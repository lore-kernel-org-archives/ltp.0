Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221AACEACC2
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 13:52:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB04C3C5916
	for <ltp@archiver.kernel.org>; Tue,  1 Oct 2024 15:52:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C8823C58FD
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:16 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 654B5601FAC
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 15:52:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9D7EA1F871
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ael/qui1oWyJ6VmkKG1qWENqzlUjM7kj0WjhhK1X9sE=;
 b=GOsyZjZlgp5nIz/WzlzRNXyHjXK6icC5udz2fyG513K9bxDKkffDu25tdR3QvvNFC21B/T
 1ECuvi03vp7jeVntjPyk8YEr8JbcNIeklIrlhnhHPVMlcJmLtQUOe0nyRkiKTUARcqeRhN
 HK5Sa6qiJD92RYfoGOGop9KGi/liDqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ael/qui1oWyJ6VmkKG1qWENqzlUjM7kj0WjhhK1X9sE=;
 b=rNSiJxIYhBsRH8OyHSlzGNTEvOEptduFmTP8lODFytlkr7QjHm0jOKeqoKdiu16j+bu+23
 YCmetgVR3OWJ6OAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GOsyZjZl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rNSiJxIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1727790735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ael/qui1oWyJ6VmkKG1qWENqzlUjM7kj0WjhhK1X9sE=;
 b=GOsyZjZlgp5nIz/WzlzRNXyHjXK6icC5udz2fyG513K9bxDKkffDu25tdR3QvvNFC21B/T
 1ECuvi03vp7jeVntjPyk8YEr8JbcNIeklIrlhnhHPVMlcJmLtQUOe0nyRkiKTUARcqeRhN
 HK5Sa6qiJD92RYfoGOGop9KGi/liDqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1727790735;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ael/qui1oWyJ6VmkKG1qWENqzlUjM7kj0WjhhK1X9sE=;
 b=rNSiJxIYhBsRH8OyHSlzGNTEvOEptduFmTP8lODFytlkr7QjHm0jOKeqoKdiu16j+bu+23
 YCmetgVR3OWJ6OAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85A8113A8A
 for <ltp@lists.linux.it>; Tue,  1 Oct 2024 13:52:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eBa8Ho/++2bJFQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 01 Oct 2024 13:52:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 01 Oct 2024 15:52:04 +0200
MIME-Version: 1.0
Message-Id: <20241001-ioctl_ficlone01_fix-v2-2-dd0b021dd31d@suse.com>
References: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
In-Reply-To: <20241001-ioctl_ficlone01_fix-v2-0-dd0b021dd31d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727790735; l=3794;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=JZZ8UUytlukiy53yEQrGuvt+zszSlFZlrDeDJiQGiec=;
 b=BRg6uUfzNppuL2/vnrvY2Lp93bbT6Ibnystwm/p2b9hdUhQXFsi3PGn+JTRf6BUE66iP+IHEL
 1RFoWILopgHBXgK25565km0WQW//Jm+yC1FQhYGrlZfUHM/58eDxlKc
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 9D7EA1F871
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] Add minimum kernel requirement for FS setup
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
 lib/tst_test.c                | 20 ++++++++++++++------
 testcases/lib/tst_run_shell.c |  5 +++++
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 38d24f48c..ac3ee66af 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -270,6 +270,9 @@ struct tst_ulimit_val {
  *
  * @mnt_data: The data passed to mount(2) when the test library mounts a device
  *            in the case of 'tst_test.mount_device'.
+ *
+ * @min_kver: minimum kernel version supporting the filesystem which has been
+ *		created with mkfs.
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
index 7dfab4677..49a46fc7b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -946,19 +946,24 @@ static void do_exit(int ret)
 	exit(ret);
 }
 
-void check_kver(void)
+void check_kver(const char *min_kver, const int skip)
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
+		if (skip)
+			tst_res(TCONF, msg, min_kver);
+		else
+			tst_brk(TCONF, msg, min_kver);
 	}
 }
 
@@ -1150,6 +1155,9 @@ static void prepare_device(struct tst_fs *fs)
 	char buf[1024];
 	struct tst_fs dummy = {};
 
+	if (fs->min_kver)
+		check_kver(fs->min_kver, 1);
+
 	fs = fs ?: &dummy;
 
 	const char *const extra[] = {fs->mkfs_size_opt, NULL};
@@ -1287,7 +1295,7 @@ static void do_setup(int argc, char *argv[])
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
-		check_kver();
+		check_kver(tst_test->min_kver, 0);
 
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index fbfbe16a7..dc840782a 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -155,6 +155,7 @@ enum fs_ids {
 	MKFS_SIZE_OPT,
 	MKFS_VER,
 	MNT_FLAGS,
+	FS_MIN_KVER,
 	TYPE,
 };
 
@@ -163,6 +164,7 @@ static ujson_obj_attr fs_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(MKFS_VER, "mkfs_ver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
+	UJSON_OBJ_ATTR_IDX(FS_MIN_KVER, "min_kver", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
 };
 
@@ -229,6 +231,9 @@ static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
 			case MKFS_VER:
 				ret[i].mkfs_ver = strdup(val->val_str);
 			break;
+			case FS_MIN_KVER:
+				ret[i].min_kver = strdup(val->val_str);
+			break;
 			case MNT_FLAGS:
 				ret[i].mnt_flags = parse_mnt_flags(reader, val);
 			break;

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
