Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D31BC433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62DE3C928A
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 17:58:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF6BA3C90EE
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 17:57:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A11392002C7
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 17:57:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1B3A210F3;
 Wed,  5 Jan 2022 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641401875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgv7GzbHia98WEdRfzaTERZSSRSAu784QPM2iTi16f4=;
 b=tfeQ4k7K4Q370i4x5X0Mxxu3h0D1OZdFU8x7GTnlUubhGPnF4pTBnm+GEa8tJ4/EnM3kTR
 JTSE8Q8ssI6JEjyEDvqt/jayYS8gd9Fn49kKhPMmRC9wSZbh4bFCCcYlupgJ5qfYWwt+4u
 GBO5m9w2iZaI7grFIqNgpsj2Hi7IFTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641401875;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kgv7GzbHia98WEdRfzaTERZSSRSAu784QPM2iTi16f4=;
 b=HCiYRdlkJnDHCKjcq7E4CSnfpwnuI5TpMe+6ancsPTW9IzyoNTAaU0aNaXyO4XYA9Osvs3
 Od2OO/hgvutQSkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ABEC13BF9;
 Wed,  5 Jan 2022 16:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eFH8HxPO1WGrGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jan 2022 16:57:55 +0000
Date: Wed, 5 Jan 2022 17:57:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YdXOEaWS2k1ScU7n@pevik>
References: <YdWC0f+70TF6Eluk@yuki>
 <CAOQ4uxg4sv9otWKSJCvdtaJnQrgaXUqvgPtnydDp6V8jio3nUA@mail.gmail.com>
 <YdWw4rza2wHGQqA9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdWw4rza2wHGQqA9@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > As usuall it's time to start preparing for the next release.

> > > Given the amount patches waiting for the review I guess that we should
> > > try to get reviewed and merged as much as possible in the next few days.
> > > I would go for git freeze at 14. 1. as that would give us a week for
> > > pre-release testing and the release would be, as usuall, finalized
> > > around the 21. 1. Feel free to reply if you think that the schedulle
> > > should be different.

> > > Also if there are patches that you think should be merged before the
> > > release let me know ASAP so we can have a look soon enough.


> > Maybe that's a good time to say I did not understand the resolution on the
> > discussion [1] about timing of merging tests for new (i.e. v5.16) features.
Good point, I hoped we'd release LTP after v5.16 to get fanotify and IMA [1]
testes merged before release anyway.

> I guess that's because we haven't ended up with one as the discussion
> faded away before christmas break. I guess I will read that again and
> try to do something about it.
+1 thanks Cyril!


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=265664

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
