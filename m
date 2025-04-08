Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BE9C3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 10:14:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77C13CB37A
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 12:14:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 140E53CB359
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 12:14:21 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 62693600A45
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 12:14:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8190C21179;
 Tue,  8 Apr 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65B2B13A1E;
 Tue,  8 Apr 2025 10:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 97S3F/n29GeFcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 10:14:17 +0000
Date: Tue, 8 Apr 2025 12:14:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250408101412.GA174986@pevik>
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-4-pvorel@suse.cz>
 <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8190C21179
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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
Cc: Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> some comments below.

> On 4/7/25 17:01, Petr Vorel wrote:
> > Add 'setup' target (alias to '.venv') to create virtualenv directory.
> > This is an optional target (not run by default).
> > If .venv exists, it's used in other targets, activation supports only
> > fish and bash/zsh (known shells used by LTP developers, csh/tcsh is
> > ignored atm).

> > This helps to use virtualenv for development, but avoid using it by
> > default (readthedoc uses container with virtualenv, creating it would be
> > waste of time).

> > Add 'distclean' target which removes also .venv/ directory.

> > Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

I hope you still agree with this ^. Or shell I wait for your ack?

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > * The same as v4

> > NOTE: doc/Makefile should be rewritten to use generic_leaf_target.mk,
> > then integration to the top level Makefile will not be a hack).

> >   doc/Makefile | 22 ++++++++++++++++++++--
> >   1 file changed, 20 insertions(+), 2 deletions(-)

> > diff --git a/doc/Makefile b/doc/Makefile
> > index 3c5682ad00..2062d6e935 100644
> > --- a/doc/Makefile
> > +++ b/doc/Makefile
> > @@ -5,15 +5,33 @@ top_srcdir		?= ..
> >   include $(top_srcdir)/include/mk/env_pre.mk
> > +PYTHON := python3
> > +VENV_DIR := .venv
> > +
> > +# only fish and bash/zsh supported
> > +VENV_CMD := if [ "x${FISH_VERSION}" != "x" ]; then . $(VENV_DIR)/bin/activate.fish; else . $(VENV_DIR)/bin/activate; fi
> I had to think carefully about this, but I think you are right. It's better
> not to over-complicate this and to support other shells but bash.
> make command can override environment variables, so it's better to use that
> feature instead of complicating Makefile that can be really messy when
> adding new features.

This supports fish, bash and zsh. If anybody asks for t{,csh} or anything else
in .venv/bin/activate* it can be added.

> > +
> > +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
> > +
> > +$(VENV_DIR):
> > +	$(PYTHON) -m virtualenv $(VENV_DIR)
> > +	$(VENV_CMD) && pip install -r requirements.txt
> > +
> > +.PHONY: setup
> > +setup: $(VENV_DIR)
> > +
> >   ${abs_top_builddir}/metadata/ltp.json:
> >   	$(MAKE) -C ${abs_top_builddir}/metadata
> >   all: ${abs_top_builddir}/metadata/ltp.json
> > -	sphinx-build -b html . html
> > +	$(RUN_VENV); sphinx-build -b html . html
> >   spelling:
> > -	sphinx-build -b spelling -d build/doctree . build/spelling
> > +	$(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling
> >   clean:
> >   	rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
> >   		${abs_top_builddir}/metadata/ltp.json
> > +
> > +distclean: clean
> > +	rm -rf $(VENV_DIR)

> The rest looks fine.

Thanks!

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
