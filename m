Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F122C433F5
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 13:27:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A36F43CA746
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 15:27:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2544C3CA756
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E04701401700
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 15:27:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651152431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3toNz/pPWgiv4CKm2EJoZDxaiF/7tmQIm7TREHiexo=;
 b=AOjWJlZ6wj07CfgJDQ8mYikmeOfKch/9P+sgu2tlQ1MbPv+1lDK0xIn1S5eR891Ss0sSfZ
 0kWa2bf4dkYoforphWtm7mK8TtCaQyooZ1YudLVEeNWEDNGnBJ2+mb1+lsPb6WMBrwwqSb
 o6sdMdbz6gJarDeRDmJ1VBrzaSbs+PE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-CNXcIGKeOKSF08Q-db1e6A-1; Thu, 28 Apr 2022 09:27:10 -0400
X-MC-Unique: CNXcIGKeOKSF08Q-db1e6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BF772811762
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 13:27:10 +0000 (UTC)
Received: from liwang-laptop.redhat.com (ovpn-12-133.pek2.redhat.com
 [10.72.12.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDCEB7AD5;
 Thu, 28 Apr 2022 13:27:08 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 28 Apr 2022 21:26:56 +0800
Message-Id: <20220428132656.11075-4-liwang@redhat.com>
In-Reply-To: <20220428132656.11075-1-liwang@redhat.com>
References: <20220428132656.11075-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] rtc02: loosen the compare precision with few
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
---
 testcases/kernel/device-drivers/rtc/rtc02.c | 46 +++++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 6198a5d5d..a008971d5 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -41,10 +41,48 @@ static char *rtctime_to_str(struct rtc_time *tm)
 
 static int rtc_tm_cmp(struct rtc_time *set_tm, struct rtc_time *read_tm)
 {
-	return !((set_tm->tm_sec == read_tm->tm_sec)
-		&& (set_tm->tm_min == read_tm->tm_min)
-		&& (set_tm->tm_hour == read_tm->tm_hour)
-		&& (set_tm->tm_mday == read_tm->tm_mday)
+	int delta = read_tm->tm_sec - set_tm->tm_sec;
+
+	/*
+	 * To handle the normal and special situations:
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
+
+	/* 1~3 */
+	if (set_tm->tm_hour == read_tm->tm_hour) {
+		if (set_tm->tm_min == read_tm->tm_min - 1)
+			delta += 60;
+		else if (set_tm->tm_min != read_tm->tm_min)
+			return 1;
+	}
+
+	/* 4 */
+	if ((set_tm->tm_hour == read_tm->tm_hour - 1) &&
+			(set_tm->tm_min == read_tm->tm_min + 59))
+		delta += 60;
+	else if ((set_tm->tm_hour != read_tm->tm_hour))
+		return 1;
+
+	if (delta < 0 || delta > 3)
+		return 1;
+
+	return !((set_tm->tm_mday == read_tm->tm_mday)
 		&& (set_tm->tm_mon == read_tm->tm_mon)
 		&& (set_tm->tm_year == read_tm->tm_year));
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
