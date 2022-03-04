Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4CFC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:19:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3912F3CA401
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:19:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C2593CA40E
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E1E23601D7E
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:40 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CE6E73F613
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435918;
 bh=v2doBMWIGRmqDlTfh7bYbypZbJ8EzVq9R0jIYzIDOUw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=LodbPBnpkHrTnMeE5JOkJoiHwQV7g133w7Vvm//rP64s9INtPpt2WyvKbBWwI3LAV
 xYgH1Kxk7bZoyLqCDynkQ6t8tRPn3QyTstdV6dcvxyiqqwj/7m+TfJSc28ZdtXooT+
 koUEgKbzeNI6F/eqRgoEnsmJeqJm4AQ71uaCxaDJRpwHyNFeCtATpRpM3pBvdsnfCI
 AOWVf1HKz1iRIfx6Kpk6t0iu5cbNBLLP8LW1GZWnPlWOTfMM7Yg1uHjz2KmumsJYLP
 ZOfhR5cOPQYsChWhj2EmxHwPhIsU7wKipwUU7FCPdfI6fg5nmwCEcNIb9tsfxh3uwp
 tyNk3uOQzyQxQ==
Received: by mail-pl1-f199.google.com with SMTP id
 e13-20020a17090301cd00b00150145346f9so5329859plh.23
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v2doBMWIGRmqDlTfh7bYbypZbJ8EzVq9R0jIYzIDOUw=;
 b=ia8wpPEYyPuN4nNOACzHA4kpIGjHVN2+mBhIwhOBVTuMTBV/B7yijldPpKpt27cvRN
 mp0ip6gko8FequQZKz1OYCIJjblv72XMROIa94HcQ53kkSrM88TEyZxoR4RHppSHEWBE
 OO1UAGWp+1deJSzO8F9oNBUVUfk3l+61DCoSLMSdBXnWhxOtboKFdwnu56Y/FQpgSoRj
 /c+J56cNfIfB0/4+G/Km2pk/d2b5I7pUG6ztT5uvVpYAv5pjTEgmuJLfzcQiYtFATQkU
 x5KIfDMWneoN6xkjqx6JVeky6eQLuaIw7fD0T52ApnaAss8GkXp/NzUnN6WoU6B0aa8N
 +nYg==
X-Gm-Message-State: AOAM5319XBsZo9P99w0Zzd6Yz57xEDpxxL6tvROy/RsgZGz4EwkASZWo
 Ss5yFfu02BGsSl52n6Fudo6YM/vekml468SX03CkcfjIL3LFnWmw5lusamqR3Y2+J1jjwKtAIS5
 hqJIe3LxjrOS4Q6Hj8ZFbtIc8w0Wm
X-Received: by 2002:a62:586:0:b0:4e1:dc81:8543 with SMTP id
 128-20020a620586000000b004e1dc818543mr835660pff.0.1646435915206; 
 Fri, 04 Mar 2022 15:18:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKuulEMUvAhARXWBavlURimsvQk7+a6T4jGlp2le/+q7AZB1nvgTnR1Dl7pC3Xp9ggX8Q+Yg==
X-Received: by 2002:a62:586:0:b0:4e1:dc81:8543 with SMTP id
 128-20020a620586000000b004e1dc818543mr835633pff.0.1646435914874; 
 Fri, 04 Mar 2022 15:18:34 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:34 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:14 -0800
Message-Id: <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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

 include/tst_cgroup.h |  7 +++++
 lib/tst_cgroup.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

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
index 8f95064b3..90d91d94e 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -366,6 +366,68 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
 	return NULL;
 }
 
+static void parse_config(const char *const config_entry)
+{
+	const char ctrl_name[32], mnt_path[PATH_MAX], test_dir_name[NAME_MAX + 1];
+	int ver, we_require_it, we_mounted_it, ltp_dir_we_created_it;
+	struct cgroup_root *root;
+	struct cgroup_ctrl *ctrl;
+
+	sscanf(config_entry, CONFIG_FORMAT,
+		ctrl_name, &ver, &we_require_it, mnt_path, &we_mounted_it,
+		&ltp_dir_we_created_it, test_dir_name);
+
+	if (!(ctrl = cgroup_find_ctrl(ctrl_name)))
+		tst_brk(TBROK, "Could not find ctrl from config. Ctrls changing between calls?");
+
+	ctrl->we_require_it = we_require_it;
+
+	if (!(root = cgroup_find_root(mnt_path)))
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
+
+	if (strlen(config) >= BUFSIZ)
+		tst_brk(TBROK, "Config has exceeded buffer size?");
+	strncpy(temp_config, config, BUFSIZ);
+
+	line = strtok(temp_config, "\n");
+	/* Make sure to consume the header. */
+	for (line = strtok(NULL, "\n"); line; line = strtok(NULL, "\n"))
+		parse_config(line);
+}
 
 /* Determine if a mounted cgroup hierarchy is unique and record it if so.
  *
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
