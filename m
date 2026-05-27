Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB91CD5BDE
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 05:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779858552; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2Z3JNLnIckscDlUWUgAUGJeqONL2QFZOK43jB0J1Uks=;
 b=R4KB475yB2Bhx0+iXOeSOEgLYSH31nRuV7Bn3rXGzcZLR2zbvuRQUk/4IDY5WOdSrbf+c
 bAZGYFm/LPBIhRLTKTtvvmMlImunxvan1rDsuwhocJVnV20simd+2Lzp0wRG6UGfmHxNV0M
 nOpLA2r3Aybe2wRtVf3M/VffQcNx4lA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACEFF3C71DC
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:09:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1CC33C2C23
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:08:48 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48C196009F9
 for <ltp@lists.linux.it>; Wed, 27 May 2026 07:08:48 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so73814865e9.0
 for <ltp@lists.linux.it>; Tue, 26 May 2026 22:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779858528; x=1780463328; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EPM0Vl97uIrdBOTreDB2GoWttO7z/HqRs+khxC6D3/E=;
 b=Y9k58pu8S5d0+0uAcNTDeorLMz8CweLkF6OlyxZIOsVAFpDcFzDY/oafiHo5JsVJIa
 /gssFXO/M7FZKC7eIQU7lalL8i44upVBE3SV0ajsOYapU04gAHC1sTt4klCoZ2Ybvdy+
 gdSM9eiYk/eEOyRAK9+5mmT0g7CGhAcIgIRLmXwX0p1gei20WHFsIzj0Xxkstn9VrpCB
 CiTU6A9BIMeBppdF2jqeLCRmFZY/uGprCSZl/fyKXiVja01wnATJVE7sZ9aG8hQggLLd
 7QLrRMCAR9UVTzcWWsWosVUSxbDfIM86KFkTXUEVWdZyeQukBOoPnjkCogxnnBfGpoiU
 Tuxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779858528; x=1780463328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPM0Vl97uIrdBOTreDB2GoWttO7z/HqRs+khxC6D3/E=;
 b=sb9C0vBW+HddRblI7aC4ej8FbpIgxU8VMp7tZhCslNwbPZXkayNyLSsCyqWDgo3+jh
 c9Koki7KE+0jkdQ1KGUhyEIxLoMLTJXqvue1/ic8YqqTAe1HRReLx+aZz2v0SBiEgXyi
 7FvkYyfsZP98H6CHWgZfIevNxerjSqCfV+b4ii/N6M/ddzWCbGuXZzGCc35NiDI08bkI
 Zg++j0nbHDhn//skGTbB8Bnkn1ZOLLd0pRvk8dq4dcV0vdi8KWKeALDBU1RQAc33/Z1X
 7sZRrwk0IEZYX9eciLL/2zRN9CbThFh9pqytax67YxZvFrsn+xQ63mc2nkIjPomR7EnM
 k4NQ==
X-Gm-Message-State: AOJu0Yyi3RdDbWNSfLukC0GUnXks4ldk+z2ZLSaRZHp6ph8JDmIePcgA
 49TL3YRL3tklkV4I/USc21Bv0ricCtC8DutArFUXQlqXDbIfLGg6SVQS5lkEt/iqMVwtABlc7Uc
 Q07iVWQ==
X-Gm-Gg: Acq92OGELAFcwlEFaVMvs9prpnNiw/A8K4+fK7MVO8YYgG8XLLPR6OGHkfmahWk64BU
 /WPITAepD3JHA2GJzka/iMLEYrqwosMyNo/2xOIpGqLqxkg4crmcHZ78H9bxepWyrHgqdV5gqSl
 8OaRmjuO6kPDd5pKfUpaDlbvMDLw7Z9c5TcntRqM+D6tZTJBBj15TPNKFa35HtPNV609ePSC5op
 UpPqkyYihWFGA61PjLGpq1h7WGaq4uBogXJrdVIohcFRjQhNttC/1hxPWnrsS/a5VTlqC03moNR
 Wn+UnS3GaxUuLvj76VLJjhSpkplBvkgnBzh772gZ9rEn2rHyuVnbp+yZGjc9WWkzHsqIfAaEMo7
 y0qw5MzSTKnu6TVoINTgephkDofluELUdnO7S8FuW2x4OkTF+osRdD98WwM56GY+aI/PEfuHCMA
 bF4v0m27hvmpVk5C663fUmiQ==
X-Received: by 2002:a05:600c:860b:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-4907df7925bmr34577155e9.8.1779858527698; 
 Tue, 26 May 2026 22:08:47 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490454b7d57sm369928055e9.15.2026.05.26.22.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 22:08:47 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 05:08:41 +0000
Message-ID: <20260527050843.14963-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] mem/min_free_kbytes: Add grace period for memory
 reclaim
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
openQA aarch64 machines.

Implement a 1-second grace period with exponential backoff polling
(from 1ms up to 512ms) in check_monitor() to allow the kernel time to
reclaim memory.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Wei Gao <wegao@suse.com>
---
v1->v2:
- Combine TINFO and TFAIL messages in check_monitor() for cleaner output.
- Remove end = 0;

 .../kernel/mem/tunable/min_free_kbytes.c      | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index a62e4ae9d..e0342ef06 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Linux Test Project, 2012-2025
+ * Copyright (c) Linux Test Project, 2012-2026
  * Copyright (C) 2012-2017  Red Hat, Inc.
  */
 
@@ -140,14 +140,13 @@ static void test_tune(unsigned long overcommit_policy)
 		} else {
 			if (WIFEXITED(status)) {
 				if (WEXITSTATUS(status) != 0) {
-					tst_res(TFAIL, "child unexpectedly "
-						 "failed: %d", status);
+					tst_res(TFAIL, "child unexpectedly failed: %d",
+						status);
 				}
 			} else if (!WIFSIGNALED(status) ||
 				   WTERMSIG(status) != SIGKILL) {
-				tst_res(TFAIL,
-					 "child unexpectedly failed: %d",
-					 status);
+				tst_res(TFAIL, "child unexpectedly failed: %d",
+					status);
 			}
 		}
 	}
@@ -183,18 +182,32 @@ static void check_monitor(void)
 {
 	unsigned long tune;
 	unsigned long memfree;
+	int i;
 
 	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
 		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
 
 		if (memfree < tune) {
-			tst_res(TINFO, "MemFree is %lu kB, "
-				 "min_free_kbytes is %lu kB", memfree, tune);
-			tst_res(TFAIL, "MemFree < min_free_kbytes");
+			/*
+			 * Give it some time to reclaim. The kernel should keep
+			 * MemFree above min_free_kbytes, but transient drops
+			 * are possible under high pressure.
+			 */
+			for (i = 1; i < 1024; i *= 2) {
+				usleep(i * 1000);
+				memfree = SAFE_READ_MEMINFO("MemFree:");
+				if (memfree >= tune)
+					break;
+			}
+
+			if (memfree < tune) {
+				tst_res(TFAIL, "MemFree %lu kB < min_free_kbytes %lu kB",
+					memfree, tune);
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
