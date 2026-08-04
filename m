Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0506EC55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785849157; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=NsagkOn+XsI0+wE1aJZFcm2NNZySEdBXPeokTJRwYwc=;
 b=OsDjPcSR0zTsgNVqQen7A7LTludObmVkkpAuPQD1vqR2rasL4UBM/xbxUl5qyqil5C4aQ
 wDWFlG2to9DwmOCeSDvFB8xxkuNmAWteDmDpM0O402PPxIwwvLsi6sH/YhJewqPbks4aYKJ
 VuKbelW1c/4TshFmGBdKfnkmFRM4BWI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3E623E7188
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:12:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E8DB3CC870
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:12:18 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0041F600060
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:12:17 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2774860f8f.0
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 06:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785849137; x=1786453937; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=epx9vCawovgE+pNwE4vCOHUiWSfpDuTVRZs/0mARrCg=;
 b=ZfPDi4XXsZxk2054UAOYfZF6eoPEN6IPph70yCrBb56clPgDuk2jeipUzSdH7s7myz
 PRkww4xVBGBqDUC5T2L/v1u9D7kotL19De2063QzkjJKNYS8N8ybUwlO6IZJujL6Auux
 7QqWDjXEZ6cAYpTBa0WIZ/6EK0GhC8lKNJ5Pt2fu3esqX5frSdJHGjOMzRMJKFXDp01d
 pcnF+Ib396mxjq1NoiC9r5+dduhlhPWTN9HYcc+Verake3ElEgdTL96nE//ioiO6NY4M
 rvmJuZKiI4aMOLTX9L7evmuip+P3gvCSW30lIOJMFPEH4CdlLCmCzkWAL14udVxa4yQi
 asvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785849137; x=1786453937;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=epx9vCawovgE+pNwE4vCOHUiWSfpDuTVRZs/0mARrCg=;
 b=d6xuSS57QTSXE/0UGxYny+SHYMwc/QIiCDqlHgN9oLKH71MJLwo2lL6u7oHqRI3ro9
 9P3dqsM7EA1aSJV04r8fytFL+IgMNx2Afqkp88GjHr/bm71LXCtP65/jDX5iRwQyhSR6
 yJjyXx48E5OL1Yj061gP54rpD4FkWM7qTuuTF8dA5Y0B6UMbTPYG36fBxmw+5pi2hVtn
 DOEh5qEnDYFd8Hip581NWawiNIvhpLFJuAOfUG9ATldS9diA45giCIEDo6GYPPaK5O9r
 T6vHcQMnDK+kkNJxZ0lBYpJx/MnzfuvapIimL6ba6GXLonj6pm83ZsFX495pGrR34IDh
 J+Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RquEjSPNXWm/y9Yqi0Gh14FbhSRDs679R0POafcwz25ydZoIiAVIm39ePWXyERpjQ9Jj0g=@lists.linux.it
X-Gm-Message-State: AOJu0Yzx7Khsm5NOnMTFEzTKntn+s2ILcV+u56NIaLD6LnbWk/9tUHIR
 WLBrrC8rXAbiPNLEDKRUAdit0+lTfxtG0HffzAzr1pnlp8tJRascA2/0hwzhPI7eiZhwdQKcp+3
 JNu5Rt1A=
X-Gm-Gg: AR+sD12l7GH6zz0CP3AYdX//KBmhOogfmC3ABr/sblO27rE1wEbm7nrJIrS1HsD1+NK
 DsQQWqZHflhiKxugZI15dSTGxchHIFRmui12qXptKJhQ2PYJ75pqpfC/apu17DSMFjDnwbv6zDH
 rR1ZN1FShD14FpGoo3fJMzDCWy/b6ehJfGfnpzX/Axti+Fc5FG77IvPxx+c7hGKxmiE8GbzHz8L
 vbaYJSgvX5mi+DNOPP+NB0RrkEmtmV4mGsEGwMX7CICH9e2OApI1J6f3LRXs5IX/kxdUxVEClBn
 AY6WfeEueuJY51zBXLf0hagVg3ZUd5gHJbb7UKxLKetnPFbFoQspgVQZQkVpTL34ZJG8oNB8jxC
 H50Tf078UFOYTIxdiVkfnESsDVXCEkQGlTcamBZjRWePABZeFBgS36/sSBjEcCeAluhKRmt43v9
 gmEaHC6qpvtZKBVsLp422iBcKInXsUs0jodzRRP3hEl9rFxNe5xrzTUXNbKEJM+zZMi22c0LpHb
 ljJ8nzlN0H/gUQLCOZMDTun+nwC1TMAasVN8x89sLD4KsaSZiHyH1dviGG6BQQceyu6hA6QgNO3
 ggaqOkyF1yXs9a8/3w3EQs3qRzK/z7zEvwYVlQ==
X-Received: by 2002:a5d:6f0c:0:b0:47f:9096:3ef8 with SMTP id
 ffacd0b85a97d-47fd9cedfeamr36968653f8f.10.1785849137418; 
 Tue, 04 Aug 2026 06:12:17 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm40623928f8f.29.2026.08.04.06.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:12:16 -0700 (PDT)
Message-ID: <6a71e530.159d33f9.a396c.0aff@mx.google.com>
To: "Tang Yizhou" <tangyeechou@gmail.com>
In-Reply-To: <77cf7e28-c8a4-4017-9ca7-425739d7378f@gmail.com>
Date: Tue, 04 Aug 2026 13:12:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Revert "tpci: unbind driver in test_assign_resources()"
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
Cc: linuxtestproject.agent@gmail.com, ltp@lists.linux.it,
 Hongtao Zhang <zhanghongtao35@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tang,

> On 30/7/26 4:53 pm, Cyril Hrubis wrote:
> > Hi!
> >>> We recently confirmed this commit does cause a flood of I/O errors on
> >>> the root filesystem in our testing, leaving the machine unusable until
> >>> reboot.
> >>>
> >>> Given that, we'd appreciate the community helping to decide soon
> >>> whether the revert is warranted.
> >>
> >> Are you 100% sure that is caused by the patch you want to revert?
> >> Because the patch looked ok to me when I reviewed. We need to have
> >> more context and info around the issue which has been generated in
> >> order to avoid any workaround for a system/kernel bug.
> > 
> > AFAIK the testing module grabs first device available on the system and
> > uses it for testing. Which means that if you are unlucky it's your
> > network card, or disk controller and you force reload it on a live
> > system.
> > 
> > And honestly the PCI test should be either rewritten and cleaned up to
> > do something more sensible or just removed. As it is it's too fragile.
> > 
> 
> Thank you for your feedback. It is very helpful to us.
> 
> -- 
> Best Regards,
> Yi
> 

Are you going to work on a new patch? what we do with this one?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
