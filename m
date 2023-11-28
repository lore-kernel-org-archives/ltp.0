Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F74AC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 09:25:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B26B53CD986
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:25:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B09FA3CD99A
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:24:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E9951A009A3
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 10:24:31 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D6E321940;
 Tue, 28 Nov 2023 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701163470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lM2Z+U89yjIwwoVuRR8LzItnOGwdxFjbJ0RFchNGIc=;
 b=PyUggaAiLLFBr3wNHKBNjdhQFzPnytILllB8oDGA8LY5fprcZ+zk3pBTQRuJx+P7EJFAVQ
 I1wp87bSxGYoQhxm6q5tyKIyFFPnUz+6rViAGUdoJMMHRqDF4shMFEzhHsD9rX9+/b0A0y
 XgnwEofST38nEk0zv6BeCaeZ8ja6yaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701163470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8lM2Z+U89yjIwwoVuRR8LzItnOGwdxFjbJ0RFchNGIc=;
 b=YgpmJe64RXdPv01ceclJnTMB2x0LzZ+Zl+EYibLLkL2Urc7HEx1JzHAzJC4egt7qXf6aVJ
 lgAnXcNGcKnr69Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B888139FC;
 Tue, 28 Nov 2023 09:24:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id EH6QFc6xZWW9UAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 09:24:30 +0000
Date: Tue, 28 Nov 2023 10:24:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231128092420.GB303912@pevik>
References: <20230925112245.30701-1-wegao@suse.com>
 <20230925112245.30701-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925112245.30701-2-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.80 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 BAYES_SPAM(5.10)[100.00%]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

make check-ptrace05 shows various redefinitions, that points on ptrace.h cleanup
needed, I'll fix it as a separate change.

CHECK testcases/kernel/syscalls/ptrace/ptrace05.c
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:50:9: warning: preprocessor token PTRACE_GETREGSET redefined
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/sys/ptrace.h:153:9: this was the original definition
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:51:9: warning: preprocessor token PTRACE_SETREGSET redefined
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/sys/ptrace.h:157:9: this was the original definition
ptrace05.c: note: in included file (through ptrace.h):
/usr/include/linux/ptrace.h:53:9: warning: preprocessor token PTRACE_SEIZE redefined

I handled this in separate patchset [3], I Cc you. Could you please base v2 on it?
I hope it will be merged soon.

[1] https://sourceware.org/glibc/wiki/Synchronizing_Headers
[2] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions#11-oldest-tested-distributions
[3] https://patchwork.ozlabs.org/project/ltp/list/?series=384172&state=*

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/ptrace/ptrace05.c | 147 ++++++--------------
>  1 file changed, 39 insertions(+), 108 deletions(-)

> diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
> index 54cfa4d7b..4904b959c 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace05.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
> @@ -1,122 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
// SPDX-License-Identifier: GPL-2.0-or-later

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
"any later version" is why GPL-2.0-or-later instead of GPL-2.0-only.

> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *   GNU General Public License for more details.
> + * Copyright (C) 2009, Ngie Cooper
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
Please add also LTP copyright (more people contributed to this test):
* Copyright (c) Linux Test Project, 2009-2019
> + */
> +
> +/*\
> + * [Description]
>   *
> - *   You should have received a copy of the GNU General Public License along
> - *   with this program; if not, write to the Free Software Foundation, Inc.,
> - *   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *  ptrace05 - an app which ptraces itself as per arbitrarily specified signals
I'm not really sure for a proper description, but we don't list the test name,
also s/app/test/

>   *
> - ******************************************************************************
>   */

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

> -#include "test.h"
>  #include "lapi/signal.h"
> +#include "tst_test.h"

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

> -	int end_signum = -1;
> -	int signum;
> -	int start_signum = -1;
> +	int end_signum = SIGRTMAX;
> +	int signum = 0;
> +	int start_signum = 0;
>  	int status;

>  	pid_t child;

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

> -		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
> -			continue;
> -
> -		switch (child = fork()) {
> +		switch (child = SAFE_FORK()) {
>  		case -1:
> -			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
> +			tst_brk(TBROK | TERRNO, "fork() failed");
We have this handled in SAFE_FORK(), it should be removed here.
Therefore switch+case should be replaced with if+else.

>  		case 0:

> -				tst_resm(TFAIL | TERRNO,
> +				tst_brk(TFAIL | TERRNO,
>  					 "Failed to ptrace(PTRACE_TRACEME, ...) "
>  					 "properly");
> -
>  			}
...
> -			/* Shouldn't get here if signum == 0. */
> -			exit((signum == 0 ? 0 : 2));
> +
> +			exit(0);
Why there can be always exit(0) ?
>  			break;

>  		default:

> -			waitpid(child, &status, 0);
> +			SAFE_WAITPID(child, &status, 0);

>  			switch (signum) {
>  			case 0:
>  				if (WIFEXITED(status)
>  				    && WEXITSTATUS(status) == 0) {
> -					tst_resm(TPASS,
> +					tst_res(TPASS,
>  						 "kill(.., 0) exited "
>  						 "with 0, as expected.");
Please join strings (this applies to code below as well).

>  				} else {
> -					tst_resm(TFAIL,
> +					tst_brk(TFAIL | TERRNO,
>  						 "kill(.., 0) didn't exit "
>  						 "with 0.");
Why not tst_res(TFAIL, ...) ?  (this applies to code below as well)

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
