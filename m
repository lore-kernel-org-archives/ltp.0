Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A92C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 11:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784027617; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=kTpC7rs27OsuBNn1RpNP1jC9iQbntoFFsCiF2lRfxbs=;
 b=gor74B1ZOJoqW6ZqOmUmQBEmeYD/NgqOVeFaYwEcRr5qMsuuRsu7tNINsUI9Pnl5sCiUr
 noGM/mGxvG5ZumG+Ioo2cGpEKOPEFHakXnfIpba7WNtmRTakgCWjh4XvcxNPFuINSE9zu21
 ewPozlFrpIIRHXbjwcv+QE41LEFd3sA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7455E3E574E
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 13:13:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 963503E2945
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:13:17 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AA038200055
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 13:13:15 +0200 (CEST)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so30083165ad.2
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shopee.com; s=shopee.com; t=1784027594; x=1784632394; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oV5C2wg8S76aVwEPzgeOLfhpuDalnze6JJATNK83lQM=;
 b=VGyne1FUBDW1rmzbGxcPRpaCpYAroJXz9u/TQfwl9TSY/U4OIoAec1AY6qRbWPSq8L
 dKjK9xo317OZwtKLkxmrES04qCN8sMVX0nWGNIU8RI17Ss1rR/y/IFUGSz7IDQyKL1GI
 f1zKkUZoVIsb+nk/cbFSZ9LzAOjD8Y4SUX71KV37RHo9KCdaIG6+kdcdF8nqRrNxx6kR
 gudfILubauELfFH4Fgd/Pv+geFU6Fgbz2jZ6vagJqAhZllVReUSvDIOKnJcInIZjVTry
 Eo4Jwe0XNT3Ufmag5VpuymvK6mlN8eYKR7sbW0dZnG/A1x83fubxA7PteIJ7bf4Jlilw
 m9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784027594; x=1784632394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oV5C2wg8S76aVwEPzgeOLfhpuDalnze6JJATNK83lQM=;
 b=Cqrsgyko2FqM6PNMh1+6PPBAjnZ6mn7860bFfKajwK/MCNx/bJv9vsY9anGlDsj0wL
 74mifrVKIFep2esECGA4V3kIh/1yAF6RMfbFONBoC9mOqMJvmu+e6raOrBxOiyvccTul
 k3VHEC3d2mYr5idjux0nrhuUXo0b0984GvF7oRgNs09Bh3o002fVKNO0sAvuvxNqvjqb
 25H+yLvYcD1He1+gghPCMUoNcYKB5atZHwvG+iU+AjY/R44QFKyT7n7GnFwx9sOvh8PK
 4gjGRZnG59hzUdeswLRz+znp00dpWN+e1YYFQlaXai9jTkou7iBDuwqNktG7GvwO2z4N
 TzcQ==
X-Gm-Message-State: AOJu0YzbF+YWuQy4pbtjEtsvWap1ggclsXyo9aMF0v6hXMRigHWE6GPi
 HmcyWH9HbwVwubLyWikPBXcAPqmXRCJQhqfSnQUp6q2nx2XL9yFJFpXGF76ghbvrChs=
X-Gm-Gg: AfdE7cmyPPnRjg1bO6dbmNCr7ME0OPZwkEYhc5TGZOO/wXnX6khzCFTYvod5lnIH+2p
 1PtxZpETJbxRUGcFEAMhzHJoOjTOIzRTOgOvj4RspKUbM8Gn/zfo4YO8i6ECxC7NhCG639ywARS
 uwRZ1Zfb00j9dy9ICHf37/op8tI18NCn4EX973n9q/3NmSEwxbMcyVzzXOV0wj5jhlBTiDWgB90
 0op0kI7cQClQRnyabEs3KGIbofbtz/a4GkpNZHUOKxQ84crHKeXIMgILxy3+5yG/8p2QW5EOifL
 4g7/BZ9bPYGn7sVEFSIXWioWFzPvFl8O2Bl9lYoL5OzsleN026ohmrDgQwuzHVBy1ug6YmPwkOM
 +dpMzxCqncddsc/Onm9OxKObwARc9BvbZ62q5e8KXPTUojfBwFPiHhGu9+0K/DtePN58UMey2tw
 ==
X-Received: by 2002:a17:902:ea07:b0:2cc:eb5d:2b1 with SMTP id
 d9443c01a7336-2cef11cb1c9mr20636075ad.15.1784027593986; 
 Tue, 14 Jul 2026 04:13:13 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d5c804sm114417225ad.82.2026.07.14.04.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:13:13 -0700 (PDT)
X-Google-Original-From: Tang Yizhou
To: Martin Doucha <mdoucha@suse.cz>,
	Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Jul 2026 19:13:07 +0800
Message-ID: <20260714111307.166205-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] perf_event_open03: Track SUnreclaim growth instead of
 MemAvailable
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
Cc: ltp@lists.linux.it
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

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 .../perf_event_open/perf_event_open03.c       | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 389cc3511..0cc1c27f0 100644
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
@@ -92,28 +92,36 @@ static void run(void)
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
+			"Unreclaimable slab can also grow due to memory activity from "
+			"any other unrelated process. If this test fails, re-run it on "
+			"an otherwise idle system and/or confirm with kmemleak "
+			"(CONFIG_DEBUG_KMEMLEAK) before treating it as a real regression.");
+	} else {
 		tst_res(TPASS, "No memory leak found");
+	}
 }
 
 static void cleanup(void)
-- 
2.39.5 (Apple Git-154)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
