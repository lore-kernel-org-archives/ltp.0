Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C7CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:08:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF3AB3E5E1E
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:08:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8B33E6A54
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:58 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D95F160083F
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:57 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso8474470eec.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546816; x=1782151616; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtPgdGZ9vcFfdNnQmTMyPS/InePmfGlilPtYHHpYJxQ=;
 b=PYfcemZiBZDlVagPK4adVStvS7TD2ct2CIZ3GhoxYDomPR/hJ9AicrgkOJdm0Ic2+W
 C3HWLHejkxebTAfxpXCf9NEKJw52b4aN45F9pRFHj7oV4WbEzTYlOzhc7JTBRwsKu8lh
 a0uQz01b5Xmc7hc8wyBqpG6QgPnVtldzxC9YqrfLPwoKRCKIZtspIeDF3vzjtcodFwTs
 4YjCWlxJTXdwJgCRkppx7Iwbbcgmxg5Ha2+PbmqFoUpE1m2ar/9MasXLbs7w6ylgbaPV
 +AXgJzruSye26q81NI1+oETYLR3Ki3lUyNUxcy73hpeJQ4ej9OrKyp3KnhXt1IZFXZic
 OgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546816; x=1782151616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KtPgdGZ9vcFfdNnQmTMyPS/InePmfGlilPtYHHpYJxQ=;
 b=kKUm1DkF68Dc1h0umu6+9a85XnFbkFzB4Qj4smGkNhOGMHD/BnFLqJ33EmkYpOqTVy
 3baFVTRlpQehhI1eT6iQ9O5d1lx0QBbByIL6TC2r8hQX1zCFfaU0oB6aEG5TsPUAWja3
 lMbqmia+iqmgKNhNFwyMXb9S2rL6Bm6lCdCVvvzmBIeQ7k/Q8z7BzrBWozXLTBy8qnHK
 0CI5zvNXrh61XI+P1vxcnegQd0/uhRbeGeM+JQfjHvT4P6bGx6EyeHA5CUW6q8lLty4h
 BKWgErZIlszX8PPKFEQnK/UZbAv6t+9uTiN7C9eUkfym1FscaB877gwxcONm/vG9xhYH
 YjPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E79jdXljVRQQTd61GAhj2Il/l0aiCXnT1RAQ5D+jNpuBcZvFVBNlejqgE8xODL594W74=@lists.linux.it
X-Gm-Message-State: AOJu0YzByG3FFdCeZ7nYVqW9M1WZk5MIAD2q3sTA+LXITzo5zNdm4HrE
 1GyQDp5d/ddydjkhkBuJqIyMQs13UCut030ErRqg5oeO2a8QI+9rBWKi
X-Gm-Gg: Acq92OGGnAt8bG/7ag1DAADT6LSj6XDfvxHKeKDKSiZghPtNRC6sTHu63uiTzwWsJZN
 JZUGRCIfGS05Ia+urm9AfmL4+fF2KgEIKtPBEaxiLXuvVamjPOz0VQ6rEBLDMU1BLZn6U9sF7F9
 Knxfisom8EKV0E50VyAFlTA7U+aavHFFRauZMgkORTjDuFbVUVlwipM4J+vWcpE2kY4hLa5Bo5/
 igB4k/n/hKeG9buxplTtEywKnDWYSpn5/b6yBOA/WB5czqRry3nc6637eflnAS6y6r+ImnnYi7q
 FFmeqClKRtpblhr4t4fKiFphzXSSRS1jBQJ/sGECguq2D1E0Y0IKwbhTXWrnAmFJW8ezITbxyfv
 KZRnkT6h91RY9l97eAsj0YtNbBUF9QYBz+YP9ZqbGABpMd7pep7Jt+vOdmCRcYFlQ4JLcCNhRjZ
 8rRp81s2t1z/dhfo6+
X-Received: by 2002:a05:7300:a54c:b0:304:d75b:f5f4 with SMTP id
 5a478bee46e88-30ba5ebdfc2mr200011eec.16.1781546815731; 
 Mon, 15 Jun 2026 11:06:55 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:55 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:28 +0800
Message-ID: <20260615180629.7148-5-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] fanotify21: Add test variants for FAN_REPORT_TID
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add test variants for FAN_REPORT_PIDFD combined with FAN_REPORT_TID,
both with and without FAN_REPORT_FD_ERROR. Add PIDFD_THREAD fallback
definition for old headers.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 include/lapi/pidfd.h                          |  4 ++
 .../kernel/syscalls/fanotify/fanotify21.c     | 56 ++++++++++++++-----
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
index a3205032c..eb4e3466d 100644
--- a/include/lapi/pidfd.h
+++ b/include/lapi/pidfd.h
@@ -43,6 +43,10 @@ struct pidfd_info {
 # define PIDFD_NONBLOCK O_NONBLOCK
 #endif
 
+#ifndef PIDFD_THREAD
+# define PIDFD_THREAD O_EXCL
+#endif
+
 #ifndef PIDFS_IOCTL_MAGIC
 # define PIDFS_IOCTL_MAGIC	0xFF
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 22f9767db..fd43c8c1c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -12,6 +12,7 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1.
  */
 
 #define _GNU_SOURCE
@@ -32,6 +33,9 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 
+#define TST_VARIANT_FD_ERROR (tst_variant & 1)
+#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
+
 struct pidfd_fdinfo_t {
 	int pos;
 	int flags;
@@ -67,6 +71,7 @@ static char event_buf[BUF_SZ];
 static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
 
 static int fd_error_unsupported;
+static int thread_pidfd_unsupported;
 
 static struct tst_clone_args clone_args = {
 	.flags = CLONE_NEWPID,
@@ -90,21 +95,37 @@ static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 static void generate_event(void)
 {
 	int fd;
+	int pidfd;
+
+	pidfd = TST_VARIANT_PIDFD_THREAD ? SAFE_PIDFD_OPEN(tst_gettid(), PIDFD_THREAD)
+					 : SAFE_PIDFD_OPEN(tst_getpid(), 0);
+	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
+	SAFE_CLOSE(pidfd);
 
 	/* Generate a single FAN_OPEN event on the watched object. */
 	fd = SAFE_OPEN(TEST_FILE, O_RDONLY);
 	SAFE_CLOSE(fd);
 }
 
+static const char *test_variant_name(void)
+{
+	switch (tst_variant) {
+	case 0: return "";
+	case 1: return "(FAN_REPORT_FD_ERROR)";
+	case 2: return "(FAN_REPORT_TID)";
+	case 3: return "(FAN_REPORT_FD_ERROR | FAN_REPORT_TID)";
+	}
+	return NULL;
+}
+
 static void do_setup(void)
 {
-	int pidfd;
 	int init_flags = FAN_REPORT_PIDFD;
 
 	/* Bind mount so remount ro/rw always work */
 	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
 
-	if (tst_variant) {
+	if (TST_VARIANT_FD_ERROR) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
 		if (fd_error_unsupported)
@@ -112,6 +133,15 @@ static void do_setup(void)
 		init_flags |= FAN_REPORT_FD_ERROR;
 	}
 
+	if (TST_VARIANT_PIDFD_THREAD) {
+		fanotify_fd = -1;
+		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
+		if (thread_pidfd_unsupported)
+			return;
+		init_flags |= FAN_REPORT_TID;
+	}
+
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
 	/*
@@ -125,12 +155,6 @@ static void do_setup(void)
 	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
-
-	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
-
-	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
-
-	SAFE_CLOSE(pidfd);
 }
 
 static void do_test(unsigned int num)
@@ -138,19 +162,25 @@ static void do_test(unsigned int num)
 	int i = 0, len;
 	struct test_case_t *tc = &test_cases[num];
 	int nopidfd_err = tc->want_pidfd_err ?
-			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
-	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
+			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
+	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
 	pid_t reader_pid;
 	int reader_exit_status;
 
 	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
-			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
+		       test_variant_name());
 
-	if (fd_error_unsupported && tst_variant) {
+	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
 		return;
 	}
 
+	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, thread_pidfd_unsupported);
+		return;
+	}
+
 	/* remount ro/rw the bind mount */
 	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
 		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
@@ -333,7 +363,7 @@ static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 4,
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
