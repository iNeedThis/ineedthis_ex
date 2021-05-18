defmodule Ineedthis.Repo.Migrations.ProdSchemaSync2 do
  use Ecto.Migration

  def change do
    execute("DROP TABLE ar_internal_metadata;")
    execute("ALTER SEQUENCE adverts_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE badge_awards_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE badges_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE channels_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE comments_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE commission_items_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE commissions_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE conversations_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE dnp_entries_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE donations_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE duplicate_reports_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE filters_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE fingerprint_bans_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE forums_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE galleries_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE gallery_interactions_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE images_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE messages_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE mod_notes_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE notifications_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE poll_options_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE poll_votes_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE polls_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE posts_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE reports_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE roles_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE site_notices_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE source_changes_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE subnet_bans_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE tag_changes_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE tags_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE topics_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE unread_notifications_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_bans_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_fingerprints_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_ips_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_links_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_name_changes_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_statistics_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE user_whitelists_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE users_id_seq AS BIGINT;")
    execute("ALTER SEQUENCE versions_id_seq AS BIGINT;")
    execute("CREATE INDEX index_users_on_created_at ON public.users USING btree (created_at);")

    execute(
      "CREATE INDEX index_users_on_role ON public.users USING btree (role) WHERE ((role)::text <> 'user'::text);"
    )

    execute("DROP INDEX temp_unique_index_tags_on_name;")
    execute("DROP INDEX temp_unique_index_tags_on_slug;")
  end
end
