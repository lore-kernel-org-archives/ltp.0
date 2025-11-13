Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A34CCD98CE
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 18:42:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2AA3CF803
	for <ltp@archiver.kernel.org>; Thu, 13 Nov 2025 19:42:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 882FD3CF7C2
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:42:20 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28CF264784F
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 19:42:20 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477775d3728so11838145e9.2
 for <ltp@lists.linux.it>; Thu, 13 Nov 2025 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763059339; x=1763664139; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ukvk2NPRx8F83SHRRKT1OLYei+SHA/U3nL/4gYO9ADI=;
 b=GA/OZC1MqEKPyoaVkHPxN3YxJiEpoiMhdSxFFaqWgRl3f8/fulNDBbK9uEcevNeIGj
 OtiBNApgFM8g/Kfz+J/qKvaUDcxq6X9BKshIzyGX/us5wQcbOaWAmglsLfuUNIFH9Z6Q
 u7FFVqWLKfTSoJjrA15C9BiNiRMtVTeKjsvBjTz+Npl1kVAx913RS1z5jpA3/6hISiA5
 XAhfhjoRc7oHg2x40FvpZc0GzRFQCwM17DlWUlbdt6v/efO4D+PQUReSlIWv29NRXIwr
 LqpOi7lAd2p1ViyKr696PB99FGahPNyDtimWYgTQMU8qDo99nJVPmhNH3EPtkdpaMjxa
 6Drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763059339; x=1763664139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ukvk2NPRx8F83SHRRKT1OLYei+SHA/U3nL/4gYO9ADI=;
 b=S3S3YKKNuv/71TPnW/F2wbDP6CaAppDUY9HCg6aTbksaiREXgK4AfIPA6kWW+YcLHC
 /6qbwzaRZROLxHhXj3VlRiM3JbAEH4c+bS68704xqgcQCGvf1pDwq193PXK/L9TxEbSy
 nA8uOCj3DY5/uJEp19uC3HpaRi5BosBP1B+Jji2oCE9hDW4FWZYE290EaWIPz9zWzywr
 Tpdl3o+Nds0q/aGpBoL8FaGb48gAtaclX5OsoBo5DEMw4L9IYm3meSZB49bsayH9Aefc
 8Wkp0zWFIDDi8GFO0zOj/qyoBmMjGE+jX/hYZ0ef/3DWjK5JPLykoBvqKoOAVDTzuMYz
 7KGw==
X-Gm-Message-State: AOJu0YwxKePvNVKxqj+cqNtbHeFPnLRByMxNiRg65pH3uT+BV+1/CyCT
 ZKUbk3w0G+pD8cVCQC3JPDy/hn2Okzqdfh5UmWA1xsUEbUKCRlvg7lBrjLmFfw==
X-Gm-Gg: ASbGncuz5Iy6gNGrK3GjIo0ZUK/HDfvQj5r3Cjco6JNrwk2bZq8ku94KIXymH85KgOu
 r/HwZ3UnTFudcqZ3lxGp7klQNYigfickjen0Qglu/fKfgOP3YnYaagldEPkVKfscoQcFVY68nYn
 312xyMiJslg7qJNQWkAlZIEagyZbXY5/ih+iWS8blQrTPkFn2ubYUcofEaRHLEGw3jOf7FQyztn
 6ctwsWcX6CknEUgcJjohed0E9LKyMQKtr8Yuaj+77aEOJVI7RtgVeEv2HAKq3h7Wz+bSahG64oV
 UQeTsmy1Envl9ci3YOK7XVhemdh5N4fkjYC08cyPo8YxPtMEgZUhoVCUK/eAYqxWOVW7PO43L/U
 XC5Ga9NqseNtj2doaQ5iT34It9yivUm5RcaxVpLDeWNyR4cdM8IgWSRXZA76Q4Gq9n+zgstUV/I
 9RXLxD3oPsiNMoZ/KtYGB4b6mCvkFJ4tkHa7IwMZo7OOHCtChpiQ==
X-Google-Smtp-Source: AGHT+IFCA7/qUrj0BeW0FKoTWMk1tNXNL0cU2Oi9q7m0sml9DcMCFiVp+gs+qkiLFTosQFWxk4qIPA==
X-Received: by 2002:a05:600c:4503:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-4778feb23dfmr4869785e9.36.1763059339256; 
 Thu, 13 Nov 2025 10:42:19 -0800 (PST)
Received: from localhost.suse.cz (apn-78-30-81-95.dynamic.gprs.plus.pl.
 [78.30.81.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae16sm5474561f8f.3.2025.11.13.10.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 10:42:18 -0800 (PST)
From: Sebastian Chlad <sebastianchlad@gmail.com>
X-Google-Original-From: Sebastian Chlad <sebastian.chlad@suse.com>
To: ltp@lists.linux.it
Date: Thu, 13 Nov 2025 19:42:16 +0100
Message-ID: <20251113184216.7768-1-sebastian.chlad@suse.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] controllers: Remove obsolete testplan.txt
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
 testcases/kernel/controllers/README       |  5 -----
 testcases/kernel/controllers/testplan.txt | 15 ---------------
 2 files changed, 20 deletions(-)
 delete mode 100644 testcases/kernel/controllers/testplan.txt

diff --git a/testcases/kernel/controllers/README b/testcases/kernel/controllers/README
index b1b00eb6a..2c9650773 100644
--- a/testcases/kernel/controllers/README
+++ b/testcases/kernel/controllers/README
@@ -1,5 +1,4 @@
 The complete dir tree is for testcases for resource management testing of linux kernel.
-For the test plan please refer to the file testplan.txt
 
 --------------
 ***WARNING:***
@@ -14,10 +13,6 @@ similar work as above.
 
 FILES DESCRIPTION:
 
-testplan.txt
-------------
-A brief description of the plan for resource management testing.
-
 test_controllers.sh
 -------------------
 This is the main script file that starts the test. It first checks if the
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
