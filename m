Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3154EC433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B85593C8D38
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:28:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F1FD3C8D38
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:28:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DE35714011B4
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:28:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1286121108;
 Wed, 15 Dec 2021 09:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639560494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTJIHTDVcWFoPFyzOLU5lubO3EPSTGtL792LRRdhoFc=;
 b=Z/3+nx0Zgtv+gzs8qYiEKRvJ33zvL1bZjeNOz7P7zAK9XRY6HP4JSQ2DzkbjSAsp0cHYD+
 SM8x+5FpfBuV5OANklG/AkElNrYBXT2PswIZSWjjBVb2JWVSRjCzZtRZhNhUgq1Zcvfxsm
 HQf43RDmZZz77134p/WZgzFgzTcu06s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639560494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTJIHTDVcWFoPFyzOLU5lubO3EPSTGtL792LRRdhoFc=;
 b=x8xtfZMLGcF2GxptDmiPA1gGQngHxZPj+H93vdYNGqUAULOna8nC9969PqyghTasPMd3oO
 RVZfNrg1m/J25CBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA90713B09;
 Wed, 15 Dec 2021 09:28:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qSOuMy21uWEnUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 09:28:13 +0000
Date: Wed, 15 Dec 2021 10:28:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybm1LBVV0SNIElt+@pevik>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz> <YbjAOffrWpsMvinQ@yuki>
 <YbjKV7yUJS+njaCY@pevik>
 <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Li,

> > > > +| 'LTP_SINGLE_FS_TYPE'  | Testing only specified filesystem instead
> > all
> > >                                          ^   ^
> > >                                        |   "specifies"
> > >                                        there should be comma or dash here

> > I meant "specific", i.e. Testing only specific filesystem instead all
> > supported,


> +1



> > but "Testing only - specifies filesystem instead all supported" makes more
> > sense.


> Hmm, I think it also makes sense to people who care about the
> only one filesystem on their product. So this should _NOT_ be limit
> for test/debug, because it can help to reduce testing time for specific
> requirements.

> Let's just provide a variable and leave the usage to users:).

Right :).
@Cyril: agree with "Testing only specific filesystem instead all supported" ?

> > > Other than that the rest looks fine, for the patchset:
> > > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> > Thanks! Waiting for Li and others for input before merging it.


> Good work.
> Reviewed-by: Li Wang <liwang@redhat.com>
Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
