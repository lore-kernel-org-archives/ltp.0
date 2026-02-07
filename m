Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9819EE0AE9
	for <ltp@archiver.kernel.org>; Sat,  7 Feb 2026 17:07:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A6A3CED74
	for <ltp@archiver.kernel.org>; Sat,  7 Feb 2026 18:07:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CA193C32DD
 for <ltp@lists.linux.it>; Sat,  7 Feb 2026 18:06:59 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9245A1A0065B
 for <ltp@lists.linux.it>; Sat,  7 Feb 2026 18:06:58 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-352c5bd2769so1885816a91.1
 for <ltp@lists.linux.it>; Sat, 07 Feb 2026 09:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770484017; x=1771088817; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VzURdAcHTCWCVIyYZWtE+33tLHabYNnSf8xY1sheooU=;
 b=iUCEPnLFu7WP7q8m4FLl5mTh41E/ZhbrSM5n57F8JZDNv1iVf7++L7cGmOlqhOsYTq
 OC2iUHIvyILSlQ8ypD4Lo35bBmWuM3cepDhkWxmsdEUswlboIcJrx6mOhk9ZVA19k+49
 5Fywczo6X9BEBMdKe90nAJ5ZFi2uI0fsZ/QjxSyhYKjwncK5x2qYCo5ArKQlSqCAM1g2
 7/u87FdOIrWhAZDaggi7NmTW32esAlC8APe8v2Q7uuaDxiOa8H3ow+JHG5jjevGOUHmi
 mV1SNEn5y9vRst7pMr2uk8ERGB0Gkx48sZJh/6Qms9m4dios6de4bp876Tx6v/gGILmf
 LTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770484017; x=1771088817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VzURdAcHTCWCVIyYZWtE+33tLHabYNnSf8xY1sheooU=;
 b=RZw3hQfIrfO2mDhsG34OQQ5BRaP0V4BSEzXWUyNZpZHxFRTfx/SdLVCRxEuUCUweZ3
 CEb6W32odQ0na/GvIozzi2/+ZBCi67sOBeu568QdOSAcnb5Ak5SMn38bT3Q3KQqQyOFF
 69PYeBTbEKfjWw1/bmtfbKfne9NS9t0x9USv4y8Ur3Y8FFehE/mO+aQ6Tt5U1NhBdD8M
 j5L109VB86F+RvewWerfGH4P2yPT87nwjDdVF2lx3TpcsDo97kT9Vj0UaaS9X/Swaj8g
 RZoeu+JOGhaflecVcwlmydbZZckyn+jyTIgMRBbj6ul4ijfSToyHHf2r0Iy7jc6UksLI
 oWYg==
X-Gm-Message-State: AOJu0YxPT3Px8eptAOon2rVbMOmHkfcfseSibjSgvXvPA9UgLaZDzx6u
 Dj8zAfy4StNClRPAwlyl7lNIYEi5tlhTY4p9WZUuArkwDMaLAWYX+TZe9Jy50Ma4qA==
X-Gm-Gg: AZuq6aKhBSuTHELcmF7Gg9Fv2AzYSXn8SejKlapzcG/VZmWwjhBrHZJe32lkmDTcuXp
 54TR/gj8HeaH35f99uMkCiQletgZpm7YguuyR6Ec/EE18S/HvEKyi6oKr2S0UqLPpxr2oeJlqNb
 99cdZ643yxyK/eynB5oMwxQ25M/bqavSPuV0PM5jeZ5dVAzFolOkq/dIOkpDr4CD12NUK6yhIsc
 j90kJlqedb//j5UB1QGYhqbTi71k4gVpeCdGN2DUgdb7gOtbS4URjZfuHsyAJbMUW/yVACtUhIg
 vMZF1N6iTqI0mNfb/mwsLuW+wjouzTjCxAaaJKl52z4ua01851ZsiBSzEEevsLtXLcss8xK/NnD
 +Ttlp6dnnEaNSzfVawofomWisDK6VJ8F/PFgS1TvQL3Zm9AwOVh+2/jfr7LSUCm0yx1P/A15CPx
 7kNFtUS/HxBIuEqUfq3wh95jU0pSsVtA==
X-Received: by 2002:a17:90b:4b0c:b0:341:315:f4ec with SMTP id
 98e67ed59e1d1-354b3c41415mr5774392a91.7.1770484016515; 
 Sat, 07 Feb 2026 09:06:56 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b21fb723sm5497450a91.10.2026.02.07.09.06.55
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 09:06:56 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Sun,  8 Feb 2026 02:06:29 +0900
Message-ID: <20260207170632.2795-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify: modernize with SAFE_ wrappers and fix minor
 style issues
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

These are small cleanups to align with current LTP style:
- Use SAFE_ wrappers instead of manual calls
- Remove trailing comma in tst_res() for cleaner logs

Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
---
 testcases/kernel/syscalls/inotify/inotify02.c | 21 ++++---------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify02.c b/testcases/kernel/syscalls/inotify/inotify02.c
index 709a92830..314c1bd49 100644
--- a/testcases/kernel/syscalls/inotify/inotify02.c
+++ b/testcases/kernel/syscalls/inotify/inotify02.c
@@ -64,11 +64,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, "");
 	test_cnt++;

-	if ((fd = creat(FILE_NAME1, 0755)) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"creat(\"%s\", 755) failed", FILE_NAME1);
-	}
-
+	fd = SAFE_CREAT(FILE_NAME1, 0755);
 	event_set[test_cnt].mask = IN_CREATE;
 	strcpy(event_set[test_cnt].name, FILE_NAME1);
 	test_cnt++;
@@ -89,11 +85,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, FILE_NAME2);
 	test_cnt++;

-	if (getcwd(fname1, BUF_SIZE) == NULL) {
-		tst_brk(TBROK | TERRNO,
-			"getcwd(%p, %d) failed", fname1, BUF_SIZE);
-	}
-
+	SAFE_GETCWD(fname1, BUF_SIZE);
 	snprintf(fname2, BUF_SIZE, "%s.rename1", fname1);
 	SAFE_RENAME(fname1, fname2);
 	event_set[test_cnt].mask = IN_MOVE_SELF;
@@ -120,12 +112,7 @@ void verify_inotify(void)
 	test_cnt++;

 	int len, i = 0, test_num = 0;
-	if ((len = read(fd_notify, event_buf, EVENT_BUF_LEN)) == -1) {
-		tst_brk(TBROK | TERRNO,
-			"read(%d, buf, %zu) failed",
-			fd_notify, EVENT_BUF_LEN);
-
-	}
+	len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);

 	while (i < len) {
 		struct inotify_event *event;
@@ -208,7 +195,7 @@ static void cleanup(void)
 {
 	if (reap_wd && myinotify_rm_watch(fd_notify, wd) < 0) {
 		tst_res(TWARN,
-			"inotify_rm_watch (%d, %d) failed,", fd_notify, wd);
+			"inotify_rm_watch (%d, %d) failed", fd_notify, wd);
 	}

 	if (fd_notify > 0)
--
2.43.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
