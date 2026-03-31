-- Multi-tenancy migration: recreate all tables with tenant_id prepended to partition key.
-- UDTs are unchanged and left in place (not dropped/recreated).

-- =============================================================================
-- DROP all existing tables
-- =============================================================================

DROP TABLE IF EXISTS fluxer.users;
DROP TABLE IF EXISTS fluxer.users_by_email;
DROP TABLE IF EXISTS fluxer.users_by_phone;
DROP TABLE IF EXISTS fluxer.users_by_username;
DROP TABLE IF EXISTS fluxer.users_by_stripe_subscription_id;
DROP TABLE IF EXISTS fluxer.users_by_stripe_customer_id;
DROP TABLE IF EXISTS fluxer.user_activity_tracking;
DROP TABLE IF EXISTS fluxer.users_pending_deletion;
DROP TABLE IF EXISTS fluxer.user_settings;
DROP TABLE IF EXISTS fluxer.relationships;
DROP TABLE IF EXISTS fluxer.relationships_by_target;
DROP TABLE IF EXISTS fluxer.notes;
DROP TABLE IF EXISTS fluxer.user_guild_settings;
DROP TABLE IF EXISTS fluxer.private_channels;
DROP TABLE IF EXISTS fluxer.dm_states;
DROP TABLE IF EXISTS fluxer.read_states;
DROP TABLE IF EXISTS fluxer.recent_mentions;
DROP TABLE IF EXISTS fluxer.recent_mentions_by_guild;
DROP TABLE IF EXISTS fluxer.saved_messages;
DROP TABLE IF EXISTS fluxer.auth_sessions;
DROP TABLE IF EXISTS fluxer.auth_sessions_by_user_id;
DROP TABLE IF EXISTS fluxer.mfa_backup_codes;
DROP TABLE IF EXISTS fluxer.webauthn_credentials;
DROP TABLE IF EXISTS fluxer.webauthn_credential_lookup;
DROP TABLE IF EXISTS fluxer.email_verification_tokens;
DROP TABLE IF EXISTS fluxer.password_reset_tokens;
DROP TABLE IF EXISTS fluxer.ip_authorization_tokens;
DROP TABLE IF EXISTS fluxer.email_revert_tokens;
DROP TABLE IF EXISTS fluxer.mfa_tickets;
DROP TABLE IF EXISTS fluxer.phone_tokens;
DROP TABLE IF EXISTS fluxer.authorized_ips;
DROP TABLE IF EXISTS fluxer.authorized_ips_v2;
DROP TABLE IF EXISTS fluxer.banned_emails;
DROP TABLE IF EXISTS fluxer.banned_phones;
DROP TABLE IF EXISTS fluxer.banned_ips;
DROP TABLE IF EXISTS fluxer.beta_codes;
DROP TABLE IF EXISTS fluxer.beta_codes_by_code;
DROP TABLE IF EXISTS fluxer.gift_codes;
DROP TABLE IF EXISTS fluxer.gift_codes_by_creator;
DROP TABLE IF EXISTS fluxer.gift_codes_by_redeemer;
DROP TABLE IF EXISTS fluxer.gift_codes_by_payment_intent;
DROP TABLE IF EXISTS fluxer.guilds;
DROP TABLE IF EXISTS fluxer.guilds_by_owner_id;
DROP TABLE IF EXISTS fluxer.guild_members;
DROP TABLE IF EXISTS fluxer.guild_members_by_user_id;
DROP TABLE IF EXISTS fluxer.guild_roles;
DROP TABLE IF EXISTS fluxer.guild_bans;
DROP TABLE IF EXISTS fluxer.guild_bans_by_ip;
DROP TABLE IF EXISTS fluxer.guild_emojis;
DROP TABLE IF EXISTS fluxer.guild_emojis_by_emoji_id;
DROP TABLE IF EXISTS fluxer.guild_stickers;
DROP TABLE IF EXISTS fluxer.guild_stickers_by_sticker_id;
DROP TABLE IF EXISTS fluxer.guild_audit_logs;
DROP TABLE IF EXISTS fluxer.guild_audit_logs_v2;
DROP TABLE IF EXISTS fluxer.guild_audit_logs_v2_by_user;
DROP TABLE IF EXISTS fluxer.guild_audit_logs_v2_by_action;
DROP TABLE IF EXISTS fluxer.guild_audit_logs_v2_by_user_action;
DROP TABLE IF EXISTS fluxer.guild_discovery;
DROP TABLE IF EXISTS fluxer.guild_discovery_by_status;
DROP TABLE IF EXISTS fluxer.channels;
DROP TABLE IF EXISTS fluxer.channels_by_guild_id;
DROP TABLE IF EXISTS fluxer.channel_state;
DROP TABLE IF EXISTS fluxer.channel_message_buckets;
DROP TABLE IF EXISTS fluxer.channel_empty_buckets;
DROP TABLE IF EXISTS fluxer.invites;
DROP TABLE IF EXISTS fluxer.invites_by_guild_id;
DROP TABLE IF EXISTS fluxer.invites_by_channel_id;
DROP TABLE IF EXISTS fluxer.webhooks;
DROP TABLE IF EXISTS fluxer.webhooks_by_guild_id;
DROP TABLE IF EXISTS fluxer.webhooks_by_channel_id;
DROP TABLE IF EXISTS fluxer.messages;
DROP TABLE IF EXISTS fluxer.channel_pins;
DROP TABLE IF EXISTS fluxer.messages_by_author_id;
DROP TABLE IF EXISTS fluxer.messages_by_author_id_v2;
DROP TABLE IF EXISTS fluxer.message_reactions;
DROP TABLE IF EXISTS fluxer.attachment_lookup;
DROP TABLE IF EXISTS fluxer.favorite_memes;
DROP TABLE IF EXISTS fluxer.favorite_memes_by_meme_id;
DROP TABLE IF EXISTS fluxer.push_subscriptions;
DROP TABLE IF EXISTS fluxer.push_devices;
DROP TABLE IF EXISTS fluxer.push_devices_by_fcm_token;
DROP TABLE IF EXISTS fluxer.processed_payments;
DROP TABLE IF EXISTS fluxer.processed_payments_by_user;
DROP TABLE IF EXISTS fluxer.visionary_purchases;
DROP TABLE IF EXISTS fluxer.visionary_purchases_by_user;
DROP TABLE IF EXISTS fluxer.user_harvests;
DROP TABLE IF EXISTS fluxer.admin_audit_logs;
DROP TABLE IF EXISTS fluxer.iar_submissions;
DROP TABLE IF EXISTS fluxer.pending_verifications;
DROP TABLE IF EXISTS fluxer.pending_verifications_by_time;
DROP TABLE IF EXISTS fluxer.payments;
DROP TABLE IF EXISTS fluxer.payments_by_payment_intent;
DROP TABLE IF EXISTS fluxer.payments_by_subscription;
DROP TABLE IF EXISTS fluxer.payments_by_user;
DROP TABLE IF EXISTS fluxer.visionary_users;
DROP TABLE IF EXISTS fluxer.visionary_users_by_user;
DROP TABLE IF EXISTS fluxer.visionary_counter;
DROP TABLE IF EXISTS fluxer.visionary_slots;
DROP TABLE IF EXISTS fluxer.pinned_dms;
DROP TABLE IF EXISTS fluxer.voice_regions;
DROP TABLE IF EXISTS fluxer.voice_servers;
DROP TABLE IF EXISTS fluxer.oauth_clients;
DROP TABLE IF EXISTS fluxer.oauth_clients_by_owner;
DROP TABLE IF EXISTS fluxer.oauth_authorization_requests;
DROP TABLE IF EXISTS fluxer.oauth_authorization_codes;
DROP TABLE IF EXISTS fluxer.oauth_access_tokens;
DROP TABLE IF EXISTS fluxer.oauth_access_tokens_by_client;
DROP TABLE IF EXISTS fluxer.oauth_access_tokens_by_user;
DROP TABLE IF EXISTS fluxer.oauth_refresh_tokens;
DROP TABLE IF EXISTS fluxer.oauth_refresh_tokens_by_client;
DROP TABLE IF EXISTS fluxer.oauth_refresh_tokens_by_user;
DROP TABLE IF EXISTS fluxer.oauth_teams;
DROP TABLE IF EXISTS fluxer.oauth_teams_by_owner;
DROP TABLE IF EXISTS fluxer.oauth_team_members;
DROP TABLE IF EXISTS fluxer.oauth_team_members_by_user;
DROP TABLE IF EXISTS fluxer.oauth_bot_tokens;
DROP TABLE IF EXISTS fluxer.oauth_bot_tokens_by_client;
DROP TABLE IF EXISTS fluxer.oidc_keys;
DROP TABLE IF EXISTS fluxer.oidc_keys_by_kid;
DROP TABLE IF EXISTS fluxer.oidc_key_status;
DROP TABLE IF EXISTS fluxer.applications;
DROP TABLE IF EXISTS fluxer.applications_by_owner;
DROP TABLE IF EXISTS fluxer.oauth2_authorization_codes;
DROP TABLE IF EXISTS fluxer.oauth2_access_tokens;
DROP TABLE IF EXISTS fluxer.oauth2_access_tokens_by_user;
DROP TABLE IF EXISTS fluxer.oauth2_refresh_tokens;
DROP TABLE IF EXISTS fluxer.oauth2_refresh_tokens_by_user;
DROP TABLE IF EXISTS fluxer.admin_archives_by_subject;
DROP TABLE IF EXISTS fluxer.admin_archives_by_requester;
DROP TABLE IF EXISTS fluxer.admin_archives_by_type;
DROP TABLE IF EXISTS fluxer.attachment_decay_by_id;
DROP TABLE IF EXISTS fluxer.attachment_decay_by_expiry;
DROP TABLE IF EXISTS fluxer.email_change_tickets;
DROP TABLE IF EXISTS fluxer.email_change_tokens;
DROP TABLE IF EXISTS fluxer.user_contact_change_logs;
DROP TABLE IF EXISTS fluxer.expression_packs;
DROP TABLE IF EXISTS fluxer.expression_packs_by_creator;
DROP TABLE IF EXISTS fluxer.pack_installations;
DROP TABLE IF EXISTS fluxer.scheduled_messages;
DROP TABLE IF EXISTS fluxer.dsa_report_email_verifications;
DROP TABLE IF EXISTS fluxer.dsa_report_tickets;
DROP TABLE IF EXISTS fluxer.swish_payments;
DROP TABLE IF EXISTS fluxer.swish_payments_by_user;
DROP TABLE IF EXISTS fluxer.user_dm_history;
DROP TABLE IF EXISTS fluxer.system_dm_jobs;
DROP TABLE IF EXISTS fluxer.admin_api_keys;
DROP TABLE IF EXISTS fluxer.admin_api_keys_by_creator;
DROP TABLE IF EXISTS fluxer.csam_evidence_packages;
DROP TABLE IF EXISTS fluxer.csam_evidence_legal_holds;
DROP TABLE IF EXISTS fluxer.csam_scan_jobs;
DROP TABLE IF EXISTS fluxer.csam_evidence_expirations;
DROP TABLE IF EXISTS fluxer.ncmec_submissions;
DROP TABLE IF EXISTS fluxer.instance_configuration;
DROP TABLE IF EXISTS fluxer.user_connections;
DROP TABLE IF EXISTS fluxer.donors;
DROP TABLE IF EXISTS fluxer.donors_by_stripe_customer_id;
DROP TABLE IF EXISTS fluxer.donors_by_stripe_subscription_id;
DROP TABLE IF EXISTS fluxer.donor_magic_link_tokens;
DROP TABLE IF EXISTS fluxer.donor_magic_link_tokens_by_email;
DROP TABLE IF EXISTS fluxer.password_change_tickets;

-- =============================================================================
-- Recreate all tables with tenant_id in partition key
-- =============================================================================

-- ---------------------
-- User tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.users (
    tenant_id bigint,
    user_id bigint,
    username text,
    discriminator int,
    bot boolean,
    system boolean,
    email text,
    email_verified boolean,
    email_bounced boolean,
    phone text,
    password_hash text,
    totp_secret text,
    authenticator_types set<int>,
    avatar_hash text,
    banner_hash text,
    bio text,
    accent_color int,
    date_of_birth date,
    locale text,
    flags bigint,
    premium_type int,
    premium_since timestamp,
    premium_until timestamp,
    premium_lifetime_sequence int,
    stripe_subscription_id text,
    stripe_customer_id text,
    suspicious_activity_flags int,
    terms_agreed_at timestamp,
    privacy_agreed_at timestamp,
    last_active_at timestamp,
    last_active_ip text,
    temp_banned_until timestamp,
    pending_deletion_at timestamp,
    password_last_changed_at timestamp,
    pronouns text,
    acls set<text>,
    deletion_reason_code int,
    deletion_public_reason text,
    deletion_audit_log_reason text,
    first_refund_at timestamp,
    beta_code_allowance int,
    beta_code_last_reset_at timestamp,
    premium_will_cancel boolean,
    has_ever_purchased boolean,
    premium_billing_cycle text,
    gift_inventory_server_seq int,
    gift_inventory_client_seq int,
    global_name text,
    premium_onboarding_dismissed_at timestamp,
    avatar_color int,
    banner_color int,
    pending_bulk_message_deletion_at timestamp,
    pending_bulk_message_deletion_channel_count int,
    pending_bulk_message_deletion_message_count int,
    version int,
    traits set<text>,
    PRIMARY KEY ((tenant_id, user_id))
);

CREATE TABLE IF NOT EXISTS fluxer.users_by_email (
    tenant_id bigint,
    email_lower text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, email_lower), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.users_by_phone (
    tenant_id bigint,
    phone text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, phone), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.users_by_username (
    tenant_id bigint,
    username text,
    discriminator int,
    user_id bigint,
    PRIMARY KEY ((tenant_id, username), discriminator, user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.users_by_stripe_subscription_id (
    tenant_id bigint,
    stripe_subscription_id text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, stripe_subscription_id), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.users_by_stripe_customer_id (
    tenant_id bigint,
    stripe_customer_id text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, stripe_customer_id), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.user_activity_tracking (
    tenant_id bigint,
    activity_month text,
    last_active_at timestamp,
    user_id bigint,
    PRIMARY KEY ((tenant_id, activity_month), last_active_at, user_id)
) WITH CLUSTERING ORDER BY (last_active_at ASC, user_id ASC);

CREATE TABLE IF NOT EXISTS fluxer.users_pending_deletion (
    tenant_id bigint,
    deletion_date date,
    pending_deletion_at timestamp,
    user_id bigint,
    deletion_reason_code int,
    PRIMARY KEY ((tenant_id, deletion_date), pending_deletion_at, user_id)
) WITH CLUSTERING ORDER BY (pending_deletion_at ASC, user_id ASC);

CREATE TABLE IF NOT EXISTS fluxer.user_settings (
    tenant_id bigint,
    user_id bigint,
    locale text,
    theme text,
    status text,
    custom_status frozen<custom_status>,
    developer_mode boolean,
    message_display_compact boolean,
    animate_emoji boolean,
    animate_stickers int,
    gif_auto_play boolean,
    render_embeds boolean,
    render_reactions boolean,
    render_spoilers int,
    inline_attachment_media boolean,
    inline_embed_media boolean,
    explicit_content_filter int,
    friend_source_flags int,
    default_guilds_restricted boolean,
    restricted_guilds set<bigint>,
    guild_positions list<bigint>,
    guild_folders frozen<list<guild_folder>>,
    afk_timeout int,
    time_format int,
    incoming_call_flags int,
    group_dm_add_permission_flags int,
    version int,
    status_resets_at timestamp,
    status_resets_to text,
    bot_default_guilds_restricted boolean,
    bot_restricted_guilds set<bigint>,
    trusted_domains set<text>,
    default_hide_muted_channels boolean,
    PRIMARY KEY ((tenant_id, user_id))
);

CREATE TABLE IF NOT EXISTS fluxer.relationships (
    tenant_id bigint,
    source_user_id bigint,
    target_user_id bigint,
    type int,
    nickname text,
    since timestamp,
    version int,
    PRIMARY KEY ((tenant_id, source_user_id), target_user_id, type)
);

CREATE TABLE IF NOT EXISTS fluxer.relationships_by_target (
    tenant_id bigint,
    target_user_id bigint,
    source_user_id bigint,
    type int,
    nickname text,
    since timestamp,
    version int,
    PRIMARY KEY ((tenant_id, target_user_id), source_user_id, type)
) WITH CLUSTERING ORDER BY (source_user_id ASC, type ASC);

CREATE TABLE IF NOT EXISTS fluxer.notes (
    tenant_id bigint,
    source_user_id bigint,
    target_user_id bigint,
    note text,
    version int,
    PRIMARY KEY ((tenant_id, source_user_id), target_user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.user_guild_settings (
    tenant_id bigint,
    user_id bigint,
    guild_id bigint,
    message_notifications int,
    muted boolean,
    mute_config frozen<mute_config>,
    mobile_push boolean,
    suppress_everyone boolean,
    suppress_roles boolean,
    hide_muted_channels boolean,
    channel_overrides frozen<map<bigint, channel_override>>,
    version int,
    PRIMARY KEY ((tenant_id, user_id), guild_id)
);

CREATE TABLE IF NOT EXISTS fluxer.private_channels (
    tenant_id bigint,
    user_id bigint,
    channel_id bigint,
    is_gdm boolean,
    PRIMARY KEY ((tenant_id, user_id), channel_id)
);

CREATE TABLE IF NOT EXISTS fluxer.dm_states (
    tenant_id bigint,
    hi_user_id bigint,
    lo_user_id bigint,
    channel_id bigint,
    PRIMARY KEY ((tenant_id, hi_user_id, lo_user_id), channel_id)
);

CREATE TABLE IF NOT EXISTS fluxer.read_states (
    tenant_id bigint,
    user_id bigint,
    channel_id bigint,
    message_id bigint,
    mention_count int,
    last_pin_timestamp timestamp,
    PRIMARY KEY ((tenant_id, user_id), channel_id)
);

CREATE TABLE IF NOT EXISTS fluxer.recent_mentions (
    tenant_id bigint,
    user_id bigint,
    message_id bigint,
    channel_id bigint,
    guild_id bigint,
    is_everyone boolean,
    is_role boolean,
    PRIMARY KEY ((tenant_id, user_id), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC)
AND default_time_to_live = 604800;

CREATE TABLE IF NOT EXISTS fluxer.recent_mentions_by_guild (
    tenant_id bigint,
    user_id bigint,
    guild_id bigint,
    message_id bigint,
    channel_id bigint,
    is_everyone boolean,
    is_role boolean,
    PRIMARY KEY ((tenant_id, user_id, guild_id), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC)
AND default_time_to_live = 604800;

CREATE TABLE IF NOT EXISTS fluxer.saved_messages (
    tenant_id bigint,
    user_id bigint,
    channel_id bigint,
    message_id bigint,
    saved_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.user_contact_change_logs (
    tenant_id bigint,
    user_id bigint,
    event_id timeuuid,
    field text,
    old_value text,
    new_value text,
    reason text,
    actor_user_id bigint,
    event_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), event_id)
) WITH CLUSTERING ORDER BY (event_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.user_connections (
    tenant_id bigint,
    user_id bigint,
    connection_type text,
    connection_id text,
    identifier text,
    name text,
    verified boolean,
    visibility_flags int,
    sort_order int,
    verification_token text,
    verified_at timestamp,
    last_verified_at timestamp,
    created_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, user_id), connection_type, connection_id)
) WITH CLUSTERING ORDER BY (connection_type ASC, connection_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.user_dm_history (
    tenant_id bigint,
    user_id bigint,
    channel_id bigint,
    PRIMARY KEY ((tenant_id, user_id), channel_id)
);

-- ---------------------
-- Auth tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.auth_sessions (
    tenant_id bigint,
    session_id_hash blob,
    user_id bigint,
    created_at timestamp,
    approx_last_used_at timestamp,
    client_ip text,
    client_os text,
    client_platform text,
    client_country text,
    client_location text,
    client_user_agent text,
    client_is_desktop boolean,
    version int,
    PRIMARY KEY ((tenant_id, session_id_hash))
);

CREATE TABLE IF NOT EXISTS fluxer.auth_sessions_by_user_id (
    tenant_id bigint,
    user_id bigint,
    session_id_hash blob,
    PRIMARY KEY ((tenant_id, user_id), session_id_hash)
);

CREATE TABLE IF NOT EXISTS fluxer.mfa_backup_codes (
    tenant_id bigint,
    user_id bigint,
    code text,
    consumed boolean,
    PRIMARY KEY ((tenant_id, user_id), code)
);

CREATE TABLE IF NOT EXISTS fluxer.webauthn_credentials (
    tenant_id bigint,
    user_id bigint,
    credential_id text,
    public_key blob,
    counter bigint,
    transports set<text>,
    name text,
    created_at timestamp,
    last_used_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, user_id), credential_id)
);

CREATE TABLE IF NOT EXISTS fluxer.webauthn_credential_lookup (
    tenant_id bigint,
    credential_id text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, credential_id))
);

CREATE TABLE IF NOT EXISTS fluxer.email_verification_tokens (
    tenant_id bigint,
    token_ text,
    user_id bigint,
    email text,
    PRIMARY KEY ((tenant_id, token_), user_id)
) WITH default_time_to_live = 86400;

CREATE TABLE IF NOT EXISTS fluxer.password_reset_tokens (
    tenant_id bigint,
    token_ text,
    user_id bigint,
    email text,
    PRIMARY KEY ((tenant_id, token_), user_id)
) WITH default_time_to_live = 3600;

CREATE TABLE IF NOT EXISTS fluxer.ip_authorization_tokens (
    tenant_id bigint,
    token_ text,
    user_id bigint,
    email text,
    PRIMARY KEY ((tenant_id, token_), user_id)
) WITH default_time_to_live = 1800;

CREATE TABLE IF NOT EXISTS fluxer.email_revert_tokens (
    tenant_id bigint,
    token_ text,
    user_id bigint,
    email text,
    PRIMARY KEY ((tenant_id, token_), user_id)
) WITH default_time_to_live = 172800;

CREATE TABLE IF NOT EXISTS fluxer.mfa_tickets (
    tenant_id bigint,
    ticket text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, ticket), user_id)
) WITH default_time_to_live = 300;

CREATE TABLE IF NOT EXISTS fluxer.phone_tokens (
    tenant_id bigint,
    token_ text,
    phone text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 2592000;

CREATE TABLE IF NOT EXISTS fluxer.authorized_ips (
    tenant_id bigint,
    user_id bigint,
    ip text,
    PRIMARY KEY ((tenant_id, user_id, ip))
);

CREATE TABLE IF NOT EXISTS fluxer.authorized_ips_v2 (
    tenant_id bigint,
    user_id bigint,
    ip text,
    PRIMARY KEY ((tenant_id, user_id), ip)
);

CREATE TABLE IF NOT EXISTS fluxer.password_change_tickets (
    tenant_id bigint,
    ticket text,
    user_id bigint,
    code text,
    code_sent_at timestamp,
    code_expires_at timestamp,
    verified boolean,
    verification_proof text,
    status text,
    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, ticket))
);

CREATE TABLE IF NOT EXISTS fluxer.email_change_tickets (
    tenant_id bigint,
    ticket text,
    user_id bigint,
    require_original boolean,
    original_email text,
    original_verified boolean,
    original_code text,
    original_code_sent_at timestamp,
    original_code_expires_at timestamp,
    new_email text,
    new_code text,
    new_code_sent_at timestamp,
    new_code_expires_at timestamp,
    status text,
    created_at timestamp,
    updated_at timestamp,
    original_proof text,
    PRIMARY KEY ((tenant_id, ticket))
);

CREATE TABLE IF NOT EXISTS fluxer.email_change_tokens (
    tenant_id bigint,
    token_ text,
    user_id bigint,
    new_email text,
    expires_at timestamp,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
);

-- ---------------------
-- Ban tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.banned_emails (
    tenant_id bigint,
    email_lower text,
    PRIMARY KEY ((tenant_id, email_lower))
);

CREATE TABLE IF NOT EXISTS fluxer.banned_phones (
    tenant_id bigint,
    phone text,
    PRIMARY KEY ((tenant_id, phone))
);

CREATE TABLE IF NOT EXISTS fluxer.banned_ips (
    tenant_id bigint,
    ip text,
    PRIMARY KEY ((tenant_id, ip))
);

-- ---------------------
-- Beta code tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.beta_codes (
    tenant_id bigint,
    creator_id bigint,
    code text,
    created_at timestamp,
    redeemer_id bigint,
    redeemed_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, creator_id), code)
);

CREATE TABLE IF NOT EXISTS fluxer.beta_codes_by_code (
    tenant_id bigint,
    code text,
    creator_id bigint,
    PRIMARY KEY ((tenant_id, code), creator_id)
);

-- ---------------------
-- Gift code tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.gift_codes (
    tenant_id bigint,
    code text,
    amount_cents int,
    duration_months int,
    created_at timestamp,
    created_by_user_id bigint,
    redeemed_at timestamp,
    redeemed_by_user_id bigint,
    stripe_payment_intent_id text,
    visionary_sequence_number int,
    checkout_session_id text,
    version int,
    PRIMARY KEY ((tenant_id, code))
);

CREATE TABLE IF NOT EXISTS fluxer.gift_codes_by_creator (
    tenant_id bigint,
    created_by_user_id bigint,
    code text,
    PRIMARY KEY ((tenant_id, created_by_user_id), code)
);

CREATE TABLE IF NOT EXISTS fluxer.gift_codes_by_redeemer (
    tenant_id bigint,
    redeemed_by_user_id bigint,
    code text,
    PRIMARY KEY ((tenant_id, redeemed_by_user_id), code)
);

CREATE TABLE IF NOT EXISTS fluxer.gift_codes_by_payment_intent (
    tenant_id bigint,
    stripe_payment_intent_id text,
    code text,
    PRIMARY KEY ((tenant_id, stripe_payment_intent_id), code)
);

-- ---------------------
-- Guild tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.guilds (
    tenant_id bigint,
    guild_id bigint,
    owner_id bigint,
    name text,
    vanity_url_code text,
    icon_hash text,
    banner_hash text,
    splash_hash text,
    features set<text>,
    verification_level int,
    mfa_level int,
    nsfw_level int,
    explicit_content_filter int,
    default_message_notifications int,
    system_channel_id bigint,
    system_channel_flags int,
    rules_channel_id bigint,
    afk_channel_id bigint,
    afk_timeout int,
    disabled_operations int,
    max_presences int,
    member_count int,
    audit_logs_indexed_at timestamp,
    banner_height int,
    banner_width int,
    splash_width int,
    splash_height int,
    embed_splash_hash text,
    embed_splash_width int,
    embed_splash_height int,
    splash_card_alignment int,
    version int,
    message_history_cutoff timestamp,
    members_indexed_at timestamp,
    PRIMARY KEY ((tenant_id, guild_id))
);

CREATE TABLE IF NOT EXISTS fluxer.guilds_by_owner_id (
    tenant_id bigint,
    guild_id bigint,
    owner_id bigint,
    PRIMARY KEY ((tenant_id, guild_id), owner_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_members (
    tenant_id bigint,
    guild_id bigint,
    user_id bigint,
    joined_at timestamp,
    nick text,
    avatar_hash text,
    banner_hash text,
    join_source_type int,
    source_invite_code text,
    inviter_id bigint,
    deaf boolean,
    mute boolean,
    communication_disabled_until timestamp,
    role_ids set<bigint>,
    is_premium_sanitized boolean,
    bio text,
    accent_color int,
    pronouns text,
    temporary boolean,
    profile_flags int,
    version int,
    PRIMARY KEY ((tenant_id, guild_id), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_members_by_user_id (
    tenant_id bigint,
    user_id bigint,
    guild_id bigint,
    PRIMARY KEY ((tenant_id, user_id), guild_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_roles (
    tenant_id bigint,
    guild_id bigint,
    role_id bigint,
    name text,
    permissions bigint,
    position int,
    color int,
    icon_hash text,
    unicode_emoji text,
    hoist boolean,
    mentionable boolean,
    hoist_position int,
    version int,
    PRIMARY KEY ((tenant_id, guild_id), role_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_bans (
    tenant_id bigint,
    guild_id bigint,
    user_id bigint,
    moderator_id bigint,
    banned_at timestamp,
    expires_at timestamp,
    reason text,
    ip text,
    PRIMARY KEY ((tenant_id, guild_id), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_bans_by_ip (
    tenant_id bigint,
    guild_id bigint,
    ip text,
    user_id bigint,
    PRIMARY KEY ((tenant_id, guild_id, ip), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_emojis (
    tenant_id bigint,
    guild_id bigint,
    emoji_id bigint,
    name text,
    creator_id bigint,
    animated boolean,
    version int,
    PRIMARY KEY ((tenant_id, guild_id), emoji_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_emojis_by_emoji_id (
    tenant_id bigint,
    emoji_id bigint,
    guild_id bigint,
    name text,
    creator_id bigint,
    animated boolean,
    PRIMARY KEY ((tenant_id, emoji_id))
);

CREATE TABLE IF NOT EXISTS fluxer.guild_stickers (
    tenant_id bigint,
    guild_id bigint,
    sticker_id bigint,
    name text,
    description text,
    format_type int,
    tags list<text>,
    creator_id bigint,
    animated boolean,
    version int,
    PRIMARY KEY ((tenant_id, guild_id), sticker_id)
);

CREATE TABLE IF NOT EXISTS fluxer.guild_stickers_by_sticker_id (
    tenant_id bigint,
    sticker_id bigint,
    guild_id bigint,
    name text,
    description text,
    format_type int,
    tags list<text>,
    creator_id bigint,
    animated boolean,
    PRIMARY KEY ((tenant_id, sticker_id))
);

CREATE TABLE IF NOT EXISTS fluxer.guild_audit_logs (
    tenant_id bigint,
    guild_id bigint,
    log_id bigint,
    user_id bigint,
    target_type text,
    target_id text,
    action text,
    audit_log_reason text,
    metadata map<text, text>,
    changes text,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, guild_id), log_id)
) WITH CLUSTERING ORDER BY (log_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.guild_audit_logs_v2 (
    tenant_id bigint,
    guild_id bigint,
    log_id bigint,
    user_id bigint,
    target_id text,
    action_type int,
    reason text,
    options map<text, text>,
    changes text,
    PRIMARY KEY ((tenant_id, guild_id), log_id)
) WITH CLUSTERING ORDER BY (log_id DESC)
AND default_time_to_live = 3888000;

CREATE TABLE IF NOT EXISTS fluxer.guild_audit_logs_v2_by_user (
    tenant_id bigint,
    guild_id bigint,
    user_id bigint,
    log_id bigint,
    target_id text,
    action_type int,
    reason text,
    options map<text, text>,
    changes text,
    PRIMARY KEY ((tenant_id, guild_id, user_id), log_id)
) WITH CLUSTERING ORDER BY (log_id DESC)
AND default_time_to_live = 3888000;

CREATE TABLE IF NOT EXISTS fluxer.guild_audit_logs_v2_by_action (
    tenant_id bigint,
    guild_id bigint,
    action_type int,
    log_id bigint,
    user_id bigint,
    target_id text,
    reason text,
    options map<text, text>,
    changes text,
    PRIMARY KEY ((tenant_id, guild_id, action_type), log_id)
) WITH CLUSTERING ORDER BY (log_id DESC)
AND default_time_to_live = 3888000;

CREATE TABLE IF NOT EXISTS fluxer.guild_audit_logs_v2_by_user_action (
    tenant_id bigint,
    guild_id bigint,
    user_id bigint,
    action_type int,
    log_id bigint,
    target_id text,
    reason text,
    options map<text, text>,
    changes text,
    PRIMARY KEY ((tenant_id, guild_id, user_id, action_type), log_id)
) WITH CLUSTERING ORDER BY (log_id DESC)
AND default_time_to_live = 3888000;

CREATE TABLE IF NOT EXISTS fluxer.guild_discovery (
    tenant_id bigint,
    guild_id bigint,
    status text,
    category_type int,
    description text,
    applied_at timestamp,
    reviewed_at timestamp,
    reviewed_by bigint,
    review_reason text,
    removed_at timestamp,
    removed_by bigint,
    removal_reason text,
    PRIMARY KEY ((tenant_id, guild_id))
);

CREATE TABLE IF NOT EXISTS fluxer.guild_discovery_by_status (
    tenant_id bigint,
    status text,
    applied_at timestamp,
    guild_id bigint,
    PRIMARY KEY ((tenant_id, status), applied_at, guild_id)
) WITH CLUSTERING ORDER BY (applied_at DESC, guild_id DESC);

-- ---------------------
-- Channel tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.channels (
    tenant_id bigint,
    channel_id bigint,
    guild_id bigint,
    type int,
    name text,
    topic text,
    icon_hash text,
    url text,
    parent_id bigint,
    position int,
    owner_id bigint,
    recipient_ids set<bigint>,
    nsfw boolean,
    rate_limit_per_user int,
    bitrate int,
    user_limit int,
    rtc_region text,
    last_message_id bigint,
    last_pin_timestamp timestamp,
    permission_overwrites frozen<map<bigint, permission_overwrite>>,
    nicks map<text, text>,
    soft_deleted boolean,
    indexed_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, channel_id, soft_deleted))
);

CREATE TABLE IF NOT EXISTS fluxer.channels_by_guild_id (
    tenant_id bigint,
    guild_id bigint,
    channel_id bigint,
    PRIMARY KEY ((tenant_id, guild_id), channel_id)
);

CREATE TABLE IF NOT EXISTS fluxer.channel_state (
    tenant_id bigint,
    channel_id bigint,
    created_bucket int,
    has_messages boolean,
    last_message_id bigint,
    last_message_bucket int,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, channel_id))
);

CREATE TABLE IF NOT EXISTS fluxer.channel_message_buckets (
    tenant_id bigint,
    channel_id bigint,
    bucket int,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, channel_id), bucket)
) WITH CLUSTERING ORDER BY (bucket DESC);

CREATE TABLE IF NOT EXISTS fluxer.channel_empty_buckets (
    tenant_id bigint,
    channel_id bigint,
    bucket int,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, channel_id), bucket)
) WITH CLUSTERING ORDER BY (bucket DESC);

-- ---------------------
-- Invite tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.invites (
    tenant_id bigint,
    code text,
    type int,
    guild_id bigint,
    channel_id bigint,
    inviter_id bigint,
    created_at timestamp,
    uses int,
    max_uses int,
    max_age int,
    temporary boolean,
    version int,
    PRIMARY KEY ((tenant_id, code))
);

CREATE TABLE IF NOT EXISTS fluxer.invites_by_guild_id (
    tenant_id bigint,
    guild_id bigint,
    code text,
    PRIMARY KEY ((tenant_id, guild_id), code)
);

CREATE TABLE IF NOT EXISTS fluxer.invites_by_channel_id (
    tenant_id bigint,
    channel_id bigint,
    code text,
    PRIMARY KEY ((tenant_id, channel_id), code)
);

-- ---------------------
-- Webhook tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.webhooks (
    tenant_id bigint,
    webhook_id bigint,
    webhook_token text,
    type int,
    guild_id bigint,
    channel_id bigint,
    creator_id bigint,
    name text,
    avatar_hash text,
    version int,
    PRIMARY KEY ((tenant_id, webhook_id), webhook_token)
);

CREATE TABLE IF NOT EXISTS fluxer.webhooks_by_guild_id (
    tenant_id bigint,
    guild_id bigint,
    webhook_id bigint,
    PRIMARY KEY ((tenant_id, guild_id), webhook_id)
);

CREATE TABLE IF NOT EXISTS fluxer.webhooks_by_channel_id (
    tenant_id bigint,
    channel_id bigint,
    webhook_id bigint,
    PRIMARY KEY ((tenant_id, channel_id), webhook_id)
);

-- ---------------------
-- Message tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.messages (
    tenant_id bigint,
    channel_id bigint,
    bucket int,
    message_id bigint,
    author_id bigint,
    type int,
    webhook_id bigint,
    webhook_name text,
    webhook_avatar_hash text,
    content text,
    edited_timestamp timestamp,
    pinned_timestamp timestamp,
    flags int,
    mention_everyone boolean,
    mention_users set<bigint>,
    mention_roles set<bigint>,
    mention_channels set<bigint>,
    attachments frozen<list<message_attachment>>,
    embeds frozen<list<message_embed>>,
    sticker_items frozen<list<message_sticker_item>>,
    message_reference frozen<message_reference>,
    call frozen<message_call>,
    message_snapshots frozen<list<message_snapshot>>,
    has_reaction boolean,
    version int,
    PRIMARY KEY ((tenant_id, channel_id, bucket), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.channel_pins (
    tenant_id bigint,
    channel_id bigint,
    message_id bigint,
    pinned_timestamp timestamp,
    PRIMARY KEY ((tenant_id, channel_id), pinned_timestamp, message_id)
) WITH CLUSTERING ORDER BY (pinned_timestamp DESC, message_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.messages_by_author_id (
    tenant_id bigint,
    author_id bigint,
    channel_id bigint,
    message_id bigint,
    PRIMARY KEY ((tenant_id, author_id), channel_id, message_id)
);

CREATE TABLE IF NOT EXISTS fluxer.messages_by_author_id_v2 (
    tenant_id bigint,
    author_id bigint,
    message_id bigint,
    channel_id bigint,
    PRIMARY KEY ((tenant_id, author_id), message_id)
) WITH CLUSTERING ORDER BY (message_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.message_reactions (
    tenant_id bigint,
    channel_id bigint,
    bucket int,
    message_id bigint,
    emoji_id bigint,
    emoji_name text,
    user_id bigint,
    emoji_animated boolean,
    PRIMARY KEY ((tenant_id, channel_id, bucket), message_id, emoji_id, emoji_name, user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.attachment_lookup (
    tenant_id bigint,
    channel_id bigint,
    attachment_id bigint,
    filename text,
    message_id bigint,
    PRIMARY KEY ((tenant_id, channel_id), attachment_id, filename)
);

-- ---------------------
-- Favorite meme tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.favorite_memes (
    tenant_id bigint,
    user_id bigint,
    meme_id bigint,
    name text,
    alt_text text,
    tags list<text>,
    attachment_id bigint,
    filename text,
    content_type text,
    content_hash text,
    size bigint,
    width int,
    height int,
    duration int,
    storage_key text,
    created_at timestamp,
    is_gifv boolean,
    tenor_id bigint,
    tenor_id_str text,
    version int,
    klipy_slug text,
    PRIMARY KEY ((tenant_id, user_id), meme_id)
) WITH CLUSTERING ORDER BY (meme_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.favorite_memes_by_meme_id (
    tenant_id bigint,
    meme_id bigint,
    user_id bigint,
    PRIMARY KEY ((tenant_id, meme_id), user_id)
);

-- ---------------------
-- Push notification tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.push_subscriptions (
    tenant_id bigint,
    user_id bigint,
    subscription_id text,
    endpoint text,
    p256dh_key text,
    auth_key text,
    user_agent text,
    PRIMARY KEY ((tenant_id, user_id), subscription_id)
) WITH default_time_to_live = 7776000;

CREATE TABLE IF NOT EXISTS fluxer.push_devices (
    tenant_id bigint,
    user_id bigint,
    device_id text,
    fcm_token text,
    platform text,
    device_name text,
    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), device_id)
) WITH default_time_to_live = 7776000;

CREATE TABLE IF NOT EXISTS fluxer.push_devices_by_fcm_token (
    tenant_id bigint,
    fcm_token text,
    user_id bigint,
    device_id text,
    PRIMARY KEY ((tenant_id, fcm_token), user_id, device_id)
) WITH default_time_to_live = 7776000;

-- ---------------------
-- Payment tables (legacy)
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.processed_payments (
    tenant_id bigint,
    payment_intent_id text,
    user_id bigint,
    checkout_session_id text,
    price_id text,
    product_type text,
    amount_cents int,
    currency text,
    is_gift boolean,
    processed_at timestamp,
    PRIMARY KEY ((tenant_id, payment_intent_id))
);

CREATE TABLE IF NOT EXISTS fluxer.processed_payments_by_user (
    tenant_id bigint,
    user_id bigint,
    payment_intent_id text,
    processed_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), processed_at, payment_intent_id)
) WITH CLUSTERING ORDER BY (processed_at DESC, payment_intent_id ASC);

-- ---------------------
-- Payment tables (v2)
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.payments (
    tenant_id bigint,
    checkout_session_id text,
    user_id bigint,
    stripe_customer_id text,
    payment_intent_id text,
    subscription_id text,
    invoice_id text,
    price_id text,
    product_type text,
    amount_cents int,
    currency text,
    status text,
    is_gift boolean,
    gift_code text,
    created_at timestamp,
    completed_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, checkout_session_id))
);

CREATE TABLE IF NOT EXISTS fluxer.payments_by_payment_intent (
    tenant_id bigint,
    payment_intent_id text,
    checkout_session_id text,
    PRIMARY KEY ((tenant_id, payment_intent_id))
);

CREATE TABLE IF NOT EXISTS fluxer.payments_by_subscription (
    tenant_id bigint,
    subscription_id text,
    checkout_session_id text,
    user_id bigint,
    price_id text,
    product_type text,
    PRIMARY KEY ((tenant_id, subscription_id))
);

CREATE TABLE IF NOT EXISTS fluxer.payments_by_user (
    tenant_id bigint,
    user_id bigint,
    created_at timestamp,
    checkout_session_id text,
    PRIMARY KEY ((tenant_id, user_id), created_at)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- ---------------------
-- Visionary tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.visionary_purchases (
    tenant_id bigint,
    purchase_id bigint,
    user_id bigint,
    purchased_at timestamp,
    sequence_number int,
    stripe_payment_intent_id text,
    PRIMARY KEY ((tenant_id, purchase_id))
);

CREATE TABLE IF NOT EXISTS fluxer.visionary_purchases_by_user (
    tenant_id bigint,
    user_id bigint,
    purchase_id bigint,
    PRIMARY KEY ((tenant_id, user_id), purchase_id)
);

CREATE TABLE IF NOT EXISTS fluxer.visionary_users (
    tenant_id bigint,
    sequence_number int,
    user_id bigint,
    checkout_session_id text,
    gift_code text,
    granted_at timestamp,
    PRIMARY KEY ((tenant_id, sequence_number))
);

CREATE TABLE IF NOT EXISTS fluxer.visionary_users_by_user (
    tenant_id bigint,
    user_id bigint,
    sequence_number int,
    granted_at timestamp,
    PRIMARY KEY ((tenant_id, user_id))
);

CREATE TABLE IF NOT EXISTS fluxer.visionary_counter (
    tenant_id bigint,
    id text,
    next_sequence_number counter,
    PRIMARY KEY ((tenant_id, id))
);

CREATE TABLE IF NOT EXISTS fluxer.visionary_slots (
    tenant_id bigint,
    slot_index int,
    user_id bigint,
    PRIMARY KEY ((tenant_id, slot_index))
);

-- ---------------------
-- Swish payment tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.swish_payments (
    tenant_id bigint,
    payment_id text,
    user_id bigint,
    product_type text,
    status text,
    is_gift boolean,
    amount int,
    currency text,
    message text,
    payer_alias text,
    payment_reference text,
    gift_code text,
    created_at timestamp,
    completed_at timestamp,
    PRIMARY KEY ((tenant_id, payment_id))
);

CREATE TABLE IF NOT EXISTS fluxer.swish_payments_by_user (
    tenant_id bigint,
    user_id bigint,
    payment_id text,
    product_type text,
    status text,
    is_gift boolean,
    amount int,
    currency text,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), created_at)
) WITH CLUSTERING ORDER BY (created_at DESC);

-- ---------------------
-- User harvest tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.user_harvests (
    tenant_id bigint,
    user_id bigint,
    harvest_id bigint,
    requested_at timestamp,
    started_at timestamp,
    completed_at timestamp,
    failed_at timestamp,
    storage_key text,
    file_size bigint,
    progress_percent int,
    progress_step text,
    error_message text,
    download_url_expires_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), harvest_id)
) WITH CLUSTERING ORDER BY (harvest_id DESC);

-- ---------------------
-- Admin tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.admin_audit_logs (
    tenant_id bigint,
    log_id bigint,
    admin_user_id bigint,
    target_type text,
    target_id bigint,
    action text,
    audit_log_reason text,
    metadata map<text, text>,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, log_id))
);

CREATE TABLE IF NOT EXISTS fluxer.admin_archives_by_subject (
    tenant_id bigint,
    subject_type text,
    subject_id bigint,
    archive_id bigint,
    requested_by bigint,
    requested_at timestamp,
    started_at timestamp,
    completed_at timestamp,
    failed_at timestamp,
    storage_key text,
    file_size bigint,
    progress_percent int,
    progress_step text,
    error_message text,
    download_url_expires_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, subject_type, subject_id), archive_id)
) WITH CLUSTERING ORDER BY (archive_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.admin_archives_by_requester (
    tenant_id bigint,
    requested_by bigint,
    archive_id bigint,
    subject_type text,
    subject_id bigint,
    requested_at timestamp,
    started_at timestamp,
    completed_at timestamp,
    failed_at timestamp,
    storage_key text,
    file_size bigint,
    progress_percent int,
    progress_step text,
    error_message text,
    download_url_expires_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, requested_by), archive_id)
) WITH CLUSTERING ORDER BY (archive_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.admin_archives_by_type (
    tenant_id bigint,
    subject_type text,
    archive_id bigint,
    subject_id bigint,
    requested_by bigint,
    requested_at timestamp,
    started_at timestamp,
    completed_at timestamp,
    failed_at timestamp,
    storage_key text,
    file_size bigint,
    progress_percent int,
    progress_step text,
    error_message text,
    download_url_expires_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, subject_type), archive_id)
) WITH CLUSTERING ORDER BY (archive_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.admin_api_keys (
    tenant_id bigint,
    key_id bigint,
    key_hash text,
    name text,
    created_by_user_id bigint,
    created_at timestamp,
    last_used_at timestamp,
    expires_at timestamp,
    version int,
    acls set<text>,
    PRIMARY KEY ((tenant_id, key_id))
);

CREATE TABLE IF NOT EXISTS fluxer.admin_api_keys_by_creator (
    tenant_id bigint,
    created_by_user_id bigint,
    key_id bigint,
    created_at timestamp,
    name text,
    expires_at timestamp,
    last_used_at timestamp,
    version int,
    acls set<text>,
    PRIMARY KEY ((tenant_id, created_by_user_id), key_id)
) WITH CLUSTERING ORDER BY (key_id DESC);

-- ---------------------
-- Report tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.iar_submissions (
    tenant_id bigint,
    report_id bigint,
    reporter_id bigint,
    reported_at timestamp,
    status int,
    report_type int,
    category text,
    additional_info text,
    reported_user_id bigint,
    reported_user_username text,
    reported_user_discriminator int,
    reported_user_avatar_hash text,
    reported_guild_id bigint,
    reported_guild_name text,
    reported_guild_icon_hash text,
    reported_message_id bigint,
    reported_channel_id bigint,
    reported_channel_name text,
    message_context frozen<list<iar_message_context>>,
    guild_context_id bigint,
    resolved_at timestamp,
    resolved_by_admin_id bigint,
    public_comment text,
    audit_log_reason text,
    reporter_email text,
    reporter_full_legal_name text,
    reporter_country_of_residence text,
    reported_guild_invite_code text,
    PRIMARY KEY ((tenant_id, report_id))
);

CREATE TABLE IF NOT EXISTS fluxer.dsa_report_email_verifications (
    tenant_id bigint,
    email_lower text,
    code_hash text,
    expires_at timestamp,
    last_sent_at timestamp,
    PRIMARY KEY ((tenant_id, email_lower))
);

CREATE TABLE IF NOT EXISTS fluxer.dsa_report_tickets (
    tenant_id bigint,
    ticket text,
    email_lower text,
    expires_at timestamp,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, ticket))
);

-- ---------------------
-- Pending verification tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.pending_verifications (
    tenant_id bigint,
    user_id bigint,
    created_at timestamp,
    metadata map<text, text>,
    version int,
    PRIMARY KEY ((tenant_id, user_id))
);

CREATE TABLE IF NOT EXISTS fluxer.pending_verifications_by_time (
    tenant_id bigint,
    created_at timestamp,
    user_id bigint,
    PRIMARY KEY ((tenant_id, created_at), user_id)
) WITH CLUSTERING ORDER BY (user_id ASC);

-- ---------------------
-- Pinned DM tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.pinned_dms (
    tenant_id bigint,
    user_id bigint,
    channel_id bigint,
    sort_order int,
    PRIMARY KEY ((tenant_id, user_id), channel_id)
);

-- ---------------------
-- Voice tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.voice_regions (
    tenant_id bigint,
    id text,
    name text,
    emoji text,
    latitude double,
    longitude double,
    priority int,
    is_default boolean,
    vip_only boolean,
    required_guild_features set<text>,
    allowed_guild_ids set<bigint>,
    allowed_user_ids set<bigint>,
    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, id))
);

CREATE TABLE IF NOT EXISTS fluxer.voice_servers (
    tenant_id bigint,
    region_id text,
    server_id text,
    endpoint text,
    api_key text,
    api_secret text,
    priority int,
    is_active boolean,
    vip_only boolean,
    required_guild_features set<text>,
    allowed_guild_ids set<bigint>,
    allowed_user_ids set<bigint>,
    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, region_id), server_id)
);

-- ---------------------
-- OAuth (legacy) tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.oauth_clients (
    tenant_id bigint,
    client_id bigint,
    client_secret_hash text,
    name text,
    description text,
    icon_url text,
    owner_user_id bigint,
    team_id bigint,
    type text,
    redirect_uris set<text>,
    scopes set<text>,
    grant_types set<text>,
    homepage_url text,
    created_at timestamp,
    updated_at timestamp,
    bot_is_public boolean,
    PRIMARY KEY ((tenant_id, client_id))
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_clients_by_owner (
    tenant_id bigint,
    owner_user_id bigint,
    client_id bigint,
    PRIMARY KEY ((tenant_id, owner_user_id), client_id)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_authorization_requests (
    tenant_id bigint,
    request_id text,
    client_id bigint,
    redirect_uri text,
    scope set<text>,
    state text,
    code_challenge text,
    code_challenge_method text,
    nonce text,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, request_id))
) WITH default_time_to_live = 900;

CREATE TABLE IF NOT EXISTS fluxer.oauth_authorization_codes (
    tenant_id bigint,
    code text,
    client_id bigint,
    user_id bigint,
    redirect_uri text,
    scope set<text>,
    code_challenge text,
    code_challenge_method text,
    nonce text,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, code))
) WITH default_time_to_live = 900;

CREATE TABLE IF NOT EXISTS fluxer.oauth_access_tokens (
    tenant_id bigint,
    token_ text,
    client_id bigint,
    user_id bigint,
    scope set<text>,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 86400;

CREATE TABLE IF NOT EXISTS fluxer.oauth_access_tokens_by_client (
    tenant_id bigint,
    client_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, client_id), token_)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_access_tokens_by_user (
    tenant_id bigint,
    user_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, user_id), token_)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_refresh_tokens (
    tenant_id bigint,
    token_ text,
    client_id bigint,
    user_id bigint,
    scope set<text>,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 2592000;

CREATE TABLE IF NOT EXISTS fluxer.oauth_refresh_tokens_by_client (
    tenant_id bigint,
    client_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, client_id), token_)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_refresh_tokens_by_user (
    tenant_id bigint,
    user_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, user_id), token_)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_teams (
    tenant_id bigint,
    team_id bigint,
    name text,
    owner_user_id bigint,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, team_id))
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_teams_by_owner (
    tenant_id bigint,
    owner_user_id bigint,
    team_id bigint,
    PRIMARY KEY ((tenant_id, owner_user_id), team_id)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_team_members (
    tenant_id bigint,
    team_id bigint,
    user_id bigint,
    role text,
    added_at timestamp,
    PRIMARY KEY ((tenant_id, team_id), user_id)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_team_members_by_user (
    tenant_id bigint,
    user_id bigint,
    team_id bigint,
    PRIMARY KEY ((tenant_id, user_id), team_id)
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_bot_tokens (
    tenant_id bigint,
    token_ text,
    client_id bigint,
    user_id bigint,
    scopes set<text>,
    created_at timestamp,
    revoked boolean,
    PRIMARY KEY ((tenant_id, token_))
);

CREATE TABLE IF NOT EXISTS fluxer.oauth_bot_tokens_by_client (
    tenant_id bigint,
    client_id bigint,
    token_ text,
    user_id bigint,
    scopes set<text>,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, client_id), token_)
);

CREATE TABLE IF NOT EXISTS fluxer.oidc_keys (
    tenant_id bigint,
    kid text,
    alg text,
    public_jwk text,
    private_jwk text,
    created_at timestamp,
    active boolean,
    PRIMARY KEY ((tenant_id, kid))
);

CREATE TABLE IF NOT EXISTS fluxer.oidc_keys_by_kid (
    tenant_id bigint,
    kid text,
    alg text,
    public_jwk text,
    private_jwk text,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, kid))
);

CREATE TABLE IF NOT EXISTS fluxer.oidc_key_status (
    tenant_id bigint,
    name text,
    active_kid text,
    published_kids set<text>,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, name))
);

-- ---------------------
-- OAuth2 / Application tables (v2)
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.applications (
    tenant_id bigint,
    application_id bigint,
    owner_user_id bigint,
    name text,
    bot_user_id bigint,
    is_confidential boolean,
    oauth2_redirect_uris set<text>,
    oauth2_scopes set<text>,
    client_secret_hash text,
    bot_token_hash text,
    bot_token_preview text,
    bot_token_created_at timestamp,
    client_secret_created_at timestamp,
    bot_is_public boolean,
    bot_require_code_grant boolean,
    version int,
    PRIMARY KEY ((tenant_id, application_id))
);

CREATE TABLE IF NOT EXISTS fluxer.applications_by_owner (
    tenant_id bigint,
    owner_user_id bigint,
    application_id bigint,
    PRIMARY KEY ((tenant_id, owner_user_id), application_id)
) WITH CLUSTERING ORDER BY (application_id DESC);

CREATE TABLE IF NOT EXISTS fluxer.oauth2_authorization_codes (
    tenant_id bigint,
    code text,
    application_id bigint,
    user_id bigint,
    redirect_uri text,
    scope set<text>,
    code_challenge text,
    code_challenge_method text,
    nonce text,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, code))
) WITH default_time_to_live = 600;

CREATE TABLE IF NOT EXISTS fluxer.oauth2_access_tokens (
    tenant_id bigint,
    token_ text,
    application_id bigint,
    user_id bigint,
    scope set<text>,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 604800;

CREATE TABLE IF NOT EXISTS fluxer.oauth2_access_tokens_by_user (
    tenant_id bigint,
    user_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, user_id), token_)
) WITH CLUSTERING ORDER BY (token_ DESC)
AND default_time_to_live = 604800;

CREATE TABLE IF NOT EXISTS fluxer.oauth2_refresh_tokens (
    tenant_id bigint,
    token_ text,
    application_id bigint,
    user_id bigint,
    scope set<text>,
    created_at timestamp,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 2592000;

CREATE TABLE IF NOT EXISTS fluxer.oauth2_refresh_tokens_by_user (
    tenant_id bigint,
    user_id bigint,
    token_ text,
    PRIMARY KEY ((tenant_id, user_id), token_)
) WITH CLUSTERING ORDER BY (token_ DESC);

-- ---------------------
-- Attachment decay tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.attachment_decay_by_id (
    tenant_id bigint,
    attachment_id bigint,
    channel_id bigint,
    message_id bigint,
    filename text,
    size_bytes varint,
    uploaded_at timestamp,
    expires_at timestamp,
    last_accessed_at timestamp,
    cost double,
    lifetime_days int,
    status text,
    PRIMARY KEY ((tenant_id, attachment_id))
);

CREATE TABLE IF NOT EXISTS fluxer.attachment_decay_by_expiry (
    tenant_id bigint,
    expiry_bucket int,
    expires_at timestamp,
    attachment_id bigint,
    channel_id bigint,
    message_id bigint,
    PRIMARY KEY ((tenant_id, expiry_bucket), expires_at, attachment_id)
);

-- ---------------------
-- Expression pack tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.expression_packs (
    tenant_id bigint,
    pack_id bigint,
    pack_type text,
    creator_id bigint,
    name text,
    description text,
    created_at timestamp,
    updated_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, pack_id))
);

CREATE TABLE IF NOT EXISTS fluxer.expression_packs_by_creator (
    tenant_id bigint,
    creator_id bigint,
    pack_id bigint,
    pack_type text,
    name text,
    description text,
    created_at timestamp,
    updated_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, creator_id), pack_id)
);

CREATE TABLE IF NOT EXISTS fluxer.pack_installations (
    tenant_id bigint,
    user_id bigint,
    pack_id bigint,
    pack_type text,
    installed_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), pack_id)
);

-- ---------------------
-- Scheduled message tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.scheduled_messages (
    tenant_id bigint,
    user_id bigint,
    scheduled_message_id bigint,
    channel_id bigint,
    payload text,
    scheduled_at timestamp,
    scheduled_local_at text,
    timezone text,
    status text,
    status_reason text,
    created_at timestamp,
    invalidated_at timestamp,
    PRIMARY KEY ((tenant_id, user_id), scheduled_message_id)
) WITH CLUSTERING ORDER BY (scheduled_message_id DESC);

-- ---------------------
-- System DM job tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.system_dm_jobs (
    tenant_id bigint,
    job_type text,
    job_id bigint,
    admin_user_id bigint,
    status text,
    content text,
    registration_start timestamp,
    registration_end timestamp,
    excluded_guild_ids set<text>,
    target_count int,
    sent_count int,
    failed_count int,
    last_error text,
    worker_job_key text,
    created_at timestamp,
    updated_at timestamp,
    approved_by bigint,
    approved_at timestamp,
    PRIMARY KEY ((tenant_id, job_type), job_id)
) WITH CLUSTERING ORDER BY (job_id DESC);

-- ---------------------
-- CSAM tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.csam_evidence_packages (
    tenant_id bigint,
    report_id bigint,
    resource_type text,
    bucket text,
    key text,
    cdn_url text,
    filename text,
    content_type text,
    channel_id bigint,
    message_id bigint,
    guild_id bigint,
    user_id bigint,
    match_tracking_id text,
    match_details text,
    frames text,
    hashes text,
    context_snapshot text,
    created_at timestamp,
    expires_at timestamp,
    integrity_sha256 text,
    evidence_zip_key text,
    PRIMARY KEY ((tenant_id, report_id))
);

CREATE TABLE IF NOT EXISTS fluxer.csam_evidence_legal_holds (
    tenant_id bigint,
    report_id bigint,
    held_until timestamp,
    created_at timestamp,
    PRIMARY KEY ((tenant_id, report_id))
);

CREATE TABLE IF NOT EXISTS fluxer.csam_scan_jobs (
    tenant_id bigint,
    job_id text,
    resource_type text,
    bucket text,
    key text,
    cdn_url text,
    filename text,
    content_type text,
    channel_id bigint,
    message_id bigint,
    guild_id bigint,
    user_id bigint,
    status text,
    enqueue_time timestamp,
    last_updated timestamp,
    match_tracking_id text,
    match_details text,
    hashes text,
    error_message text,
    expires_at timestamp,
    PRIMARY KEY ((tenant_id, job_id))
);

CREATE TABLE IF NOT EXISTS fluxer.csam_evidence_expirations (
    tenant_id bigint,
    bucket text,
    expires_at timestamp,
    report_id bigint,
    PRIMARY KEY ((tenant_id, bucket), expires_at, report_id)
) WITH CLUSTERING ORDER BY (expires_at ASC);

CREATE TABLE IF NOT EXISTS fluxer.ncmec_submissions (
    tenant_id bigint,
    report_id bigint,
    status text,
    ncmec_report_id text,
    submitted_at timestamp,
    submitted_by_admin_id bigint,
    failure_reason text,
    created_at timestamp,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, report_id))
);

-- ---------------------
-- Instance configuration
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.instance_configuration (
    tenant_id bigint,
    key text,
    value text,
    updated_at timestamp,
    PRIMARY KEY ((tenant_id, key))
);

-- ---------------------
-- Donation tables
-- ---------------------

CREATE TABLE IF NOT EXISTS fluxer.donors (
    tenant_id bigint,
    email text,
    stripe_customer_id text,
    business_name text,
    tax_id text,
    tax_id_type text,
    stripe_subscription_id text,
    subscription_amount_cents int,
    subscription_currency text,
    subscription_interval text,
    subscription_current_period_end timestamp,
    subscription_cancel_at timestamp,
    created_at timestamp,
    updated_at timestamp,
    version int,
    PRIMARY KEY ((tenant_id, email))
);

CREATE TABLE IF NOT EXISTS fluxer.donors_by_stripe_customer_id (
    tenant_id bigint,
    stripe_customer_id text,
    email text,
    PRIMARY KEY ((tenant_id, stripe_customer_id), email)
);

CREATE TABLE IF NOT EXISTS fluxer.donors_by_stripe_subscription_id (
    tenant_id bigint,
    stripe_subscription_id text,
    email text,
    PRIMARY KEY ((tenant_id, stripe_subscription_id), email)
);

CREATE TABLE IF NOT EXISTS fluxer.donor_magic_link_tokens (
    tenant_id bigint,
    token_ text,
    donor_email text,
    expires_at timestamp,
    used_at timestamp,
    PRIMARY KEY ((tenant_id, token_))
) WITH default_time_to_live = 900;

CREATE TABLE IF NOT EXISTS fluxer.donor_magic_link_tokens_by_email (
    tenant_id bigint,
    donor_email text,
    token_ text,
    PRIMARY KEY ((tenant_id, donor_email), token_)
) WITH default_time_to_live = 900;

-- =============================================================================
-- Tenant bootstrap tables (NO tenant_id in PK)
-- =============================================================================

CREATE TABLE IF NOT EXISTS fluxer.tenants (
    tenant_id bigint,
    name text,
    slug text,
    plan text,
    status text,
    created_at timestamp,
    PRIMARY KEY ((tenant_id))
);

CREATE TABLE IF NOT EXISTS fluxer.tenants_by_domain (
    domain text,
    tenant_id bigint,
    PRIMARY KEY ((domain))
);
