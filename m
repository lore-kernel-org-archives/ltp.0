Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0DBC36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 13:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EFF83CB411
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 15:22:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BF993CB3FD
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 15:22:29 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E146200DCB
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 15:22:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA6D81F390;
 Wed,  9 Apr 2025 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744204946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yItTT8EZIAhKsZgt1oZXY6t9WsAC56SmSPJNLPG1S0=;
 b=NFh2GPQykGO/DwjBBm5s5+PVt5d8EQDt410w1n8zPSP3HrW7qawovGWexHdBeWejqiVxRH
 SzpM+9VVrsjw09q+dGx8/M9JHJPwB34WtpNtMk7B9oWBIK/K5C0doHOmywA7zjIXlnudE6
 zjLpic+tyM48AgWlIiL18y3xL6DIn9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744204946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yItTT8EZIAhKsZgt1oZXY6t9WsAC56SmSPJNLPG1S0=;
 b=9Lad3FoPF3AvBFW1gq6PEWiygBa/OirfDZNXZ7Nv6D0YWALprzC4qpd3ae2V/yJfwV3k4C
 CuLAO2RlGlMSliAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NFh2GPQy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Lad3FoP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744204946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yItTT8EZIAhKsZgt1oZXY6t9WsAC56SmSPJNLPG1S0=;
 b=NFh2GPQykGO/DwjBBm5s5+PVt5d8EQDt410w1n8zPSP3HrW7qawovGWexHdBeWejqiVxRH
 SzpM+9VVrsjw09q+dGx8/M9JHJPwB34WtpNtMk7B9oWBIK/K5C0doHOmywA7zjIXlnudE6
 zjLpic+tyM48AgWlIiL18y3xL6DIn9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744204946;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6yItTT8EZIAhKsZgt1oZXY6t9WsAC56SmSPJNLPG1S0=;
 b=9Lad3FoPF3AvBFW1gq6PEWiygBa/OirfDZNXZ7Nv6D0YWALprzC4qpd3ae2V/yJfwV3k4C
 CuLAO2RlGlMSliAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C6113691;
 Wed,  9 Apr 2025 13:22:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lqR9IZJ09mcmPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 09 Apr 2025 13:22:26 +0000
Date: Wed, 9 Apr 2025 15:22:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250409132224.GA304084@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-5-pvorel@suse.cz>
 <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com>
 <20250407145312.GA101494@pevik>
 <D91HUKSMMOZO.2YOCEDPG2QE0E@suse.com>
 <20250409081210.GA286967@pevik>
 <D923RP7LIXZZ.2QBXXZH9AOOS3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D923RP7LIXZZ.2QBXXZH9AOOS3@suse.com>
X-Rspamd-Queue-Id: BA6D81F390
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/5] Makefile: Update 'doc' target,
 add 'doc-clean'
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

Hi Ricardo,

...
> >> Right, I tried out something (below) which kind of works but it would require
> >> the setup target becoming the default... The sad part is that even if
> >> the user chooses not to use a virtualenv, linuxdoc does not seem to be
> >> packaged in the major distros (I checked Tumbleweed, Debian and Fedora
> >> only Fedora has it)

> > I'm surprised that any distro package linuxdoc. And IMHO all linux distros
> > require pip install to run inside virtualenv.


> I was surprise it isn't :(

IMHO kernel developers do very little packaging. And the rest does not care
about (it's not mandatory for building a distro kernel, it's only for publishing
on https://docs.kernel.org/). I would guess quite a lot of kernel maintainers
use Fedora (and Debian) maybe the reason why it's there.

> >> diff --git a/Makefile b/Makefile
> >> index 506678934983..69a8016535a9 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -41,7 +41,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
> >>  endif
> >>  endef

> >> -COMMON_TARGETS         += testcases tools metadata
> >> +COMMON_TARGETS         += testcases tools metadata doc

> > I was testing doc part of COMMON_TARGETS as well (that requires that
> > generic_leaf_target.mk to be included). But that means that doc will be always
> > built, which means that user either has linuxdoc and others installed as a
> > package or via 'make -C doc setup'.


> +1

> >>  # Don't want to nuke the original files if we're installing in-build-tree.
> >>  ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
> >> @@ -169,8 +169,8 @@ INSTALL_TARGETS             += $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))

> >>  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)

> >> -.PHONY: doc
> >> -doc: metadata-all
> >> +#.PHONY: doc
> >> +#doc: metadata-all

> > 'doc: metadata-all' is a part I suggested to be deleted (useless now).
> > But IMHO it should be replaced by other phony target - my plan was to use
> > generic_leaf_target.mk (reuse existing LTP build system instead writing from
> > scratch), but don't have doc/ part of build from top level Makefile (avoid
> > dealing with virtualenv). Therefore I guess at least doc target in this patchset
> > is more or less correct. Maybe having doc as a part of CLEAN_TARGETS
> > variable will work.

> Adding it to CLEAN_TARGETS will work, as it will create the `doc-clean`
> target.

+1. I hope it creates also doc-distclean (to remove doc/.venv).


> >>  .PHONY: check
> >>  check: $(CHECK_TARGETS)
> >> diff --git a/doc/Makefile b/doc/Makefile
> >> index 2062d6e93561..7f11e659cab8 100644
> >> --- a/doc/Makefile
> >> +++ b/doc/Makefile
> >> @@ -23,15 +23,17 @@ setup: $(VENV_DIR)
> >>  ${abs_top_builddir}/metadata/ltp.json:
> >>         $(MAKE) -C ${abs_top_builddir}/metadata

> >> -all: ${abs_top_builddir}/metadata/ltp.json
> >> +all: ${abs_top_builddir}/metadata/ltp.json setup
> >>         $(RUN_VENV); sphinx-build -b html . html

> > Using virtualenv by default was something which Andrea did not want (equivalent
> > of this was in my v1). And I agree we don't want packagers to deal with
> > virtualenv (FYI atm there are at least SUSE, Buildroot and Yocto packages; Red
> > hat plans to use it as well).


> Hm, but if we have a top-level target "doc" which setup the venv by
> default, it will be even more confusing... Maybe having both doc and
> doc-setup would make sense?

> With this, we can opt-in the venv by doing `make doc-setup` first. We
> can clean it with `make doc-clean` or the top-level `make clean` and
> `make distclean`

It is confusing, but it would be documented.

I wanted top level doc to be as easiest as possible. And generally have top
level targets as simple as possible (shortcuts - go to LTP git directory and
type short make target to have things done):

make -C doc # without venv

make doc # for venv
(shorter than make doc-setup; make doc)

But if you consider it too confusing, it's not that long the targets you
suggest. It'd be nice to have opinion from others.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
