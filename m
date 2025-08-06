Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716BC87FD1
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 11:52:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 389723C8289
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 13:52:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADAAB3C31D2
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:52:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 915F51000759
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:52:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AE5A1FD42;
 Wed,  6 Aug 2025 11:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754481139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1zG/H1Fa6GrIffIcDGFxYJT1S3ItwXqojuDoWMWomA=;
 b=LgOfVy+1N1EqpyFo9HgtR2u84vLKlktM2gTmse/3FQ+X7pdoqIXn3VdAX6Avl/pnppAm4I
 kZKgUBKx8K8utOkMy0rsj9J7kJT4qW55waDOXDzu8EFvbMXy8qW2XChskHU5+IRN+6mH0P
 wvvXnoOS8VSM7IsE+LplPeI2TvxpldU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754481139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1zG/H1Fa6GrIffIcDGFxYJT1S3ItwXqojuDoWMWomA=;
 b=zoiUoHOr7emd0i+lTq92RiWU3boj3SffbY2m1oTUCHH/5Fgtp6jKBA5gQQYUvze2cO35k7
 jh3aCoC1nu2zORAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LgOfVy+1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zoiUoHOr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754481139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1zG/H1Fa6GrIffIcDGFxYJT1S3ItwXqojuDoWMWomA=;
 b=LgOfVy+1N1EqpyFo9HgtR2u84vLKlktM2gTmse/3FQ+X7pdoqIXn3VdAX6Avl/pnppAm4I
 kZKgUBKx8K8utOkMy0rsj9J7kJT4qW55waDOXDzu8EFvbMXy8qW2XChskHU5+IRN+6mH0P
 wvvXnoOS8VSM7IsE+LplPeI2TvxpldU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754481139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1zG/H1Fa6GrIffIcDGFxYJT1S3ItwXqojuDoWMWomA=;
 b=zoiUoHOr7emd0i+lTq92RiWU3boj3SffbY2m1oTUCHH/5Fgtp6jKBA5gQQYUvze2cO35k7
 jh3aCoC1nu2zORAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B75113AA8;
 Wed,  6 Aug 2025 11:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GLr5BfNBk2iDTgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 06 Aug 2025 11:52:19 +0000
Date: Wed, 6 Aug 2025 13:52:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250806115217.GB431066@pevik>
References: <20250801100935.974351-1-pvorel@suse.cz>
 <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
 <CAEemH2c9h97nC6sj323oG2kDvkcEqxspA5DPRrgK=zGSpEFr6w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c9h97nC6sj323oG2kDvkcEqxspA5DPRrgK=zGSpEFr6w@mail.gmail.com>
X-Rspamd-Queue-Id: 4AE5A1FD42
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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

Hi Li, all,

> >> +MODULE_DIRS := commands/insmod \

> > Here should be:

> > -MODULE_DIRS := commands/insmod \
> > +MODULE_DIRS := testcases/commands/insmod \


> Or, if we avoid hard-coding the module dirs, then we don't need
> to amend it when adding new tests later.

> Something maybe like:

> -MODULE_DIRS := commands/insmod \
> -       testcases/kernel/firmware \
> -       testcases/kernel/device-drivers \
> -       testcases/kernel/syscalls/delete_module \
> -       testcases/kernel/syscalls/finit_module \
> -       testcases/kernel/syscalls/init_module
> +MODULE_DIRS := $(shell \
> +  find testcases/ -type f -name 'Makefile' | \
> +  xargs grep -l 'include.*module\.mk' | \
> +  xargs -n1 dirname | \
> +  sort -u \
> +)

nit: at least xargs could be avoided.

MODULE_DIRS := $(shell \
	dirname $(grep -l 'include.*module\.mk' $(find testcases/ -type f -name 'Makefile')) | sort -u
)

Although this works, I wonder if we want to depend on a shell detection like
this (I'd appreciate others' opinion).

Kind regards,
Petr

> >> +       testcases/kernel/firmware \
> >> +       testcases/kernel/device-drivers \
> >> +       testcases/kernel/syscalls/delete_module \
> >> +       testcases/kernel/syscalls/finit_module \
> >> +       testcases/kernel/syscalls/init_module
> >> +
> >> +.PHONY: modules modules-clean modules-install
> >> +modules:
> >> +       @$(foreach dir,$(MODULE_DIRS),\
> >> +               echo "Build $(dir)";\
> >> +               $(MAKE) -C $(abs_srcdir)/$(dir); \
> >> +)
> >> +modules-clean:
> >> +       @$(foreach dir,$(MODULE_DIRS),\
> >> +               echo "Build $(dir)";\
> >> +               $(MAKE) -C $(abs_srcdir)/$(dir) clean; \
> >> +)
> >> +modules-install: modules
> >> +       @$(foreach dir,$(MODULE_DIRS),\
> >> +               echo "Build $(dir)";\
> >> +               $(MAKE) -C $(abs_srcdir)/$(dir) install; \
> >> +)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
