Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C6AF53D6D
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 15:45:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F156F3E60A0
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 16:45:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 565493E52D0
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:45:23 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AECE01A004B1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 16:45:22 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82a124f3a5bso2464120b3a.0
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773675921; x=1774280721; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJmY1D14t4FUgkH7BausiG9l0UxigORepE/tvVv5Roo=;
 b=h8UdGWdksnXkAZZvDKBRRa7Mr2xXAo0y3yDTN/6vIx3N3d3I8jAGg6LVaPku4KryrF
 QdXT60fgj2xGpW8rZMe6z5U7N/exOjZ9TrLDdwrxY+u2FiL94+slVG2afwdD2yHxFvxP
 QmJT420UuJBdw0TQGGUpVQGb/ri9J1iFSkeOWAjV92CX/+4s+AeM4065vxFdV3uDlOuG
 Nh1/tqrGyShGVxtXcSqBGievi1u2wpOJWA0/P24mVY0/zA4V+tlRgY/9o7cXLv6wp5Yt
 GWaEE3ZOhMzTqPxMxqttn5Jv3dNidaYUREeM7DhADSIBdBKkh99PxZW4aW4uOpwn57IN
 UTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773675921; x=1774280721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NJmY1D14t4FUgkH7BausiG9l0UxigORepE/tvVv5Roo=;
 b=WUqjAuYmQURC0V7zFvJ08M8bigKcxhIJqgvbt2JOC/b953urfOv/9Pym1oQbSnRuiC
 sYlK/r+BUyhYU3+0k5o6vX/tsgzjtvQsYYdzHZe6XJNus+jlbyUE/TdDSYtcTR6SuW9g
 x0o/fhx0MvKPhiwDlDRefkvinsYV+h2cK6sjdZSeyBV3Lqy/IABS0TV4ZABq06LKTnLi
 1LyEyNFMGtW5I8RGRDGJfnsnjc1DYMhMDC+JEskqyQJJAlZIV+P8iSHXzuLiM/Gi+Zyr
 7Girhi8T2CsZWQdurN48CbTY2/tc5dXlmWQZpfhYyvNCBmuEBNTnviFM6VNHz8TBwSXh
 MEzw==
X-Gm-Message-State: AOJu0YxTRxTO/t6d+gyIrxcJMl7c2ICx4/SpGhaG9UqiGgCj+ihg+mIT
 qt+aswD4dguMgH7TFbhhuYoFDbj/uK/bjUWzdGsuQ4w7ia5tC+++yESWpC6sT7c=
X-Gm-Gg: ATEYQzwRAXsP0nFvK4gaThdyROTiTpIfihPkhjphr9cZ7Oo5uXTCTXrYa3ElWDYAk0s
 YTESOy0fy0brr/WqgElJe0NJJ99oAs0Brp8U6ZR+OefCM6GsiPKKPIP+yzfaKoft8CElbH5XY3V
 6na2PezZUQCmfYx22fyqlHuRCY8iAcTCrduwVKo7WRCVdBo0mNjhF+SGxdoC73OCg1lwOzu45zd
 KLuEM5aWTt+53uQQA7VwqerB6Fg98ikm/xwRucrHl1ELckJgc3QHlUSO2CyO0zA96ELPjGEvUpw
 jeN8r0fCwJPjeoW5cGKnE0pw4sLjqqVgo7mdXGKn2iQ8UI8E1uVPXyGDjne7RqCa/poGY6HSFCB
 co5j0/b7L9wIkIoe4/YJjzpnpOR57s2/ot3xy9nBNaMWSheivakt9sp2nyujEinW2mvgix9fIim
 ISGl6j33UFEElvbgQRrDuE9Q8LXZLQPAoALh4ikVoMNtTep7oBJrev
X-Received: by 2002:a05:6a00:2d91:b0:821:8084:f8c8 with SMTP id
 d2e1a72fcca58-82a198c6c31mr11634053b3a.37.1773675920806; 
 Mon, 16 Mar 2026 08:45:20 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a07365b22sm13836228b3a.45.2026.03.16.08.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 08:45:19 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Tue, 17 Mar 2026 00:44:54 +0900
Message-ID: <20260316154457.117543-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b7f7db.050a0220.14698e.828a@mx.google.com>
References: <69b7f7db.050a0220.14698e.828a@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] inotify: replace strcpy() with snprintf()
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

Use snprintf() instead of strcpy() to avoid potential buffer
overflows when constructing file names.

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify02.c | 24 +++++++++----------
 testcases/kernel/syscalls/inotify/inotify04.c | 10 ++++----
 testcases/kernel/syscalls/inotify/inotify07.c |  8 +++----
 testcases/kernel/syscalls/inotify/inotify10.c | 10 ++++----
 4 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 314c1bd49..61217cac3 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -35,7 +35,7 @@
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))

 #define BUF_SIZE 256
-static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];
+static char fname1[BUF_SIZE], fname2[PATH_MAX], fname3[PATH_MAX];
 static int fd, fd_notify, reap_wd;
 static int wd;

@@ -61,40 +61,40 @@ void verify_inotify(void)
 	 */
 	SAFE_CHMOD(".", 0755);
 	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
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
-	snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
+	snprintf(fname2, sizeof(fname2), "%s.rename1", fname1);
 	SAFE_RENAME(fname1, fname2);
 	event_set[test_cnt].mask = IN_MOVE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;

 	SAFE_UNLINK(FILE_NAME2);
 	event_set[test_cnt].mask = IN_DELETE;
-	strcpy(event_set[test_cnt].name, FILE_NAME2);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", FILE_NAME2);
 	test_cnt++;

 	/*
@@ -103,12 +103,12 @@ void verify_inotify(void)
 	 * we can correct determine kernel bug which exist before
 	 * 2.6.25. See comment below.
 	 */
-	snprintf(fname3, BUF_SIZE, "%s.rename2", fname1);
+	snprintf(fname3, sizeof(fname3), "%s.rename2", fname1);
 	SAFE_RENAME(fname2, fname3);

 	SAFE_RENAME(fname3, fname1);
 	event_set[test_cnt].mask = IN_MOVE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;

 	int len, i = 0, test_num = 0;
diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index 947623952..2d7f34bae 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -91,10 +91,10 @@ void verify_inotify(void)
 	reap_wd_dir = 0;

 	event_set[test_cnt].mask = IN_DELETE_SELF;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;
 	event_set[test_cnt].mask = IN_IGNORED;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;

 	SAFE_UNLINK(TEST_FILE);
@@ -108,14 +108,14 @@ void verify_inotify(void)
 	 * understand how Unix works.
 	 */
 	event_set[test_cnt].mask = IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;

 	event_set[test_cnt].mask = IN_DELETE_SELF;
-	strcpy(event_set[test_cnt].name, TEST_FILE);
+	snprintf(event_set[test_cnt].name, sizeof(event_set[test_cnt].name), "%s", TEST_FILE);
 	test_cnt++;
 	event_set[test_cnt].mask = IN_IGNORED;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
 	test_cnt++;

 	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index b4000f353..f0acd9e91 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -74,18 +74,18 @@ void verify_inotify(void)
 	 */
 	SAFE_CHMOD(DIR_PATH, 0755);
 	event_set[test_cnt].mask = IN_ISDIR | IN_ATTRIB;
-	strcpy(event_set[test_cnt].name, "");
+	event_set[test_cnt].name[0] = '\0';
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
diff --git a/testcases/kernel/syscalls/inotify/inotify10.c b/testcases/kernel/syscalls/inotify/inotify10.c
index 4c3a1d116..0a94ead15 100644
--- a/testcases/kernel/syscalls/inotify/inotify10.c
+++ b/testcases/kernel/syscalls/inotify/inotify10.c
@@ -121,25 +121,27 @@ static void verify_inotify(unsigned int n)
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
+		event_set[test_cnt].name[0] = '\0';
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
+		event_set[test_cnt].name[0] = '\0';
 		test_cnt++;
 	}

--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
