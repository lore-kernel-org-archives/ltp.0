Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75D3C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2932B3CA0B6
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72D643C9F24
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:17 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CABAF1400DAD
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:16 +0200 (CEST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 506173F123
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436796;
 bh=jKj0RLDgiGNIrBiFAYms6cwR3Ml469jX9zmQGtlKCOE=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=cGV4WinxnvKmFq5XVGq/Be1sDe3UXaopE03BPe3QVzg35ot2MA+rhZtYMpskFedQQ
 Zii0jKkrSWRM0ogp6ZSf+UtOPr77hI51trPZcq7SUGJBKhw70jdJ1pZ2Z1gzDYSfrS
 wwznVaaD/aRt1m76UzpPxuLshYkHuN7rbAxbFZ4RDDfD6Wyl6nNRgkqTwoi5mnE0Qt
 o9aodMaEhfIGOkskEZGV/m9OHFOfaXMaCxur1XX50FnGB6md5DQ4DHXfOEl6l6S3yz
 Py+2a0N0trs+qpx1154DxYrp3Z2NtUedDW37A6vpygZxrdks9DyTXg1Fo/4hS7JxII
 ro21jWhqsbFfQ==
Received: by mail-pj1-f72.google.com with SMTP id
 o13-20020a17090ab88d00b001f1ef2109aaso3275831pjr.2
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jKj0RLDgiGNIrBiFAYms6cwR3Ml469jX9zmQGtlKCOE=;
 b=4noXVoqpyV5eZEXMy4KpBW4t7P2Bk0sltT16h7lk8srcgfzn8s5H8UDXe8fFr9j0wb
 HztM6dr6ASUmRwF8zGnBFqx7borkH/rfSh9yT7DF30PMr9o5qNgutYrDsct/3FLcDos1
 VvdeqX0Qb8rv8jK1mNdWe95LlRwPMucGr4ANlIyxmE5o+AZ3hyT5agb6wqBZvrJhhDqn
 ifxuLCpT85H/X8t+q/B5oWTk7nh0UgXkWrEYbzBoN494F55UiVvmi7vZqgMWXtQbrS+K
 gQE+gi7awIGEUwPVY/E7Ndamk4HmEUqqoo2RkqjUAiA3kYH5axR/4GCfRd8pO+PAg9pj
 fUhw==
X-Gm-Message-State: AJIora+83aqBC01tsz+IoXVdylIKnK0JHN49f2N2rnC0J6pPB/2O76v8
 MljCJu/yoP8zSsSEZCII1qNjiBA2J6HpGQHAoKpVpBDXyM+VqjHfw6JcbBaW3a/XPyaUHyfslvZ
 PccJ4ZpnwOx+HMecauiqBSVWrbKaG
X-Received: by 2002:a17:902:8346:b0:16d:1fb6:3e9c with SMTP id
 z6-20020a170902834600b0016d1fb63e9cmr160733pln.28.1658436794617; 
 Thu, 21 Jul 2022 13:53:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uflnvxqzlnEwUAIdt74cLlDmYSFSaJBDRiEDABic8P157Ju12c3dmHnd5E3liMvf+BEV5mtw==
X-Received: by 2002:a17:902:8346:b0:16d:1fb6:3e9c with SMTP id
 z6-20020a170902834600b0016d1fb63e9cmr160716pln.28.1658436794321; 
 Thu, 21 Jul 2022 13:53:14 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:13 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:16 -0700
Message-Id: <339bfd84c4977b89bf552c1f3017ff6ec7e7e57f.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 06/18] API/cgroup: Implement tst_cg_load_config
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
v5: Change to use TST_TO_STR macro

 include/tst_cgroup.h |  7 ++++
 lib/tst_cgroup.c     | 77 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index aa70dc27a..d06847cc6 100644
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
  * necessary use tst_test.needs_cgroup_ctrls instead.
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index e9652703f..27e3f5f0d 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -318,8 +318,9 @@ opendir:
 				  O_PATH | O_DIRECTORY);
 }
 
+#define PATH_MAX_STRLEN 4095
 #define CONFIG_HEADER "ctrl_name ver we_require_it mnt_path we_mounted_it ltp_dir.we_created_it test_dir.dir_name"
-#define CONFIG_FORMAT "%s\t%d\t%d\t%s\t%d\t%d\t%s"
+#define CONFIG_FORMAT "%" TST_TO_STR(CTRL_NAME_MAX) "s\t%d\t%d\t%" TST_TO_STR(PATH_MAX_STRLEN) "s\t%d\t%d\t%" TST_TO_STR(NAME_MAX) "s"
 /* Prints out the state associated with each controller to be consumed by
  * tst_cg_load_config.
  *
@@ -338,7 +339,7 @@ void tst_cg_print_config(void)
 		if (!root)
 			continue;
 
-		printf(CONFIG_FORMAT,
+		printf("%s\t%d\t%d\t%s\t%d\t%d\t%s\n",
 			ctrl->ctrl_name,
 			root->ver,
 			ctrl->we_require_it,
@@ -346,7 +347,6 @@ void tst_cg_print_config(void)
 			root->we_mounted_it,
 			root->ltp_dir.we_created_it,
 			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
-		printf("\n");
 	}
 }
 
@@ -375,6 +375,77 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
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
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
