Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5007AC433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 13:27:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 029323CA71C
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 15:27:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEAD63CA74C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D87411001551
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ujjmtIts2ICtDxLeG8ttxBrsOj6VFtkLbQ/UJjKIHo=;
 b=H3aiElDbD3jIl3N9zgiHpSfZOICIeHLnQuQU4g/EaOQlng8m9Nev9YcT7e9QCYe+hLvyML
 c5LESZ8becH33QyImVogYn6MrkHJURWG+Ua7CCrQ87dd4BGZ4r2Gp0dLkckJJ9lyecYH7h
 yycZDAs0hyo5PmaVPObo6NR8WYTNnko=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-phXGTVfWMOSa6y6xEHxsYA-1; Thu, 28 Apr 2022 09:27:05 -0400
X-MC-Unique: phXGTVfWMOSa6y6xEHxsYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEEE83C0D198
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:27:04 +0000 (UTC)
Received: from liwang-laptop.redhat.com (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2F49E8F;
 Thu, 28 Apr 2022 13:26:59 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 21:26:54 +0800
Message-Id: <20220428132656.11075-2-liwang@redhat.com>
In-Reply-To: <20220428132656.11075-1-liwang@redhat.com>
References: <20220428132656.11075-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] rtc02: skip test with unsupport set RTC platform
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
Cc: Hiroyuki Yasuhara <hyasuhar@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some hardware(e.g. Fujisu FX700) does not provides a feature to set the
RTC clock, thus test failed with EINVAL from ioctl(RTC_SET_TIME).

  tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
  rtc02.c:66: TINFO: To set RTC date/time is: 2020-10-09 13:23:30
  rtc02.c:70: TFAIL: ioctl() RTC_SET_TIME: EINVAL (22)
  tst_rtctime.c:116: TWARN: open(/dev/rtc,0,7020) failed: EBUSY (16)
  tst_wallclock.c:117: TWARN: tst_rtc_settime() realtime failed: EBADF (9)

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Hiroyuki Yasuhara <hyasuhar@redhat.com>
---
 testcases/kernel/device-drivers/rtc/rtc02.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index ef83aad89..8484a0074 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -22,6 +22,7 @@
 #include "tst_wallclock.h"
 #include "tst_test.h"
 
+static int rtc_unsupport;
 static char *rtc_dev = "/dev/rtc";
 
 static char *rtctime_to_str(struct rtc_time *tm)
@@ -67,6 +68,10 @@ static void set_rtc_test(void)
 
 	ret = tst_rtc_settime(rtc_dev, &set_tm);
 	if (ret != 0) {
+		if (errno == EINVAL) {
+			rtc_unsupport = 1;
+			tst_brk(TCONF, "RTC may not support be set via ioctl(RTC_SET_TIME)");
+		}
 		tst_res(TFAIL | TERRNO, "ioctl() RTC_SET_TIME");
 		return;
 	}
@@ -99,7 +104,8 @@ static void rtc_setup(void)
 
 static void rtc_cleanup(void)
 {
-	tst_rtc_clock_restore(rtc_dev);
+	if (!rtc_unsupport)
+		tst_rtc_clock_restore(rtc_dev);
 }
 
 static struct tst_test test = {
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
