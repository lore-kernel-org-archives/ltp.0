Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE09F34C49
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 12:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776084967; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=OpHqOQ3axw8THldOoYRxxsy2C70zxa2GIB0Y5hYN8ro=;
 b=R1pNAqbteLlcJsjvyugOy/BUXSUIJY3fWcOWyAf0OT4yocO3ZEYwDQqOZvMOdDkrY5VsI
 xSXrTY5pqiy3gV62nPFAHCdMG1nnZ+PO89dz8JG5KFChelm4WUud+U0phfODE8LPFTzLSzy
 pbqADiwY1x/hUWMMIlFDlLz0YoUGIEU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE9C53E2E12
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 14:56:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC5483E298E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 14:55:43 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A316140096C
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 14:55:43 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso41604945e9.3
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 05:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776084942; x=1776689742; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:to:from:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qB2NgzEvBAD+19i5I3fiiyeSk1qMY+xCXiMd0JeXCTw=;
 b=OTFK++iH0ftli9OZEdW71s22Vh2G2CPrYvQt7Mlze+a4bc9OW1Z+53e0yo6B0NX1I/
 /8TTEZWx0t9aVHmOIYLFhT+umI5eHjB0mCwM7mslSoUZzgMqtJUsOLxPNZhqBxaIy0KQ
 It78o+FlsVKl5ph85TOdN0xL9PiSh82FLCwr11eeWv5woL6ioD2ufuXsys1R06qm2bRl
 70/hfetLuSwOcyzMwlCiqx3xiUVbqT+dCFSuDV6LVDe4ta842G2LyA+E3SrpGlglcfEt
 zDU0hNmtkoL7FmhvwLXIHYbxwr5t4uBSGho5ly43LF8pUckTFkxQHtHHDFlSCLGK2F6i
 alfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776084942; x=1776689742;
 h=date:content-transfer-encoding:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qB2NgzEvBAD+19i5I3fiiyeSk1qMY+xCXiMd0JeXCTw=;
 b=pHe+8tKSRnsTHF5W47/TsQpCh/H3/EtMrlIPhxW83MXBVLkGvB5hKDRjl1WePihuTW
 oeMAiAQj+YVonu4Hqc3ZWJ0vW5JLiaZK6nF+plwUuoB1bzRZBQDKEtZo9qPfUMRyjRQd
 5YFxsUbRrRhbocGwL9ZSJtId3ZD8B6GlCLUw51u7I1OFYz0UIfv9HQX8+hHSwWDEh4mD
 c/+++Y+xQF5rAxw4kb4JAdsdhrmeQPbilbl2/mhKuVSNQRfjlvGlbi4EbLGjJ38DF+x2
 FWObUDzu1GFQKMFBmFG2iEH9h0YZY369K9RVQeZBA7/TwgnVOb2apwr3sDDAYOTKVCxU
 NJfQ==
X-Gm-Message-State: AOJu0YwhoRBk8rkM1E/DQIQFZer7yAb6ilnC9cH1Rqt0gMbWvtR2OSom
 66zqMGUjXG0kohssweF9WyydrFj+OyBLXoFm6dFY8KMB6H6BJxkTayeK9BGYONnsPzsDoo7LWN3
 9OBazxlVHQA==
X-Gm-Gg: AeBDiesmxnslVZ0nLERg4E8rzEraR7Wecqs2LlQSubEgE2VVPL6lGDU5d4eEus4oTC4
 55pjmWK0i4qn2bVP0TxV81imTdvp/lrXL4NwuuHjVm/OHjxCsJLi1ewbAN67uO9cKLvbEplFG5D
 YZYQO97dBhc9LqvJb5x3M+cNd/UF5w8BtWyc+6GfOSrH6mFVmIi5ZAYXihlaEkAUhFU8mGu3pJ0
 fBu830x3SmpCyGiZQuprPtZTMp/rWzP8+9dFu5MV00aupMF6Hw6xgqv1/n5/Jdrdw1R63xdT5UV
 Xqo+QX+N3nxGF4HNpj7Yc7eDk3ygUz8lfPMV6/hxMaXIov8Oi+fkAd2t2ANbBbWHlvMCbFFmTbc
 jsAQ74iVguBdT9yufRPAlYa+4oL2H6DbUUEsI6HxJpv022ZtCJo2vonMJEmcI2+nAi10grQCMTZ
 RzzvPWlXPyhC/ylIMyQEgdKnEkzIl2JOfHLHuMTWv1
X-Received: by 2002:a05:600c:c091:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488d683662cmr127601785e9.19.1776084942204; 
 Mon, 13 Apr 2026 05:55:42 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5888acbsm344854785e9.1.2026.04.13.05.55.41
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 05:55:41 -0700 (PDT)
Message-ID: <69dce7cd.050a0220.18678b.446a@mx.google.com>
To: "LTP Mailing List" <ltp@lists.linux.it>
Date: Mon, 13 Apr 2026 12:55:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] AI review agent
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Everyone,

it has been a long journey, but we can happily announce that our
AI review agent is up and running.

This is something new also for us. We worked hard in the past years
to keep the quality of tests as high as possible with a tiny team of
~4 people actively reviewing patches.

And despite the number of patches per day, which is still around 10
per day, the amount of work kept increasing. Everyone has a job,
private life and sometimes it's hard to keep up reviewing kernel
tests.

For this reason, we started to explore the possibility of using LLMs
for reviewing LTP patches, ending up with an agent that was good
enough to review most of the common errors and reducing workload on
maintainers shoulders.

Hopefully, this will help developers to write high quality patches,
without feeling left behind in the review process that might be
slow sometimes.

There are still improvements to be made, but the reviews are pretty
good at the moment, with a minimum amount of hallucinations.

You can find the source code of the agent at the following link:

https://github.com/acerv/ltp-agent

Best Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
