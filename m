Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C0C54E58
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 08:57:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F40933CE63D
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:57:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B732E3CBBBE
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:57:01 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 84D8A1000BDD
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 09:56:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82DC63537A;
 Thu, 21 Mar 2024 08:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711011418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z751jNKeOaTWdnZnRaNbj7gKyF66OEbpiKksYH2RxP4=;
 b=ad/GrAg8z6EPx56DS/jLSQA7WtAcnEkPKUcvKCw2SllCh6zby6YArx5KkhTwuX7n8UDFZ5
 15AEuY9SBWFsRYlrILq9dYJzPHdmp5nfWdQAjyq9BgNh1pMBWIz0cNP1NIwaDQR4g9bX9i
 QcsOt4xVoLQ8hqixWDb1Sbhaojraag4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711011418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z751jNKeOaTWdnZnRaNbj7gKyF66OEbpiKksYH2RxP4=;
 b=NeXvqNgSmGCDFQGl6+p0LhHh3mR9UpB61jS67Dfr57ixdhD+kXYVSeu4TAnFn95IM9C2Sd
 CqhE3TL8zH1rvBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711011418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z751jNKeOaTWdnZnRaNbj7gKyF66OEbpiKksYH2RxP4=;
 b=ad/GrAg8z6EPx56DS/jLSQA7WtAcnEkPKUcvKCw2SllCh6zby6YArx5KkhTwuX7n8UDFZ5
 15AEuY9SBWFsRYlrILq9dYJzPHdmp5nfWdQAjyq9BgNh1pMBWIz0cNP1NIwaDQR4g9bX9i
 QcsOt4xVoLQ8hqixWDb1Sbhaojraag4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711011418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z751jNKeOaTWdnZnRaNbj7gKyF66OEbpiKksYH2RxP4=;
 b=NeXvqNgSmGCDFQGl6+p0LhHh3mR9UpB61jS67Dfr57ixdhD+kXYVSeu4TAnFn95IM9C2Sd
 CqhE3TL8zH1rvBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2552B136AD;
 Thu, 21 Mar 2024 08:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AunCBFr2+2V6fAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 08:56:58 +0000
Date: Thu, 21 Mar 2024 09:56:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240321085656.GA543531@pevik>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
 <20240321082559.GA535362@pevik>
 <593a7a6a-f4dd-450e-9fbe-6f77ef62c6ff@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <593a7a6a-f4dd-450e-9fbe-6f77ef62c6ff@suse.com>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ad/GrAg8";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NeXvqNgS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 82DC63537A
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/10] New LTP documentation
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

Hi Andrea,

> Hi Petr!

> On 3/21/24 09:25, Petr Vorel wrote:
> > Hi Andrea,

> > > The new LTP documentation is meant to use Sphinx as the main
> > > documentation framework, with ReconStructedText as the main language.
> > > All the conversion has been done step-by-step, each chapter at time,
> > > updating english syntax and fixing typos. There are minor improvements,
> > > but overall the structure is the same.
> > > C / Networking / KVM API are not documented yet, because they will be
> > > probably integrated in the LTP library. C API documentation is already
> > > on going, but the others not.
> > > For a demo, please take a look at:
> > > https://ltp-acerv.readthedocs.io/en/latest/index.html
> > Out of curiosity, we need to register LTP on readthedocs.io.
> > Then we need GitHub Action hook (including some secret for auth) for publishing.
> > Correct?

> > https://docs.readthedocs.io/en/stable/guides/setup/git-repo-manual.html
> readthedocs works with any kind of git server. The only thing we need, it's
> a .readthedocs.yaml file inside a specific branch (i.e. master).
> So we need to create an account for the LTP team in readthedocs.com, then we
> provide the git repo to readthedocs and site will be published
> automatically.
> ltp.readthedocs.io is available, so maybe we should create an account
> already.

ack.

> > I guess you now deploy to your fork manually, otherwise you would add GitHub
> > Action config in the patchset.
> It's automatic done by readthedocs and we don't need Github actions.

> > Also, what I like (for the future) offline formats (PDF, ePub, HTML) are
> > supported:

> > https://docs.readthedocs.io/en/stable/downloadable-documentation.html
> Sure we can try to generate it and see what happens. I never tried to do it
> in sphinx.

> > Also, I would prefer when this merged it would actually replace the old github
> > docs (otherwise we maintainers endup maintaining both - getting fixes for both).
> > E.g. in the final version first deleting the old docs + github update hook.
> Sure, so let's finish the basics. I'm waiting for Cyril LTP library
> documentation, since I don't have all the expertise which are requested. The
> idea is that we will get rid of the current C-Test-API.asciidoc file and we
> will only use documented headers.
> Then we can proceed for sure.

Cool (I can imagine it might take some time and energy).

> > Kind regards,
> > Petr

> We also have networking/KVM/shell API documentation that should be placed
> inside the headers. It would be nice to have a help on that.

Yeah. It might be another challenge to get Sphinx working on shell API.

Kind regards,
Petr

> Regards,
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
