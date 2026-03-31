/*
 * Copyright (C) 2026 Fluxer Contributors
 *
 * This file is part of Fluxer.
 *
 * Fluxer is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Fluxer is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with Fluxer. If not, see <https://www.gnu.org/licenses/>.
 */

import {type TenantID, createTenantID} from '@fluxer/api/src/BrandedTypes';
import {Config} from '@fluxer/api/src/Config';
import {fetchOne} from '@fluxer/api/src/database/Cassandra';
import type {TenantByDomainRow} from '@fluxer/api/src/database/types/TenantTypes';
import {TenantContext} from '@fluxer/api/src/tenant/TenantContext';
import {TenantNotFoundError} from '@fluxer/api/src/tenant/TenantNotFoundError';
import {TenantsByDomain} from '@fluxer/api/src/tenant/TenantTables';
import type {HonoEnv} from '@fluxer/api/src/types/HonoEnv';
import {createMiddleware} from 'hono/factory';

const FETCH_TENANT_BY_DOMAIN = TenantsByDomain.select({
	where: TenantsByDomain.where.eq('domain'),
	limit: 1,
});

async function resolveTenantFromHost(host: string): Promise<TenantID | null> {
	const {platformDomain} = Config.tenant;

	// Check if this is a subdomain of the platform domain
	if (platformDomain && host.endsWith(`.${platformDomain}`)) {
		const subdomain = host.slice(0, -(platformDomain.length + 1));
		if (subdomain && !subdomain.includes('.')) {
			// Look up by the full subdomain host
			const row = await fetchOne<TenantByDomainRow>(FETCH_TENANT_BY_DOMAIN.bind({domain: host}));
			return row?.tenant_id ?? null;
		}
	}

	// Custom domain lookup
	const row = await fetchOne<TenantByDomainRow>(FETCH_TENANT_BY_DOMAIN.bind({domain: host}));
	return row?.tenant_id ?? null;
}

export const TenantMiddleware = createMiddleware<HonoEnv>(async (ctx, next) => {
	let tenantId: TenantID;

	if (!Config.tenant.enabled) {
		tenantId = createTenantID(BigInt(Config.tenant.defaultTenantId));
	} else {
		const host = ctx.req.header('host')?.split(':')[0];
		if (!host) {
			throw new TenantNotFoundError();
		}

		const resolved = await resolveTenantFromHost(host);
		if (resolved === null) {
			throw new TenantNotFoundError();
		}
		tenantId = resolved;
	}

	ctx.set('tenantId', tenantId);
	return TenantContext.run(tenantId, () => next());
});
