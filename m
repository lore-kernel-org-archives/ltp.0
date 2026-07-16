Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA90C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784199054; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=s06+GxoFlQgj6EijbA14hik/ZRwnPcpot4DK9r1Xxs0=;
 b=RaRn1Xf6Skdm2LoN+MDZCkOAperQIFtNevfcZVmUAFtk+/DOgfZNchp4RWEks3dTBbAM8
 3gnJEYRdk/4NsBmapQJWUvQPEGTNZBzuxdGVFzpfrADqY8Z7b9Nl36wA+eyprQAzXmAXxL+
 /n9xrXKNpRKj1IDhSkcbI1C8xjECwmk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A7C3E2584
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:50:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50F9D3E1CE1
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:50:33 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E18560076F
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:50:32 +0200 (CEST)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CA903F2D4
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784199032;
 bh=knbxMzMyYq5KSFbBij0f3utvvFvgs4sGNbEY2UF6PUw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=BiDqDCE8eWWjaFxGeYVZjbXbpZquUXW08xNZuYl0kI0v7xTRagjTzRZNvu5NNbMfT
 /yL0lTp31PJ5wqOW96YU2XzdjwzvDjM4/sG8AQuxssyWBrPbZBeKDR9Pg4R6NthSJF
 Acg4Bg4ZWXjCzNyrLiTMXcvOV30V2JcQTTjAfM2rJn1m1WzzGwHGXv7e8JzsuoLWPt
 2SPlj6/YzI2Q1St+alOEFqzpuVQAIjs54kAjMmzwPUHXbz0GBxYQSIXu2qQqabgVH8
 F1f0qZSm6NqwlUWDtDNjiXJHI0vXaFIDkpNly0t2L0SvVygz6cVZC4C4wteSZx6cdg
 xqMHtTEbJ0jLn667hqSHnlAM8NtY5ArNzVrkVHhrD8dv6dv/mo5/5+jAuxhB9L8cy9
 FZHTpG/TWJ+VtKwIseJotYJ/xbDPi2DEydWIoIDi47LXQ+L3eVuP8VnczDB4YyZFuQ
 SgazO9HJvdbX+irOGS1vpR9dtv8sz8+y1wCZi2dTDggpZ2dQTi0i/SXUlhizfLkU9Z
 WHwid2HJ1Cio+WVRcSEqYNC+KHjJcls3uYjB3stsiDLEWDoqgd6LYNkcWa07L3B+Jc
 bi6o0cpzY8S3J8WSJcYESwKdC81i2X7eNPEEMFCuqHqUEvoTshFgpAQfBoJO5NHzfI
 xh992D6+3UrgNYQo68pg/nao=
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47bbe3b9705so5772806f8f.0
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 03:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199032; x=1784803832;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=knbxMzMyYq5KSFbBij0f3utvvFvgs4sGNbEY2UF6PUw=;
 b=VDFJ8YcRMs9nj3Xz0bL4o3O0smczTcvXAKILY2ccqP8O9bjMuM6nbLPWX9Z/kDAJdZ
 Qm45I9BJPoKS2UJAcqXJxqrMYxZaOqyFrVuIRGqiBJWRrEqB4QA6h/uH5wlquZQdxkJt
 0u8ce+6ELw2FiYIYAEOCfXQPDKXcLoZQ6sedbk/nxTiX49O6KGGAAKWi93N/GKeM3tBT
 hWoHCQ2eYkI6wIwdweZipr/2HSAAvAbSQHZS9ayORdtnlU//RL+z8e44NXaP5Zly8SBh
 Y3l0Su/y7TeJMo4tz4uWKsuMg5EY6CV559hclUvZ6XPU1AZexjxHLER1G5txXq2QlP4v
 /cKw==
X-Gm-Message-State: AOJu0YweSrJ6s29kYDbnlWZxBzf/w90EgC61qv2JV9lh7OPd7NOUrWzZ
 pKmCKQbhIeaeX2lscDqemui/+sQ/3+5ExG51Gzv9hayTGyoXX2z0riimDGndvlmhuX/UKtELWbp
 iupgo+HKK0MTyXnpLlORqwpgXFemHJPy0hRDr+yi9/f9Jb5sxY7wou5LOKIDcQKTr3m1lKnuqLF
 Y2
X-Gm-Gg: AfdE7ckTZmKimGCWbIXm3+0WsNSlg8uP4orrS1dMPwyCNyKhnXkY3USnRWzn//2cu1y
 ZmAn6mTSCMUGlkcWYibSgaprc/S3ITNm2f5ICKP1svPlDL9aZUjw0+xklGJLnXdWYUaP5QY1mn/
 sqcdGqg3l0QcILafpHAkz524+exb6lFoLTUd0dTz30n8asEbbInpV/clR9KtbUji5PV0FKKXzg7
 kHsXp378RvN3x9yHb0+rjmODcratR3sjjmhsWI0mTEUnAsTNfwR5SOYZdvzeXeekKBPjB76uHOB
 8xuPbspQJnEkik2ygoN/h/C3qv3QrGnIUNhn4vjRfl/a2f/sBVMa+KW0jtE2CxpykAlK9uMh0rJ
 CCcNRMPEvB4GEyc6Nq63edOtmrGMtP4F0YYzA/Xdrj+VbbH7Lkr61DwFB
X-Received: by 2002:a05:6000:40e1:b0:472:fe1a:1ee9 with SMTP id
 ffacd0b85a97d-47f4fcd58d9mr7422973f8f.20.1784199031960; 
 Thu, 16 Jul 2026 03:50:31 -0700 (PDT)
X-Received: by 2002:a05:6000:40e1:b0:472:fe1a:1ee9 with SMTP id
 ffacd0b85a97d-47f4fcd58d9mr7422946f8f.20.1784199031467; 
 Thu, 16 Jul 2026 03:50:31 -0700 (PDT)
Received: from localhost.localdomain (user-5-173-218-44.play-internet.pl.
 [5.173.218.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464bbb0esm23886963f8f.28.2026.07.16.03.50.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:50:31 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 12:50:25 +0200
Message-ID: <20260716105025.1014856-1-kuba.pawlak@canonical.com>
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
index 34509ab..042fa65 100644
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
+        tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
+	}
+
 	tst_rtc_clock_save(rtc_dev);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
