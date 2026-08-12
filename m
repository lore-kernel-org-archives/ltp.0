Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84767C5AD5A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 11:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786533215; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=30TYNc7fI+wsdROhEAQV5Bx0/pPcME6DfHzI4HvifkA=;
 b=f1dyA7ajnFz2t7QA9JXA+PUoWhU/3lwy9xYeIdf7mVWzQg+ZGNxyE8ra18jsH1dwmTPuP
 SKl80jRAmuqGlJFlyzjIRHOLyh13lm4wfgf/SLwmsywUfIp6TjQSMYLjAnqrGtuxBSmTlHw
 agUUCbwLVvzJn1CU0vWIA5eEqi8dm+o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8A563E6CBD
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:13:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82E663E2104
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:13:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE4BC60054E
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:13:15 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so7242955e9.0
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786533195; x=1787137995; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3xlThE6C1BbErq9gaHSTZZfjwqALAUrk7P5xwfhRuds=;
 b=To5wxCl76aaRhq1osgAewez9Gv3cElGoK5jsPlm0Ac+zwxAI5mB2VmiY6mTNlbPy/f
 aNNbf9/lnadr26t7LiWNyeVOnBbdYd1NDF/Pt93xA3TJnKTq3XILRbOdsUmftdFofKQY
 olog3vg92rwXUIk86KYxcWxvW7zbH4M65+Y+5do/kJSraek6x0jMKY+q6S36lkz6ZFGX
 fEkSIGviYjC8eXkQcH7F0YrNrgF7CQIebVw6hyKtN9/PzTdVY1OcV2/DXIW7Jn8xvMW9
 y/YqV5pfLGaDWCvq0plztzvucVvJkdJnD3jD5f5pkrTuNGvFTEh3vNRAxf8D3EBflu7z
 8tJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786533195; x=1787137995;
 h=content-transfer-encoding:content-type:in-reply-to:from:cc
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3xlThE6C1BbErq9gaHSTZZfjwqALAUrk7P5xwfhRuds=;
 b=kqikhNGx9K7MLjZfqnr7iC2beQqOQEI09mnalbs1SwY/Kv6w5FboODAeZsAX7wWGdc
 AEfnfJ6srBaN0OtqQpWggYMkmvaJfVZsko5FhDSchZUGEFXN3s8XFjshZ/RBe+ED0dDB
 J55q6D5RU7H1nB7W+VweqkUTNNxyjTjj3VtUtcYSkOItsTwe5/ctT2SSaZHtkB3m9d4y
 0/Y/RBSrSTSlwDxSjQTyGIt/FAbulNe9oo+u3aRgZ9OOIx2PC08DrnbAlCzXtlXACaK4
 lhzECu5CIGiAPVbSgxTooJ3Gx50IJ6rfiKuG4ZwfvtRbf5SMJb9CwI8VPMjI+tqVn9gR
 Z7sA==
X-Gm-Message-State: AOJu0YygDQQU2Rh/dD2XF1qJUpuvY5bXcVSxhCDuLcT8l+heutfdU/x6
 RFiPEDMOjzC8m5hJ/a1/3X+YFj5Kh8II5uo9e2SurKyCNOF2atUdvK6gqzlqfm+uNfE=
X-Gm-Gg: AR+sD13lVdTxATobNL2viPrVvbTt9WwsBBCTz4kbJy6reeATf6+C7mpn2RVKn+RpFXl
 soEj9bWKiHZUNuDtY7nQkGcslZyTtrKQdw8wy0WEx+OgEwhnORGsFRSkL8QF8DFA6cDbDqPr067
 JQGvaclfo5j8rfMKbHezzcEG8Fu1EOTbQYIzC2w/gXGJvEIbSbe1n64gdLSxKsvl4BDZ4Esra+E
 atdKpj6A64sSFuhJoRnDPIbL490OXPy3wVU7OEPV2vSVupcU1pM21xziQ2trEAZ4WmJUroB9+yv
 7yNgOjayRv2AgHMTI0IzGQ9hKE3NDyUjlVM+Gh7rsGvRhuOeA1u9cPXtvua9uHfqLcb9Kagj25f
 jvQgvAx4K/elYjIUDpeWLlKi77kIVcMPKM7ykbQLh6dlyTMD0kvHdVTusZL+5AXWNBtow8njnSy
 NO76M6TDtqR81GWU3TitKsmh2VcEOyu1lTAzcfhEwvNzENHDgxnOlDrm47IEpdOTAb+Zsh+Ohq7
 rnBTQ==
X-Received: by 2002:a05:600c:6a84:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-4997c0f0529mr38142475e9.1.1786533195227; 
 Wed, 12 Aug 2026 04:13:15 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa5d04sm61843435e9.2.2026.08.12.04.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 04:13:14 -0700 (PDT)
Message-ID: <c41e20c9-86c2-43ae-8264-04434ee54f62@suse.com>
Date: Wed, 12 Aug 2026 13:13:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wake Liu <wakel@google.com>, Li Wang <li.wang@linux.dev>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260807110541.8702-1-linuxtestproject.agent@gmail.com>
 <20260807234935.3248935-1-wakel@google.com>
Content-Language: en-US
In-Reply-To: <20260807234935.3248935-1-wakel@google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] lib: Use backoff polling to wait for loop
 device nodes
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,


d90d2004657b ("lib: Use backoff polling to wait for loop
   device nodes")

This patch introduces a regression in few old API based tests which
call tst_acquire_device() -> tst_find_free_loopdev()/tst_attach_device()):

     - linkat02
     - mknodat02
     - rename11
     - renameat01
     - umount2_01

these fail with
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
linkat02    1  TBROK  :  tst_sig.c:232: unexpected signal SIGCHLD(17) 
received (pid = 122504).
linkat02    2  TBROK  :  Remaining cases broken

which comes from def_handler(int sig) in lib/tst_sig.c

The old API treats SIGCHLD as fatal, which is now being generated while
reading the kconfig file. So we need to address this until we convert
these tests to new API, maybe by intentionally avoiding
TST_RETRY_FN_EXP_BACKOFF()/tst_multiply_timeout() for now.


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
