Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB375C61DCB
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 08:22:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 748C03D0E67
	for <ltp@archiver.kernel.org>; Sat, 21 Feb 2026 09:22:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E57763CB249
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 09:22:05 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7408C6007A5
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 09:22:05 +0100 (CET)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-8249cb73792so2554425b3a.3
 for <ltp@lists.linux.it>; Sat, 21 Feb 2026 00:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771662124; x=1772266924; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DIDaS4F1+PUDo6ptBoVSpqYWNndwwBl374Ni82QIQVU=;
 b=SBJxnRYrx8tiShSf/66c38IlLBEJCT5cArfyqQkZXicLDStAh3aGrC+qI6lWdXPagT
 mAA09i8UDVwoHu1CXceE1KuaQW6mQcgU4Vn475BHRe48s25tqkYNUcXWlq5cGlgucJcR
 A1s3+MZHrHJvq2QbswV9hEuK2C+JnFXIxfOGRLvEgtEuOPLMRTt0PyyHIbJRI2QgLWx6
 XEJ8Vmlnr3Xc8+t4xsn0KSjxEfkrWkK+Pm86u+vmkslQIAHiYi02d6IJjmL7PF60Q6gf
 bWKiKLESG+Hoa1kbEN+PfsJ0/XYSSRQzcHIKlwFeuCMoBIFMyprZTcB982PaZitdHV0x
 nfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771662124; x=1772266924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DIDaS4F1+PUDo6ptBoVSpqYWNndwwBl374Ni82QIQVU=;
 b=UqTrSIzgJT5r6nbI4rimnWKHsy4Eb2YNi8JBN7hqmW0DvfM0Vz0uq6CAk47sjrSYDS
 9MftqTm9M7AMNnN+iFv2I3YKRHi3nkMrM3NbOiV0v+tYbTuoPldyXIGR6q92oEwXVarg
 HxHFe8+DcIALgqDMl1pgbW9SYvq3ISOhoTKj/XtO/AETpU42Wxq74oIiWu1g8xJWAyPk
 M3OF6gz3RqKXFNUulAGo+mf3c//XR0TF7B6AOj9VZXAhzzPpfxA8KymskfYvd09ittz1
 Os61GA+vDdy8qqVSlPvJB7wBli5l6JJmta/O9fAKTHgCcvCuTI79MQPrCwQcajTNvdgT
 +bsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHW9hU+q9gqYG6kEpYd4RxvQtVj38hyNL/8CfEO8WCcshOEYk2ebGYfg4tqEM4Ti5LaeQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yyu6Jbq3+Gnjq+w8VNLFUiQ/rJuwu8D7YCVPju9veVHuzEPAnF/
 6ZwwpWmC8jHqyTkZ5bJzDRlOrCMUvpx/QcNqKXm99gwsAmxwzYFQ+9s=
X-Gm-Gg: AZuq6aKx0Lt7wdFF5BWJexKlKBZuGy81miPsdb4H76u7Bx1sHMJ/1YyED0ocFM4xNE8
 wpP4JCUDMn3cvOD/VgUN3ufDXsULGuq3+LtcL0F71tMhCipRytR3TtQqj60rtt+uGx0NPrzpUYu
 yYLOFCR2ZAzAlZdMh73YKOhIaIwoiIkhPkgPwF7rxfL7TdfhzMd6H7kK/Q0+ApjR7jacf34JX1f
 iYckqFjC2ZkyhtQcwZ2RO/ApUbPMYqQF/J3mfc2BFDfyOd+QhFVMR7Y3rOtCTvakqOJMIV4+9Im
 qbW6Ob5gAhb6UyuOjdZoucnVUtWLMusZffIUicSJLDPoKDjxKT5AxzwF0tKjfeDhGTi6pOpiX9P
 C/DhhLBCNFUD9vpDD43+sHmRruvDbyJnTdbQDllu3n9Z4WSHMVhHrCZj/FlfxTtdAzL+HIz5Ys9
 7Or/do0rH9j9A/g/14goZ3MqjDxgxZZ6undw9qtF0xrmYGht/eye10
X-Received: by 2002:a05:6a00:3a19:b0:823:943:391b with SMTP id
 d2e1a72fcca58-826daaab11cmr2063277b3a.60.1771662123656; 
 Sat, 21 Feb 2026 00:22:03 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-826dd68c0b8sm1717140b3a.17.2026.02.21.00.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 00:22:03 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: chrubis@suse.cz,
	ltp@lists.linux.it
Date: Sat, 21 Feb 2026 17:21:37 +0900
Message-ID: <20260221082139.1709-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aZh4Tsd1V2rlgoAn@yuki.lan>
References: <aZh4Tsd1V2rlgoAn@yuki.lan>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] inotify: modernize with SAFE_ wrappers
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

Replace manual read/write with SAFE_READ/SAFE_WRITE for better stability
and consistency.

inotify12.c intentionally unchanged: raw read() + manual EAGAIN handling
is required to treat missing second event as IN_IGNORED (normal case).

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify01.c | 17 +++--------------
 testcases/kernel/syscalls/inotify/inotify03.c | 14 ++------------
 testcases/kernel/syscalls/inotify/inotify04.c |  4 +---
 testcases/kernel/syscalls/inotify/inotify05.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify07.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify08.c |  7 +------
 testcases/kernel/syscalls/inotify/inotify10.c |  4 +---
 7 files changed, 10 insertions(+), 50 deletions(-)

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
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 9bb95addb..a7974dd57 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
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
index 1db38ddf2..947623952 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -118,9 +118,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, "");
 	test_cnt++;

-	len = read(fd_notify, event_buf, EVENT_BUF_LEN);
-	if (len == -1)
-		tst_brk(TBROK | TERRNO, "read failed");
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct inotify_event *event;
diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index d9bfb05f1..82a4c7bdc 100644
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
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 66a2f4d37..b4000f353 100644
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
