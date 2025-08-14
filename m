Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4487FCA0EE4
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 13:19:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E8A43CBB28
	for <ltp@archiver.kernel.org>; Thu, 14 Aug 2025 15:19:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFA243C052E
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:19:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E74A6002C4
 for <ltp@lists.linux.it>; Thu, 14 Aug 2025 15:18:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A5441F458;
 Thu, 14 Aug 2025 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755177539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6ul1qNTspXPO3uNcUopR6VvGkr+WvfT2uUHMpPKdWk=;
 b=2g/6flqH3P7hxd3yPFQb+Dmg5+Uad3E+ppfkQmoaF0hZDEImZ6dUyFkh8tMf++ymDiGeS9
 3e6a0mjCVz0+HP7gWSIB/pdo0tsg5ADDCKDZYZly+uaEOgUdFe6Swk5z6FEK/JcTwonIG6
 C5UyQ+2QU5LRnE91tiaDGdMPTc0qVKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755177539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6ul1qNTspXPO3uNcUopR6VvGkr+WvfT2uUHMpPKdWk=;
 b=dL9ZD0HyxFFq6pW9npgQNK2zMpOjHSkXaZ0W53vvndOtxIzJ28WkSx+FnqUkcFZ7TdTQst
 0Lc7gZxR45lhAHDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755177539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6ul1qNTspXPO3uNcUopR6VvGkr+WvfT2uUHMpPKdWk=;
 b=2g/6flqH3P7hxd3yPFQb+Dmg5+Uad3E+ppfkQmoaF0hZDEImZ6dUyFkh8tMf++ymDiGeS9
 3e6a0mjCVz0+HP7gWSIB/pdo0tsg5ADDCKDZYZly+uaEOgUdFe6Swk5z6FEK/JcTwonIG6
 C5UyQ+2QU5LRnE91tiaDGdMPTc0qVKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755177539;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6ul1qNTspXPO3uNcUopR6VvGkr+WvfT2uUHMpPKdWk=;
 b=dL9ZD0HyxFFq6pW9npgQNK2zMpOjHSkXaZ0W53vvndOtxIzJ28WkSx+FnqUkcFZ7TdTQst
 0Lc7gZxR45lhAHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F6C5136AE;
 Thu, 14 Aug 2025 13:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cysiAkPinWi1ZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Aug 2025 13:18:59 +0000
Date: Thu, 14 Aug 2025 15:18:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250814131857.GB575710@pevik>
References: <20250807062941.348971-1-pvorel@suse.cz>
 <20250807062941.348971-2-pvorel@suse.cz>
 <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e1CbqCv8Bq4dJgBoRU2hJ72fPTsHJDYV8oLXRgs7SdAw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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

Hi Li,

> Hi Petr,

> I am still trying to make sure my understanding is correct on
> 'FORCE_MODULES=1',
> which one below do you mean:

>   1. If a subdirectory fails, it stops for that subdirectory but the
> top-level make
>       continues with the next directory in the list.

>   2. The top-level build should stop immediately when any subdirectory
> fails.

> If the answer is (1), I believe our current patch is correct (feel free to
> add my RBT).
> However, if the intended behavior is (2), we will need to amend the
> top-level Makefile
> to ensure the build stops at the first failure.

I intended 1., but exit afterwards non-zero on error. But this actually is not
true.  => v5 is needed.

The reason for 1. was to see which modules failed (all of them).
Maybe it'd be enough to implement 2.

This works for me (sending v5 today):
-               $(MAKE) -C $(abs_srcdir)/$(dir); \
+               $(MAKE) -C $(abs_srcdir)/$(dir); [ $$? -eq 0 ] || exit exit $$?; \

I wonder if it's enough to add the change only to 'modules' target or whether I
should add it to the others (modules-clean, modules-install) as well.

Kind regards,
Petr

...
> > +++ b/include/mk/module.mk
...
> > +define newline
> > +
> > +
> > +endef
> > +n := $(newline)
> > +
> > +$(info skip: $(SKIP), FORCE_MODULES: $(FORCE_MODULES))
> >  ifneq ($(SKIP),0)
> >  MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
> > +ifeq ($(FORCE_MODULES),1)
> > +$(error Kernel modules not built!$(n)\
> > +Check that package for building kernel modules for $(LINUX_VERSION)\
> > +is installed and try again.$(n)\
> > +* openSUSE/SLES: kernel-default-devel$(n)\
> > +* Fedora/RHEL: kernel-devel/kernel-headers$(n)\
> > +* Debian/Ubuntu: linux-kbuild$(n)\
> > +You can build anyway by omitting FORCE_MODULES=1)
> > +endif
> >  endif

> >  ifneq ($(filter install clean,$(MAKECMDGOALS)),)
> > @@ -45,6 +63,10 @@ MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko,
> > $(MAKE_TARGETS)))

> >  .dep_modules: $(MODULE_SOURCES)
> >         @echo "Building modules: $(MODULE_SOURCES)"
> > +ifneq ($(FORCE_MODULES),1)
> >         -$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> > +else
> > +       $(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
> > +endif
> >         rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd
> > Module.symvers
> >         @touch .dep_modules
> > --
> > 2.50.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
