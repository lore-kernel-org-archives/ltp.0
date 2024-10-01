Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AEACEACC1
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 13:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D13563C591E
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 15:53:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6AB3C58E2
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:17 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04EC1601A02
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B6C321B0E
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=029gJfA2ENCRSwlF0enL829tCA3gaMVNzJGlbBDOGa4=;
 b=AkBLgn6zhUMYqfmEcVAOFy3odmkbnwBCL2eDpywtu85EbQOgWR3ClNlizbqVpVhbLnS7kq
 OC74xNdXa7yS22VKuClDHIwFokI5/nKdQjYQ5xFuY3pes2jeKgH6kpkLnddT9e5f8ytuws
 cRtoY+mcQoCbaUIcQRHjOTUAsaq0Kd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=029gJfA2ENCRSwlF0enL829tCA3gaMVNzJGlbBDOGa4=;
 b=qOJX24jqDQ9owai+a6NeGin1tyJH2VXRDIxZeEVd5MGxeiRRj/GJbydaJ84Shz2oDLUPLB
 fg/i9/BrdOrXdmBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AkBLgn6z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qOJX24jq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=029gJfA2ENCRSwlF0enL829tCA3gaMVNzJGlbBDOGa4=;
 b=AkBLgn6zhUMYqfmEcVAOFy3odmkbnwBCL2eDpywtu85EbQOgWR3ClNlizbqVpVhbLnS7kq
 OC74xNdXa7yS22VKuClDHIwFokI5/nKdQjYQ5xFuY3pes2jeKgH6kpkLnddT9e5f8ytuws
 cRtoY+mcQoCbaUIcQRHjOTUAsaq0Kd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=029gJfA2ENCRSwlF0enL829tCA3gaMVNzJGlbBDOGa4=;
 b=qOJX24jqDQ9owai+a6NeGin1tyJH2VXRDIxZeEVd5MGxeiRRj/GJbydaJ84Shz2oDLUPLB
 fg/i9/BrdOrXdmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64E8A13A73
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kPxaE4/++2bJFQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 01 Oct 2024 13:52:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 01 Oct 2024 15:52:03 +0200
MIME-Version: 1.0
Message-Id: <20241001-ioctl_ficlone01_fix-v2-1-dd0b021dd31d@suse.com>
References: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
In-Reply-To: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727790735; l=8800;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=YoxIK26qGQ2N6+hbYjAOF8MGIAfz/Weg0Zi1B2kaRu0=;
 b=AvahPtwOzsQqXTenVorjkcrEnc64WeHtZLZEQVQF6KL32SqeOhPy9d03dNLYYhEDLsEMBQxPx
 kEO2b6eH0YaCPFxtVBMOWayPUXDaUEAMx5Uju7YHUt2n38JPjfZjK2l
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 7B6C321B0E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/3] Filter mkfs version in tst_fs
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
 include/tst_private.h         |   6 +-
 include/tst_test.h            |   4 ++
 lib/tst_cmd.c                 | 130 +++++++++++++++++++++++++++++++++---------
 lib/tst_test.c                |   5 +-
 testcases/lib/tst_run_shell.c |   5 ++
 5 files changed, 119 insertions(+), 31 deletions(-)

diff --git a/include/tst_private.h b/include/tst_private.h
index 6f4f39b15..a29f2d1c1 100644
--- a/include/tst_private.h
+++ b/include/tst_private.h
@@ -40,11 +40,11 @@ char tst_kconfig_get(const char *confname);
 
 /*
  * If cmd argument is a single command, this function just checks command
- * whether exists. If not, case skips.
+ * whether exists. If not, case breaks unless skip_on_error is defined.
  * If cmd argument is a complex string ie 'mkfs.ext4 >= 1.43.0', this
  * function checks command version whether meets this requirement.
- * If not, case skips.
+ * If not, case breaks unless skip_on_error is defined.
  */
-void tst_check_cmd(const char *cmd);
+void tst_check_cmd(const char *cmd, const int skip_on_error);
 
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
index b3f8a95ab..35dd71253 100644
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
+void tst_check_cmd(const char *cmd, const int skip_on_error)
 {
 	struct version_parser *p;
 	char *cmd_token, *op_token, *version_token, *next, *str;
+	char *check_msg;
 	char path[PATH_MAX];
 	char parser_cmd[100];
 	int ver_parser, ver_get;
@@ -302,45 +325,98 @@ void tst_check_cmd(const char *cmd)
 
 	switch (op_flag) {
 	case OP_GE:
-		if (ver_parser < ver_get) {
-			tst_brkm(TCONF, NULL, "%s required >= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser >= ver_get)
+			break;
+
+		check_msg = "%s required >= %d, but got %d, "
+			"the version is required in order run the test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	case OP_GT:
-		if (ver_parser <= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required > %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser > ver_get)
+			break;
+
+		check_msg = "%s required > %d, but got %d, "
+			"the version is required in order run the "
+			"test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	case OP_LE:
-		if (ver_parser > ver_get) {
-			tst_brkm(TCONF, NULL, "%s required <= %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser <= ver_get)
+			break;
+
+		check_msg = "%s required <= %d, but got %d, "
+			"the version is required in order run the "
+			"test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	case OP_LT:
-		if (ver_parser >= ver_get) {
-			tst_brkm(TCONF, NULL, "%s required < %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser < ver_get)
+			break;
+
+		check_msg = "%s required < %d, but got %d, "
+			"the version is required in order run the "
+			"test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	case OP_EQ:
-		if (ver_parser != ver_get) {
-			tst_brkm(TCONF, NULL, "%s required == %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser == ver_get)
+			break;
+
+		check_msg = "%s required == %d, but got %d, "
+			"the version is required in order run the "
+			"test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	case OP_NE:
-		if (ver_parser == ver_get) {
-			tst_brkm(TCONF, NULL, "%s required != %d, but got %d, "
-				"the version is required in order run the test.",
-				cmd, ver_get, ver_parser);
+		if (ver_parser != ver_get)
+			break;
+
+		check_msg = "%s required != %d, but got %d, "
+			"the version is required in order run the "
+			"test.";
+
+		if (skip_on_error) {
+			tst_resm(TCONF, check_msg, cmd, ver_get,
+				ver_parser);
+		} else {
+			tst_brkm(TCONF, NULL, check_msg, cmd, ver_get,
+				ver_parser);
 		}
 		break;
 	}
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 918bee2a1..7dfab4677 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1154,6 +1154,9 @@ static void prepare_device(struct tst_fs *fs)
 
 	const char *const extra[] = {fs->mkfs_size_opt, NULL};
 
+	if (fs->mkfs_ver)
+		tst_check_cmd(fs->mkfs_ver, 1);
+
 	if (tst_test->format_device)
 		SAFE_MKFS(tdev.dev, tdev.fs_type, fs->mkfs_opts, extra);
 
@@ -1306,7 +1309,7 @@ static void do_setup(int argc, char *argv[])
 		int i;
 
 		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
-			tst_check_cmd(cmd);
+			tst_check_cmd(cmd, 0);
 	}
 
 	if (tst_test->needs_drivers) {
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 8ed0f21b6..fbfbe16a7 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -153,12 +153,14 @@ static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
 enum fs_ids {
 	MKFS_OPTS,
 	MKFS_SIZE_OPT,
+	MKFS_VER,
 	MNT_FLAGS,
 	TYPE,
 };
 
 static ujson_obj_attr fs_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
+	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
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
