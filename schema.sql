CREATE TABLE "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
CREATE TABLE "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(100) NOT NULL, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL, UNIQUE ("app_label", "model"));
CREATE TABLE "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(50) NOT NULL, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id"), "codename" varchar(100) NOT NULL, UNIQUE ("content_type_id", "codename"));
CREATE TABLE "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(80) NOT NULL UNIQUE);
CREATE TABLE "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id"), "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"), UNIQUE ("group_id", "permission_id"));
CREATE TABLE "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NOT NULL, "is_superuser" bool NOT NULL, "username" varchar(30) NOT NULL UNIQUE, "first_name" varchar(30) NOT NULL, "last_name" varchar(30) NOT NULL, "email" varchar(75) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL);
CREATE TABLE "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id"), "group_id" integer NOT NULL REFERENCES "auth_group" ("id"), UNIQUE ("user_id", "group_id"));
CREATE TABLE "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id"), "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id"), UNIQUE ("user_id", "permission_id"));
CREATE INDEX auth_permission_417f1b1c ON "auth_permission" ("content_type_id");
CREATE INDEX auth_group_permissions_0e939a4f ON "auth_group_permissions" ("group_id");
CREATE INDEX auth_group_permissions_8373b171 ON "auth_group_permissions" ("permission_id");
CREATE INDEX auth_user_groups_e8701ad4 ON "auth_user_groups" ("user_id");
CREATE INDEX auth_user_groups_0e939a4f ON "auth_user_groups" ("group_id");
CREATE INDEX auth_user_user_permissions_e8701ad4 ON "auth_user_user_permissions" ("user_id");
CREATE INDEX auth_user_user_permissions_8373b171 ON "auth_user_user_permissions" ("permission_id");
CREATE TABLE "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "action_time" datetime NOT NULL, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL, "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id"), "user_id" integer NOT NULL REFERENCES "auth_user" ("id"));
CREATE INDEX django_admin_log_417f1b1c ON "django_admin_log" ("content_type_id");
CREATE INDEX django_admin_log_e8701ad4 ON "django_admin_log" ("user_id");
CREATE TABLE "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
CREATE INDEX django_session_de54fa62 ON "django_session" ("expire_date");
CREATE TABLE "workshops_airport" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "fullname" varchar(100) NOT NULL UNIQUE, "country" varchar(100) NOT NULL, "latitude" real NOT NULL, "longitude" real NOT NULL, "iata" varchar(10) NOT NULL UNIQUE);
CREATE TABLE "workshops_task" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "event_id" integer NOT NULL REFERENCES "workshops_event" ("id"), "person_id" integer NOT NULL REFERENCES "workshops_person" ("id"), "role_id" integer NOT NULL REFERENCES "workshops_role" ("id"));
CREATE INDEX workshops_task_4437cfac ON "workshops_task" ("event_id");
CREATE INDEX workshops_task_a8452ca7 ON "workshops_task" ("person_id");
CREATE INDEX workshops_task_84566833 ON "workshops_task" ("role_id");
CREATE TABLE "workshops_skill" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(40) NOT NULL);
CREATE TABLE "workshops_qualification" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "person_id" integer NOT NULL REFERENCES "workshops_person" ("id"), "skill_id" integer NOT NULL REFERENCES "workshops_skill" ("id"));
CREATE INDEX workshops_qualification_a8452ca7 ON "workshops_qualification" ("person_id");
CREATE INDEX workshops_qualification_d38d4c39 ON "workshops_qualification" ("skill_id");
CREATE TABLE "workshops_role" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(40) NOT NULL);
CREATE TABLE "workshops_badge" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(40) NOT NULL, "title" varchar(40) NOT NULL, "criteria" varchar(100) NOT NULL);
CREATE TABLE "workshops_site" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "domain" varchar(100) NOT NULL UNIQUE, "fullname" varchar(100) NOT NULL UNIQUE, "country" varchar(100) NULL, "notes" text NOT NULL);
CREATE TABLE "workshops_award" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "awarded" date NOT NULL, "badge_id" integer NOT NULL REFERENCES "workshops_badge" ("id"), "person_id" integer NOT NULL REFERENCES "workshops_person" ("id"), "event_id" integer NULL REFERENCES "workshops_event" ("id"));
CREATE INDEX workshops_award_a4578ce0 ON "workshops_award" ("badge_id");
CREATE INDEX workshops_award_a8452ca7 ON "workshops_award" ("person_id");
CREATE INDEX workshops_award_4437cfac ON "workshops_award" ("event_id");
CREATE TABLE "workshops_person" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "personal" varchar(100) NOT NULL, "middle" varchar(100) NULL, "family" varchar(100) NOT NULL, "email" varchar(100) NULL UNIQUE, "airport_id" integer NULL REFERENCES "workshops_airport" ("id"), "gender" varchar(1) NULL, "github" varchar(40) NULL UNIQUE, "twitter" varchar(40) NULL UNIQUE, "url" varchar(100) NULL, "slug" varchar(100) NULL, "active" bool NULL);
CREATE INDEX workshops_person_f480dbb2 ON "workshops_person" ("airport_id");
CREATE TABLE "workshops_event_tags" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "event_id" integer NOT NULL REFERENCES "workshops_event" ("id"), "tag_id" integer NOT NULL REFERENCES "workshops_tag" ("id"), UNIQUE ("event_id", "tag_id"));
CREATE TABLE "workshops_event" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "start" date NULL, "end" date NULL, "slug" varchar(100) NULL, "reg_key" varchar(20) NULL, "attendance" integer NULL, "site_id" integer NOT NULL REFERENCES "workshops_site" ("id"), "url" varchar(100) NULL UNIQUE, "organizer_id" integer NULL REFERENCES "workshops_site" ("id"), "admin_fee" decimal NULL, "notes" text NOT NULL, "published" bool NOT NULL);
CREATE INDEX workshops_event_9365d6e7 ON "workshops_event" ("site_id");
CREATE INDEX workshops_event_24107bbc ON "workshops_event" ("organizer_id");
CREATE TABLE "workshops_tag" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(40) NOT NULL UNIQUE, "details" varchar(100) NOT NULL);
