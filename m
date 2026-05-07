Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0726ECD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778139203; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=a7Ab+kZ7lNrt7PB4erwOcNnYKRC2oprLjh2bH9qRXG0=;
 b=SpAoaJ8iKEmHoTR0p/QB21z/NjsrR7AsnMtsA/Ba8Y/Qu70ooyoRaN1I9tw6JDHG7b5A0
 0BzWv6wpoBe47hpxHmnMu9uFn9Vs9xIJY3xxdupWbFulsnQkLJF3rEmRvLczTDJMhbwCl2r
 UM4u2c9PwSKVkuFDgXDnrCh3LewQd2Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C4B03E2877
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:33:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 407553CB935
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:33:00 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF8801400433
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:32:59 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so6240785e9.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778139179; x=1778743979; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ab8bqdyoMC2pr2XM/LsnGJeFtPztME6IG6jAtyfx+Fc=;
 b=cByrlAX3cSpN+PEc7RXEoBZuhRsnfiphdcbfHAUaHGzvyq/Eo4bhoSry34iTN9KEIg
 kBID4H6+5WnWtu0lTRHYwCTKn0zEjrCwa/UPlgpfe/wTQlsdd611LeM3EqwgyjqvlY/Z
 Rm3uYhVEOLLAiPru73ADvAZN7R+KAqvhkAH9CLcFvhdKu+GWgArG60Og5xpVnnjH8xpA
 1uGNkartUyzhgFssZeMVjTn5JaIrcitYsqc08gK+WJA/6kzYdcc8NbYD6S3G8WLzUbhQ
 wSuAYngOVvH0qNAPjRUcOT7g/NIjYY1TomEtFjUtn6Op516UYRUlgFdjj8cZbfDU9CXs
 iKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778139179; x=1778743979;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab8bqdyoMC2pr2XM/LsnGJeFtPztME6IG6jAtyfx+Fc=;
 b=jUiIMSypcqM344QfsofAGmFrdL5+AwIGzPLfBVTjgpQ2TGFt9F5X8XXQuwA8g6TxDE
 6Sd1iYHog/v+n+aFK3Sc9kuK5lFsC0D5SxCqQCzv3ywQXCSHeivhaVakTHBgtrNktK6v
 jzsFwkpsa9sJ8fTCPfKMVe43GG6i3xjMN2Ytu+vHg9qFQpTFLnPEb0n4zHu/vwNSWmIv
 NQXU1cUvIzi+9JA5HaEOX8VQGz7xMCd1TzQ2iyTI7b/MZiA0yJ7N5FIb98uA0KFlyLpX
 VWjgM9DrC+mivf0RA350bp5g1f/hltZ+TILGyX8HnxhGajfBBtx6TZpdd8RAcCCVzwhI
 Ho6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+F9J+Rps5KdkX5Wlf1NPLzCvufTdZJ95ho/+GKZ5XWXCJnIlCYPAyzjV+HAU2F877XTvw=@lists.linux.it
X-Gm-Message-State: AOJu0YxzhQbPhAbHUuv8ieBisirqHWpiqbFnOHJkTgJ8e3qHUs62ad2E
 IIOo1vy4jDOdrcrmCG+ADW3CpvjDRZlWdqmIix7Tl2pM6iGjROS3aaYUm3JujIvX5QH0zhN0l2D
 6+NkFM2JUrA==
X-Gm-Gg: AeBDiesoJ98yDLL5lB6pOWqzea2mLySaPSssq53vxjkCEk6u5MjdgunLeqAh7LjutBr
 N4PolIPOQbWUHcfJaRVqcCKs6LFa8jzZntGyjNIsjSepT0KZq1nQnVjZiKGr2uct+ctoNG8f7kL
 nmgTaGe75zhFAmuPBXAreb1JLSz4jl3fbZlg5h8/K3bQeHSm7E8E2PjaFl5GKaI51060MERSJgG
 ovJoNW8LCkmrrNRrvXPq5GvYDTIAMy4mB/MLMxH27QYnwdOyacTmaFRqIXuZiFSmflSvCtqKt+N
 goVLAGIHzLHvGkNrEuXcdQ+g3bGRzlo4c84DMnyqZtWEs4lXyqnbnzNxvUAGe2l4bJvshLYnfey
 6sgI2EtORcLErEoceaCx3MhgoJ0jzihhUIXDt2Z51oTqN02v23FaG4AEI9exVhJuEeZptioEzfp
 D7QA3AUfZ8G30nl5hI4twJ9Yr1Dq9P5poTUuP5PsqT5Lvz+XT6JKKQYO7PSNiJGu7tb1ocgI/ou
 QO3baik8pq1QZ5lajX9Z2bCuOwGvdYpev9XB4NWB/L6dm+W+U44EFMe
X-Received: by 2002:a05:600c:35d6:b0:48a:53ea:13eb with SMTP id
 5b1f17b1804b1-48e51f21e88mr114694995e9.5.1778139179325; 
 Thu, 07 May 2026 00:32:59 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e53895effsm100395015e9.3.2026.05.07.00.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 00:32:59 -0700 (PDT)
Message-ID: <69fc402b.050a0220.36c077.a5aa@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aftt_phyFZNngJ4e@yuki.lan>
Date: Thu, 07 May 2026 07:32:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] aio_cancel_6-1: Rewrite test
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

Hi Cyril,

> Hi!
> >  
> >  	/* try to cancel the last one queued */
>            ^
> 	   This comment is no longer true, right?
> 
> I guess that we should just remove it.
> 

I can remove it before merge.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
