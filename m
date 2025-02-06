Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20754C02198
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:05:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB25B3C9292
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:05:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE2D3C008D
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:05:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F31711425593
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:05:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB63F210F5;
 Thu,  6 Feb 2025 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgnnrPRPkQjkItLxr5BGmw9IlCHCHKJO5b8DKqTsyY4=;
 b=wjcTsdRCXPCd1IaTgu7E2+fyF4g7LGn/+AJ8qQrz5dWppD68AcOtmiR4+urUx3U0kAmI/u
 ys90HRSQP148k3LJ34XgKTl30iS7tNFVe4I4LRhlbi8fvDbsFh+/QCCYnhj3lnQT461Hks
 dDqy/Vi7/vghq/P8w1LLzzrEscR7R9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgnnrPRPkQjkItLxr5BGmw9IlCHCHKJO5b8DKqTsyY4=;
 b=g4UkM5zdEvlf76VoySbgB2qPA4zobuNV6WTbVvBrXvce1HK52Wi7UMaRRpn/H32qxFl+ST
 8Fu440HvTt4ax1Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wjcTsdRC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g4UkM5zd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgnnrPRPkQjkItLxr5BGmw9IlCHCHKJO5b8DKqTsyY4=;
 b=wjcTsdRCXPCd1IaTgu7E2+fyF4g7LGn/+AJ8qQrz5dWppD68AcOtmiR4+urUx3U0kAmI/u
 ys90HRSQP148k3LJ34XgKTl30iS7tNFVe4I4LRhlbi8fvDbsFh+/QCCYnhj3lnQT461Hks
 dDqy/Vi7/vghq/P8w1LLzzrEscR7R9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgnnrPRPkQjkItLxr5BGmw9IlCHCHKJO5b8DKqTsyY4=;
 b=g4UkM5zdEvlf76VoySbgB2qPA4zobuNV6WTbVvBrXvce1HK52Wi7UMaRRpn/H32qxFl+ST
 8Fu440HvTt4ax1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E54F13694;
 Thu,  6 Feb 2025 15:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uNYaHabPpGe2MQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Feb 2025 15:05:10 +0000
Date: Thu, 6 Feb 2025 16:05:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250206150508.GC1573569@pevik>
References: <20250206143421.1571918-1-pvorel@suse.cz>
 <20250206143421.1571918-4-pvorel@suse.cz>
 <3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com>
X-Rspamd-Queue-Id: AB63F210F5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/7] doc/Makefile: Improve make targets
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

> Hi Petr,

> On 2/6/25 15:34, Petr Vorel wrote:
> > * add _static/syscalls.rst into clean target)
> > * add targets:
> >    - .venv
> >    - distclean target (for .venv)

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >   doc/Makefile | 20 ++++++++++++++++----
> >   1 file changed, 16 insertions(+), 4 deletions(-)

> > diff --git a/doc/Makefile b/doc/Makefile
> > index e536e95db6..0f67721ef5 100644
> > --- a/doc/Makefile
> > +++ b/doc/Makefile
> > @@ -1,8 +1,20 @@
> > -all:
> > -	sphinx-build -b html . html
> > +PYTHON := python3
> > +
> > +# install sphinx only if needed
> > +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo "true" || echo "pip install sphinx")
> > +
> > +.venv:
> > +	$(PYTHON) -m virtualenv .venv
> > +	. .venv/bin/activate && pip install -r requirements.txt && $(INSTALL_SPHINX)
> > +
> > +all: .venv
> > +	. .venv/bin/activate && sphinx-build -b html . html
> The reason why we didn't have virtualenv dependency in the makefie is that
> every distro has their own python packages as well.

> virtualenv requires pip, but it's not strictly needed. For example, that
> could be don't inside a container for development reasons and the venv
> activation wouldn't be possible.

> I would suggest to keep the previous version, without the virtualenv
> dependency for this reason.

I hoped using virtualenv would actually help developers. Because doc/ is not
parsed by top level Makefile, therefore rpm/deb packages will not build it.
But OK, let's drop this change, I'll send v2.

Kind regards,
Petr

> >   spelling:
> > -	sphinx-build -b spelling -d build/doctree . build/spelling
> > +	. .venv/bin/activate && sphinx-build -b spelling -d build/doctree . build/spelling
> >   clean:
> > -	rm -rf html/
> > +	rm -rf html/ _static/syscalls.rst
> Good idea, maybe also _static/tests.rst since we added it.

Now I'll add just _static/, to be always valid. Also, change in tests does not
trigger the need of rebuild, therefore one must always run 'make clean', but I
haven't tried to figure out how to express the dependency.

Kind regards,
Petr

> > +
> > +distclean: clean
> > +	rm -rf .venv/
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
