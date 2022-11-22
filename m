Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523A6C4332F
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:30:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 751BA3CCAE4
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 10:30:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D4D83CCAB4
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 10:30:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46E6E12501F2
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 10:30:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71D0F21D48;
 Tue, 22 Nov 2022 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669109430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nl38GYd1i1cdJIJbQO6w9m1VdbkixxcItlux4LW7R3A=;
 b=iIZK1rKasWXrRE4UJwJv0LfgSjfwARIk4dJLNqqac+NN9mz42W0E153c/2bHIsSTX3AHXP
 VzB33h3fQ+fuSNX7tj19O/aqM5Ve4EnO3uMMb4IwU+HANfjNfYHu80D+dfGElssIOwoLog
 Oj6YsFkZ78Q4dr41+s45fYuSqrwA/Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669109430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nl38GYd1i1cdJIJbQO6w9m1VdbkixxcItlux4LW7R3A=;
 b=D7trkY8zV9ko9/OPlE5PLNQMX8J0RrnuT8wz+1MAeFX/EUOMRo4ywklz0iK9KzH/a8OskR
 BpkbkxIEcvyrUBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 477F113AA1;
 Tue, 22 Nov 2022 09:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nc4VELaWfGO4OwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 09:30:30 +0000
Date: Tue, 22 Nov 2022 10:30:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3yWsgwJrcsi26Vu@pevik>
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki> <87mt8kfgad.fsf@suse.de>
 <Y3ukncX84lQTJNe9@rei> <87ilj7fjz6.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilj7fjz6.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie, Cyril,

...
> >> > I woder if this would work with different compilers. I suppose clang
> >> > does work, but what about icc?

> >> Clang is fine. I doubt that icc compiles LTP at present unless it does
> >> support GNU extensions.

> > Fair enough.

> >> > I supose that we get tons of 'can't do pointer arithmetics on void*
> >> > pointers and stuff' with plain c99. Maybe it would be better to clean
> >> > these out instead.

FYI gnu99 works on our CI
https://github.com/pevik/ltp/actions/runs/3521626082

and c99 not
https://github.com/pevik/ltp/actions/runs/3521624383
parse_opts.c:458:35: error: implicit declaration of function 'sbrk' [-Werror=implicit-function-declaration]
parse_opts.c:475:27: error: 'CLOCK_MONOTONIC' undeclared (first use in this function)
parse_opts.c:208:47: error: 'optarg' undeclared (first use in this function)
and many other errors

Richie probably found that himself.

So that I'm for merging this and Jan's fixes on the top of it.
I suppose there is no feature dependency on autotools (i.e. we don't need to add
-std=gnu99 to any of macros in m4/.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
