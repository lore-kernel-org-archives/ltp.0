Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C93C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 10:00:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBC93C90E8
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 11:00:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78D623C9235
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 91EA76009FB
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 11:00:17 +0100 (CET)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BEC4E3F163
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 10:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641376816;
 bh=6dAeG9CvREzKEASdTDOf8vSp3/FHtdUTQsVRSsXF6MU=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=dKG+2A8v0FPEF40WPLMe8hNhqDmn5H49Y+NxaTGMSOSpfhMa5D4HSY2sgBuPIngvx
 xYtoG+R7FuXClVhJ+QTD90VDkPRL9bhyxHGxopP3J5ZdDojMJ3pesxFCeCY4ryhL0g
 TD2Ct0lPOZpLpOJBhLMMrm5ZBw4bacKoXlcttY85ByAiaOkx63aHPF8DPQN7ijQcqy
 R1e5KISLjCU6wBBxC3c+8PvTQljGaWkUEPWrKX4rlyu/4OdElUAt2/hkSnIwVb1jvv
 rkPSLQVIsTtPJsYRRUAQawEhK5PKOjoP1Zt6lptJxQ4Jm0Q7cGykfj9t7cpZGlKKrX
 8aUqbbukGWWRg==
Received: by mail-lf1-f72.google.com with SMTP id
 cf14-20020a056512280e00b00426460c9af9so8789541lfb.4
 for <ltp@lists.linux.it>; Wed, 05 Jan 2022 02:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6dAeG9CvREzKEASdTDOf8vSp3/FHtdUTQsVRSsXF6MU=;
 b=vLvcyNWaV8NCkk8oR8dhNx8WZDGCzobeo9RVP3bWbvym4zaDMR8yXk7rq27flg38OJ
 Wuxj3JeWv7nwIocDnCD43UhByrMPPd2g1WzG1FGOIA+hIG4zz7RQQRwkOoyUg4maoT+w
 lmn5zZXqWkDlsQRdaI+r1VIwYZjhP2/y5hT9pAOb9sqE+WZH/9AP8wds0df/eUHaKxPD
 7VC0dNdfcIhhzLVyxg01itGEPCuBqGwLcNGB7WUyLZdDJXE9XGPNYejmhKKhoWw4HQC/
 059m3HvfyFdPJnSMJWl54TXEArrHx12tCMWuXcyqKUnv3BqdHotNJ/2cW3Z7qw2y4/oq
 zCkQ==
X-Gm-Message-State: AOAM531dtNVoKZJYUvTRoJCIqu1ctuYokEATK30zM+EemtjNlG5kh2Ml
 3HZb1NlBjhuQW7YTz93gP86JkpvZLrwYUB0h6ie3w65jKBt4qokSdiAZnfGbULikFs69YqS5oR8
 9bRKpqBQlvXQfovv0DERiStc5P/MD
X-Received: by 2002:a2e:361a:: with SMTP id d26mr40334205lja.56.1641376815875; 
 Wed, 05 Jan 2022 02:00:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznagj2aLewIKZ0WJ6zQsxRRb6v+zOVlzOZQbGpO9Qm8QKygcT9yfYLXeSZtfZEDxcJMjW1eg==
X-Received: by 2002:a2e:361a:: with SMTP id d26mr40334193lja.56.1641376815550; 
 Wed, 05 Jan 2022 02:00:15 -0800 (PST)
Received: from lukenow-XPS-13-9380.home (159-205-75-251.adsl.inetia.pl.
 [159.205.75.251])
 by smtp.gmail.com with ESMTPSA id z25sm4152527lfq.20.2022.01.05.02.00.14
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jan 2022 02:00:15 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Wed,  5 Jan 2022 02:00:05 -0800
Message-Id: <39c482de2c75e393fa53c31d06620995dabc5284.1641376050.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] API/cgroup: Implement tst_cgroup_load_config()
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

Implement tst_cgroup_load_config which consumes the state given by
tst_cgroup_print_config() to update the internal test state to reflect
the given config.

This allows for programs using the cgroup C API to load and reload
state, allowing functionality such as calling tst_cgroup_require and
tst_cgroup_cleanup to function properly between programs or between
invocations of a binary using the C API.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 include/tst_cgroup.h |   4 +-
 lib/tst_cgroup.c     | 108 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index cfcc189ee..9785bf7b9 100644
--- a/include/tst_cgroup.h
+++ b/include/tst_cgroup.h
@@ -112,7 +112,9 @@ struct tst_cgroup_group;
 void tst_cgroup_scan(void);
 /* Print the config detected by tst_cgroup_scan */
 void tst_cgroup_print_config(void);
-
+/* Load the config printed by tst_cgroup_print_config() to update the
+ * the internal state of the test to the given config */
+void tst_cgroup_load_config(const char *const config);
 /* Ensure the specified controller is available in the test's default
  * CGroup, mounting/enabling it if necessary */
 void tst_cgroup_require(const char *const ctrl_name,
diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 1cec3e722..9b3c639fc 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -378,6 +378,114 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
 	return root;
 }
 
+static int parse_ctrl_config(const char *const config_entry)
+{
+	char *token;
+	struct cgroup_ctrl *ctrl = NULL;
+	int we_require_it = 0;
+
+	if (!strcmp(CONFIG_CTRL_HEADER, config_entry))
+		return 0;
+
+	if (!strcmp(CONFIG_ROOT_HEADER, config_entry))
+		return 1;
+
+	for (token = strtok(config_entry, " "); token; token = strtok(NULL, " ")) {
+		if (!ctrl && !(ctrl = cgroup_find_ctrl(token)))
+			tst_brk(TBROK, "Could not find ctrl from config. Ctrls changing between calls?");
+
+		if (ctrl && !strcmp(token, CONFIG_CTRL_REQUIRED))
+			ctrl->we_require_it = 1;
+	}
+
+	return 0;
+}
+
+static int parse_root_config(char *config_entry)
+{
+	char *key;
+	char *value;
+	struct cgroup_root *root;
+
+	for (key = strtok(config_entry, " "); key; key = strtok(NULL, " ")) {
+		if (!(value = strchr(key, '='))) {
+			if (!(root = cgroup_find_root(key)))
+				tst_brk(TBROK, "Could not find root from config. Roots changing between calls?");
+
+			continue;
+		}
+
+		*value = '\0';
+		value = value + 1;
+
+		if (!strcmp(key, CONFIG_MOUNTROOT_KEY) && !strcmp(value, "yes")) {
+			root->we_mounted_it = 1;
+
+		} else if (!strcmp(key, CONFIG_LTPDIR_KEY) && !root->ltp_dir.dir_name) {
+			cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
+			if (!strcmp(value, "yes"))
+				root->ltp_dir.we_created_it = 1;
+
+		} else if (!strcmp(key, CONFIG_DRAINDIR_KEY) && !root->drain_dir.dir_name) {
+			cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
+			if (!strcmp(value, "yes"))
+				root->ltp_dir.we_created_it = 1;
+
+		} else if (!strcmp(key, CONFIG_TESTID_KEY) && strcmp(value, "NULL") &&
+				   !root->test_dir.dir_name) {
+			cgroup_dir_mk(&root->ltp_dir, value, &root->test_dir);
+			root->test_dir.we_created_it = 1;
+		}
+	}
+
+	return 0;
+}
+
+/* Load the test state configuration provided by tst_cgroup_print_config()
+ *
+ * This will reload some internal tst_cgroup state given by the config
+ * that might otherwise have been lost between calls or between different
+ * processes. In particular this is used by tools/cgroup/tst_cgctl to
+ * provide access to this C api to shell scripts.
+ *
+ * The config keeps track of the minimal state needed for tst_cgroup_cleanup
+ * to cleanup after a test and does not keep track of the creation of
+ * test cgroups that might be created through tst_cgroup_group_mk().
+ */
+void tst_cgroup_load_config(const char *const config)
+{
+	char temp_config[BUFSIZ];
+	char *curr_line;
+	char *next_line;
+
+	if (strlen(config) >= BUFSIZ)
+		tst_brk(TBROK, "Config has exceeded buffer size?");
+
+	strncpy(temp_config, config, BUFSIZ);
+
+	for (curr_line = &temp_config[0]; curr_line; curr_line = next_line + 1) {
+		next_line = strchr(curr_line, '\n');
+		if (next_line)
+			*next_line = '\0';
+
+		if (parse_ctrl_config(curr_line))
+			break;
+	}
+
+	for (curr_line = next_line + 1; curr_line; curr_line = next_line + 1) {
+		next_line = strchr(curr_line, '\n');
+		if (next_line)
+			*next_line = '\0';
+
+		parse_root_config(curr_line);
+		/* Bash will truncate the last newline that we are using to deliminate
+		 * the start and end of valid entries, so if we could not detect any more
+		 * newlines we assume that was our last entry. */
+		if (!next_line)
+			break;
+	}
+}
+
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
  * For CGroups V2 this is very simple as there is only one
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
