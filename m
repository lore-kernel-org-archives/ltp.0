Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B037C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 20:41:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5CB3CA755
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 22:41:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 101DA3CA76D
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:41 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F4C41400B9E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 22:40:39 +0200 (CEST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 692BB3F21E
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651178439;
 bh=9CzRBac2nrdXcDOgi8sl/vBoqWG0GI04eyLc4wXxRk8=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=pCbVo3qDzRHKXjArXJ/Bz1RA3/tnSmh8w2ToXK0MtdCW1/zvSw+fCr+4UXhGtEXTV
 qQaRH8npQHbOTGhD198RN0+5i/ze0YTyZ6XQiPjD5WMX6Z5xGMQjDLZOvMJeEEMQ+B
 nP6Rf+yjRKp9sesjO2JIVCTOi5BjYppid6wpyRwrCP7D0qt3QCf9XdEiJ9IOPa/hcK
 yFrqqXejUxtlScHCoY83TsmEcyXX8tRj+ADNK3qbnEWB2khYgpG1r49qxtRgeGT3QW
 +ZFjkub5sxiqag96MWCQa0CrW7PRcvpbW0QO9E3vR0866w7sa6BstrQl+oUAlx8SDF
 w/O+t4zE+RyHg==
Received: by mail-pj1-f72.google.com with SMTP id
 t24-20020a17090a449800b001d2d6e740c3so5751770pjg.9
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9CzRBac2nrdXcDOgi8sl/vBoqWG0GI04eyLc4wXxRk8=;
 b=Bf+UczhkuXlocmuLY1k9UqI26XAj4KbvcklI3hi22S2vK9Lv0a7Prhg9AVd0ew4qiN
 oU5NHIPc+lwFDQmsnvW9yCRhYL0WJKgcyNWYSR6N6oiXwB1YG0n+ERDCc4+hV0HNzHnp
 /fohhJAiw7Dpodao3nCzxqXF1YIAEVBZ6NmVCtZXetpl+nAcRRep3D7aEg1G5dVJUBtt
 dS1SYgT61FK5h7ucbIz0cX5FW85aQNullz5sJNLW0zvyPyFWrbIR0TKOdRdhQoVL32RU
 FredssNC8cSiadS6poeuK6WHjSLt+hnv8K+Im1XQ8qTDKMgZeldCSiVRKWh1cgU7aB/c
 vYyQ==
X-Gm-Message-State: AOAM532VFkmMNjYqUHTObTImoSQppS11bzrn32YwawNZPOyL937aG/M3
 KFYllTbqSUEgZMGX08cGmc2lRrhlwsUqsCyYss4CCmokv2Wj6vuk51fPNpisF6oMiUFoaRmIXsL
 rhEdEoH3P+gTgyGExzYKwQvc7wqn1
X-Received: by 2002:a05:6a00:1907:b0:4f7:945:14cf with SMTP id
 y7-20020a056a00190700b004f7094514cfmr36885445pfi.47.1651178437647; 
 Thu, 28 Apr 2022 13:40:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqu6wOujKJ1pzSiQsl7JpAKujbzDc7gFkFVemqF5D/b7Ah0W1A7soshzURK/rH/b1gwAg8mw==
X-Received: by 2002:a05:6a00:1907:b0:4f7:945:14cf with SMTP id
 y7-20020a056a00190700b004f7094514cfmr36885413pfi.47.1651178437220; 
 Thu, 28 Apr 2022 13:40:37 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 f63-20020a62db42000000b0050d35bcdbc0sm659027pfg.181.2022.04.28.13.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 13:40:36 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Thu, 28 Apr 2022 13:39:31 -0700
Message-Id: <e01538f44e048afd2127d60c9dfcd5dccc39e16d.1651176646.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 06/19] API/cgroup: Implement tst_cg_load_config
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Implement tst_cg_load_config which consumes the state given by
tst_cg_print_config to update the internal test state to reflect
the given config.

This allows for programs using the cgroup C API to load and reload
state, allowing functionality such as calling tst_cg_require and
tst_cg_cleanup to function properly between programs or between
invocations of a binary using the C API.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Add root null check in parse_root_config.
    Remove checking for ltp_drain_dir key from config as it was
    redundant.
    Remove unsued variable in parse_ctrl_config.
    Cleanup some compiler warnings.
v3: Rewrite to consume each line of the config with a scanf to make
    the parsing much simpler while using new config variables.
v4: Modify CONFIG_FORMAT to have variable delimits for sscanf to make it
    more safe. Add extra checks for sscanf reading.

 include/tst_cgroup.h |  7 ++++
 lib/tst_cgroup.c     | 77 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 87e55f4df..9bad0d366 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -121,6 +121,13 @@ void tst_cg_scan(void);
  */
 void tst_cg_print_config(void);
 
+/* Load the config printed out by tst_cg_print_config and configure the internal
+ * libary state to match the config. Used to allow tst_cg_cleanup to properly
+ * cleanup mounts and directories created by tst_cg_require between program
+ * invocations.
+ */
+void tst_cg_load_config(const char *const config);
+
 /* Ensure the specified controller is available in the test's default
  * CGroup, mounting/enabling it if necessary. Usually this is not
  * necesary use tst_test.needs_cgroup_controllers instead.
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 2d4e4a2fe..55c57b20d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -319,8 +319,9 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
+#define PATH_MAX_STRLEN 4095
 #define CONFIG_HEADER "ctrl_name ver we_require_it mnt_path we_mounted_it ltp_dir.we_created_it test_dir.dir_name"
-#define CONFIG_FORMAT "%s\t%d\t%d\t%s\t%d\t%d\t%s"
+#define CONFIG_FORMAT "%" TST_TOSTR(CTRL_NAME_MAX) "s\t%d\t%d\t%" TST_TOSTR(PATH_MAX_STRLEN) "s\t%d\t%d\t%" TST_TOSTR(NAME_MAX) "s"
 /* Prints out the state associated with each controller to be consumed by
  * tst_cg_load_config.
  *
@@ -339,7 +340,7 @@ void tst_cg_print_config(void)
 		if (!root)
 			continue;
 
-		printf(CONFIG_FORMAT,
+		printf("%s\t%d\t%d\t%s\t%d\t%d\t%s\n",
 			ctrl->ctrl_name,
 			root->ver,
 			ctrl->we_require_it,
@@ -347,7 +348,6 @@ void tst_cg_print_config(void)
 			root->we_mounted_it,
 			root->ltp_dir.we_created_it,
 			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
-		printf("\n");
 	}
 }
 
@@ -376,6 +376,77 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
 	return NULL;
 }
 
+static void cgroup_parse_config_line(const char *const config_entry)
+{
+	char ctrl_name[CTRL_NAME_MAX + 1], mnt_path[PATH_MAX_STRLEN + 1], test_dir_name[NAME_MAX + 1];
+	int ver, we_require_it, we_mounted_it, ltp_dir_we_created_it, vars_read;
+	size_t len;
+	struct cgroup_root *root;
+	struct cgroup_ctrl *ctrl;
+
+	vars_read = sscanf(config_entry, CONFIG_FORMAT,
+		ctrl_name, &ver, &we_require_it, mnt_path, &we_mounted_it,
+		&ltp_dir_we_created_it, test_dir_name);
+
+	if (vars_read != 7)
+		tst_brk(TBROK, "Incorrect number of vars read from config. Config possibly malformed?");
+
+	ctrl = cgroup_find_ctrl(ctrl_name);
+	if (!ctrl)
+		tst_brk(TBROK, "Could not find ctrl from config. Ctrls changing between calls?");
+
+	ctrl->we_require_it = we_require_it;
+
+	root = cgroup_find_root(mnt_path);
+	if (!root)
+		tst_brk(TBROK, "Could not find root from config. Config possibly malformed?");
+
+	if (we_mounted_it)
+		root->we_mounted_it = 1;
+
+	if (!root->ltp_dir.dir_name) {
+		cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
+		cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
+		if (ltp_dir_we_created_it) {
+			root->ltp_dir.we_created_it = 1;
+			root->drain_dir.we_created_it = 1;
+		}
+	}
+
+	if (!root->test_dir.dir_name && strcmp(test_dir_name, "NULL")) {
+		strncpy(cgroup_test_dir, test_dir_name, NAME_MAX);
+		cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir, &root->test_dir);
+		root->test_dir.we_created_it = 1;
+	}
+}
+
+/* Load the test state config provided by tst_cg_print_config
+ *
+ * This will reload some internal tst_cgroup state given by the config
+ * that might otherwise have been lost between calls or between different
+ * processes. In particular this is used by testcases/lib/tst_cgctl to
+ * provide access to this C api to shell scripts.
+ *
+ * The config keeps track of the minimal state needed for tst_cg_cleanup
+ * to cleanup mounts and directories created by tst_cg_require.
+ */
+void tst_cg_load_config(const char *const config)
+{
+	char temp_config[BUFSIZ];
+	char *line;
+	const size_t config_len = strlen(config) + 1;
+
+	if (config_len >= BUFSIZ)
+		tst_brk(TBROK, "Config has exceeded buffer size?");
+
+	memcpy(temp_config, config, config_len);
+	temp_config[config_len] = '\0';
+
+	line = strtok(temp_config, "\n");
+	/* Make sure to consume the header. */
+	for (line = strtok(NULL, "\n"); line; line = strtok(NULL, "\n"))
+		cgroup_parse_config_line(line);
+}
 
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
