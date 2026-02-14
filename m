Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0780EF584E
	for <ltp@archiver.kernel.org>; Sat, 14 Feb 2026 17:53:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31B073D02F9
	for <ltp@archiver.kernel.org>; Sat, 14 Feb 2026 18:53:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 966E13CFB42
 for <ltp@lists.linux.it>; Sat, 14 Feb 2026 18:53:02 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F035F14001E5
 for <ltp@lists.linux.it>; Sat, 14 Feb 2026 18:53:01 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-823075fed75so1141640b3a.1
 for <ltp@lists.linux.it>; Sat, 14 Feb 2026 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771091580; x=1771696380; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3+5EJCkp7WWhMhFbtfDWsFB7Tg1zhVmEH5gNG+rEO0E=;
 b=DSust+yNHT8ga487rLv0GjPveVCHArc0TKFxmmrA8FL0XTIS0DpyOdOdV7P1RkvFaX
 iqGNbB5TyE9YryiWtV74vkxcE6PakeOBHIRL4DXG90ZZYs95QlRDcwKoAOckxDECvrwC
 cNii1Xlu09Jgvtfca1ILCQzke1ZeZaKKONdO7se34nymRBtIQ0kFiGBvLejYo17cI3i9
 FTpAuFjQYX34KW5lvlWpzBEW9hsKylFfv1D6kMvMsJofhozH7ZgeTXRNdciSFQQUB0/8
 Tl86J0eIvcZYajm3JxkIJZudy2MLauyS94nKmBL0HSsXaAuXkrWFcFHeiEQnNadPgGtI
 0u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771091580; x=1771696380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3+5EJCkp7WWhMhFbtfDWsFB7Tg1zhVmEH5gNG+rEO0E=;
 b=jVMJavLz729EJXUpT3PsE9RqAmMt8dv6b13GunICQ1YO8o4hmMZ19zb/VY8lTSyxg9
 4KmYdqh7hWAJuezUNBOa+XkxI6ta0EqrIGu7aNwBhQrUkxi89MCgSudnTJiJtrjdtwvK
 HXjtYUivrQqeDbxYM1aHrH+vJ/sk4gKDIw8W+C5FSqjw8ffep7rPGnGpZH46+EDP5y7z
 mgZK9zzf8KguCyr7oF2bsGRohw/fUrTw9rqAawgHJcdvfsGANSaS9M2NTQsceMyCzyMj
 Tl2QecGKPXW4jWfzjhOuA2LZ4dRgQNOl/aL0cDfksPkTHuakBq7kJjxVyaA20uMu0jCz
 Fxvw==
X-Gm-Message-State: AOJu0YxvGcpt2NgMwjUixG1eS1vs0RZ0vTdvpmAd8w06Tw5kqHBAp8c0
 0IcZSJSTUhGd7d0hcFZ9gSKFoaKKvazHjvJACsFyRw6CXMgOg+JocfMnH7SktvInTw==
X-Gm-Gg: AZuq6aJN+iXVsDdN9RuWWrYzypz4TygK+RceLjXVVD84VVVTM6G5p2wvP4SPZGL5LTf
 45MEmJAaE/4ZVqzkAhZbcoDcBrJsuE87RN/rnx5Y5WQtzN2Gd0JK/O1e+Ff+g5kHkDXjU8xat15
 2Q1+b7bbmF1LOebgBLPr79v3geTao3JpR8EQAwphryDsU9DGsxKQLYt/UFtU2zDAntgfE1HM6L9
 YU4EVMqQzJHLSLuISV0Qbi4RWjAtSgZoUzJJdyvgGKVQ/MtfJmjY5wrvfJdp41KhZDfJ+EL2Sr9
 ghF9/5dbclZWnmaFDqLfcPRoRTPRIo725ySIE/HkuO5Hhd/CNGCjwf6uL5pz2Dvh0TcCwOETdok
 RaG3drlQwqPpM/x6XTGM4C8J7D96EsQ6IdgMaaob5dcDth+190ezBFd1eUz7/6+h9Aj9V4AKLCy
 5Z7bELTrlT/59AvB93AI45pj6FoS+WznxqR+t0BQf0XA==
X-Received: by 2002:a05:6a00:bc10:b0:81f:832a:174 with SMTP id
 d2e1a72fcca58-824d5e1c726mr3260303b3a.16.1771091579841; 
 Sat, 14 Feb 2026 09:52:59 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a3e145sm5527773b3a.16.2026.02.14.09.52.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 09:52:59 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun, 15 Feb 2026 02:52:37 +0900
Message-ID: <20260214175237.13794-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify: cleanup - limit masks, use SAFE_ wrappers
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
 testcases/kernel/syscalls/inotify/inotify01.c | 21 ++++++-------------
 testcases/kernel/syscalls/inotify/inotify02.c |  5 ++++-
 testcases/kernel/syscalls/inotify/inotify03.c | 16 +++-----------
 testcases/kernel/syscalls/inotify/inotify04.c | 10 ++++-----
 testcases/kernel/syscalls/inotify/inotify05.c | 10 +++------
 testcases/kernel/syscalls/inotify/inotify07.c | 10 +++------
 testcases/kernel/syscalls/inotify/inotify08.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify10.c |  4 +---
 8 files changed, 26 insertions(+), 57 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 8671b594a..f58784ffd 100644
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
@@ -143,7 +132,9 @@ static void setup(void)

 	fd_notify = SAFE_MYINOTIFY_INIT();

-	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ALL_EVENTS);
+	wd = SAFE_MYINOTIFY_ADD_WATCH(fd_notify, fname, IN_ATTRIB | IN_OPEN |
+				      IN_ACCESS | IN_CLOSE_NOWRITE | IN_MODIFY |
+				      IN_CLOSE_WRITE);
 	reap_wd = 1;
 }

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
