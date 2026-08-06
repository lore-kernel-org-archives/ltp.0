Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA24C5AC67
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786058114; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=sroh/E9GUJWGpWUpqdRQAlcLztYdYBmwvJSl/dfdMj0=;
 b=JocB7LgPAkGCP3NhaJI2U8DZ/C8MZ7AZwssIcaM5Qh6/GmZi+IXGNFRy/OU7faOG9seIa
 ZWE9+jnQkuV5nqkx3W1XL1pMXBtWmgnHPAxX2kbx8+0r8yzFt32ZdV2Li81r8YXEuTIzUHX
 JJpjAF9qYXla908G8zaqhUC40qlOrrI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDC003E7154
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 01:15:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5BDC3E2D7C
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 01:14:50 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F2F16200233
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 01:14:49 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47fe2d179e2so1784514f8f.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 16:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786058089; x=1786662889; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pY0lX6Q2iQ2uSqcn04x8cftHBw3IhtbxXWzDiKcCaTQ=;
 b=R6XH0Xi/2h/nDFv1rPkJfSZGqc/A2QRQ0EBDx0MQaBnQoyQ3CnDcubabeu2EjzsiDP
 UKKYABgKV6N8x1CmHmuL6zsYDqQYJzJ7UtnhO3Yn/W1Dfdg5Gb6bRrljXkPvAjJCTLPq
 f/I5LpHyEZUvFZYpGvO/pC98sMr2Zg4FVuOEWilgveoT1LsbrxfzJ6WEI0g7gR7eXFja
 EHGuGdThXQK4lmKZKpnuZ3p9laabGTJyT8v6i5OfJREP1IzkM/1Zxc8JCnCmshdnrO/U
 kokz8CUxtlS8eVsPv/C8c2YONJr4KNJvD50tR5LU3wHRdZkvS0b0Fy2tj4QSSBiuMYFW
 tQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058089; x=1786662889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pY0lX6Q2iQ2uSqcn04x8cftHBw3IhtbxXWzDiKcCaTQ=;
 b=oks+4B58SsHxIS6GjhA5awmjq+aOMkvyJw2Z004mBAl1I9b+C7RcTh5z9dyCAup44a
 Dxcw4ALQl+6uzf6OU0dcRQpxcksMUXdkCouw1pE1h3rgDD8FsgrUqpyPQRxcu8JKxUl9
 pHybzV29/W9CEnrX4d94+Fh/6X47jDZciVwofJ/K3d4q87Gs14NcqiU0+JAr/aEdfwm3
 3LmuVEp9jKBPjK2nhj49Stgw3q3Ld9W7Eu/qhrkIGv8u8PZ4FNF+zbFvmvr6w+mqHMjN
 QdmtyBFNkBBFimDdjM8ngU7n1hhWFSvEAcPRY3uZ3svpzzpGHxw9Bemup/rVo1mbxw3E
 NHLQ==
X-Gm-Message-State: AOJu0Yx4LSCDVZBnrfFxej7oslbukpwXYPuFRNDgfLKfKZQUrAKWe0Md
 JnZg/d1rnotnUyySBdnAQnXzfZ/2Tt+V+9EYdsZ8h7vUnQDjYfPHUW/pU3nNQXKEEJ8p0yEV6b3
 daRs=
X-Gm-Gg: AR+sD12+FxtbY/ZkubLl/laxw0Bf/5EuIbEMwVVWi9mJAKlDSQJBomffEqPtXs4/+Qo
 iEk7jWF0+9L6rkm3L8Hdl5ziJotWOStYMNntDl1dkB+UcoXfRMrSEqv7H1lF/96qe93gdZ9d9n/
 85zvkjmLttBRsHX2iOB1Ses2tP3gMYbGFOSFUetJ3ww8gRFvVKVLDf1xRqp44bv3TdBYAeRmxBa
 U9z/fp10glakIzhURJV7tBEcBEed0PN7ySYj1Qy+8PTzQMMbZNxeeWAdH4APNy2sEvZnMv8gI58
 uPYxZ5YtKysL7O/ulZgZ7DTw2J+b3JMV6HixJ94ClRmkIxJmGK3y2KjoqfbYkTenksdWTKpj/bb
 0zWgmPiX94n5Gb4XIzVfyZ5+zCasMG/HGfrJt7o1A7fMa1nzj55G4HrCRIUKlovuDKybb4Ib+KV
 fMLQqjSCuHYY6ZQKeSGKb9HfTaiOksjH3yBL44HAbQ8AO5I1J1
X-Received: by 2002:a05:6000:1a88:b0:47d:ea8a:d224 with SMTP id
 ffacd0b85a97d-47fec62e439mr28564473f8f.23.1786058089345; 
 Thu, 06 Aug 2026 16:14:49 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-47ff7b18091sm9422877f8f.21.2026.08.06.16.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:14:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  6 Aug 2026 23:13:17 +0000
Message-ID: <20260806231423.17724-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729053803.9823-1-wegao@suse.com>
References: <20260729053803.9823-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6] min_free_kbytes: Handle transient memory drops in
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
v5->v6:
- Simplified the loop checking MemFree based on Petr's feedback

 .../kernel/mem/tunable/min_free_kbytes.c      | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 4f991025a..e125601e9 100644
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
+			for (i = 0; i < 200; i++) {
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
+					memfree, (min_memfree * 100 / tune), (i + 1) * 10);
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
