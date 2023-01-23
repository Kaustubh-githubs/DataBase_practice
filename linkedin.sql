
CREATE TYPE valid_type AS ENUM ('userAccount', 'employerAccount');


CREATE TABLE "user_profile" (
  "id" bigint  NOT NULL,
  "userName" varchar(50) UNIQUE,
  "password" varchar(15) NOT NULL,
  "name" varchar(50) NOT NULL,
  "email" varchar(50) UNIQUE NOT NULL,
  "type"  valid_type,	
  "phoneNo" VARCHAR(10),
  "profile_pic_url" varchar(100) ,
  "title" VARCHAR(100),
  PRIMARY KEY ("id")
);

CREATE INDEX "Key" ON  "user_profile" ("id", "title");

CREATE TABLE "user_skill_map" (
  "id" bigint unique NOT NULL,
  "user_profile_id" bigint,
  "skill_id" bigint,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_user_skill_map.user_profile_id"
    FOREIGN KEY ("user_profile_id")
      REFERENCES "user_profile"("id")
);

CREATE TABLE "skills" (
  "id" bigint NOT NULL,
  "name" varchar(50),
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_skills.id"
    FOREIGN KEY ("id")
      REFERENCES "user_skill_map"("skill_id")
);

CREATE TABLE "company" (
  "id" big_int,
  "name" varchar,
  "start_date" Type,
  "end_date" Type,
  "desc" Type,
  "salary" Type,
  PRIMARY KEY ("id")
);

CREATE INDEX "Key" ON  "company" ("desc", "salary");

CREATE TABLE "connection" (
  "id" big_int,
  "senders_id" int_serial,
  "recieve" int_serial,
  "is_accepted" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_connection.senders_id"
    FOREIGN KEY ("senders_id")
      REFERENCES "user_profile"("id"),
  CONSTRAINT "FK_connection.recieve"
    FOREIGN KEY ("recieve")
      REFERENCES "user_profile"("id")
);

CREATE TABLE "posts" (
  "id" big_int,
  "post" Type,
  "user_profile" varchar,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_posts.user_profile"
    FOREIGN KEY ("user_profile")
      REFERENCES "user_profile"("id")
);

CREATE INDEX "Key" ON  "posts" ("user_profile");

CREATE TABLE "comments" (
  "id" big_int,
  "comment" Type,
  "user_profile_id" Type,
  "entity_id" Type,
  "entity_type" varchar,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_comments.entity_id"
    FOREIGN KEY ("entity_id")
      REFERENCES "posts"("id"),
  CONSTRAINT "FK_comments.entity_id"
    FOREIGN KEY ("entity_id")
      REFERENCES "comments"("entity_type"),
  CONSTRAINT "FK_comments.user_profile_id"
    FOREIGN KEY ("user_profile_id")
      REFERENCES "user_profile"("id")
);

CREATE INDEX "Key" ON  "comments" ("comment");

CREATE TABLE "like" (
  "id" big_int,
  "user_profile_id" Type,
  "entity_id" Type,
  "entity_type" Type,
  "like_type" Type,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_like.entity_id"
    FOREIGN KEY ("entity_id")
      REFERENCES "posts"("id"),
  CONSTRAINT "FK_like.entity_id"
    FOREIGN KEY ("entity_id")
      REFERENCES "comments"("id"),
  CONSTRAINT "FK_like.user_profile_id"
    FOREIGN KEY ("user_profile_id")
      REFERENCES "user_profile"("id")
);

CREATE INDEX "Key" ON  "like" ("like_type");

CREATE TABLE "institution" (
  "id" big_int,
  "name" varchar,
  "start_date" Type,
  "end_date" Type,
  "desc" Type,
  "GPA" Type,
  PRIMARY KEY ("id")
);

CREATE INDEX "Key" ON  "institution" ("desc", "GPA");

CREATE TABLE "user_institution" (
  "id" big_int,
  "user_profile_id" varchar,
  "institution_id" Type,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_user_institution.institution_id"
    FOREIGN KEY ("institution_id")
      REFERENCES "institution"("id"),
  CONSTRAINT "FK_user_institution.user_profile_id"
    FOREIGN KEY ("user_profile_id")
      REFERENCES "user_profile"("id")
);

CREATE TABLE "user_company" (
  "id" big_int,
  "user_profile_id" varchar,
  "company_id" Type,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_user_company.company_id"
    FOREIGN KEY ("company_id")
      REFERENCES "company"("id"),
  CONSTRAINT "FK_user_company.user_profile_id"
    FOREIGN KEY ("user_profile_id")
      REFERENCES "user_profile"("id")
);

CREATE TABLE "recruting_company" (
  "id" int,
  "name" varchar(40),
  "domain" varchar(2000,
  "website_url" varchar(300),
  "is_active" bool,
  PRIMARY KEY ("id")
);

CREATE INDEX "Key" ON  "recruting_company" ("name", "domain", "website_url", "is_active");

CREATE TABLE "job_post_activity" (
  "id" int,
  "user_id" varchar,
  "job_post_id" int,
  "apply_date" date,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_job_post_activity.user_id"
    FOREIGN KEY ("user_id")
      REFERENCES "user_profile"("id")
);

CREATE TABLE "job_post" (
  "id" int,
  "job_type" varchar(40),
  "company_id" varchar(20),
  "job_tag" varchar(40),
  "job_desc" varchar(2000,
  "location_city" varchar(50),
  "is_active" bool,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_job_post.company_id"
    FOREIGN KEY ("company_id")
      REFERENCES "recruting_company"("id"),
  CONSTRAINT "FK_job_post.id"
    FOREIGN KEY ("id")
      REFERENCES "job_post_activity"("job_post_id")
);

CREATE INDEX "Key" ON  "job_post" ("job_type", "job_tag", "job_desc", "location_city", "is_active");

CREATE TABLE "job_post_skill_set" (
  "id" int,
  "skill_set_id" varchar,
  "job_post_id" Type,
  PRIMARY KEY ("id"),
  CONSTRAINT "FK_job_post_skill_set.skill_set_id"
    FOREIGN KEY ("skill_set_id")
      REFERENCES "skills"("id"),
  CONSTRAINT "FK_job_post_skill_set.job_post_id"
    FOREIGN KEY ("job_post_id")
      REFERENCES "job_post"("id")
);
