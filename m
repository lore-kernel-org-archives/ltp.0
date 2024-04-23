Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5212C4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961439; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mSDu8gy9iKS42KWnwCxR+bAP4YnHCdmgZIlsvQ7Mk70=;
 b=RWdNMhQM9XbdqSXKjtRlu+WdTvghMPJULzUqGuL6G+HSz9LZMsWBQEXJpjc2qyLxDNBxb
 sj6qQ3q6vIX+Qw+gefDiqcovh1qW3J8QT//wk9ip++/8R04sjKbl+bnAgB2i3A3wqHwcbhA
 sz30dELXhhKYF1lG+nRzXAnD5zfiSn4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 712AE3D003F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:23:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 171063CFA6F
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:37 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3C501A00819
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:36 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-61b4ede655aso56362657b3.0
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913115; x=1714517915; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=H4PkHezeEtQtk0O3/8OMzikJgl6imPnEzi39ldKY/9A=;
 b=i1Q46RVXcFZeVvB+Y0AVTXkSx3hvdVyeWALhI8VjoQzCDREgpXgqTmR8mu0E2HKl5E
 tHC0/6b0a0lJhVyXQJpxBs4Q9Ir4/jEzmSgOejqNf/pgxwV12c76hmBGWyC3yVbfwuL2
 ORUZUuhj7i0IgkxGx6oYrbXk16l4mPK7+SjH86ADkQvdpDwrw1l6oqGMD37pK91HXoOU
 a4Pkxkuwd01UfrH27LzolUplZ1sgMlKA6BDO1/3jksH/U+c/dWZSGYuzdvkweH3f1eBd
 dczL+Q2vXoxoUfWPFd0TEnq/asxueDp11oZrdb/Di9ameC3FuM6wgslQxkkkmbowXthZ
 mtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913115; x=1714517915;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4PkHezeEtQtk0O3/8OMzikJgl6imPnEzi39ldKY/9A=;
 b=CwUYqRC88GYSwhJgYAnDW4jCEKvJtxwwgoaFyRtjIla9Z7hIJgfotzSz8Jej3R6Ytc
 WNnB1AX20H6OIIwuM9wBOy1lNgs1DIj1iTQ+v7y0fNPu/jo19YiC/Q73wE3eP894lFVR
 QOkmZ/i4w7I3lS1q/EWTaIGt6/GdaQUjG5yb6OOf5pe6huNnjljrtEC6pN06h539Tkdb
 ry1v6SGfnHyWdf5GII12yfF9tzq+LfWe/nhtBfbWicnJ1wdsAk78cI9Ib+99Z8udx/jf
 8yRAVFJFV0nnWkLQW2PlD0S6rl6DXxRn5FArnSKDwr+xMVMeRz+RZkNttC0+akVrqGbT
 VO0Q==
X-Gm-Message-State: AOJu0Yz4g05WYzCh4my4turGhl4DlAGBRk/fZCdP1/OWQ5jAleZOTL5c
 uFHPbag2bsSUNPb85HkGlOrXocUFFMd2as0YGVQ5DkBsNXsjihzO+6OWKGLcJkqYQLCYaZx+CQB
 A0z51WINb6wTkjTffuAlEYisxlSs6KIOx1uQimMXyUH01/lotX8HFHL0Bvzbj79IvTuDid6n2GI
 NA2z4kUHhK5VT8xfvfpE9kf6rfzz371b8=
X-Google-Smtp-Source: AGHT+IErZiOWcCQR/gkEqy5p9WloewHYU4m5X6hMTYiId0b3noSeE/P+sLTO26smhOpQPnQLqzSGo2vnhJF7
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1501:b0:dce:5218:c89b with SMTP
 id q1-20020a056902150100b00dce5218c89bmr134338ybu.5.1713913115409; Tue, 23
 Apr 2024 15:58:35 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:58:02 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-6-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 5/6] sched_football: Add prctrl calls to set thread
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
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 7686ce3e6..45fbf6766 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -69,6 +69,7 @@
 #include <errno.h>
 #include <sys/syscall.h>
 #include <unistd.h>
+#include <sys/prctl.h>
 #include <sys/time.h>
 #include <librttest.h>
 
@@ -126,6 +127,7 @@ unsigned long long ts_delta(struct timespec *start, struct timespec *stop)
 /* These are fans running across the field. They're trying to interrupt/distract everyone */
 void *thread_fan(void *arg)
 {
+	prctl(PR_SET_NAME, "crazy_fan", 0, 0, 0);
 	atomic_inc(&players_ready);
 	/*occasionally wake up and run across the field */
 	while (1) {
@@ -146,6 +148,7 @@ void *thread_fan(void *arg)
 /* This is the defensive team. They're trying to block the offense */
 void *thread_defense(void *arg)
 {
+	prctl(PR_SET_NAME, "defense", 0, 0, 0);
 	atomic_inc(&players_ready);
 	/*keep the ball from being moved */
 	while (1) {
@@ -156,6 +159,7 @@ void *thread_defense(void *arg)
 /* This is the offensive team. They're trying to move the ball */
 void *thread_offense(void *arg)
 {
+	prctl(PR_SET_NAME, "offense", 0, 0, 0);
 	atomic_inc(&players_ready);
 	while (1) {
 		atomic_inc(&the_ball);	/* move the ball ahead one yard */
@@ -168,6 +172,7 @@ int referee(int game_length)
 	struct timeval start, now;
 	int final_ball;
 
+	prctl(PR_SET_NAME, "referee", 0, 0, 0);
 	printf("Game On (%d seconds)!\n", game_length);
 
 	gettimeofday(&start, NULL);
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
