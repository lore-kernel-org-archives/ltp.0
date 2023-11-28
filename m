Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E354C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:24:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6B693CD994
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:24:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8CC3CB700
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:24:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AAF541401180
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:24:07 +0100 (CET)
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A3BC71F74D;
 Tue, 28 Nov 2023 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701163444;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7w6BTeLbCY5oM5qIwOE3k7Gg25qIy78ACD6cnFpLiK4=;
 b=AdFyLTP4KYehah5gajussLG3LTOi/1rHK5BUIn6O4LGgyNydJd7tFOgAU7u5GfdDGlj08j
 LcpQgvhkLNfpmtVF12X4Xo05awNiTAefwPk6Qnd/KfRAMVLLjsSCjftvr4msjZiOu83grs
 9D+L1Hc5OcTJFqLweRSSNIf5BCPzd40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701163444;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7w6BTeLbCY5oM5qIwOE3k7Gg25qIy78ACD6cnFpLiK4=;
 b=WfBrreTY6K0g7H+GUGxHvkUrMr6qyw6XUd6sTtrrJV3NnHkXQnXg/weJ2J7M2gmCJI4Zf1
 O9AStCRfTBvlVRCQ==
Received: from g78 (rpalethorpe.udp.ovpn1.prg.suse.de [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3E2762C1A1;
 Tue, 28 Nov 2023 09:24:04 +0000 (UTC)
References: <20230925112245.30701-1-wegao@suse.com>
 <20230925112245.30701-2-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Tue, 28 Nov 2023 08:57:57 +0000
Organization: Linux Private Site
In-reply-to: <20230925112245.30701-2-wegao@suse.com>
Message-ID: <87zfyy6xjg.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: ++++++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de; 
 dmarc=fail reason="No valid SPF,
 No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: A3BC71F74D
X-Spamd-Result: default: False [18.99 / 50.00];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; RDNS_NONE(1.00)[];
 SPAMHAUS_XBL(0.00)[149.44.160.134:from]; TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 REPLYTO_ADDR_EQ_FROM(0.00)[];
 HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
 R_SPF_SOFTFAIL(4.60)[~all:c];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
 HAS_ORG_HEADER(0.00)[]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; RDNS_DNSFAIL(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(3.00)[1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 VIOLATED_DIRECT_SPF(3.50)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.it:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] ptrace05: Refactor the test using new LTP
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
>  testcases/kernel/syscalls/ptrace/ptrace05.c | 147 ++++++--------------
>  1 file changed, 39 insertions(+), 108 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
> index 54cfa4d7b..4904b959c 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace05.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
> @@ -1,122 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
> - ******************************************************************************
> - *
> - *   ptrace05 - an app which ptraces itself as per arbitrarily specified signals,
> - *   over a user specified range.
> - *
> - *   Copyright (C) 2009, Ngie Cooper
> - *
> - *   This program is free software; you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *   GNU General Public License for more details.
> + * Copyright (C) 2009, Ngie Cooper
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - *   You should have received a copy of the GNU General Public License along
> - *   with this program; if not, write to the Free Software Foundation, Inc.,
> - *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *  ptrace05 - an app which ptraces itself as per arbitrarily specified signals
>   *
> - ******************************************************************************
>   */
>  
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <signal.h>
> -#include <errno.h>
> -#include <libgen.h>
> -#include <math.h>
>  #include <stdlib.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include <unistd.h>
> -
>  #include <config.h>
>  #include "ptrace.h"
>  
> -#include "test.h"
>  #include "lapi/signal.h"
> +#include "tst_test.h"
>  
> -char *TCID = "ptrace05";
> -int TST_TOTAL = 0;
> -
> -int usage(const char *);
> -
> -int usage(const char *argv0)
> -{
> -	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
> -	return 1;
> -}
> -
> -int main(int argc, char **argv)
> +static void run(void)
>  {
>  
> -	int end_signum = -1;
> -	int signum;
> -	int start_signum = -1;
> +	int end_signum = SIGRTMAX;
> +	int signum = 0;
> +	int start_signum = 0;
>  	int status;

{start,end}_signum don't appear to serve a purpose anymore.

>  
>  	pid_t child;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	if (start_signum == -1) {
> -		start_signum = 0;
> -	}
> -	if (end_signum == -1) {
> -		end_signum = SIGRTMAX;
> -	}
> -
>  	for (signum = start_signum; signum <= end_signum; signum++) {
>  
> -		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
> -			continue;

Why can this be removed?

I remember we had an issue on some systems because some signals are
reserved by libc.

> -
> -		switch (child = fork()) {
> +		switch (child = SAFE_FORK()) {
>  		case -1:
> -			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
> +			tst_brk(TBROK | TERRNO, "fork() failed");
>  		case 0:
>  
> -			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
> -				tst_resm(TINFO, "[child] Sending kill(.., %d)",
> -					 signum);
> -				if (kill(getpid(), signum) < 0) {
> -					tst_resm(TINFO | TERRNO,
> -						 "[child] kill(.., %d) failed.",
> -						 signum);
> -				}
> +			TEST(ptrace(PTRACE_TRACEME, 0, NULL, NULL));
> +			if (TST_RET != -1) {
> +				tst_res(TINFO, "[child] Sending kill(.., %d)",
> +						signum);
> +				SAFE_KILL(getpid(), signum);
>  			} else {
> -
> -				/*
> -				 * This won't increment the TST_COUNT var.
> -				 * properly, but it'll show up as a failure
> -				 * nonetheless.
> -				 */
> -				tst_resm(TFAIL | TERRNO,
> +				tst_brk(TFAIL | TERRNO,
>  					 "Failed to ptrace(PTRACE_TRACEME, ...) "
>  					 "properly");
> -
>  			}
> -			/* Shouldn't get here if signum == 0. */
> -			exit((signum == 0 ? 0 : 2));
> +
> +			exit(0);
>  			break;
>  
>  		default:
>  
> -			waitpid(child, &status, 0);
> +			SAFE_WAITPID(child, &status, 0);
>  
>  			switch (signum) {
>  			case 0:
>  				if (WIFEXITED(status)
>  				    && WEXITSTATUS(status) == 0) {
> -					tst_resm(TPASS,
> +					tst_res(TPASS,
>  						 "kill(.., 0) exited "
>  						 "with 0, as expected.");
>  				} else {
> -					tst_resm(TFAIL,
> +					tst_brk(TFAIL | TERRNO,
>  						 "kill(.., 0) didn't exit "
>  						 "with 0.");
>  				}
> @@ -125,20 +70,20 @@ int main(int argc, char **argv)
>  				if (WIFSIGNALED(status)) {
>  					/* SIGKILL must be uncatchable. */
>  					if (WTERMSIG(status) == SIGKILL) {
> -						tst_resm(TPASS,
> +						tst_res(TPASS,
>  							 "Killed with SIGKILL, "
>  							 "as expected.");
>  					} else {
> -						tst_resm(TPASS,
> +						tst_brk(TFAIL | TERRNO,
>  							 "Didn't die with "
>  							 "SIGKILL (?!) ");
>  					}
>  				} else if (WIFEXITED(status)) {
> -					tst_resm(TFAIL,
> +					tst_brk(TFAIL | TERRNO,
>  						 "Exited unexpectedly instead "
>  						 "of dying with SIGKILL.");
>  				} else if (WIFSTOPPED(status)) {
> -					tst_resm(TFAIL,
> +					tst_brk(TFAIL | TERRNO,
>  						 "Stopped instead of dying "
>  						 "with SIGKILL.");
>  				}
> @@ -146,35 +91,21 @@ int main(int argc, char **argv)
>  				/* All other processes should be stopped. */
>  			default:
>  				if (WIFSTOPPED(status)) {
> -					tst_resm(TPASS, "Stopped as expected");
> +					tst_res(TPASS, "Stopped as expected");
>  				} else {
> -					tst_resm(TFAIL, "Didn't stop as "
> +					tst_brk(TFAIL | TERRNO, "Didn't stop as "
>  						 "expected.");
> -					if (kill(child, 0)) {
> -						tst_resm(TINFO,
> -							 "Is still alive!?");
> -					} else if (WIFEXITED(status)) {
> -						tst_resm(TINFO,
> -							 "Exited normally");
> -					} else if (WIFSIGNALED(status)) {
> -						tst_resm(TINFO,
> -							 "Was signaled with "
> -							 "signum=%d",
> -							 WTERMSIG(status));
> -					}
> -
>  				}
> -
>  				break;
> -
>  			}
> -
>  		}
> -		/* Make sure the child dies a quick and painless death ... */
> -		kill(child, 9);
>  
> +		if (signum != 0 && signum != 9)
> +			SAFE_PTRACE(PTRACE_CONT, child, NULL, NULL);

nit; it's clearer to write SIGKILL than 9 also some other signals change
number between platforms.

>  	}
> -
> -	tst_exit();
> -
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.forks_child = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
