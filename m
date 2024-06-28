Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA55C2BD09
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 16:16:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082A63D4395
	for <ltp@archiver.kernel.org>; Fri, 28 Jun 2024 18:16:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E1253D04D2
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 18:16:00 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 210DC1036E3E
 for <ltp@lists.linux.it>; Fri, 28 Jun 2024 18:15:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1888621A05;
 Fri, 28 Jun 2024 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719591356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/W3Vj5KhTo11+COvGCE0/PcNUTaukjixfz/HNIwwmY=;
 b=B6CkfMPRoIThKzS/2lebCTfgdfbzDKbPwVYKm9FglnZRwwLBHhEJH1jHCzI618wn/eZrvc
 1YLC4x/bqXHFHWNS7uA83WORLUI4kbnVi1Dbcc9G6ZOw/Ba9+09vuWxaXYb8fu6udISw5R
 405OPRYO2pyhUGcc068ZCrrRdT2lJYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719591356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/W3Vj5KhTo11+COvGCE0/PcNUTaukjixfz/HNIwwmY=;
 b=nPltiYxfC37DjyGkL+TTOfy09CsXLlWSwvrFgJ4wH0a8w2gyH3URyaY385AIeC69JdLJnp
 btGjoC6E7Xy8aZCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719591356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/W3Vj5KhTo11+COvGCE0/PcNUTaukjixfz/HNIwwmY=;
 b=B6CkfMPRoIThKzS/2lebCTfgdfbzDKbPwVYKm9FglnZRwwLBHhEJH1jHCzI618wn/eZrvc
 1YLC4x/bqXHFHWNS7uA83WORLUI4kbnVi1Dbcc9G6ZOw/Ba9+09vuWxaXYb8fu6udISw5R
 405OPRYO2pyhUGcc068ZCrrRdT2lJYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719591356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9/W3Vj5KhTo11+COvGCE0/PcNUTaukjixfz/HNIwwmY=;
 b=nPltiYxfC37DjyGkL+TTOfy09CsXLlWSwvrFgJ4wH0a8w2gyH3URyaY385AIeC69JdLJnp
 btGjoC6E7Xy8aZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0260113375;
 Fri, 28 Jun 2024 16:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OMtCALzhfmaYMgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 28 Jun 2024 16:15:55 +0000
Date: Fri, 28 Jun 2024 18:15:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zn7hrQn67hNGZSuk@yuki>
References: <20231201005902.15630-1-wegao@suse.com>
 <20240603103553.8318-1-wegao@suse.com>
 <20240603103553.8318-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240603103553.8318-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] ptrace06: Refactor the test using new LTP
 API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/*\
> + * [Description]
> + *
>   * check out-of-bound/unaligned addresses given to
> + *
>   *  - {PEEK,POKE}{DATA,TEXT,USER}
>   *  - {GET,SET}{,FG}REGS
>   *  - {GET,SET}SIGINFO
> - *
> - * Copyright (c) 2008 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later
>   */
>  
> -#define _GNU_SOURCE
> -
> -#include <errno.h>
> -#include <stdbool.h>
> -#include <stdio.h>
>  #include <stdlib.h>
> -#include <unistd.h>
>  #include <sys/ptrace.h>
> -
> -#include "test.h"
> -#include "spawn_ptrace_child.h"
> +#include "tst_test.h"
>  
>  /* this should be sizeof(struct user), but that info is only found
>   * in the kernel asm/user.h which is not exported to userspace.
>   */
> +
>  #if defined(__i386__)
>  #define SIZEOF_USER 284
>  #elif defined(__x86_64__)
> @@ -32,168 +31,215 @@
>  #define SIZEOF_USER 0x1000	/* just pick a big number */
>  #endif
>  
> -char *TCID = "ptrace06";
> -
> -struct test_case_t {
> +static struct test_case_t {
>  	int request;
>  	long addr;
>  	long data;
>  } test_cases[] = {
> -	{
> -	PTRACE_PEEKDATA,.addr = 0}, {
> -	PTRACE_PEEKDATA,.addr = 1}, {
> -	PTRACE_PEEKDATA,.addr = 2}, {
> -	PTRACE_PEEKDATA,.addr = 3}, {
> -	PTRACE_PEEKDATA,.addr = -1}, {
> -	PTRACE_PEEKDATA,.addr = -2}, {
> -	PTRACE_PEEKDATA,.addr = -3}, {
> -	PTRACE_PEEKDATA,.addr = -4}, {
> -	PTRACE_PEEKTEXT,.addr = 0}, {
> -	PTRACE_PEEKTEXT,.addr = 1}, {
> -	PTRACE_PEEKTEXT,.addr = 2}, {
> -	PTRACE_PEEKTEXT,.addr = 3}, {
> -	PTRACE_PEEKTEXT,.addr = -1}, {
> -	PTRACE_PEEKTEXT,.addr = -2}, {
> -	PTRACE_PEEKTEXT,.addr = -3}, {
> -	PTRACE_PEEKTEXT,.addr = -4}, {
> -	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 1}, {
> -	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 2}, {
> -	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 3}, {
> -	PTRACE_PEEKUSER,.addr = SIZEOF_USER + 4}, {
> -	PTRACE_PEEKUSER,.addr = -1}, {
> -	PTRACE_PEEKUSER,.addr = -2}, {
> -	PTRACE_PEEKUSER,.addr = -3}, {
> -	PTRACE_PEEKUSER,.addr = -4}, {
> -	PTRACE_POKEDATA,.addr = 0}, {
> -	PTRACE_POKEDATA,.addr = 1}, {
> -	PTRACE_POKEDATA,.addr = 2}, {
> -	PTRACE_POKEDATA,.addr = 3}, {
> -	PTRACE_POKEDATA,.addr = -1}, {
> -	PTRACE_POKEDATA,.addr = -2}, {
> -	PTRACE_POKEDATA,.addr = -3}, {
> -	PTRACE_POKEDATA,.addr = -4}, {
> -	PTRACE_POKETEXT,.addr = 0}, {
> -	PTRACE_POKETEXT,.addr = 1}, {
> -	PTRACE_POKETEXT,.addr = 2}, {
> -	PTRACE_POKETEXT,.addr = 3}, {
> -	PTRACE_POKETEXT,.addr = -1}, {
> -	PTRACE_POKETEXT,.addr = -2}, {
> -	PTRACE_POKETEXT,.addr = -3}, {
> -	PTRACE_POKETEXT,.addr = -4}, {
> -	PTRACE_POKEUSER,.addr = SIZEOF_USER + 1}, {
> -	PTRACE_POKEUSER,.addr = SIZEOF_USER + 2}, {
> -	PTRACE_POKEUSER,.addr = SIZEOF_USER + 3}, {
> -	PTRACE_POKEUSER,.addr = SIZEOF_USER + 4}, {
> -	PTRACE_POKEUSER,.addr = -1}, {
> -	PTRACE_POKEUSER,.addr = -2}, {
> -	PTRACE_POKEUSER,.addr = -3}, {
> -	PTRACE_POKEUSER,.addr = -4},
> +	{PTRACE_PEEKDATA, .addr = 0},
> +	{PTRACE_PEEKDATA, .addr = 1},
> +	{PTRACE_PEEKDATA, .addr = 2},
> +	{PTRACE_PEEKDATA, .addr = 3},
> +	{PTRACE_PEEKDATA, .addr = -1},
> +	{PTRACE_PEEKDATA, .addr = -2},
> +	{PTRACE_PEEKDATA, .addr = -3},
> +	{PTRACE_PEEKDATA, .addr = -4},
> +	{PTRACE_PEEKTEXT, .addr = 0},
> +	{PTRACE_PEEKTEXT, .addr = 1},
> +	{PTRACE_PEEKTEXT, .addr = 2},
> +	{PTRACE_PEEKTEXT, .addr = 3},
> +	{PTRACE_PEEKTEXT, .addr = -1},
> +	{PTRACE_PEEKTEXT, .addr = -2},
> +	{PTRACE_PEEKTEXT, .addr = -3},
> +	{PTRACE_PEEKTEXT, .addr = -4},
> +	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1},
> +	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2},
> +	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3},
> +	{PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4},
> +	{PTRACE_PEEKUSER, .addr = -1},
> +	{PTRACE_PEEKUSER, .addr = -2},
> +	{PTRACE_PEEKUSER, .addr = -3},
> +	{PTRACE_PEEKUSER, .addr = -4},
> +	{PTRACE_POKEDATA, .addr = 0},
> +	{PTRACE_POKEDATA, .addr = 1},
> +	{PTRACE_POKEDATA, .addr = 2},
> +	{PTRACE_POKEDATA, .addr = 3},
> +	{PTRACE_POKEDATA, .addr = -1},
> +	{PTRACE_POKEDATA, .addr = -2},
> +	{PTRACE_POKEDATA, .addr = -3},
> +	{PTRACE_POKEDATA, .addr = -4},
> +	{PTRACE_POKETEXT, .addr = 0},
> +	{PTRACE_POKETEXT, .addr = 1},
> +	{PTRACE_POKETEXT, .addr = 2},
> +	{PTRACE_POKETEXT, .addr = 3},
> +	{PTRACE_POKETEXT, .addr = -1},
> +	{PTRACE_POKETEXT, .addr = -2},
> +	{PTRACE_POKETEXT, .addr = -3},
> +	{PTRACE_POKETEXT, .addr = -4},
> +	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 1},
> +	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 2},
> +	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 3},
> +	{PTRACE_POKEUSER, .addr = SIZEOF_USER + 4},
> +	{PTRACE_POKEUSER, .addr = -1},
> +	{PTRACE_POKEUSER, .addr = -2},
> +	{PTRACE_POKEUSER, .addr = -3},
> +	{PTRACE_POKEUSER, .addr = -4},
>  #ifdef PTRACE_GETREGS
> -	{
> -	PTRACE_GETREGS,.data = 0}, {
> -	PTRACE_GETREGS,.data = 1}, {
> -	PTRACE_GETREGS,.data = 2}, {
> -	PTRACE_GETREGS,.data = 3}, {
> -	PTRACE_GETREGS,.data = -1}, {
> -	PTRACE_GETREGS,.data = -2}, {
> -	PTRACE_GETREGS,.data = -3}, {
> -	PTRACE_GETREGS,.data = -4},
> +	{PTRACE_GETREGS, .data = 0},
> +	{PTRACE_GETREGS, .data = 1},
> +	{PTRACE_GETREGS, .data = 2},
> +	{PTRACE_GETREGS, .data = 3},
> +	{PTRACE_GETREGS, .data = -1},
> +	{PTRACE_GETREGS, .data = -2},
> +	{PTRACE_GETREGS, .data = -3},
> +	{PTRACE_GETREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_GETFGREGS
> -	{
> -	PTRACE_GETFGREGS,.data = 0}, {
> -	PTRACE_GETFGREGS,.data = 1}, {
> -	PTRACE_GETFGREGS,.data = 2}, {
> -	PTRACE_GETFGREGS,.data = 3}, {
> -	PTRACE_GETFGREGS,.data = -1}, {
> -	PTRACE_GETFGREGS,.data = -2}, {
> -	PTRACE_GETFGREGS,.data = -3}, {
> -	PTRACE_GETFGREGS,.data = -4},
> +	{PTRACE_GETFGREGS, .data = 0},
> +	{PTRACE_GETFGREGS, .data = 1},
> +	{PTRACE_GETFGREGS, .data = 2},
> +	{PTRACE_GETFGREGS, .data = 3},
> +	{PTRACE_GETFGREGS, .data = -1},
> +	{PTRACE_GETFGREGS, .data = -2},
> +	{PTRACE_GETFGREGS, .data = -3},
> +	{PTRACE_GETFGREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_SETREGS
> -	{
> -	PTRACE_SETREGS,.data = 0}, {
> -	PTRACE_SETREGS,.data = 1}, {
> -	PTRACE_SETREGS,.data = 2}, {
> -	PTRACE_SETREGS,.data = 3}, {
> -	PTRACE_SETREGS,.data = -1}, {
> -	PTRACE_SETREGS,.data = -2}, {
> -	PTRACE_SETREGS,.data = -3}, {
> -	PTRACE_SETREGS,.data = -4},
> +	{PTRACE_SETREGS, .data = 0},
> +	{PTRACE_SETREGS, .data = 1},
> +	{PTRACE_SETREGS, .data = 2},
> +	{PTRACE_SETREGS, .data = 3},
> +	{PTRACE_SETREGS, .data = -1},
> +	{PTRACE_SETREGS, .data = -2},
> +	{PTRACE_SETREGS, .data = -3},
> +	{PTRACE_SETREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_SETFGREGS
> -	{
> -	PTRACE_SETFGREGS,.data = 0}, {
> -	PTRACE_SETFGREGS,.data = 1}, {
> -	PTRACE_SETFGREGS,.data = 2}, {
> -	PTRACE_SETFGREGS,.data = 3}, {
> -	PTRACE_SETFGREGS,.data = -1}, {
> -	PTRACE_SETFGREGS,.data = -2}, {
> -	PTRACE_SETFGREGS,.data = -3}, {
> -	PTRACE_SETFGREGS,.data = -4},
> +	{PTRACE_SETFGREGS, .data = 0},
> +	{PTRACE_SETFGREGS, .data = 1},
> +	{PTRACE_SETFGREGS, .data = 2},
> +	{PTRACE_SETFGREGS, .data = 3},
> +	{PTRACE_SETFGREGS, .data = -1},
> +	{PTRACE_SETFGREGS, .data = -2},
> +	{PTRACE_SETFGREGS, .data = -3},
> +	{PTRACE_SETFGREGS, .data = -4},
>  #endif
>  #if HAVE_DECL_PTRACE_GETSIGINFO
> -	{
> -	PTRACE_GETSIGINFO,.data = 0}, {
> -	PTRACE_GETSIGINFO,.data = 1}, {
> -	PTRACE_GETSIGINFO,.data = 2}, {
> -	PTRACE_GETSIGINFO,.data = 3}, {
> -	PTRACE_GETSIGINFO,.data = -1}, {
> -	PTRACE_GETSIGINFO,.data = -2}, {
> -	PTRACE_GETSIGINFO,.data = -3}, {
> -	PTRACE_GETSIGINFO,.data = -4},
> +	{PTRACE_GETSIGINFO, .data = 0},
> +	{PTRACE_GETSIGINFO, .data = 1},
> +	{PTRACE_GETSIGINFO, .data = 2},
> +	{PTRACE_GETSIGINFO, .data = 3},
> +	{PTRACE_GETSIGINFO, .data = -1},
> +	{PTRACE_GETSIGINFO, .data = -2},
> +	{PTRACE_GETSIGINFO, .data = -3},
> +	{PTRACE_GETSIGINFO, .data = -4},
>  #endif
>  #if HAVE_DECL_PTRACE_SETSIGINFO
> -	{
> -	PTRACE_SETSIGINFO,.data = 0}, {
> -	PTRACE_SETSIGINFO,.data = 1}, {
> -	PTRACE_SETSIGINFO,.data = 2}, {
> -	PTRACE_SETSIGINFO,.data = 3}, {
> -	PTRACE_SETSIGINFO,.data = -1}, {
> -	PTRACE_SETSIGINFO,.data = -2}, {
> -	PTRACE_SETSIGINFO,.data = -3}, {
> -	PTRACE_SETSIGINFO,.data = -4},
> +	{PTRACE_SETSIGINFO, .data = 0},
> +	{PTRACE_SETSIGINFO, .data = 1},
> +	{PTRACE_SETSIGINFO, .data = 2},
> +	{PTRACE_SETSIGINFO, .data = 3},
> +	{PTRACE_SETSIGINFO, .data = -1},
> +	{PTRACE_SETSIGINFO, .data = -2},
> +	{PTRACE_SETSIGINFO, .data = -3},
> +	{PTRACE_SETSIGINFO, .data = -4},
>  #endif
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> +#define SPT(x)[PTRACE_##x] = #x,
> +static char *strings[] = {
> +	SPT(TRACEME)
> +	SPT(PEEKTEXT)
> +	SPT(PEEKDATA)
> +	SPT(PEEKUSER)
> +	SPT(POKETEXT)
> +	SPT(POKEDATA)
> +	SPT(POKEUSER)
> +#ifdef PTRACE_GETREGS
> +	SPT(GETREGS)
> +#endif
> +#ifdef PTRACE_SETREGS
> +	SPT(SETREGS)
> +#endif
> +#ifdef PTRACE_GETSIGINFO
> +	SPT(GETSIGINFO)
> +#endif
> +#ifdef PTRACE_SETSIGINFO
> +	SPT(SETSIGINFO)
> +#endif
> +#ifdef PTRACE_GETFGREGS
> +	SPT(GETFGREGS)
> +#endif
> +#ifdef PTRACE_SETFGREGS
> +	SPT(SETFGREGS)
> +#endif
> +	SPT(KILL)
> +	SPT(SINGLESTEP)
> +};
> +
> +static inline char *strptrace(int request)
> +{
> +	return strings[request];
> +}
> +
> +static void child(void)
> +{
>  
> -int main(int argc, char *argv[])
> +	char path[512];
> +
> +	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
> +
> +	if (tst_get_path("ptrace06_child", path, sizeof(path)))
> +		tst_brk(TCONF, "Couldn't find ptrace06_child in $PATH");
> +
> +	TEST(execl(path, "ptrace06_child", "", NULL));
> +	tst_brk(TFAIL | TTERRNO,
> +			"Failed to execute execl01_child");
> +	exit(0);

So this whole exec() stuff looks to me like a uCLinux leftover. I
suppose that all this can be easily simplified to the SAFE_PTRACE() and
something that makes the child run. I suppose raising SIGSTOP signal
would suffice.

> +}
> +
> +static void run(void)
>  {
>  	size_t i;
> -	long ret;
> -	int saved_errno;
> +	int pid;
> +	int status;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	pid = SAFE_FORK();
>  
> -	make_a_baby(argc, argv);
> +	if (!pid)
> +		child();
> +
> +	SAFE_WAIT(&status);
> +
> +	if (!WIFSTOPPED(status))
> +		tst_brk(TBROK, "child %d was not stopped", pid);
>  
>  	for (i = 0; i < ARRAY_SIZE(test_cases); ++i) {
>  		struct test_case_t *tc = &test_cases[i];
>  
> -		errno = 0;
> -		ret =
> -		    ptrace(tc->request, pid, (void *)tc->addr,
> -			   (void *)tc->data);
> -		saved_errno = errno;
> -		if (ret != -1)
> -			tst_resm(TFAIL,
> +		TEST(ptrace(tc->request, pid, (void *)tc->addr,
> +					(void *)tc->data));
> +		if (TST_RET != -1)
> +			tst_brk(TFAIL | TERRNO,
>  				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
>  				 strptrace(tc->request), tc->addr, tc->data,
> -				 ret);
> -		else if (saved_errno != EIO && saved_errno != EFAULT)
> -			tst_resm(TFAIL,
> +				 TST_RET);
> +		else if (TST_ERR != EIO && TST_ERR != EFAULT)
> +			tst_brk(TFAIL | TERRNO,
>  				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
>  				 strptrace(tc->request), tc->addr, tc->data,
> -				 saved_errno, strerror(saved_errno));
> +				 TST_ERR, strerror(TST_ERR));
>  		else
> -			tst_resm(TPASS,
> +			tst_res(TPASS,
>  				 "ptrace(%s, ..., %li, %li) failed as expected",
>  				 strptrace(tc->request), tc->addr, tc->data);
>  	}

This can be just single TST_EXP_FAIL() we now have a variant that can be
passed an array of expected errnos.

> -	/* hopefully this worked */
> -	ptrace(PTRACE_KILL, pid, NULL, NULL);
> +	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);
>  
> -	tst_exit();
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +};
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace06_child.c b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
> new file mode 100644
> index 000000000..350b0e8df
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ptrace/ptrace06_child.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2018 Linux Test Project
> + * Copyright (C) 2015 Cyril Hrubis chrubis@suse.cz
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +int main(int argc, char *argv[])
> +{
> +
> +	tst_res(TPASS, "%s executed", argv[0]);
> +
> +	return 0;
> +}
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
