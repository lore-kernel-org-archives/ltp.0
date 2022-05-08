Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350A7C433EF
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 03:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 520DE3CA8D7
	for <ltp@archiver.kernel.org>; Sun,  8 May 2022 05:05:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567393C062C
 for <ltp@lists.linux.it>; Sun,  8 May 2022 05:05:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C9451400062
 for <ltp@lists.linux.it>; Sun,  8 May 2022 05:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651979130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JicXVa01jiLMgGuSvQZrhSMIFFhiJMsw5/5k7MA2fSE=;
 b=EOFMmb/6dgOlRUbl2Tc58gMtqwujXUu9G24zlz/yfmSCQ3cypsq3oIy+W5vx8M1ewbjgdG
 4qgaAENwLZykEO6uYozKFxMGcsUqNTyMhE8tSQDLprEDHopAtPMmre46UBBHWMeGqPC6Xr
 TMXZgb0rVpJjw0M3RbzcgyfT1g1yuU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-I9tgPvpAPpmqcpQuKRe44A-1; Sat, 07 May 2022 23:05:29 -0400
X-MC-Unique: I9tgPvpAPpmqcpQuKRe44A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC54C85A5A8;
 Sun,  8 May 2022 03:05:27 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1696D9E6C;
 Sun,  8 May 2022 03:05:25 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun,  8 May 2022 11:05:24 +0800
Message-Id: <20220508030524.2072035-1-liwang@redhat.com>
In-Reply-To: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
References: <CAEemH2d-83ubH1LF3SotjvxwD_5C0BiLTTZ+yGtaYqv47n28AQ@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] rtc02: loosen the compare precision with few
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

That possibly has time elapse between twice operations, especially
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
 testcases/kernel/device-drivers/rtc/rtc02.c | 41 +++++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 0705357bb..8b03b0a90 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -40,10 +40,43 @@ static char *rtctime_to_str(struct rtc_time *tm)
 
 static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
 {
-	return !((set_tm->tm_sec == read_tm->tm_sec)
-		&& (set_tm->tm_min == read_tm->tm_min)
-		&& (set_tm->tm_hour == read_tm->tm_hour)
-		&& (set_tm->tm_mday == read_tm->tm_mday)
+	long delta, seconds1, seconds2;
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
+	if (!(set_tm->tm_sec == read_tm->tm_sec)
+		|| !(set_tm->tm_min == read_tm->tm_min)
+		|| !(set_tm->tm_hour == read_tm->tm_hour)) {
+
+		seconds1 = (set_tm->tm_hour  * 3600) + (set_tm->tm_min  * 60) + set_tm->tm_sec;
+		seconds2 = (read_tm->tm_hour * 3600) + (read_tm->tm_min * 60) + read_tm->tm_sec;
+
+		delta = seconds2 - seconds1;
+
+		if (delta < 0 || delta > 3)
+			return 1;
+	}
+
+	return !((set_tm->tm_mday == read_tm->tm_mday)
 		&& (set_tm->tm_mon == read_tm->tm_mon)
 		&& (set_tm->tm_year == read_tm->tm_year));
 }
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
