Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B1C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:14:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71F2D3C98D8
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:14:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DEBA3C98B5
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:23 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE9CC1182BAC
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:22 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso30614245e9.0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739200402; x=1739805202; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCmjzahZ+QHfId617BilrkRcDNpOISopNsybGx6Z0Vk=;
 b=R7yiVMRIRCdAmdrGHxAcowNdrNk0Hz3F4MRBnD6ZFRtwr0abGFcFU/o1cvYEeU8C8N
 SAwskoYRktgcxXRoBbsI6/iQAozZMyf7WBZqSFzT7csOFEiFhcQtd1boYHaH1DWgZKLW
 zTnTqxx/xJ5+zykNxQXBK0vFlXWcnW1gYs3Rcj0D3Upu5vSU4Kviw8rZlHD9l9EMrlCL
 TLiC7FOV++gQFQyKrQZfmKOGwlISTc3fndmXKdfoawMpWlrCZUz+dRfHcdoMMpDqKwgV
 suj8FKTLqJdYxFVQg7HUbcajCuwVMxgq2Fu+hZiJA36lkWrMGQvgW+lw6RDMd61nS/Mw
 dWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739200402; x=1739805202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCmjzahZ+QHfId617BilrkRcDNpOISopNsybGx6Z0Vk=;
 b=U3iw+N8SqadkiHqKIqTWoMR68jSjnoenXsQVSY+4KhbroMhThwEEnaxgl/AdLUem+5
 7l+ymdXqcFvFlT5YbZtv1VHrEipuLcrF9pnFaOI9+QCW6dAAGYzBZbrmtxhUmsncidCC
 37EwE75dXKonODlzU0Pm5cS/wY8kEb9YYnQHNaHlVfT1ORM6ht2UfwvtFyZ14BXFQt3j
 /DSgtVsu5pADwlzcN5AbVhAar1eArkZvt2n5v0pTZAs8HDsA48jAi3RzLZ4XQLeZtA4m
 rQUKoZgS8Ls1fM8oaESIW07H0qhlZgJ4PRBC9X3cGIB09f9d2Ha4qSl9w0qxnVeK+SLl
 NFtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfzeyWBq4s+Sj4Lj9LMyeQo1Yy3G2/Af94VldVqWHya1mMtGHzSUvBfERdYMx/fmO9z50=@lists.linux.it
X-Gm-Message-State: AOJu0Yzpe7A7biKiUhH/4G3nh4p3PmAUkibEtncPnYXE2Pt4fKDuKLwu
 fC4LrAg+BpXOdQbl237UhJrxjv67ez3QWzGsfz7poi9i3SpyA5/C+lGhtB3K
X-Gm-Gg: ASbGncsYzWX+hz9kjMmwB3p/B+zALkmTHWB1lJ37iqQXJE+joU1BOpJ8gtcj5US1UPC
 hN2zTb+RKCuLO0NDJw/wmLINjNH4WkgBq27BMlTsFYqz8vNqcsuqypH/Z7BmPfRlw36rQ+S5b9O
 L8zMfohFjvR8WDqPSbia0hAxqne965CfipPQeLOgHniT0h3Zlya5SOz2YX2pHfBHQ+qVf0+D+CU
 5oz9CTpFjK3Kt+TDf/CvXuJt2qP0yCf/7jOI2ALiT/luRZeYetLmzOZRNPwuBj07knOVAIfu14V
 zdPq0W+SdvqZ0hQvtSLG1gOEZGOfYA7Rn/LJ4uTz3QgRw9ji+IOdzJ5QBqp2o8XOwh+FC5JFU1z
 oY6KE6Q3jwqTg
X-Google-Smtp-Source: AGHT+IER8VL26eaIYLlm4UJWSIy2RzcA5oB6h6+06HQVLtNoAFBYdOC3lkwksPFU9EA8TWNvt3S4ow==
X-Received: by 2002:a5d:540c:0:b0:38d:c55e:ebcf with SMTP id
 ffacd0b85a97d-38dc9352269mr7307320f8f.52.1739200401650; 
 Mon, 10 Feb 2025 07:13:21 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce6f2c37sm9106869f8f.99.2025.02.10.07.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:13:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2025 16:13:14 +0100
Message-Id: <20250210151316.246079-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210151316.246079-1-amir73il@gmail.com>
References: <20250210151316.246079-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission events
 on children
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Verify that permission events are delivered iff parent is watching
children.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify03.c     | 47 ++++++++++++++++---
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 64c933c19..4b2f6e45e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -121,12 +121,29 @@ static struct tcase {
 			{FAN_OPEN_EXEC_PERM, FAN_DENY}
 		}
 	},
+	{
+		"parent watching children, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(PARENT),
+		FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM | FAN_EVENT_ON_CHILD, 2,
+		{
+			{FAN_ACCESS_PERM, FAN_DENY},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+		}
+	},
+	{
+		"parent not watching children, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(PARENT),
+		FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 0,
+		{
+		}
+	},
 };
 
-static void generate_events(void)
+static void generate_events(struct tcase *tc)
 {
 	int fd;
 	char *const argv[] = {FILE_EXEC_PATH, NULL};
+	int exp_ret, exp_errno = tc->event_count ? EPERM : 0;
 
 	/*
 	 * Generate sequence of events
@@ -136,13 +153,25 @@ static void generate_events(void)
 	SAFE_WRITE(SAFE_WRITE_ANY, fd, fname, 1);
 	SAFE_LSEEK(fd, 0, SEEK_SET);
 
-	if (read(fd, buf, BUF_SIZE) != -1)
+	exp_ret = exp_errno ? -1 : 1;
+	errno = 0;
+	if (read(fd, buf, BUF_SIZE) != exp_ret || errno != exp_errno) {
+		tst_res(TFAIL, "read() got errno %d (expected %d)", errno, exp_errno);
 		exit(3);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "read() got errno %d as expected", errno);
+	}
 
 	SAFE_CLOSE(fd);
 
-	if (execve(FILE_EXEC_PATH, argv, environ) != -1)
+	exp_ret = exp_errno ? -1 : 0;
+	errno = 0;
+	if (execve(FILE_EXEC_PATH, argv, environ) != exp_ret || errno != exp_errno) {
+		tst_res(TFAIL, "execve() got errno %d (expected %d)", errno, exp_errno);
 		exit(5);
+	} else if (errno == exp_errno) {
+		tst_res(TINFO, "execve() got errno %d as expected", errno);
+	}
 }
 
 static void child_handler(int tmp)
@@ -156,7 +185,7 @@ static void child_handler(int tmp)
 	fd_notify = -1;
 }
 
-static void run_child(void)
+static void run_child(struct tcase *tc)
 {
 	struct sigaction child_action;
 
@@ -174,7 +203,7 @@ static void run_child(void)
 	if (child_pid == 0) {
 		/* Child will generate events now */
 		SAFE_CLOSE(fd_notify);
-		generate_events();
+		generate_events(tc);
 		exit(0);
 	}
 }
@@ -220,6 +249,12 @@ static int setup_mark(unsigned int n)
 
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
+	if (mark->flag == FAN_MARK_PARENT) {
+		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
+				   tc->mask, AT_FDCWD, MOUNT_PATH);
+		return 0;
+	}
+
 	for (; i < ARRAY_SIZE(files); i++) {
 		SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | mark->flag,
 				  tc->mask, AT_FDCWD, files[i]);
@@ -237,7 +272,7 @@ static void test_fanotify(unsigned int n)
 	if (setup_mark(n) != 0)
 		return;
 
-	run_child();
+	run_child(tc);
 
 	/*
 	 * Process events
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
