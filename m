Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5409AEB64D9
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 14:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5220F3C9A2D
	for <ltp@archiver.kernel.org>; Mon, 10 Jul 2023 16:14:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B56A63C2A18
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 16:14:08 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A9856006E4
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 16:14:08 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82de7so33391095e9.1
 for <ltp@lists.linux.it>; Mon, 10 Jul 2023 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688998447; x=1691590447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KtwApC2IeF7ZZAycZtIXUlgrC3sWKo1yrJH9+Do4iPo=;
 b=ndXdYXe2mOSJB3Zhktzc/QvzwSKuSMaOZBJy+2Yhx4Tw1klYmWZ4ztE78DW0+IpX7j
 ua5Br+oNJnYAnnLCYJeJP0o3RarCoqBikT4ZpLIo1+FvHDTzgFJzXxD/8sti73d4R7N8
 DlYJidDwNSNnlUP9ayO/RASNLTDL2lyKPzBDIJp7P8jfU0P5KrxkWxmTjr/nTyYL5b3B
 WHYT3cFTohY6AjYbpe1mtk6L30/wUn7HCPPRKx71XqDnVx5ls+KXjxvE+AK32MdHOprW
 kl5ai9wEHwaTOrAGNTZ9m5OnPYpV6YA0WH53ys1I6epvrRiaJAtaikbyRE9q2RTebGj4
 gbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688998447; x=1691590447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KtwApC2IeF7ZZAycZtIXUlgrC3sWKo1yrJH9+Do4iPo=;
 b=kJZkrYBEYiF7ZJ+ZK52lou0H6j03bkEd8pFYnFtnIz4XefAvJ1WbJPwLcOLgVaEOEw
 4FOC2KYtHPhDkvxNQnWu+ZUkzYmGRli+1GA0s2a6JCaeJH/ST63exU9roJvf/T80N8NE
 slHEvuazsnTyqg6zZ6PSROgCd/aNTbwoUD24JJKAD5O2xF1vNwU+APO9ESk+vyhINfgj
 0G4cF81VUM3Ow47f+rRCh8jbFWCkpyny39hYMr6HMFi0eWUy+rAMOsbr1IwVZUMAsYQw
 jwT8Z5i0JoRKo+FliiHMikOqqwjGVdVEugdkeGmGiQ+EK85ozAVx9QmBfbgz56oZO50j
 FF8w==
X-Gm-Message-State: ABy/qLbyoOKU6OOQ2O6hjEbuJZyyk0Z5y5ktqBo6jaBVef7eEyafRAz6
 DIKkG6KznEBcbWGC5j3S2RITorkteEw=
X-Google-Smtp-Source: APBJJlHuK82CZMvIRVrJQjRKgSIjc+td0zIk+XWX15Kf5n91gHSOpEtCuHHbdeoQROMYnSkVXNnC+g==
X-Received: by 2002:a1c:4c06:0:b0:3fb:acbe:da5d with SMTP id
 z6-20020a1c4c06000000b003fbacbeda5dmr11476713wmf.4.1688998447289; 
 Mon, 10 Jul 2023 07:14:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local
 (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c021900b003fbc30825fbsm10435603wmi.39.2023.07.10.07.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 07:14:06 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Jul 2023 17:14:03 +0300
Message-Id: <20230710141403.1155151-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify14: Test disallow sb/mount mark on anonymous
 pipe
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

Petr,

This tests for a behavior that we consider broken since the dawn of
fanotify.

The fix was merged to v6.5-rc1.
I've already posted backport patches for kernels > v5.0.
I am not planning to post backport patches for older kernels.

Even though the two new test cases do not use FAN_REPORT_FID,
fanotify14 requires FAN_REPORT_FID, so it is not going to run these
test cases on kernel < v5.1 anyway.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify14.c     | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index bfa0349fe..063a9f96f 100644
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
 	{FLAGS_DESC(FAN_CLASS_CONTENT | FAN_REPORT_FID), {}, {}, EINVAL},
@@ -148,6 +153,16 @@ static struct test_case_t {
 	{FLAGS_DESC(FAN_CLASS_NOTIF),
 		FLAGS_DESC(FAN_MARK_FILESYSTEM | FAN_MARK_IGNORE),
 		FLAGS_DESC(FAN_OPEN), EINVAL},
+
+	/* mount mark on anonymous pipe is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF),
+		FLAGS_DESC(FAN_MARK_MOUNT),
+		{ FAN_ACCESS, "anonymous pipe"}, EINVAL, pipes},
+
+	/* filesystem mark on anonymous pipe is not valid */
+	{FLAGS_DESC(FAN_CLASS_NOTIF),
+		FLAGS_DESC(FAN_MARK_FILESYSTEM),
+		{ FAN_ACCESS, "anonymous pipe"}, EINVAL, pipes},
 };
 
 static void do_test(unsigned int number)
@@ -185,11 +200,17 @@ static void do_test(unsigned int number)
 
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
@@ -231,12 +252,18 @@ static void do_setup(void)
 
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
@@ -251,6 +278,7 @@ static struct tst_test test = {
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
