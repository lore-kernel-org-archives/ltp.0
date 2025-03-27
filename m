Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C420C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 14:57:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4943C9FF6
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 15:57:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39BFF3C9F5B
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:57:16 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DFEE1400F2F
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 15:57:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 215A71F78D;
 Thu, 27 Mar 2025 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743087433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SC4kKTNrwGnKy9+iPFfTPIV1jH6r0PrR7Bwv5sm9O80=;
 b=X1kL7FIhF0zqUUIynMAiKpzgGaFyrqxcctrDPGvCg76zKoUJ4oQ5CbAS9q3/3gVCXh4on1
 hGp8Uxt36iXKuOcJHe5ZpYqOLWN2+HXQ2tFdnB3/b+m9DNDNfU7d4wWoP/p07V4Wj//LJU
 Lxozap8vh0S9BLQE9B1e5GjsEkcuSZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743087433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SC4kKTNrwGnKy9+iPFfTPIV1jH6r0PrR7Bwv5sm9O80=;
 b=H7M0PyGtXdJ8Wj9zjlukjwneQdMibVi1baWpBeQVvDN6pEhlpFSPWrbPMBhilHHG0NfUNf
 v5W+t+t7uR4q4BBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743087433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SC4kKTNrwGnKy9+iPFfTPIV1jH6r0PrR7Bwv5sm9O80=;
 b=X1kL7FIhF0zqUUIynMAiKpzgGaFyrqxcctrDPGvCg76zKoUJ4oQ5CbAS9q3/3gVCXh4on1
 hGp8Uxt36iXKuOcJHe5ZpYqOLWN2+HXQ2tFdnB3/b+m9DNDNfU7d4wWoP/p07V4Wj//LJU
 Lxozap8vh0S9BLQE9B1e5GjsEkcuSZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743087433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SC4kKTNrwGnKy9+iPFfTPIV1jH6r0PrR7Bwv5sm9O80=;
 b=H7M0PyGtXdJ8Wj9zjlukjwneQdMibVi1baWpBeQVvDN6pEhlpFSPWrbPMBhilHHG0NfUNf
 v5W+t+t7uR4q4BBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 046891376E;
 Thu, 27 Mar 2025 14:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C6cMAEln5WfdawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 14:57:13 +0000
Date: Thu, 27 Mar 2025 15:57:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250327145707.GA88071@pevik>
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-3-pvorel@suse.cz>
 <4c07a227-8fb6-4a9a-b664-d75d726a3d39@suse.com>
 <20250325094825.GA372417@pevik>
 <67679d92-f7fa-4720-bb42-343edfe2fd3a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67679d92-f7fa-4720-bb42-343edfe2fd3a@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] doc/Makefile: Allow to create and use .venv
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

> Hi Petr,

> On 3/25/25 10:48, Petr Vorel wrote:
> > Hi Andrea,

> > first, thanks for your review.

> > > Hi,
> > > On 3/25/25 00:40, Petr Vorel wrote:
> > > > This is an optional target (not run by default).
> > > > If .venv exists, it's used in other targets.
> > > > This helps to use virtualenv for development, but avoid using it by
> > > > default (readthedoc uses container with virtualenv, creating it would be
> > > > waste of time).
> > > > Add 'distclean' target which removes also .venv/ directory.
> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > > Changes since v2:
> > > > * Add distclean in "doc/Makefile: Allow to create and use .venv"
> > > >    doc/Makefile | 19 +++++++++++++++++--
> > > >    1 file changed, 17 insertions(+), 2 deletions(-)
> > > > diff --git a/doc/Makefile b/doc/Makefile
> > > > index 3c5682ad00..3b8265d88e 100644
> > > > --- a/doc/Makefile
> > > > +++ b/doc/Makefile
> > > > @@ -5,15 +5,30 @@ top_srcdir		?= ..
> > > >    include $(top_srcdir)/include/mk/env_pre.mk
> > > > +PYTHON := python3
> > > > +VENV_DIR := .venv
> > > > +VENV_CMD := . $(VENV_DIR)/bin/activate
> > > This will cut off all shells not supporting "activate" script, such as fish
> > > or csh.
> > I would guess csh is not much used nowadays in Linux. I would dare to say bash
> > is much more popular than modern fish (I know more people using zsh), but sure,
> > how about:

> > VENV_CMD := . $(VENV_DIR)/bin/activate || . venv/bin/activate.fish

> > Or even add also activate.csh if you think people are using it.
> > I would ignore the rest of activate.* scripts
> Yeah, somehow we need to handle those shells.

I don't have openSUSE statistics, thus using Debian popcon:

* bash: 99.98%
https://qa.debian.org/popcon.php?package=bash

* zsh (compatible with bash):  7.32%
https://qa.debian.org/popcon.php?package=zsh

* fish (you're using): 1.95%
https://qa.debian.org/popcon.php?package=fish

* csh + tcsh: 0.67% + 1.91%
https://qa.debian.org/popcon.php?package=tcsh
https://qa.debian.org/popcon.php?package=csh

I'm not really convinced anybody uses {t}csh on shell development, but ok,
giving up and add also this support :).

> > > Quite possible this Makefile would work only on CI, since developers often
> > > customize their own shells, unless you override VENV_CMD. And, in that case,
> > > virtualenv creation is 1 command away and it makes this Makefile feature
> > > superfluous.
> > I would say in with the above it will work for most of the users (I have heavily
> > customised shell and venv always worked) and yes, it allows to overwrite.

> > make VENV_CMD=". .venv/bin/activate.csh"

> > > > +RUN_VENV := if [ -d $(VENV_DIR) ]; then $(VENV_CMD); fi
> > > > +
> > > > +# install sphinx only if needed
> > > > +INSTALL_SPHINX := $(shell $(PYTHON) -c "import sphinx" 2>/dev/null && echo ":" || echo "pip install sphinx")
> > > This can be added to requirements.txt, there's no need to handle it in
> > > Makefile.
> > I added this as it speeds up the installation. Sure, I can remove it.

> > > > +
> > > > +$(VENV_DIR):
> > > "setup" stage is more clear than using virtualenv directory name.
> > Using directory name gives us detection if it's needed for free. You complained
> > about Makefile getting complicated, using setup would complicate it more. Do you
> > want that?
> "make setup" is not complicated. Fixing command based on the folder name is:
> none cares how the virtualenv folder is named and none really wants to
> remember how it's called.
> If the goal is to keep things simple, exposing Makefile implementations to
> the users sounds weird and counterintuitive.

I'm ok to have phony target 'setup' which points to '.venv' target (less code
than to have only setup target bug check for directory presence). I suppose you
talk only about the make target, not about the virtualenv directory name.

About the directory name: I felt '.venv' is kind of the default directory which
is used by people for virtualenv. Looking at:
https://codesearch.debian.net/search?q=%5C.venv&perpkg=1&page=1
People mostly use: .venv, then venv, .venv*, venv*, .env, env, .eggs

That's why it make sense to me create the directory as '.venv'. Also it's good
that it's a hidden directory (starts with '.'). Hope you agree.

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
