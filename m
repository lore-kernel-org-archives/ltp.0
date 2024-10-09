Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A4CEDD97
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:03:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDED93C4AE2
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 16:03:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E4163C3153
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:03 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C6ED610235
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 720F621ABE;
 Wed,  9 Oct 2024 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMOjgmm3XTEf7JZUsRdWVKl53c18u/DE9wyeoR9o1Y4=;
 b=yxDqTB9eF0lRQeksd2xOopL8wT9jbbWU/jzg/FY6BzEsTbbK6O3LuQeusrBO6BsaTAQlip
 jYq2hn0RmJ5vmITAoYX8X5uf90BDp35ExmdduOpFtr9LFozhWZlBkkT+mJs1RfdSbr36Ls
 5MGzFp5WtR2j32hSo8IK9PySrPc9cmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMOjgmm3XTEf7JZUsRdWVKl53c18u/DE9wyeoR9o1Y4=;
 b=A/c+cdMpJ8iUR0lvzdXIh6FzX1rUqHDC0zrbLCIL0e1FworaKR9eIZX3u3OGocXy8YfU4V
 pLSqV2kg7XU7wABQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yxDqTB9e;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="A/c+cdMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMOjgmm3XTEf7JZUsRdWVKl53c18u/DE9wyeoR9o1Y4=;
 b=yxDqTB9eF0lRQeksd2xOopL8wT9jbbWU/jzg/FY6BzEsTbbK6O3LuQeusrBO6BsaTAQlip
 jYq2hn0RmJ5vmITAoYX8X5uf90BDp35ExmdduOpFtr9LFozhWZlBkkT+mJs1RfdSbr36Ls
 5MGzFp5WtR2j32hSo8IK9PySrPc9cmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482580;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WMOjgmm3XTEf7JZUsRdWVKl53c18u/DE9wyeoR9o1Y4=;
 b=A/c+cdMpJ8iUR0lvzdXIh6FzX1rUqHDC0zrbLCIL0e1FworaKR9eIZX3u3OGocXy8YfU4V
 pLSqV2kg7XU7wABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C8C413A58;
 Wed,  9 Oct 2024 14:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kMP1GhGNBmcIPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 14:02:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 16:02:40 +0200
MIME-Version: 1.0
Message-Id: <20241009-ioctl_ficlone01_fix-v5-1-943238be9923@suse.com>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
In-Reply-To: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728482574; l=9538;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=bA0VXv1Qd0FofAopoQmALhpEMKAYClmkuUSIdwB2N+o=;
 b=gIyfEp2wIr8m2LnQjjd477IO6wVBtdg4L8by6by1XRk2AmY8CHAqVHEywavPSab5ZLbFO+sqh
 tkFmhYlQo+yDfiYnmub9IyRhrw+WFLBw/yTpGh+aonsW9GpNCCYkQWr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 720F621ABE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/3] Filter mkfs version in tst_fs
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Introduce mkfs_ver attribute in the tst_fs declaration, in order to
filter specific mkfs.* tools versions.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_private.h         |   6 +-
 include/tst_test.h            |   4 ++
 lib/tst_cmd.c                 | 131 +++++++++++++++++++-----------------------
 lib/tst_test.c                |  13 ++++-
 testcases/lib/tst_run_shell.c |   5 ++
 5 files changed, 80 insertions(+), 79 deletions(-)

diff --git a/include/tst_private.h b/include/tst_private.h
index 6f4f39b15..4c6479f4b 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -40,11 +40,11 @@ char tst_kconfig_get(const char *confname);
 
 /*
  * If cmd argument is a single command, this function just checks command
- * whether exists. If not, case skips.
+ * whether exists. If not, case breaks if brk_nosupp is defined.
  * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
  * function checks command version whether meets this requirement.
- * If not, case skips.
+ * If not, case breaks if brk_nosupp is defined.
  */
-void tst_check_cmd(const char *cmd);
+int tst_check_cmd(const char *cmd, const int brk_nosupp);
 
 #endif
diff --git a/include/tst_test.h b/include/tst_test.h
index d0fa84a71..38d24f48c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -262,6 +262,9 @@ struct tst_ulimit_val {
  *                 passed to mkfs after the device path and can be used to
  *                 limit the file system not to use the whole block device.
  *
+ * @mkfs_ver: mkfs tool version. The string format supports relational
+ *            operators such as < > <= >= ==.
+ *
  * @mnt_flags: MS_* flags passed to mount(2) when the test library mounts a
  *             device in the case of 'tst_test.mount_device'.
  *
@@ -273,6 +276,7 @@ struct tst_fs {
 
 	const char *const *mkfs_opts;
 	const char *mkfs_size_opt;
+	const char *mkfs_ver;
 
 	unsigned int mnt_flags;
 	const void *mnt_data;
diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index b3f8a95ab..82d60497a 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -34,16 +34,6 @@
 #define OPEN_MODE	(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
 #define OPEN_FLAGS	(O_WRONLY | O_APPEND | O_CREAT)
 
-enum cmd_op {
-	OP_GE, /* >= */
-	OP_GT, /* >  */
-	OP_LE, /* <= */
-	OP_LT, /* <  */
-	OP_EQ, /* == */
-	OP_NE, /* != */
-};
-
-
 int tst_cmd_fds_(void (cleanup_fn)(void),
 		const char *const argv[],
 		int stdout_fd,
@@ -210,7 +200,7 @@ static int mkfs_ext4_version_parser(void)
 	return major * 10000 +  minor * 100 + patch;
 }
 
-static int mkfs_ext4_version_table_get(char *version)
+static int mkfs_generic_version_table_get(char *version)
 {
 	int major, minor, patch;
 	int len;
@@ -228,23 +218,44 @@ static int mkfs_ext4_version_table_get(char *version)
 	return major * 10000 + minor * 100 + patch;
 }
 
+static int mkfs_xfs_version_parser(void)
+{
+	FILE *f;
+	int rc, major, minor, patch;
+
+	f = popen("mkfs.xfs -V 2>&1", "r");
+	if (!f) {
+		tst_resm(TWARN, "Could not run mkfs.xfs -V 2>&1 cmd");
+		return -1;
+	}
+
+	rc = fscanf(f, "mkfs.xfs version %d.%d.%d", &major, &minor, &patch);
+	pclose(f);
+	if (rc != 3) {
+		tst_resm(TWARN, "Unable to parse mkfs.xfs version");
+		return -1;
+	}
+
+	return major * 10000 +  minor * 100 + patch;
+}
+
 static struct version_parser {
 	const char *cmd;
 	int (*parser)(void);
 	int (*table_get)(char *version);
 } version_parsers[] = {
-	{"mkfs.ext4", mkfs_ext4_version_parser, mkfs_ext4_version_table_get},
+	{"mkfs.ext4", mkfs_ext4_version_parser, mkfs_generic_version_table_get},
+	{"mkfs.xfs", mkfs_xfs_version_parser, mkfs_generic_version_table_get},
 	{},
 };
 
-void tst_check_cmd(const char *cmd)
+int tst_check_cmd(const char *cmd, const int brk_nosupp)
 {
 	struct version_parser *p;
 	char *cmd_token, *op_token, *version_token, *next, *str;
 	char path[PATH_MAX];
 	char parser_cmd[100];
 	int ver_parser, ver_get;
-	int op_flag = 0;
 
 	strcpy(parser_cmd, cmd);
 
@@ -257,22 +268,7 @@ void tst_check_cmd(const char *cmd)
 		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
 
 	if (!op_token)
-		return;
-
-	if (!strcmp(op_token, ">="))
-		op_flag = OP_GE;
-	else if (!strcmp(op_token, ">"))
-		op_flag = OP_GT;
-	else if (!strcmp(op_token, "<="))
-		op_flag = OP_LE;
-	else if (!strcmp(op_token, "<"))
-		op_flag = OP_LT;
-	else if (!strcmp(op_token, "=="))
-		op_flag = OP_EQ;
-	else if (!strcmp(op_token, "!="))
-		op_flag = OP_NE;
-	else
-		tst_brkm(TCONF, NULL, "Invalid op(%s)", op_token);
+		return 0;
 
 	if (!version_token || str) {
 		tst_brkm(TCONF, NULL,
@@ -300,48 +296,37 @@ void tst_check_cmd(const char *cmd)
 	if (ver_get < 0)
 		tst_brkm(TBROK, NULL, "Failed to get %s version", p->cmd);
 
-	switch (op_flag) {
-	case OP_GE:
-		if (ver_parser < ver_get) {
-			tst_brkm(TCONF, NULL, "%s required >= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
-	case OP_GT:
-		if (ver_parser <= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required > %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
-	case OP_LE:
-		if (ver_parser > ver_get) {
-			tst_brkm(TCONF, NULL, "%s required <= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
-	case OP_LT:
-		if (ver_parser >= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required < %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
-	case OP_EQ:
-		if (ver_parser != ver_get) {
-			tst_brkm(TCONF, NULL, "%s required == %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
-	case OP_NE:
-		if (ver_parser == ver_get) {
-			tst_brkm(TCONF, NULL, "%s required != %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
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
 	}
+
+	return 0;
+error:
+	if (brk_nosupp) {
+		tst_brkm(TCONF, NULL, "%s requires %s %d, but got %d",
+			cmd, op_token, ver_get, ver_parser);
+	} else {
+		tst_resm(TCONF, "%s requires %s %d, but got %d",
+			cmd, op_token, ver_get, ver_parser);
+	}
+
+	return 1;
 }
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d226157e0..9015f28e3 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1310,7 +1310,7 @@ static void do_setup(int argc, char *argv[])
 		int i;
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd);
+			tst_check_cmd(cmd, 1);
 	}
 
 	if (tst_test->needs_drivers) {
@@ -1415,8 +1415,12 @@ static void do_setup(int argc, char *argv[])
 
 		tdev.fs_type = default_fs_type();
 
-		if (!tst_test->all_filesystems && count_fs_descs() <= 1)
+		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
+			if (tst_test->filesystems->mkfs_ver)
+				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
+
 			prepare_device(tst_test->filesystems);
+		}
 	}
 
 	if (tst_test->needs_overlay && !tst_test->mount_device)
@@ -1805,6 +1809,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	tst_res(TINFO, "=== Testing on %s ===", fs_type);
 	tdev.fs_type = fs_type;
 
+	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
+		return TCONF;
+
 	prepare_device(fs);
 
 	ret = fork_testrun();
@@ -1832,7 +1839,7 @@ static int run_tcases_per_fs(void)
 		if (!fs)
 			continue;
 
-		run_tcase_on_fs(fs, filesystems[i]);
+		ret = run_tcase_on_fs(fs, filesystems[i]);
 
 		if (ret == TCONF)
 			continue;
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 8ed0f21b6..ee029b666 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -153,6 +153,7 @@ static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
 enum fs_ids {
 	MKFS_OPTS,
 	MKFS_SIZE_OPT,
+	MKFS_VER,
 	MNT_FLAGS,
 	TYPE,
 };
@@ -160,6 +161,7 @@ enum fs_ids {
 static ujson_obj_attr fs_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
+	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
 };
@@ -224,6 +226,9 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 			case MKFS_SIZE_OPT:
 				ret[i].mkfs_size_opt = strdup(val->val_str);
 			break;
+			case MKFS_VER:
+				ret[i].mkfs_ver = strdup(val->val_str);
+			break;
 			case MNT_FLAGS:
 				ret[i].mnt_flags = parse_mnt_flags(reader, val);
 			break;

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
