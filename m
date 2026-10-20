Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD9606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=DgAFRPnb;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=b0Al4Vbb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=F7TlES9a;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3453MQUT
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C72FB3E2D94
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 22:15:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0E63E0EA5
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 22:15:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EFDE4140026A
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 22:15:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFA2A1F807;
 Tue, 20 Oct 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792527333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1bSBpWNYKXEJbflU1WLoVHGbMuhM8Twp9Y30g5Qe3s=;
 b=DgAFRPnbiEc+z/S7Zd2i6ZOqI6/my78plhIPrYAiWq9ID/1/BcLzcJMXqL20UrxZsPHH8x
 cQW/BOzEs/6Hf117slxX0gP9gK3H1lpt5+yVG++YTcxYdrI6TSZVi1rGSku9iVsEUzZ+CL
 yrAUGC/jVi97VHJXoRPel+VgDRDJlC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792527333;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1bSBpWNYKXEJbflU1WLoVHGbMuhM8Twp9Y30g5Qe3s=;
 b=b0Al4VbbXAI40XmASoCCgGg1Cw9cYJJxAtFVKH8djgp/CCjNF8Wn4UqpUpezcpaXDr5Udq
 VbYlZdMT5Xz/3gDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792527332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1bSBpWNYKXEJbflU1WLoVHGbMuhM8Twp9Y30g5Qe3s=;
 b=F7TlES9aD4olSpcCq/FJLi+V/te+ZFzSd0V4xUqnFaCZ4ks6Tre6QWlOoBjz2cYQyIc5/+
 VthTEh72P06wIkacV2HFAZjiAP1dYTPZO+IuAVj3zif3HRBd6/Bpj6jiLLsf9TFPjZF0kh
 3QaFSl6xREJKOimhaxFQMvbCTjtU6Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792527332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1bSBpWNYKXEJbflU1WLoVHGbMuhM8Twp9Y30g5Qe3s=;
 b=3453MQUTJbp7k2Z88UQgnAbtVExpsoW9BYNKQO5zyRTtf29LqMgQZy3AP18FRpDMv9eD7v
 14nZoKmna5UbTKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEE9B136C6;
 Tue, 20 Oct 2026 20:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l0lWHuTL12ptLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 20 Oct 2026 20:15:32 +0000
Date: Tue, 20 Oct 2026 22:15:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20261020201531.GA154402@pevik>
References: <20261020-build_system_optimize-v1-1-744f9fa88908@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261020-build_system_optimize-v1-1-744f9fa88908@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -7.50
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] build: Parallelize subdirectory recursion in
 generic_trunk_target
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

thanks for the speedup.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
...

> +# Recurse into subdirectories in parallel instead of using a serial shell loop.
> +# Each subdirectory is mapped to a phony target (<dir>-all, <dir>-install, etc.).
> +# GNU Make can then schedule sibling directories concurrently under -jN.
> +all:     $(addsuffix -all,$(SUBDIRS))
> +install: $(addsuffix -install,$(SUBDIRS))
> +check:   $(addsuffix -check,$(SUBDIRS))
> +
> +.PHONY: $(addsuffix -all,$(SUBDIRS)) $(addsuffix -install,$(SUBDIRS)) $(addsuffix -check,$(SUBDIRS))
> +
> +# For each target (e.g. 'open-all'), strip the suffix to get the directory name,
> +# build trunk-local targets first, and ensure the subdirectory exists.
> +$(addsuffix -all,$(SUBDIRS)): trunk-all | $(SUBDIRS) $(MAKE_DEPS)
>  ifdef VERBOSE
> -	@set -e; for dir in $(SUBDIRS); do \
> -	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> -	done
Yeah, replacing shell for loop which is single process only to make processing
makes sense.

> +	$(MAKE) -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
>  else
> -	@set -e; for dir in $(SUBDIRS); do \
> -	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> -	done
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
> +endif
> +
> +$(addsuffix -install,$(SUBDIRS)): trunk-install | $(SUBDIRS) $(MAKE_DEPS)
> +ifdef VERBOSE
> +	$(MAKE) -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> +else
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> +endif
> +
> +$(addsuffix -check,$(SUBDIRS)): trunk-check | $(SUBDIRS) $(MAKE_DEPS)
> +ifdef VERBOSE
> +	$(MAKE) -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
> +else
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
>  endif
>  endif

> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 29e26742d..3bf5e433e 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -54,3 +54,6 @@ FILTER_OUT_DIRS		+= containers controllers device-drivers fs io ipc mem \
>  endif

>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> +
> +# libkerntest.a in lib/ must be built before syscalls and mem consumers
> +syscalls-all mem-all: lib-all

I wonder if this can be autogenerated, because this was not needed before.

I'm ok with this explicit definition. Probably in the future we should move it
to libs/ (using it as LTPLIBS), which will solve the dependency.

> diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
> index 6ecb1a665..8d12bdf1e 100644
> --- a/testcases/network/rpc/Makefile
> +++ b/testcases/network/rpc/Makefile
> @@ -9,3 +9,6 @@ include $(top_srcdir)/include/mk/env_pre.mk
>  INSTALL_TARGETS		:= *.sh

>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> +
> +# librpc-tirpc.a in rpc-tirpc/ must be built before basic_tests
> +basic_tests-all: rpc-tirpc-all

Also librpc-tirpc.a should be moved into libs/ (if we still keep this code and
not move it to libtirpc project where it'd make more sense).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
