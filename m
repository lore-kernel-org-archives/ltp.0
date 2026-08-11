Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CA4C5CFCF
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786443678; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=DKd9I/PSbhMhvV6H4doFZGxlJHntto5QezSwnZE2OFY=;
 b=BzT7DD0g4FHQQvwYKt9LHNuGS7BtOcSB4J9w84Qsw2/oJkw5Z+phtJ2uh7kjQgMmhFtmV
 W98iXztCbzbkjz+sHzsioF5pmrkKNj3352AcPe1ppOJHEkMWnn7L9MKisxUXCSauvhLKcwz
 8gsIzPzqdW//UJOdY8AFVbbmS0E9Tos=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6BD33CF738
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 12:21:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B313CB9F4
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:20:59 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A6A06007A5
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 12:20:59 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1672467f8f.1
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 03:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786443658; x=1787048458; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SP0BLIN8mzgQBTRjg1+4WhSvO/xETyvcMwLnzseLhd4=;
 b=BO0sdErb+6Mq6seOOA0TaO+hGeRjRaBa/HeZnnjhfzSdzicQ4mAKI9yDU72mQdn2Yy
 2eHYv4reT9H51uyV3MBprmSgy4BAV+05iDsjvWqvrtuocH4k1HM8OrnsoFra17ipV3Sy
 ltbfqLN4+B0RLKB89YLBp4JCJIwCnV6mYFxQvlQzLtoynMl0bTO7vWa53zO5RJ3RN8Ic
 Qwp44X5uXoBgjsZDvB3O1r9t3SLBd9CbXhH4fD+sBfwVINMeGuCeHNGOtQfzf9pKecDu
 M+7c6kg+Dq9Tw205I/kfoDVYVJNnOoyF1T4EArvtOAT1RAIP69+F/sV/WgbelsiAkzBK
 IEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786443658; x=1787048458;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SP0BLIN8mzgQBTRjg1+4WhSvO/xETyvcMwLnzseLhd4=;
 b=FPY1PewZBEto6tDZeRgkZ1pOTVLhus7pZra9rCfhQI1cevyCCArPt6j9fGDG7OiA5s
 d7tOX32BFSPmLYRhJAQlzb4F4Fc5SVRb1vVuT6ajS+D1QVDtD9uPiotIcTrKEQYe73wi
 xG6lUum/2VZJx9b7spjaCsPV9Rrxhvrno0J1uuGkJ8jXXJRuHgxIPYmOSM3+W81AmVXv
 nNZq482MTezCZtzxXHPkf2bGB/KEkJ9904XmLyMOWWSgn5wvaIDYRE+WLN4u6TNigEq1
 mLeig5kRZDSFqJcJBhjYwk6dCrF1OK8TM9vPnanxjVjfKtLi+tc8/iNKMbd4krfMr6zj
 xNDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrnWXuW6yHj9j+zWMH8IFPb94VZjIjMccJBdq6fhdkS++sWZcuEE6D8B8oYNdnD1pyAg6Y=@lists.linux.it
X-Gm-Message-State: AOJu0YxDZf8qoqvd5uIC1oRL32wBxJl9j1Yxlr13xgn8U+gGAMretv37
 tthQoZMUVDqmIHDuID4ST3qJ7Cz8EcEQzDzVTXjYEYEvbGYU9SoXZZgwjnhgeWza9aE=
X-Gm-Gg: AR+sD119ooK7esLFo3zHxZU6Bgal2jqV2e7Irb5NNzDlwh7abb6HKBsdcO3qMidMCpX
 lM+BN7wV1nDg3IFUSrkvgw2yuZEeXTW4M2qidRUQi+Yu5hh7EwwKXJgsKTIdHZeOV7GMtvcBN/4
 cLLrCAfyughZAkBQCDnT4pwJhbSGXzk/V48UrMxGJyKBduDbnH3QfZSm+MytwQ4mrZ3CdbGyI1E
 KzIEROi+07+HyvAZ6Q4bmeuX3qexHzI+APBy2po6gP+etzi45JyfumY0I1xV5rGzsgwy3/eLx+Q
 YWFuiYbY/ViPUy1oyY5E2H2sGNRZGmQzAFRwpPUT0ZLyjWEt/1xaycTaVCsxsVJ9jDaPt1HtLXC
 ODx0Ajvb9NvBDIQoromnnoUiNtpkLHsuFyzcSvyBBpRuV6ai50qaK8qdFw5MQfxVsQTlsR5ShFN
 rorwKCbCLrLReRLcY+AVE/maj9KATlIzt+eMNh301dLKWIJi6CFMHHL8Ya+6GjGhDmvSqDAg==
X-Received: by 2002:a05:6000:470a:b0:481:4dcd:aefa with SMTP id
 ffacd0b85a97d-4814dcdaf17mr2220787f8f.6.1786443658463; 
 Tue, 11 Aug 2026 03:20:58 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a7097adsm3418090f8f.23.2026.08.11.03.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 03:20:58 -0700 (PDT)
Message-ID: <6a7af78a.df882948.2caf51.fc9a@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <anqQXb08RqRK-74w@linux.dev>
Date: Tue, 11 Aug 2026 10:20:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] shell: enable OOM protection by default
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Hi Andrea, Petr,
> 
> After looking into it more, now I slightly think doing OOM protection
> in the shell harness isn't worth it: the benefit doesn't justify the
> complexity. Forking the whole test body means dealing with cleanup and
> timer ownership across the fork, plus passing results back from the
> child, and all of that would need revalidating for every shell test
> that goes through tst_test.sh.
> 
> Given that only a few tests actually produce memory pressure, I'd
> rather keep it simple and handle it locally in those tests instead of
> touching the common harness. Something like a small helper the test
> can wrap the memory hungry workload with:
> 
>     tst_oom_run()
>     {
>         ( echo 0 > /proc/self/oom_score_adj; exec "$@" )
>     }
> 
> The harness (or the setup) protects itself with oom_score_adj -1000,
> and only the workload started via tst_oom_run stays killable.
> This keeps the harness alive to report results without forking the
> whole test body, and matches the C harness model where the worker is
> the unprotected part.
> 
> Does this direction make sense to you, or do you see a case that
> really needs the protection to be harness-wide?

I think you are right, perhaps these shell tests need to be rewritten in
C anyway. Most of them are unstable and fificult to maintain (like all
shell scripts anyway).

I can go back to my original idea of setting oom protection only
for specific tests.

>  
> > Suggested-by: Li Wang <liwang@redhat.com>
> 
> This email address is no longer in use :).

Ah damn.. :-D

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
