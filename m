Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB62FCCFA13
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 09:17:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08BA03CF57C
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 10:17:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9140B3CF553
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:16:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCFD014002D9
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 10:16:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F85D1F397;
 Mon, 10 Nov 2025 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762766215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCkNrcRCiyGmoldokA3TF0RtnOk+c6B9Z2Zaw032L7c=;
 b=2ophQVVB78Afj/Bniccwu2NHbJacNUYpAZZiAu32h5lQsYS+Rh2Kg653lHkzP5DLifwHbf
 fprP2KYa5NN3jLcgj6cdkCBRdSS3IIe8XHnFadP/vKxolau5X4g/VMjanhivrrjR/XjZhT
 +dQIWQ3/6yaXGpP0BmchWubd+gXG+EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762766215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCkNrcRCiyGmoldokA3TF0RtnOk+c6B9Z2Zaw032L7c=;
 b=rjJX0u79L7W8hrMIrzVb4IGXDSDUHO9LHodgmOfa/1ac/Az6HZsu6C3N9IlqE3yJ5T0QyO
 +IlO8HmR47NMRSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762766215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCkNrcRCiyGmoldokA3TF0RtnOk+c6B9Z2Zaw032L7c=;
 b=2ophQVVB78Afj/Bniccwu2NHbJacNUYpAZZiAu32h5lQsYS+Rh2Kg653lHkzP5DLifwHbf
 fprP2KYa5NN3jLcgj6cdkCBRdSS3IIe8XHnFadP/vKxolau5X4g/VMjanhivrrjR/XjZhT
 +dQIWQ3/6yaXGpP0BmchWubd+gXG+EI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762766215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dCkNrcRCiyGmoldokA3TF0RtnOk+c6B9Z2Zaw032L7c=;
 b=rjJX0u79L7W8hrMIrzVb4IGXDSDUHO9LHodgmOfa/1ac/Az6HZsu6C3N9IlqE3yJ5T0QyO
 +IlO8HmR47NMRSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8721813BE4;
 Mon, 10 Nov 2025 09:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +KMqIIetEWlEXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Nov 2025 09:16:55 +0000
Date: Mon, 10 Nov 2025 10:16:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251110091646.GA1246253@pevik>
References: <20251110-kirk_makefile_install_fix-v2-1-d1f61d4fa23a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110-kirk_makefile_install_fix-v2-1-d1f61d4fa23a@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kirk: install only if sources are present
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

> Fix kirk Makefile, so source code is copied during install process
> only if it's present.

> Fixes: 4db20e7d79 ("kirk: move kirk source code inside tools/kirk/kirk-src")
+1, thank you.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v2:
> - git submodule --init if we are inside the folder or during make check
> - Link to v1: https://lore.kernel.org/r/20251110-kirk_makefile_install_fix-v1-1-e3f01e0cd53e@suse.com
> ---
>  tools/kirk/Makefile | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

> diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
> index 1a09c43ce..10c45789c 100644
> --- a/tools/kirk/Makefile
> +++ b/tools/kirk/Makefile
> @@ -8,15 +8,25 @@ top_srcdir		?= ../..
>  include $(top_srcdir)/include/mk/env_pre.mk

>  BASE_DIR		:= $(abspath $(DESTDIR)/$(prefix))
> +KIRK_SRC		?= kirk-src

Is it really useful to have directory optional? (I'm not sure this is useful for
sparse).

> +
> +$(KIRK_SRC)/Makefile:
> +ifeq ($(KIRK_SRC),sparse-src)
> +	git submodule update --init

This will always run "git submodule update --init" even on top level make
install. This requires "make install" to have internet connection. Therefore I
would prefer to skip kirk on top level "make install".

-FILTER_OUT_DIRS		+= sparse
+FILTER_OUT_DIRS		+= kirk sparse

And what is the difference? I see slightly better having:
'cd tools/kirk && make && make install' than
'git submodule init tools/ltx/ltx-src' or
'git submodule update --init'.

If you don't agree, I'm not against the first version.

Kind regards,
Petr

> +else
> +	$(error "Can't find $(KIRK_SRC)/Makefile")
> +endif

>  install:
> +ifneq ($(wildcard $(abs_srcdir)/kirk-src/libkirk/*.py),)
>  	mkdir -p $(BASE_DIR)/libkirk
>  	mkdir -p $(BASE_DIR)/libkirk/channels

> -	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
> -	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
> -	install -m 00775 $(top_srcdir)/tools/kirk/kirk-src/kirk $(BASE_DIR)/kirk
> +	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
> +	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
> +	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/kirk

>  	cd $(BASE_DIR) && ln -sf kirk runltp-ng
> +endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
