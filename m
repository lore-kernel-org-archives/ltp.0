Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A44C2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359733; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4R1rbuev/YzpOMkyOVMTQ6hAArzUQKySOjKWj1cjhBg=;
 b=nhGfWlfu36VtiqUm49c9/4s4LNm1LJ5aU0gFJkdbsUPjKn/8sBW/BBYjPoMg88zybE1CK
 pppknITzKKtsQXGOiWYfleMQRXZPOaZ0PQcr+SDEJSHfpe8tvhSPGGTboQgVw8h++6Oayk7
 r1lD09bL1YragXBAguEPWPJrP3qS9Uw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C943D1195
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:55:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF5463D1088
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:04 +0200 (CEST)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B0941000A6E
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:04 +0200 (CEST)
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1f9db3192d8so109975ad.1
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359583; x=1719964383; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=1RjNx0X5MMH94tgJLHaciaRMPRy6awqueCCvyIXUcuY=;
 b=Bw2mVD1qKTz6lVasw2gJhOZNeA3Nkm8rgCv5YYLXzxJ+/TE6lFmUZk5/1uUgvPBlRx
 6nJ70VXdwwBboi9N+jrdOpm1vRdldOt+nfLbgqRSNFi03/s0tGt3soW8dsdIyW7IX017
 hv3IMSpEOlKpC9sjXXOHrxJFpeF/nulQWPatSv6u0bnRjo+6YZshxwIdEvCEyFHEFGw5
 2XEaqUTHCOPfzQK5POYXMPfW160rDlOGnQ0AE91j6EkdvZg/J+5dI6GaL92I9GZo0GZ6
 Zer2Dmlg33gkKvz8sqyRZ4XG176Cjv3jgOpUY4HtTuBA+fKpCU8popcYjaYOBDH7Gefc
 V3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359583; x=1719964383;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1RjNx0X5MMH94tgJLHaciaRMPRy6awqueCCvyIXUcuY=;
 b=ViTU48o/NgRfw2VA8N+dlDpNDsnJuX/dJ/UOlLs/k7pbSQ+OFWHUhMzgdYPm5Gii1a
 XTVYtb8z8qSyw7hFlcKqiFRAKQTgNuIdi551OQP6fgnScdWcI/xwU7+HC0Z+Ptcp59c4
 LajcZ0E+O2qrReczyd/M+bP2lvXAly4YDechH2sr8QbWNrs+qNn+c4pSIAG4Ek61rLBX
 6ngAq428HglJsoMCf7Kz89i/zcjEUfXjiXuaRzICdF1fYSYFscJpLmPu2s+J7GotrLBV
 /2R3cjJnLS8VRSYsKtnAHPkupPXRaxCSEC7pg2TjcYL86ol7n6eSs3PTNUa7aE+MZGT9
 bzFg==
X-Gm-Message-State: AOJu0Yxy/s3bMzQHBJpFTAMEsMinF0KBl/3sWJcX8VeTf5EVF8PwBuQA
 h8bNYKNXdPuerRMW9EjrqNJuw6l+416yLsI2J8LRQQ9miUUMfK24O9RDVsOUYpSPTUxRLbumxVB
 fNPj3EOQ5B5VPijFhNsUm4DbqwHUSzV8vqLDTJv+8WUm1zfOaCPZw1ciYmY53UH4R8gikg3pQMp
 FaOEd5b/gxcDUonv3iI4m1jK8DW5gXk1Q=
X-Google-Smtp-Source: AGHT+IGSeRIvgcyduRMGaUmfe64cRdqJpxxy47rIXV2vC+6rFIxpvsmzueKyuoSxUGtpiOt3H+Hd0LmB55NT
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:f685:b0:1fa:1a78:b5bc with SMTP id
 d9443c01a7336-1fa1a78b81fmr5492035ad.0.1719359582629; Tue, 25 Jun 2024
 16:53:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:34 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-6-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/6] sched_football: Add prctrl calls to set thread
 comms
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

Make it easier to follow whats happening in traces by setting
the thread comms to be more descriptive.

Cc: kernel-team@android.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 9d12f0193..40496cc22 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -68,6 +68,7 @@
 #include <errno.h>
 #include <sys/syscall.h>
 #include <unistd.h>
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <librttest.h>
 #include <tst_atomic.h>
@@ -119,6 +120,7 @@ int parse_args(int c, char *v)
 /* These are fans running across the field. They're trying to interrupt/distract everyone */
 void *thread_fan(void *arg)
 {
+	prctl(PR_SET_NAME, "crazy_fan", 0, 0, 0);
 	tst_atomic_add_return(1, &players_ready);
 	/*occasionally wake up and run across the field */
 	while (1) {
@@ -142,6 +144,7 @@ void *thread_fan(void *arg)
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void *arg)
 {
+	prctl(PR_SET_NAME, "defense", 0, 0, 0);
 	tst_atomic_add_return(1, &players_ready);
 	/*keep the ball from being moved */
 	while (1) {
@@ -152,6 +155,7 @@ void *thread_defense(void *arg)
 /* This is the offensive team. They're trying to move the ball */
 void *thread_offense(void *arg)
 {
+	prctl(PR_SET_NAME, "offense", 0, 0, 0);
 	tst_atomic_add_return(1, &players_ready);
 	while (1) {
 		tst_atomic_add_return(1, &the_ball); /* move the ball ahead one yard */
@@ -164,6 +168,7 @@ int referee(int game_length)
 	struct timeval start, now;
 	int final_ball;
 
+	prctl(PR_SET_NAME, "referee", 0, 0, 0);
 	printf("Game On (%d seconds)!\n", game_length);
 
 	gettimeofday(&start, NULL);
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
