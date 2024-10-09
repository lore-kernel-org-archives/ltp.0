Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C4CCEDD99
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B4783C31A4
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 16:03:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F4493C3100
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F21F510122B5
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 16:03:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E9EB21ABE;
 Wed,  9 Oct 2024 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rqQ08MeNm0U3dfHuq2plInYcF7/AdVjM7luMK3C4tU=;
 b=tCw3QyB4758Yv8ujqDcHfEy/nbx99BMcfz1NstFZSgLlYzrXr4v2eIFG1QuTjLiYaTc9J9
 qCp92Nbg8BM7fy26Bdul2ixPRYsEZ++2JQacxPfalb4S+wIwsqgDSdCr4s4HSN69ajlbtG
 1NVUFJie8rtS4hWpFF8AIX8BGA+cJxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rqQ08MeNm0U3dfHuq2plInYcF7/AdVjM7luMK3C4tU=;
 b=h0CbLUMgvrTPQrt7YqcAs8mYbq54PmBr45PEwubo+fcO/NejTQ52/yGwX9XoANOcgGd7pk
 nNyVesWYZ58B9MAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ou4w619w;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=abfKxyL4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728482583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rqQ08MeNm0U3dfHuq2plInYcF7/AdVjM7luMK3C4tU=;
 b=Ou4w619wRf53Tb5Q8wUQbGuROMSlKreCbP5aybCLTb0gR+7uyiqSr+qGQ2yI2OVW9AX4PY
 rveyX8jeW4T3dvOFXnyPWeIS6pS6yWfFTVolG9Jnk6UUHKyKXPkmlkRqAmSDXQk1Sfdr8g
 bdNteXqcPx8tacPoTg45Z7WI20pJ8HY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728482583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rqQ08MeNm0U3dfHuq2plInYcF7/AdVjM7luMK3C4tU=;
 b=abfKxyL4POkMtzq86iG/nxwkl/fysD4JkStJNXBacbp0LLdaQ4NLJ7HiClk6kVDNUnNIAK
 e0HdoUjNvIO5sFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30FAD13A58;
 Wed,  9 Oct 2024 14:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IANzIxWNBmcIPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 14:03:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 16:02:41 +0200
MIME-Version: 1.0
Message-Id: <20241009-ioctl_ficlone01_fix-v5-2-943238be9923@suse.com>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
In-Reply-To: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728482574; l=4278;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Rj9aUj/UYdrtnL40m2rhm/S27dPPc3jH8UjZjvxGspU=;
 b=kfaCTMPjneZGYKztb0XsBDKPk8M1KcbhxkMeIVysX9m60hlRFKfG/ly14K1L+Gr+DHcPGWBYb
 vEnoLfjoO3NCNfFDiYI6ypgX00PqEZXzwvzT0UvzOBRvARXsT+XuN38
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 6E9EB21ABE
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_arch.name:url,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] Add minimum kernel requirement for FS setup
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
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
index 9015f28e3..8d205a42f 100644
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
@@ -1288,7 +1297,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver();
+		check_kver(tst_test->min_kver, 1);
 
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
@@ -1419,6 +1428,9 @@ static void do_setup(int argc, char *argv[])
 			if (tst_test->filesystems->mkfs_ver)
 				tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);
 
+			if (tst_test->filesystems->min_kver)
+				check_kver(tst_test->filesystems->min_kver, 1);
+
 			prepare_device(tst_test->filesystems);
 		}
 	}
@@ -1812,6 +1824,9 @@ static int run_tcase_on_fs(struct tst_fs *fs, const char *fs_type)
 	if (fs->mkfs_ver && tst_check_cmd(fs->mkfs_ver, 0))
 		return TCONF;
 
+	if (fs->min_kver && check_kver(fs->min_kver, 0))
+		return TCONF;
+
 	prepare_device(fs);
 
 	ret = fork_testrun();
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index ee029b666..95cac0d60 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -151,6 +151,7 @@ static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
 }
 
 enum fs_ids {
+	FS_MIN_KVER,
 	MKFS_OPTS,
 	MKFS_SIZE_OPT,
 	MKFS_VER,
@@ -159,6 +160,7 @@ enum fs_ids {
 };
 
 static ujson_obj_attr fs_attrs[] = {
+	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
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
