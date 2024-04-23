Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2800CC4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961345; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KW3zKKyFcVKV8+YBBohAgxsMGKij4mQoGCcwrqY/ky0=;
 b=C/13BOJTFaW0N9e4ScmUBH17gqqbTmDFM61svuBhJP93TiuSyT7ZWNif0Ki/JqLkyG7Zt
 ONQxcgO0lJHUFxRbMguTxvMYOTh7Nndr3rwnG875idYjb8jQvBCUV3d/aDuZ6ywIuSFpztW
 ocrOI6N39bbzmwPWTlN0ezzOutJxwUY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E5FF3D0019
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:22:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50AEC3CFA6F
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:30 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2C296006D7
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:29 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dc6b2682870so11082499276.0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913108; x=1714517908; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mUabKwQ6pkEL5HnBx7JpYwffqD3CqZ31cx+tz1JLzHA=;
 b=Nw4ZzfSVNoFHEltL8v0NtP7gON2tCpkQ9Sf44xXT7zl6ly9AoAVSRhihwGgqi8hako
 QozVScAfOwsgv6gjJk2HoFDGBPUTwellfPzDGHUdY4+efIjhfBQc7Ocec10QsSss6FQP
 RNc0wMuE6pz5lx4IEkp+pkycklz7TL2NBilKYx9s0Xklqjet++yXe604ByQFxuTnWX7J
 UVgdCvHzjRl3IO5Y1k7r1N/9RWRHjnj/H/hRQsb9uUywI+7IinEH+ACJ48ZutFiTdCk8
 g3UU9f7l9NZca6bgKRmDs9v5Hu3zFFD0qSgMwA4VxeYyinnmsv9Ohh4KcEWY/7+DzcE7
 /u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913108; x=1714517908;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUabKwQ6pkEL5HnBx7JpYwffqD3CqZ31cx+tz1JLzHA=;
 b=pCd9KGJ+REzduLMUx6kp5sL98Nlz026VciIxoTPMR7dW/KTyS37H4dGar2CEWq93Ag
 FKIZmCaYOjkTCJXOiddO4ZuD+zkUeUm69f908CgS+uO46cm/D90WtXzDd2OVd4MVCzRn
 gdTt5lO5xSssH/usR/9zRr2+B0WNV509wpvIUFdCzi8IWwLTnxq9SXUQw92OHPP8HQpj
 kZK6K2GWOppyEM9i8wtAn9fn7+DcVqFTq4WXWhWqa2BtZNroT0m96X/M7zcqE7ofEKCL
 Kvon3TDBq2e53OJIsgW1Rj8mEruHv1NG8vY4NIgHAcmrRzcvb40bixhB+TWBY1BiLuBy
 i9jQ==
X-Gm-Message-State: AOJu0Yymb7xl4E+iarBaGsN2ueWac6X/meTGN6IyY53DC5qKJZsxJqbj
 kRIIpikK1S4CKed1/0i3vB55A4ktoNda08wvDo+FuaHCCKhBvzgP4ihHrjpYSHQmkbkh/kL51U7
 UjFQLXVj9AWbHVY38k4EXSaeiHxHZQb6SMnRnwSBR0PvGC7YZ/yUgVwejtG4ZUeeQwUIMgPTBEX
 LMm2ZwKv6bQvoQMJpZOUGZMq8XItWnzG0=
X-Google-Smtp-Source: AGHT+IH+tue3sjCZ3NHnjORp3DAOTdVr6uH6WzV3glygQLb0xfpPY3AXeYCii2VUjgCdEg5Popilu97Xa6gY
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:10c2:b0:dd9:3a6b:11f8 with SMTP
 id w2-20020a05690210c200b00dd93a6b11f8mr315331ybu.5.1713913108060; Tue, 23
 Apr 2024 15:58:28 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:57:58 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-2-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 1/6] sched_football: Drop use of sched_yeild()
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

sched_yeild() just causes the SCHED_FIFO tasks to behave like
SCHED_RR which makes analysis of the behavior more difficult to
follow. So lets drop the calls.

Also fixes up some whitespace inconsistencies in the header comment.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 .../realtime/func/sched_football/sched_football.c      | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 6f075aea3..1e205219d 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -32,12 +32,12 @@
  *       - Create a fixed number of offense threads (lower priority)
  *       - Create a referee thread (highest priority)
  *       - Once everyone is on the field, the offense thread increments the
- *	 value of 'the_ball' and yields. The defense thread tries to block
- *	 the ball by never letting the offense players get the CPU (it just
- * 	   does a sched_yield).
+ *         value of 'the_ball'. The defense thread tries to block
+ *         the ball by never letting the offense players get the CPU (it just
+ *         spins).
  *       - The refree threads wakes up regularly to check if the game is over :)
  *       - In the end, if the value of 'the_ball' is >0, the test is considered
- *	 to have failed.
+ *         to have failed.
  *
  * USAGE:
  *      Use run_auto.sh script in current directory to build and run test.
@@ -113,7 +113,6 @@ void *thread_defense(void *arg)
 	atomic_inc(&players_ready);
 	/*keep the ball from being moved */
 	while (1) {
-		sched_yield();	/* let other defenders run */
 	}
 	return NULL;
 }
@@ -124,7 +123,6 @@ void *thread_offense(void *arg)
 	atomic_inc(&players_ready);
 	while (1) {
 		the_ball++;	/* move the ball ahead one yard */
-		sched_yield();	/* let other offensive players run */
 	}
 	return NULL;
 }
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
