Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423D4C44516
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784283648; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ozrxbrGxvZiLnoguQy0TeBXXHNdaEakbE0sDed5gn5w=;
 b=NJbEYuBriHqyrmduJHhvOEqQDYrE8p8JLGfnFewTakqsRFnjDbtsorlFcLJstLrsVok4x
 jQUdt3RV+OPjfLf/lTSKbFqp3uv05mEBSdO6vtQZfnXB25etlUHDwDSNdd8Tig9GGC1PrkQ
 T+RwOBYSg5+qaeteP7i/PtjB8QuUtBA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1A6B3E76AE
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:20:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EF663E55DC
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:20:08 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CC33D1400B62
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:20:06 +0200 (CEST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1C7863F135
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784283606;
 bh=f0h3Z1tb/rnM6NoLUE3A5Jelv85o74DkHoB4eukCyak=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HxgsBQT++B7G/OF5Zrb5UP3w0RP2VPdDlPlF2Zy+qtt+0USFRP/RbTVcDfG80BA3p
 HgJZMjRVFxJa1guGLh3QuIDHwwiz2CdjnISfkyCSHjVCWkzHMgB71Gl8J+t8Aj8vIA
 ku4vuvqUinvnbqCfygvPNzryYOrwZFprCaqhoQIfhWMNLjnvj1d5MguWeB9/7ChNZo
 9NEqQTOYsj3i6Dl8wf2ySn8AVxw8jwjNatZBovLEohEyw6RtCVelwHr21UhbyixRqN
 P9uX5mUSY4utGZD/u4KIRYYi55NJp5Asf9ERdUCx8w48ZugAp1rHxh9joUpvi4VN4B
 Rlf0CQ69+NLaBpaJuVaKykcWwn8y816jsASxgXLw+NojniF7dAFAjYYjL7D4x+hsUN
 c3xnvHZPzZx0LMFzMsCGpeN1cN+d7LQ3Lv7ay20yxHezLhRY+Ul6OYWt0JHU6Gy0q4
 L7UKMOc2L0+UKJCCuZfAvPWMkIEaD94qj8CKGbAgViwdWFz0Y4LVl17zixx73tz6GY
 bwYH8UXbgGgTcXtWE2DKlzAYRRWAYt55Sz3MM2LCZOtq3eeyDRmfqxeR30jE/zc3Ec
 w0+J+Xy/JEe8XSrogqYopj/0F3yrwqYZneNgWIqQWA44gpu0vlTV0kDr2lP9bSvbnP
 5heoxBwq0YSmDsj5cQpg5iYw=
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-39d93d95a21so20167041fa.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784283605; x=1784888405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f0h3Z1tb/rnM6NoLUE3A5Jelv85o74DkHoB4eukCyak=;
 b=k5B1ERsbRyGHxKT4LV5LbUS5d+rKlkRL9jBkSnk39tc73liZP4vB+pExhfgBmZpsPQ
 0G9IBJpjaeP1+HXcGbBsCh6Wjqfwf4N6LWoNb5OFCpVEzJ9+GwxYShaddiy3y7LmrUXv
 HOjXeSXaDtt/ngxOOH35dMoXwWML0Gx1o4XFI7Jw6+OGrjrb1z/pSLVmoIGZd8jmB67z
 qm3uzzSbORBckP+KRQEF/DG7QsHra2CQbnROVWKlfdBxWf4TtwTRDaZK3UzG5Ep1yPNO
 2UnEF3UQcbFvDcDjKHPepcoBDQjTDUuLCdyPXXUqY2M4pEbzQbM4DBFjKs7EzKFBqTCj
 ETBw==
X-Gm-Message-State: AOJu0YyE5ac4zA3T9TesT6dnfQgAAv93203Pq48z3eG98lTFP2CaloEc
 4CtS3gUKA2+swFKbYmgx34ivmuyy5QWIjOfeLS8Iww5GMT7X+LZcx1djqehRsXRO0MMsKrjRzXw
 S+XVsCHxtTp6v1u9hnni2hJ/nZ8+Rll4VIAjECKMtQf12CMcaSdKkNC6aZz4Qi6K40k1C7l+Xe6
 vc
X-Gm-Gg: AfdE7cmO4KwWtlSwx9K4oRfQAuTtc294anUUZFRiQzumijPyKEipfFLctZrCTos4bzX
 ZD2ofGr3XzfonbymWTLEd0L7L9ZnVWASOLtiAE7dsxlIAdq8Uw6CNZmGNcewBrpwM087yBoKhIs
 mUoGB16ZGBWCPUhfPdW0TGGbB5MNif4PZQPIofNy7XewnFI4zGAE83o3/slEv7skP1d112yKIyL
 5WC8Ro8hsiy7PGLoT5vtrVA94YRW+OIpUGifrmknul/xwtcoP74uP0mN6slwCTUh1LpBxJnLWfu
 DLjHf6Xib9e90oAxmEcRFNxUmHMVNUgH1bS/5AI1ysv+AHsVxRifcvySP3oY0Nr1bX+w3jj/H8p
 jR3fzGjL3vhnKXnCkBejmAltOl/OSFpiPbjxUi2q3YhYQ2pUET95iFZPPuIec
X-Received: by 2002:a05:651c:88b:b0:394:3b62:b6aa with SMTP id
 38308e7fff4ca-39eb275de69mr4589731fa.12.1784283605442; 
 Fri, 17 Jul 2026 03:20:05 -0700 (PDT)
X-Received: by 2002:a05:651c:88b:b0:394:3b62:b6aa with SMTP id
 38308e7fff4ca-39eb275de69mr4589671fa.12.1784283604979; 
 Fri, 17 Jul 2026 03:20:04 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39eb4e5b31esm1228501fa.12.2026.07.17.03.20.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:20:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 12:20:00 +0200
Message-ID: <20260717102000.1318116-2-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
References: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] rtc02: skip (TCONF) on read-only RTCs that
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
 testcases/kernel/device-drivers/rtc/rtc02.c | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 34509ab..96e1084 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -16,6 +16,7 @@
  */
 
 #include <stdio.h>
+#include <errno.h>
 #include "tst_rtctime.h"
 #include "tst_wallclock.h"
 #include "tst_test.h"
@@ -133,10 +134,31 @@ static void set_rtc_test(void)
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
+	 *
+	 * Only ENODEV is treated as "not supported" here. Wider errnos such as
+	 * EINVAL are used broadly by the kernel and could mask a genuine
+	 * failure, so let anything else fall through to TBROK.
+	 */
+	if (tst_rtc_gettime(rtc_dev, &probe_tm))
+		tst_brk(TBROK | TERRNO, "ioctl() RTC_RD_TIME");
+	if (tst_rtc_settime(rtc_dev, &probe_tm)) {
+		if (errno == ENODEV)
+			tst_brk(TCONF | TERRNO,
+				"RTC does not support setting the time");
+		tst_brk(TBROK | TERRNO, "ioctl() RTC_SET_TIME");
+	}
+
 	tst_rtc_clock_save(rtc_dev);
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
