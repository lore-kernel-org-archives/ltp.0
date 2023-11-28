Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FE3C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 116EF3CDA1F
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:03:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E31923C88C8
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:03:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 11494600049
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:03:27 +0100 (CET)
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 90FEA1F37E;
 Tue, 28 Nov 2023 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701165795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1msXzc6IZC0nJ+NBG2VxJMz3nP0we/l4L4mc8AtEE+4=;
 b=QNPTY1HRhAKC2/PsaCsE5zMX1M2M5ngGyrMFOEUFtQE2w56+4u8Z+CpjLTob7lvcaXkh2s
 kG1z3c/Zp+MyA6AViajtIKSDhHgYyVFi+rFOqLf7cgFEC/H9L651huBzWchZFkgca7sRYw
 /b9FahCL2pSyemhKw7EgwkKN9SEvSZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701165795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1msXzc6IZC0nJ+NBG2VxJMz3nP0we/l4L4mc8AtEE+4=;
 b=rKPubytmpfb0rq1bMjJ/ec4hk2khurWJkQjySniFltvQD+cj6WSEsP2Z5FP3myo508lL/a
 1BfNj6GlgVCAlOCQ==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6569D2C166;
 Tue, 28 Nov 2023 10:03:15 +0000 (UTC)
References: <20230925112245.30701-1-wegao@suse.com>
 <20230925112245.30701-3-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Tue, 28 Nov 2023 09:31:02 +0000
Organization: Linux Private Site
In-reply-to: <20230925112245.30701-3-wegao@suse.com>
Message-ID: <87v89m6vq6.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: 90FEA1F37E
X-Spamd-Result: default: False [18.99 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; RDNS_NONE(1.00)[];
 SPAMHAUS_XBL(0.00)[149.44.160.134:from]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[];
 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
 HAS_ORG_HEADER(0.00)[];
 R_RATELIMIT(0.00)[rip(RLa6h5sh378tcam5q78u)]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; RDNS_DNSFAIL(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] ptrace06: Refactor the test using new LTP
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace06.c | 306 +++++++++++---------
>  1 file changed, 175 insertions(+), 131 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
> index c0cb3b9bd..5829faea4 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace06.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
> @@ -1,32 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> + * Copyright (c) 2008 Analog Devices Inc.
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
>   * check out-of-bound/unaligned addresses given to
>   *  - {PEEK,POKE}{DATA,TEXT,USER}
>   *  - {GET,SET}{,FG}REGS
>   *  - {GET,SET}SIGINFO
>   *
> - * Copyright (c) 2008 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later
>   */
>  
>  #define _GNU_SOURCE
>  
> -#include <errno.h>
> -#include <stdbool.h>
> -#include <stdio.h>
>  #include <stdlib.h>
> -#include <unistd.h>
> -
>  #include <config.h>
> -#include "ptrace.h"
>  
> -#include "test.h"
> -#include "spawn_ptrace_child.h"
> -#include "config.h"
> +#include "ptrace.h"
> +#include "tst_test.h"
>  
>  /* this should be sizeof(struct user), but that info is only found
>   * in the kernel asm/user.h which is not exported to userspace.
>   */
> +
>  #if defined(__i386__)
>  #define SIZEOF_USER 284
>  #elif defined(__x86_64__)
> @@ -35,168 +34,213 @@
>  #define SIZEOF_USER 0x1000	/* just pick a big number */
>  #endif
>  
> -char *TCID = "ptrace06";
> -
>  struct test_case_t {
>  	int request;
>  	long addr;
>  	long data;
>  } test_cases[] = {
>  	{
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
> +	PTRACE_PEEKDATA, .addr = 0}, {
> +	PTRACE_PEEKDATA, .addr = 1}, {
> +	PTRACE_PEEKDATA, .addr = 2}, {
> +	PTRACE_PEEKDATA, .addr = 3}, {
> +	PTRACE_PEEKDATA, .addr = -1}, {
> +	PTRACE_PEEKDATA, .addr = -2}, {
> +	PTRACE_PEEKDATA, .addr = -3}, {
> +	PTRACE_PEEKDATA, .addr = -4}, {
> +	PTRACE_PEEKTEXT, .addr = 0}, {
> +	PTRACE_PEEKTEXT, .addr = 1}, {
> +	PTRACE_PEEKTEXT, .addr = 2}, {
> +	PTRACE_PEEKTEXT, .addr = 3}, {
> +	PTRACE_PEEKTEXT, .addr = -1}, {
> +	PTRACE_PEEKTEXT, .addr = -2}, {
> +	PTRACE_PEEKTEXT, .addr = -3}, {
> +	PTRACE_PEEKTEXT, .addr = -4}, {
> +	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 1}, {
> +	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 2}, {
> +	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 3}, {
> +	PTRACE_PEEKUSER, .addr = SIZEOF_USER + 4}, {
> +	PTRACE_PEEKUSER, .addr = -1}, {
> +	PTRACE_PEEKUSER, .addr = -2}, {
> +	PTRACE_PEEKUSER, .addr = -3}, {
> +	PTRACE_PEEKUSER, .addr = -4}, {
> +	PTRACE_POKEDATA, .addr = 0}, {
> +	PTRACE_POKEDATA, .addr = 1}, {
> +	PTRACE_POKEDATA, .addr = 2}, {
> +	PTRACE_POKEDATA, .addr = 3}, {
> +	PTRACE_POKEDATA, .addr = -1}, {
> +	PTRACE_POKEDATA, .addr = -2}, {
> +	PTRACE_POKEDATA, .addr = -3}, {
> +	PTRACE_POKEDATA, .addr = -4}, {
> +	PTRACE_POKETEXT, .addr = 0}, {
> +	PTRACE_POKETEXT, .addr = 1}, {
> +	PTRACE_POKETEXT, .addr = 2}, {
> +	PTRACE_POKETEXT, .addr = 3}, {
> +	PTRACE_POKETEXT, .addr = -1}, {
> +	PTRACE_POKETEXT, .addr = -2}, {
> +	PTRACE_POKETEXT, .addr = -3}, {
> +	PTRACE_POKETEXT, .addr = -4}, {
> +	PTRACE_POKEUSER, .addr = SIZEOF_USER + 1}, {
> +	PTRACE_POKEUSER, .addr = SIZEOF_USER + 2}, {
> +	PTRACE_POKEUSER, .addr = SIZEOF_USER + 3}, {
> +	PTRACE_POKEUSER, .addr = SIZEOF_USER + 4}, {
> +	PTRACE_POKEUSER, .addr = -1}, {
> +	PTRACE_POKEUSER, .addr = -2}, {
> +	PTRACE_POKEUSER, .addr = -3}, {
> +	PTRACE_POKEUSER, .addr = -4},
>  #ifdef PTRACE_GETREGS
>  	{
> -	PTRACE_GETREGS,.data = 0}, {
> -	PTRACE_GETREGS,.data = 1}, {
> -	PTRACE_GETREGS,.data = 2}, {
> -	PTRACE_GETREGS,.data = 3}, {
> -	PTRACE_GETREGS,.data = -1}, {
> -	PTRACE_GETREGS,.data = -2}, {
> -	PTRACE_GETREGS,.data = -3}, {
> -	PTRACE_GETREGS,.data = -4},
> +	PTRACE_GETREGS, .data = 0}, {
> +	PTRACE_GETREGS, .data = 1}, {
> +	PTRACE_GETREGS, .data = 2}, {
> +	PTRACE_GETREGS, .data = 3}, {
> +	PTRACE_GETREGS, .data = -1}, {
> +	PTRACE_GETREGS, .data = -2}, {
> +	PTRACE_GETREGS, .data = -3}, {
> +	PTRACE_GETREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_GETFGREGS
>  	{
> -	PTRACE_GETFGREGS,.data = 0}, {
> -	PTRACE_GETFGREGS,.data = 1}, {
> -	PTRACE_GETFGREGS,.data = 2}, {
> -	PTRACE_GETFGREGS,.data = 3}, {
> -	PTRACE_GETFGREGS,.data = -1}, {
> -	PTRACE_GETFGREGS,.data = -2}, {
> -	PTRACE_GETFGREGS,.data = -3}, {
> -	PTRACE_GETFGREGS,.data = -4},
> +	PTRACE_GETFGREGS, .data = 0}, {
> +	PTRACE_GETFGREGS, .data = 1}, {
> +	PTRACE_GETFGREGS, .data = 2}, {
> +	PTRACE_GETFGREGS, .data = 3}, {
> +	PTRACE_GETFGREGS, .data = -1}, {
> +	PTRACE_GETFGREGS, .data = -2}, {
> +	PTRACE_GETFGREGS, .data = -3}, {
> +	PTRACE_GETFGREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_SETREGS
>  	{
> -	PTRACE_SETREGS,.data = 0}, {
> -	PTRACE_SETREGS,.data = 1}, {
> -	PTRACE_SETREGS,.data = 2}, {
> -	PTRACE_SETREGS,.data = 3}, {
> -	PTRACE_SETREGS,.data = -1}, {
> -	PTRACE_SETREGS,.data = -2}, {
> -	PTRACE_SETREGS,.data = -3}, {
> -	PTRACE_SETREGS,.data = -4},
> +	PTRACE_SETREGS, .data = 0}, {
> +	PTRACE_SETREGS, .data = 1}, {
> +	PTRACE_SETREGS, .data = 2}, {
> +	PTRACE_SETREGS, .data = 3}, {
> +	PTRACE_SETREGS, .data = -1}, {
> +	PTRACE_SETREGS, .data = -2}, {
> +	PTRACE_SETREGS, .data = -3}, {
> +	PTRACE_SETREGS, .data = -4},
>  #endif
>  #ifdef PTRACE_SETFGREGS
>  	{
> -	PTRACE_SETFGREGS,.data = 0}, {
> -	PTRACE_SETFGREGS,.data = 1}, {
> -	PTRACE_SETFGREGS,.data = 2}, {
> -	PTRACE_SETFGREGS,.data = 3}, {
> -	PTRACE_SETFGREGS,.data = -1}, {
> -	PTRACE_SETFGREGS,.data = -2}, {
> -	PTRACE_SETFGREGS,.data = -3}, {
> -	PTRACE_SETFGREGS,.data = -4},
> +	PTRACE_SETFGREGS, .data = 0}, {
> +	PTRACE_SETFGREGS, .data = 1}, {
> +	PTRACE_SETFGREGS, .data = 2}, {
> +	PTRACE_SETFGREGS, .data = 3}, {
> +	PTRACE_SETFGREGS, .data = -1}, {
> +	PTRACE_SETFGREGS, .data = -2}, {
> +	PTRACE_SETFGREGS, .data = -3}, {
> +	PTRACE_SETFGREGS, .data = -4},
>  #endif
>  #if HAVE_DECL_PTRACE_GETSIGINFO
>  	{
> -	PTRACE_GETSIGINFO,.data = 0}, {
> -	PTRACE_GETSIGINFO,.data = 1}, {
> -	PTRACE_GETSIGINFO,.data = 2}, {
> -	PTRACE_GETSIGINFO,.data = 3}, {
> -	PTRACE_GETSIGINFO,.data = -1}, {
> -	PTRACE_GETSIGINFO,.data = -2}, {
> -	PTRACE_GETSIGINFO,.data = -3}, {
> -	PTRACE_GETSIGINFO,.data = -4},
> +	PTRACE_GETSIGINFO, .data = 0}, {
> +	PTRACE_GETSIGINFO, .data = 1}, {
> +	PTRACE_GETSIGINFO, .data = 2}, {
> +	PTRACE_GETSIGINFO, .data = 3}, {
> +	PTRACE_GETSIGINFO, .data = -1}, {
> +	PTRACE_GETSIGINFO, .data = -2}, {
> +	PTRACE_GETSIGINFO, .data = -3}, {
> +	PTRACE_GETSIGINFO, .data = -4},
>  #endif
>  #if HAVE_DECL_PTRACE_SETSIGINFO
>  	{
> -	PTRACE_SETSIGINFO,.data = 0}, {
> -	PTRACE_SETSIGINFO,.data = 1}, {
> -	PTRACE_SETSIGINFO,.data = 2}, {
> -	PTRACE_SETSIGINFO,.data = 3}, {
> -	PTRACE_SETSIGINFO,.data = -1}, {
> -	PTRACE_SETSIGINFO,.data = -2}, {
> -	PTRACE_SETSIGINFO,.data = -3}, {
> -	PTRACE_SETSIGINFO,.data = -4},
> +	PTRACE_SETSIGINFO, .data = 0}, {
> +	PTRACE_SETSIGINFO, .data = 1}, {
> +	PTRACE_SETSIGINFO, .data = 2}, {
> +	PTRACE_SETSIGINFO, .data = 3}, {
> +	PTRACE_SETSIGINFO, .data = -1}, {
> +	PTRACE_SETSIGINFO, .data = -2}, {
> +	PTRACE_SETSIGINFO, .data = -3}, {
> +	PTRACE_SETSIGINFO, .data = -4},
> +#endif
> +};
> +
> +#define SPT(x) [PTRACE_##x] = #x,
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
>  #endif
> +	SPT(KILL)
> +	SPT(SINGLESTEP)
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static inline char *strptrace(int request)
> +{
> +	return strings[request];
> +}
> +
> +static void child(void)
> +{
> +	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
> +	execl("/bin/echo", "/bin/echo", NULL);

This isn't guaranteed to exist.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
