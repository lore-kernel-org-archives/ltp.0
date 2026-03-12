Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9702F105A596
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773321244; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=h1jwHrUkI2ugKSLlkYSezwvvgcM0dEzDZUTmEDd4po0=;
 b=UeVOpOxKWDWeAuEOTL/IBcHK5fXj5rcYFIHBK3BhZn/Zy/IiWwr4myM267nkbqC03yg1E
 sHQwXRoa3vyWWQsIC2p6YjSQ98QQjyAeTdpqRpQ0L9pHT3wsfac1s94zC+sEdJi9Fpto+IC
 ag0jTvQmZjUWeTR/vDcj5cqsat2fgPo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4939D3E279F
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 14:14:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 829193D0349
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 14:13:42 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09671200DC4
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 14:13:42 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso9602575e9.2
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773321221; x=1773926021; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Ka7aJ1+ipFDuuHTk7Ryq+UPjRwHHd3TD33ZU9rW/8YA=;
 b=BTn/EF72WOTJfcAvH+UIwSCj2mwIlw9eCpcmUDgo1umKLJYmI30GrILox2diq4RbdM
 PHZUxzwuPFfKQ8JBeID6F/Nh2cEyvh09me4IFJDXSBWt2IrW5RCUJJDlUjJwflA8o082
 nCUZupucxAUFf+r07lBu8Mg/hVqaA0lgP39oMvONnbRH4gcStidiNZ1Hss4dnKODomtB
 jtril+Xy8U8zfce1WiTHPv7B4QnYGLh8p09ib6dEC+SQeU1mhGSvx9M3P0efXV0Qd2Mc
 2oqVsvJvrle+tkO3YklAimCndOlrmw9vvDPYjE6Vgjc68KFofYjZfz4TalozNO2XZGrd
 CiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773321221; x=1773926021;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ka7aJ1+ipFDuuHTk7Ryq+UPjRwHHd3TD33ZU9rW/8YA=;
 b=RapqzFZccuUG3fJ6x/ZUL/W1njwTl5TXrAVJYy1/Szglr/sz37Dz0y+qYSElnIJJ29
 pLtPsgJHF2oFWp3CN6r4LEEDFx7KS5u+gD+KPL4fGl+0xVPZf2af8PNn8qruVnl99PMz
 r6W/+zsgWyYjfJyFOTRrgzo8URpa7TK7AcY2QFNFn4uahXX6HigJs4LKXd89Bfc62dii
 tjVB+cWqsaar91UnLY12Z/Re9btaxa3G5HlHYTgy4DTU3hw9O0L+n/IlteRuzQ+GOoSz
 BMLvDOE6ICdJpZ9Nz4HCMcu3a9iCxucxYOs9ZiQ3sBDEEJOb1iVDCXq+1d0IiflBBVip
 X7VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEuhsVqDLw1k02WOTI799n0FPpkfb2SOA4OplpQXi9S8sb4ygk+PfqIzXHlUNbJ3DqLsQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwIw8+UQsSxslPZMLswe6nkIGHvKCwFs5Le9KGAO0pp0d4/jYm1
 3SgmYBhdCBcJExRyXJ9xyzHD+HEqafP9+bV82nafKq/Cpro7PBwcCTMhEvU2IsZh8+Q=
X-Gm-Gg: ATEYQzzHA76HsOFtpFqqwMS+5F7kI7pO7bZ37GY3mYMv7r75AG47+Xx1OIGjlomBwa5
 T06DzO/+z5M0udXHTnkHSGOC93vhHWK6Mf/Q709+3mF646TU8NaauWPf4bQmdk4lT34cmaesw9S
 Gi3nhI1mnaAGdRqoa7/CSmqp/WAWZ8EDz+jw03dlTXv57ab3P1ig+0qhoq80Pri1fjDi4xweHxq
 97a+Jnibwx4qK7tHzCg+HmGND+aY90vqUEcmT2K6+E4L6zOZRP1XerZ/X49bPjC4LvEjnwDJU/A
 yHhNk0jXPmS97lbBMgN6ZhbSot5e13soMpSKYg0F0Gpk1E7oQ9qzILWEb/+FLTrfDcWZrR+aFHC
 cYR0RQ13H8GUU9F+gZ3ReFHyP1CHgHBdUSwISPIGaIR/SadJYCkVAvrUW90fYDk+Hh7PEevGaX4
 cdpNMNXLGgoxwao0Kvoyf1bEAYQzfHQydDx/xkkxwe
X-Received: by 2002:a05:600c:1d16:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-4854b0a6d74mr108625635e9.2.1773321221264; 
 Thu, 12 Mar 2026 06:13:41 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b7f3cdsm257125455e9.14.2026.03.12.06.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:13:40 -0700 (PDT)
Message-ID: <69b2bc04.050a0220.fabf1.b09e@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>, ltp@lists.linux.it
In-Reply-To: <20260302120207.170340-1-rbranco@suse.de>
Date: Thu, 12 Mar 2026 13:13:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] userfaultfd: Add test using UFFDIO_POISON
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

Hi!

> +
> +static void reset_pages(void)
> +{
> +	if (page) {
> +		SAFE_MUNMAP(page, page_size);
> +		page = NULL;
> +	}
> +}
> +
> +static void *handle_thread(void)

It looks good, but I noticed that all threads handlers in the userfaultfd testing
suite are not using the POSIX syntax:

    static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)

We should can change it later on.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
