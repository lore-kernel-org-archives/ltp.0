Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579D7C352A1
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 16:42:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FB423CDBCF
	for <ltp@archiver.kernel.org>; Tue,  6 Dec 2022 17:42:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84C073CC158
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:41:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B21AF1A002D8
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 17:41:57 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9BD4721BDB
 for <ltp@lists.linux.it>; Tue,  6 Dec 2022 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670344916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvQhGGfDIuTZb66+ijb32wSU3OYNBUMIaxGRaix+09g=;
 b=WwGdat+m1ho5tNnBecG6TD/0AjC0saPysYs2rL8KCITggjzgZOulXmkcvsGmGN9sLIMFrp
 /vojwAVTNBYenhFGh716boo5ZegWDUwHLvTTiBGnLb35ZSzhVfWBFAq+FT5pfUYS1KEvda
 F5BcSoSObPIJF20sGTXv5r0GZw10vOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670344916;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvQhGGfDIuTZb66+ijb32wSU3OYNBUMIaxGRaix+09g=;
 b=4s+F4hPDi8FCnpo1r/lVwy63PX65PoLhiUlntdLR+KprLiwKJwYUtgVR8l+WSB7+lBVAh5
 jbWyH4XiEbGrSiDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 739472C145;
 Tue,  6 Dec 2022 16:41:56 +0000 (UTC)
References: <20221206115329.17760-1-rpalethorpe@suse.com>
 <20221206115329.17760-2-rpalethorpe@suse.com> <Y49EjvZHd1npsXS7@rei>
 <87edtctuos.fsf@suse.de> <Y49qssvWl2g+rvOu@yuki>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 06 Dec 2022 16:30:02 +0000
Organization: Linux Private Site
In-reply-to: <Y49qssvWl2g+rvOu@yuki>
Message-ID: <87a640trg1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fill_fs: Ensure written data is not easily
 compressed
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> I suppose that instead of writing random lengths we could just copy
>> /dev/urandom to <path> in static chunks of a reasonable size.
>
> Actually it would make sense to do random length writes as well, at
> least for a subset of files. I guess that in real life scenario we would
> encounter both, block writes and randomly sized writes for files.
>
> I would do something as:
>
> #define BLOCK_SIZE 4096
>
> ..
> 	char buf[2*BLOCK_SIZE];
>
> 	fd = SAFE_OPEN("/dev/urandom", O_RDONLY);
> 	SAFE_READ(1, fd, buf, sizeof(buf));
> 	SAFE_CLOSE(fd);
>
> 	...
>
> 	random_size = random() % 2;
>
> 	while (len) {
> 		if (random_size)
> 			len = random() % BOCK_SIZE;
> 		else
> 			len = BLOCK_SIZE;
>
> 		off = random() % BLOCK_SIZE;
>
> 		ret = write(fd, buf + off, len);
>
> 	...
>
>
> But feel free to implement anything that you find sensible.

What are we trying to do though, simply fill the device to test the
ENOSPC condition or some kind of poor man's fuzzing?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
