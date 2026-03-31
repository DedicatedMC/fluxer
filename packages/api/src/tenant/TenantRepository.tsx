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

import type {TenantID} from '@fluxer/api/src/BrandedTypes';
import {fetchOne} from '@fluxer/api/src/database/Cassandra';
import type {TenantByDomainRow, TenantRow} from '@fluxer/api/src/database/types/TenantTypes';
import {Tenants, TenantsByDomain} from '@fluxer/api/src/tenant/TenantTables';

const FETCH_TENANT_BY_ID = Tenants.select({
	where: Tenants.where.eq('tenant_id'),
	limit: 1,
});

const FETCH_TENANT_BY_DOMAIN = TenantsByDomain.select({
	where: TenantsByDomain.where.eq('domain'),
	limit: 1,
});

export class TenantRepository {
	async findById(tenantId: TenantID): Promise<TenantRow | null> {
		return fetchOne<TenantRow>(FETCH_TENANT_BY_ID.bind({tenant_id: tenantId}));
	}

	async findByDomain(domain: string): Promise<TenantID | null> {
		const row = await fetchOne<TenantByDomainRow>(FETCH_TENANT_BY_DOMAIN.bind({domain}));
		return row?.tenant_id ?? null;
	}
}
