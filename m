Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056D3C44512
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 05:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784698914; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=NJTwiBLN2l6QPFbqLm2xqzPKcKMQKgZ6I64xaxe2onw=;
 b=PXJHj6c3f8MD+/NdZz9u/Nrrp/FHNtmRyV2WN3ww96bwI1Cr1eTaOKj2hu2MZe21ilK5L
 aS4kzRs+0krX8V69U9rzX0e4eep3saOIPCmBU4Xt7UilG6SHnrsm542ycKMMHy4skbffuZa
 labmeoJ/uhsuFuEoDX50CZcEA97WdC0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 908CD3E1F83
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CD363C0571
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:41:33 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 780FF6010EF
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 07:41:33 +0200 (CEST)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cbb7926836eso1231233a12.3
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1784698892; x=1785303692; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ibpBk+GGyIYiJnw3tXq+GzE0nkvLfHLywKT61AZnNq0=;
 b=Eu9RB2AfdOdpb34WZo9XKWynJx3maGja9JIq0iOFhdp5oBVwlxf2MYvpb37TPvm1vG
 0he/2NBv0RCT1jyqXltsBZG/termnDCgElOMI5kdoW4raDKKdlep/Bpyukz9CAbpTC5A
 kY7j1v3BtNldAApgdoD+Rf5R4c3sPAa8Ft7te0dsS+8q0VFb6FCbv2CtBI2wkgKKiw21
 JysvGVanoQclMPD4y+5P2ONC6wLsChKfAPureV+61MPCO+mbgPBNoeaRXiU9CBY/+bNa
 5M2A3sx53FZFhKiHYv665DIe0bns90MqNjfnnAQiSAoIDorWWKxRpDyocv/sZvb60N3C
 o5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784698892; x=1785303692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ibpBk+GGyIYiJnw3tXq+GzE0nkvLfHLywKT61AZnNq0=;
 b=MEXKJEJFRDOcmcqU/SOBa4fUzdm56dC3BiQfE1L0Ouynj7JXU2rlvguDu0iLwyNQ8f
 lPEqEd+NrPGtFAbE+MEB0t1NaTw8mYnqim74Mq1rZcFsDRdFpirYobVeLc7aiaEf1Kit
 kzAFF4UCVyL2mJbm/mzHAFJtchy5vTkHT8S8VXz/KakNWCdE3lnVStZR54TC5TFsLFNr
 dRhCzfXhUx3+zAFZr3KqxkEkNq1vfGkUR0VczA4d3e7ZqgdKYtGRlKor+wFspFytUqVH
 b6Jaf4XX1rBW4LnIXkkBjiS9X1SVUOSgfAn8hriCW4X9dYLE3nrCoxek1fDtlSSIjBUx
 S2cg==
X-Gm-Message-State: AOJu0Yy4DLvVEN6JkIiqham+DZxsFf9nJcjuHjVeMoK8kD/QmvuSmtBr
 Z5bWHFoWH50J9qWhAJA2QibKV2Z2OYIEtd7o1sFhbUetcC95mZrWn4L032wT/+KHGyk=
X-Gm-Gg: AR+sD13eSvDEglfq8UPHCPxHIyd4c+EaWwGZhDUnyCWB+tQutiAjR9WEShtOkQjDrKP
 1yaMzjroXstw52M8xfVqah8PNwXXjAFATk8/GGwpE7RbUoeX0E0x4IKlTSUgPKmw+7ofAlJcsAm
 WizxaCRXjp8l09nxezqrYl5g0YGBHtAhbIsenGI9qKOW51rJ3kDszcLZOQXDiDapWNMX4iQNvDa
 TfjSAI8xRuvRuY+Wl+yv2WOx5MQzgRNLEW56m9mDFm0JkZEN6kuUezNU1xGyqQKWTNxC3Q52jQH
 P4TiNKvQgE8KzvSswFfIJo9NnrcDP6GuG+4vUQdlgkuxD64Pbmm9TU1W7dPZ2X/LW77yAzeHHpZ
 3UKPdyATieWQW8k90E5K/ERnqE/cyuhDDe+4XvCqUfTz+jfi+czzjYTE27ks7p54=
X-Received: by 2002:a05:6a20:918e:b0:3bf:6c04:a819 with SMTP id
 adf61e73a8af0-3c3ad9e7e87mr22199358637.58.1784698891758; 
 Tue, 21 Jul 2026 22:41:31 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147df0686fsm5055484eec.14.2026.07.21.22.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 22:41:31 -0700 (PDT)
X-Google-Original-From: Tang Yizhou
To: Martin Doucha <mdoucha@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jul 2026 13:41:25 +0800
Message-ID: <20260722054125.197919-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] perf_event_open03: Track SUnreclaim growth instead
 of MemAvailable
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
From: Tang Yizhou via ltp <ltp@lists.linux.it>
Reply-To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Tang Yizhou <yizhou.tang@shopee.com>

CVE-2020-25704 leaks a small kmalloc() allocation (the filter's file
name string) on every failed PERF_EVENT_IOC_SET_FILTER call. The test
detected this by watching MemAvailable in /proc/meminfo drop by more
than 100MB over 12M iterations.

MemAvailable is a global, system-wide estimate. It is heavily influenced
by other memory activities of unrelated processes. This produces
intermittent false positives: the test passes when run alone but
occasionally fails when run with other tasks.

An improvement is to track the growth of SUnreclaim instead. It is less
sensitive to other kinds of memory activities.

Also note in the failure output that unreclaimable slab can still grow
due to unrelated slab activities, so a failure should be confirmed on an
idle system or with kmemleak before being treated as a regression.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
v2:
Take Vlastimil and Cyril's reviewed-by tag.
Update the printed error message.

 .../perf_event_open/perf_event_open03.c       | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 389cc35111b4..a4ce6eaffc02 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -77,13 +77,13 @@ static void check_progress(int i)
 
 static void run(void)
 {
-	long diff, diff_total, mem_avail, mem_avail_prev;
+	long diff, diff_total, slab, slab_prev;
 	int i, sample;
 
 	sample = 0;
 	diff_total = 0;
 
-	mem_avail_prev = SAFE_READ_MEMINFO("MemAvailable:");
+	slab_prev = SAFE_READ_MEMINFO("SUnreclaim:");
 	tst_timer_start(CLOCK_MONOTONIC);
 
 	/* leak about 100MB of RAM */
@@ -92,28 +92,34 @@ static void run(void)
 		check_progress(i);
 
 		/*
-		 * Every 1200000 iterations, calculate the difference in memory
-		 * availability. If the difference is greater than 20 * 1024 (20MB),
-		 * increment the sample counter and log the event.
+		 * Every 1200000 iterations, calculate how much the unreclaimable
+		 * slab has grown. If the increase is greater than 20 * 1024
+		 * (20MB), increment the sample counter and log the event.
 		 */
 		if ((i % 1200000) == 0) {
-			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
-			diff = mem_avail_prev - mem_avail;
+			slab = SAFE_READ_MEMINFO("SUnreclaim:");
+			diff = slab - slab_prev;
 			diff_total += diff;
 
 			if (diff > 20 * 1024) {
 				sample++;
-				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
+				tst_res(TINFO, "SUnreclaim increased by %ld kB at iteration %d", diff, i);
 			}
 
-			mem_avail_prev = mem_avail;
+			slab_prev = slab;
 		}
 	}
 
-	if ((sample > 5) || (diff_total > 100 * 1024))
-		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
-	else
+	if ((sample > 5) || (diff_total > 100 * 1024)) {
+		tst_res(TFAIL,
+			"Likely kernel memory leak detected, SUnreclaim increased by %ld kB total",
+			diff_total);
+		tst_res(TINFO,
+			"Unreclaimable slab can also grow due to unrelated reasons as well. "
+			"You can rerun the test with CONFIG_DEBUG_KMEMLEAK to make sure the leak is real");
+	} else {
 		tst_res(TPASS, "No memory leak found");
+	}
 }
 
 static void cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
