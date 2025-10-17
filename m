Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780C7CCD195
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 16:17:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECBD93CEEB0
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 18:16:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF65C3CE6D3
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:16:44 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 313561A00706
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 18:16:44 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b4736e043f9so343185966b.0
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760717803; x=1761322603; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UNoWstTw2Xxe42kUcsXl4w6PLiZ1V8hToRbyLsfhL5s=;
 b=g4OwJpwfBSd0HRen0KT4cTI+lS63L+oSYLfl1q4o1F0+N8ODkIk9qrwvhlCbgcpxEH
 8OcTox1Zx+s1rVc8potnItvfyxHez8YvP8Bb13TQlx7XPawl4nLTp/cKKXD5os68BxEB
 sfQEMYSxaoJ74agloOXEwNBlcW44G1tMFORHJ7eFdo8cEaI0bifEN14pgZWJFaXhIfVp
 stuhqhgv3AIge1Dt7rMcjh9qyeK9YzXIMbbp6tM053+tnoPHCsI/unaMs2ttw3hKBbyJ
 sFPKInLDkyfglf8ByVeRm/ynfSLQ/FS2sVdJQtC0XvzBhIZmih8iP5sgyqwxY5yiGWDA
 YkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760717803; x=1761322603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UNoWstTw2Xxe42kUcsXl4w6PLiZ1V8hToRbyLsfhL5s=;
 b=ZhB2XPyzJXNalLpIklKkcLHj8KkYUjUbctxurz8AEEFqVjNXZ7xOfPHKt220ldC+Yx
 XtpHIfxYirQGlbLGuIQYWNvLypsTwX/v6vL4lzK+Paj/y0bCmcRNcsmj6b33DdTCWhKg
 T9toE/l2d9PRhPE0qJgv6G5XBHQxIH3TG2duJtRk9unKkIeYIcrdyXfpc/RrEBKlngA8
 ME1u7sC6V/a0DWt1a545ZVjPHeqVSQ+3ljWx+stHhmmxBqccyfah+fMrk+C1Xbz/mZSJ
 ta9n3EWapQ5N1oMuHiN+lk3LL1WySxwLWYqxpKt3VwuXhzqNP9CyeAt3SMpHL3YpVNfU
 WXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgWJqawpgabGt0OI7U9wvSPnVNjbLlY5yF0NH5utHmSgiWzYy9m4R2A+bGLNbt43KPvWM=@lists.linux.it
X-Gm-Message-State: AOJu0YwDy9yWI8ueq3B+aQqgnTSC5kIX0stny0HN14y1TDMobi7FQU5Y
 uWswCcMD+Zwdh/vmo9oDSUw9jMcjE0GuZ0e60uAy738RPaiP6gd9lf4BFWuZpbxi
X-Gm-Gg: ASbGncvYgLmb1gX8cEBjp7gusgENi77YIZUW9JHt60mmOjhkuYVU2CKn7wo626zVFho
 6RrN6igqY5fr4h5lSvd1SjThL2sp99y7f53YjNrt0US4G9u3z3F0ON5gsE2NvyMkikM47beZcO8
 tSL51sIMkvXjT9qFwbGyEjz+yWY685lzSd3RUl7Z8dvpHy0E+Pp/qfTxdPDIMqyPu3atddkMqzx
 ITSdINBrCZC4ce2lZJXk2GWLVIrBcflvk4bdXIiMbQUBoLFqV4Nas2DdB2pDjQm2+S1FrDc0bGA
 4PEFpxCMpmzS4mzyolVt7WNNYWoZPGsxt5mtry+UrxoeSemWIm/LEg4oGThUq35oRf+DHyH+xPY
 TtZHUjZpipVwJGQhdcPxdHNoSr6tk1T3C8msGU9zymwQDdhSlOWYGE6y0Bq3EEFCygUkAifqhJR
 nUrxoyAsDatBME5wH0UY7Qjp5bs3+Ob9fK0IrsE2tr2CtwsIsAIuwYZe/L5HLabgd9TbQgfaSbR
 x0Xzoq0onTLpFeJk6dCXO6TuKvwsCrOsqT5mzlIfK3D
X-Google-Smtp-Source: AGHT+IFZ0u/XXKSfltwRWZPmAhxNAwsX8EotKo0EhVuzcXeLBxJdlQOpuNFb7/lM3r4+FpvIAi3bDg==
X-Received: by 2002:a17:907:7e8e:b0:b40:cfe9:ed41 with SMTP id
 a640c23a62f3a-b6473b530f0mr475134766b.34.1760717803118; 
 Fri, 17 Oct 2025 09:16:43 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (2001-1c00-570d-ee00-16ee-5f8c-9068-69ca.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:570d:ee00:16ee:5f8c:9068:69ca])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb526098sm9418466b.62.2025.10.17.09.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:16:42 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Oct 2025 18:16:39 +0200
Message-ID: <20251017161639.2088158-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify24: Verify expected count/offset info in pre
 content events
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
Cc: Kiryl Shutsemau <kas@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To test fix commit 28bba2c2935e2 ("fsnotify: Pass correct offset to
fsnotify_mmap_perm()"), diversify the offsets and count used for mmap()
write() and read() and verify that the FAN_PRE_ACCESS events report the
expected count/offset.

For the FAN_PRE_ACCESS events generated by execve(), we cannot
anticipate the exact ranges, so we set 0 count to skip this verification.

Also add prints of path of the fd passed with the event (not verified
against expected path).

Make sure that we take the expected error value for an operation
(e.g. read) from a matching event type (e.g. FAN_PRE_ACCESS).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify24.c     | 167 +++++++++++-------
 1 file changed, 107 insertions(+), 60 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index 27f0663ce..8f2dee55b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -9,6 +9,8 @@
 /*\
  * - Test fanotify pre-content events
  * - Test respond to permission/pre-content events with cutsom error code
+ * - Test count/offset info bug that was fixed by commit
+ *   28bba2c2935e2 "fsnotify: Pass correct offset to fsnotify_mmap_perm()"
  */
 
 #define _GNU_SOURCE
@@ -44,6 +46,8 @@
 #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
 
 static char fname[BUF_SIZE];
+static char symlnk[BUF_SIZE];
+static char fdpath[BUF_SIZE];
 static char buf[BUF_SIZE];
 static volatile int fd_notify;
 static size_t page_sz;
@@ -55,6 +59,8 @@ static char event_buf[EVENT_BUF_LEN];
 struct event {
 	unsigned long long mask;
 	unsigned int response;
+	unsigned long pgcount;
+	unsigned long pgoff;
 };
 
 static struct tcase {
@@ -68,11 +74,11 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
-			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_OPEN_PERM, FAN_ALLOW,0 ,0},
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_ALLOW,0 ,0},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -80,10 +86,10 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_DENY,0 ,0},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -91,11 +97,11 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
-			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_OPEN_PERM, FAN_ALLOW,0 ,0},
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_ALLOW, 1, 1},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -103,10 +109,10 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_DENY,0 ,0},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -114,11 +120,11 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
-			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_OPEN_PERM, FAN_ALLOW,0 ,0},
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_ALLOW, 1, 1},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -126,10 +132,10 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
-			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
-			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_DENY,0 ,0},
+			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO),0 ,0},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY),0 ,0}
 		}
 	},
 	{
@@ -137,10 +143,10 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(PARENT),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD,
 		{
-			{FAN_PRE_ACCESS, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
-			{FAN_PRE_ACCESS, FAN_DENY},
-			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+			{FAN_PRE_ACCESS, FAN_ALLOW, 2, 100},
+			{FAN_PRE_ACCESS, FAN_DENY,0 ,0},
+			{FAN_PRE_ACCESS, FAN_DENY,0 ,0},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY,0 ,0}
 		}
 	},
 	{
@@ -156,7 +162,7 @@ static struct tcase {
 		FAN_PRE_ACCESS,
 		{
 			/* This allows multiple FAN_PRE_ACCESS events */
-			{FAN_PRE_ACCESS, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_ALLOW,0 ,0},
 		}
 	},
 };
@@ -190,17 +196,19 @@ static void generate_events(struct tcase *tc)
 	 */
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 
-	exp_errno = expected_errno(event->response);
-	event++;
-
+	exp_errno = 0;
+	if (event->mask & FAN_PRE_ACCESS) {
+		exp_errno = expected_errno(event->response);
+		event++;
+	}
 	exp_ret = exp_errno ? -1 : 1;
-	errno = 0;
 	/*
 	 * FAN_PRE_ACCESS events are reported on map() and write(), but should
 	 * not be reported when faulting in the user page at offset page_sz*100
 	 * that is used as an input buffer to the write() syscall.
 	 */
-	addr = SAFE_MMAP(NULL, page_sz, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
+	errno = 0;
+	addr = SAFE_MMAP(NULL, page_sz*2, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
 	if (!addr || errno != exp_errno) {
 		tst_res(TFAIL, "mmap() got errno %d (expected %d)", errno, exp_errno);
 		exit(3);
@@ -208,12 +216,14 @@ static void generate_events(struct tcase *tc)
 		tst_res(TINFO, "mmap() got errno %d as expected", errno);
 	}
 
-	exp_errno = expected_errno(event->response);
-	event++;
-
+	exp_errno = 0;
+	if (event->mask & FAN_PRE_ACCESS) {
+		exp_errno = expected_errno(event->response);
+		event++;
+	}
 	exp_ret = exp_errno ? -1 : 1;
 	errno = 0;
-	if (write(fd, addr, 1) != exp_ret || errno != exp_errno) {
+	if (pwrite(fd, addr, 1, page_sz) != exp_ret || errno != exp_errno) {
 		tst_res(TFAIL, "write() got errno %d (expected %d)", errno, exp_errno);
 		exit(3);
 	} else if (errno == exp_errno) {
@@ -222,12 +232,14 @@ static void generate_events(struct tcase *tc)
 
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 
-	exp_errno = expected_errno(event->response);
-	event++;
-
+	exp_errno = 0;
+	if (event->mask & FAN_PRE_ACCESS) {
+		exp_errno = expected_errno(event->response);
+		event++;
+	}
 	exp_ret = exp_errno ? -1 : BUF_SIZE;
 	errno = 0;
-	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
+	if (pread(fd, buf, BUF_SIZE, page_sz*2) != exp_ret || errno != exp_errno) {
 		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
 		exit(4);
 	} else if (errno == exp_errno) {
@@ -236,9 +248,11 @@ static void generate_events(struct tcase *tc)
 
 	SAFE_CLOSE(fd);
 
-	exp_errno = expected_errno(event->response);
-	event++;
-
+	exp_errno = 0;
+	if (event->mask & (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM)) {
+		exp_errno = expected_errno(event->response);
+		event++;
+	}
 	/*
 	 * If execve() is allowed by permission events, check if executing a
 	 * file that open for write is allowed.
@@ -346,6 +360,21 @@ static int setup_mark(unsigned int n)
 	return 0;
 }
 
+static char *event_fdpath(struct fanotify_event_metadata *event)
+{
+	int len = 0;
+
+	if (event->fd < 0)
+		return "";
+
+	sprintf(symlnk, "/proc/self/fd/%d", event->fd);
+	len = readlink(symlnk, fdpath, sizeof(fdpath));
+	if (len < 0)
+		len = 0;
+	fdpath[len] = 0;
+	return fdpath;
+}
+
 static void test_fanotify(unsigned int n)
 {
 	int ret, len = 0, i = 0, test_num = 0;
@@ -366,6 +395,7 @@ static void test_fanotify(unsigned int n)
 	while (test_num < EVENT_SET_MAX && fd_notify != -1) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_range *range;
+		const char *filename;
 
 		if (i == len) {
 			/* Get more events */
@@ -395,6 +425,7 @@ static void test_fanotify(unsigned int n)
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		range = (struct fanotify_event_info_range *)(event + 1);
+		filename = event_fdpath(event);
 		/* Permission events cannot be merged, so the event mask
 		 * reported should exactly match the event mask within the
 		 * event set.
@@ -402,41 +433,53 @@ static void test_fanotify(unsigned int n)
 		if (event->mask != event_set[test_num].mask) {
 			tst_res(TFAIL,
 				"got event: mask=%llx (expected %llx) "
-				"pid=%u fd=%d",
+				"pid=%u fd=%d [%s]",
 				(unsigned long long)event->mask,
 				event_set[test_num].mask,
-				(unsigned int)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd, filename);
 		} else if (event->pid != child_pid) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u "
-				"(expected %u) fd=%d",
+				"(expected %u) fd=%d [%s]",
 				(unsigned long long)event->mask,
 				(unsigned int)event->pid,
 				(unsigned int)child_pid,
-				event->fd);
+				event->fd, filename);
 		} else if (event->mask & LTP_PRE_CONTENT_EVENTS) {
+			unsigned long long expected_count = event_set[test_num].pgcount * page_sz;
+			unsigned long long expected_offset = event_set[test_num].pgoff * page_sz;
+
 			if (event->event_len < sizeof(*event) + sizeof(*range) ||
 			    range->hdr.info_type != FAN_EVENT_INFO_TYPE_RANGE) {
 				tst_res(TFAIL,
 					"got event: mask=%llx pid=%u len=%d fd=%d "
-					"(expected range info)",
+					"(expected range info) [%s]",
 					(unsigned long long)event->mask,
 					(unsigned int)event->pid,
 					(unsigned int)event->event_len,
-					event->fd);
+					event->fd, filename);
+			} else if (expected_count && (range->count != expected_count ||
+						      range->offset != expected_offset)) {
+				tst_res(TFAIL,
+					"got event: mask=%llx pid=%u fd=%d "
+					"count=%llu offset=%llu (expected %llu@%llu) [%s]",
+					(unsigned long long)event->mask,
+					(unsigned int)event->pid, event->fd,
+					range->count, range->offset,
+					expected_count, expected_offset, filename);
 			} else {
 				tst_res(TPASS,
 					"got event: mask=%llx pid=%u fd=%d "
-					"offset=%llu count=%llu",
+					"count=%llu offset=%llu [%s]",
 					(unsigned long long)event->mask,
 					(unsigned int)event->pid, event->fd,
-					range->offset, range->count);
+					range->count, range->offset, filename);
 			}
 		} else {
 			tst_res(TPASS,
-				"got event: mask=%llx pid=%u fd=%d",
+				"got event: mask=%llx pid=%u fd=%d [%s]",
 				(unsigned long long)event->mask,
-				(unsigned int)event->pid, event->fd);
+				(unsigned int)event->pid, event->fd, filename);
 		}
 
 		/* Write response to the permission event */
@@ -481,7 +524,7 @@ static void setup(void)
 
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
-	SAFE_TRUNCATE(fname, page_sz*101);
+	SAFE_TRUNCATE(fname, page_sz*102);
 
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_PRE_CONTENT, FAN_MARK_FILESYSTEM,
 						FAN_PRE_ACCESS, fname);
@@ -511,7 +554,11 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.mntpoint = MOUNT_PATH,
-	.resource_files = resource_files
+	.resource_files = resource_files,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "28bba2c2935e2"},
+		{}
+	}
 };
 
 #else
-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
