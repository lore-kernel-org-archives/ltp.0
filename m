Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02C1C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD4FF3C7951
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:50:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CD083C6CD7
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFC09140099E
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B727D82F6C
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmeKTCwgquhd66A19fVeGRIGTlP1rzrCjcFGgJ76lHk=;
 b=3dqD1KXhD2cGKaEXwMd7/At0YD29OMQBGrIQItMchioJXEOT27YxshwN0YsAC7XKnmaTr+
 lBla/ZKfvKwsdXLGDhuJxkHXcv6lrSFT1ZtwdeZYmX1vWldpHhbOuC8AooIGPkb7yGoQgp
 fZMNNWTihrBNtUiu+RAySPvHu/xuveM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmeKTCwgquhd66A19fVeGRIGTlP1rzrCjcFGgJ76lHk=;
 b=GkZzga074PHWXNpw98xyK2LJcLtu3mK33ye0OKh3l3VNdDqM+0L8wS6Hywb2k2EyU2QesN
 bjHIf8G9pNQ8UqCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yo25JmlO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="M0U/jbQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmeKTCwgquhd66A19fVeGRIGTlP1rzrCjcFGgJ76lHk=;
 b=yo25JmlOihR50QBJk9dAiqOFPvyjZQ01Prbblpz5P4sGF4OFW7sy0t2pEW8novFoN9B/JA
 bBn2tidWKIMEsoaRgmax+6QdGBrXL2HYxkVirF04RDf+7Sjab5jzyxXnD4K91uqDlAYfWG
 sg+qeV6MUCfTXHcHw5mwokWtvlkEFSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmeKTCwgquhd66A19fVeGRIGTlP1rzrCjcFGgJ76lHk=;
 b=M0U/jbQAilLSGMf3uWXeAwHwfMRkGzArrJUn5Rg11oPl8phyYnUVnCMQkY0C3+rReOu8qU
 xiK1Hgfrc3AQ3UBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C080783AD
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kN52JOkOf2rlKgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Aug 2026 14:49:36 +0200
Message-ID: <20260814124943.36853-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814124943.36853-1-mdoucha@suse.cz>
References: <20260814124943.36853-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B727D82F6C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] struct tst_fs: Add flag for checking filesystem
 mount support in kernel
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

Add flag for skipping filesystem if mount() fails with EOPNOTSUPP. This
error usually happens when special mkfs options are not supported
by the kernel.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/old/tso_safe_macros.h |  2 +-
 include/safe_macros_fn.h      |  2 +-
 include/tst_safe_macros.h     |  7 ++++---
 include/tst_test.h            |  4 ++++
 lib/safe_macros.c             | 14 ++++++++++----
 lib/tst_test.c                |  3 ++-
 6 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/old/tso_safe_macros.h b/include/old/tso_safe_macros.h
index f3965cc68..fec31e666 100644
--- a/include/old/tso_safe_macros.h
+++ b/include/old/tso_safe_macros.h
@@ -154,7 +154,7 @@
 #define SAFE_MOUNT(cleanup_fn, source, target, filesystemtype, \
 		   mountflags, data) \
 	safe_mount(__FILE__, __LINE__, (cleanup_fn), (source), (target), \
-		   (filesystemtype), (mountflags), (data), NULL)
+		   (filesystemtype), (mountflags), (data), NULL, 0)
 
 #define SAFE_UMOUNT(cleanup_fn, target) \
 	safe_umount(__FILE__, __LINE__, (cleanup_fn), (target))
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index e8dc02539..f01378b0a 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -187,7 +187,7 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *source, const char *target,
 	       const char *filesystemtype, unsigned long mountflags,
-	       const void *data, int *is_fuse);
+	       const void *data, int *is_fuse, unsigned int check_support);
 
 int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 		const char *target);
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 91a130a48..55ca2bf8b 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -245,12 +245,13 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 #define SAFE_MOUNT(source, target, filesystemtype, \
 		   mountflags, data) \
 	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
-		   (filesystemtype), (mountflags), (data), NULL)
+		   (filesystemtype), (mountflags), (data), NULL, 0)
 
 #define SAFE_MOUNT2(source, target, filesystemtype, \
-		    mountflags, data, is_fuse) \
+		    mountflags, data, is_fuse, check_support) \
 	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
-		   (filesystemtype), (mountflags), (data), (is_fuse))
+		   (filesystemtype), (mountflags), (data), (is_fuse), \
+		   (check_support))
 
 #define SAFE_UMOUNT(target) \
 	safe_umount(__FILE__, __LINE__, NULL, (target))
diff --git a/include/tst_test.h b/include/tst_test.h
index c69362485..d3de042db 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -280,6 +280,8 @@ struct tst_ulimit_val {
  *
  * @min_kver: A minimum kernel version supporting the filesystem which has been
  *            created with mkfs.
+ *
+ * @mount_check_support: Skip this filesystem if mount() fails with EOPNOTSUPP.
  */
 struct tst_fs {
 	const char *type;
@@ -292,6 +294,8 @@ struct tst_fs {
 	const void *mnt_data;
 
 	const char *min_kver;
+
+	unsigned int mount_check_support:1;
 };
 
 /**
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index f95c5fdc5..187550041 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -930,7 +930,7 @@ static int possibly_fuse(const char *fs_type)
 int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *source, const char *target,
 	       const char *filesystemtype, unsigned long mountflags,
-	       const void *data, int *is_fuse)
+	       const void *data, int *is_fuse, unsigned int check_support)
 {
 	int rval = -1;
 	char mpath[PATH_MAX];
@@ -993,9 +993,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 			"mount.%s failed with %i", filesystemtype, rval);
 		return -1;
 	} else if (rval == -1) {
-		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
-			"mount(%s, %s, %s, %lu, %p) failed", source, target,
-			filesystemtype, mountflags, data);
+		if (check_support && errno == EOPNOTSUPP) {
+			tst_brkm_(file, lineno, TCONF | TERRNO, cleanup_fn,
+				"Kernel does not support required %s features",
+				filesystemtype);
+		} else {
+			tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
+				"mount(%s, %s, %s, %lu, %p) failed", source,
+				target, filesystemtype, mountflags, data);
+		}
 	} else {
 		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
 			"Invalid mount(%s, %s, %s, %lu, %p) return value %d",
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9c5f2617f..166e0f672 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1301,7 +1301,8 @@ static void prepare_device(struct tst_fs *fs)
 				buf, sizeof(buf), tdev.fs_type);
 
 		SAFE_MOUNT2(get_device_name(tdev.fs_type), tst_test->mntpoint,
-				tdev.fs_type, fs->mnt_flags, mnt_data, &tdev.is_fuse);
+				tdev.fs_type, fs->mnt_flags, mnt_data,
+				&tdev.is_fuse, fs->mount_check_support);
 		context->mntpoint_mounted = 1;
 	}
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
