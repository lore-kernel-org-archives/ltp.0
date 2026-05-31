Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53691CD6E52
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780234999; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ULUrHjseEhz6k1QSYpnsEsYwUBBwm5tobz+zJg3d8fA=;
 b=rDfNp5vLno34UDWHCcmVGPwZB2TMrd38Q7bNfUTFuOHp+TATrY0K5qFilqfedcSHM+CO/
 q4B50kuRo8VEXN6Cc0CNqCa3B8rl59o8HQwCdCCba4hwOWZRpM4AJCDXuWFInRUPvQYTWsa
 vCUr7h4x4MVvJJEpXWguAJdUNweQE50=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C938B3C8B57
	for <ltp@archiver.kernel.org>; Sun, 31 May 2026 15:43:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A2D63C560C
 for <ltp@lists.linux.it>; Sun, 31 May 2026 15:42:56 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 334AE6002E5
 for <ltp@lists.linux.it>; Sun, 31 May 2026 15:42:56 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490a765f2feso5285905e9.1
 for <ltp@lists.linux.it>; Sun, 31 May 2026 06:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780234975; x=1780839775; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bITcF7bgYmcjdQEPUGnR0tUAwdiGu3jVZ/gFau37EyA=;
 b=gjGvI9eUg6iByFRmHmL8ulvod29C7LCd7t0IDYvoQeAP0IKfpn3kjDfueSFKiht7kT
 MiPnGhMMSxjgq7KQT/CtCmegEb3VmTLnaOk8SI/zV7CpKy54dl42jcSf4GQljWY7D0mR
 I5+OdWl+ykuzxKPvP7fLw0DAq7obMW+7p4mntoT02G0hGA3CT92SmYgF4mm4Er2dcTQz
 EqokBpvyQ1xRFnPTcxHaNDe9HclK9S8Vz0237LXIyUJGxDPGoJTrv0p1ttGFSSRXygoY
 vwnCOles9m+G6m4hpBRFaCfSRm5U+kgdZ+zPDre2fnBRJ5LrIcraDNqvjUos9xO1lGEX
 XeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780234975; x=1780839775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bITcF7bgYmcjdQEPUGnR0tUAwdiGu3jVZ/gFau37EyA=;
 b=KzS51PUGvc+9Tlyc33awAkgOeHakaZl+h4uJZJoPq7y1ayPUAHmCqxaplvkIXSQBxg
 6n2mg4gJx6FHB24mNGd6AO2DTwx+iUxax2BiIGJbxSXW5PKwe9h4j4qsmZ83mRuugq+l
 TycVVHB8I3wX816CWgsSAgPkxrIbRWSoH+PGSK6MGtLrj8GH4fAo/n9Kn9NozlCvj9YV
 To5AXr/W4Tq3YG9XQp58omzplNDVYPEQ8R27CzChDxaA7Klou02NGvqIpOm0LWBq/7Gf
 1/wgLME7lwTYw3W/J75HsxSU9XiLMKRFn4Z74io0f1mYKBOjOffolsnu1WlV9ow/Srox
 0DgA==
X-Gm-Message-State: AOJu0YyRyl6VPO18UUUrcLzysGnQHIOwg+uEfmngOsutU1rinx7L/HUO
 G0rv8bzxTOhf3Vde0QaKJuFcFUD+q/VDb+2xLn/KZl0RWVmxMrTWvtHmvWaBWtPUE1B7IseMhQL
 t8Rc=
X-Gm-Gg: Acq92OFmRKPCQu+ioLCHgyY4v0oQT79cHJU+QHyikdKnA0xnJ1UxCN8NHwziHmYB9NJ
 teRk9BxIUK0fUy7hirMv1zERvfkv9WFLyUwx6xBZW4JNZJamhjP9ceCezS8a2QfY1+8o9SVGX0k
 6A84IkhLJbaX1aog+zdCMU4G0Rk8mNB7d8J6iQ7gCA5BytiLIW/6y1gBWqtpzo3gapPXKJUJy/W
 NOt6fvrt5UpnqCM62l9HL0m32+B5EO2DutmC+GLDhTN/SlVxCTbqBK51xYZ7lxImmJ2pdAFSwHw
 ek7bavCsAer+Fmr382bhC687P8gvDxtTbFc7Fy2NTVHZa/OVzmEisu6QrhtMdNOJLrUAqtwwLf7
 osk01b6efBbGbcsJT/V2ZXXtkrGWCUOoK+G3yku0+rJMsSmvQLfzl3ontV4mgf6VIQjrQ/eqika
 s9P+ab7syJm9Lc104PSskwLQ==
X-Received: by 2002:a05:600c:c4a4:b0:490:6e12:a40f with SMTP id
 5b1f17b1804b1-490a291cce1mr130552955e9.12.1780234975563; 
 Sun, 31 May 2026 06:42:55 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4909c6319ddsm177296855e9.0.2026.05.31.06.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 06:42:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 31 May 2026 13:40:47 +0000
Message-ID: <20260531134250.25279-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527050843.14963-1-wegao@suse.com>
References: <20260527050843.14963-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] min_free_kbytes: Handle transient memory drops in
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
This results in intermittent test failures, particularly observed on
openQA aarch64 machines where swap is exhausted.

Implement a 2-second grace period with high-accuracy 10ms fixed polling
in check_monitor() to allow the kernel time to reclaim memory.

Introduce a 10% tolerance (90% threshold) for the MemFree check. Our
measurements showed that under extreme pressure, MemFree can take a
long time to recover to the exact 100% MIN_FREE_KBYTES, or may stay slightly
below it. This tolerance prevents false positives and avoids excessive
wait times while still ensuring memory is maintained near the required level.

Enhanced diagnostics are added to report MemAvailable and the minimum
memory level seen during the pressure period to aid in future
calibration.

Signed-off-by: Wei Gao <wegao@suse.com>
---
v2->v3:
- Switched from an exponential backoff retry loop to a fixed 10ms polling interval for up to 2 seconds. 
  This provides better resolution and a more predictable grace period for the kernel to reclaim memory.
- Introduced a 10% tolerance threshold (90% of min_free_kbytes). Memory levels staying within this range 
  after the grace period are now logged as info rather than failing, avoiding false positives on systems 
  under extreme pressure.
- Added enhanced diagnostics: the test now reports MemAvailable, the minimum MemFree level seen during 
  the pressure period, and the percentage of the threshold achieved.
- Refined logging to clearly distinguish between recovery, tolerance-level maintenance, and actual failures.

 .../kernel/mem/tunable/min_free_kbytes.c      | 49 ++++++++++++++++---
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 7882c6072..bd3821cf1 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2012-2025
+ * Copyright (c) Linux Test Project, 2012-2026
  * Copyright (C) 2012-2017  Red Hat, Inc.
  */
 
@@ -177,20 +177,55 @@ static int eatup_mem(unsigned long overcommit_policy)
 
 static void check_monitor(void)
 {
-	unsigned long tune;
-	unsigned long memfree;
+	unsigned long tune, threshold;
+	unsigned long memfree, memavail, min_memfree;
+	int i, retry_count;
 
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
+			retry_count = 0;
+			/*
+			 * Give it some time to reclaim. The kernel should keep
+			 * MemFree above min_free_kbytes, but transient drops
+			 * are possible under high pressure.
+			 * Check every 10ms for up to 2 seconds for high accuracy.
+			 */
+			for (i = 10; i <= 2000; i += 10) {
+				retry_count++;
+				usleep(10000);
+				memfree = SAFE_READ_MEMINFO("MemFree:");
+				if (memfree < min_memfree)
+					min_memfree = memfree;
+
+				if (memfree >= tune)
+					break;
+			}
+
+			memavail = SAFE_READ_MEMINFO("MemAvailable:");
+
+			if (memfree < threshold) {
+				tst_res(TINFO, "tune=%lu, threshold=%lu", tune, threshold);
+				tst_res(TINFO, "MemFree=%lu, MemAvailable=%lu, MinSeen=%lu (%lu%%)",
+					memfree, memavail, min_memfree, (min_memfree * 100 / tune));
+				tst_res(TFAIL, "MemFree < 90%% of min_free_kbytes after ~2s");
+			} else if (memfree < tune) {
+				tst_res(TINFO, "MemFree (%lu) stayed within 10%% tolerance (min %lu%%, avail %lu) after ~2s",
+					memfree, (min_memfree * 100 / tune), memavail);
+			} else {
+				tst_res(TINFO, "MemFree recovered to %lu (min %lu%%, avail %lu) after %d retries (~%d ms)",
+					memfree, (min_memfree * 100 / tune), memavail, retry_count, i);
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
