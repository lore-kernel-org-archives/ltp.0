Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB1C433F5
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 14:45:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95A223C950B
	for <ltp@archiver.kernel.org>; Wed, 19 Jan 2022 15:45:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20A353C913B
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:27 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83B0B6008C2
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 15:44:26 +0100 (CET)
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D74740045
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 14:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642603466;
 bh=6eUBSQ+ivjr3qUitJlkecWn/2aKQtcoeLEloQYvE7D0=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KxzX1qensYpmErQLB4VOhp8zbRorSiJWC4/irI3Z8wi5pIzYjBkT+yP+UdcbmLmrX
 Ri5Cs4hAEQ6Vr3HcunG22D0WgWAAF+di0SqvP2Bk79cEnFKFVhtwm5dDhlq+cT16pg
 egSP5IyFFhgCKUUzBqXL0WfhCX/doZEgBy4gJKu7G7Q5qZVDSfjQL/8IpmLqSIOkYf
 hUUBhRN+aFfeE/KbzpWBjKMcdthgf6oKRtHivA7hjCEe+S2VJ2WZLOORUNB/dJtwk4
 1ggUiFPvW2u8M0jDArU2/2LvblKarF1BfbgJUMiNpAsV02QSfAIV4w0NwM6UmhGrXW
 TV81tTRwanRmA==
Received: by mail-lf1-f71.google.com with SMTP id
 d34-20020a0565123d2200b0042ed74cbf6aso1751771lfv.11
 for <ltp@lists.linux.it>; Wed, 19 Jan 2022 06:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6eUBSQ+ivjr3qUitJlkecWn/2aKQtcoeLEloQYvE7D0=;
 b=k+G+KE85Lq4JErzjwSSl11lGDoZWHic2PeFUMksS47iAUhxDY5ANzsCf4ob7BrgL6X
 pEYsqpgpJek9dwlDIkBDFFqmhH+xhb/gNSGdi90EoY1n2RAqbAlIIEs8q+3foiJa9Wx3
 XCsEWR9ZJgCj2kRSQHsYdp+hEvUD3LnZwI+5ZF6ZVGYJhjaMRdDmMoj8aBUXy2LViXtF
 1IFEVNSEy4bQ3XaTVwpUpTb9vRm/VHI41z2SYawm3AdE/6wtpziwfMG2UEoA3vFzvIDD
 aJwjC2q8D5mOpy6w62NHqZWdC3pQmdy9tjajhGKS2blcsAjGXm+FXHGl9sRAyiIE80iu
 8zlQ==
X-Gm-Message-State: AOAM532ZXRykajsf0Fr57U1GIVqMKQlQzfgxqupuSPkH3biHW0IuttzQ
 rmt4s5v2lOMPTphv/s55qMY0IEQIGy6TbvaylTCN5IvJ/YQhJMQLEDJT70paiZ/zwoJUpx6BbmW
 s7JMRITwayYCIZSX9g2uiEUYyAlAL
X-Received: by 2002:a19:f811:: with SMTP id a17mr26695835lff.18.1642603465204; 
 Wed, 19 Jan 2022 06:44:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjc/+WvVvA2r2XGiadJrxPrWAfaxURHXIpF/BczYwrptKoTqX4eet6rwDCCpOdMUtz+6783g==
X-Received: by 2002:a19:f811:: with SMTP id a17mr26695812lff.18.1642603464967; 
 Wed, 19 Jan 2022 06:44:24 -0800 (PST)
Received: from lukenow-XPS-13-9380.. (d83-110.icpnet.pl. [77.65.83.110])
 by smtp.gmail.com with ESMTPSA id bt18sm2036843lfb.50.2022.01.19.06.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 06:44:24 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Wed, 19 Jan 2022 06:44:06 -0800
Message-Id: <5a65fad42ee618e0191cc664d8da7feeaa754cc0.1642601554.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/16] API/cgroup: Implement
 tst_cgroup_load_config()
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
v2: Add root null check in parse_root_config.
    Remove checking for ltp_drain_dir key from config as it was
    redundant.
    Remove unsued variable in parse_ctrl_config.
    Cleanup some compiler warnings.

 include/tst_cgroup.h |   4 +-
 lib/tst_cgroup.c     | 106 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
index 7c309edbd..0987cb047 100644
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
index 7a406c9db..df541d26a 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -375,6 +375,112 @@ static struct cgroup_root *cgroup_find_root(const char *const mnt_path)
 	return NULL;
 }
 
+static int parse_ctrl_config(const char *const config_entry)
+{
+	char *token;
+	struct cgroup_ctrl *ctrl = NULL;
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
+	struct cgroup_root *root = NULL;
+
+	for (key = strtok(config_entry, " "); key; key = strtok(NULL, " ")) {
+		if (!(value = strchr(key, '='))) {
+			if (!(root = cgroup_find_root(key)))
+				tst_brk(TBROK, "Could not find root from config. Roots changing between calls?");
+
+			continue;
+		}
+
+		if (!root)
+			tst_brk(TBROK, "Root has not been found, possibly malformed config?");
+
+		*value = '\0';
+		value = value + 1;
+
+		if (!strcmp(key, CONFIG_MOUNTROOT_KEY) && !strcmp(value, "yes")) {
+			root->we_mounted_it = 1;
+		} else if (!strcmp(key, CONFIG_LTPDIR_KEY) && !root->ltp_dir.dir_name) {
+			cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir, &root->ltp_dir);
+			cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
+			if (!strcmp(value, "yes")) {
+				root->ltp_dir.we_created_it = 1;
+				root->drain_dir.we_created_it = 1;
+			}
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
+ * processes. In particular this is used by testcases/lib/tst_cgctl to
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
