Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED8AD2D103
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 13:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768311726; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1ey7MwqWraWWVPenNssfawcIgdGD3DSzGYtI8CuJWH4=;
 b=KuhqqWJktEebsU2/B4TFNsSQxHOowUTeN53LjVdFMZDAO60i3NoAYFpknlLvDHm1UthJn
 vCtWqRto+gsSe2DBaZDJqAOdJ0fbaGcCX6Xyr0sleJxRI+vAU927r3nQVp5LjEZzC5KC6Y2
 OLcSoKTwctju2i6YxLUaTI4pfvW3hT0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D00D63C649A
	for <ltp@archiver.kernel.org>; Tue, 13 Jan 2026 14:42:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 128B53C6335
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 14:41:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 54050201DCF
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 14:41:42 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47d3ba3a4deso43976425e9.2
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 05:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768311702; x=1768916502; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyPbOsC/gELdf/Y1EmD/XcM4HM6UrmAPdVLjWbW2JCw=;
 b=XhsuEcw6t+c0xIZVjcKJzOSJmMajaC2RNXsRLNYcRTS9w1LfLSHZtGKRUP2jqAZJHB
 5H9axaaGb1vqmodAkwX8m8ePt1TpsiUTqnIYxYy3XpKpOktE+Nxy7+hqC8ZRlYVBDvwT
 vhiDIkxdyHioRZD+YItOVdIWhwQi8tCcRIVS20fAvkSYBPm8ZhqbGQHroYwCRAfRFFYV
 QZuIl8QGMF93ur8uI+kFhs1GJHZC6nyWOQevEE10I9piGiAikIPb9U+VqA2GunL7FAGS
 CAMPA+4Xxc/buty8okdMnFfRnD9pSWD65ufeFX6zcsGfsx0Ct46276UcEjNitPNEHlc/
 FYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768311702; x=1768916502;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XyPbOsC/gELdf/Y1EmD/XcM4HM6UrmAPdVLjWbW2JCw=;
 b=HzFx20dSIC3n5434/JX4QqoZiQDnVFSRAwlBnMvvbdmWqiJasqF2jgnyJKe5asq7WG
 BoNkHMoWKB7qwubtHSsU2G5PgI1Cu8gJxcul4qO15NJLl5c2Vj4v5/TBYJeHQKLDw2UO
 6uONRxADuIYXA5YCo3QsosKqueTCemMnmo8PkvfmekgVdNn17Xo75h3rup4zTOmiRAx1
 AxdbnlGpIbLZGBgytsfBAHNyb+SK97DfHhECc5r+hkrrRCuGIou4fI4wMB+UmfKoWCBd
 OfBKnedUAm0v2VOhm3YEHDcsznUK4PBnNFV7X3vRwCvKZYF7kH6PMmE2faW+xJa6hXUK
 zn6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn6w7bCThaYuKZYFunGbMzjaD1odjUn1ATbsQL9AHcoUCIOec6lpR029JaUbDoXuOvX6k=@lists.linux.it
X-Gm-Message-State: AOJu0YxA4aKLqgLa4sh4JLZeiYs4nMZifQqbG6iB8ghHDZ1vnKacvapO
 PcmeLLFzKo/ADitbvWhRzdux+yLoHC9YUwrXkzgO3jLY3y+RqP0mdMsVZbX6BjiHXNQ=
X-Gm-Gg: AY/fxX6qZTug3FcWOw4y0HuoTlCEESFvlCzMxGmlnm38gCp7DAeBBNXbPAYWc4dP4Zj
 dW9y2LNdaMpb+VAUcxCCnY1oQ0GwGHZ+UhfEds221M0feb3Zsje1oJAaZ4yPrsdLbjUtkaYoDRK
 zDGTMb+dSX+Blfptvj3KvPqlOOYHvaASamkEPHe+dTS3t5CToQ4swIwSJQGp5XOPGxMO6MJR3XC
 7BNt3MIifLBTydRT0si3JFBTYG2Xe0t8O9g0Oz5xRjX24eSmuJXQLtfAIh36F6IjAnqI1tjmt0y
 u2ekBq8Eu0p0IhlBa23iUNeKUNizQQIDrMFA+xuqDFuCdhmL2ryX5F/tVj8PNcspfUuOicg8NGX
 +ZW0F2XbiCOC/2Sx+IbUCKSn11tNnoQhIfcR6nLuRgcLpLRQ8MUrGLzI9P4Hm5Nf7FTcd9QMs7J
 QwnFyevI2r3scp
X-Google-Smtp-Source: AGHT+IHFZCl2Ilg83w39ajvFwXyrIbbhGNC5zZtB5eRz+3JRSmo8I/VmUAKSx5qRD2KxYST5KO9a7A==
X-Received: by 2002:a05:600c:1385:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-47d84b0a227mr247520475e9.4.1768311701723; 
 Tue, 13 Jan 2026 05:41:41 -0800 (PST)
Received: from localhost ([88.128.90.24]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41eb3bsm423123465e9.7.2026.01.13.05.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 05:41:41 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 13 Jan 2026 14:41:40 +0100
Message-Id: <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
To: "Jan Stancek" <jstancek@redhat.com>, "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
In-Reply-To: <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> I'd keep them separate from core library. For non-core libraries, I'd go with
> something more distinct, like "ltp" prefix for file and function names.
>
> When I look at "libnuma.h" I'd have to think for a bit if this is
> header from numa-devel
> or LTP. "ltpnuma.h" seems (to me) more clear that it's not LTP core
> nor numa-devel.
>
> my 2 cents,
> Jan
>

That's exactly why I was suggesting to keep `tst_*`, which is more for
code-library. The `lib*` prefix is pretty generic and we need something
more specific for LTP.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
