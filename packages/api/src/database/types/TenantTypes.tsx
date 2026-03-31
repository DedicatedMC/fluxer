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

export interface TenantRow {
	tenant_id: TenantID;
	name: string;
	slug: string;
	plan: string;
	status: string;
	created_at: Date;
}

export const TENANT_COLUMNS = [
	'tenant_id',
	'name',
	'slug',
	'plan',
	'status',
	'created_at',
] as const satisfies ReadonlyArray<keyof TenantRow>;

export interface TenantByDomainRow {
	domain: string;
	tenant_id: TenantID;
}

export const TENANT_BY_DOMAIN_COLUMNS = ['domain', 'tenant_id'] as const satisfies ReadonlyArray<
	keyof TenantByDomainRow
>;
