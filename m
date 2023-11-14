Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B459EC4167B
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 07:24:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D3C3CC318
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 08:24:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876303CE4CE
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:48 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E94FF1000CB4
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:47 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so3609753f8f.3
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 23:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699946627; x=1700551427; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDfQh111WKBpAAI36ju9Trv7z9GDyyLMh0aCHIItMX4=;
 b=Zev6CE3tH7iGefB6h53jPNkbaOYAndMCjPFh47hOiuQZkN/R+lug5xc1fyEfhfyXaB
 vg+4nNoIRYGsN7ugxwTP05+RoZxI9F6pSEU+OCMlkoSxU2idjKofl1auiXJU9cNJIWpA
 gpddU6ZLJvYY6FYlchrNTp22PdApfvKEmKad+w0rKmmGKpqwmISAufDi8MkI8mBqaFra
 hgKL69J6FUPR8BMeiESLPU0TzqvhIv+CuiYwXSDu13tMYD5lw4geKwhm/2KyYC10p7xS
 b9F2elh8D6eA7PeT7Qje6g9j+MXFp3fqgFzUfD7O0i+GUw+SzrQWwNuJpI/mMJe5dDLO
 ietw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699946627; x=1700551427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDfQh111WKBpAAI36ju9Trv7z9GDyyLMh0aCHIItMX4=;
 b=us6hJjjiiowVtYWNUDG1enFv2C6yvFmFuhImtTtQXojC8fVmkEgjzfTXcQ1/kWZ9Dy
 lTwbOFmwQ3pKsborsgY6zkmbQGRqc+xASt2kztt7M4KWyJ9kUnJiQ+fKXqmRq9amfM1X
 b+9U2J1qsjP+7v5rLW7/shCbqcB+RYC1U95iM5thTEeNkbZE3pnRghmCBRLe25us9WG1
 h08jpTRpDmfpEb+d5rjlu8r9WvWv4S6flyt/EB4QpoOIUD3I+0c2i9p0XTh0oGVbjBT+
 dJgnYuAe23D0aPTctpArpaml8mLPswcr6uWDdREdEWi4AZb7m6IuhPnuXdEgnFkE0pDM
 wwdw==
X-Gm-Message-State: AOJu0YwU341IpE4VnY66FOsRM0CDC8TqjTkF3tB274V4WUPldv5KE6q4
 QfSbZrQ6d5xxqiCm4I38drk=
X-Google-Smtp-Source: AGHT+IEPIfoGnaR+bUnXhLjAO3EQzp8hGSlTE0f+b79h8lR0IjsmdcbVTrkSE2rr25LVY/iyUbBSRA==
X-Received: by 2002:a05:6000:237:b0:31a:d871:7ae7 with SMTP id
 l23-20020a056000023700b0031ad8717ae7mr5282512wrz.29.1699946627362; 
 Mon, 13 Nov 2023 23:23:47 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adff409000000b0032f7d7ec4adsm6865681wro.92.2023.11.13.23.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 23:23:47 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Nov 2023 09:23:38 +0200
Message-Id: <20231114072338.1669277-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114072338.1669277-1-amir73il@gmail.com>
References: <20231114072338.1669277-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] fanotify13: Test watching overlayfs with
 FAN_REPORT_FID
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
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.cz>, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Run test variants watching overlayfs (over all supported fs)
and reporting events with fid.

This requires overlayfs support for AT_HANDLE_FID (kernel 6.6) and
even with AT_HANDLE_FID file handles, only inode marks are supported.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 28 ++++++++++++-----
 .../kernel/syscalls/fanotify/fanotify13.c     | 31 ++++++++++++++++---
 2 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 78424a350..a8aec6597 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -79,8 +79,11 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
 /*
  * Helper function used to obtain fsid and file_handle for a given path.
  * Used by test files correlated to FAN_REPORT_FID functionality.
+ *
+ * Returns 0 if normal NFS file handles are supported.
+ * Returns AT_HANDLE_FID, of only non-decodeable file handles are supported.
  */
-static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
+static inline int fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 				    struct file_handle *handle)
 {
 	int mount_id;
@@ -93,6 +96,11 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 
 	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
 		if (errno == EOPNOTSUPP) {
+			/* Try to request non-decodeable fid instead */
+			if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id,
+					      AT_HANDLE_FID) == 0)
+				return AT_HANDLE_FID;
+
 			tst_brk(TCONF,
 				"filesystem %s does not support file handles",
 				tst_device->fs_type);
@@ -100,6 +108,7 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 		tst_brk(TBROK | TERRNO,
 			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
 	}
+	return 0;
 }
 
 #ifndef FILEID_INVALID
@@ -112,18 +121,21 @@ struct fanotify_fid_t {
 	char buf[MAX_HANDLE_SZ];
 };
 
-static inline void fanotify_save_fid(const char *path,
+static inline int fanotify_save_fid(const char *path,
 				     struct fanotify_fid_t *fid)
 {
 	int *fh = (int *)(fid->handle.f_handle);
+	int ret;
 
 	fh[0] = fh[1] = fh[2] = 0;
 	fid->handle.handle_bytes = MAX_HANDLE_SZ;
-	fanotify_get_fid(path, &fid->fsid, &fid->handle);
+	ret = fanotify_get_fid(path, &fid->fsid, &fid->handle);
 
 	tst_res(TINFO,
 		"fid(%s) = %x.%x.%x.%x.%x...", path, fid->fsid.val[0],
 		fid->fsid.val[1], fh[0], fh[1], fh[2]);
+
+	return ret;
 }
 #endif /* HAVE_NAME_TO_HANDLE_AT */
 
@@ -179,6 +191,7 @@ static inline int fanotify_events_supported_by_kernel(uint64_t mask,
  * @return  0: fanotify supported both in kernel and on tested filesystem
  * @return -1: @flags not supported in kernel
  * @return -2: @flags not supported on tested filesystem (tested if @fname is not NULL)
+ * @return -3: @flags not supported on overlayfs (tested if @fname == OVL_MNT)
  */
 static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const char *fname)
 {
@@ -199,7 +212,7 @@ static inline int fanotify_init_flags_supported_on_fs(unsigned int flags, const
 
 	if (fname && fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname) < 0) {
 		if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV) {
-			rval = -2;
+			rval = strcmp(fname, OVL_MNT) ? -2 : -3;
 		} else {
 			tst_brk(TBROK | TERRNO,
 				"fanotify_mark (%d, FAN_MARK_ADD, ..., AT_FDCWD, %s) failed",
@@ -269,10 +282,11 @@ static inline void fanotify_init_flags_err_msg(const char *flags_str,
 	if (fail == -1)
 		res_func(file, lineno, TCONF,
 			 "%s not supported in kernel?", flags_str);
-	if (fail == -2)
+	if (fail == -2 || fail == -3)
 		res_func(file, lineno, TCONF,
-			 "%s not supported on %s filesystem",
-			 flags_str, tst_device->fs_type);
+			 "%s not supported on %s%s filesystem",
+			 flags_str, fail == -3 ? "overlayfs over " : "",
+			 tst_device->fs_type);
 }
 
 #define FANOTIFY_INIT_FLAGS_ERR_MSG(flags, fail) \
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 4bcffaab2..4a7c2af23 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -91,8 +91,10 @@ static struct test_case_t {
 
 static int ovl_mounted;
 static int bind_mounted;
+static int ovl_bind_mounted;
 static int nofid_fd;
 static int fanotify_fd;
+static int at_handle_fid;
 static int filesystem_mark_unsupported;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
@@ -113,8 +115,10 @@ static void get_object_stats(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(objects); i++)
-		fanotify_save_fid(objects[i].path, &objects[i].fid);
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		at_handle_fid |=
+			fanotify_save_fid(objects[i].path, &objects[i].fid);
+	}
 }
 
 static int setup_marks(unsigned int fd, struct test_case_t *tc)
@@ -154,6 +158,11 @@ static void do_test(unsigned int number)
 		return;
 	}
 
+	if (at_handle_fid && mark->flag != FAN_MARK_INODE) {
+		tst_res(TCONF, "overlayfs does not support decodeable file handles required by %s", mark->name);
+		return;
+	}
+
 	if (filesystem_mark_unsupported && mark->flag & FAN_MARK_FILESYSTEM) {
 		tst_res(TCONF, "FAN_MARK_FILESYSTEM not supported in kernel?");
 		return;
@@ -169,7 +178,7 @@ static void do_test(unsigned int number)
 		goto out;
 
 	/* Watching base fs - open files on overlayfs */
-	if (tst_variant) {
+	if (tst_variant && !ovl_bind_mounted) {
 		if (mark->flag & FAN_MARK_MOUNT) {
 			tst_res(TCONF, "overlayfs base fs cannot be watched with mount mark");
 			goto out;
@@ -191,7 +200,7 @@ static void do_test(unsigned int number)
 			SAFE_CLOSE(fds[i]);
 	}
 
-	if (tst_variant)
+	if (tst_variant && !ovl_bind_mounted)
 		SAFE_UMOUNT(MOUNT_PATH);
 
 	/* Read events from event queue */
@@ -288,6 +297,8 @@ static void do_setup(void)
 	 * Variant #0: watch base fs - open files on base fs
 	 * Variant #1: watch lower fs - open lower files on overlayfs
 	 * Variant #2: watch upper fs - open upper files on overlayfs
+	 * Variant #3: watch overlayfs - open lower files on overlayfs
+	 * Variant #4: watch overlayfs - open upper files on overlayfs
 	 *
 	 * Variants 1,2 test a bug whose fix bc2473c90fca ("ovl: enable fsnotify
 	 * events on underlying real files") in kernel 6.5 is not likely to be
@@ -295,6 +306,8 @@ static void do_setup(void)
 	 * To avoid waiting for events that won't arrive when testing old kernels,
 	 * require that kernel supports encoding fid with new flag AT_HADNLE_FID,
 	 * also merged to 6.5 and not likely to be backported to older kernels.
+	 * Variants 3,4 test overlayfs watch with FAN_REPORT_FID, which also
+	 * requires kernel with support for AT_HADNLE_FID.
 	 */
 	if (tst_variant) {
 		REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(AT_HANDLE_FID);
@@ -319,6 +332,12 @@ static void do_setup(void)
 	/* Create file and directory objects for testing on base fs */
 	create_objects();
 
+	if (tst_variant > 2) {
+		/* Setup watches on overlayfs */
+		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
+		ovl_bind_mounted = 1;
+	}
+
 	/*
 	 * Create a mark on first inode without FAN_REPORT_FID, to test
 	 * uninitialized connector->fsid cache. This mark remains for all test
@@ -337,6 +356,8 @@ static void do_cleanup(void)
 		SAFE_CLOSE(nofid_fd);
 	if (fanotify_fd > 0)
 		SAFE_CLOSE(fanotify_fd);
+	if (ovl_bind_mounted)
+		SAFE_UMOUNT(MOUNT_PATH);
 	if (bind_mounted) {
 		SAFE_UMOUNT(MOUNT_PATH);
 		SAFE_RMDIR(MOUNT_PATH);
@@ -348,7 +369,7 @@ static void do_cleanup(void)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 3,
+	.test_variants = 5,
 	.setup = do_setup,
 	.cleanup = do_cleanup,
 	.needs_root = 1,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
