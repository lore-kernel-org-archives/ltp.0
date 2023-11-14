Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87610C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 07:24:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E29503CE4D2
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 08:24:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D793D3CC2D0
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:47 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01E451000CB4
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 08:23:47 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083cd3917eso43290155e9.3
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 23:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699946626; x=1700551426; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRjqmPoGjqCwEmzdD8zzaVXiSu14ojGr+c4OhtAXAwk=;
 b=cirSfvLUn+MPdGxLZsmsbk1kAGyKMWRFyfv5MP3a9nh1u9zzCYPiy82JXWDfxMDUV2
 OUjZvEf8DXnnrEFH83LpYWTIU7Xg2Ytx7aQl4uCptQvME0ttiT4zYfYRmYuR3IPHa506
 EEMousOfYmqSsXFfexep+ZY4UsYxXU/lTGuO1qzsG3zDvjnjpjRMlWb3kPqSkobzXjtu
 4spVCAdq0vsNAiHT5YlIdc4Uw8urB94Y5tzOVlLkgmUzPTLh0P1pWK8qeMggmB7l99lR
 dYIKJoH6rAXSXkaF1C9FCewQUH47/D0c0jdGlKIMohMwAj3Ll7zQwEJoaPE+5mlWgYmY
 2YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699946626; x=1700551426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRjqmPoGjqCwEmzdD8zzaVXiSu14ojGr+c4OhtAXAwk=;
 b=p/T5CcZAkuJllJryCzi9cJdGdDgaD39VOzGSOxibylp/hWvGevn96spZyP6Mf2LObD
 Q5TPqpwDmpRNh9pvPmWu/zv7NILuYEISCBqxWahadZ7XdGGlPp2QzrIJ7C/9Nknhb+D7
 lAj7bz/yAXXHj+/epwje5W1TaR3Jnkko6ntIlg52ccmY0RVqZ+2emUWxdv5LenYZnM/i
 kwJWO6EVVwDjcGbqQZIH0uLSt888Dr1hTmHjUytmFk7LEY/MSC9mij1Z0I8L+7H8ZWqd
 mxcMX9n6fEwpZhDooqNXBQJbW3DtaMovLBAYKn6rqR0HOD8inP1q9atJjlivjdiDey6k
 qDUA==
X-Gm-Message-State: AOJu0YwfcO/tySju+8RTov30up+vYYBoDDlzk1LDEAdKQPPxXK5pW6/L
 09d29GZkOY/0eSlGdmGjcZQ=
X-Google-Smtp-Source: AGHT+IF5Ft80Fs+HQrM4IsQ/ydzwv31rzgmK+PwjOnWlW6w/TBoqkW5FH+4zU/Ip1FKt58G+gEynYA==
X-Received: by 2002:a05:6000:2c1:b0:32f:c750:6ebc with SMTP id
 o1-20020a05600002c100b0032fc7506ebcmr6321541wry.71.1699946626257; 
 Mon, 13 Nov 2023 23:23:46 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adff409000000b0032f7d7ec4adsm6865681wro.92.2023.11.13.23.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 23:23:45 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Nov 2023 09:23:37 +0200
Message-Id: <20231114072338.1669277-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114072338.1669277-1-amir73il@gmail.com>
References: <20231114072338.1669277-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] fanotify13: Test overlayfs while watching lower fs
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

We already have a test variant when watching upper fs.

Improve test coverage by adding a test variant with overlayfs
(over all supported fs) when watching the lower fs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify13.c     | 25 +++++++++++--------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index a25a360fd..4bcffaab2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -168,10 +168,10 @@ static void do_test(unsigned int number)
 	if (setup_marks(fanotify_fd, tc) != 0)
 		goto out;
 
-	/* Variant #1: watching upper fs - open files on overlayfs */
-	if (tst_variant == 1) {
+	/* Watching base fs - open files on overlayfs */
+	if (tst_variant) {
 		if (mark->flag & FAN_MARK_MOUNT) {
-			tst_res(TCONF, "overlayfs upper fs cannot be watched with mount mark");
+			tst_res(TCONF, "overlayfs base fs cannot be watched with mount mark");
 			goto out;
 		}
 		SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);
@@ -191,7 +191,7 @@ static void do_test(unsigned int number)
 			SAFE_CLOSE(fds[i]);
 	}
 
-	if (tst_variant == 1)
+	if (tst_variant)
 		SAFE_UMOUNT(MOUNT_PATH);
 
 	/* Read events from event queue */
@@ -286,9 +286,10 @@ static void do_setup(void)
 	/*
 	 * Bind mount to either base fs or to overlayfs over base fs:
 	 * Variant #0: watch base fs - open files on base fs
-	 * Variant #1: watch upper fs - open files on overlayfs
+	 * Variant #1: watch lower fs - open lower files on overlayfs
+	 * Variant #2: watch upper fs - open upper files on overlayfs
 	 *
-	 * Variant #1 tests a bug whose fix bc2473c90fca ("ovl: enable fsnotify
+	 * Variants 1,2 test a bug whose fix bc2473c90fca ("ovl: enable fsnotify
 	 * events on underlying real files") in kernel 6.5 is not likely to be
 	 * backported to older kernels.
 	 * To avoid waiting for events that won't arrive when testing old kernels,
@@ -298,7 +299,10 @@ static void do_setup(void)
 	if (tst_variant) {
 		REQUIRE_HANDLE_TYPE_SUPPORTED_BY_KERNEL(AT_HANDLE_FID);
 		ovl_mounted = TST_MOUNT_OVERLAY();
-		mnt = OVL_UPPER;
+		if (!ovl_mounted)
+			return;
+
+		mnt = tst_variant & 1 ? OVL_LOWER : OVL_UPPER;
 	} else {
 		mnt = OVL_BASE_MNTPOINT;
 
@@ -312,7 +316,7 @@ static void do_setup(void)
 
 	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
-	/* Create file and directory objects for testing */
+	/* Create file and directory objects for testing on base fs */
 	create_objects();
 
 	/*
@@ -329,7 +333,8 @@ static void do_setup(void)
 
 static void do_cleanup(void)
 {
-	SAFE_CLOSE(nofid_fd);
+	if (nofid_fd > 0)
+		SAFE_CLOSE(nofid_fd);
 	if (fanotify_fd > 0)
 		SAFE_CLOSE(fanotify_fd);
 	if (bind_mounted) {
@@ -343,7 +348,7 @@ static void do_cleanup(void)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 3,
 	.setup = do_setup,
 	.cleanup = do_cleanup,
 	.needs_root = 1,
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
