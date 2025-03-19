Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D31C35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:29:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2E43CAE10
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:29:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3804D3CADFC
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:51 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BE88C200740
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:27:50 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so857273f8f.1
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 12:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742412470; x=1743017270; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtnJhrByoHAOH8sikTFuZ6wKoakkNQhZ2H+kpcsvz4g=;
 b=TtUY8ev2YUI0aNOIIdT08MqsqsOuYLo6aiLd8IeU8a7bdFZUWFkd2aK/+di6W4jmTI
 F7BGGf0rtNoQyHdN0mUGJRqNKuKNyZe0UTiBNozsnt+u5Um5OZYd7cj12VL5GwvhFQ8Z
 DNsO8UeSJiy7mgWJjsRNPEbxHlLh9hE2umoA3buc1tWzM8qE/4vw4uZOxiBGN/kDof6d
 oDNxSaQWAcnR7RgInzNkUDWK52cKyfdSln+WFtekLZMO00ExNNemK/qBH2g7H4kfyt/q
 FZsoIveuMvhWxKrj5RzrM62uWCP5fA4dL4NIv/kLEJZyCZFlGQFtLzMSWhzzODZFQDlR
 zHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412470; x=1743017270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtnJhrByoHAOH8sikTFuZ6wKoakkNQhZ2H+kpcsvz4g=;
 b=DzYKaTJNykkvERQH+PdLOg+2eoonFMto3R6rbvpQnd2iBVMLxCWzrXuxiPtlxNCRqG
 Qc68pkAHvq8WJWRSQDtCwGi7CTEAAjYWPS0xip+3G+pTxVe9FnNDxCw8agSOrUckhscX
 LLV6/YVFEREsY/7BJp6aaF8kVMlQGS51mTVU2i/d3y1iwGCpyvmrhQEARJHPVHhMRrru
 yVtStZtq48hssv4Vm0IlBmZMvsNBv8kCro7BT66gPvm3tHtt92U3r1XRRKRU0nULdu3t
 o7MbKXc1hEoHKReQC9rTob0xmU2+z3EiIzU3j6GKBls9zEuZEWQ3e39fglSEQWF0xZji
 jltw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTp8NivwaAcGlbP/OUhLLPj6YXEj9eQmGF5ga2+YsavI8lVh7rJfNXledrzs/H4Gj0Hgo=@lists.linux.it
X-Gm-Message-State: AOJu0YwUFAqlumD3vo0QcWol7vwCRo05RwgWAJxuFkqUTF/w3Nk0kMO1
 zJGk/F5G/Ncc0iGevWto4BMOPyNGgxQeORrH7P0lQgzN73wGIlRP6XbDThmk
X-Gm-Gg: ASbGncuAnai9sCUZYd61p0cAJszXLcLgtg6Hr/5EGwK0/DXtnxuGBvZ8jcaR+GZD5tt
 UOFTuzPEvJpzryCQudCjBlkXywxOuGgCSmKCdVTDuB4u5jFYf7L2MsXRviQAJXytxeHjOItbh4T
 lS5k9wFo59GMI32ghusD0unini1sux8NtX8ctiD2lTT8VYhXozv9XThQipJA1GroM+ZAN5xI83+
 TYmSFfFvFcBpTb0mAQaYWGvB+GIwU67z8AFhMwpkyGbbFQr0jUi1NEmH4amz4Z4ICqN2ZKy2yCi
 KZBfcAc/HeuHfEc6wdhADy52cJg6ZaaHukw1ob1XHvwsadcJ79S3+QL3WWMhJyKqz9z1f27Lxf4
 qj45Ljei2qJgovkVvSBLYYcVQFSNA5F7GS+/GrXW6vg==
X-Google-Smtp-Source: AGHT+IHGOFPGxuZAmv42XVEwVJU8ZmzXDsD5O9PYqc9UMxv0VxuuXftN5cNLEFqPvqYdrWehUfbw/Q==
X-Received: by 2002:a5d:47a8:0:b0:391:43ff:8ca8 with SMTP id
 ffacd0b85a97d-399739c8e78mr3350641f8f.26.1742412469676; 
 Wed, 19 Mar 2025 12:27:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4453225bsm26531585e9.7.2025.03.19.12.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:27:49 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Mar 2025 20:27:42 +0100
Message-Id: <20250319192742.999506-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192742.999506-1-amir73il@gmail.com>
References: <20250319192742.999506-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] fanotify24: add mmap() and user page fault to test
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

Commit 066e053fe208a ("fsnotify: add pre-content hooks on mmap()")
in 6.14-rc7 added a pre-content hooh in mmap() before the final release
of the fsnotify pre-content event feature.

To test pre-content hook on mmap(), increase the size of the test file
to 101 pages use mmap() to setup a buffer from the end of the test file.

Change some of the test cases to allow the write() and use this buffer
as the input buffer to write(), which tests deadlock avoidance by
suppresing pre-content hook on user page faults.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify24.c     | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index 2d2479b39..3a76f2c1b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -46,6 +46,7 @@
 static char fname[BUF_SIZE];
 static char buf[BUF_SIZE];
 static volatile int fd_notify;
+static size_t page_sz;
 
 static pid_t child_pid;
 
@@ -68,7 +69,8 @@ static struct tcase {
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
 		}
@@ -78,6 +80,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
@@ -89,7 +92,8 @@ static struct tcase {
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
 		}
@@ -99,6 +103,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
@@ -110,7 +115,8 @@ static struct tcase {
 		FAN_OPEN_PERM | FAN_PRE_ACCESS,
 		{
 			{FAN_OPEN_PERM, FAN_ALLOW},
-			{FAN_PRE_ACCESS, FAN_DENY},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_PERM, FAN_DENY_ERRNO(EBUSY)}
 		}
@@ -120,6 +126,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM,
 		{
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY_ERRNO(EIO)},
 			{FAN_OPEN_EXEC_PERM, FAN_DENY_ERRNO(EBUSY)}
@@ -130,6 +137,7 @@ static struct tcase {
 		INIT_FANOTIFY_MARK_TYPE(PARENT),
 		FAN_PRE_ACCESS | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD,
 		{
+			{FAN_PRE_ACCESS, FAN_ALLOW},
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_PRE_ACCESS, FAN_DENY},
 			{FAN_OPEN_EXEC_PERM, FAN_DENY}
@@ -169,6 +177,7 @@ static int expected_errno(unsigned int response)
 static void generate_events(struct tcase *tc)
 {
 	int fd;
+	char *addr;
 	char *const argv[] = {FILE_EXEC_PATH, NULL};
 	struct event *event = tc->event_set;
 	int exp_ret, exp_errno = 0;
@@ -186,8 +195,25 @@ static void generate_events(struct tcase *tc)
 
 	exp_ret = exp_errno ? -1 : 1;
 	errno = 0;
-	/* FAN_PRE_ACCESS events are reported also on write */
-	if (write(fd, fname, 1) != exp_ret || errno != exp_errno) {
+	/*
+	 * FAN_PRE_ACCESS events are reported on map() and write(), but should
+	 * not be reported when faulting in the user page at offset page_sz*100
+	 * that is used as an input buffer to the write() syscall.
+	 */
+	addr = SAFE_MMAP(NULL, page_sz, PROT_READ, MAP_PRIVATE, fd, page_sz*100);
+	if (!addr || errno != exp_errno) {
+		tst_res(TFAIL, "mmap() got errno %d (expected %d)", errno, exp_errno);
+		exit(3);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "mmap() got errno %d as expected", errno);
+	}
+
+	exp_errno = expected_errno(event->response);
+	event++;
+
+	exp_ret = exp_errno ? -1 : 1;
+	errno = 0;
+	if (write(fd, addr, 1) != exp_ret || errno != exp_errno) {
 		tst_res(TFAIL, "write() got errno %d (expected %d)", errno, exp_errno);
 		exit(3);
 	} else if (errno == exp_errno) {
@@ -199,7 +225,7 @@ static void generate_events(struct tcase *tc)
 	exp_errno = expected_errno(event->response);
 	event++;
 
-	exp_ret = exp_errno ? -1 : 1;
+	exp_ret = exp_errno ? -1 : BUF_SIZE;
 	errno = 0;
 	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
 		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
@@ -449,8 +475,11 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
+	page_sz = getpagesize();
+
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
+	SAFE_TRUNCATE(fname, page_sz*101);
 
 	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_PRE_CONTENT, FAN_MARK_FILESYSTEM,
 						FAN_PRE_ACCESS, fname);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
