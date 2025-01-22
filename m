Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266E0C02182
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 17:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C2D3C30A9
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 18:26:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D9BA3C3084
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:49 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA321141ABAE
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:24:48 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso52350675e9.2
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 09:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737566688; x=1738171488; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGU8p7tNLhmNAY4sN+z3CxHEUlGufSGkgwZx3tPWe4o=;
 b=Sjiu29oKZJ9LrWd2qRtyybFcQVg69aqsfVvR7omIDuuQFLKo2mdPdzg24Y4/QGaUG+
 o7N+4KM6nxe5HN9XelY3zH+PnQVaaPADF8Uhb/u/RZ7OUbLs5UFEKUat+6vaSyAfQq9n
 6eoCho+cTwPWcrveovZR5P6DyoUXjroXT2vYNB704I9jujWpdMB9ooMTvcih7JaZ3y6r
 mBeDBDBUDaBQzs9GXh30y85HBX4W7HFZwfBuL/3GBCYjg2+BiVdUbvETMudn9K0e2dlS
 Z7jayZ0AlXTWcjcPs5zkZLP5I0hcZMU4ai9j96ayt5/1YoBhgIbsEainOZiDm6BFfps9
 qUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566688; x=1738171488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGU8p7tNLhmNAY4sN+z3CxHEUlGufSGkgwZx3tPWe4o=;
 b=KdVHci5zhjYsUErTW/cV77yhhuEisrZxels4rAOnxkjoZl+CXJP2GS3iiVhGivLDzF
 24k/Ac7tMqbfxbOI5aOvTidJ+DJgE8nIyHKNMwwAxhp6qFLhpaSEwc1ra6auSvvr+Rb6
 jH5WhPZSap26L2H3svg5BnyIXuWVi6j092yg4bk6WIHtpwXZWtGHiBjI9VtnjrhbHG+l
 1r9Brrcb6TVpD05942u81QTNW6GC0AjbH/N5umoSNAOEiNTwVc5FqBFDV7OpuV6L5oLU
 tqDplCPNmZcWYg1rE6+04Svd7/cCCIz9u0crd/qoWIQHovvmzZ45K9wjv3KJ7174mNsj
 J4dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMWxtgYKeoGtPsrV2Xee/d27a4DFEShZoOsumgTr1hA1uN53OBN+y4gczFMMiTkAugHBA=@lists.linux.it
X-Gm-Message-State: AOJu0YwdUA+N55mMHy0ka9P7RcR8ZlWFsieewyol1DD0Y9ThMnCWgCro
 jQvmUr86Zaw0Oyok2E8SnjN2u6mD0vvkDjLeE49ZmZdOJ3fIvFP+Nxyp8Mhw
X-Gm-Gg: ASbGnctjrHpflAdBI8EBnTQ2jkFnPEQIl27N0X5kvYoookh+VABYOolse8Unew719qE
 k12LPLOuCyfYw+lquGh2c4irOEM93nBMUld9PGpAQbSyFCKF8XMYQe8lPrjpOMPLRVg7S1jIQuU
 FoQOhnZDl8al4fMTJaL0Gg+4tXKA7rEBV+O6Ec0Jq+WE2v7BzP1eugTZKgj82ji4u+JY0VbMCZa
 W+JdpPwKTt/NLlrFB2+Erao1bYKp7dXvMNT51xgtcUzLOm2OZXyaIpoZkPtMPGOlAsu+Ni7t3D4
 YhCwLReSB2rgKI9T8N+bpiTX/zdQBwEP7Wie6f7Us20InTgGH8YzJusCrA/jRw5Q58c=
X-Google-Smtp-Source: AGHT+IGngsxz5LDMDmiBj2YRFs9s8oRF0rzV9GytldLmvSTOwYmZoVW7KGgmO3c4IwJL6r2VqOEq6Q==
X-Received: by 2002:a05:600c:1e1c:b0:434:f0df:9f6 with SMTP id
 5b1f17b1804b1-438913bf655mr220244155e9.3.1737566687748; 
 Wed, 22 Jan 2025 09:24:47 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31d98e2sm31592405e9.26.2025.01.22.09.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:24:47 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Jan 2025 18:24:40 +0100
Message-Id: <20250122172440.506677-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122172440.506677-1-amir73il@gmail.com>
References: <20250122172440.506677-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] fanotify21: Test reporting fd open errors with
 FAN_REPORT_FD_ERROR
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Expect to get -EROFS as event->fd.
Expect to get -ESRCH instead of FAN_NOPIDFD.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 61 ++++++++++++++++---
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 4324019fa..8765767f2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -57,7 +57,7 @@ static struct test_case_t {
 	{
 		"return invalid pidfd for event created by terminated child",
 		1,
-		FAN_NOPIDFD,
+		1,
 		0,
 	},
 	{
@@ -72,6 +72,8 @@ static int fanotify_fd;
 static char event_buf[BUF_SZ];
 static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
 
+static int fd_error_unsupported;
+
 static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 {
 	char *fdinfo_path;
@@ -121,6 +123,15 @@ static void do_fork(void)
 static void do_setup(void)
 {
 	int pidfd;
+	int init_flags = FAN_REPORT_PIDFD;
+
+	if (tst_variant) {
+		fanotify_fd = -1;
+		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
+		if (fd_error_unsupported)
+			return;
+		init_flags |= FAN_REPORT_FD_ERROR;
+	}
 
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
@@ -132,7 +143,7 @@ static void do_setup(void)
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
 						    TEST_FILE);
 
-	fanotify_fd = SAFE_FANOTIFY_INIT(FAN_REPORT_PIDFD, O_RDWR);
+	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
 
@@ -150,8 +161,17 @@ static void do_test(unsigned int num)
 {
 	int i = 0, len;
 	struct test_case_t *tc = &test_cases[num];
+	int nopidfd_err = tc->want_pidfd_err ?
+			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
+	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
 
-	tst_res(TINFO, "Test #%d: %s", num, tc->name);
+	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
+			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
+
+	if (fd_error_unsupported && tst_variant) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
+		return;
+	}
 
 	if (tc->remount_ro) {
 		/* SAFE_MOUNT fails to remount FUSE */
@@ -179,12 +199,12 @@ static void do_test(unsigned int num)
 	 */
 	len = read(fanotify_fd, event_buf, sizeof(event_buf));
 	if (len < 0) {
-		if (tc->remount_ro && errno == EROFS) {
+		if (tc->remount_ro && !fd_err && errno == EROFS) {
 			tst_res(TPASS, "cannot read event with rw fd from a ro fs");
 			return;
 		}
 		tst_brk(TBROK | TERRNO, "reading fanotify events failed");
-	} else if (tc->remount_ro) {
+	} else if (tc->remount_ro && !fd_err) {
 		tst_res(TFAIL, "got unexpected event with rw fd from a ro fs");
 	}
 	while (i < len) {
@@ -218,6 +238,28 @@ static void do_test(unsigned int num)
 			goto next_event;
 		}
 
+		/*
+		 * Check if event->fd reported any errors during
+		 * creation and whether they're expected.
+		 */
+		if (!fd_err && event->fd >= 0) {
+			tst_res(TPASS,
+				"event->fd %d is valid as expected",
+				event->fd);
+		} else if (fd_err && event->fd == fd_err) {
+			tst_res(TPASS,
+				"event->fd is error %d as expected",
+				event->fd);
+		} else if (fd_err) {
+			tst_res(TFAIL,
+				"event->fd is %d, but expected error %d",
+				event->fd, fd_err);
+		} else {
+			tst_res(TFAIL,
+				"event->fd creation failed with error %d",
+				event->fd);
+		}
+
 		/*
 		 * Check if pidfd information object reported any errors during
 		 * creation and whether they're expected.
@@ -229,20 +271,18 @@ static void do_test(unsigned int num)
 				(unsigned int)event->pid,
 				info->pidfd);
 			goto next_event;
-		} else if (tc->want_pidfd_err &&
-			   info->pidfd != tc->want_pidfd_err) {
+		} else if (tc->want_pidfd_err && info->pidfd != nopidfd_err) {
 			tst_res(TFAIL,
 				"pidfd set to an unexpected error: %d for pid: %u",
 				info->pidfd,
 				(unsigned int)event->pid);
 			goto next_event;
-		} else if (tc->want_pidfd_err &&
-			   info->pidfd == tc->want_pidfd_err) {
+		} else if (tc->want_pidfd_err && info->pidfd == nopidfd_err) {
 			tst_res(TPASS,
 				"pid: %u terminated before pidfd was created, "
 				"pidfd set to the value of: %d, as expected",
 				(unsigned int)event->pid,
-				FAN_NOPIDFD);
+				nopidfd_err);
 			goto next_event;
 		}
 
@@ -323,6 +363,7 @@ static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
+	.test_variants = 2,
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
