Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78966CD8CBD
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 18:36:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF1113CF810
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 19:36:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06DE33CF7C2
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:36:20 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71B046008C7
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:36:20 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so9203155e9.0
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 10:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763058980; x=1763663780; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=opCuYTG+TdNAt2qdTwtqdKwBllORdPq9RnK+oDl4GGw=;
 b=GW20rXMu60vUqsmWjQdNeNYovFU41yccyx1GPuOlqHl5p7uCQL4JRw3D+hd0CXjrwx
 46l/EWhDB9asIOigvtfv53yWyIXPWpMg/BqXjAqnuFzrIOAHL7NuESfS0sXMV9SDt9xQ
 ka89jVCJ+KD2bDUtYBS69PeHUBCH2AQuJ6F3oQGBjf7aLzGGHBtNJ/sysiVpO4TKFj08
 2iELLysnQQ2xEgK4Bbyqz57XcFtuVRfU3esNpBd8DzdMQmLGd54OFGVfLrhllnMXlszY
 CObBHjrgGtyVoOUQ62/F12K/lCW/wWxa2Bix+QJFF0GpOipWPzuBhKnaK7FZHRPfS2Vf
 cQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763058980; x=1763663780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opCuYTG+TdNAt2qdTwtqdKwBllORdPq9RnK+oDl4GGw=;
 b=c/xPJEE2RJUoSV5CX4ziMGBmIwPj8auPHKlHzokXWmzwUlrbBYSPrTtaE6heTMY5l+
 c/UYW46Xe0+v5aEDJYOPu1Q+jpoUN0nOfF660B2oF4u4QDktlohnhEihpkDB0maRI6rY
 4QBhlyZollasKl4G/WgagmUOkXomitOuxnRgNNfhL7/KXemCZ4eqVGDiHRxY2+Yfetkh
 5LgKz/Octrh9InpTRIGHHrGP+IPYg2yvkWnhMFXwsb75VK4I0LpxXlGFj+f0d6WKHLhp
 CSWwzDjkZBlXIuOIM7AzDrr5trdw0H+BM7jJCs/pPO2EgVp6iinLhxA7/mtj3yCfJOPp
 EsUw==
X-Gm-Message-State: AOJu0Yx3nnKGzc36QFiCy0/vSom4xFmnZQKfR8fHDN3nsfjAcEEWGVK9
 VepSmR8DvfXac24GtlCU1KgcgbULSYBjVC5Vf177ZQrHaKKtSTWpw7Zm2ZN6Fw==
X-Gm-Gg: ASbGncvty4uNWL5FToIY0BiB0MW/wvNcyAfdQWedKm/6mkBj5IpTcXVd6PWFwgdq7BA
 hIVH/6zlDMRAYWz+wwP9XICBg36UX01YfLwMtOqrXR08KWvteowIOghneliMPxWLsTY/TGDXpdw
 4QrQ7JyapH7L4HuwC0bAzMXEXO4GqAhJiVDKZZqTBVrRCXYUPCuaalagmXOPqmZ2g0ZB8jXHFVF
 1N8cVliAniI+j74fhOSnTWXDwdNcFgbHrBMylqLpMj80Nmd1goD/WBFJUT+X8IjMWaIetUHrC76
 P1w4V9eOxX2nm1v3hhR1fzZuP/DC4wfW51u/gMba2kfa0MVfqadCAvdzi/rJ9j7gzbDe+PvFw4X
 8jSiX8CuZETMLsygXkkhYO44PzkSQA19J6077JSx/jV5nWMgKTAw0HV60VN+iQqus5SkwFu7J3s
 xTDMo4DCwYc0/iSf4vdfvRChfvhnEb0FCfO9E63cvFb85F9T4M7A==
X-Google-Smtp-Source: AGHT+IH26iVl5WayCWLp8VBWH7KgkTBesAvn66s7v/OsFtFuh65WDiwxFAvRTknLOMWG7bHfgB5QpQ==
X-Received: by 2002:a05:600c:1d19:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-4778fe50bb3mr4957715e9.4.1763058979581; 
 Thu, 13 Nov 2025 10:36:19 -0800 (PST)
Received: from localhost.suse.cz (apn-78-30-81-95.dynamic.gprs.plus.pl.
 [78.30.81.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778f247821sm22307575e9.5.2025.11.13.10.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 10:36:19 -0800 (PST)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 19:36:16 +0100
Message-ID: <20251113183616.3679-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers: Remove obsolete testplan.txt
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The testplan.txt file contains outdated information and is unlikely to be
maintained going forward. The tests are already self-contained and clearly
organized by controller type.

Removing this file avoids confusion and reduces maintenance overhead.

Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
---
 testcases/kernel/controllers/testplan.txt | 15 ---------------
 1 file changed, 15 deletions(-)
 delete mode 100644 testcases/kernel/controllers/testplan.txt

diff --git a/testcases/kernel/controllers/testplan.txt b/testcases/kernel/controllers/testplan.txt
deleted file mode 100644
index 7fbca2a05..000000000
--- a/testcases/kernel/controllers/testplan.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-THE RESOURCE MANAGEMENT (CONTROLLERS) TEST PLAN
-
-This directory "controllers" is created to include all test cases related to
-the resource controllers in linux. The testplan at present includes testing
-of cpu controller, memory controller and cpuset controller.
-There are test cases to test cpu, memory and cpuset controller. In future new
-testcases will be included to test these controllers further.
-Each new controller will have it's own directory to contain all its test
-cases.
-A brief description of all the testcases is given in the corresponding
-controllers directory.
-
-For more information on resource controllers please refer to
-cgroups/cgroups.txt, cgroups/memory.txt and cgroups/cpusets.txt in kernel
-source code documentation.
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
