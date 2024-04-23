Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7421C4345F
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713961462; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oskmwMlHhawqZ6NM9oWWhB/h6OBL0RhJhZHEZTiyeQE=;
 b=XPq2k2HW4LcGAooeeiBtffhncXqc4qk+8zmlmeXgTuHmT40JeCEpUYJHckqCWhDgMncxA
 NRwu8kuchYMyBoVXjWCUcC7OrtrxtC0bYg2BjC0whROs4BVmNdvT+K0M6TuPKOpfudi20pI
 inudIrtwuQFCAnN8B+eCKR1/gjmNjKg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2F53D0044
	for <ltp@archiver.kernel.org>; Wed, 24 Apr 2024 14:24:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 214573CFFC0
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:38 +0200 (CEST)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5ED8560227C
 for <ltp@lists.linux.it>; Wed, 24 Apr 2024 00:58:38 +0200 (CEST)
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-61b32e7f94bso101236447b3.2
 for <ltp@lists.linux.it>; Tue, 23 Apr 2024 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713913117; x=1714517917; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9xllRW4ZA5JYHFU0T9o/gXf96UFUHa4Xku3XM0BO74=;
 b=Qw4t+UENBMUrho6JL2lHJfc42B6rz6tAERYM8f5G11imlNEZXQqnHQv+Fe+P663IrG
 mGEDirStCFbf4x5WNeeXLeOskyLeZIoKGhfADGKK2ggAO1Y7W/DXKMCdzsYVQIsNeD4L
 mo1WmvMSBYMLOs9Z8iYSBheNQKA3Dd4x51rbD/lp1w1RCDej0oWimt2hL6BFRg2lr+Fc
 vClHGtoDaIy3tlrgKNo2Omr+QY78kYjwBolQ2CG1Xnuv5aC2VGgCGTOk9Pxq6aoRRvdp
 uXI9h2/X/GQRNW89gDVol03prn4t/FtRI01DhT7pDvDZHPo1mBBSvpZ3SzvIbmG0Rv2O
 CfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713913117; x=1714517917;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9xllRW4ZA5JYHFU0T9o/gXf96UFUHa4Xku3XM0BO74=;
 b=LlCXwep/riKIQRXqNjUh63LXPFtyMpZPwcIBGqh+YcZZ6RtgU/4IIqra00rZ0ebyFH
 q0KV0PWSnBaYcVVrs5q3pVmzvFxEMy/rcyVOzgY+GdicwEOBoQQA78gs38wSEslNM51s
 bmiSXjZ3baILDSeFWGwO6buh9qhtiavD9Bh218Va+fgyi1NGv5fPb9Y5hRv9Yxw8gb/Q
 cLhU35NYvWhyXqLGxk04q1eopqBs23mZxYcpcG7TyVMf3skp2/59jFwFjGnfD50+CcXS
 jEbBrL8lXY8K91NJErBWzXP45+xQFsseDklSg6uwl5ynJqe9LHxIBttlfuBtdXY4T4ch
 /IcQ==
X-Gm-Message-State: AOJu0YyS7vNjyltaSX34dTbRd5YKuc9UtDfvbNIIxse7w+XU4jMuxXkz
 oxZBbljsFmguiPLAcuBnh1IeTCqwjvUi6Bdfo0+msW2o2ib+AROFKaCvsKaj+TFfIQ6sLplyUaY
 kIIvMvFbVdXS1yOB1VdOgKNTqwVRmdzG2W9Gd5tc8eOIJAEq6CUrVJQmoK653winO6fc7a1MWLG
 YYbYz54vv4Iiu8m0vjClJ778hjGMdSIj8=
X-Google-Smtp-Source: AGHT+IGZ6tIBtUNuM79+LQ1Gehc+RwjSL0Y97HoMRUJPcQPnzvL23icc0QOgBqFugmZ14xROuCRiRbGtNo14
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a81:848c:0:b0:61a:c7c9:5392 with SMTP id
 u134-20020a81848c000000b0061ac7c95392mr220869ywf.2.1713913117181; Tue, 23 Apr
 2024 15:58:37 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:58:03 -0700
In-Reply-To: <20240423225821.4003538-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423225821.4003538-7-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Apr 2024 14:22:03 +0200
Subject: [LTP] [PATCH 6/6] sched_football: Add trace_marker messages if
 we're tracing
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

To further help with tracing, add trace_marker messages so we
can see exactly when the game starts and ends in the tracelog.

Cc: kernel-team@android.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 .../realtime/func/sched_football/sched_football.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 45fbf6766..ca44584b0 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -67,6 +67,7 @@
 #include <pthread.h>
 #include <sched.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <sys/prctl.h>
@@ -167,10 +168,14 @@ void *thread_offense(void *arg)
 	return NULL;
 }
 
+#define BUF_LEN 256
 int referee(int game_length)
 {
 	struct timeval start, now;
+	char buf[BUF_LEN];
 	int final_ball;
+	int fd = open("/sys/kernel/tracing/trace_marker", O_RDWR, 0);
+	int ret;
 
 	prctl(PR_SET_NAME, "referee", 0, 0, 0);
 	printf("Game On (%d seconds)!\n", game_length);
@@ -178,14 +183,19 @@ int referee(int game_length)
 	gettimeofday(&start, NULL);
 	now = start;
 
+	sprintf(buf, "I|%i|Game_Started!\n", getpid());
 	/* Start the game! */
 	atomic_set(0, &the_ball);
-
+	if (fd > 0)
+		ret = write(fd, buf, strnlen(buf, BUF_LEN));
 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
 		sleep(1);
 		gettimeofday(&now, NULL);
 	}
+	sprintf(buf, "I|%i|Game_Over!\n", getpid());
+	if (fd > 0)
+		ret = write(fd, buf, strnlen(buf, BUF_LEN));
 	final_ball = atomic_get(&the_ball);
 	/* Blow the whistle */
 	printf("Game Over!\n");
-- 
2.44.0.769.g3c40516874-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
