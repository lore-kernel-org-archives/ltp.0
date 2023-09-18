Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84109CD37B0
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 09:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 552A33CE4E8
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:18:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6705A3CA9AE
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:17:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B0F2F2010E0
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 11:17:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F18201F892;
 Mon, 18 Sep 2023 09:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695028677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESx05X4uNL9RpttWk16f6ryOc705RJUv+PxNJeiexpw=;
 b=NA8MaG7mVwB8Yz2M3maiu6XGyefPePkHq24ddQiTGSMkwrJ5LOwdLFw9PDpfiu64+12x4o
 /yDZCk40zrFyHqIRqnKxHRKhFxWYf+Zj2x2s/b3oKJVT4cSmD2Br25yeJJtints1YIMdnc
 T4IhuOZ0UgiZ+FXALwprexZ1EaMW05w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695028677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ESx05X4uNL9RpttWk16f6ryOc705RJUv+PxNJeiexpw=;
 b=swmvhoyj6wYyoom/7K868uc/frbFDBRuR0ByOPRUmguEcrWASW34LEWVOn/hHq/eVys+nk
 PpG8YWjEMA0LXqCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5BAF13480;
 Mon, 18 Sep 2023 09:17:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aWLbMsUVCGVTEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 09:17:57 +0000
Date: Mon, 18 Sep 2023 11:17:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230918091756.GB30304@pevik>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
 <20230918082506.17464-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918082506.17464-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add Linux Test eXecutor inside tools
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> The ltx program runs on the system under test (SUT). It's primary
> purpose is to run test executables in parallel and serialise the
> results.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .gitmodules        |  3 +++
>  tools/ltx/Makefile | 31 +++++++++++++++++++++++++++++++
>  tools/ltx/ltx-src  |  1 +
>  3 files changed, 35 insertions(+)
>  create mode 100644 tools/ltx/Makefile
>  create mode 160000 tools/ltx/ltx-src

> diff --git a/.gitmodules b/.gitmodules
> index c389186c9..2a8b7a399 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -10,3 +10,6 @@
>  [submodule "tools/kirk"]
>  	path = tools/kirk
>  	url = https://github.com/linux-test-project/kirk.git
> +[submodule "tools/ltx/ltx-src"]
> +	path = tools/ltx/ltx-src
> +	url = https://github.com/linux-test-project/ltx.git
> diff --git a/tools/ltx/Makefile b/tools/ltx/Makefile
> new file mode 100644
> index 000000000..4810ec8df
> --- /dev/null
> +++ b/tools/ltx/Makefile
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2023 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2023 Andrea Cervesato <andrea.cervesato@suse.com>
> +#
> +# Install script for Linux Test eXecutor
> +
> +top_srcdir		?= ../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +ifneq ($(wildcard $(abs_srcdir)/ltx-src/*),)
> +
> +BINARY=ltx
> +
> +MAKE_TARGETS := $(BINARY)
> +
> +CFLAGS+=-I$(abs_srcdir)/ltx-src/ -I$(abs_srcdir)/ltx-src/msgpack/
> +
> +$(BINARY): $(wildcard $(abs_srcdir)/ltx-src/*.c $(abs_srcdir)/ltx-src/msgpack/*.c)
> +ifdef VERBOSE
> +	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +else
> +	@echo CC $@
> +	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
> +endif
This works, but why we don't use approach used for sparc, i.e.

$(MAKE) -C ltx-src

That way we would not have to redefine the default rules.

Also it detects missing git clone and runs
git submodule update --init if needed.

I'm asking for a same approach, not only because later we can unify and reuse
the code in some make helper, but also because it'd be more user friendly if our
new git submodules work the same way.

But if there is not enough time before release I would not be against this.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
