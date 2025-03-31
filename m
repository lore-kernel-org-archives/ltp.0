Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9756EC36011
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 16:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 053E93CACF8
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 18:37:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 232483CAB4F
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:37:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 618006006D4
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:37:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA6621F46E;
 Mon, 31 Mar 2025 16:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743439049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahj4N3bpk3Fn5OYWQCEzsIZgScKK775ye4b/J3RLBfs=;
 b=pyzRvYQs0sQ4dZRM21XsZapvas9cgKsWYVqe17V81jMfr/PcFBjbTw8soAwrYQCLH5IoGr
 SJM1Edn1DFdEbUOOYYIuwQYSAw1EAR+1aawUh1v/8nm4yefroDkcgQI62msfCVXHNujLzJ
 QIYGVnQQCDW/di1Nw49J88MjOJnmWfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743439049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahj4N3bpk3Fn5OYWQCEzsIZgScKK775ye4b/J3RLBfs=;
 b=ehYeZcQDnSmbfl2stB+WQfLLf2r69ixMi6eUYssAKwb/u1nLqFSCOatOfsUpxarJm/Yk5t
 BuTq4Z/2HNMY2iAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743439048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahj4N3bpk3Fn5OYWQCEzsIZgScKK775ye4b/J3RLBfs=;
 b=PCtiXvmUfXlDD5jYdtk7Z+VHSyefFig9Y3wNZ/VOD5yRKuVg4rxFBzMNlYtoI/hG8foYcH
 XYYBZMWOCh3fWSg0v7/+5JCc7VGtB7bVdwouQrVecnIyGwuezGPlSuvDKmwBcf/TwnlOY5
 rNxRsg557WCvAUROS9WwZ6npf2i3RVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743439048;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahj4N3bpk3Fn5OYWQCEzsIZgScKK775ye4b/J3RLBfs=;
 b=LaboCH/IwchvMEbUI9CJz9CX7OET9TcTgDwVJThJn75XkSDInGkT+kJAzDc72x1AY9lKxq
 ND69nQPf9DW/J4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BEE3139A1;
 Mon, 31 Mar 2025 16:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rUknGsjE6mfdYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 16:37:28 +0000
Date: Mon, 31 Mar 2025 18:37:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>
Message-ID: <20250331163726.GB220855@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-3-pvorel@suse.cz>
 <f5949261-2e0e-4f37-bac8-bc52b74d8f91@suse.com>
 <20250331163120.GA220855@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331163120.GA220855@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/5] doc: Add sphinx to requirements.txt
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi Petr,

> > On 3/28/25 10:57, Petr Vorel wrote:
> > > Although that slightly prolongs creating virtualenv, it's probably
> > > better to handle it as the other requirements.

> > > Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > New in v4.

> > >   doc/developers/documentation.rst | 2 --
> > >   doc/requirements.txt             | 1 +
> > >   2 files changed, 1 insertion(+), 2 deletions(-)

> > > diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
> > > index 27c847e125..a303253693 100644
> > > --- a/doc/developers/documentation.rst
> > > +++ b/doc/developers/documentation.rst
> > > @@ -23,8 +23,6 @@ Before building, make sure you have python3 ``virtualenv`` module installed.
> > >       # prepare virtual environment
> > >       python3 -m virtualenv .venv
> > >       . .venv/bin/activate
> > > -
> > > -    pip install sphinx # usually packaged in distros
> > >       pip install -r requirements.txt
> > >       # build documentation
> > > diff --git a/doc/requirements.txt b/doc/requirements.txt
> > > index 742fb8b4bb..1f4cefb2c6 100644
> > > --- a/doc/requirements.txt
> > > +++ b/doc/requirements.txt
> > > @@ -1,3 +1,4 @@
> > > +sphinx
> > In requirements.txt we usually put the right version of the package that we
> > want to use. We can use the latest, what do you think?

> I hesitated a bit if fixed versions are the best as sooner or later will have to
> be manually updated when it breaks, but sure - we use it anyway for other modules

> -sphinx
> -sphinx-rtd-theme==2.0.0
> +sphinx==8.2.3
> +sphinx-rtd-theme==3.0.2

> In that case I would remove python3-sphinx from apt install command in
> .github/workflows/ci-sphinx-doc.yml to match the command => I'll send v5
> of this change only.

Wait, one thing: we use doc/requirements.txt in .readthedocs.yml. Is it really a
good idea to add there sphinx, when it uses containers? I can test it in a
separate branch, but we discussed some time ago that we should avoid adding
sphinx for readthedocs.

Wouldn't be in the end better to keep 'pip install sphinx' in Makefile instead
(the previous proposal).

Kind regards,
Petr

> Kind regards,
> Petr

> > >   sphinx-rtd-theme==2.0.0
> > >   linuxdoc==20231020
> > >   sphinxcontrib-spelling==7.7.0
> > Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
