Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F63C433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 05:44:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C9043C6B1B
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 06:44:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51833C0959
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 06:43:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A9B110007DC
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 06:43:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7517F212CA;
 Wed,  8 Dec 2021 05:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638942236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msTNAeDSTgbuVbbmMfWXciBd8uYN1btq0rLsrBqmtOU=;
 b=d+Gq8x6np8nViucsxpKXlvUTY05RdIbDVjIo1Qh3Gl8YscOKoq+pFBt56jqQNOOgP9JMh7
 YqFk3/XvM7ltdIp4541SsWsV8dhGqrypcP9QoNaW1rqFMmnPUIyHvEBh9xhhoj0/0hEVvs
 PrHJvmeoAdQ9oCrdgm7Wg3pNnBi1OgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638942236;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=msTNAeDSTgbuVbbmMfWXciBd8uYN1btq0rLsrBqmtOU=;
 b=ADgS/A2mfS88UgUTy1ln9/4cz98vxjSPrxjx3TA5oG1QPw4YXv4elyw1ze1g07O906Qct8
 5D7sGzSVxl4GdaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0528113B42;
 Wed,  8 Dec 2021 05:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N3CrOBtGsGGSMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Dec 2021 05:43:55 +0000
Date: Wed, 8 Dec 2021 06:43:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YbBGGctiRqsKF9CG@pevik>
References: <20211202203006.32259-1-pvorel@suse.cz>
 <CAASaF6we7wki=+4Rt_8NGg848735VdAUeaMSGNUMBcL-cOX5pg@mail.gmail.com>
 <Ya3lc9jWR5UZXB3T@pevik> <87wnkgbm70.fsf@suse.de>
 <Ya+VQ9mVuAo99QOB@pevik> <Ya+5CUgD5CBVhdGG@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ya+5CUgD5CBVhdGG@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > I wonder if colours can be added to all output with some autotools toggle?
> > There might be some third party plugin, but I haven't found any.

> Actually you can override the default macros used to print the results
> as described in:

> https://stackoverflow.com/questions/38729273/colorize-output-from-configure-script
Sure, I have found this as well, that's the way to go. I hoped that there would
be for something so basic as colors some third party macro similar to pkg.m4
which could be just used.

As shown here, I suggest just to color yes as green and no as red.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
