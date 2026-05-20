Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC61CD4F3D
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779288196; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=apy/l1RXlzJuaE8x/aR/8391uIfcA4IXIrGLiLW7Khw=;
 b=kd69c1dLEpxgxFpcGNT7RmPlenQmnjaBJFKRlStjcs34LPoN7K/CfGiwPK7eWBT0KQ1ec
 qvjWXu52WuERux0Fq5pgLsRa5d/CBsMu1Gj+cOfJe7icED2bK7teNgLbf41BfTM8D5HnNsa
 985x0/IswRQmmgT4/rnbaNBLhmm0tCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCD6E3C737E
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 16:43:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B62C73C71BF
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:42:52 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28376601BCA
 for <ltp@lists.linux.it>; Wed, 20 May 2026 16:42:52 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso37401425e9.1
 for <ltp@lists.linux.it>; Wed, 20 May 2026 07:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779288171; x=1779892971; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nqvXPsRYGSY85VoLf7m0tN8NleZ6D2A0QzEFb1IkAng=;
 b=VFA7/o0SdXrVVZgsF1y07G2zS/NEEjCIXvPm3AVniQcAAym6KQ4V3n5N2wDWkDxnj4
 8BSpygfGdCDb3wi261zOjAUAJcHoZLekkK/XQkR9+U7HJkwb7kFR4x85HFnuBw02wp67
 xuuqpmD4KJ53RSq1zOu3WE8RW1FIUyuqRu1dOdVVOIy/WqwcbfVTIHKbs97d3X3u5dLA
 dXHLNCQCxIWIrXE3ubjYQAqK+FfAQOkwR2u1LYrHrrzOKmUS68EC2QsvsgCJ+HnCpofu
 THKNVzLG6KD0No3NVpSH/ygirfua09ldGG3TYRx3mSIc2Phr9Udgn1tG8CkaYomIWF96
 5w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288171; x=1779892971;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqvXPsRYGSY85VoLf7m0tN8NleZ6D2A0QzEFb1IkAng=;
 b=qzmC9HWXjxF2SI7Rle8a/59ud18cf0p4k4cbrPrKy1BT+KycP98Rrw0yh1y7T/kyLd
 1VbJUpJiwwow7146oZBJ9Gblz2ZDq5yepqQmcTiCIEd4UKIrUkcnHFeRraIU8UD/7D8N
 jWBaQma7AikAmESTMA/m1enpbi5GvhpIOXcB77eWqq4RyRE7YIyq76clP8Ir0ertQDOY
 Q2RL2KHP9IeujDIFTdmYNHUOGtw3cTwxPf7dn6GILLlSLuXZPREBhSjMrI8pfTaZzTIc
 WQ2EKmiUvIp7ouzYViVnaJhIhRa3MBe7tAZx1412kvwBZ8bn89zzKqQb/URqElXSKtKz
 uF0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mHwUHtYN6UBPc97n8N5A5Z7F0glMf3CMj1caGITNZ69oNhuCgs2hHyKZZws7MwhFLlLc=@lists.linux.it
X-Gm-Message-State: AOJu0YzHNLoDAZbfDQwRcDt0wtsfRsrPC2wvdYp3SxJ/XYjSjViB2zhv
 Pue+PT5iWgRXd1T5fTwgThTes2hjEK6CTmg0PZXRndr68iis05B1Ds/bYSmY6WQ0pms=
X-Gm-Gg: Acq92OHrCnnKxlIMpBBcrRLUfLB7+5YGSr5ra93fcFhS9fP/MLaHxF64E+2NDL1SPpk
 cmPoZHqyaVyRq2J2VYmOyCUevaiJAl9H8OcPm53Vy3zHBuSN8Dl/sAj0DUPr+gQNygJyz3i8rvH
 WElK4R9wnxRBQmKd+eXpactOvyNcv2/i0S+/9zW+oXFS69+t+sLvXpik2/yZwRLinZ//CQP/3Bs
 axPdYEg7yU4breImD6u5QR7GCoBjcIGODPY8YIAQa3xvTDo0UxrxlbUbgwvjEwNOpHUszCEcyjR
 NA04Ka5tx6BRZEi9XYpbQpjgazzbNxc/1JROeufChGTRvyfvp7Oz186dRGRLmregKrF62sV/Trj
 ylaHOzHRPgwc2M2ZvtE7HsiiJvaJzoeHhyumaCtLMv0MZZazqkoZvkk4Sd6o52MKWNbG/kmJxBJ
 oNXyxT7tW89ZOsUyIb7srImTaQQzRo4QbQBcqTVdvZEqGKli0WGJJGby66v6wGkA==
X-Received: by 2002:a05:600d:8:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48fe6325213mr310143695e9.22.1779288171502; 
 Wed, 20 May 2026 07:42:51 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe60fc0sm156956075e9.21.2026.05.20.07.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:42:51 -0700 (PDT)
Message-ID: <6a0dc86b.8ad23161.248f65.9428@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <a17d2c76-3b48-480a-bf2b-39fa49cbf952@suse.cz>
Date: Wed, 20 May 2026 14:42:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sockets/xfrm03: Add skb_segment SKBFL_SHARED_FRAG
 stripping test
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> I've tried to simplify the namespace setup but I haven't found a usable 
> kernel build where I could verify that the reproducer still fails even 
> though esp6 variant of Fragnesia is already fixed. I can only find 
> kernels where both CVE variants are fixed or present. We should revisit 
> this after Labs conf.

yes, I was able to reproduce this bug on tumbleweed only. Let's talk
about the Labs conference.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
