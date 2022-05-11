Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A481FC433F5
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 02:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78BFB3CA984
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 04:16:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127B03C1C59
 for <ltp@lists.linux.it>; Wed, 11 May 2022 04:16:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6601200984
 for <ltp@lists.linux.it>; Wed, 11 May 2022 04:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652235403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=J2Iv1+fMacJRsTSg394gYScEIokCZDyv+iZ70hbt8Iw=;
 b=SO7RNj2ZT7mlYNVj0t0O+dBKaB++oGZTjDsC1JnuqJETdgQMqSJPQUPw1rHGVEdL6V9ezV
 oqF46n5MmvvR9yEEE3nvz/L+dj0uHpVLUwd5D32NxLAl1CrlhjokR0MRDYzq6nzxUGOwMV
 oxQRUCLaApzp5h+qzcMHPNBzgn6VQEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-_aRkkOYjM7SFb5rJMeHvRg-1; Tue, 10 May 2022 22:16:40 -0400
X-MC-Unique: _aRkkOYjM7SFb5rJMeHvRg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB7CE811E76;
 Wed, 11 May 2022 02:16:39 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEE02166B2F;
 Wed, 11 May 2022 02:16:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 11 May 2022 10:16:36 +0800
Message-Id: <20220511021636.2166562-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] rtc02: loosen the compare precision with few
 seconds
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
Cc: Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

That possibly has time elapse between the two operations, especially
on VM we can't guarantee the time precisely equal, let's lose a few
seconds to make the test happy:

  tst_test.c:1433: TINFO: Timeout per run is 0h 10m 00s
  rtc02.c:66: TINFO: To set RTC date/time is: 2020-10-09 13:23:30
  rtc02.c:80: TINFO: read RTC date/time is: 2020-10-09 13:23:31
  rtc02.c:83: TFAIL: RTC SET TEST

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Eirik Fuller <efuller@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    V3:
      I'm also fine to go with only use seconds for hour/min/sec comparsing.
      But that quite no necessary since most of time delta is zero.

 testcases/kernel/device-drivers/rtc/rtc02.c | 54 ++++++++++++++++++---
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 0705357bb..dbac11b85 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -40,12 +40,54 @@ static char *rtctime_to_str(struct rtc_time *tm)
 
 static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
 {
-	return !((set_tm->tm_sec == read_tm->tm_sec)
-		&& (set_tm->tm_min == read_tm->tm_min)
-		&& (set_tm->tm_hour == read_tm->tm_hour)
-		&& (set_tm->tm_mday == read_tm->tm_mday)
-		&& (set_tm->tm_mon == read_tm->tm_mon)
-		&& (set_tm->tm_year == read_tm->tm_year));
+	long delta, seconds1, seconds2;
+
+	if (set_tm->tm_year != read_tm->tm_year)
+		return 1;
+
+	if (set_tm->tm_mon != read_tm->tm_mon)
+		return 1;
+
+	if (set_tm->tm_mday != read_tm->tm_mday)
+		return 1;
+
+	/*
+	 * Convert hour/min/sec into seconds to handle the normal
+	 * and special situations:
+	 * 1#
+	 *       set_tm:  2022-04-28 13:00:50
+	 *       read_tm: 2022-04-28 13:00:50
+	 * 2#
+	 *       set_tm:  2022-04-28 13:00:50
+	 *       read_tm: 2022-04-28 13:00:51
+	 * 3#
+	 *       set_tm:  2022-04-28 13:00:59
+	 *       read_tm: 2022-04-28 13:01:00
+	 * 4#
+	 *       set_tm:  2022-04-28 13:59:59
+	 *       read_tm: 2022-04-28 14:00:00
+	 *
+	 * Note: as we have avoided testing around the zero
+	 * clock, so it's impossible to hit situation 5#
+	 *       set_tm:  2022-04-28 23:59:59
+	 *       read_tm: 2022-04-29 00:00:00
+	 */
+	if ((set_tm->tm_hour != read_tm->tm_hour)
+		|| (set_tm->tm_min != read_tm->tm_min)
+		|| (set_tm->tm_sec != read_tm->tm_sec)) {
+
+		seconds1 = (set_tm->tm_hour  * 3600) + (set_tm->tm_min  * 60) + set_tm->tm_sec;
+		seconds2 = (read_tm->tm_hour * 3600) + (read_tm->tm_min * 60) + read_tm->tm_sec;
+
+		delta = seconds2 - seconds1;
+
+		if (delta < 0 || delta > 3) {
+			tst_res(TFAIL, "seconds1 is %ld, seconds2 is %ld", seconds1, seconds2);
+			return 1;
+		}
+	}
+
+	return 0;
 }
 
 static void set_rtc_test(void)
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
