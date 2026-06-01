Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F371CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780296746; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Vkv3zPPEknA9CGyQoowOv2IIjXP2qhnZS0M2zt8TJnE=;
 b=a0PiyftnQ1g/cii3z9IDAzn+mrTl5wBg2Fru+n2I19wqfIsIaPZrYhXPMTTT+3yX9qF76
 Z2LiAfp7VJK81+McGxMfJSPkGFZEFYHsnOUPzAQ+QBfVE1UnR2tglnQpPMz4F9DmNoM2ckS
 ePNVL1/EuVqP7QMEJeGUjn4JqDk/lkU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D97303E483B
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:52:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02C1C3E483B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:52:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 398EF1400B9D
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:52:04 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso2666415e9.3
 for <ltp@lists.linux.it>; Sun, 31 May 2026 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780296723; x=1780901523; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=uZn4WCpR9Yf5P6MSpWr5F1/tLJ9iI2mhCbqPWa9gojg=;
 b=TZPPj+tx2X8fBc9Y1RkHaJIL+Ko4U2QY53rkLzsERFCVEdMbG64mDZC4qRpl0FMquy
 froSRdxa9dn6VH63SJ5jq8tHow/FFH7qUbaKHxAx9f8S5c2uUUeW6fyQ8sGNK4eoUtFw
 4PP7TuzGi9qMZ/iRiR+tN9jBWZ143155pBuhiT2ho9NXOhHDTNP9j7eHCmXp/Ubn8Qdj
 P2RaJi84FXjTIV7zhzOSc8VotnAuhm2tf4B3d5alJ22gSpeaGC69mXMy/25rvs0LhFsa
 qyWFWPuewgxV1wc8HbGs/dHg3a3p0mGG+wb+gbZbH+F2pwTns/YuOTSMdrKo38Kh9PYW
 JZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780296723; x=1780901523;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZn4WCpR9Yf5P6MSpWr5F1/tLJ9iI2mhCbqPWa9gojg=;
 b=DsCTvJZruNVYvjIw080HvAzCErjz8pTv/JkcWM0qfZ/jjw56nwP8qvlsRtod5/hJvT
 HQJ8n6n1lx3Gu3Q34KOljLGpnt1QrqF7x6Xj1vxv7plD261930wkQ6gmBf159Wmh+Yoh
 Aeti1f0FIHpqY6BwR5JahtQiJD5Ivo0ky32w6m1w9CvIYrhy9PicmYHGW07nviospw/J
 UybGqnAdrS9uLT17B1n3NyCNQRhcfhPlJoPUfSmep09a/WlZ1kHX046Qjkdw5bjXxTDK
 UVtYoLMxvEn6Nc81cdBD4OyqsPp/oOrfq4CV3HvUYSNHWoaMCANjElSbARCxiiZs3FWx
 57xA==
X-Gm-Message-State: AOJu0Yy4mzFRFJKgvK6bFW80oYJRnVhy4obPikURz7DvjgB4t0/6UYD0
 BFTx+5GT4TGHsgrsC6Glp0SkVOwdioeJPfLfYHV04zjHAtxeAYj/3rFPizEsR5i1rwA=
X-Gm-Gg: Acq92OFawMGJLnaD8Hwhj3u6B8HPLgk6wVKIVHzTcvoD6RXrwwl8PCgYk0cf1TnQtel
 i5mAH1jd0KKe/PMnmmgzoFv7MxiA6xKCihDNyyXtXnSdP1gZUIrUVbmCCFA3G7LEdbn0smNIRqf
 eaelN5zRccGlJnrR9ZxhX9L6c4RhzEup83Z7DRO32OTVzp+DKSqNMhlnjZQRyGdHQxdpTVBX6G0
 D6zz5C5Ox1TQ2L7hT9DjfuFD3Cnoxod/FWKL8Y02BG9D1mihkJUci7dqAhPnkKDL7ecALR/kArQ
 OhY95XOC7KGddK94o7CJkGsM3FbDO9MP1qoCwPnTD6rP2a5sYKQLnj1WYy94L6bfWz1J4w0XLB/
 4awArBigyxSZQtfJou2+W+7wAr5KhcqvspPWrkqhvxzNyv+fbyhZc4C4jwHOrCl2IVXBcMIuAHT
 QlXI6VN5S03aiYo0Kul407Iiw1rb+75hZUEyECgsr4L7WdRUYEXbYCr+l3pcILa4uDnfW0tbSdS
 V0Eiay4JIWnlYbN/9LmNGZX3aPeSsYH0aYIwCvxGr7qQWglc8eWEEwU
X-Received: by 2002:a05:600c:6209:b0:490:add9:7f88 with SMTP id
 5b1f17b1804b1-490add98007mr13334295e9.21.1780296723563; 
 Sun, 31 May 2026 23:52:03 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4a8800d2346cb1fd1859e6.dip0.t-ipconnect.de.
 [2003:ef:2f4a:8800:d234:6cb1:fd18:59e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ae24427asm3414235e9.6.2026.05.31.23.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 23:52:03 -0700 (PDT)
Message-ID: <6a1d2c13.27cc1087.221ac7.5bf6@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <341cd021-1121-42e8-92ae-292f0d895ade@suse.cz>
Date: Mon, 01 Jun 2026 06:52:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/xfrm.h: Include system XFRM header and force kernel
 IPv6 definition
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
Cc: LTP List <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

thanks for checking. The CI is also not building on alpine, so I
will move this patch-set to change requested.

https://github.com/linux-test-project/ltp/actions/runs/26509749446/job/78071109354

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
