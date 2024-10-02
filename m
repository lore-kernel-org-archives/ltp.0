Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01409CF31B8
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 12:23:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6E53C5A79
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:23:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33A6F3C5A13
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:49 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 593BF1009BD3
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 14:22:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 056CC1FD56
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2xt+VWLGaXi7L+/5sj+Tu2pAR7+PZlGhinaQ3QPkLU=;
 b=z03F4kdX2di9SmvQlnLeEvo3svHSZBWjtwdCphzzRGKcqHDbBPTZall5F2GLPE6P+wAhog
 d1m5ZcmNZLThMq0m9OuXEAviZOect1motSKu/mBvqlakd2tdku748mqgTWaqJgkZ6aawKf
 Z2GpAJ43kyFxxsM7XA2FCYCCA0dVOb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2xt+VWLGaXi7L+/5sj+Tu2pAR7+PZlGhinaQ3QPkLU=;
 b=TxZlCs3SaAdqa7XR4oK5g45Eu6CDnCeSM2brTaEOr6S/TLGA/9b9Y2J2JR3twSRCpfZhGL
 9FJ1ivqcguqXyoAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727871767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2xt+VWLGaXi7L+/5sj+Tu2pAR7+PZlGhinaQ3QPkLU=;
 b=z03F4kdX2di9SmvQlnLeEvo3svHSZBWjtwdCphzzRGKcqHDbBPTZall5F2GLPE6P+wAhog
 d1m5ZcmNZLThMq0m9OuXEAviZOect1motSKu/mBvqlakd2tdku748mqgTWaqJgkZ6aawKf
 Z2GpAJ43kyFxxsM7XA2FCYCCA0dVOb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727871767;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2xt+VWLGaXi7L+/5sj+Tu2pAR7+PZlGhinaQ3QPkLU=;
 b=TxZlCs3SaAdqa7XR4oK5g45Eu6CDnCeSM2brTaEOr6S/TLGA/9b9Y2J2JR3twSRCpfZhGL
 9FJ1ivqcguqXyoAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E22C913A97
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 12:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kM5mNRY7/WbICAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 02 Oct 2024 12:22:46 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Oct 2024 14:22:45 +0200
MIME-Version: 1.0
Message-Id: <20241002-ioctl_ficlone01_fix-v3-2-7e077918dfd4@suse.com>
References: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
In-Reply-To: <20241002-ioctl_ficlone01_fix-v3-0-7e077918dfd4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727871766; l=4169;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=6+AFZkXYhnzbJyZqpx83t6ARnzDpH8zz4VeE54USJOw=;
 b=4GNn2BZeeAUjD3M7witVXJ31Hjk/QEQMcqRGLAHI2zAwSTrKPzynnsVWJer8cpe9R8wZCx4QV
 7TKByrFIfTaCiG0CQ1qLv9jHSPcvM75kvjo54PQzXKPJjQdMUa+IPOm
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] Add minimum kernel requirement for FS setup
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

In some cases, a filesystem that is going to be created and mounted
by LTP can't be supported by certain kernel versions. This is the case
of the CoW support: mkfs creates a CoW filesystem, while underlying
kernel can't mount it.

To cover this scenario, a new flag called .min_kver has been
introduced in the tst_fs structure, giving the user a possibility to
filter out certain kernels not supporting certain FS features.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_test.h            |  5 +++++
 lib/tst_test.c                | 27 +++++++++++++++++++++------
 testcases/lib/tst_run_shell.c |  5 +++++
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 38d24f48c..8d1819f74 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -270,6 +270,9 @@ struct tst_ulimit_val {
  *
  * @mnt_data: The data passed to mount(2) when the test library mounts a device
  *            in the case of 'tst_test.mount_device'.
+ *
+ * @min_kver: A minimum kernel version supporting the filesystem which has been
+ *            created with mkfs.
  */
 struct tst_fs {
 	const char *type;
@@ -280,6 +283,8 @@ struct tst_fs {
 
 	unsigned int mnt_flags;
 	const void *mnt_data;
+
+	const char *min_kver;
 };
 
 /**
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 192fee309..fe07c4d98 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -950,20 +950,29 @@ static void do_exit(int ret)
 	exit(ret);
 }
 
-void check_kver(void)
+int check_kver(const char *min_kver, const int brk_nosupp)
 {
+	char *msg;
 	int v1, v2, v3;
 
-	if (tst_parse_kver(tst_test->min_kver, &v1, &v2, &v3)) {
+	if (tst_parse_kver(min_kver, &v1, &v2, &v3)) {
 		tst_res(TWARN,
 			"Invalid kernel version %s, expected %%d.%%d.%%d",
-			tst_test->min_kver);
+			min_kver);
 	}
 
 	if (tst_kvercmp(v1, v2, v3) < 0) {
-		tst_brk(TCONF, "The test requires kernel %s or newer",
-			tst_test->min_kver);
+		msg = "The test requires kernel %s or newer";
+
+		if (brk_nosupp)
+			tst_brk(TCONF, msg, min_kver);
+		else
+			tst_res(TCONF, msg, min_kver);
+
+		return 1;
 	}
+
+	return 0;
 }
 
 static int results_equal(struct results *a, struct results *b)
@@ -1289,7 +1298,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver();
+		check_kver(tst_test->min_kver, 1);
 
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
@@ -1420,6 +1429,9 @@ static void do_setup(int argc, char *argv[])
 			if (tst_test->filesystems->mkfs_ver)
 				ret = tst_check_cmd(tst_test->filesystems->mkfs_ver, 0);
 
+			if (tst_test->filesystems->min_kver)
+				ret = check_kver(tst_test->filesystems->min_kver, 0);
+
 			if (ret)
 				return;
 
@@ -1816,6 +1828,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
 		return TCONF;
 
+	if (fs->min_kver && check_kver(fs->min_kver, 0))
+		return TCONF;
+
 	prepare_device(fs);
 
 	ret = fork_testrun();
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index ee029b666..6b714c51c 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -156,6 +156,7 @@ enum fs_ids {
 	MKFS_VER,
 	MNT_FLAGS,
 	TYPE,
+	FS_MIN_KVER,
 };
 
 static ujson_obj_attr fs_attrs[] = {
@@ -164,6 +165,7 @@ static ujson_obj_attr fs_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
+	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),
 };
 
 static ujson_obj fs_obj = {
@@ -235,6 +237,9 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 			case TYPE:
 				ret[i].type = strdup(val->val_str);
 			break;
+			case FS_MIN_KVER:
+				ret[i].min_kver = strdup(val->val_str);
+			break;
 			}
 
 		}

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
