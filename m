Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21FC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:34:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F4C610C9
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C5F4C610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0653C9315
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 18:34:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE5F43C21F8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 18:33:51 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1B1D36007A0
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 18:33:50 +0200 (CEST)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 77D303F302
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631205224;
 bh=mT1qtC+qcT2xw7KLA2lDZ75XZ0hqLLEJ5KwsgAYynIw=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=tJg2HBHrNPPrwI2Y3SXroxB7cQptfn8hFYeUdom+2MjJWMwKQZRMj2tVcyfaWoOHc
 9+mLvR5a6YXsI6MnzRdDc2Z4ZU0U8y+UiwWN1mSff6y0s46LACM6q0y9I5gda+p1KN
 KZaZyVnaFDIdfLcz6xzNQOr70X0SNXnQKXqcFtDUTsqZfZjtp98KIWpZSf7uiMM1Dd
 BICMTuWoHGUcvDDPoPdKrT3wzVZWBIjIkjnC9mbEMm2KbGpZqN2Io628PdIouttMIh
 hcYbXGYRpGH8PKkhswPmco0g1UnRxOcHaObWlH+/3wAUxTocKZeoTP49ozfGE8ySlC
 zK78uf2TdCoqg==
Received: by mail-wr1-f72.google.com with SMTP id
 p10-20020a5d68ca000000b001552bf8b9daso701997wrw.22
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mT1qtC+qcT2xw7KLA2lDZ75XZ0hqLLEJ5KwsgAYynIw=;
 b=2hnYiyWkCjUmAVVonjPXoZqXjATAcwJd3JaLu/w0sCKl41CfyrjKcFJJB6QtX9Kj00
 zzFEf6IjBlKgZvYxGm1FChAbnK0WyteR1OZnL0dEkcWvF6gZu3hAM+L8JvY0UUDXbH2m
 zaoJUamttpDhbOXvYJ833eGxsSC6Crl3DCnxCzitBxrs3pVS3PcEWXeKgqtgf+QceExP
 DmCfJc+AZzSl4R7158bnIDuty08B7l5AvhnXtEzTnxQRP3W1qTpmoZhSYo8Hq5beTm0X
 wwp8nKJZKUU/+jZQRrKKq2H74TP4tAQ7glskzpucNx+xqxz1BJP11kfgwWb7ATSbUTKc
 MPOQ==
X-Gm-Message-State: AOAM533ML3as/Wxg8NpkIzx/gqFqX6skEOv1iAFdw0CBQrMeyhN9fKjf
 oZT1IphPZ5QDOvzJ8dnFcqkThDm05mzq6T1XIG12J1qU0kW8aQ1F8AxneoSDwGW4spa33a5eMp6
 6d9MIQx1Kg6BWm5bly1m3emnYuEWf
X-Received: by 2002:a05:6000:18a:: with SMTP id
 p10mr4610206wrx.40.1631205223917; 
 Thu, 09 Sep 2021 09:33:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBmW27i2gByLTnIUiwYrcL+aURLO12gJ/cHyKARvK4W+ZXkolkazcfpAZQYl5fm3mKLZp8pA==
X-Received: by 2002:a05:6000:18a:: with SMTP id
 p10mr4610185wrx.40.1631205223693; 
 Thu, 09 Sep 2021 09:33:43 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.201])
 by smtp.gmail.com with ESMTPSA id n3sm1741944wmh.30.2021.09.09.09.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Sep 2021 09:33:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 18:33:25 +0200
Message-ID: <20210909163326.42598-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] rtc01: add space to beginning of comments
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
Message-ID: <20210909163325.uL_M32cy-h5jieyDOz4Xc6ohsSWSY5Z6z27QCIWaxi8@z>

Improve readability of comments - no functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 testcases/kernel/device-drivers/rtc/rtc01.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index 8a1f62eadcec..ebd15306d583 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -67,7 +67,7 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC READ TEST:");
 
-	/*Read RTC Time */
+	/* Read RTC Time */
 	ret = ioctl(rtc_fd, RTC_RD_TIME, &rtc_tm);
 	if (ret == -1) {
 		tst_resm(TFAIL | TERRNO, "RTC_RD_TIME ioctl failed");
@@ -82,7 +82,7 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "RTC ALARM TEST :");
 
-	/*set Alarm to 5 Seconds */
+	/* Set Alarm to 5 Seconds */
 	rtc_tm.tm_sec += 5;
 	if (rtc_tm.tm_sec >= 60) {
 		rtc_tm.tm_sec %= 60;
@@ -106,7 +106,7 @@ void read_alarm_test(void)
 		return;
 	}
 
-	/*Read current alarm time */
+	/* Read current alarm time */
 	ret = ioctl(rtc_fd, RTC_ALM_READ, &rtc_tm);
 	if (ret == -1) {
 		if (errno == EINVAL) {
@@ -129,13 +129,13 @@ void read_alarm_test(void)
 
 	tst_resm(TINFO, "Waiting 5 seconds for the alarm...");
 
-	tv.tv_sec = 6;		/*set 6 seconds as the time out */
+	tv.tv_sec = 6;		/* set 6 seconds as the time out */
 	tv.tv_usec = 0;
 
 	FD_ZERO(&rfds);
 	FD_SET(rtc_fd, &rfds);
 
-	ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);	/*wait for alarm */
+	ret = select(rtc_fd + 1, &rfds, NULL, NULL, &tv);	/* wait for alarm */
 
 	if (ret == -1) {
 		tst_resm(TFAIL | TERRNO, "select failed");
@@ -174,7 +174,7 @@ void update_interrupts_test(void)
 	struct timeval tv;
 
 	tst_resm(TINFO, "RTC UPDATE INTERRUPTS TEST :");
-	/*Turn on update interrupts */
+	/* Turn on update interrupts */
 	ret = ioctl(rtc_fd, RTC_UIE_ON, 0);
 	if (ret == -1) {
 		if (errno == EINVAL)
@@ -187,7 +187,7 @@ void update_interrupts_test(void)
 	tst_resm(TINFO, "Waiting for  5 update interrupts...");
 	for (i = 1; i < 6; i++) {
 
-		tv.tv_sec = 2;	/*2 sec time out for each interrupt */
+		tv.tv_sec = 2;	/* 2 sec time out for each interrupt */
 		tv.tv_usec = 0;
 
 		FD_ZERO(&rfds);
@@ -231,10 +231,10 @@ int main(int argc, char *argv[])
 
 	rtc_fd = SAFE_OPEN(NULL, rtc_dev, O_RDONLY);
 
-	/*Read and alarm tests */
+	/* Read and alarm tests */
 	read_alarm_test();
 
-	/*Update interrupts test */
+	/* Update interrupts test */
 	update_interrupts_test();
 
 	close(rtc_fd);
-- 
2.30.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
