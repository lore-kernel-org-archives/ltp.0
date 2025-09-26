Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2524CAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758876689; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ZRZDqyJgqZw8mSjexyro6HdsbXf5y2eEdrdLiPS7H1s=;
 b=JxkZL46MucKWT8M4xQ16QjF/mTOkFw9FcEsENlBwBS00HsszzF8cJgl0H2DvTxYAQQI7G
 aQOUAKWF0jEClhFKxq0TTZrhz5bmEUYZhQkhZ/WEgj9/UssCNEUY5t7LYAGFQLKeb+CfTzS
 c1uC6pWvWk4mFKrs3Xy4UtggDSKV+fg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 283853CE091
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:51:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6D143CE089
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:47 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07CF214004F4
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:50:47 +0200 (CEST)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso302915666b.1
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758876646; x=1759481446; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ve229BNh/mLJgVPuij2HGtue4ukFhFOUCGaXP1erSWk=;
 b=GFkuYs1hpWOPgberSywN3gdFeg7dO6s0KV/J0JZrKGRKMPZ/9V5lZBUvOSGooe2G0X
 /uTKKqWIAcDoEmvFqcDoZlk0oI+Mgd2T27vMCOlqjua7KW8qVpOIKoMC4i7C6gD6d1cA
 0wPOlsQkf27qb54mRx/vvqAS5CVjAqQbIdrllbsFF9P4ejEDf7oWU+tbP4IGGw4pHjz8
 E6xCEZy+lq3z4vR7UlfeLXHsytv8HQyvTvr7VwQM+nSzFq6aVoPYWch1RifFktR1O55H
 TxDoFZs4uaIc+7RyisvAxMHTs4Jto65c7ciKmzrQo8Fw8LfNqqbHGz+Jsxi9IWZn9OW1
 OFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758876646; x=1759481446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ve229BNh/mLJgVPuij2HGtue4ukFhFOUCGaXP1erSWk=;
 b=BqL5ApeLdi6KKw99kgCzfbxyWXinFwJFPVXMATqj6o3M7SVMvhkl3FhzKGdIQ5hFcK
 e6/t6BttkFFHUkzoPYzYyWEz1kp2QMG8iTZsryvT6wV4pxqHgEHHfg06fapJeAc+MKtz
 bzFysJimWJfyOg0l4u7zIN73Ku+O1ESdX+67fDXrMnQVBf2/JXDCFOxr5gQM2GvUBm5A
 H69XofNy0Vp5T7VVj+PIOv99AzorfVNs41ojFgpB+Dpc9eFCooYoN252F/qeghMEri+W
 XlUy0+GNGrKo/03cd3OrOfc+3VQ7gtjPP9yKMXNMdUAKlwJdFZSSSrraKOBlNizklgLe
 3Rgg==
X-Gm-Message-State: AOJu0YzyZ1B7Q6MV9tUbQTJ3+kUffNIDfOhhlFNUkjyKGljXpUm0Njfe
 qBEfC0smvMUByOFt8rfB8qF9gt6b/Mw3jGHBDkiywIaTCVrVgwEeGn4eWhRSbI0MsqEnP7RN/Ro
 DntI=
X-Gm-Gg: ASbGncuqAaD82czIjXfFTdE9UG5EsoNRTdTnpAnuv8JdNhUgkOZFvRJIPuJ7BZkTH+Q
 mc1S7i4UKlKaDCaOXHSMQY+Fy+3RLq9PYwY7PNeT/ihtYIg6yDk11AML6y/5Hql78yJe1X6ukmb
 BOzxAG/Gni03jCtMhM8KnO1ja00kcbmG2eFNkLiEpMYgUYW3JBaOW5c53V/gi27U3eIZyx9I58T
 uAaeLqITgkrPoOXFpNdXwiuC/+QtD8pvWhC0IUtDZ07+X0WFnwIjl86ir1LXLh+r7OleDeMip4i
 1VB0KqZmeuM2a3BMP1rMtGwJYO2xybQq6DLkkLJ1ppVR1Fosjub699M+yVSbaQa9IIzcpv9CX7A
 hGvH+PbKMtKx6+nrnvtyrDkULfjWhcR7wwNGsVqkLvyO8VbNfe8HFcA==
X-Google-Smtp-Source: AGHT+IHW68+2vtWJF0VZx8bDbvQ0CABfpWT9cdOjN2eDFoEV+yWJGGhljfZHNhaUHeybLMo1XWQajw==
X-Received: by 2002:a17:907:808:b0:b04:2533:e8dd with SMTP id
 a640c23a62f3a-b34beca14ccmr620084766b.60.1758876646175; 
 Fri, 26 Sep 2025 01:50:46 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b35446f758csm330514166b.53.2025.09.26.01.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 01:50:45 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 26 Sep 2025 08:50:11 +0000
Message-ID: <20250926085021.22141-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926085021.22141-1-wegao@suse.com>
References: <20250926085021.22141-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] lib: Add support option for .needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

NOTE:This patchset is draft for review not final one.
Since not include update .needs_cmds for all related testcases.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_cmd.h     | 15 +++++++
 include/tst_private.h |  2 +
 include/tst_test.h    |  2 +-
 lib/tst_cmd.c         | 98 +++++++++++++++++++++++++++++++++++++++++++
 lib/tst_test.c        |  9 ++--
 5 files changed, 121 insertions(+), 5 deletions(-)

diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 939825646..c7e7e56c1 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -5,6 +5,8 @@
 #ifndef TST_CMD_H__
 #define TST_CMD_H__
 
+#include <stdbool.h>
+
 enum tst_cmd_flags {
 	/*
 	 * return the program exit code, otherwise it will call cleanup_fn() if the
@@ -16,6 +18,19 @@ enum tst_cmd_flags {
 	TST_CMD_TCONF_ON_MISSING = 2,
 };
 
+struct tst_cmd {
+	const char *cmd;
+	unsigned int required:1;
+	unsigned int support:1;
+};
+
+
+/*
+ * tst_cmd_present would loop over the tst_cmd array and return the supported flag
+ * value.
+ */
+bool tst_cmd_present(struct tst_cmd *pcmd, const char *cmd);
+
 /*
  * vfork() + execvp() specified program.
  *
diff --git a/include/tst_private.h b/include/tst_private.h
index 4c6479f4b..d549cf968 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -47,4 +47,6 @@ char tst_kconfig_get(const char *confname);
  */
 int tst_check_cmd(const char *cmd, const int brk_nosupp);
 
+int tst_check_needs_cmds(struct tst_cmd *cmd, const int brk_nosupp);
+
 #endif
diff --git a/include/tst_test.h b/include/tst_test.h
index 9c21c1728..8fb7cd86c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -617,7 +617,7 @@ struct tst_fs {
 
 	const struct tst_tag *tags;
 
-	const char *const *needs_cmds;
+	struct tst_cmd *needs_cmds;
 
 	const enum tst_cg_ver needs_cgroup_ver;
 
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 82d60497a..7457d17c4 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -330,3 +330,101 @@ error:
 
 	return 1;
 }
+
+int tst_check_needs_cmds(struct tst_cmd *cmd, const int brk_nosupp)
+{
+	struct version_parser *p;
+	char *cmd_token, *op_token, *version_token, *next, *str;
+	char path[PATH_MAX];
+	char parser_cmd[100];
+	int ver_parser, ver_get;
+
+	strcpy(parser_cmd, cmd->cmd);
+
+	cmd_token = strtok_r(parser_cmd, " ", &next);
+	op_token = strtok_r(NULL, " ", &next);
+	version_token = strtok_r(NULL, " ", &next);
+	str = strtok_r(NULL, " ", &next);
+
+	if (tst_get_path(cmd_token, path, sizeof(path)))
+		if (brk_nosupp)
+			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
+		else
+			goto error;
+
+	if (!op_token)
+		goto pass;
+
+	if (!version_token || str) {
+		tst_brkm(TCONF, NULL,
+			"Illegal format(%s), should use format like mkfs.ext4 >= 1.43.0",
+			cmd->cmd);
+	}
+
+	for (p = &version_parsers[0]; p->cmd; p++) {
+		if (!strcmp(p->cmd, cmd_token)) {
+			tst_resm(TINFO, "Parsing %s version", p->cmd);
+			break;
+		}
+	}
+
+	if (!p->cmd) {
+		tst_brkm(TBROK, NULL, "No version parser for %s implemented!",
+			cmd_token);
+	}
+
+	ver_parser = p->parser();
+	if (ver_parser < 0)
+		tst_brkm(TBROK, NULL, "Failed to parse %s version", p->cmd);
+
+	ver_get = p->table_get(version_token);
+	if (ver_get < 0)
+		tst_brkm(TBROK, NULL, "Failed to get %s version", p->cmd);
+
+	if (!strcmp(op_token, ">=")) {
+		if (ver_parser < ver_get)
+			goto error;
+	} else if (!strcmp(op_token, ">")) {
+		if (ver_parser <= ver_get)
+			goto error;
+	} else if (!strcmp(op_token, "<=")) {
+		if (ver_parser > ver_get)
+			goto error;
+	} else if (!strcmp(op_token, "<")) {
+		if (ver_parser >= ver_get)
+			goto error;
+	} else if (!strcmp(op_token, "==")) {
+		if (ver_parser != ver_get)
+			goto error;
+	} else if (!strcmp(op_token, "!=")) {
+		if (ver_parser == ver_get)
+			goto error;
+	} else {
+		tst_brkm(TCONF, NULL, "Invalid op(%s)", op_token);
+	}
+pass:
+	cmd->support = 1;
+	return 0;
+error:
+	cmd->support = 0;
+	if (brk_nosupp) {
+		tst_brkm(TCONF, NULL, "%s requires %s %d, but got %d",
+			cmd, op_token, ver_get, ver_parser);
+	} else {
+		tst_resm(TCONF, "%s requires %s %d, but got %d",
+			cmd, op_token, ver_get, ver_parser);
+	}
+
+	return 1;
+}
+
+bool tst_cmd_present(struct tst_cmd *pcmd, const char *cmd)
+{
+	while (pcmd->cmd) {
+		if (!strcmp(pcmd->cmd, cmd))
+			return pcmd->support;
+
+		pcmd++;
+	}
+	return false;
+}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8894f782..41519d4e1 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1422,11 +1422,12 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
 
 	if (tst_test->needs_cmds) {
-		const char *cmd;
-		int i;
+		struct tst_cmd *cmd = tst_test->needs_cmds;
 
-		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd, 1);
+		while (cmd->cmd) {
+			tst_check_needs_cmds(cmd,cmd->required);
+			cmd++;
+		}
 	}
 
 	if (tst_test->needs_drivers) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
