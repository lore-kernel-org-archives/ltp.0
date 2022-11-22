Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEA7C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 10:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27F6C3CCAD1
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 11:02:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16BE83C03AE
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:01:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E88A14002AB
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 11:01:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CFCC021AF4;
 Tue, 22 Nov 2022 10:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669111316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RUV1uw0W1PTbXzXzPe80Zv7T8KOi2keY3i9iVkCkz18=;
 b=VpAy5riVDWjTiS/SCf2GD1DHDQ91yvxs+pDQi/farvi9kKtYyaveu75AMgIXqP2B/ZtJ2z
 oP7wD256FRC/kvfa0djbqRRi5fwThSkuUB1DbefG3mxQCORS8pTXgj5hOkkyosrRK4wI7I
 jUY+gtNx4w/1ABIHeZKT5PmFRBFj4Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669111316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RUV1uw0W1PTbXzXzPe80Zv7T8KOi2keY3i9iVkCkz18=;
 b=kn2yEtHgP7ZUDf7G4+Iw8RX+w4vroPCPuhKklwnbH99hMJm2EIMPj9GJawKzC4Y3LbO9ZU
 WjEP9LaGb9FRXvAg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9187C2C142;
 Tue, 22 Nov 2022 10:01:56 +0000 (UTC)
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki> <87mt8kfgad.fsf@suse.de> <Y3ukncX84lQTJNe9@rei>
 <87ilj7fjz6.fsf@suse.de> <Y3yWsgwJrcsi26Vu@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Nov 2022 10:00:40 +0000
Organization: Linux Private Site
In-reply-to: <Y3yWsgwJrcsi26Vu@pevik>
Message-ID: <87a64jfgtn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] config: Explicitly set gnu99
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie, Cyril,
>
> ...
>> >> > I woder if this would work with different compilers. I suppose clang
>> >> > does work, but what about icc?
>
>> >> Clang is fine. I doubt that icc compiles LTP at present unless it does
>> >> support GNU extensions.
>
>> > Fair enough.
>
>> >> > I supose that we get tons of 'can't do pointer arithmetics on void*
>> >> > pointers and stuff' with plain c99. Maybe it would be better to clean
>> >> > these out instead.
>
> FYI gnu99 works on our CI
> https://github.com/pevik/ltp/actions/runs/3521626082
>
> and c99 not
> https://github.com/pevik/ltp/actions/runs/3521624383
> parse_opts.c:458:35: error: implicit declaration of function 'sbrk' [-Werror=implicit-function-declaration]
> parse_opts.c:475:27: error: 'CLOCK_MONOTONIC' undeclared (first use in this function)
> parse_opts.c:208:47: error: 'optarg' undeclared (first use in this function)
> and many other errors
>
> Richie probably found that himself.
>
> So that I'm for merging this and Jan's fixes on the top of it.
> I suppose there is no feature dependency on autotools (i.e. we don't need to add
> -std=gnu99 to any of macros in m4/.

Yes, agreed. Just see my comment on the other thread first. Thanks.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
