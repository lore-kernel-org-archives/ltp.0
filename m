Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFA5C8302B
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 15:32:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26AA3C5F9B
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 17:32:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AFE03C0433
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:31:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 906BF10009FC
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 17:31:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24BBF2111F
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751297485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wa+LR9HzbjUWrYDlDFzrIs9PLmZIynOioo3n9JJd9aY=;
 b=3Co/IR+HDrDupiCn3pZ9/paG23dWXQ+bdK3ku8BBq6SVqy3G2cmK7j6CeUfmgh4K6Gn3+G
 x9nduNhfwMU3zMkCTn0d3xh4mmKhKeWte2ksbr2BZF+m5NXb8YdLXFw1KV+NLozNRxYGRW
 O2aXfAqLxy+qlv5qFj8MvGQr/qcPWcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751297485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wa+LR9HzbjUWrYDlDFzrIs9PLmZIynOioo3n9JJd9aY=;
 b=OKT8TGelbyE97yZgP2xyUQgnqMeMNAavQuv4AmtqcVV4PVxxc6g8QlX1cO0WPU466M9+58
 NXmBl66s15b+eeAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kKMt3aNV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Dai2yRE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751297484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wa+LR9HzbjUWrYDlDFzrIs9PLmZIynOioo3n9JJd9aY=;
 b=kKMt3aNVP22mPW902rXOgitXovQy4nXSh9U6GqxbM0FY8gC2yoGYF3F3n2vkGMdKHYQ8ZJ
 K8RUVsF+BK+XJTQiBLmKyw05sbEymiQJFlmj/YU9T5r3EyDZ6TS+EUj/shQL08aWprZUso
 6T2QNLkxAcAOjcwFAckW4+CtPnFm/N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751297484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wa+LR9HzbjUWrYDlDFzrIs9PLmZIynOioo3n9JJd9aY=;
 b=Dai2yRE3Ab3xKXPVTkUldJ6+bBU0bCsAMUSLtirGgyuQtXE97WsSFLK8cT6gNG4CJ2UsWN
 oTlKFKb8TULgBjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14AC213983
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WeB4AcytYmj4BQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 15:31:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 30 Jun 2025 17:32:04 +0200
Message-ID: <20250630153205.19017-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 24BBF2111F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: Add is_fuse flag to SAFE_MOUNT() and
 tst_device
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

This allows us to adjust tests that need different expectations on FUSE
based filesystems.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/old/safe_macros.h |  2 +-
 include/safe_macros_fn.h  |  2 +-
 include/tst_device.h      |  2 ++
 include/tst_safe_macros.h |  7 ++++++-
 lib/safe_macros.c         | 10 ++++++++--
 lib/tst_test.c            |  4 ++--
 6 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
index fb1d7a110..307843ab0 100644
--- a/include/old/safe_macros.h
+++ b/include/old/safe_macros.h
@@ -150,7 +150,7 @@
 #define SAFE_MOUNT(cleanup_fn, source, target, filesystemtype, \
 		   mountflags, data) \
 	safe_mount(__FILE__, __LINE__, (cleanup_fn), (source), (target), \
-		   (filesystemtype), (mountflags), (data))
+		   (filesystemtype), (mountflags), (data), NULL)
 
 #define SAFE_UMOUNT(cleanup_fn, target) \
 	safe_umount(__FILE__, __LINE__, (cleanup_fn), (target))
diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
index d256091b7..b4be482c1 100644
--- a/include/safe_macros_fn.h
+++ b/include/safe_macros_fn.h
@@ -172,7 +172,7 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *source, const char *target,
 	       const char *filesystemtype, unsigned long mountflags,
-	       const void *data);
+	       const void *data, int *is_fuse);
 
 int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 		const char *target);
diff --git a/include/tst_device.h b/include/tst_device.h
index 2597fb4e2..9ca802735 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -15,6 +15,8 @@ struct tst_device {
 	const char *dev;
 	const char *fs_type;
 	uint64_t size;
+	/* If device was mounted by the test library this flag is set for fuse fileystems. */
+	int is_fuse;
 };
 
 /*
diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 19504beb5..6d53c0bbc 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -241,7 +241,12 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
 #define SAFE_MOUNT(source, target, filesystemtype, \
 		   mountflags, data) \
 	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
-		   (filesystemtype), (mountflags), (data))
+		   (filesystemtype), (mountflags), (data), NULL)
+
+#define SAFE_MOUNT2(source, target, filesystemtype, \
+		    mountflags, data, is_fuse) \
+	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
+		   (filesystemtype), (mountflags), (data), (is_fuse))
 
 #define SAFE_UMOUNT(target) \
 	safe_umount(__FILE__, __LINE__, NULL, (target))
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 726c9ae8e..6d267522f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -907,11 +907,14 @@ static int possibly_fuse(const char *fs_type)
 int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *source, const char *target,
 	       const char *filesystemtype, unsigned long mountflags,
-	       const void *data)
+	       const void *data, int *is_fuse)
 {
 	int rval = -1;
 	char mpath[PATH_MAX];
 
+	if (is_fuse)
+		*is_fuse = 0;
+
 	if (realpath(target, mpath)) {
 		tst_resm_(file, lineno, TINFO,
 			"Mounting %s to %s fstyp=%s flags=%lx",
@@ -957,8 +960,11 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 			filesystemtype, mount_ro, source, target);
 
 		rval = tst_system(buf);
-		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
+		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0) {
+			if (is_fuse)
+				*is_fuse = 1;
 			return 0;
+		}
 
 		tst_brkm_(file, lineno, TBROK, cleanup_fn,
 			"mount.%s failed with %i", filesystemtype, rval);
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 17ce91932..2130e4be8 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1273,8 +1273,8 @@ static void prepare_device(struct tst_fs *fs)
 		mnt_data = limit_tmpfs_mount_size(fs->mnt_data,
 				buf, sizeof(buf), tdev.fs_type);
 
-		SAFE_MOUNT(get_device_name(tdev.fs_type), tst_test->mntpoint,
-				tdev.fs_type, fs->mnt_flags, mnt_data);
+		SAFE_MOUNT2(get_device_name(tdev.fs_type), tst_test->mntpoint,
+				tdev.fs_type, fs->mnt_flags, mnt_data, &tdev.is_fuse);
 		context->mntpoint_mounted = 1;
 	}
 }
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
