Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7F2C44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 10:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784283629; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=yvIvHxAOr2HiW6H9VoTMZ3Wm7IncRk13wbXBt/HPYw4=;
 b=WZUfN8o+3Q88DROTGQTY9U/xNEGB+8VbowI0Js+zK4fuUQm50+XcQL3aBbmiv8wkQSjDz
 hwbgBdZG93xWK8yWBk3Fq+5FNGcIl+f/5Pzzm5PmktUSvfGZM7n/Pkc3YR7p3zMyVvyq50X
 nT+QsTuUL4Wl/pjELFkdMYaJWBfQDS4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0DCF3E55E4
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:20:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53AB43E55DC
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:20:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CB7551A00CCB
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:20:06 +0200 (CEST)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B37FD3FBBB
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1784283605;
 bh=aQdMk0NUWB2lTEs3taz/x2co5QNpFCBG9e5V9WXfiuY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=XApsuWM/1vD177xMiiMnor83qXjtrG3/kMsCY6Fe/qG3bA/c6iyz4UGKnvsH2w+bF
 Wa6PBsikk6lrFhcs9hL2yufsmbizbPWshzToA5ofgh+HHwrUc/UGT2jRIv3qGZ2BBW
 /kGwZiOi1QQksHL1do57u9lQOxaRX93pZjEQHi1RSO1gcArbXWXJWw5ucmd5Ei2FWf
 dyulfAhNgaDQktu7jeNeGSVbbyHxC2ssSM13qA4eIATG9PJ5qwRAT1bzGnRjsx2q9Q
 QMSEw6vJ8re9hLuYIejBwQAMsxuXaRujM+oRkNLVU8uzjeEPXjtCmH8Tz/gy2kTNcI
 ivfHRJCzLBaDedSIVbm5dFeHd9OMShA54XxG1TB4Sxa+xH6a5ftx5F+VZSqPOAp0fw
 BZuvr4DpxT5P8aH+z7x1TkSeOcyttDlxzQvvnqp0jg7Ekzz/h7KvCRt+PnKfH3E3MJ
 3beU4htON/CDacWVoNnj5bbq01V/n6kbSUdmrMZgiQnJzOTMfC+mUM9uURbK9lNG8+
 YvFSTKwX9VkkYXpiL/DcSyTJ0LRpFcPGL2UUwJVdrUgNMNrVhfqtJybzXzkH5KdJaS
 2S841gBp9j47a+7c0QU2uu1ip4WBdLciFdgXjwvLv6HefhFxeI4kOlI2E/xe08/XlS
 ocZ3vGn5WOFsnU8RL0kccqRw=
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39ad2e6474dso39875451fa.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 03:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784283605; x=1784888405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aQdMk0NUWB2lTEs3taz/x2co5QNpFCBG9e5V9WXfiuY=;
 b=DvHTi3PHgGTNNlBfQ4BJ+pZA2jA4YJohjhnOhu6xymkzzMcDp1b6Y3TuYXkpg4XFIs
 TFZkhCUxH3hwpKTxmKr9qMNuIzpXF90lnbmN3/KtUSO/wkc9cZ0ugEwlSiCfJqYdiEpI
 s5nEIm7exOkXBRIoheiXeI45a+u1uPCZTxLZUtmfft3xObC3wGNS1UvTpc2zXgmfhbKz
 pfX+ApNtt2uLjRQAT2cd+kQhda9ehyKqUSNvVryDyae5ibHt4NuUIhPIPmwGiaSLueeg
 IDtdF/vNc/M621MpKgl94hAmpZhOf07qmR6pXpZUrIoSrzgi+iQG4KRVB9J0UWiLUHyL
 6tng==
X-Gm-Message-State: AOJu0YxfncPmc0OeJkmg1hKLfdvjPAaZ3s0cmjwtlq/KWvpW8IfxZGE8
 Yr7xQA42lJqNI4vU+eDzbWJ++W4TVBEsQBehn91USAXX3hpfR90uxRUt+11BxU3U4EuTC7zkFhM
 pCKAFYVojdTIRserEwbnMGW5q/NWETaB/mWpR7aUTghN1k1cfbyddJUnizrdxejijtIyBTft5b0
 cD
X-Gm-Gg: AfdE7cm92uFUSormC93ZgBq6mcurc2HfRPIyic34i2DdOYXlH/Ls/blM03F5QHCV2R1
 IuJz1jGGGUTPgj6p0pyF9TyGx5D6Am1zo6CR1cQMjjF6AQRQbuItBFuf4GYSIUaUhoyZZtGqFGt
 mxfQeJTyafX7ccZjLanQO+E+ph2zaosnxdaVlIpUvzlq0sKngJ0unXbtFLvmpypL6UWBdRhCxOS
 zytDGGsVc1ZRXAotY2L5q+aEEHvuNmM+37UG8bQ53NOYFZ2e6Hi8isMeM2izBmGV/UbkBdDetU6
 CTqVAhE1igW80xLy8tE91tGsSpI52dqnEbUffFQMxjgrmRQF2MErGw3U7XQb1I8Pr5AgBTwhVHc
 0w379s49VDjqxQ7DfMM7IDOVTF7QcTIojdmUvxt//HnUeM+Nbr0xQ+rOYrwMa
X-Received: by 2002:a05:651c:440b:10b0:39c:92b8:dd9d with SMTP id
 38308e7fff4ca-39eb2826190mr3377351fa.26.1784283604985; 
 Fri, 17 Jul 2026 03:20:04 -0700 (PDT)
X-Received: by 2002:a05:651c:440b:10b0:39c:92b8:dd9d with SMTP id
 38308e7fff4ca-39eb2826190mr3377311fa.26.1784283604455; 
 Fri, 17 Jul 2026 03:20:04 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-183-213-56.toya.net.pl.
 [31.183.213.56]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39eb4e5b31esm1228501fa.12.2026.07.17.03.20.04
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 03:20:04 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 17 Jul 2026 12:19:59 +0200
Message-ID: <20260717102000.1318116-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: tst_rtctime: close RTC fd on the ioctl()
 error path
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

tst_rtc_ioctl() opens the RTC device with SAFE_OPEN() but returns -1 on
an ioctl() failure without closing the descriptor, leaking it on every
failed call. The RTC character device is exclusive-open, so a leaked fd
makes the next tst_rtc_ioctl() open fail with EBUSY.

This was mostly latent because the failure path was rarely taken, but it
is now hit routinely on RTCs that reject RTC_SET_TIME (e.g. Qualcomm PMIC
RTCs returning -ENODEV). Close the fd on the error path and preserve
errno so callers can still inspect the ioctl() failure reason.

Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
---
 lib/tst_rtctime.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/tst_rtctime.c b/lib/tst_rtctime.c
index c62ac73..cc0cb4e 100644
--- a/lib/tst_rtctime.c
+++ b/lib/tst_rtctime.c
@@ -7,6 +7,7 @@
 
 #include <stdbool.h>
 #include <limits.h>
+#include <errno.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_rtctime.h"
@@ -117,11 +118,15 @@ int tst_rtc_ioctl(const char *rtc_dev, unsigned long request,
 
 	ret = ioctl(rtc_fd, request, rtc_tm);
 
-	if (ret != 0)
-		return -1;
+	if (ret != 0) {
+		int saved_errno = errno;
 
-	if (rtc_fd > 0)
 		SAFE_CLOSE(rtc_fd);
+		errno = saved_errno;
+		return -1;
+	}
+
+	SAFE_CLOSE(rtc_fd);
 
 	return 0;
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
