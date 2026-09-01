Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4227C61DD6
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 07:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788248303; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=9c9Zmfq3DfUfmw0aNfhdYqC3DHVrxcmCQo+c33kiVww=;
 b=fHWP90Wuq/Gt648ZeAN30eBv7wWf4MNYaod5gV27872ixtkp5CC8DSRgco1dRgatXc+Y1
 3K7s6VcwgVhXR9BpgcPbZGvSlVppG9fhloiUrvE33liv6yClUQg2vCR6yZoGXjEXsmg987R
 U6MhGoMkYtbFiB6muGOtoX1hBpZ8fRI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D820D3E96AF
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 09:38:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D2213E9428
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 09:38:03 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB4AA60005A
 for <ltp@lists.linux.it>; Tue,  1 Sep 2026 09:38:02 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so911043f8f.2
 for <ltp@lists.linux.it>; Tue, 01 Sep 2026 00:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788248282; x=1788853082; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uuC4Ykg5gQjP6/+pSjOnnVh8fh+4anYXvZY+tBM5j48=;
 b=gKct8tMQ/bL6OhFT5goQhouSMsqmPcdxzXn+FswERk/JWbcBYt8w7txd0RQafKOIEr
 odV2r8lFsY/5ZKf7YYhUpWh263JfRRyBZIapwpWwST9uiPSYAY/upacwclb5xr3OqBuk
 1NIW8wuO7FbnPQ7V6BLhOFsKnjD386j8lGAUd8VwxADTurwN3DAJEGXEhQm/gEWpUh7P
 dTbbKBgzkqcwoFRrk6G3/DrOHyf5HX6G3i0QabIeNmvMofFLjgB3UFLHk+1poQbpynQg
 EmoYiP+KmDyAjpMqrDSMgxit9RHZvxSfdNB1860vg466QlLkCssjKT4YJSLI6sxajQco
 Yp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788248282; x=1788853082;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uuC4Ykg5gQjP6/+pSjOnnVh8fh+4anYXvZY+tBM5j48=;
 b=WHB5K1pl4ZuwuN9vZejgOui85mojoKdt9BZ55nciJs1CoIzE2HA8GdOtL1mK0blxWW
 e+DIQ6rZJOabEW4tUCmG7iPEvzyvLW87jGYnVV1K2/O2ciCNfcpO+5BAll6hc610acKg
 oJHn0xbA0G52CL3JO0KNI83CNh+j1AEaAX01Sf4q8eXRaFuj9TY17e9GJw5nfoJfIEtP
 bHj2Gi5IThQFF/9It9pWRDg+1MObIH8hN9Sp6cb/fBGTwcqy0kQGg/iSyJ/XwU0M6XlV
 32iI9vWvOA0uOovJGmvwqQwDEq4aCtxaXpG8o/pxUxFB1QVXHytV5p7YN4ZVgVDJYqf2
 CCkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6Rn7k3JzzgD1UiSSGnygKx9ARD/pEIZIlpOkcC78wAdDDCBRFMFJGF/0LvQWlQVMrbgs=@lists.linux.it
X-Gm-Message-State: AFuF++nta0f665Xf59kVvI/MCDJd6cBBaD9NG/sNHYGLVt3R4jYV2l0P
 onIcwaZiLukUz6YG11ZLBcz9+qB6eUWICWvyfPBCKsN8aV+5p+tY0IR68f0cKKv97Xo=
X-Gm-Gg: AYBFou25P7S5NSQLQ/Bkp87th6sOZq/YWTTU28xjLg9TZ7Tzc32152Zw2gjrIK5RTsn
 yzDtBX0EPwKZQIaFlX/cPxFIGoxAOPIIB7LY1FZAIkeAXc2/pG+jJjnOZSvhU0PcGmEI/Hg0sUD
 2m8KQxnpJtF0Ht/8GXG7w/DEqhsqHcHCeuklPca9mGmiUSkoK+WlpKM3dO83gyJyXG8g5JKvF7o
 7qhbHrk+jTKBOqaDWgP6PpfG537xfA3iWNqM66FkEBxE1nbNBDZUHi1lg7LK4UHEUfwv5mFlvan
 aAju/7BiDKYkmljdjcAzoPKxolgU2hzEwJo2AmTSz840iZ+EQpzXXQCPe84DpBRVa/YxE5YLkH5
 CaViGC21HST7H9OQjrKRGogVFmIiPJUK7n3nvva3TIsx1VMyxMdYZyOSb8oSQ33fGQvv3Q4iUeZ
 lCbrW1MMKeUwyN6vxR6lELrtmTImVoMiqn1mdToh51fJawa2De7VqiBNJZknFCidn1vhUdd5rfC
 4okEVb3Ds/Eymptw/jweqlWRGvWiKGcqe9+4J2SX98BtFDOBt8QHdcR0eTcZ9MAP+un0/Y=
X-Received: by 2002:a05:6000:4698:b0:482:e2ea:7ff6 with SMTP id
 ffacd0b85a97d-48440fcee0fmr9174305f8f.4.1788248282104; 
 Tue, 01 Sep 2026 00:38:02 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6e9cfsm3243745f8f.22.2026.09.01.00.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 00:38:01 -0700 (PDT)
Message-ID: <6a9680d9.9099b29d.2c53c3.ca0e@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <apYysdNBmxPxyn3z@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 01 Sep 2026 07:38:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> > Something as:
> > 
> > diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > index 4e6023399..2c0c6fb02 100644
> > --- a/testcases/kernel/mem/mmapstress/mmapstress06.c
> > +++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
> > @@ -59,8 +59,9 @@ static void run_test(void)
> >  
> >                 for (size_t i = 0; i < map_size; i += page_size) {
> >                         mmapaddr[i] = 'a';
> > -                       if ((i % (2 * 1024 * 1024)) == 0)
> > -                               usleep(1000);
> > +
> > +                       if (i >= mem_limit && !(i % (2 * 1024 * 1024)))
> > +                               usleep(100000);
> >                 }
> > 
> > The testrun increses to 6s from 1s but it makes the OOM very unlikely to
> > happen.
> Thanks for your suggestion.
> I have tested above solution in our openqa setup but still encounter failure, 3 test cases
> still failure with oom after run 100 cases. Maybe slow down dirty loop
> is still too late?

I still believe there's no way to avoid this, unless we re-implement the
OOM-killer or memory.reclaim mechanism increasing the amount of attempts
per request. We will always encounter hardware that is too slow that
won't swap memory fast enough for the test.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
