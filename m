Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54B9C44512
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784208325; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=W6etQF6tV+Z1m6gXPZq/x+abzY+njaEqFgM0PH9FXi0=;
 b=j4RIimCYWF0hTYi5XeCJIbOHJqoneg6hVjHKTP+Wcnpb1ISRBUG4NvKp7HMIlCyd5CD3X
 DJW/0TcZeyYIfcmxLMNAGXgnIURBwyzjO/gmffCGJBGjeT0yz4nTaQLGC+1bbZ5mMUi4oLx
 CM+7pPB2DBpgHGrcsx9GsSMJW8320IU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014743E5693
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:25:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F61B3E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:25:03 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 575786009B4
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:25:03 +0200 (CEST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A42133F61E
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784208302;
 bh=HoM03vpMsgteKToUdqsQuXtkD2Zlo6/hPpmvoTHlaWI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=kNKEW/Cc+SRHhiOpItisn1t3rP6a5TZ7YkrfGLWIhYqJpGU6P5puiqRoNHYNgk1ea
 elYNqBMTRU96cjhLQX6S2La9wrflg+cxQRTSkZLgQARuIUpIrfcRjdaPmuekFMwy0k
 4VXJzbyCmoOBcwWBl5LZUYGIl5q7l8sIcU5SFQLgkonXWM1gLN4iivMChM7JXU4Vtn
 Q2RIXspaWPbbEt2P2HthcuOA3E4+8AT+2u/hXPekMPE3iA4vAd24dtIRbTBA6R/NgL
 Qm+z799mJ/uiR+Pfy9UT4Jhp3oRpezPUvG4DV0llHTyPkVJBnY+z6EmU65J6QLNDsO
 tD25npAyPlb9rosdgb6bEXHU579eP5fUCbqRZQ4ecd3Lecvrce0Iqmm+a0XctXvT29
 Zk5qUUrnHtvyccOzlw7WUP0ReqqxOyXtt0PI0BK0Trw7tvlumn+mjLwEXtu2kE6/J2
 bmiYsvIsd4WondnginEF5zN2LmgnyWHuxgMXAHUu0MbnlFMZQE/ydPX+Yf1WIK5YGz
 Sy5ZvivH72yGowZDUZ4POnYuibXAxmZ7H6P5cMU5XOCR8s1y4OAvcYMAiagaHtG/XI
 P8F89Yr9b13yGGhj5DX7yA97SfAAzY5/yhxESz4hDYK/dz+987HmiGfB38WnGJXvFr
 zVGoawdbxsPQmAWrJoBA4pDw=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-472a798fc7cso2350384f8f.1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208302; x=1784813102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HoM03vpMsgteKToUdqsQuXtkD2Zlo6/hPpmvoTHlaWI=;
 b=Pt58BFWrVOMxVAloOS3mOutlErGKpDeHnjXejgZEJOO2i5mTfQUNJVE4uUMAmA6cv9
 HzjCtUYW0mQHYErn0a4YgGSc8tg2yPblKRJWj5YJnT0XN381e5nPFfeSNpOdHa8MIpqt
 aEdeL8jbZi47wsENrysh3S2CivwaR6dvAOu1KiFFWEBKywVpKoqg/1un6ueGMeSCjYWZ
 Gl2XU7Atad6F0b1MJvuAgQj9nG2hQoVTwGbslnf+snWyMc5PIPMdDmmsBdLudXj0NQdQ
 KmuDox0dHmbMyLMABZyslq2DLqOkJLXsKTHJosDrxC2sgAg6xpN7NwYMab9Qbd3jz1i9
 H/Sw==
X-Gm-Message-State: AOJu0YyT/cG1PayuhvZa3gr/trq0O7ittODDUTBGUm4cwSK+S8m63z0a
 gO3LmNOxqUToTtLH+8FUkMu6ccJJwjZMtNfQCOxQdfyKSI7kNtvLEJYXTOVLRskwYqP5VBd1Q7D
 YLrZO20Katl4fiZMp2BhfSzLtMVHmafLoT7Z9Zz8ShIKX0QmjG621TCzXRcbmQmWcXe/Z5Z6Krt
 K2
X-Gm-Gg: AfdE7cnezRF4Dq25K+Scy7PuR6wjVPUUGBNs1dz4kApgs+FUMZL0kZ1QzGdMCugPZVB
 lGD/oeizBhWMcBgb4W4Gn6LxUko+O+mDYZzj5U3A+KQUWLNzHJh4oYQMlzqyIc3DUG5v06i/f9A
 W9HXVkpzD0RcDgdyMgTVXfpnuM0RUgxC/Xo/DXm5Fwd2C6yTwlJTvlyjJXpURxfSxYV/yF17avG
 djl8yBnrUe/XWc2e4nMFegnLclodTTwjQszn4mK1Ox/f7VbxhRusU+1op06AunHU+4+PbsPGPGA
 3CleJoi7GJ3IDsmdUXGK75+dOjip5I9xOzXwVgqfhSHZKmsKQvubjti4gNFc/UIE3Q/8Orus0S3
 U7HV25TxrajX0+WlBd09wVwxteiWZgOYDEZRG
X-Received: by 2002:a05:6000:2004:b0:47a:c103:8a2e with SMTP id
 ffacd0b85a97d-47f2dce3062mr25608806f8f.45.1784208301982; 
 Thu, 16 Jul 2026 06:25:01 -0700 (PDT)
X-Received: by 2002:a05:6000:2004:b0:47a:c103:8a2e with SMTP id
 ffacd0b85a97d-47f2dce3062mr25608764f8f.45.1784208301464; 
 Thu, 16 Jul 2026 06:25:01 -0700 (PDT)
Received: from P16s.. (user-5-173-218-44.play-internet.pl. [5.173.218.44])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5b8sm22578107f8f.6.2026.07.16.06.25.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:25:00 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 15:24:59 +0200
Message-ID: <20260716132459.1042752-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] rtc02: skip (TCONF) on read-only RTCs that reject
 RTC_SET_TIME
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
fails with an errno that indicates the operation is unsupported or not
permitted (ENODEV, EOPNOTSUPP, EINVAL, EACCES, EPERM), skip the whole
test with TCONF.

Doing the check in setup, before tst_rtc_clock_save(), also avoids the
cleanup path (tst_rtc_clock_restore()) issuing RTC_SET_TIME and turning
the run into a TBROK on such devices. If the probe succeeds the test body
runs as before, so no additional handling is needed there.

Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
---
 testcases/kernel/device-drivers/rtc/rtc02.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 34509ab..9103d60 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -16,6 +16,7 @@
  */
 
 #include <stdio.h>
+#include <errno.h>
 #include "tst_rtctime.h"
 #include "tst_wallclock.h"
 #include "tst_test.h"
@@ -133,10 +134,29 @@ static void set_rtc_test(void)
 static void rtc_setup(void)
 {
 	int exists = access(rtc_dev, F_OK);
+	struct rtc_time probe_tm;
 
 	if (exists < 0)
 		tst_brk(TCONF, "RTC device %s not available", rtc_dev);
 
+	/*
+	 * Skip on RTCs that do not allow setting the time, e.g. Qualcomm PMIC
+	 * RTCs without allow-set-time or an nvmem offset, where RTC_SET_TIME
+	 * returns -ENODEV. Probe with the current time so a writable RTC is
+	 * left unchanged, and skip here (before tst_rtc_clock_save()) so the
+	 * cleanup restore does not fail on such devices.
+	 */
+	if (tst_rtc_gettime(rtc_dev, &probe_tm))
+		tst_brk(TBROK | TERRNO, "ioctl() RTC_RD_TIME");
+	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
+		if (errno == ENODEV || errno == EOPNOTSUPP ||
+		    errno == EINVAL || errno == EACCES || errno == EPERM)
+			tst_brk(TCONF | TERRNO,
+				"RTC does not support setting the time");
+
+	    tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
+	}
+
 	tst_rtc_clock_save(rtc_dev);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
