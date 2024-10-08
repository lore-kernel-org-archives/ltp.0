Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED472CEF15C
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:56:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82A713C1B69
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 13:56:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3544C3C14A2
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:55:45 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5CD7F600FB9
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 13:55:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1968A1FF3A
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728388543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA3fZH7Xb0ZxPkwzqPh58DkVo6mYVJOZajvn86q4JiQ=;
 b=pSHQTB8k3dzAEQ8dmmCv/HsuORu7yX1Bmpv6ML5WBD9t1N5kvrTphZmLWwWsBMEtFnrIuh
 PFhQdzSiMH64kwEpO2odtSsZVg25CDoZ/VxFwok8UoyMY6SajYskOLa8+lHzkMLsycmO4T
 cYv8HsAAhpYvYaXQbPt/rbYyvpxU00I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728388543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA3fZH7Xb0ZxPkwzqPh58DkVo6mYVJOZajvn86q4JiQ=;
 b=8W1qXpsN9FHWBbSVG4qYMA9qp3ax5PhCBWuYOJfCdNjabucKfr+8szm2aWgsfPQ8zpOrk/
 yFzQmyDy/P2q9ZDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728388543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA3fZH7Xb0ZxPkwzqPh58DkVo6mYVJOZajvn86q4JiQ=;
 b=pSHQTB8k3dzAEQ8dmmCv/HsuORu7yX1Bmpv6ML5WBD9t1N5kvrTphZmLWwWsBMEtFnrIuh
 PFhQdzSiMH64kwEpO2odtSsZVg25CDoZ/VxFwok8UoyMY6SajYskOLa8+lHzkMLsycmO4T
 cYv8HsAAhpYvYaXQbPt/rbYyvpxU00I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728388543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA3fZH7Xb0ZxPkwzqPh58DkVo6mYVJOZajvn86q4JiQ=;
 b=8W1qXpsN9FHWBbSVG4qYMA9qp3ax5PhCBWuYOJfCdNjabucKfr+8szm2aWgsfPQ8zpOrk/
 yFzQmyDy/P2q9ZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFDD11340C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAa8LL4dBWf4aQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 11:55:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 13:55:38 +0200
MIME-Version: 1.0
Message-Id: <20241008-ioctl_ficlone01_fix-v4-1-eae3adac33c9@suse.com>
References: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
In-Reply-To: <20241008-ioctl_ficlone01_fix-v4-0-eae3adac33c9@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728388542; l=8779;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Vp2gw3rkKeY+Wi3EjT31c+j62ytAyfoI8fe8miNj228=;
 b=mY/Lxofb13eDRm8Q/kcUrTAj2sLC+SdX0TLSKXGaP4b9F7BmDRU1DpI0kw22gZG3NNJTAl1Jm
 lgQOR6+TMeDC+WTKaxHST176SfUENhqH7YqvhQfngWpgRd9qC0rL2iF
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] Filter mkfs version in tst_fs
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_private.h         |   6 +--
 include/tst_test.h            |   4 ++
 lib/tst_cmd.c                 | 109 +++++++++++++++++++++++++++---------------
 lib/tst_test.c                |  14 ++++--
 testcases/lib/tst_run_shell.c |   5 ++
 5 files changed, 93 insertions(+), 45 deletions(-)

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
index b3f8a95ab..2f6ae3ec3 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -210,7 +210,7 @@ static int mkfs_ext4_version_parser(void)
 	return major * 10000 +  minor * 100 + patch;
 }
 
-static int mkfs_ext4_version_table_get(char *version)
+static int mkfs_generic_version_table_get(char *version)
 {
 	int major, minor, patch;
 	int len;
@@ -228,19 +228,42 @@ static int mkfs_ext4_version_table_get(char *version)
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
+	char *op_msg = NULL;
 	char path[PATH_MAX];
 	char parser_cmd[100];
 	int ver_parser, ver_get;
@@ -257,7 +280,7 @@ void tst_check_cmd(const char *cmd)
 		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
 
 	if (!op_token)
-		return;
+		goto error;
 
 	if (!strcmp(op_token, ">="))
 		op_flag = OP_GE;
@@ -302,46 +325,54 @@ void tst_check_cmd(const char *cmd)
 
 	switch (op_flag) {
 	case OP_GE:
-		if (ver_parser < ver_get) {
-			tst_brkm(TCONF, NULL, "%s required >= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
+		if (ver_parser >= ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
 	case OP_GT:
-		if (ver_parser <= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required > %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
+		if (ver_parser > ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
 	case OP_LE:
-		if (ver_parser > ver_get) {
-			tst_brkm(TCONF, NULL, "%s required <= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
+		if (ver_parser <= ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
 	case OP_LT:
-		if (ver_parser >= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required < %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
+		if (ver_parser < ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
 	case OP_EQ:
-		if (ver_parser != ver_get) {
-			tst_brkm(TCONF, NULL, "%s required == %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
-		}
-		break;
+		if (ver_parser == ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
 	case OP_NE:
-		if (ver_parser == ver_get) {
-			tst_brkm(TCONF, NULL, "%s required != %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser != ver_get)
+			break;
+
+		op_msg = op_token;
+		goto error;
+	}
+
+	return 0;
+error:
+	if (op_msg) {
+		if (brk_nosupp) {
+			tst_brkm(TCONF, NULL, "%s requires %s %d, but got %d",
+				cmd, op_msg, ver_get, ver_parser);
+		} else {
+			tst_resm(TCONF, "%s requires %s %d, but got %d",
+				cmd, op_msg, ver_get, ver_parser);
 		}
-		break;
 	}
+
+	return 1;
 }
diff --git a/lib/tst_test.c b/lib/tst_test.c
index d226157e0..4f4a53080 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1250,6 +1250,7 @@ static const char *default_fs_type(void)
 static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
+	int ret = 0;
 
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
@@ -1310,7 +1311,7 @@ static void do_setup(int argc, char *argv[])
 		int i;
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd);
+			tst_check_cmd(cmd, 1);
 	}
 
 	if (tst_test->needs_drivers) {
@@ -1415,8 +1416,12 @@ static void do_setup(int argc, char *argv[])
 
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
@@ -1805,6 +1810,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	tst_res(TINFO, "=== Testing on %s ===", fs_type);
 	tdev.fs_type = fs_type;
 
+	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
+		return TCONF;
+
 	prepare_device(fs);
 
 	ret = fork_testrun();
@@ -1832,7 +1840,7 @@ static int run_tcases_per_fs(void)
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
