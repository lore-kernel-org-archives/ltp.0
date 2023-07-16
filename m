Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0ACEB64DA
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 05:36:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3CA43CACF0
	for <ltp@archiver.kernel.org>; Sun, 16 Jul 2023 07:36:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A084A3CDDF6
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:40 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E742E600732
 for <ltp@lists.linux.it>; Sun, 16 Jul 2023 07:35:39 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-316f9abf204so694281f8f.1
 for <ltp@lists.linux.it>; Sat, 15 Jul 2023 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689485739; x=1692077739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaGMWEvhFWfhumRlvv5oHQn0PZ/jE2wcL1i3MyNAwXk=;
 b=Hsg+zeJbMyGfadsQaiANgsg4I1l9ioA4QeljCGd6U6Avx0IJ/hFB/HdvEzXETZJfQj
 Ft9zDHDCeBHs25NZDzEsb0jalOZoGIl9v6KZlbJ0p3/ZdOw/FnGh3xN39Q21XpHg2Pye
 u91hqcvJ+t3zm6ilGtCQRcA6lQVr3+P9i4xZN9U2Gr0F/joQk0SqRFPXWrI7o2duq8eo
 CJjIcNImgECICMcJbK8PE+iSn9QGX7ddeW6vkR1Wf7jpas38HPBWF0Ge1XC5COJizR8O
 80zUftshAs9x5agguc44zuLC1ixBuBxacaVWpQekSKK8PCoxz/z2wjR/Jiv6/7dsk6oO
 IyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689485739; x=1692077739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaGMWEvhFWfhumRlvv5oHQn0PZ/jE2wcL1i3MyNAwXk=;
 b=ZOGOY1aQFzlSWdT1V1Gp85lb+pA2MBQ+MEA2UoIs1sbS+Tjw01+dCFQ9G9rqK24Rub
 JVwN04ABfpXgFY8mOWBrPd4pXGH9OB+SJtBDYU82nCFur0iBD6I0pT+QRqlSTJEziORa
 wSILc106ApoDpBmEVxsDHHkdl2cFmIuAmh+iXNKMA2e4URmijIEJOhDU40H7GUTcdSii
 bdVi1ZQnFR0cI/QCjNtghwJuMGYlGJaXLrIhdCS0hetlCfyGrTUioyTdwZARkpb+Pul2
 4eaZB87eIf4q00NC9Wfn216AB9krfed/2hGB7IYhySmH16uF8m2IDTq6X74DDIv1D/tz
 cLyg==
X-Gm-Message-State: ABy/qLaSka8Hi9ZcvBgnkrpjYF0Oa5eddlVQITBkIRy8teYMmPLBWYAU
 7ys3LdLARwQDdaZQBnuEo3Iq9s5NI9o=
X-Google-Smtp-Source: APBJJlEeWYj9Gn6zZW8Xjb6GIHZXRxQEvzSiPy3lXCMOPjzxGAyGQFMSjTZbPCoolotnxrtMRrmKcA==
X-Received: by 2002:adf:e646:0:b0:30e:3f55:ebc9 with SMTP id
 b6-20020adfe646000000b0030e3f55ebc9mr7899440wrn.13.1689485739355; 
 Sat, 15 Jul 2023 22:35:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a5d4682000000b00313e2abfb8dsm15556087wrq.92.2023.07.15.22.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 22:35:39 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Sun, 16 Jul 2023 08:35:30 +0300
Message-Id: <20230716053530.1629416-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230716053530.1629416-1-amir73il@gmail.com>
References: <20230716053530.1629416-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] fanotify14: Test disallow sb/mount mark on
 anonymous pipe
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This case was retroactively disallowed.

This test is meant to encourage the backporting of commit 69562eb0bd3e
("fanotify: disallow mount/sb marks on kernel internal pseudo fs") to
all stable kernels.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify14.c     | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 2c6f6afea..4596511f0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -19,6 +19,9 @@
  *
  *     ceaf69f8eadc fanotify: do not allow setting dirent events in mask of non-dir
  *     8698e3bab4dd fanotify: refine the validation checks on non-dir inode mask
+ *
+ * The pipes test cases are regression tests for commit:
+ *     69562eb0bd3e fanotify: disallow mount/sb marks on kernel internal pseudo fs
  */
 
 #define _GNU_SOURCE
@@ -40,6 +43,7 @@
 
 #define FLAGS_DESC(flags) {(flags), (#flags)}
 
+static int pipes[2] = {-1, -1};
 static int fanotify_fd;
 static int fan_report_target_fid_unsupported;
 static int ignore_mark_unsupported;
@@ -60,6 +64,7 @@ static struct test_case_t {
 	/* when mask.flags == 0, fanotify_init() is expected to fail */
 	struct test_case_flags_t mask;
 	int expected_errno;
+	int *pfd;
 } test_cases[] = {
 	/* FAN_REPORT_FID without class FAN_CLASS_NOTIF is not valid */
 	{
@@ -216,6 +221,22 @@ static struct test_case_t {
 		.mask = FLAGS_DESC(FAN_OPEN),
 		.expected_errno = EINVAL,
 	},
+	/* mount mark on anonymous pipe is not valid */
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_MOUNT),
+		.mask = { FAN_ACCESS, "anonymous pipe"},
+		.pfd = pipes,
+		.expected_errno = EINVAL,
+	},
+	/* filesystem mark on anonymous pipe is not valid */
+	{
+		.init = FLAGS_DESC(FAN_CLASS_NOTIF),
+		.mark = FLAGS_DESC(FAN_MARK_FILESYSTEM),
+		.mask = { FAN_ACCESS, "anonymous pipe"},
+		.pfd = pipes,
+		.expected_errno = EINVAL,
+	},
 };
 
 static void do_test(unsigned int number)
@@ -253,11 +274,17 @@ static void do_test(unsigned int number)
 
 	/* Set mark on non-dir only when expecting error ENOTDIR */
 	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
+	int dirfd = AT_FDCWD;
+
+	if (tc->pfd) {
+		dirfd = tc->pfd[0];
+		path = NULL;
+	}
 
-	tst_res(TINFO, "Testing fanotify_mark(FAN_MARK_ADD | %s, %s)",
+	tst_res(TINFO, "Testing %s with %s",
 		tc->mark.desc, tc->mask.desc);
 	TST_EXP_FD_OR_FAIL(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark.flags,
-					 tc->mask.flags, AT_FDCWD, path),
+					 tc->mask.flags, dirfd, path),
 					 tc->expected_errno);
 
 	/*
@@ -299,12 +326,18 @@ static void do_setup(void)
 
 	/* Create temporary test file to place marks on */
 	SAFE_FILE_PRINTF(FILE1, "0");
+	/* Create anonymous pipes to place marks on */
+	SAFE_PIPE2(pipes, O_CLOEXEC);
 }
 
 static void do_cleanup(void)
 {
 	if (fanotify_fd > 0)
 		SAFE_CLOSE(fanotify_fd);
+	if (pipes[0] != -1)
+		SAFE_CLOSE(pipes[0]);
+	if (pipes[1] != -1)
+		SAFE_CLOSE(pipes[1]);
 }
 
 static struct tst_test test = {
@@ -319,6 +352,7 @@ static struct tst_test test = {
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "ceaf69f8eadc"},
 		{"linux-git", "8698e3bab4dd"},
+		{"linux-git", "69562eb0bd3e"},
 		{}
 	}
 };
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
