Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BCF107BCC9
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 16:07:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F1833E5B3E
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 17:07:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E78003E52AA
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:06:35 +0100 (CET)
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4ED7C1401389
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:06:35 +0100 (CET)
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so25727465ad.0
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773417993; x=1774022793; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MtiXSByGQZT6L5+r3nDWr1VQddJ5835ds9E+NPNZxk=;
 b=BzQkb6E9gcbZzvoVV2PhoBUBHcJgJSpSSKZBtwcEYxIicbTUM8xtUZdJN5iq4xNYhz
 Zffe7YNFKq1I4dCcC4PB1c5eijdrsh6FzJTXuRyrJOU+wZTEE22Q5h6nUQNE4cvpvZwl
 SQD97qpEEUWj5pFlmGySZW5UZ0eTHg+cpnj7xjNaz+wa9Nhjr/a6CUyoRu49NFoz9ZVj
 dcDu8eOYp6lgpl1/IiRfEotFz/NnjzzUqllWqskuRquGCpZ6mwuc6DHbiHfl9KxzTgeE
 poheNkSyG0VBm4hWQPwTTPnWqRVpw8Qowsyzv1Ua6iGlxK90M++WPlJZze7wJHb45u8g
 Z+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773417993; x=1774022793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4MtiXSByGQZT6L5+r3nDWr1VQddJ5835ds9E+NPNZxk=;
 b=fu8+fSEWOvLNmQjoxYrBC26Rk1czbPtxZqXuq6AdlggjEvrrLa/DBJjchLF8AFG+Qz
 ppoVx7CoOs+hIpFKtkJ4ljnwJEMEq2rR+F07pKy+/mX1nQKzZMS7ocHIEQyPoMoCsX6h
 vj4gh8TvcSGDYmqT1zliD7pDSucctGKvKex49bjA3d0J0ho1YdzOlN9cb4pAop2tajPP
 yAHwbyGX5eoOUnmvId2BFHEyGrFpjQHpVWTUm1GZUDlVThWcSIFyiDNccUDSowEHijP2
 +sqOy1QH/kD2BMZ0maAXVU+iWjl7LQo4cDmYcoxJ2gU4hPQCHR38M/Bo484LE7vo3TIf
 tvng==
X-Gm-Message-State: AOJu0YwJ+cYWpcrIrweRaSQkiPpCio7xrugNwkQa5wais+OZDrbVyzD3
 jCKcKUg1OaNj2DyL1X7YW23Vd/1vhSuN1DYvm1eu/caOC8sRb3nhzak=
X-Gm-Gg: ATEYQzwHsyfp/u5sKKVudN1NuvnIYUGqcDhS5vxswhKH4s4K4Ic/VHXEopUftQ87Og6
 9Bo1u2422Nza3DyqDoC9y/6CdIkbWu/ccZ9PlTbTWePPOABaFieY1/jnObFevKCMWkvxDVpj7eE
 ORi/Ena3wjyEPYTrs/1OCKN6r9HbXjwgFSHDqfErnKxvoqJnfjzK7FrhPEKNmIaC9PfQ0np36Ky
 cNPzZwjznsjSRS01BXkUPmP0AeneA56Nurn2u05vIisbmgmo/zDAWL0bYr+d1kH9pm4FC1sHk95
 VGZa2PBighws+cw19ypmHKshGv9ESWhKXYN4ns+J/gGk12KHawZxwKT1J5Q30c/6/67HGC2agCw
 sII5a0WX1pkS10SDUZP9/XczPbP0dvtqDigmV37V6n+NKfROGKnQJloNCqCvnMBp8Ydiy6CNgtf
 z0+mYguPpRbt59r8DmXbZezLwmvRfcGTdIMrO2mvNgdw==
X-Received: by 2002:a17:902:e850:b0:2ae:4ac7:bcb9 with SMTP id
 d9443c01a7336-2aeba45e14dmr73812075ad.9.1773417993474; 
 Fri, 13 Mar 2026 09:06:33 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece630b8asm26230775ad.40.2026.03.13.09.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:06:33 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com,
	chrubis@suse.cz
Date: Sat, 14 Mar 2026 01:05:16 +0900
Message-ID: <20260313160520.39745-2-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260313160520.39745-1-always.starving0@gmail.com>
References: <69a70250.050a0220.3bc433.165d@mx.google.com>
 <20260313160520.39745-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] inotify: fix make check findings
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fix various issues reported by `make check` in inotify syscall tests:

- Fix SPDX license comment style
- Make local functions and variables static
- Replace DIR_MODE macro with an octal permission value
- Fix minor style and prototype issues

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify.h   |  5 +++--
 testcases/kernel/syscalls/inotify/inotify01.c |  4 +++-
 testcases/kernel/syscalls/inotify/inotify02.c |  8 +++++---
 testcases/kernel/syscalls/inotify/inotify03.c |  5 +++--
 testcases/kernel/syscalls/inotify/inotify04.c | 13 ++++++-------
 testcases/kernel/syscalls/inotify/inotify05.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify07.c |  8 ++++----
 testcases/kernel/syscalls/inotify/inotify08.c |  5 +++--
 testcases/kernel/syscalls/inotify/inotify10.c |  8 ++++----
 9 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify.h b/testcases/kernel/syscalls/inotify/inotify.h
index dbf814902..7ac4f4908 100644
--- a/testcases/kernel/syscalls/inotify/inotify.h
+++ b/testcases/kernel/syscalls/inotify/inotify.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * inotify testcase common definitions.
  *
@@ -51,7 +51,8 @@ static inline int safe_myinotify_init(const char *file, const int lineno, int fd
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
index 423676bf9..67e01d14a 100644
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

@@ -112,10 +113,12 @@ void verify_inotify(void)
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
index 2d7f34bae..ed6ba5d36 100644
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
@@ -122,6 +121,7 @@ void verify_inotify(void)

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
index f0acd9e91..3da45fc6c 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -65,7 +65,7 @@ static const char mntpoint[] = OVL_BASE_MNTPOINT;
 static struct event_t event_set[EVENT_MAX];
 static char event_buf[EVENT_BUF_LEN];

-void verify_inotify(void)
+static void verify_inotify(void)
 {
 	int test_cnt = 0;

@@ -89,10 +89,11 @@ void verify_inotify(void)
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
index 0a94ead15..80b7a825b 100644
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
@@ -150,6 +149,7 @@ static void verify_inotify(unsigned int n)
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
