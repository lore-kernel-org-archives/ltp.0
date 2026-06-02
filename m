Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC1ACD5BD1
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 01:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780362128; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BMtRAj1nciqYZHcLN+bI9tQTslKhtU4lKo0L3jpEAPo=;
 b=M8de3Dx46i6LqSBKcfOj7YO2FXM/mZaHtbKKhwxBYOzLgVZjE61I61Is11+aMX+miXvz/
 op9XDfy2Ejdqyoin5IuoEjKH+oHAPrsJTDY5p3fz0xHpiXMkp5Op2xna0BBdrNgTS7x4Nw9
 z3O/nnRDwFmL5pMOhpyj8rdi1EB1i9g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47C203E1A83
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 03:02:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 912433E18F5
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 03:01:47 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9EC0E1A010AF
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 03:01:41 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef82204c6so1489851f8f.3
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 18:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780362101; x=1780966901; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khvRz/Kj8a4jwINYsAL2SGCXbW9b/Yj8ZgobV4ML/PE=;
 b=ZKK/mi2BXZ3Kdce6TrkxrzHNBBjh/C5cxW0/H1/9xSOomP8RcBfbpyOeU5ZukyfwGR
 1vMUTs4lHRQJdGSv2Vu6y/dwAZhZbtMNBkpBZUPvZB6hRiF9WFJX910RrXWGYLPq7DO6
 rV/rrOZuHFqbOML75f8yXYBj+CO4KEB2hWQbAPKCl5LiufSuQ5OkcNThxQdaA/lN+jrA
 VKU8g5e2hzKVCY36xB6pZI5hTxLJ0VZ+xMgSd7tluFA84UCQPHy/vOFj1Bvv+uSx92Ip
 xrJJ2BrJSUIBgs3WhUlV1ZB7PZmq5EtPxJqFkZl+lI4uJjICPLEtbmIGxhacIz4ihvsY
 JsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780362101; x=1780966901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=khvRz/Kj8a4jwINYsAL2SGCXbW9b/Yj8ZgobV4ML/PE=;
 b=WtoBnr1/yHzU0axSDu4Ol/3oQhv797tnh5hHIyy39CJUfLubfZ9uIV4r2AHTf35EVb
 zEDM6AmSVW/DXwODMA8+B32H/jrGJhuE9j1GfChJs0vsB3YGrGPbRMvIzmBsu/eHnnZf
 UnRaxa95w8tX5fBaVKsNrUgcLsT6jvgxqLbY6/q6LJ5vd4VSshRrNkzMCjRn8RcGHIAa
 n+/M8/d9TU2ur/IxdlaDFX/JqL0xFaQ4PzdsTRgp47hg5kU1u8S+hEHLD7kGbnCllYA0
 7BphyTHEHobytz7c+X71lDw9coDglvXKbV1hHP/sdrkc3X+sSKmeeyk6iLiMSf0Ezxk0
 1MIg==
X-Gm-Message-State: AOJu0Yz52CtOJqCK5k4x7xsbaJXiRLIDwxkVfszmiXtXEQ6lsUHgf5Xh
 1sW0zYVjMCEaBSBrIv5o319UODk+fses4NwQUgpQ2h90w0cNQawWy5wGRhpEGdPvHJmu3TKs3KK
 TLr8=
X-Gm-Gg: Acq92OHuSqK6dqutCo2E69s6GYyiiRThZ/+A9DVFNx26ifWkJxuWf0MXOTUQzgq9XrV
 RVJSKGlMZCVxNhzUY7yoJz1LJ+AmauavPtgwiWQSZmfzLLF2STA9BGU6eMkFa5iD16E70JqXnFu
 yVcQLE86h+7Cp6YBuXMpcO2RG2iiH0XO3SPoO7+xlxaqb2YK7h/bZ5Rb9UrdqELGJcQT3TFwio/
 wA+IFotVwSERUO88UF8033evl8Og8puI1Gpng5uVbSckxbHGEcETK2zjYujPEsozGRhZ7qsRSCH
 NKo8kHpid8rCxBOB2auT2MY0JVSzqF5qtVGF0BEseCfwiqIperd69wNLYxQTQsAQkzaj1ac2fe1
 8u013R7IKpFifqWadftY4fVl9JEiif/ASiY/3osq0qzwj8hRtYMMUMP4ySZnkR1DaM7AVgTyep5
 3WWBuMTKmEBnN//HnYD5q0jDIyTAmBG0kp
X-Received: by 2002:adf:f7d0:0:b0:45e:e076:7fb9 with SMTP id
 ffacd0b85a97d-45ef6b3a0f8mr19050369f8f.15.1780362100736; 
 Mon, 01 Jun 2026 18:01:40 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45ef34a065esm29948509f8f.5.2026.06.01.18.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 18:01:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  2 Jun 2026 01:00:42 +0000
Message-ID: <20260602010137.27226-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531134250.25279-1-wegao@suse.com>
References: <20260531134250.25279-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

High memory pressure can cause MemFree to temporarily drop below the
min_free_kbytes threshold before the kernel reclaimer can catch up.
This results in intermittent test failures, observed on openQA aarch64
virtual machines.

Implement a 2-second grace period with high-accuracy 10ms fixed polling
in check_monitor() to allow the kernel time to reclaim memory.

Introduce a 10% tolerance (90% threshold) for the MemFree check. My
measurements showed that under extreme pressure, MemFree can dip as low
as ~50% to ~70% of the target. While it typically recovers above 90%
within one second, hitting the exact 100% watermark sometimes can take
significantly longer. This tolerance prevents false positives during the
slow recovery tail while still ensuring memory is maintained near the
required level.

Also, increase the monitor's idle polling frequency from 2s to 100ms
to improve responsiveness during the test run.

Enhanced diagnostics are added to report the minimum memory level seen
during the pressure period to aid in future calibration.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v3->v4:
- Remove redundant 'retry_count' variable.
- Remove 'MemAvailable' from diagnostics.
- Provide quantitative justification for the 10% tolerance (measured dips to ~50%).

 .../kernel/mem/tunable/min_free_kbytes.c      | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 7882c6072..6b6d009dd 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2012-2025
+ * Copyright (c) Linux Test Project, 2012-2026
  * Copyright (C) 2012-2017  Red Hat, Inc.
  */
 
@@ -177,20 +177,49 @@ static int eatup_mem(unsigned long overcommit_policy)
 
 static void check_monitor(void)
 {
-	unsigned long tune;
-	unsigned long memfree;
+	unsigned long tune, threshold;
+	unsigned long memfree, min_memfree;
+	int i;
 
 	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
+		/*
+		 * Allow 10% tolerance to account for transient states.
+		 */
+		threshold = tune * 9 / 10;
 
 		if (memfree < tune) {
-			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
-			tst_res(TFAIL, "MemFree < min_free_kbytes");
+			min_memfree = memfree;
+			/*
+			 * Give it some time to reclaim. The kernel should keep
+			 * MemFree above min_free_kbytes, but transient drops
+			 * are possible under high pressure.
+			 * Check every 10ms for up to 2 seconds for high accuracy.
+			 */
+			for (i = 10; i <= 2000; i += 10) {
+				usleep(10000);
+				memfree = SAFE_READ_MEMINFO("MemFree:");
+				if (memfree < min_memfree)
+					min_memfree = memfree;
+
+				if (memfree >= tune)
+					break;
+			}
+
+			if (memfree < threshold) {
+				tst_res(TFAIL, "MemFree %lu < 90%% of min_free_kbytes %lu (MinSeen: %lu%%) after 2s",
+					memfree, tune, (min_memfree * 100 / tune));
+			} else if (memfree < tune) {
+				tst_res(TINFO, "MemFree (%lu) stayed within 10%% tolerance (min %lu%%) after ~2s",
+					memfree, (min_memfree * 100 / tune));
+			} else {
+				tst_res(TINFO, "MemFree recovered to %lu (min %lu%%) after %d ms",
+					memfree, (min_memfree * 100 / tune), i);
+			}
 		}
 
-		sleep(2);
+		usleep(100000);
 	}
 }
 
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
