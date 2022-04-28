Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8F0C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 13:27:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EAD33CA71C
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 15:27:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD893CA72C
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3A86520112F
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mf12lVv6ITiqtmHVrjN7MSYn6/3durRYL4MRqDMzF88=;
 b=XohxuFOkhu+SB1BKfH2aQ8iKGKL4fUublVaiaoPKZ5FOJFFQ5+atMlKXCPjh4kFVfxeC3O
 bmCPZa0wqPs1lwrX6kJTMHtowOWZzrPZNU3LzPofqY5+zoF2cWrCJMA4+hIcnwgtHqaPzh
 7qL69xoKq3dELSP+HYVmp2Bg3ZCpUSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-RZTFxneVMQCAl9Ko88lqVg-1; Thu, 28 Apr 2022 09:27:08 -0400
X-MC-Unique: RZTFxneVMQCAl9Ko88lqVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45FAB86B8A0
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:27:08 +0000 (UTC)
Received: from liwang-laptop.redhat.com (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731C87C55;
 Thu, 28 Apr 2022 13:27:05 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 21:26:55 +0800
Message-Id: <20220428132656.11075-3-liwang@redhat.com>
In-Reply-To: <20220428132656.11075-1-liwang@redhat.com>
References: <20220428132656.11075-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] rtc02: reset backward 1 hour to RTC time
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
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If there's a limit on how much backward time can be set to RTC,
rtc02 easily get an EINVAL error as well. (Note: that limitation
may enforced by the host or by EFI firmware)

  rtc02.c:70: TFAIL: ioctl() RTC_SET_TIME: EINVAL (22)
  tst_rtctime.c:116: TWARN: open(/dev/rtc,0,21042104211) failed: EBUSY (16)
  tst_wallclock.c:117: TWARN: tst_rtc_settime() realtime failed: EBADF (9)

To show the problem by manually performing `hwclock -w`.

  # date -s "2020-10-09 13:23:30"
  Fri Oct  9 13:23:30 EDT 2020
  # hwclock -w
  hwclock: ioctl(RTC_SET_TIME) to /dev/rtc0 to set the time failed: Invalid argument

If just go with a few days backwards things work:

  # date -s "2022-03-12 13:23:30"
  Sat Mar 12 13:23:30 EST 2022
  # hwclock -w
  # echo $?
  0

To be on the safe side, here reset backward +/-1 hour (in case of zero clock).

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Eirik Fuller <efuller@redhat.com>
---
 testcases/kernel/device-drivers/rtc/rtc02.c | 27 ++++++++++++---------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 8484a0074..6198a5d5d 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -51,19 +51,23 @@ static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
 
 static void set_rtc_test(void)
 {
-	struct rtc_time read_tm;
+	struct rtc_time read_tm, set_tm;
 	int ret;
 
-	struct rtc_time set_tm = {
-		.tm_sec = 30,
-		.tm_min = 23,
-		.tm_hour = 13,
-		.tm_mday = 9,
-		.tm_mon = 9,
-		.tm_year = 120,
-	};
+	/* Read current RTC Time */
+	ret = tst_rtc_gettime(rtc_dev, &read_tm);
+	if (ret != 0) {
+		tst_res(TFAIL | TERRNO, "ioctl() RTC_RD_TIME");
+		return;
+	}
+
+	/* set rtc to +/-1 hour */
+	set_tm = read_tm;
+	if (set_tm.tm_hour == 0)
+		set_tm.tm_hour += 1;
+	else
+		set_tm.tm_hour -= 1;
 
-	/* set rtc to 2020.10.9 13:23:30 */
 	tst_res(TINFO, "To set RTC date/time is: %s", rtctime_to_str(&set_tm));
 
 	ret = tst_rtc_settime(rtc_dev, &set_tm);
@@ -76,7 +80,7 @@ static void set_rtc_test(void)
 		return;
 	}
 
-	/* Read current RTC Time */
+	/* Read new RTC Time */
 	ret = tst_rtc_gettime(rtc_dev, &read_tm);
 	if (ret != 0) {
 		tst_res(TFAIL | TERRNO, "ioctl() RTC_RD_TIME");
@@ -89,7 +93,6 @@ static void set_rtc_test(void)
 		return;
 	}
 	tst_res(TPASS, "The read RTC time is consistent with set time");
-
 }
 
 static void rtc_setup(void)
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
