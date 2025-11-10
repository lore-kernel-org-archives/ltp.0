Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA2DCCF9E3
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 08:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19E2B3CF58D
	for <ltp@archiver.kernel.org>; Mon, 10 Nov 2025 09:40:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF103CF53D
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:40:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9E54E1400330
 for <ltp@lists.linux.it>; Mon, 10 Nov 2025 09:40:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89BA233683;
 Mon, 10 Nov 2025 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762764029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtF7zLi/6oRcd9XkCaB06zeC4D4De2ky42omwLguLE8=;
 b=nvbPuLcd1J1ftirwiW3sYOxsbcYAGq3NErSmif/QHI2C4Wy0qiBAsYCYhybei+OlDeidia
 OTx66dcZ4xKsdl6JaAsL8esjlVp227kWWAoDnsS1QEb/zkrKtc0fJyUAcZgq+mx7mGjsf4
 lsqfq0lA5g5XpyQ5qhZxQ1eNu32lr6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762764029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtF7zLi/6oRcd9XkCaB06zeC4D4De2ky42omwLguLE8=;
 b=YOvFPpqEVwSJ0687o0PTtILp4N4+FxwNeEq//sxTLeHk+1gZIdr8qcyEK0FSAadcjk01a4
 9A6vPG739ff7GgBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762764029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtF7zLi/6oRcd9XkCaB06zeC4D4De2ky42omwLguLE8=;
 b=nvbPuLcd1J1ftirwiW3sYOxsbcYAGq3NErSmif/QHI2C4Wy0qiBAsYCYhybei+OlDeidia
 OTx66dcZ4xKsdl6JaAsL8esjlVp227kWWAoDnsS1QEb/zkrKtc0fJyUAcZgq+mx7mGjsf4
 lsqfq0lA5g5XpyQ5qhZxQ1eNu32lr6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762764029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtF7zLi/6oRcd9XkCaB06zeC4D4De2ky42omwLguLE8=;
 b=YOvFPpqEVwSJ0687o0PTtILp4N4+FxwNeEq//sxTLeHk+1gZIdr8qcyEK0FSAadcjk01a4
 9A6vPG739ff7GgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A91513BBE;
 Mon, 10 Nov 2025 08:40:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3wD6GP2kEWkTOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Nov 2025 08:40:29 +0000
Date: Mon, 10 Nov 2025 09:40:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251110084028.GA1244228@pevik>
References: <20251110-kirk_makefile_install_fix-v1-1-e3f01e0cd53e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110-kirk_makefile_install_fix-v1-1-e3f01e0cd53e@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: install only if sources are present
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

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  tools/kirk/Makefile | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/tools/kirk/Makefile b/tools/kirk/Makefile
> index 1a09c43ce..876eb3e2e 100644
> --- a/tools/kirk/Makefile
> +++ b/tools/kirk/Makefile
> @@ -10,13 +10,15 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  BASE_DIR		:= $(abspath $(DESTDIR)/$(prefix))

>  install:
> +ifneq ($(wildcard $(abs_srcdir)/kirk-src/libkirk/*.py),)

Maybe add:
Fixes: 4db20e7d79 ("kirk: move kirk source code inside tools/kirk/kirk-src")

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI tools/sparse/Makefile runs 'git submodule update --init' if source code
does not exists:

$(SPARSE_SRC)/Makefile:
ifeq ($(SPARSE_SRC),sparse-src)
	git submodule update --init
else
	$(error "Can't find $(SPARSE_SRC)/Makefile")
endif

Because it filters out tools/sparse in tools/Makefile, this gets applied only
when sparse is really needed (i.e. via 'make check' or cd into the directory).

>  	mkdir -p $(BASE_DIR)/libkirk
>  	mkdir -p $(BASE_DIR)/libkirk/channels

> -	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
> -	install -m 00644 $(top_srcdir)/tools/kirk/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
> -	install -m 00775 $(top_srcdir)/tools/kirk/kirk-src/kirk $(BASE_DIR)/kirk

Although I acked the change to move Makefile to LTP, thinking about it twice I'm
not convinced that it's a much better solution than keeping Makefile outside. I
understand you don't want to keep LTP specific Makefile in kirk, but having to
keep kirk paths in LTP is not optimal either (during experimenting with a
different version one will have to update the Makefile).

Kind regards,
Petr

> +	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/*.py $(BASE_DIR)/libkirk
> +	install -m 00644 $(abs_srcdir)/kirk-src/libkirk/channels/*.py $(BASE_DIR)/libkirk/channels
> +	install -m 00775 $(abs_srcdir)/kirk-src/kirk $(BASE_DIR)/kirk

>  	cd $(BASE_DIR) && ln -sf kirk runltp-ng
> +endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
