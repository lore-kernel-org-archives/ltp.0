Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2689FE9A053
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 18:05:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 647643D0733
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 19:05:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F03F3D0414
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 19:05:21 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C89D7140004A
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 19:05:20 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82318702afbso1039559b3a.1
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771524319; x=1772129119; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5KDjPzktmmJVf8IwmbCVzpdSk+PqoNFl5GSpcHuSLmc=;
 b=WsfVsPWVkgXOUFXmo8YFe2Eu7rs4f5Dbr9jd0UbTHZG9QMtuildqMZRUH5n9Ptx9j9
 kZKi7XQNXlFfQSFeAbghyms9aNNBtVM37JTZWXkYHce41D+7POdsLDXyLj54ZPYaU1Qj
 XZAR2u+t+BRxm20Sw5dTW3SMtvYMBfKs12MAyhjU+OtBYeZKb/4l+nhOT6l20yy0DRUq
 DOiIXOP1MFtD9CCNL1pWfRrL2bszZM4MmaRNMmPbdvW5Bzc5qE3OFc/R1CdzlChti8tE
 ZU2Buda7lPKm4TCN9+kIbXumTE1jXnjncwqs6jQraJAmIH2Euos18NFIn5tcRV5cOY6R
 e6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771524319; x=1772129119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5KDjPzktmmJVf8IwmbCVzpdSk+PqoNFl5GSpcHuSLmc=;
 b=U/AvlYAI1fs7SNj6bE200CPge6/RJyJ1deEmXtUB56+Gb6uIIzHfsZTfR9zrAjfF1w
 c0I1PqmXXptvY9EqKHGyCbxjNqhJ1emTecE6G9boqWuVZxnvf1asLkw1H21MR3xmEnK6
 eZ0EUZYdyDvfuZTIblLGNnVQiJpQoX+3olFBseul03znOlHoYWFWuj4yJ1ZkXovY/mYj
 dfqjV1tjWIkvtmucUkr5g3Nw+bc6OTD0/t3d0yaGmhncGC3HMPpX9FCBEHjPXnipBjSY
 anPaUh6+ua6k0X/UVimr7CIFfuHZ2645pXI0w/9wL3ujWt1nVENyy6R7iHswrc1R6EEy
 ez/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCULob1KawKY/adO/JlzwwlCCqK4oVw2bqlTZ3dmPhODoOrdqO8HBCY5nmg2oT2zXnmpHHY=@lists.linux.it
X-Gm-Message-State: AOJu0Yzl4tLd2DIgRn13gyEwo0SKCauGO8ZC6W+vmOr0cCo9a7XLVzVA
 racMyl8mTq/7+z2YXOyeI7wsr8aOGHhkwrC3Bkax7njZUCQ48X1KRCo9qwdJbSO7eA==
X-Gm-Gg: AZuq6aKTCiDfDKBlMQXI4lB3Thu9uFsz0d0DyJgry+de26sn+0tTOojyDZeijzkBV7N
 ZwPCBGJ4HTUWSJJWc5wKq68BN57JCQwN+oVNoV07+f4kIOEMyZWMZD5qtCWSzhgDT/8ZAANpJMA
 DTikkhnEFUL4jfCXwWeJZCWKUxLIMDVBREWjqfTSx0U0lRSpHHe6KV7HEXi/EmN1O2SF3kGF3Lf
 bu3Er8xR8XhuGd5RRNh0rsmEba9ETKAvBXajfEUfbEn37LfZViRpVlzZhFum8Fx5Zpbns0mo1Xh
 c5h+282abLYeZiOrUAk+8R0XnVjlXXyVCu0M3aqlJTw2elep2si1qTG2WHKwwvNq2i22oKKfdul
 4MfS7z0fAp1AUgHTH9nAJmNNd9IQSKQkznZlpgzsytEqtmPUN8BIlNOOxCQrujBQTOvzeOy/dAm
 3bJhMSvA9Y2yOity8jaxn630RtaI3GxfiY2Ee4R/Jyl6bmBAN5jF/q
X-Received: by 2002:a05:6a00:2307:b0:7ef:3f4e:9176 with SMTP id
 d2e1a72fcca58-824d9612684mr16533845b3a.49.1771524319116; 
 Thu, 19 Feb 2026 10:05:19 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69efdsm19534891b3a.40.2026.02.19.10.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 10:05:18 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Fri, 20 Feb 2026 03:04:53 +0900
Message-ID: <20260219180455.41568-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZc1j_HZeoZRdYi6@yuki.lan>
References: <aZc1j_HZeoZRdYi6@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] inotify: cleanup - limit masks, use SAFE_ wrappers
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

Replace IN_ALL_EVENTS with minimal relevant masks and manual read/write
with SAFE_READ/SAFE_WRITE for better stability and consistency.

inotify12.c intentionally unchanged: raw read() + manual EAGAIN handling
is required to treat missing second event as IN_IGNORED (normal case).

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify01.c | 17 +++--------------
 testcases/kernel/syscalls/inotify/inotify02.c |  5 ++++-
 testcases/kernel/syscalls/inotify/inotify03.c | 16 +++-------------
 testcases/kernel/syscalls/inotify/inotify04.c | 10 +++++-----
 testcases/kernel/syscalls/inotify/inotify05.c | 10 +++-------
 testcases/kernel/syscalls/inotify/inotify07.c | 10 +++-------
 testcases/kernel/syscalls/inotify/inotify08.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify10.c |  4 +---
 8 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 8671b594a..972b1025e 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -55,10 +55,7 @@ void verify_inotify(void)
 	event_set[test_cnt] = IN_OPEN;
 	test_cnt++;

-	if (read(fd, buf, BUF_SIZE) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"read(%d, buf, %d) failed", fd, BUF_SIZE);
-	}
+	SAFE_READ(0, fd, buf, BUF_SIZE);
 	event_set[test_cnt] = IN_ACCESS;
 	test_cnt++;

@@ -70,10 +67,7 @@ void verify_inotify(void)
 	event_set[test_cnt] = IN_OPEN;
 	test_cnt++;

-	if (write(fd, buf, BUF_SIZE) == -1) {
-		tst_brk(TBROK,
-			"write(%d, %s, %d) failed", fd, fname, BUF_SIZE);
-	}
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, BUF_SIZE);
 	event_set[test_cnt] = IN_MODIFY;
 	test_cnt++;

@@ -85,12 +79,7 @@ void verify_inotify(void)
 	 * get list of events
 	 */
 	int len, i = 0, test_num = 0;
-	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) < 0) {
-		tst_brk(TBROK,
-			"read(%d, buf, %zu) failed",
-			fd_notify, EVENT_BUF_LEN);
-
-	}
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	/*
 	 * check events
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 314c1bd49..a842abeee 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -187,7 +187,10 @@ static void setup(void)
 {
 	fd_notify = SAFE_MYINOTIFY_INIT();

-	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", IN_ALL_EVENTS);
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, ".", IN_ATTRIB | IN_CREATE |
+				      IN_OPEN | IN_CLOSE_WRITE |
+				      IN_MOVED_FROM | IN_MOVED_TO |
+				      IN_MOVE_SELF | IN_DELETE);
 	reap_wd = 1;
 }

diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 9bb95addb..5d141fbb5 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -55,7 +55,7 @@ void verify_inotify(void)
 	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
 	mount_flag = 1;

-	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_UNMOUNT | IN_IGNORED);

 	event_set[test_cnt] = IN_UNMOUNT;
 	test_cnt++;
@@ -74,11 +74,7 @@ void verify_inotify(void)
 	}
 	mount_flag = 0;

-	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len < 0) {
-		tst_brk(TBROK | TERRNO,
-			"read(%d, buf, %zu) failed", fd_notify, EVENT_BUF_LEN);
-	}
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	/* check events */
 	test_num = 0;
@@ -125,8 +121,6 @@ void verify_inotify(void)

 static void setup(void)
 {
-	int ret;
-
 	SAFE_MKDIR(mntpoint, DIR_MODE);

 	SAFE_MOUNT(tst_device->dev, mntpoint, tst_device->fs_type, 0, NULL);
@@ -135,11 +129,7 @@ static void setup(void)
 	sprintf(fname, "%s/tfile_%d", mntpoint, getpid());
 	fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);

-	ret = write(fd, fname, 1);
-	if (ret == -1) {
-		tst_brk(TBROK | TERRNO,
-			 "write(%d, %s, 1) failed", fd, fname);
-	}
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, fname, 1);

 	/* close the file we have open */
 	SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 1db38ddf2..1472bcff0 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -81,10 +81,12 @@ void verify_inotify(void)
 	SAFE_MKDIR(TEST_DIR, 00700);
 	close(SAFE_CREAT(TEST_FILE, 00600));

-	wd_dir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, IN_ALL_EVENTS);
+	wd_dir = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_DIR, IN_DELETE_SELF |
+					  IN_ATTRIB | IN_IGNORED);
 	reap_wd_dir = 1;

-	wd_file = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, IN_ALL_EVENTS);
+	wd_file = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, TEST_FILE, IN_DELETE_SELF |
+					   IN_ATTRIB | IN_IGNORED);
 	reap_wd_file = 1;

 	SAFE_RMDIR(TEST_DIR);
@@ -118,9 +120,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, "");
 	test_cnt++;

-	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len == -1)
-		tst_brk(TBROK | TERRNO, "read failed");
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct inotify_event *event;
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index d9bfb05f1..d1e35b735 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -60,12 +60,7 @@ void verify_inotify(void)
 		/*
 		 * get list on events
 		 */
-		len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-		if (len < 0) {
-			tst_brk(TBROK | TERRNO,
-				"read(%d, buf, %zu) failed",
-				fd_notify, EVENT_BUF_LEN);
-		}
+		len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 		/*
 		 * check events
@@ -128,7 +123,8 @@ static void setup(void)

 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);

-	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ACCESS | IN_MODIFY |
+				      IN_OPEN | IN_Q_OVERFLOW);

 	SAFE_FILE_SCANF("/proc/sys/fs/inotify/max_queued_events",
 			"%d", &max_events);
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 66a2f4d37..55d03377c 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -88,12 +88,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, FILE_NAME);
 	test_cnt++;

-	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len == -1 && errno != EAGAIN) {
-		tst_brk(TBROK | TERRNO,
-			"read(%d, buf, %zu) failed",
-			fd_notify, EVENT_BUF_LEN);
-	}
+	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	int i = 0, test_num = 0;
 	while (i < len) {
@@ -151,7 +146,8 @@ static void setup(void)
 	fd_notify = SAFE_MYINOTIFY_INIT1(O_NONBLOCK);

 	/* Setup a watch on an overlayfs lower directory */
-	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, DIR_PATH, IN_ALL_EVENTS);
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, DIR_PATH, IN_ATTRIB | IN_OPEN |
+				      IN_CLOSE_WRITE);
 	reap_wd = 1;

 	SAFE_STAT(DIR_PATH, &buf);
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 4cbb16ce0..e0837cac3 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -86,12 +86,7 @@ void verify_inotify(void)
 	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 	SAFE_TOUCH(OVL_UPPER"/"FILE_NAME, 0644, NULL);

-	int len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len == -1 && errno != EAGAIN) {
-		tst_brk(TBROK | TERRNO,
-			"read(%d, buf, %zu) failed",
-			fd_notify, EVENT_BUF_LEN);
-	}
+	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	int i = 0, test_num = 0;
 	while (i < len) {
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index a78572dff..4c3a1d116 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -143,9 +143,7 @@ static void verify_inotify(unsigned int n)
 		test_cnt++;
 	}

-	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len == -1)
-		tst_brk(TBROK | TERRNO, "read failed");
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct event_t *expected = &event_set[test_num];
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
