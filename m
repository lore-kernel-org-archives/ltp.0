Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C736C35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 11:58:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5B13CF337
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 12:58:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 374FB3C98D3
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 12:58:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C89A5601BCB
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 12:58:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1B211FD53;
 Mon, 18 Dec 2023 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702900693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Km1IqtaIwxEXYB6zdZ5gLVRb9Bth9zrkajXdEwzMb+k=;
 b=0oETSbFGrRy/Ap1EEz36xgoR+mubMi7LpEjvBnqkmAMMCfkzIM7D7SV64/qXgX9KtusdXO
 eBhsNcoJ4bDc26FIaxF6eD820OgYlN2XRj/bgZcHbFzM9Hy7QEtvwbG8QxVLBNNYazkM6W
 BhptdmyYHLAqU2wcCioiCyKL6sqacoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702900693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Km1IqtaIwxEXYB6zdZ5gLVRb9Bth9zrkajXdEwzMb+k=;
 b=E8+6YfW5q3ILs1E6erLeKyMaqK1koHsHvW3+xhbiJHD+zOiOKVKOf+6icpYcDxfWlCmhOy
 M9dfjklJIeLYn1Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702900693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Km1IqtaIwxEXYB6zdZ5gLVRb9Bth9zrkajXdEwzMb+k=;
 b=0oETSbFGrRy/Ap1EEz36xgoR+mubMi7LpEjvBnqkmAMMCfkzIM7D7SV64/qXgX9KtusdXO
 eBhsNcoJ4bDc26FIaxF6eD820OgYlN2XRj/bgZcHbFzM9Hy7QEtvwbG8QxVLBNNYazkM6W
 BhptdmyYHLAqU2wcCioiCyKL6sqacoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702900693;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Km1IqtaIwxEXYB6zdZ5gLVRb9Bth9zrkajXdEwzMb+k=;
 b=E8+6YfW5q3ILs1E6erLeKyMaqK1koHsHvW3+xhbiJHD+zOiOKVKOf+6icpYcDxfWlCmhOy
 M9dfjklJIeLYn1Ag==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 72E6013BC8;
 Mon, 18 Dec 2023 11:58:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Lm6zGdUzgGWGQAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 11:58:13 +0000
Date: Mon, 18 Dec 2023 12:58:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20231218115811.GA184666@pevik>
References: <20231017114900.17690-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231017114900.17690-1-andrea.cervesato@suse.de>
X-Spamd-Result: default: False [0.70 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor fork14 using new LTP API
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> +#ifndef TST_ABI32

> +#include <stdlib.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
This will fail on 32bit arch, where TST_TEST_TCONF() is used. You need to
include tst_test.h first.

...
> +static void run(void)
{
...
> +	for (i = 0; i < EXTENT; i++) {
> +		mem = mmap(NULL, 1 * TST_GB,
> +			PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS,
> +			0, 0);
We have SAFE_MMAP(), is there a reason not to use it?

> -		reproduced = fork_test();
> -		if (reproduced == 0)
> -			tst_resm(TPASS, "fork failed as expected.");
> -	}
> -	cleanup();
> -	tst_exit();
> -}
> +		if (mem == MAP_FAILED) {
> +			tst_res(TINFO, "mmap() failed");
...
> +			if (failures > 10) {
> +				tst_brk(TCONF, "mmap() fails too many "
> +					"times, so it's almost impossible to "
> +					"get a vm_area_struct sized 16TB.");
I would join this into single string.
> +			}
> +		}

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
> +		if (ret == -1 && errno != ECHILD)
> +			tst_brk(TBROK | TERRNO, "waitpid() error");
Why not use SAFE_WAITPID(). It was even used before.

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

...
> +static void setup(void)
> +{
> +	memvec = SAFE_MALLOC(EXTENT * sizeof(char *));
> +	memset(memvec, 0, EXTENT);
> +}
> +
> +static void cleanup(void)
> +{
> +	for (long i = 0; i < EXTENT; i++) {
> +		if (memvec[i])
If malloc() in setup() fails (rare case, I know) bad thing happen here,
you should check for (memvec && memvec[i]) here
> +			SAFE_MUNMAP(memvec[i], 1 * TST_GB);
>  	}

Also here should be check if (memvec)
> +	free(memvec);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
