Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76C606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ltScSLyG;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EhTf9YkG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794811351; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=TfXLOKvE2nCi/1TnRYi7QyDTLXYKVojAJn+dL4jrOm8=;
 b=ltScSLyGrShEsypqyNP6GZAEzzxrScnuussmphuIdAOJctvui+jIYV2iYspwWOLlHc1fr
 ztCO2jA2m9uJuR3jXMZUSQ/FN6PfxYFXewOWDBIC9sgxqYvFAe3NdEODFhjsc5D+WOPBneA
 i+MfwlzKojsR8uqZIYzUPpODSHqI92c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B6B33E30D0
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:42:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC7E53CD35B
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 07:42:10 +0100 (CET)
Received: from mail-pl1-x645.google.com (mail-pl1-x645.google.com
 [IPv6:2607:f8b0:4864:20::645])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0C2E600042
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 07:42:09 +0100 (CET)
Received: by mail-pl1-x645.google.com with SMTP id
 d9443c01a7336-2eb2437d752so14081205ad.0
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 22:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794811328; x=1795416128; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4IRYZl7S4bYDWZ1suodYMTK+WHbMZkozQ8JrmWtEL44=;
 b=EhTf9YkGiE8W5fUsireluzXOSeDrIkgtirNZsf6CAD1EqW2q+b9gWSevFsGqxEcPEf
 gsUX1thimsgfdYheqvYWpiNWBXrN7Bopqt9jvus19UFl5149anrMERVNVsvdmGEkigD5
 cb9aTHRpAW/04ShO5J3XsT23La9Gs5gN58bDYMuKeVSgy+aojgoiCgxGpTnlR3OVZaTC
 BTEJEH6mgCY46oOax2DrZmMML2YS3REsuV1FJoqPmY89M6pqiebE8Gk/ixrMRgAc6/22
 xdga+/PUh53GN6Mxeis1z0aQcK+Iojf5XZ2LLYpSqyW2PWnHsHBX0z5oz5xC9Nkqz0+d
 PlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794811328; x=1795416128;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4IRYZl7S4bYDWZ1suodYMTK+WHbMZkozQ8JrmWtEL44=;
 b=Gy0E3+GCJ1D4P2nZwExQRyJ+iELG297W4KhHhMwJw8qm0M4Ppo9FX7PNimpfUUo0P7
 c3hOIOV7FlJv9fGkCjGsJJae2UkpMKnjMWmsRDXv5P5wnGE4v9tbhGfoocaOToqEOsCi
 E6XS8DSJzFG30biY4KyNnMy+iRg42Scq4gMTLvDiu9lv8BHiTveoYrssHWdbHWOMAh/y
 qoHpt45jLHw0B9a9axnlwIIgHx26M4Gfj9dR6FUmb/bdrTnE6Eh2Z5yslFhd4xhCTjCs
 Mq4PbJQWlUaMt3a0e8MZK8T77xMKfFuJMxiKTHGUm3l+hMyXGUWH3qG6f+YwpQwfqYTI
 8+Lw==
X-Gm-Message-State: APuU4Z/y7kLy/ozXqpkciGrnvEq4CF8gVO06z4PYemT5+kIlCNa3UUqr
 RoyLne/TqZJRTCFrYyPMCOhFhDp7GUWE6U48hYXY4XaMGjhpDnXyoMhHxSlb5e0H37ANPJTa/MH
 iw9BHAqWDNxXEJqwe9eKFB2cw4MbSRD+L7aSgu8d+yex1tsy2tg9jPrPSs1sHh5ME+mtljdmw1a
 XYsmdV6OZmNwvXzOPK9JfY9JYgwg==
X-Received: from plblc12.prod.google.com ([2002:a17:902:fa8c:b0:2ec:f981:3ba8])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f70b:b0:2e9:5598:d185
 with SMTP id d9443c01a7336-2ee0dcc9d2amr92153625ad.56.1794811327690; Sun, 15
 Nov 2026 22:42:07 -0800 (PST)
Date: Mon, 16 Nov 2026 06:42:05 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116064205.2360040-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] leapsec01: Keep STA_UNSYNC set to avoid corrupting
 the RTC
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test sets CLOCK_REALTIME to two seconds before the next UTC midnight
and then calls adjtimex(ADJ_STATUS) with STA_PLL, 0 and STA_INS. None of
these include STA_UNSYNC, so the kernel treats the clock as synchronized
by NTP and its "11 minute mode" (sync_hw_clock(), CONFIG_RTC_SYSTOHC=y
by default) copies the system time into the RTC shortly afterwards. The
RTC thus ends up with the fake time around 23:59:59.

The test restores CLOCK_REALTIME at the end, but nothing restores the
RTC, which is left up to a day ahead of the system time. Tests that run
later and compare the RTC with the system time, such as sys_rtc01, fail,
and the machine boots with a wrong time until the clock is synced again.

Set STA_UNSYNC in every ADJ_STATUS call. The kernel inserts the leap
second regardless of STA_UNSYNC, as second_overflow() only checks
STA_INS, so the test still exercises the hrtimer bug. adjtimex() now
returns TIME_ERROR instead of the leap second state, which only changes
the informational messages printed by the test.

Signed-off-by: Wake Liu <wakel@google.com>
---
Tested on QEMU (x86_64, 6.12 kernel with CONFIG_RTC_SYSTOHC=y) by
running leapsec01 followed by sys_rtc01:

  without the patch: rtc0 - system time = 75612s, sys_rtc01 TFAIL
  with the patch:    rtc0 - system time = 2s, sys_rtc01 TPASS, and the
                     kernel still logs "Clock: inserting leap second
                     23:59:60 UTC"

The remaining 2s come from the existing CLOCK_REALTIME restore in
run_leapsec(), which accounts neither for the time spent before the
clock is set nor for the inserted leap second.

We hit this on Android devices, where leapsec01 runs about ten minutes
before sys_rtc01.

 testcases/kernel/syscalls/clock_gettime/leapsec01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_gettime/leapsec01.c b/testcases/kernel/syscalls/clock_gettime/leapsec01.c
index a71e2adc6..2d175468b 100644
--- a/testcases/kernel/syscalls/clock_gettime/leapsec01.c
+++ b/testcases/kernel/syscalls/clock_gettime/leapsec01.c
@@ -79,6 +79,15 @@ static void adjtimex_status(struct timex *tx, int status)
 	int ret;
 	struct timespec now;
 
+	/*
+	 * Keep STA_UNSYNC set, otherwise the kernel considers the clock
+	 * synchronized and copies the system time, i.e. the fake time set by
+	 * this test, into the RTC (CONFIG_RTC_SYSTOHC). Nothing restores the
+	 * RTC afterwards. The leap second is inserted regardless of
+	 * STA_UNSYNC.
+	 */
+	status |= STA_UNSYNC;
+
 	tx->modes = ADJ_STATUS;
 	tx->status = status;
 	ret = adjtimex(tx);
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
