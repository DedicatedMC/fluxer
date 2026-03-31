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

import {AsyncLocalStorage} from 'node:async_hooks';
import type {TenantID} from '@fluxer/api/src/BrandedTypes';

const tenantStorage = new AsyncLocalStorage<TenantID>();

export const TenantContext = {
	run<T>(tenantId: TenantID, fn: () => T): T {
		return tenantStorage.run(tenantId, fn);
	},

	get(): TenantID {
		const tenantId = tenantStorage.getStore();
		if (tenantId === undefined) {
			throw new Error('TenantContext.get() called outside of a tenant scope');
		}
		return tenantId;
	},

	getOrNull(): TenantID | null {
		return tenantStorage.getStore() ?? null;
	},
} as const;
