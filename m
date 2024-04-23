Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F34C4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961415; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4I2hZmgZybnYkreaqk+6wpYd4WD1gkUpPGUA6wW7MZQ=;
 b=i7zyP4SbZKQbTuY9cgPBwwM4DcqiZTGENGQvXCzYqZ/+BnlKzVGwMqxz0lfu63HM2HfuE
 EAHIQsruYXYNNv2tGRt9qr+tLPK9X7tUz7jEFzqBkIKXLcf6/tsWWh1x1UA/ojo5OB2PwI0
 AGi339tESps+LtEAzmPRWY3gSIN2xYs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCB433D0048
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:23:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF00C3CFA6F
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:31 +0200 (CEST)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3ACCA1000900
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:31 +0200 (CEST)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-61ab173fe00so122721847b3.3
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913110; x=1714517910; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=eOozvj3glB6sdsKF5Juu5L8bKFQZW0f5cjVRMvpomsU=;
 b=xxykyOUgw2YSc+WJIowiPE7VUT1jNQJrgILyLDEC5zi7sU0u+4AYFKjSi+WnlKJpzy
 RMHMd8OQwm9VoCIfxBAqe//8Hr46ylT/SFj7zdsoA0hP/Q315Rqae/X0/nE+CIL3RmDz
 MnD9x9OLZLQVqrOyzeiO7ApROn7XPFKvpg/xpmp+z1cTNqTLJDCaOX40tkWdczIdELCJ
 tdc4jZiUHATu+jw26Nfn6pCBOxTueuYXnuOTpcQcNOqIR7VAShVAxQPEFUwu9Ddj5jSZ
 pKFdIQp/G2pFcHOWlW0sOMvp6vwubrWGF1+Z9nqVq4oYMHZ85xM1+HPF5NwmndHBr+L2
 tFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913110; x=1714517910;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eOozvj3glB6sdsKF5Juu5L8bKFQZW0f5cjVRMvpomsU=;
 b=FbrGrl/1tul0H7EXj1HJsKfwFuD4/REkMIN0HwvUbNUaNrNlbWvZfjj+m+6SE4mcvr
 yx0GOCAGYMlr88lVzioMbjpZuWbsILT7cXtj+LexaXq8fzTUWPQBA0TwYd3MMwDZxPlZ
 RnYnbQwwYA95qjwwZ/mvFIj57rrIuoeYGl3ijTNOtU3K2OScT/XG18gR05rgf57FJODk
 P28uizTLUbO0WUC2/xuhY/M971RPScnTXz+PjnA9MMsfkBQq+52RHNyFL6EP+MwuAKGF
 Z9r1xkjuVITg5HXkK7Dw25ebFfMdrmueBaaX46jsA5dkdLOP41ni5JlffPr9qrWouFCE
 Y45g==
X-Gm-Message-State: AOJu0YwF4Hg6p+xahUkrK3lCctqUJzKcUsHxE12huAC7ni+deLCIhf48
 VfVlWhAgezbEBL7VvmYzN4BMHUdZKL11g4tONk4u3u3CS+SsuXqMquVkUju0JIgktvrxQs5KEui
 eYu6Y2gBPGXitaJDv38kauobGBOA3bwzd/VyEfUyG8ZLo3fW+/hTHZheSRPY5k6umeIVCvrh/82
 e0U8D0iSyft/yT1B0ZjSGIj+c/Pbe+VVg=
X-Google-Smtp-Source: AGHT+IFUZfSZmm54yv3CFZvrSw25y6hYoCw9Blh+0W8VN78E7cyzOD6ZdqO1ArVxg4rlrynE3+U1o3YvPg19
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:260f:b0:de5:4ed6:d3f3 with SMTP
 id dw15-20020a056902260f00b00de54ed6d3f3mr301345ybb.6.1713913109941; Tue, 23
 Apr 2024 15:58:29 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:57:59 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-3-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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

Use atomic type for the ball value, as we don't have any locking
going on.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 1e205219d..359c96703 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -71,7 +71,7 @@
 #define DEF_GAME_LENGTH 5
 
 /* Here's the position of the ball */
-volatile int the_ball;
+static atomic_t the_ball;
 
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
@@ -122,7 +122,7 @@ void *thread_offense(void *arg)
 {
 	atomic_inc(&players_ready);
 	while (1) {
-		the_ball++;	/* move the ball ahead one yard */
+		atomic_inc(&the_ball);	/* move the ball ahead one yard */
 	}
 	return NULL;
 }
@@ -138,16 +138,16 @@ int referee(int game_length)
 	now = start;
 
 	/* Start the game! */
-	the_ball = 0;
+	atomic_set(0, &the_ball);
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
 		sleep(1);
 		gettimeofday(&now, NULL);
 	}
+	final_ball = atomic_get(&the_ball);
 	/* Blow the whistle */
 	printf("Game Over!\n");
-	final_ball = the_ball;
 	printf("Final ball position: %d\n", final_ball);
 	return final_ball != 0;
 }
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
