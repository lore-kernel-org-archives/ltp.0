Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5005FFD006D
	for <ltp@archiver.kernel.org>; Sun,  1 Mar 2026 16:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82F153D694A
	for <ltp@archiver.kernel.org>; Sun,  1 Mar 2026 17:58:13 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A30C3CDA7B
 for <ltp@lists.linux.it>; Sun,  1 Mar 2026 17:57:53 +0100 (CET)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9ECC9600834
 for <ltp@lists.linux.it>; Sun,  1 Mar 2026 17:57:52 +0100 (CET)
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-82735a41985so2091748b3a.2
 for <ltp@lists.linux.it>; Sun, 01 Mar 2026 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772384271; x=1772989071; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=0JK2EoPBCeuePn3INicLcWi4jARvENHq7skxOtqLbvU=;
 b=N6/KePZDPisvwd/LOSCI+IZjhGDxKHELCzBXzM4fgv4ibqnTb8dGfSzW7kbc/Ide13
 vm2blr9WU8/Nd2RGjhB/pnAUxoClplO5MXvvXAnnKXDsz9BI/7QH5c9whoC2FwWr/m2W
 Iq0S8D3Vb3lLQ+2VunkmKVqffyoLZo4ke2KHaoIA/tmvfYjrvWkYPCuxNac7jT2VaC0B
 l79MyTNLRUZyClKyPitrwzlBqZlUTtg+669fE4Wf1Mef+CtJHLonHIvlW9C+jK9co1rj
 4cb6Mg4jr3r9S6w9xtlxDC9uRQv7PifPRyT8YN+JkuOZunnsFr2Bp+IwOVv7IkBt98+u
 oVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772384271; x=1772989071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JK2EoPBCeuePn3INicLcWi4jARvENHq7skxOtqLbvU=;
 b=M1ekEnmcUbybVT47mWE2OLjXuDmroIS2Xd8VyMq/iEkfMmWJxycJSe+s8wWc7Gn8lT
 zoCG9kZ35Lqb6YGt7unWHJ0TOY+aMMeWmnOJa1nA5ymKkW5m48yFHbDYgwacdDy50fMY
 QihvdDN7TjQs0druD9ifl4LiYc9cnflU6LmwtWZv7gFG9NcxmyZg/LMojJ7nTTMSb2yU
 iRAcrMtHSTxrsO3BkiY8ESmptVVUx4t04D3hOswjLa41n+J1F04bCVA7ayQiuIgUsd/Q
 fIarzc0c+mqhOBmY2/oJyTJ7YCLJUoCqC0ufqgqzXJ5COaPtW5gi9eUo2Q6saEUUCHY7
 sacg==
X-Gm-Message-State: AOJu0YyQRlvV1yQvZ7bg0kCvVMG5fPXgfkwdrJzNMCG2WZ+Rm4yBcKqu
 pdPkkB6OAwn/tCNu23gvvgumlIB2+4nP4/+FlPH0V4Ow4JkB/m9WFRsVwflBrtU=
X-Gm-Gg: ATEYQzxeQ6J/Sa2or4wsGDUXTdXOAy5zwdj5RG74OG5QItoewW3NhN6FyE1nhFLvEKf
 p9rCMeHGR694cTo2UHOZql+PiLinxanHecXyXl+4rqSmTD82p37NyjyewxmnZBPmPR80QpPVcBm
 8B+7YuO1JONDqohs9tJaSAHawUgJddvTZ+YLot1DMdtKSDoUZhAO+hpr1fTFcFG7A5jT3Jm+SFx
 PX8pzBgqI77Y0YmZuiN9FgDEIwtWRBC4sfWNcdWq1o+BRucxvlDdzBnQDQnxlTCAzfHO8ILIQDR
 q+KLlYEkcZsx8O5+lG3UI9C+UWYl4qRSPndtP1AO5ZKzDgvQOSar626pGK+FfyCdY0QlWomTqDK
 f6qPBex7KuOazhlCAAPbHfWL7x0FvA00eJmH3Lt7oHC3Nsk7Je7lr52EXNZZVQfDE/57dVS79EY
 YfKZYvjVeoS/GdwSHbeWbzkRtrDvY24amjE9Ycof1gtQ==
X-Received: by 2002:a05:6a00:1a0b:b0:81b:c599:7593 with SMTP id
 d2e1a72fcca58-8274da5fdc3mr7844757b3a.60.1772384270181; 
 Sun, 01 Mar 2026 08:57:50 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4d8dbsm13524351b3a.5.2026.03.01.08.57.49
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 08:57:49 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Mon,  2 Mar 2026 01:57:24 +0900
Message-ID: <20260301165726.4984-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify: clean up build and make check findings
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

Fix various issues reported by `make` and `make check`:

- Drop ENOSYS-based logic and rely on TERRNO reporting
- Silence known format-truncation warnings locally
- Clean up string handling and permissions
- Fix minor style and prototype issues

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/Makefile    |  1 +
 testcases/kernel/syscalls/inotify/inotify.h   | 13 +++-------
 testcases/kernel/syscalls/inotify/inotify01.c |  4 ++-
 testcases/kernel/syscalls/inotify/inotify02.c | 26 ++++++++++---------
 testcases/kernel/syscalls/inotify/inotify03.c |  5 ++--
 testcases/kernel/syscalls/inotify/inotify04.c | 23 ++++++++--------
 testcases/kernel/syscalls/inotify/inotify05.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify07.c | 16 ++++++------
 testcases/kernel/syscalls/inotify/inotify08.c |  5 ++--
 testcases/kernel/syscalls/inotify/inotify10.c | 18 +++++++------
 10 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/Makefile b/testcases/kernel/syscalls/inotify/Makefile
index 16d430864..57124c739 100644
--- a/testcases/kernel/syscalls/inotify/Makefile
+++ b/testcases/kernel/syscalls/inotify/Makefile
@@ -4,6 +4,7 @@
 top_srcdir		?= ../../../..

 include $(top_srcdir)/include/mk/testcases.mk
+inotify02: CFLAGS+=-Wno-format-truncation
 inotify09: CFLAGS+=-pthread
 inotify09: LDLIBS+=-lrt
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index dbf814902..1bc36defa 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * inotify testcase common definitions.
  *
@@ -33,14 +33,8 @@
 static inline int safe_myinotify_init(const char *file, const int lineno, int fd)
 {
 	if (fd < 0) {
-		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"%s:%d: inotify is not configured in this kernel",
+		tst_brk(TBROK | TERRNO, "%s:%d: inotify_init failed",
 				file, lineno);
-		} else {
-			tst_brk(TBROK | TERRNO, "%s:%d: inotify_init failed",
-				file, lineno);
-		}
 	}
 	return fd;
 }
@@ -51,7 +45,8 @@ static inline int safe_myinotify_init(const char *file, const int lineno, int fd
 #define SAFE_MYINOTIFY_INIT1(flags) \
 	safe_myinotify_init(__FILE__, __LINE__, myinotify_init1(flags))

-static inline int safe_myinotify_watch(const char *file, const int lineno, int wd, int fd, const char* fname, const char* mask)
+static inline int safe_myinotify_watch(const char *file, const int lineno, int wd,
+				       int fd, const char *fname, const char *mask)
 {
 	if (wd < 0) {
 		tst_brk(TBROK | TERRNO,
diff --git a/testcases/kernel/syscalls/inotify/inotify01.c b/testcases/kernel/syscalls/inotify/inotify01.c
index 972b1025e..12aadf862 100644
--- a/testcases/kernel/syscalls/inotify/inotify01.c
+++ b/testcases/kernel/syscalls/inotify/inotify01.c
@@ -40,7 +40,7 @@ static unsigned int event_set[EVENT_MAX];

 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int test_cnt = 0;

@@ -79,6 +79,7 @@ void verify_inotify(void)
 	 * get list of events
 	 */
 	int len, i = 0, test_num = 0;
+
 	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	/*
@@ -86,6 +87,7 @@ void verify_inotify(void)
 	 */
 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 314c1bd49..5f288b270 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -43,6 +43,7 @@ struct event_t {
 	char name[BUF_SIZE];
 	unsigned int mask;
 };
+
 #define FILE_NAME1 "test_file1"
 #define FILE_NAME2 "test_file2"

@@ -50,7 +51,7 @@ static struct event_t event_set[EVENT_MAX];

 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	unsigned int stored_cookie = UINT_MAX;

@@ -61,40 +62,40 @@ void verify_inotify(void)
 	 */
 	SAFE_CHMOD(".", 0755);
 	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	fd = SAFE_CREAT(FILE_NAME1, 0755);
 	event_set[test_cnt].mask = IN_CREATE;
-	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME1);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_OPEN;
-	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME1);
 	test_cnt++;

 	SAFE_CLOSE(fd);
 	event_set[test_cnt].mask = IN_CLOSE_WRITE;
-	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME1);
 	test_cnt++;

 	SAFE_RENAME(FILE_NAME1, FILE_NAME2);
 	event_set[test_cnt].mask = IN_MOVED_FROM;
-	strcpy(event_set[test_cnt].name, FILE_NAME1);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME1);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_MOVED_TO;
-	strcpy(event_set[test_cnt].name, FILE_NAME2);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME2);
 	test_cnt++;

 	SAFE_GETCWD(fname1, BUF_SIZE);
 	snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
 	SAFE_RENAME(fname1, fname2);
 	event_set[test_cnt].mask = IN_MOVE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	SAFE_UNLINK(FILE_NAME2);
 	event_set[test_cnt].mask = IN_DELETE;
-	strcpy(event_set[test_cnt].name, FILE_NAME2);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME2);
 	test_cnt++;

 	/*
@@ -108,14 +109,16 @@ void verify_inotify(void)

 	SAFE_RENAME(fname3, fname1);
 	event_set[test_cnt].mask = IN_MOVE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	int len, i = 0, test_num = 0;
+
 	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
@@ -125,8 +128,7 @@ void verify_inotify(void)
 				event->cookie, event->len, event->len,
 				event->name);

-		} else if ((event_set[test_num].mask == event->mask)
-				&&
+		} else if ((event_set[test_num].mask == event->mask) &&
 				(!strncmp
 				 (event_set[test_num].name, event->name,
 				  event->len))) {
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index a7974dd57..8a5103bd8 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -40,12 +40,12 @@ static unsigned int event_set[EVENT_MAX];

 static char event_buf[EVENT_BUF_LEN];

-#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
+#define DIR_MODE	0750

 static char *mntpoint = "mntpoint";
 static int mount_flag;

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int ret;
 	int len, i, test_num;
@@ -81,6 +81,7 @@ void verify_inotify(void)
 	i = 0;
 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= (test_cnt - 1)) {
 			tst_res(TFAIL,
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 947623952..18a1c4a6e 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -35,7 +35,6 @@
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))

-
 #define BUF_SIZE 256

 struct event_t {
@@ -46,11 +45,11 @@ struct event_t {
 #define	TEST_DIR	"test_dir"
 #define	TEST_FILE	"test_file"

-struct event_t event_set[EVENT_MAX];
+static struct event_t event_set[EVENT_MAX];

-char event_buf[EVENT_BUF_LEN];
+static char event_buf[EVENT_BUF_LEN];

-int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;
+static int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;

 static void cleanup(void)
 {
@@ -73,7 +72,7 @@ static void setup(void)
 	fd_notify = SAFE_MYINOTIFY_INIT();
 }

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int i = 0, test_num = 0, len;
 	int test_cnt = 0;
@@ -91,10 +90,10 @@ void verify_inotify(void)
 	reap_wd_dir = 0;

 	event_set[test_cnt].mask = IN_DELETE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;
 	event_set[test_cnt].mask = IN_IGNORED;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	SAFE_UNLINK(TEST_FILE);
@@ -108,20 +107,21 @@ void verify_inotify(void)
 	 * understand how Unix works.
 	 */
 	event_set[test_cnt].mask = IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	event_set[test_cnt].mask = IN_DELETE_SELF;
-	strcpy(event_set[test_cnt].name, TEST_FILE);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", TEST_FILE);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_IGNORED;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
@@ -130,8 +130,7 @@ void verify_inotify(void)
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len, event->name);

-		} else if ((event_set[test_num].mask == event->mask)
-			   &&
+		} else if ((event_set[test_num].mask == event->mask) &&
 			   (!strncmp
 			    (event_set[test_num].name, event->name,
 			     event->len))) {
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 82a4c7bdc..1a38056f0 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -36,7 +36,7 @@ static int max_events;

 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int i;
 	int len, stop;
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index b4000f353..258e14b92 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -65,7 +65,7 @@ static const char mntpoint[] = OVL_BASE_MNTPOINT;
 static struct event_t event_set[EVENT_MAX];
 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int test_cnt = 0;

@@ -74,25 +74,26 @@ void verify_inotify(void)
 	 */
 	SAFE_CHMOD(DIR_PATH, 0755);
 	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 	test_cnt++;

 	SAFE_TOUCH(FILE_PATH, 0644, NULL);
 	event_set[test_cnt].mask = IN_OPEN;
-	strcpy(event_set[test_cnt].name, FILE_NAME);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_CLOSE_WRITE;
-	strcpy(event_set[test_cnt].name, FILE_NAME);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, FILE_NAME);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME);
 	test_cnt++;

 	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
-
 	int i = 0, test_num = 0;
+
 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
@@ -101,8 +102,7 @@ void verify_inotify(void)
 				"name=\"%.*s\"", event->wd, event->mask,
 				event->cookie, event->len, event->len,
 				event->name);
-		} else if ((event_set[test_num].mask == event->mask)
-				&&
+		} else if ((event_set[test_num].mask == event->mask) &&
 				(!strncmp
 				 (event_set[test_num].name, event->name,
 				  event->len))) {
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index e0837cac3..154654ce3 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -63,7 +63,7 @@ static const char mntpoint[] = OVL_BASE_MNTPOINT;
 static struct event_t event_set[EVENT_MAX];
 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int test_cnt = 0;

@@ -87,10 +87,11 @@ void verify_inotify(void)
 	SAFE_TOUCH(OVL_UPPER"/"FILE_NAME, 0644, NULL);

 	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
-
 	int i = 0, test_num = 0;
+
 	while (i < len) {
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 4c3a1d116..838ae29a3 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -32,7 +32,6 @@
 #define EVENT_SIZE  (sizeof(struct inotify_event))
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))

-
 #define BUF_SIZE 256

 struct event_t {
@@ -75,11 +74,11 @@ static struct tcase {
 	},
 };

-struct event_t event_set[EVENT_MAX];
+static struct event_t event_set[EVENT_MAX];

-char event_buf[EVENT_BUF_LEN];
+static char event_buf[EVENT_BUF_LEN];

-int fd_notify, fd_notify_other;
+static int fd_notify, fd_notify_other;

 static void verify_inotify(unsigned int n)
 {
@@ -121,25 +120,27 @@ static void verify_inotify(unsigned int n)
 	if (wd_parent && (tc->parent_mask & IN_ATTRIB)) {
 		event_set[test_cnt].wd = wd_parent;
 		event_set[test_cnt].mask = tc->parent_mask | IN_ISDIR;
-		strcpy(event_set[test_cnt].name, TEST_DIR);
+		snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name),
+			 "%s", TEST_DIR);
 		test_cnt++;
 	}
 	if (wd_subdir && (tc->subdir_mask & IN_ATTRIB)) {
 		event_set[test_cnt].wd = wd_subdir;
 		event_set[test_cnt].mask = tc->subdir_mask | IN_ISDIR;
-		strcpy(event_set[test_cnt].name, "");
+		snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 		test_cnt++;
 	}
 	if (wd_parent && (tc->parent_mask & IN_ATTRIB)) {
 		event_set[test_cnt].wd = wd_parent;
 		event_set[test_cnt].mask = tc->parent_mask;
-		strcpy(event_set[test_cnt].name, TEST_FILE);
+		snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name),
+			 "%s", TEST_FILE);
 		test_cnt++;
 	}
 	if (wd_child && (tc->child_mask & IN_ATTRIB)) {
 		event_set[test_cnt].wd = wd_child;
 		event_set[test_cnt].mask = tc->child_mask;
-		strcpy(event_set[test_cnt].name, "");
+		snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", "");
 		test_cnt++;
 	}

@@ -148,6 +149,7 @@ static void verify_inotify(unsigned int n)
 	while (i < len) {
 		struct event_t *expected = &event_set[test_num];
 		struct inotify_event *event;
+
 		event = (struct inotify_event *)&event_buf[i];
 		if (test_num >= test_cnt) {
 			tst_res(TFAIL,
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
