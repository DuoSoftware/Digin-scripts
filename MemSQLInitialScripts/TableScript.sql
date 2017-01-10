CREATE TABLE `digin_component_access_details` (
  `component_id` decimal(14,0) NOT NULL,
  `user_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `domain` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `security_level` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `shared_by` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `user_group_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`component_id`,`user_id`,`type`,`domain`)
);
CREATE TABLE `digin_datasource_details` (
  `id` decimal(14,0) NOT NULL,
  `project_id` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dataset_id` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datasource_id` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `datasource_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schema` JSON COLLATE utf8_bin,
  `modified_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_tenant` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
);

CREATE TABLE `digin_datasource_upload_details` (
  `upload_id` decimal(14,0) NOT NULL,
  `datasource_id` decimal(14,0) NOT NULL,
  `upload_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uploaded_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `upload_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `number_of_rows` bigint(20) DEFAULT NULL,
  `first_row_number` bigint(20) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`upload_id`)
);

CREATE TABLE `digin_data_source_config` (
  `ds_config_id` bigint(50) NOT NULL,
  `connection_type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `connection_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `host_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `database_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `port` bigint(20) DEFAULT NULL,
  `user_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `others` JSON COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ds_config_id`)
);
