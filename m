Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29255606A31A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ah+7MED1;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZj4iU3/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ah+7MED1;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=IZj4iU3/
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5A643EA9DA
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 16:39:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6193E200A
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:38:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BE3A62001B6
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 16:38:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A788220F0;
 Mon, 23 Nov 2026 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795448333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+IpAWlkYY0DqQ6CSjsHpFMwdz9CNUjbge/6Ur8rIvM=;
 b=ah+7MED1ykNVSvXBYpWrUwElNPXO1fSmyN+/HoixIpxUSOa3Rl/DznTm951BB6GtVNalWm
 wDIuRf5d1ZHlyr7BCYJrwpWekLDHF5wF55i6aDR7oWd+KIcjQEr5btWl3MDneIMO6S5IFa
 ZG8cPW9dENxLVGWKxA8YtbjmxKBle5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795448333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+IpAWlkYY0DqQ6CSjsHpFMwdz9CNUjbge/6Ur8rIvM=;
 b=IZj4iU3/pN1TXkrmZPwSMIpVa31mNnKxpYU3I6eG/j4xaEkxQ9L38JNFdsHPUkod8yykgA
 uwqea94VVziUuWDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795448333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+IpAWlkYY0DqQ6CSjsHpFMwdz9CNUjbge/6Ur8rIvM=;
 b=ah+7MED1ykNVSvXBYpWrUwElNPXO1fSmyN+/HoixIpxUSOa3Rl/DznTm951BB6GtVNalWm
 wDIuRf5d1ZHlyr7BCYJrwpWekLDHF5wF55i6aDR7oWd+KIcjQEr5btWl3MDneIMO6S5IFa
 ZG8cPW9dENxLVGWKxA8YtbjmxKBle5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795448333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+IpAWlkYY0DqQ6CSjsHpFMwdz9CNUjbge/6Ur8rIvM=;
 b=IZj4iU3/pN1TXkrmZPwSMIpVa31mNnKxpYU3I6eG/j4xaEkxQ9L38JNFdsHPUkod8yykgA
 uwqea94VVziUuWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D5DE13510;
 Mon, 23 Nov 2026 15:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sb/6Bg1eBGtsJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Nov 2026 15:38:53 +0000
Date: Mon, 23 Nov 2026 16:39:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <awReJ8ld5eLzuyi7@yuki.lan>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[linux.it:url,suse.cz:email,imap1.dmz-prg2.suse.org:helo,generic_leaf_target.mk:url,generic_trunk_target.mk:url,suse.com:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] build: Build shared libs once on subtree
 make
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> When make is invoked directly in a trunk subdirectory (MAKELEVEL == 0),
> build shared prerequisites (libltp.a, libs, and libkerntest.a) once
> via MAKE_DEPS before launching parallel subdirectory builds.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/mk/generic_trunk_target.inc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

I think this is added to a wrong file. The build isn't triggered from
leaf directories, e.g. testcases/kernel/syscalls/accept/

I suppose that it should go to a separate file
include/mk/generic_lib_deps.inc and should be included from both
generic_trunk_target.mk and generic_leaf_target.mk.

> diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> index f9db7896a..aa8e500e1 100644
> --- a/include/mk/generic_trunk_target.inc
> +++ b/include/mk/generic_trunk_target.inc
> @@ -36,6 +36,29 @@ RECURSIVE_TARGETS		?= all install check
>  
>  $(eval $(get_make_dirs))
>  
> +ifeq ($(MAKELEVEL),0)
> +ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)
> +MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a $(abs_top_builddir)/libs-all

These two targets should be .PHONY so that the libraries are properly
rebuild on:

touch lib/*.c
cd testcases/kernel/syscalls/
make

> +$(abs_top_builddir)/lib/libltp.a:
> +	mkdir -m 00755 -p "$(abs_top_builddir)/lib"
> +	$(MAKE) -C "$(abs_top_builddir)/lib" -f "$(abs_top_srcdir)/lib/Makefile" all
> +
> +.PHONY: $(abs_top_builddir)/libs-all
> +$(abs_top_builddir)/libs-all: $(LTPLIBS_FILES)
> +	mkdir -m 00755 -p "$(abs_top_builddir)/libs"
> +	$(MAKE) -C "$(abs_top_builddir)/libs" -f "$(abs_top_srcdir)/libs/Makefile" all
> +endif
> +
> +ifneq ($(filter $(abs_top_builddir)/testcases/kernel/%,$(CURDIR)),)
> +MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
> +
> +$(abs_top_builddir)/testcases/kernel/lib/libkerntest.a:
> +	mkdir -m 00755 -p "$(abs_top_builddir)/testcases/kernel/lib"
> +	$(MAKE) -C "$(abs_top_builddir)/testcases/kernel/lib" -f "$(abs_top_srcdir)/testcases/kernel/lib/Makefile" all
> +endif
> +endif
> +
>  .PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>  
>  $(SUBDIRS): %:
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
