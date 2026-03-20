Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF451093187
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 07:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773993484; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=H5U/MI4XTiGyotIRDuDq9ka8sQg5yDiSi4WbY6eBk2Y=;
 b=TMpvDl0jB9LqffdD3kmrTRAkh7t5vnR0obLgNVgGe0eQBDPhRvGid8C1FDB1jQKLpu2mR
 KeK2CKvQKCJIvAw6C8oU4NsKcoQ7cpMyKg/6R9/sv3UzlKAY7KNHHiCM7M3e/5SawTXSI+e
 JZ2hWFG4XgfGxat09yEuF3NaYad/u/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6493E1FFD
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 08:58:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 136333E1C3B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:57:41 +0100 (CET)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 556CD1001197
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:57:41 +0100 (CET)
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-c74217894d9so176683a12.2
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773993459; x=1774598259; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SLo1CQXJHMjlU9Nty8Kv+5/Wrp16fbKHPXDZxlHd4og=;
 b=XXbLJr2re4+HPEDMU6aEnmkqqoLbvHKi3iszT1bEfpWLqvZhNLUN8qARRBQ+xyO/GT
 7gT3wKn71Hx1D9dFyv+RaEGZ00Z/XOSuXkHzzOAZq4xnUKmL6OfodfzEEYPjfFGknUnK
 k1QArcKsoRnxqrZwoOCD1lVQXITMb+PB3vGSqv/HJN+sHL197X5JyB/Nn1tAeav0A1Or
 OunOVtPr5my8SYpZQhbcJipE9DnZozJgWjfDmykJa8PegYxhEn0UTakgQznirDkqIB7+
 29c0Z8K4VqvO1i61gfx30QLeArS+P41LWuL8/cbrLxOFvF2TwN5HFQsPS0QgIB+rrN1G
 Bw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773993459; x=1774598259;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLo1CQXJHMjlU9Nty8Kv+5/Wrp16fbKHPXDZxlHd4og=;
 b=aG7WL8WN45XDXLliaVs4QDEyGWW8+nItwLyIIJ6kkrrJuK7+bl3/UbJtf+LVha3cJi
 kCT+fmJc5iUekp5Y6sSG/g7df9od03ppeWaDhpydzkJngCeELTdITS4XJOB1szhH+HXN
 Jknv0Phs+wWXcWBdQfnC7o4sFEgMcN+noIaxIZJccKtkAHATYEccohdmeKmXUQRaMMDA
 Rtvs+0wnLIw3P0IBCTp+/k4cfxOpambvm1Jdasl7+7brApaGzOTxkbAUwHK2SuMGa++4
 LrZRcefDOhjZjDIohGM73iKw0i7TrWKexxxWfUHvcwzVpMFOJ3Z/W2NFI86xypt3Uldf
 sAcA==
X-Gm-Message-State: AOJu0YwQEyqMXAsKyYZbSqjJe56G//s0n8PbK7E/JE8va9ssk6mmGyfg
 V3/DqqtHVePQoAo20WfuVosPNGksxQqjK0+A/C7COIw7hTtRvb1WqpM58DEriTJAkSlR+LyvrQU
 /58jYFbAhvYoPVn6aj2XrURIoMM6trmwOY7gkdUflaUKD750wu0aLDDUWrGnP4mQB2Yjt1GAsd1
 Ds/4A3s4ZXSFoa9/DU7MFWGzarLA==
X-Received: from pga28.prod.google.com ([2002:a05:6a02:4f9c:b0:c0e:3543:bdb0])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1596:b0:39b:cbab:63d6
 with SMTP id adf61e73a8af0-39bce9b60c6mr1902129637.3.1773993459027; Fri, 20
 Mar 2026 00:57:39 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:57:33 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260320075733.936817-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/file_attr01: Allow EOPNOTSUPP when
 attributes is NULL
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The syscalls file_getattr and file_setattr may return EOPNOTSUPP
instead of EFAULT when the ufattr argument is NULL, specifically on
filesystems that do not support extended attributes (e.g., tmpfs when
CONFIG_TMPFS_XATTR is disabled).

In the kernel, the fileattr_get/set operations are checked before the
pointer dereference. If the filesystem does not define these operations,
the kernel returns -ENOIOCTLCMD (translated to EOPNOTSUPP in userspace)
before checking the validity of the user-provided pointer.

This is a valid behavior for kernel configurations where extended
attributes are not enabled for certain filesystems. This leads to
test failures on such systems:
TFAIL: File attributes is NULL expected EFAULT: EOPNOTSUPP (95)

This patch updates the test case to support multiple expected errnos
using TST_EXP_FAIL_ARR, allowing both EFAULT and EOPNOTSUPP for the NULL
attributes test case.

Signed-off-by: Wake Liu <wakel@google.com>
---
 .../kernel/syscalls/file_attr/file_attr01.c   | 35 ++++++++++++-------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
index c9c9288a1..02aea66a6 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr01.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -42,7 +42,8 @@ static struct tcase {
 	struct file_attr **ufattr;
 	size_t *usize;
 	int at_flags;
-	int exp_errno;
+	int exp_errs[2];
+	int exp_errs_cnt;
 	char *msg;
 } tcases[] = {
 	{
@@ -50,7 +51,8 @@ static struct tcase {
 		.filename = &valid_filename,
 		.ufattr = &valid_file_attr,
 		.usize = &valid_usize,
-		.exp_errno = EBADF,
+		.exp_errs = {EBADF},
+		.exp_errs_cnt = 1,
 		.msg = "Invalid file descriptor",
 	},
 	{
@@ -58,7 +60,8 @@ static struct tcase {
 		.filename = &invalid_filename,
 		.ufattr = &valid_file_attr,
 		.usize = &valid_usize,
-		.exp_errno = ENOENT,
+		.exp_errs = {ENOENT},
+		.exp_errs_cnt = 1,
 		.msg = "File doesn't exist",
 	},
 	{
@@ -66,7 +69,8 @@ static struct tcase {
 		.filename = &null_ptr,
 		.ufattr = &valid_file_attr,
 		.usize = &valid_usize,
-		.exp_errno = EFAULT,
+		.exp_errs = {EFAULT},
+		.exp_errs_cnt = 1,
 		.msg = "Filename is NULL",
 	},
 	{
@@ -74,7 +78,8 @@ static struct tcase {
 		.filename = &valid_filename,
 		.ufattr = (struct file_attr **)(&null_ptr),
 		.usize = &valid_usize,
-		.exp_errno = EFAULT,
+		.exp_errs = {EFAULT, EOPNOTSUPP},
+		.exp_errs_cnt = 2,
 		.msg = "File attributes is NULL",
 	},
 	{
@@ -82,7 +87,8 @@ static struct tcase {
 		.filename = &valid_filename,
 		.ufattr = &valid_file_attr,
 		.usize = &zero,
-		.exp_errno = EINVAL,
+		.exp_errs = {EINVAL},
+		.exp_errs_cnt = 1,
 		.msg = "File attributes size is zero",
 	},
 	{
@@ -90,7 +96,8 @@ static struct tcase {
 		.filename = &valid_filename,
 		.ufattr = &valid_file_attr,
 		.usize = &small_usize,
-		.exp_errno = EINVAL,
+		.exp_errs = {EINVAL},
+		.exp_errs_cnt = 1,
 		.msg = "File attributes size is too small",
 	},
 	{
@@ -98,7 +105,8 @@ static struct tcase {
 		.filename = &valid_filename,
 		.ufattr = &valid_file_attr,
 		.usize = &big_usize,
-		.exp_errno = E2BIG,
+		.exp_errs = {E2BIG},
+		.exp_errs_cnt = 1,
 		.msg = "File attributes size is too big",
 	},
 	{
@@ -107,7 +115,8 @@ static struct tcase {
 		.ufattr = &valid_file_attr,
 		.usize = &valid_usize,
 		.at_flags = -1,
-		.exp_errno = EINVAL,
+		.exp_errs = {EINVAL},
+		.exp_errs_cnt = 1,
 		.msg = "Invalid AT flags",
 	},
 };
@@ -117,18 +126,18 @@ static void run(unsigned int i)
 	struct tcase *tc = &tcases[i];
 
 	if (tst_variant) {
-		TST_EXP_FAIL(file_getattr(
+		TST_EXP_FAIL_ARR(file_getattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			tc->exp_errs, tc->exp_errs_cnt,
 			"%s", tc->msg);
 	} else {
-		TST_EXP_FAIL(file_setattr(
+		TST_EXP_FAIL_ARR(file_setattr(
 			*tc->dfd, *tc->filename,
 			*tc->ufattr, *tc->usize,
 			tc->at_flags),
-			tc->exp_errno,
+			tc->exp_errs, tc->exp_errs_cnt,
 			"%s", tc->msg);
 	}
 }
-- 
2.53.0.983.g0bb29b3bc5-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
