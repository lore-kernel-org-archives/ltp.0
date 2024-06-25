Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFEEC2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359603; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=N7O99ebZ0R4aekAw3xNX9mxbJjW9+JmB1E5ufe0Eras=;
 b=QjZGIXrWuKSF/agCHR57+aUt23bz8d3L8qXJlZdhhMpPel9xkMDYwAmxGFRBIse2mfBO0
 0KIS2nQwWe9QznUgLTU8sgqYZk6wkCeuFadw+b9xcpnnNYhlpK3cwpx/5kpeBIpBpGcjboW
 sNqklMS8RXRpv6v9nI96qovZH0+IBkw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 322D83D114F
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:53:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19B553C13C2
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:56 +0200 (CEST)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com
 [IPv6:2607:f8b0:4864:20::b49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 38204140051E
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:56 +0200 (CEST)
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e032e254319so1377039276.3
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359575; x=1719964375; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jvH6ZIsZFpN93JEbkzVNomsf2DRly8nxONgN5XybNeI=;
 b=jtgXOYtR8nc5mS91PQV2YwCqeW4Jhhy6BcwlFvkE2vw6fFU8etnYOm8qXySyeg9zWN
 qVirbX0SCnDA0C4Z/I1Fd/Prf0H7UQllgiJ/9dtQ5bBR0vWW4lAjT4990MaN5cCGA6I3
 OcgdzlsUyWtMRUn/O9w/cZVKMJ/YPINyenS6mO8BL6+Dr6Mw9amVgWvkiyyzLuVjZydE
 5P6X1ctJ4qDUBd6lupXdPHsXvJoHgRxrYZOmIw9UItyD42j+Y4O2g8LXL2yrVbBZWOok
 avhCgDPPTqTzM0sHo33qxFJHE9Bl8W2aDU0xerZQ7uYYCvEJgdjygFGEhxJf0PT61d5B
 qKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359575; x=1719964375;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jvH6ZIsZFpN93JEbkzVNomsf2DRly8nxONgN5XybNeI=;
 b=Zi5T8g+liS/B766t3P6hjzx1jkRwB2b+UgH4xdRy18342de0+2o7S6Ogm8WdyXoIv7
 ucUUcOelhCvHCM4NtvDDAkvI9mKNhnDU1aY1e69ITaAiM3FCAxSaFwHaNH6wPP1xsgU1
 kucsaNq0+EKsmjbFYTq+f0nog0myEuldQqID/SMR+i5kWIFG7rthA8FBre2Wn4sPCwrG
 Cd/gZ7dfN9Be75vjAjI1TonFR8plJYfMtkZ+8EURJm7BFnc54dsSkuUdV2dK/3sNxHQC
 8LrmOISN6pBgau599O3YL1oXC/rWFRVyaCECXpJoqxQXIzgxorMeUaviuWyN1p+gtl/X
 Crwg==
X-Gm-Message-State: AOJu0Yx4QFecGzorEANKQhNxvXfU2rejIgaJzXCevyHbr1F1gC9X9ase
 DkDRCTUpElcrxNJrpo+3pRrUGnPYy/hsquVvE/qOj8EBDglQDnf4EBPQCwEAVp+ybZ/g5XdKN7P
 y+25xt8egP/M14VAAWpPVVU28tTEdMHyeQi/G81yuGzun+GX9HG8zSRzwypdlX4DuXLD7T82gyo
 OcCGZdo55lkhducI86Bs7gGtnq9I6Gdx8=
X-Google-Smtp-Source: AGHT+IFFir4rky9uC7F0dNDyKPC+EQW47kXfvNgIpW2MPfggNYFPUGk8QcaO8IZTWa4QY8ubC9SjFNmPttzb
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:c591:0:b0:e02:d71e:87b5 with SMTP id
 3f1490d57ef6-e0304009b41mr315710276.6.1719359574522; Tue, 25 Jun 2024
 16:52:54 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:30 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-2-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/6] sched_football: Drop use of sched_yeild()
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
Cc: Cyril Hrubis <chrubis@suse.cz>
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
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
