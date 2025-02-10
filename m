Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C92EC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 15:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CADF23C98D8
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 16:14:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1BA13C98BB
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:26 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6CF0923285E
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 16:13:24 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so951073f8f.0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739200404; x=1739805204; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AN38LGW0sz8HoepnGmIbatEzbGDOiuXBpWBUpB0cj48=;
 b=TXBPbeI9IvO9p8PvaUexCrN2D/zmpXVSvBZv59RsFbR+Wtkjhu7c+W0vkEsPt119Q2
 kVbrHZnO/WakfWSyCZg7mE9J5+A67XEV+TD51FqQYbUx9MzZ3Z9yNZc1vZG6ByH4EMRW
 EEkeJkOT0lCL4KXjIhhE74KU2ADaI/AnG9clTRUdnQQ0tyL0tk/fIZhLAwmiaXFV6IXf
 KV5D1pbMUvtVE1r32AYAf53MZN/ytDgs7bwDyy9MogiFNP+O7xVUU6lxNAt7cgj+kXuN
 eKRmUd5hmieFXW46E5hiUNpQQnjzT1rEozdUPWmAPbgz7w+N0pm+XI1hbeUI2NY23z5x
 rdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739200404; x=1739805204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AN38LGW0sz8HoepnGmIbatEzbGDOiuXBpWBUpB0cj48=;
 b=NQPSdUJtl2G2G6fsy68+NJ9qVSW/LZ1eb34Y35J+rL4ytX59i8LUntMIniTwZWVFdI
 90V78SekfQroSVY9jR5uDlB9/phYnqauBP2yN3fNdNcrxaWp0HjCQqHbZjJfx94wyaex
 LLU2HOduYkJkV/dNgayUPJEfJ3HrHrHjcFVVUOoU+8UtTDQdaZv8yD4HinX+lHmVp5HR
 U2APMMw4om4RxCdLPmDaRDJZ/l0cIXe+yWeH5l0vuiIGNNy+1LKbK1Eq9kO8pcJpfrir
 4MNPDqJokuFt7Wo1L5SJKfWVEny414FDaymiw4wQeKu93LijOKzZFPJwghabBvUDOlsV
 qiyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Rhh2ltevWtHcGaOIZirKZUcyGx7XVuVpnSnR+D25abnpjcBgxnRbo4uOPjSgpPY9BW4=@lists.linux.it
X-Gm-Message-State: AOJu0YzujzAAjwjQiLP6XPBw+JgK2DG/bAfNV5flCCZtTP4ExYtD+9+j
 gaLAK81K0Yc258UPnYJP8wdWFX3mA3NR+lZy8gajehZ8Pev02CJ+t+F8TmHx
X-Gm-Gg: ASbGncvq2nWb2rcaSQx9DRouVkSxVeIu188UWox6s/+f3risslK1pfq8kfIa8fqt+J7
 GwXWFQo53ylhpUQlof0rcFL0HTGQZyDZwO6lF0t38dR2J4RPWgPJXpusRsXdvGFTIYL2xJfNji2
 NFgu1lg2qfR2c1Ds6vlk9YHX6wHVd3qfFDbTlZg3ZrB/0mffgc4tda1ZM/r7tg2N6fTcsEZP/j0
 cMuQTYXEb57b/0T3BZy5yBXQi/ORryxtWRBfSf9PTMYW76dgxfB3/lTKw1qZPgHmn3zqy7qW9Qz
 oQ3fkTEGZA3hcW8mF1Qjv+CGYojOokm26peKxEBqjnq1RN5pX1J04m1rF4kkjgzpbrn7Igie94c
 zDLMKEYAca4J3
X-Google-Smtp-Source: AGHT+IHn/u3s+OBz+qP4T809ofNJW7fJuMOyzjORmCxyXded+TvZW8tXl/dtR94OfoN6OQxsnQi6Kw==
X-Received: by 2002:a5d:588d:0:b0:38d:da11:df19 with SMTP id
 ffacd0b85a97d-38dda11dff7mr5374403f8f.41.1739200403393; 
 Mon, 10 Feb 2025 07:13:23 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl
 (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce6f2c37sm9106869f8f.99.2025.02.10.07.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:13:22 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2025 16:13:16 +0100
Message-Id: <20250210151316.246079-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210151316.246079-1-amir73il@gmail.com>
References: <20250210151316.246079-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] fanotify24: Test open for write of executable
 files with pre-content watch
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

Watching pre-content events should allow opening an executable file for
write and executing a file that is open for write.

We have an existing test where the exectable file is not watched by
pre-content events.

We add a new test case, where the executable file is watched for
FAN_PRE_ACCESS pre-content event and access is allowed.

In the former case (not watched), execution should fail with ETXTBSY and
in the latter case (per-content watched) execution should succeed.

When allowing access events, we allow for multiple events, because
read() may generate more than a single access event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify24.c     | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
index a7aa2e052..537773d52 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify24.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
@@ -144,6 +144,15 @@ static struct tcase {
 		{
 		}
 	},
+	{
+		"inode mark, FAN_PRE_ACCESS event allowed",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_PRE_ACCESS, 1,
+		{
+			/* This allows multiple FAN_PRE_ACCESS events */
+			{FAN_PRE_ACCESS, FAN_ALLOW},
+		}
+	},
 };
 
 static int expected_errno(unsigned int response)
@@ -206,6 +215,21 @@ static void generate_events(struct tcase *tc)
 	exp_errno = expected_errno(event->response);
 	event++;
 
+	/*
+	 * If execve() is allowed by permission events, check if executing a
+	 * file that open for write is allowed.
+	 * HSM needs to be able to write to file during pre-content event, so it
+	 * requires that a file being executed can be open for write, which also
+	 * means that a file open for write can be executed.
+	 * Therefore, ETXTBSY is to be expected when file is not being watched
+	 * at all or being watched but not with pre-content events in mask.
+	 */
+	if (!exp_errno) {
+		fd = SAFE_OPEN(FILE_EXEC_PATH, O_RDWR);
+		if (!tc->event_count)
+			exp_errno = ETXTBSY;
+	}
+
 	exp_ret = exp_errno ? -1 : 0;
 	errno = 0;
 	if (execve(FILE_EXEC_PATH, argv, environ) != exp_ret || errno != exp_errno) {
@@ -214,6 +238,9 @@ static void generate_events(struct tcase *tc)
 	} else if (errno == exp_errno) {
 		tst_res(TINFO, "execve() got errno %d as expected", errno);
 	}
+
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
 }
 
 static void child_handler(int tmp)
@@ -309,8 +336,8 @@ static void test_fanotify(unsigned int n)
 	/*
 	 * Process events
 	 *
-	 * tc->count + 1 is to accommodate for checking the child process
-	 * return value
+	 * tc->count + 1 is to let read() wait for child process to exit
+	 * and to accomodate for extra access events
 	 */
 	while (test_num < tc->event_count + 1 && fd_notify != -1) {
 		struct fanotify_event_metadata *event;
@@ -319,6 +346,7 @@ static void test_fanotify(unsigned int n)
 			/* Get more events */
 			ret = read(fd_notify, event_buf + len,
 				   EVENT_BUF_LEN - len);
+			/* Received SIGCHLD */
 			if (fd_notify == -1)
 				break;
 			if (ret < 0) {
@@ -329,6 +357,17 @@ static void test_fanotify(unsigned int n)
 			len += ret;
 		}
 
+		/*
+		 * If we got an event after the last event and the last event was
+		 * allowed then assume this is another event of the same type.
+		 * This is to accomodate for the fact that a single read() may
+		 * generate an unknown number of access permission events if they
+		 * are allowed.
+		 */
+		if (test_num > 0 && test_num == tc->event_count &&
+		    event_set[test_num-1].response == FAN_ALLOW)
+			test_num--;
+
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		/* Permission events cannot be merged, so the event mask
 		 * reported should exactly match the event mask within the
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
