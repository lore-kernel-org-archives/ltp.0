Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083A0107BCC9
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 16:06:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 660313E5B3C
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 17:06:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49D4B3E52AA
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:06:34 +0100 (CET)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BFD111A01158
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:06:33 +0100 (CET)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a9296b3926so18931065ad.1
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773417992; x=1774022792; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1bFpUszIqFSZv4s1FSy6Ig/C6qu7yoRnEaFltU4TO6c=;
 b=nBenDDt6JOSXRlUXP0pQdi0/Sq2NwZMwwtgyFNYqeyTlYBbPJk9Vx6gHnkh+6lwSwI
 41VjR1xqz799WjRnEP1I7Pow3QoTqaV8NOWXYO6ikVO2t8JoJXChnBIlPY7k0ufxm8HW
 Zfwt3nYpUrlvm79Ulst0YC1dhs2NScF3ZHtwcoPGNBg+s4s5RwjBAfcWGJy51zlGbKJa
 P1c7ORace0JYYRyMCtU8fQO6kgfDAuhiXz3VzYHdIBvsimnE6mrJT6rJYjn8pgpOvCHk
 4Wd87kixkcxE8IAGHzhXHjlbwMwIT1DYFoXfdLb4qRUWP7gNrcSuH1l0oI6L2wWRYYZi
 1l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773417992; x=1774022792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1bFpUszIqFSZv4s1FSy6Ig/C6qu7yoRnEaFltU4TO6c=;
 b=Znzoux1FegOFs9Yq6Z/sfkw+bX33s3YOrtb+8wEMbSjhghF9LKe41d+Ws+sP0pmsWD
 IUXr9nOlvJHxwNakjnoOIeIt2Q//WY9XY+j6dgrnZjTO0EtgvTn5VABH9yLUwcj2Hf6T
 y9ETy2NkOTasZu05pSR5YJgeipNM7XK3O3sm1z4ocqEySA8GeiSQzg11CSUVkZRtshoZ
 5nwpfC03MGh3FdAwZrm7oeCpuMXLEsb4kGCSLMHEZsmQBluLEanBqvEH0ncNTiAZ1Dvr
 otfaupWP3lmZI9RrFq67ypKoNZImBMXFL6cwyEnAeFshlcpzfASzAEDguPyChq3HhjAq
 pvZw==
X-Gm-Message-State: AOJu0YzSLuuSoPvo/Y/PCH62xBduC10RChauUPyYE+PsZq0RYG0ruiDX
 JJTwHtK/lnODkXjLVezOE++pqXf9WC2plUnezacX6SnSgWUJHWyUx0Xf06BxwSPKuw==
X-Gm-Gg: ATEYQzzqnFIaRYeI59aVM4LS9jImD8hP7yYVxgi8ZYnorv9twjQh38gvcK1FR7dm3yd
 FGnMXGraR+eIsCDy2h+viGxYBcVbkP03I0CVXwQbz6x/VhslCIqizOdXOvonhymG4M6+Lwh6a8B
 F9GKXYzIhxd0VZPlqK49cZw/xkt4byS866n3PUe+j+w3LILlB4CTnl5oSi1zmEEhMfhVqh/udf6
 kFSIp9vQGRQV2DE3DydhjWvdEARHWKfote6MXPswq6h5tROy6c9LRZEvdfeuRNACA98MO9Rop9p
 XAYlU9w0cZLiOmcL0VM1foD9ydFqxbxrcfD4zULFsJcq1C7ERMrkVDmybbrlb85E7tM57kYUkPG
 Ud4ElcTyxGjw7W+34mwP1xfvlodTlH4rZeeGeywz/zH8QmR7a/0TOHawWJ1hJT2UMAU1XDpQ2PV
 1jtJyjVraPB+WqfSRKHXz38jrv6BEQ17IEomnhKMzNKQ==
X-Received: by 2002:a17:902:d48b:b0:2ae:4d23:3364 with SMTP id
 d9443c01a7336-2aecaca2054mr36183305ad.52.1773417991902; 
 Fri, 13 Mar 2026 09:06:31 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece630b8asm26230775ad.40.2026.03.13.09.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 09:06:31 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com,
	chrubis@suse.cz
Date: Sat, 14 Mar 2026 01:05:15 +0900
Message-ID: <20260313160520.39745-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69a70250.050a0220.3bc433.165d@mx.google.com>
References: <69a70250.050a0220.3bc433.165d@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] inotify: replace strcpy() with snprintf()
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
index 314c1bd49..423676bf9 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -35,7 +35,7 @@
 #define EVENT_BUF_LEN        (EVENT_MAX * (EVENT_SIZE + 16))

 #define BUF_SIZE 256
-static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];
+static char fname1[BUF_SIZE], fname2[BUF_SIZE+32], fname3[BUF_SIZE+32];
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
