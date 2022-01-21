Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287FEC433EF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 13:55:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD7753C9727
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 14:54:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AB863C96C2
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:54:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02E18200085
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 14:54:47 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0520421972;
 Fri, 21 Jan 2022 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642773287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoLRDSo1SOoPQsfO6GqdQBAayVTOEp3P+b3PxYW1Psc=;
 b=wQWMX9RkzS0P/6k/HK+D+yMuYh77l1XwNgZxXt9g8VE59nHLl96iacBPfEY6KmQJxfarDk
 e6MxgiDoOG1ls63AL4l/usVLGdBHo6rqyGqp7FFRjKzlCgNdB2HYP9UB770Tvx28WkG5lU
 tCMQAa3m+w17RkgF+su5KYUgtNuykRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642773287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoLRDSo1SOoPQsfO6GqdQBAayVTOEp3P+b3PxYW1Psc=;
 b=z3KsrHKa7YmJXHy7eI0UGrnbVpHMyKAKsIjPEEgN63w6IH1hEgegdLZRplqYngLX1Eeawh
 heQHE9TXMW9vsXAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE48D13941;
 Fri, 21 Jan 2022 13:54:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CmYEMSa76mHNVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 13:54:46 +0000
Date: Fri, 21 Jan 2022 14:54:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yeq7JdbZUTPBKkcb@pevik>
References: <20220121103011.6266-1-pvorel@suse.cz>
 <4508acbd-3ca2-b1b4-ff38-6ffa573aa6fd@suse.cz>
 <Yeq2KeBX5/04d01m@pevik>
 <5988d540-ce29-d210-365e-7e5efa91b547@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5988d540-ce29-d210-365e-7e5efa91b547@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] aiodio: Set timeout 30 min
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

> On 21. 01. 22 14:33, Petr Vorel wrote:
> >> Hi,
> >> only dio_sparse really needs higher timeout because we use it for a slow
> >> stress test in a runfile. dio_read should get a lower default number of
> >> child processes instead (8 or 16 to keep the default memory requirements
> >> under 512MB).
> > Thanks!

> > I also noticed dio_read, but as you pointed out it's already fixed by
> > f3caabe44c ("Reduce memory footprint of the dio_read test")

> Runfile usage is fixed but running the program manually with default
> setting would still result in extreme memory use. We should make the
> defaults more sensible as well.
+1. So do we want in the end to increase dio_read just for now before release?
That'd make sense to me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
