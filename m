Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFDFC36002
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 08:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6408A3CB3EB
	for <ltp@archiver.kernel.org>; Wed,  9 Apr 2025 10:12:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67ACE3CA46A
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 10:12:19 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1FE561A010B6
 for <ltp@lists.linux.it>; Wed,  9 Apr 2025 10:12:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E0031F38D;
 Wed,  9 Apr 2025 08:12:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A600137AC;
 Wed,  9 Apr 2025 08:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sksRHOAr9mc6WQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 09 Apr 2025 08:12:16 +0000
Date: Wed, 9 Apr 2025 10:12:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250409081210.GA286967@pevik>
References: <20250328095747.169011-1-pvorel@suse.cz>
 <20250328095747.169011-5-pvorel@suse.cz>
 <D8RV9V5D07EO.ORPMFWGXAMSO@suse.com>
 <20250407145312.GA101494@pevik>
 <D91HUKSMMOZO.2YOCEDPG2QE0E@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D91HUKSMMOZO.2YOCEDPG2QE0E@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1E0031F38D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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

> >> > -doc: metadata-all
> >> > +doc:
> >> > +	$(MAKE) -C $(abs_builddir)/doc setup
> >> > +	$(MAKE) -C $(abs_builddir)/doc
> >> > +
> >> > +.PHONY: doc-clean
> >> > +doc-clean:
> >> > +	$(MAKE) -C $(abs_builddir)/doc clean

> >> IMO the top-level clean and distclean targets should be responsible of
> >> calling the respective targets in doc/Makefile, what do you think?

> > Well, we have in the top level other clean targets:
> > lib-clean, libs-clean, ac-clean, ac-distclean, ac-maintainer-clean.
> > Therefore I thought add at least doc-clean would be good. I ignored
> > doc-distclean.

> > Most of LTP is compiled and therefore handled by
> > include/mk/generic_leaf_target.mk. kirk and sparse are special (submodule anyway),
> > but even they allows to use generic_leaf_target.mk. I'm not sure if I want to
> > rewrite whole doc/Makefile to support generic_leaf_target.mk, I should, but my
> > goal was to simplify creating venv. I guess I drop this atm and send v5 and
> > without it and get to it later.


> Right, I tried out something (below) which kind of works but it would require
> the setup target becoming the default... The sad part is that even if
> the user chooses not to use a virtualenv, linuxdoc does not seem to be
> packaged in the major distros (I checked Tumbleweed, Debian and Fedora
> only Fedora has it)

I'm surprised that any distro package linuxdoc. And IMHO all linux distros
require pip install to run inside virtualenv.

> diff --git a/Makefile b/Makefile
> index 506678934983..69a8016535a9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -41,7 +41,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
>  endif
>  endef

> -COMMON_TARGETS         += testcases tools metadata
> +COMMON_TARGETS         += testcases tools metadata doc

I was testing doc part of COMMON_TARGETS as well (that requires that
generic_leaf_target.mk to be included). But that means that doc will be always
built, which means that user either has linuxdoc and others installed as a
package or via 'make -C doc setup'.

>  # Don't want to nuke the original files if we're installing in-build-tree.
>  ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
> @@ -169,8 +169,8 @@ INSTALL_TARGETS             += $(addprefix $(DESTDIR)/$(bindir)/,$(BINDIR_INSTALL_SCRIPTS))

>  $(INSTALL_TARGETS): $(INSTALL_DIR) $(DESTDIR)/$(bindir)

> -.PHONY: doc
> -doc: metadata-all
> +#.PHONY: doc
> +#doc: metadata-all

'doc: metadata-all' is a part I suggested to be deleted (useless now).
But IMHO it should be replaced by other phony target - my plan was to use
generic_leaf_target.mk (reuse existing LTP build system instead writing from
scratch), but don't have doc/ part of build from top level Makefile (avoid
dealing with virtualenv). Therefore I guess at least doc target in this patchset
is more or less correct. Maybe having doc as a part of CLEAN_TARGETS
variable will work.

>  .PHONY: check
>  check: $(CHECK_TARGETS)
> diff --git a/doc/Makefile b/doc/Makefile
> index 2062d6e93561..7f11e659cab8 100644
> --- a/doc/Makefile
> +++ b/doc/Makefile
> @@ -23,15 +23,17 @@ setup: $(VENV_DIR)
>  ${abs_top_builddir}/metadata/ltp.json:
>         $(MAKE) -C ${abs_top_builddir}/metadata

> -all: ${abs_top_builddir}/metadata/ltp.json
> +all: ${abs_top_builddir}/metadata/ltp.json setup
>         $(RUN_VENV); sphinx-build -b html . html

Using virtualenv by default was something which Andrea did not want (equivalent
of this was in my v1). And I agree we don't want packagers to deal with
virtualenv (FYI atm there are at least SUSE, Buildroot and Yocto packages; Red
hat plans to use it as well).

>  spelling:
>         $(RUN_VENV); sphinx-build -b spelling -d build/doctree . build/spelling

> -clean:
> +clean::
+1, I did not have enough time to figure out '::'.

>         rm -rf html/ build/ _static/syscalls.rst _static/tests.rst syscalls.tbl \
>                 ${abs_top_builddir}/metadata/ltp.json

> -distclean: clean
> +distclean:: clean
>         rm -rf $(VENV_DIR)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

> Thanks,
> 		rbm

> > Kind regards,
> > Petr

> > The rest of LTP final directories is handled by
> > include/mk/generic_leaf_target.mk, but doc/ is somehow special, that's why I
> > added these targets.

> > If you call make clean or distclean


> >> >  .PHONY: check
> >> >  check: $(CHECK_TARGETS)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
