Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA525C2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359655; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qrw+sy62BekQvLKJu2HUcwhVrztuk2fltcmtj8t3I/U=;
 b=aF91cuahosh8ksj9RCHehJyH7sjNtMlNvfGgNX2Pm9u36IwnkUBloOspIXtXbD1mXPiu2
 PcQ5KRz8zxfN4GcrXLHNADEioN6VAjXDuQCj8flfi/fD1qvfNG/aGrFyStCRTCEWvtM0IMH
 HV4MH0vgh8RBKuzOeGVZjcUJUddd8aQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 328513D1124
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:54:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92383C13C2
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:58 +0200 (CEST)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12F97208187
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:52:58 +0200 (CEST)
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e02b7adfb95so13725237276.2
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359577; x=1719964377; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FTp9q60rzLSN1frYIZugxdoapi1PLWWITI6bDYejvog=;
 b=RtpNDVXbIZ5uEnXx5/MJn/iMnn9dYESgsjcvie296/COMPRpO90WiPkh5yUEKt8/d0
 P1VAEZQDU+60BHsKPsYp3xjRe2HRv/PnPpUMydXaXson7hw2gFg/vxo3MBH6WJ7D/qj6
 l9fqvP4GdENqym7H4Isg+NLHncgoX69SUp2ZmWByGE1/nVOw9CZTxrUAucu31K9P29Og
 iwEWOsstXf79jqemse3DRx1+m7ZRV13ytEYPmqqCJ/9SjUdb6V1C8DLqw5nOmgH66xBk
 dcjfxyy9x7KPGyoyNPkhLpxIJg80DhzQZxC67YTmgzACJsKhxAKLazHltJlnemCuZ93Q
 feYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359577; x=1719964377;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FTp9q60rzLSN1frYIZugxdoapi1PLWWITI6bDYejvog=;
 b=JE7j2soHDOByoKkDNl85i4Mu5wL4oc+tHC4C26v8eDE6HkXMhVoGJ7Tj1bofu55Ayl
 Y7TjKUcSfw35cT2o85J3Hz4Owo20ZnGE6lzVQ8ma4euBqWcVv+nZN7WKxm4iIJMDZCv/
 DzM0sAXRg4GuSAWe+IO5WcwLOBWaIz4jxHjT55c+Yt2SXAOR2NDoyu3o0y+UvtAkFCgG
 x7GmyCP4UyM5vAkTw7sNYdr/Ucc6N0ksZVLOAghdaLvFHd6FERUXXKEKLI/zU8I4NlU6
 /Z4IdgjkVxD4aE5eR9l+iFZskNbbP0q0thyMirDjKDixlWtmPZXUH9h6pcw0yei8WLFB
 skOA==
X-Gm-Message-State: AOJu0YxFs8VzP7C18F2bRTkvJVHM7A27NMMyrV3315+bUEhI1OQ2VP0n
 QbmvfwDm/Rqv/FLMhupSi9i52fMxLi9GPCrzJjkrvr7DV7zlVijV8OT113ueT0oX/vjD7EFwe7L
 tzqbtly9KbPIhRgLa/Hs/z1/ARSKYC5lvSjb2vpCZftCBtGOHB0cfxpmYpPNAObBG88AEeXoonM
 0LWpNOWbEsoKRg3CZJARR/KeVSn11oTHA=
X-Google-Smtp-Source: AGHT+IHTMAq5B4jby4L4d1fu9lo1u5/NG9J/4I8XIAUylSuq/8tFHK6moQy9jozi+EeXaQK8NHS7orwuhS2h
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:2b8d:b0:e02:c619:73d with SMTP id
 3f1490d57ef6-e030403de41mr320987276.5.1719359576596; Tue, 25 Jun 2024
 16:52:56 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:31 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-3-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/6] sched_football: Use atomic operations for ball
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

Use the tst_atomic* methods for the player count and ball values,
as we don't have any locking going on.

Cc: kernel-team@android.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v2: Rework to use tst_atomic* methods instead of atomic_t, as
    suggested by Cyril
---
 .../func/sched_football/sched_football.c      | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 1e205219d..1a1bc5780 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -67,15 +67,16 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <librttest.h>
+#include <tst_atomic.h>
 
 #define DEF_GAME_LENGTH 5
 
 /* Here's the position of the ball */
-volatile int the_ball;
+static int the_ball;
 
 static int players_per_team = 0;
 static int game_length = DEF_GAME_LENGTH;
-static atomic_t players_ready;
+static int players_ready;
 
 void usage(void)
 {
@@ -110,7 +111,7 @@ int parse_args(int c, char *v)
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void *arg)
 {
-	atomic_inc(&players_ready);
+	tst_atomic_add_return(1, &players_ready);
 	/*keep the ball from being moved */
 	while (1) {
 	}
@@ -120,9 +121,9 @@ void *thread_defense(void *arg)
 /* This is the offensive team. They're trying to move the ball */
 void *thread_offense(void *arg)
 {
-	atomic_inc(&players_ready);
+	tst_atomic_add_return(1, &players_ready);
 	while (1) {
-		the_ball++;	/* move the ball ahead one yard */
+		tst_atomic_add_return(1, &the_ball); /* move the ball ahead one yard */
 	}
 	return NULL;
 }
@@ -138,16 +139,16 @@ int referee(int game_length)
 	now = start;
 
 	/* Start the game! */
-	the_ball = 0;
+	tst_atomic_store(0, &the_ball);
 
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
 		sleep(1);
 		gettimeofday(&now, NULL);
 	}
+	final_ball = tst_atomic_load(&the_ball);
 	/* Blow the whistle */
 	printf("Game Over!\n");
-	final_ball = the_ball;
 	printf("Final ball position: %d\n", final_ball);
 	return final_ball != 0;
 }
@@ -165,7 +166,7 @@ int main(int argc, char *argv[])
 	if (players_per_team == 0)
 		players_per_team = sysconf(_SC_NPROCESSORS_ONLN);
 
-	atomic_set(0, &players_ready);
+	tst_atomic_store(0, &players_ready);
 
 	printf("Running with: players_per_team=%d game_length=%d\n",
 	       players_per_team, game_length);
@@ -185,7 +186,7 @@ int main(int argc, char *argv[])
 		create_fifo_thread(thread_offense, NULL, priority);
 
 	/* Wait for the offense threads to start */
-	while (atomic_get(&players_ready) < players_per_team)
+	while (tst_atomic_load(&players_ready) < players_per_team)
 		usleep(100);
 
 	/* Start the defense */
@@ -196,7 +197,7 @@ int main(int argc, char *argv[])
 		create_fifo_thread(thread_defense, NULL, priority);
 
 	/* Wait for the defense threads to start */
-	while (atomic_get(&players_ready) < players_per_team * 2)
+	while (tst_atomic_load(&players_ready) < players_per_team * 2)
 		usleep(100);
 
 	/* Ok, everyone is on the field, bring out the ref */
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
