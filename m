Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B2EC531C7
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784800252; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/7VpsO81+HQeIMoPqHtlDhUKAC2m2VUueb4QySGRgdU=;
 b=O+CARYY/GQkTAH156W1vnGI/AE2ENfLJVbwpwmIW8DQJ6+du2NZx/mP6nMFCZu6Ur/p8J
 flNdnbLYOQreXL2yi+p18LLT7ybsJ334fsQPGJywiLtkPS3VasyLPo6gu6iXjCXKg8X5svO
 q2nCxXSEK/XxovnyeXJHCLNdp+JmcSo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 526F73E2BD7
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:50:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81D4E3E23BD
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 19B361A00886
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 11:49:55 +0200 (CEST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 870C53F66A
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784800195;
 bh=mUs340vMoY1y5wr3uoPTPnyREVwaJthXlvHEEzbNP+I=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HcXAEZj/C8ytHzFfCmxDVzK1vL3QhlX2qChZfLRHOpxCMW6zgm5llRZaqx/aY/TBu
 ZwBvo8GyoG3lDvuagKpExlh8skpYmm0pUuBOnbmb523mkKrambxklCtAmlpYTpDNfL
 o4OT/Cxp62LufjTIP0724ZIjVsam/pF7UeFiH6uiqhIWDiieEIYN9UEdIrj9/4YIRU
 AzkJjFOP6bHsZbVmntrHiLq5pjZUzIkk1u4odKwxv+L30IxOr4aGZPttoz0SUEjefB
 pqcSXZuqL8JlM0zXf0JaTCtCwlVX1QUsCi431LzgJmee5zVpgG10jjqiKl/YpoTjuP
 gF0r9Og+uGh6bHtXHKGdyBFcygykIjAWEyb53NljBnNmMhroPItbHFA/MNnQA3t1Xw
 ebmVQ9QUPfh8E/6tHVJ3NCwXZYusHycGDww3hy8ILiMRTWG2VwOdqDDwybUiu3oA8b
 /Kz+0Se71IOd1PMvzZTc9ZsBQxpkxEkqRRjLX//rycb6GrzaiFAVwJph7VdO5BJlcO
 d0Cn+tWlJDbViT8ZFNHDvFVBitVR9N+CM045GIjYDeM/4o/+AebJbNAj+n/dkRHQzW
 4/Nzs8I//+dBcoaih1Dz7Emv92DDW8z3t5Ow8Ezuaqy8kqQXP9on27G6ncXf0plX+F
 pSNgufEjOs2LcG0eB26jVLEs=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955b84e25eso3397475e9.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 02:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784800195; x=1785404995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mUs340vMoY1y5wr3uoPTPnyREVwaJthXlvHEEzbNP+I=;
 b=c2lcufpWHT2Oln27HFUtXdWY/fXLDnw50RvvdbqGs1E9FXiIvaRKogzWKScpGLHJQ0
 eJdwI4V/j107B8bbhsHbycEPe5aZzmSBXJ/99ghKKUZyuEMNqpLICPc1V1A9KdAU184H
 okhxiHYniLKn44kwA/jndBGZZdy9Rkdu9fxOIoXQx3cg+OUwbO+G5zsD3YVc75rJZAvv
 RnTyJyw1bkR0wEclUghevULppjo+06HT5mbm7l4p3YM311itAZadKwjLrlieS1qsqpZE
 TWRu9AGEJI7mpOPsnC5nL26anwOfmHtmPKho00w/k8iDbI5fbju8Arzem/DqieFWxtd2
 AjGQ==
X-Gm-Message-State: AOJu0YzhM4o0H+zBwO66RddTxAyRNCaTznYNCNJVSFV5GMcAzQz3/nHM
 4BUPuau8veOLVHL39foAwKMMGeUx9UowALzsXMSTluWE6ph4iDdVXAeSUHnHR+GJtK0/XBjQZMt
 6dTTzJhsjH6uec8yncAvMYe5h6Ku2XjwdAwNp7MrZdIXkRHfdYuH4bgNwaz+EBOBK/uweMEz4ET
 G0
X-Gm-Gg: AR+sD11Pz9nyqffj5bKsv9enaJldfgFVE57lWh093vryLYiHxrsfePabD8x2Je0ssrY
 j9grZUYEZs93ZwG8D2yPRMzAy0n3ovxwA9tiJTkH07idi1HlPhCWaibm4xKCLqeBlguB06AL/B6
 ffPmMYZXj5gnEBaFkxXzqU5IHdAyEqG3KnmtvSFp5xq9/ILpxn+RS3lIEVIJVlatF5r1F2Hdqum
 QsDqhHl9jaDOa0KH5IQvlrB/sPqGcPi+/OyEfikfWnnzHkgNJzoxwwSkXTG6Eeb+YMq4rnY0DAm
 FdJWQt7RqcyCkJB9PQ9M0BqZNx+aGvnOZxTsE9deuEu5QTgd51gJWh8UCRrI/2TdE6cIEryruyl
 ThZn9PExuN0jCdze2DJM4h4axMinebbLo8J/4Op7WVynYCUj4l45167fcj4Qc
X-Received: by 2002:a05:600c:190f:b0:495:5172:661f with SMTP id
 5b1f17b1804b1-49573cd7f19mr26848525e9.19.1784800195049; 
 Thu, 23 Jul 2026 02:49:55 -0700 (PDT)
X-Received: by 2002:a05:600c:190f:b0:495:5172:661f with SMTP id
 5b1f17b1804b1-49573cd7f19mr26848175e9.19.1784800194557; 
 Thu, 23 Jul 2026 02:49:54 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm196600555e9.8.2026.07.23.02.49.52
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:49:53 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Jul 2026 11:49:47 +0200
Message-ID: <20260723094947.2639934-3-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723094947.2639934-1-kuba.pawlak@canonical.com>
References: <20260723094947.2639934-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] rtc02: skip (TCONF) on read-only RTCs that
 reject RTC_SET_TIME
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
From: Kuba Pawlak via ltp <ltp@lists.linux.it>
Reply-To: Kuba Pawlak <kuba.pawlak@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some RTC hardware does not allow setting the time from the host. For
example Qualcomm PMIC RTCs (rtc-pm8xxx) that are configured without the
allow-set-time DT property and without an nvmem/UEFI offset return
-ENODEV from RTC_SET_TIME; the counter free-runs from the epoch and is
only usable as an uptime source. On such devices rtc02 currently reports
TFAIL, which is a hardware limitation rather than a kernel defect.

Probe whether the RTC can be set in the setup phase, writing back the
value just read so a writable RTC is left unchanged. When RTC_SET_TIME
fails with ENODEV, skip the whole test with TCONF. Only ENODEV is treated
as "not supported": wider errnos such as EINVAL are used broadly by the
kernel and could mask a genuine failure, so anything else still results
in TBROK.

Doing the check in setup, before tst_rtc_clock_save(), also avoids the
cleanup path (tst_rtc_clock_restore()) issuing RTC_SET_TIME and turning
the run into a TBROK on such devices. If the probe succeeds the test body
runs as before, so no additional handling is needed there.

Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
---
v3: drop the long explanatory comment; add a blank line between the
    RTC_RD_TIME and RTC_SET_TIME probes.

 testcases/kernel/device-drivers/rtc/rtc02.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 34509ab..1b954f3 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -16,6 +16,7 @@
  */
 
 #include <stdio.h>
+#include <errno.h>
 #include "tst_rtctime.h"
 #include "tst_wallclock.h"
 #include "tst_test.h"
@@ -133,10 +134,20 @@ static void set_rtc_test(void)
 static void rtc_setup(void)
 {
 	int exists = access(rtc_dev, F_OK);
+	struct rtc_time probe_tm;
 
 	if (exists < 0)
 		tst_brk(TCONF, "RTC device %s not available", rtc_dev);
 
+	if (tst_rtc_gettime(rtc_dev, &probe_tm))
+		tst_brk(TBROK | TERRNO, "ioctl() RTC_RD_TIME");
+
+	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
+		if (errno == ENODEV)
+			tst_brk(TCONF | TERRNO, "RTC does not support setting the time");
+		tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
+	}
+
 	tst_rtc_clock_save(rtc_dev);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
