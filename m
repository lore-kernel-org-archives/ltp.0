Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F1C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 16:50:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CFB3C7C12
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 17:50:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14B1F3C7BE1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:50:31 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16F9F611E01
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:50:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0ED5021183;
 Thu, 16 Jan 2025 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737046230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwCK2SbUUaIJXUfqTpASEKbq3PbZRTZlMElN4zbgRXE=;
 b=R95Gd+oYD80BlcZaSlaI9SWf7voFQNpEgcX6t+MOFc5wLxqKIc6EGHqC3rQ6OFRzWWHMhb
 PaUyN7b5ZhCmK4NpWvA0zzNZyVjXc2Im2omzgTEqtTtHQ5NZsshwCqTHnL+brwymFFWwhX
 o5gEzZpXclavMfOZzHeWH76bv7dDXD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737046230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwCK2SbUUaIJXUfqTpASEKbq3PbZRTZlMElN4zbgRXE=;
 b=tuXPoPayjNinZuFST2l/9mmq6GFKFd5JlSXXvQSc56DfKbrrt3rgEtlnKD5HZaxpVvcj8a
 kr/XzxEqvnDHA6AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R95Gd+oY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tuXPoPay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737046230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwCK2SbUUaIJXUfqTpASEKbq3PbZRTZlMElN4zbgRXE=;
 b=R95Gd+oYD80BlcZaSlaI9SWf7voFQNpEgcX6t+MOFc5wLxqKIc6EGHqC3rQ6OFRzWWHMhb
 PaUyN7b5ZhCmK4NpWvA0zzNZyVjXc2Im2omzgTEqtTtHQ5NZsshwCqTHnL+brwymFFWwhX
 o5gEzZpXclavMfOZzHeWH76bv7dDXD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737046230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwCK2SbUUaIJXUfqTpASEKbq3PbZRTZlMElN4zbgRXE=;
 b=tuXPoPayjNinZuFST2l/9mmq6GFKFd5JlSXXvQSc56DfKbrrt3rgEtlnKD5HZaxpVvcj8a
 kr/XzxEqvnDHA6AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE9F13A57;
 Thu, 16 Jan 2025 16:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ontuOdU4iWeIZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jan 2025 16:50:29 +0000
Date: Thu, 16 Jan 2025 17:50:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z4k4yCM67CBKMUGL@yuki.lan>
References: <20250114124023.4702-1-wegao@suse.com>
 <20250114143217.21018-1-wegao@suse.com>
 <20250114143217.21018-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250114143217.21018-3-wegao@suse.com>
X-Rspamd-Queue-Id: 0ED5021183
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] ptrace06: Refactor the test using new LTP
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

On Tue, Jan 14, 2025 at 09:32:17AM -0500, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace06.c   | 325 ++++++++++--------
>  .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
>  2 files changed, 190 insertions(+), 151 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c
> 
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
> index a1db3bab8..b760ab89d 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace06.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
> @@ -1,199 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * check out-of-bound/unaligned addresses given to
> + * Copyright (c) 2008 Analog Devices Inc.
> + * Copyright (c) Linux Test Project, 2009-2022
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check out-of-bound/unaligned addresses given to
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
> -#define SIZEOF_USER 284
> +# define SIZEOF_USER 284
>  #elif defined(__x86_64__)
> -#define SIZEOF_USER 928
> +# define SIZEOF_USER 928
>  #else
> -#define SIZEOF_USER 0x1000	/* just pick a big number */
> +# define SIZEOF_USER 0x1000	/* just pick a big number */
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
> +#endif
> +};
> +
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
>  #endif
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
>  };
>  
> -int TST_TOTAL = ARRAY_SIZE(test_cases);
> +static void child(void)
> +{
> +	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
> +	raise(SIGSTOP);
> +	exit(0);
> +}
>  
> -int main(int argc, char *argv[])
> +static void run(void)
>  {
>  	size_t i;
> -	long ret;
> -	int saved_errno;
> +	int pid;
> +	int status;
> +	int exp_errnos[] = {EIO, EFAULT};
> +
> +	pid = SAFE_FORK();
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	if (!pid)
> +		child();
>  
> -	make_a_baby(argc, argv);
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
> -				 "ptrace(%s, ..., %li, %li) returned %li instead of -1",
> -				 strptrace(tc->request), tc->addr, tc->data,
> -				 ret);
> -		else if (saved_errno != EIO && saved_errno != EFAULT)
> -			tst_resm(TFAIL,
> -				 "ptrace(%s, ..., %li, %li) expected errno EIO or EFAULT; actual: %i (%s)",
> -				 strptrace(tc->request), tc->addr, tc->data,
> -				 saved_errno, strerror(saved_errno));
> -		else
> -			tst_resm(TPASS,
> -				 "ptrace(%s, ..., %li, %li) failed as expected",
> -				 strptrace(tc->request), tc->addr, tc->data);
> +		TEST(ptrace(tc->request, pid, (void *)tc->addr,
> +					(void *)tc->data));

This test is not useful here, have you forget to remove this macro after
TST_EXP_FAIL_ARR() has been added?

> +		TST_EXP_FAIL_ARR(ptrace(tc->request, pid, (void *)tc->addr,
> +					(void *)tc->data), exp_errnos, ARRAY_SIZE(exp_errnos),
> +					"ptrace(%s, ..., %li, %li) failed as expected",
> +					 strings[tc->request], tc->addr, tc->data);
>  	}
>  
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

This program does not appear to be used at all.



With the useless parts removed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
