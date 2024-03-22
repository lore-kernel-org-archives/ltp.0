Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5014DC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:42:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A22C13CE629
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 07:42:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83FE3C998A
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 07:42:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F5CD1000DF5
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 07:42:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 182753813E;
 Fri, 22 Mar 2024 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711089747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9b8C8c/O9s+cu+MLBJGkhLlIFnsKnLWb9uVicSokMA=;
 b=vyC4wQ6T7vodMsc4XjMoVR8VZF0fnxEgwWIu5iqQservNsIX1UGyH5zWKz7WoUEsjDmCxH
 hs+I3X2YbS6wu3vMWyH0HWFO1MsrfgSsGkw/Tn/LDnKgRGBFBK206nn48MHJsoMbs3FShp
 8z2heE4N5dSJKime1noCvsOEc4nhW+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711089747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9b8C8c/O9s+cu+MLBJGkhLlIFnsKnLWb9uVicSokMA=;
 b=2bW9gWG4WEkNtRfKjvO607srfpCDnDE62qoHLsC1csc3Pzhb1s+hQ/5j0mHVC05yxeZ0Js
 pv/ul8TUOlmSt+CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711089747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9b8C8c/O9s+cu+MLBJGkhLlIFnsKnLWb9uVicSokMA=;
 b=vyC4wQ6T7vodMsc4XjMoVR8VZF0fnxEgwWIu5iqQservNsIX1UGyH5zWKz7WoUEsjDmCxH
 hs+I3X2YbS6wu3vMWyH0HWFO1MsrfgSsGkw/Tn/LDnKgRGBFBK206nn48MHJsoMbs3FShp
 8z2heE4N5dSJKime1noCvsOEc4nhW+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711089747;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9b8C8c/O9s+cu+MLBJGkhLlIFnsKnLWb9uVicSokMA=;
 b=2bW9gWG4WEkNtRfKjvO607srfpCDnDE62qoHLsC1csc3Pzhb1s+hQ/5j0mHVC05yxeZ0Js
 pv/ul8TUOlmSt+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04D76132FF;
 Fri, 22 Mar 2024 06:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nAN4AFMo/WXUDgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 06:42:27 +0000
Date: Fri, 22 Mar 2024 07:42:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240322064221.GA594557@pevik>
References: <20240313124542.13636-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313124542.13636-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vyC4wQ6T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2bW9gWG4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 182753813E
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Refactor fork14 using new LTP API
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

generally LGTM.
With using .skip_in_compat and SPDX GPL-2.0-only:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Minor notes below.

> ---
> Reverted SAFE_MMAP to mmap
> Added kernel tags
+1

>  testcases/kernel/syscalls/fork/fork14.c | 208 +++++++++++-------------
...
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
>   * Copyright (C) 2014  Red Hat, Inc.
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.

This is GPL-2.0-only.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> - *
> - * This test is a reporducer for this patch:
> - *              https://lkml.org/lkml/2012/4/24/328
> + * This test is a reporducer for this patch: https://lkml.org/lkml/2012/4/24/328
very nit: I would trust lore more, thus I would use

https://lore.kernel.org/lkml/1335289853-2923-1-git-send-email-siddhesh.poyarekar@gmail.com/

>   * Since vma length in dup_mmap is calculated and stored in a unsigned
>   * int, it will overflow when length of mmaped memory > 16 TB. When
> - * overflow occur, fork will  incorrectly succeed. The patch above
> - * fixed it.
> - ********************************************************************/
> + * overflow occur, fork will incorrectly succeed. The patch above fixed it.
s/occur/occurs/

> + */

> -#include <sys/mman.h>
> -#include <sys/wait.h>
> -#include <stdio.h>
> -#include <unistd.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/abisize.h"
> +#include "tst_test.h"

> -char *TCID = "fork14";
> -int TST_TOTAL = 1;
> +#ifndef TST_ABI32

We can use .skip_in_compat = 1, flag instead.

> -#define GB		(1024 * 1024 * 1024L)
> +#include <stdlib.h>
> +#include <sys/wait.h>

> -/* set mmap threshold to 16TB */
>  #define LARGE		(16 * 1024)
>  #define EXTENT		(16 * 1024 + 10)

> -static char **pointer_vec;
> +static char **memvec;

> -static void setup(void);
> -static void cleanup(void);
> -static int  fork_test(void);
> -
> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc, reproduced;
> +	int i, j, ret;
> +	pid_t pid;
> +	void *mem;
> +	int prev_failed = 0;
> +	int passed = 1;
> +	int failures = 0;

> +	for (i = 0; i < EXTENT; i++) {
I wonder if the code would not be slightly more readable if the content of the
loop was in the separate function. Probably not, feel free to ignore.

> +		mem = mmap(NULL, 1 * TST_GB,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
...
> +		if (mem == MAP_FAILED) {
> +			failures++;
...
> +			if (failures > 10) {
> +				tst_brk(TCONF, "mmap() fails too many "
> +					"times, so it's almost impossible to "
> +					"get a vm_area_struct sized 16TB.");
> +			}

> -static void cleanup(void)
> -{
> -	free(pointer_vec);
> -}
> +			continue;
> +		}


> -		switch (tst_fork()) {
> -		case -1:
> -			prev_failed = 1;
> -		break;
> -		case 0:
> +		if (!pid)
>  			exit(0);
> -		default:
> -			SAFE_WAITPID(cleanup, -1, NULL, 0);

> -			if (prev_failed > 0 && i >= LARGE) {
> -				tst_resm(TFAIL, "Fork succeeds incorrectly");
> -				reproduced = 1;
> -				goto clear_memory_map;
> -			}
> +		ret = waitpid(pid, NULL, 0);
Why not SAFE_WAITPID() as it was originally?

> +		if (ret == -1 && errno != ECHILD)
> +			tst_brk(TBROK | TERRNO, "waitpid() error");
> +
> +		if (prev_failed && i >= LARGE) {
> +			passed = 0;
> +			break;
>  		}
> +
> +		prev_failed = 0;
> +
> +		tst_res(TINFO, "fork() passed at %d attempt", i);
> +	}
> +
> +	for (j = 0; j < i; j++) {
> +		if (memvec[j])
> +			SAFE_MUNMAP(memvec[j], 1 * TST_GB);
>  	}

> -clear_memory_map:
> -	for (j = 0; j < cnt; j++) {
> -		if (pointer_vec[j])
> -			SAFE_MUNMAP(cleanup, pointer_vec[j], 1 * GB);
> +	if (passed)
> +		tst_res(TPASS, "fork() failed as expected");
> +	else
> +		tst_res(TFAIL, "fork() succeeded incorrectly");
> +}
> +
> +static void setup(void)
> +{
> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
> +	memset(memvec, 0, EXTENT);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (long i = 0; i < EXTENT; i++) {
> +		if (memvec && memvec[i])
> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
>  	}

> -	return reproduced;
> +	if (memvec)
> +		free(memvec);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "7edc8b0ac16cbaed7cb4ea4c6b95ce98d2997e84"},
nit: we usually use shorter hash 7edc8b0ac16c (as used in Fixes: in git
commits).

> +		{}
> +	}
> +};
> +
> +#else /* TST_ABI32 */
> +	TST_TEST_TCONF("Test doesn't supports 32bits architecture");
s/supports/support/

But we can use .skip_in_compat = 1, flag instead.

Kind regards,
Petr

> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
