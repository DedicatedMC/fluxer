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

import {defineTable} from '@fluxer/api/src/database/Cassandra';
import {
	TENANT_BY_DOMAIN_COLUMNS,
	TENANT_COLUMNS,
	type TenantByDomainRow,
	type TenantRow,
} from '@fluxer/api/src/database/types/TenantTypes';

export const Tenants = defineTable<TenantRow, 'tenant_id'>({
	name: 'tenants',
	columns: TENANT_COLUMNS,
	primaryKey: ['tenant_id'],
	tenantScoped: false,
});

export const TenantsByDomain = defineTable<TenantByDomainRow, 'domain'>({
	name: 'tenants_by_domain',
	columns: TENANT_BY_DOMAIN_COLUMNS,
	primaryKey: ['domain'],
	tenantScoped: false,
});
