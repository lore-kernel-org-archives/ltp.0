Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C5FC2BD09
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 11:38:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 914983D3FC7
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 13:38:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD473C221F
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 13:37:48 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98F471000447
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 13:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719833865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=nD1egN6PJX5mhTjW6TYZbvYPn+YIzWET3UKmChIhSAw=;
 b=S2z0L3bsnw9EQTt8F/YA4yiJvxC0XWUHSkLdo3bPwbqcyc9Bj61Geg0BvTdfPK1Zp1TAry
 TDjaDQkx9I7p9biQFV+FcVe2pzKj6nUDisZ93WJQqUKF3ItB1NU70SNSYzfuXWm6HCVAvQ
 P/CvjAMtSnik5YFwufi7c0axChqFZko=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-GqPtCckjMB-yNa09n5Z3bA-1; Mon, 01 Jul 2024 07:37:43 -0400
X-MC-Unique: GqPtCckjMB-yNa09n5Z3bA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-6716094a865so1852786a12.0
 for <ltp@lists.linux.it>; Mon, 01 Jul 2024 04:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719833862; x=1720438662;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nD1egN6PJX5mhTjW6TYZbvYPn+YIzWET3UKmChIhSAw=;
 b=g51ItVsrxdV2RSwJDhJjDZwvSRb5RGiiJPshPxA0hor+teKK80EmjcdMfYZ2QQ5q0B
 3mcmFuLhWu7d41LU2hm9Tgz0XdT5IuShDlcRKd0wKVMMmp7t1f1XqLy0mmcdyBemPVfh
 gfKljuDSqqg36HCI7qFJvE4a2Jr67+52ROTQZBHBmyqOYO0r2YpKDSsWXRZwPeF+7TBu
 rBeAxZB38hFl4s3fkfA4kMdO0GA+X+j9T2hJ61Im/Q5y8Btq01OaMl0v63W2rBYxjAsc
 lS0ZDQSihjNDtRRSQf0Ask/Gh2xLGX23Yj9Hc2Zczo2iUNQ0pSWDmi+Q25fy8pZaooSS
 Qtbw==
X-Gm-Message-State: AOJu0YyjCQRAVqLZl/d7GvYX8sBhxEVIv2wES4MidD/Gq1KWpoDSLJWL
 bSYQO1+ug4M2d6ChUbzgcI3xypWze0uGgsrZo/54fR9o/ncRuoZ7nUBBO34rGcnHb+TyoqH0vQD
 qEXBTKM+ntFYpbj63P28AJx0W+p4ftwKD69/AkGmovmMcgqz+TiLEK4Emzu8AUGGj64wDvkwuIa
 0z96AuCcJVsC0S/sp+VxhclAcHyDTO8/n6FxuB
X-Received: by 2002:a05:6a20:7489:b0:1bd:2aa5:f177 with SMTP id
 adf61e73a8af0-1bef611aa11mr4998405637.11.1719833862000; 
 Mon, 01 Jul 2024 04:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhThExz+ef1O4ptiHbcKDYTEX/70ktKTHzOVew6VieRjSit1X4I5Fs3IyXHRF+xn107OeNBc/dRGGMvXwmmKo=
X-Received: by 2002:a05:6a20:7489:b0:1bd:2aa5:f177 with SMTP id
 adf61e73a8af0-1bef611aa11mr4998388637.11.1719833861645; Mon, 01 Jul 2024
 04:37:41 -0700 (PDT)
MIME-Version: 1.0
From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Jul 2024 19:37:30 +0800
Message-ID: <CAEemH2cDCEW_akeKDECceW_5+B1z+Vw0gpRiC-upePn3tPauLQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] perf_event_open03.c:95: TFAIL: Likely kernel memory leak
 detected
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, All,

Our automatic jobs keep throwing thus false positives on the daily test.
After checking perf_event_open03.c, it uses the diff of MemAvailable as the
final condition for memory leaks.

    perf_event_open03.c:95: TFAIL: Likely kernel memory leak detected

I think relying solely on the MemAvailable metric to detect a memory leak
can be imprecise, because available memory can be influenced by various
factors unrelated to the specific code being tested.

And "/sys/kernel/debug/kmemleak" maybe a good tool for diagnosing memory
leak,
but it is usually disabled on the stock kernel by default, so far I have no
better idea
how to improve that, any suggestions?


    diff = SAFE_READ_MEMINFO("MemAvailable:");

    /* leak about 100MB of RAM */
    for (i = 0; i < iterations; i++) {
        ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
        check_progress(i);
    }

    diff -= SAFE_READ_MEMINFO("MemAvailable:");

    if (diff > 50 * 1024)
        tst_res(TFAIL, "Likely kernel memory leak detected");
    ...


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
