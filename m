Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A515C07E98
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:53:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597AE3CD988
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:53:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC92A3CC319
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:52:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F285E10134CF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:52:26 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 779A22198B;
 Tue, 28 Nov 2023 09:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701165116;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WM2eAaHkv2Ch/4MxANLahD3SAtp1MMYGU4xl1hynQE4=;
 b=SB13Cvl2zmzg9yEdFhZntl9gD13pN2iJybXiAxmFPDlh5VBrnlK20lgDWaaz6VengoN/i6
 NPDI3hrSoyj59/ikq0m32nHtkQIrAjEBfgDIQ13m1+iSVkvudBbwp7qN81i4KUmKx/LUP1
 KxOBCpsxotXXYzyZqk5el18MDO7h6QE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701165116;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WM2eAaHkv2Ch/4MxANLahD3SAtp1MMYGU4xl1hynQE4=;
 b=Nz6Et7AKCq7iJfc6i8RjQ1gahboQvWoF2HK64q/4lN8cwKqaJPIUG2tp/bO14bsKx3Yj5Y
 V2rJtz5wFEaUweAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5863F133B5;
 Tue, 28 Nov 2023 09:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id KgW5Ezy4ZWVEWQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:51:56 +0000
Date: Tue, 28 Nov 2023 10:51:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231128095149.GA356525@pevik>
References: <20230925112245.30701-1-wegao@suse.com>
 <20230925112245.30701-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925112245.30701-3-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[13.98%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ozlabs.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

note ptrace06 was not even been compiled. I tested that even in old API it
worked, thus I re-enable it in patch

https://patchwork.ozlabs.org/project/ltp/patch/20231128091524.340808-3-pvorel@suse.cz/
(part of https://patchwork.ozlabs.org/project/ltp/list/?series=384172&state=*)

> +++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
> @@ -1,32 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-only
Again:
// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) 2008 Analog Devices Inc.
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
>   * check out-of-bound/unaligned addresses given to
Without missing blank line here the list will not be working.
>   *  - {PEEK,POKE}{DATA,TEXT,USER}
>   *  - {GET,SET}{,FG}REGS
>   *  - {GET,SET}SIGINFO
>   *
Why this blank line above?

> - * Copyright (c) 2008 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later
... because this:
>   */

>  #define _GNU_SOURCE
This might not be needed (needs to be verified in CI if also the oldest distros
does not need it).

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

I wonder if this SIZEOF_USER is valid. I haven't found what value they mean
(they talk about arch/*/include/asm/user*.h in kernel).

> -char *TCID = "ptrace06";
> -
>  struct test_case_t {
>  	int request;
>  	long addr;
>  	long data;
>  } test_cases[] = {
>  	{
> +	PTRACE_PEEKDATA, .addr = 0}, {
> +	PTRACE_PEEKDATA, .addr = 1}, {
IMHO This is ugly formatting, brackets shold be always on the same place.
.e.g 
{ PTRACE_PEEKDATA, .addr = 0},
{ PTRACE_PEEKDATA, .addr = 1},


> +	PTRACE_PEEKDATA, .addr = 2}, {
> +	PTRACE_PEEKDATA, .addr = 3}, {
> +	PTRACE_PEEKDATA, .addr = -1}, {
> +	PTRACE_PEEKDATA, .addr = -2}, {
...
> +static void child(void)
> +{
> +	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
> +	execl("/bin/echo", "/bin/echo", NULL);
This will not work for AOSP (Android). Maybe adding ptrace06_child.c with very
simple code (printf or tst_res(TINFO) something, use TST_NO_DEFAULT_MAIN) would
be better.

> +	exit(0);
> +}

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
