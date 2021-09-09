Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044B7C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:34:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4006113A
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A4006113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEBD03C91A6
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 18:34:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67C063C8D8B
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 18:33:53 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F24B8600815
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 18:33:52 +0200 (CEST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7490D3F302
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631205232;
 bh=TtcNJL6x44ndm3xibUbYyp5tWk5g94OyGxV5OByUKF0=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=M1Ed2C1Mw7sSqxHAQ3LtcH4nzaGwfEpq/gOg3a1GWvPBswKObTTXc2Vg0Ic5T+l8e
 bIUaSj0T0uvIddOmYsg4jf6xHwcdceFYjb87Jmwr5QQHpd/sNy1+WMdStgJTEW5N9S
 Fbe8kI2VG8/l91L9hGdYxye5qcRLKNR59ZKxbN8wZA5zwmPK894mtXsyTST6NBYHlY
 m4uLYDBj9wribz6rzXsPUWznFlNLp7Py2gRlshT5raQHJrgiVByDU6BvyZRaozf+1c
 NBHvgyab+6A+a+c8Qn+qNafhGkiKip27eALMEG7GU7PTVx/WsTNOK+FkUzc+lpeuPH
 2X3qV/qXIE9xw==
Received: by mail-wm1-f71.google.com with SMTP id
 v2-20020a7bcb420000b02902e6b108fcf1so1090883wmj.8
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 09:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TtcNJL6x44ndm3xibUbYyp5tWk5g94OyGxV5OByUKF0=;
 b=aqNDBEOdgf7XkE2IbFumDxQH9z25EqgYQ7ozqI0WAeB27zeYtLkNmFTUiUm/sL4u1h
 18x3e5tzgiucuXowfaqj47eZBU+QD5erVh8mDKF9hr9rgKNElEHWg/5o3iKWQwX05E8T
 Fr13fC10EAgJJQexHt9U9GTxOxOLR8q+ONf6pF/bq9AOyH/QR4oMaJ/mt4dkF5ryGpvO
 lAHleaBSDUQcsGU6HFMSdYWR/Qjq0UeJzit7qxgsZL9I5bwI/CfJKlZdxilyQPovMXHc
 066suTQ4yCo49REfHa8J7dMog2Ut3Zrxulsh3FzYZ3V7RVGkkbteAK4OtG317cT6rtc4
 AYMQ==
X-Gm-Message-State: AOAM5312+9QLJ2rQtO1vPRtFJkrNDBr+aXi+OlzFsd0wBZk5rX2C8PEX
 mgft4zXBrV2Tcr2R/BQWIaxOyI4+4J9X+MMuhBwpykg3VD2jKEjPkUCcHGPemiiHK98BiyhV/Bf
 cEfkCy73aFNY5QKbuSS5AHepIovUJ
X-Received: by 2002:a5d:570c:: with SMTP id a12mr4684877wrv.117.1631205231805; 
 Thu, 09 Sep 2021 09:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlcwIuKyDh8TKGmYaz5u1rx6dhN2J8z/w7+FLqBF2zBxvytjVJkkvZoEWXVO8LP1oJg3gdJw==
X-Received: by 2002:a5d:570c:: with SMTP id a12mr4684855wrv.117.1631205231580; 
 Thu, 09 Sep 2021 09:33:51 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.201])
 by smtp.gmail.com with ESMTPSA id n3sm1741944wmh.30.2021.09.09.09.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 09:33:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 18:33:26 +0200
Message-ID: <20210909163326.42598-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
References: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] rtc01: add workaround for broken CMOS RTC on
 Microsoft Hyper-V cloud
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909163326.nOZQr2CoqnENB6fSfYBVnBhUrRATM7Mqv4ggVl5OZIk@z>

rtc01 fails on missed alarm on multiple different Azure instances if the
alarm is set for the next minute:

  rtc01 0 TINFO : RTC READ TEST:
  rtc01 1 TPASS : RTC READ TEST Passed
  rtc01 0 TINFO : Current RTC date/time is 11-6-2021, 09:00:58.
  rtc01 0 TINFO : RTC ALARM TEST :
  rtc01 0 TINFO : Alarm time set to 09:01:03.
  rtc01 0 TINFO : Waiting 5 seconds for the alarm...
  rtc01 2 TFAIL : rtc01.c:151: Timed out waiting for the alarm

Reproduced easily with rtcwake:

  $ rtcwake -d rtc0 -m on -s 50 -v

If alarm is set for now+60 seconds, it works fine.  Clearly Microsoft
Hyper-V cloud instances have a broken CMOS RTC which unfortunately
cannot be easily fixed.  Adding simple workaround to extend the time to
60 seconds allows to avoid false positives in expense of longer testing
time.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/rtc/rtc01.c | 25 +++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index ebd15306d583..51b144f201ad 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -64,6 +64,23 @@ void read_alarm_test(void)
 	unsigned long data;
 	fd_set rfds;
 	struct timeval tv;
+	unsigned int alarm_sec = 5;
+
+	if (tst_is_virt(VIRT_HYPERV)) {
+		/*
+		 * Microsoft Hyper-V hypervisor has broken CMOS RTC which
+		 * does not generate interrupts if alarm is set for 5-59
+		 * seconds from now and it advances to next the minute
+		 * (e.g. 10:12:57 -> 10:13:02).
+		 * However alarm set to fire in 60 seconds (and more) works
+		 * fine.
+		 *
+		 * This was confirmed on different Linux kernels (from v4.15 up
+		 * to v5.14.2) and instances (Standard_B1ms, Standard_B4ms,
+		 * Standard_D4s_v3, Standard_D8d_v4).
+		 */
+		alarm_sec = 60;
+	}
 
 	tst_resm(TINFO, "RTC READ TEST:");
 
@@ -82,8 +99,8 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC ALARM TEST :");
 
-	/* Set Alarm to 5 Seconds */
-	rtc_tm.tm_sec += 5;
+	/* Set Alarm to 5 (or more) seconds */
+	rtc_tm.tm_sec += alarm_sec;
 	if (rtc_tm.tm_sec >= 60) {
 		rtc_tm.tm_sec %= 60;
 		rtc_tm.tm_min++;
@@ -127,9 +144,9 @@ void read_alarm_test(void)
 		return;
 	}
 
-	tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
+	tst_resm(TINFO, "Waiting %u seconds for the alarm...", alarm_sec+1);
 
-	tv.tv_sec = 6;		/* set 6 seconds as the time out */
+	tv.tv_sec = alarm_sec+1;		/* set 5+1 seconds as the time out */
 	tv.tv_usec = 0;
 
 	FD_ZERO(&rfds);
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
