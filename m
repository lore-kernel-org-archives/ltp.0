Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496E3C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 05:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785303507; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=l840wCPY01Gqz2yBAL7oPn5ga3drw+yKcFSS6MaIzh8=;
 b=roYwZdbWu7Rq9lh9/0DE1bVmLNWVju09w1ljwElBIWqUfCJFMfpdUuEIRt32cprRii1+/
 XHYMumTSv22T/xDjrRft5X05Mnxd3V+EmsfwLIfEml0C1PqXS17qiZ8G6v/SrofK7kABnYU
 oz30JCVQWpGlykI7VT3d990hnIHpX8o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 609BD3E4A7C
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 07:38:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00C523E171C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:38:06 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6DF9C2000A6
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 07:38:06 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f84023916so519637f8f.3
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 22:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785303486; x=1785908286; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtAK8EEyevee/zaKvHM+8HzhLgD8rzRrBB3gAvsd3zA=;
 b=KfSfCQ/9BwNvtcHNAQGu2smGJQ00cZMi/7Bu2dfCwv8MNN0TjzCcBYfUwpGHcL9n9u
 P6uZenfgvC0XWnrSmyOzAkQmEPzpUAbPDmD4WaKcjzr+vM5MqUy/nmAQoVdnU56lQSS2
 esM6sBOYzO90/Cz84f0TNHVtsulpJVYm2sDyu0f4C5lnlDQgpMvpjsf4GnFjOGQ3FNj6
 1GFe7lw/MkKfsdLSE+gUaZ5yELkR5fyBdy3+prg6FGszIPuzHOcVYY4zXFfcfLXSt2H9
 msp3KgHzMegqiLGoFKWqYB4LowsH55vQHIC2yzvnTfVIwJV4JDDN0vuynnPREei1kq1e
 hl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785303486; x=1785908286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtAK8EEyevee/zaKvHM+8HzhLgD8rzRrBB3gAvsd3zA=;
 b=eO2p/glmOOhrtil6Dfd3ew4qJ/rCm1gIUG8YWmo58Tkbzw2u+S09mQAN5boTR+wCzF
 E3T3eLtInZmmI9vjUCSSRVnwEYwdIs5GMD89saIDB9U88oKCrEUv2Ka9vHiSaal4zFJX
 FX4L3ZIfmWnBh7tkAm6EEBJ+Sd+NfST4bvX/d5mHjC4jJ7tTzXyBI/8QzBWds+iBf8B+
 stnJcasFRheqOUuoF9AmrkRSa7WkMA3T8xLRfToIF7ZNbntbAgmHXWZJiXrPI35koZla
 jRBhmGKDHZcJcKqUsl2zdFrFSFT6cyHJM83HzfJkFh4bUtKd7MRTdzI57jl/JTcOesd2
 EfgQ==
X-Gm-Message-State: AOJu0YwME0tKL94WhaNmvutLul1XsznAAqYdV3tUCfBKZ2ZR42kIdxIU
 MwY295rjRtHWclq85lsZwpFKGWX7idZhh73iQkTtUolLgFNYmdCrh3sUj1eMPLW2Jz4Uljx7/gv
 36Cs=
X-Gm-Gg: AR+sD10r3L6I5cXSUh1OTnXoCoeZFghCxsMr3ioqaM1pNUN2rXO2tX2NAxNSvuaqHfw
 QGIlGAVWbx/zAqQVzxqy98ux4I0IU4fR2FwBxLpKdA4IaflOxNOwPpV3XBP7pm1Ccp4UWAoTTba
 0oS11746x8KbdWDTl78nE3t6CEAC96kUCjJravnrlhgPh5d1a9Ho6P9hHIOGf4pJ9iFGFR2yMyG
 9xFSxpNxNTdhIET5dRTDHUVn5VPFd8/r3iiIxRLq0xDY1ZVv4bruzDW/n5xuZpm1O+22imQex87
 XJNY/aqfMpDVq7n64YSixFnpjBG6TCnGCbsfSt03Tlr9GhpnlQArC2GRTIf/sthNQYY5HnX5n9/
 SNS9ZL1D2IelMXNlsabov+3y/jqCOoQefOuJFl5KSTp7q1lh5tMeMRZDQNHRAX4zV82H2LlRHdZ
 3M0HFlWlRDYe4gT2KbnG7lKxrdzMODntnfTv5mSUYnwAsGZLei
X-Received: by 2002:a5d:64e9:0:b0:47d:eee8:ec40 with SMTP id
 ffacd0b85a97d-47fb1f103f9mr5848046f8f.38.1785303485860; 
 Tue, 28 Jul 2026 22:38:05 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47fb6aa3a94sm4701594f8f.8.2026.07.28.22.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 22:38:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 05:37:51 +0000
Message-ID: <20260729053803.9823-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602010137.27226-1-wegao@suse.com>
References: <20260602010137.27226-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5] min_free_kbytes: Handle transient memory drops in
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

Introduce a 10% tolerance (90% threshold) for the MemFree check.
Measurements under extreme pressure show MemFree can dip as low as
~50% to ~70% of the target. While it typically recovers above 90%
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
v4->v5:
- Formatted output messages and commit messages
- Rebase 

 .../kernel/mem/tunable/min_free_kbytes.c      | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 4f991025a..2b4c69b95 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2012-2025
+ * Copyright (c) Linux Test Project, 2012-2026
  * Copyright (C) 2012-2017  Red Hat, Inc.
  */
 
@@ -169,21 +169,50 @@ static int eatup_mem(unsigned long overcommit_policy)
 static void check_monitor(void)
 {
 	int violated = 0;
-	unsigned long tune;
-	unsigned long memfree;
+	unsigned long tune, threshold;
+	unsigned long memfree, min_memfree;
+	int i;
 
 	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = TST_SYS_CONF_LONG_GET(PATH_VM_MIN_FREE_KBYTES);
+		/*
+		 * Allow 10% tolerance to account for transient states.
+		 */
+		threshold = tune * 9 / 10;
 
 		if (memfree < tune) {
-			tst_res(TINFO, "MemFree is %lu kB, "
-				"min_free_kbytes is %lu kB", memfree, tune);
-			tst_res(TFAIL, "MemFree < min_free_kbytes");
-			violated = 1;
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
+				tst_res(TFAIL, "MemFree %lu kB < 90%% of min_free_kbytes %lu kB (MinSeen: %lu%%) after 2s",
+					memfree, tune, (min_memfree * 100 / tune));
+				violated = 1;
+			} else if (memfree < tune) {
+				tst_res(TINFO, "MemFree (%lu kB) stayed within 10%% tolerance (min %lu%%) after ~2s",
+					memfree, (min_memfree * 100 / tune));
+			} else {
+				tst_res(TINFO, "MemFree recovered to %lu kB (min %lu%%) after %d ms",
+					memfree, (min_memfree * 100 / tune), i);
+			}
 		}
 
-		sleep(2);
+		usleep(100000);
 	}
 
 	if (!violated)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
