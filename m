Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AF7C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:32:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB8E43C8131
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 11:32:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36073C1DBA
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:32:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F26821A0147C
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 11:32:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BDAC1F45B;
 Fri, 21 Feb 2025 10:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740133936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZauPYtfAJFvQkB7Dy0jDr4FnVtnk0Uo5lFJXSWlXvRg=;
 b=lAEjQR5YVtyzDyLcrKdZxbc/E1g6CfRExnFBesdKeU+kp3uVlJq2qhvZzP1iQXjTVVQuVm
 yxFkTzHTyiJtWkNb2oNlMf+BQDwYXUhoHuFi1OqvYYh2BHO7VysAltX6tXwtbmP6zUgvvO
 yr9bk0Ap52tGYLem7jNJqPWFfoOUsJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740133936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZauPYtfAJFvQkB7Dy0jDr4FnVtnk0Uo5lFJXSWlXvRg=;
 b=vVkbpRLH/TmdqsBwUvFBBHwV+coCICM0SzbuPIuJM6HOcrIWsYf+JlZ21i6/8dKNtFoOsy
 zlA4PmqdQCLntuDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lAEjQR5Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vVkbpRLH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740133936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZauPYtfAJFvQkB7Dy0jDr4FnVtnk0Uo5lFJXSWlXvRg=;
 b=lAEjQR5YVtyzDyLcrKdZxbc/E1g6CfRExnFBesdKeU+kp3uVlJq2qhvZzP1iQXjTVVQuVm
 yxFkTzHTyiJtWkNb2oNlMf+BQDwYXUhoHuFi1OqvYYh2BHO7VysAltX6tXwtbmP6zUgvvO
 yr9bk0Ap52tGYLem7jNJqPWFfoOUsJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740133936;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZauPYtfAJFvQkB7Dy0jDr4FnVtnk0Uo5lFJXSWlXvRg=;
 b=vVkbpRLH/TmdqsBwUvFBBHwV+coCICM0SzbuPIuJM6HOcrIWsYf+JlZ21i6/8dKNtFoOsy
 zlA4PmqdQCLntuDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BE8C13806;
 Fri, 21 Feb 2025 10:32:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3/QmITBWuGc0OwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 21 Feb 2025 10:32:16 +0000
Date: Fri, 21 Feb 2025 11:32:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <ricardo@marliere.net>
Message-ID: <Z7hWOTzp7CSorBRu@yuki.lan>
References: <20250218-conversions-pause-v2-0-8c72960fe1ec@suse.com>
 <20250218-conversions-pause-v2-3-8c72960fe1ec@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250218-conversions-pause-v2-3-8c72960fe1ec@suse.com>
X-Rspamd-Queue-Id: 9BDAC1F45B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] syscalls/pause03: Refactor into new API
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
Cc: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> ---
>  testcases/kernel/syscalls/pause/pause03.c | 115 +++++++-----------------=
------
>  1 file changed, 25 insertions(+), 90 deletions(-)
> =

> diff --git a/testcases/kernel/syscalls/pause/pause03.c b/testcases/kernel=
/syscalls/pause/pause03.c
> index 459222045c08dc1fc4804efd2ece02316fe55a0e..85c3c18b19d63343c65fa553a=
65ecb6f9f0c0700 100644
> --- a/testcases/kernel/syscalls/pause/pause03.c
> +++ b/testcases/kernel/syscalls/pause/pause03.c
> @@ -1,104 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2001
> - *  07/2001 Ported by Wayne Boyer
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software Foundati=
on,
> - * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * 07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2025 Ricardo B. Marli=E8re <rbm@suse.com>
>   */
> -/*
> - * Test Description:
> - *  pause() does not return due to receipt of SIGKILL signal and specifi=
ed
> - *  process should be terminated.
> - */
> -#include <unistd.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <sys/wait.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static pid_t cpid;
>  =

> -char *TCID =3D "pause03";
> -int TST_TOTAL =3D 1;
> +/*\
> + * This test verifies that pause() does not return after receiving a SIG=
KILL
> + * signal, at which point the process should be terminated.

Maybe this can be shorter, something as:

Verifies that pause() does not return after process recieved SIGKILL.

> + */
>  =

> -static void do_child(void);
> -static void setup(void);
> -static void cleanup(void);
> +#include "tst_test.h"
>  =

> -int main(int ac, char **av)
> +void run(void)
>  {
> -	int lc;
>  	int status;
> +	pid_t pid;
>  =

> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> -		tst_count =3D 0;
> -
> -		if ((cpid =3D tst_fork()) =3D=3D -1)
> -			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
> -
> -		if (cpid =3D=3D 0)
> -			do_child();
> -
> -		TST_PROCESS_STATE_WAIT(cleanup, cpid, 'S');
> -
> -		kill(cpid, SIGKILL);
> -
> -		SAFE_WAIT(NULL, &status);
> -
> -		if (WIFSIGNALED(status) && WTERMSIG(status) =3D=3D SIGKILL) {
> -			tst_resm(TPASS, "pause() did not return after SIGKILL");
> -			continue;
> -		}
> -
> -		if (WIFSIGNALED(status)) {
> -			tst_resm(TFAIL, "child killed by %s unexpectedly",
> -			         tst_strsig(WTERMSIG(status)));
> -			continue;
> -		}
> -
> -		tst_resm(TFAIL, "child exited with %i", WEXITSTATUS(status));
> +	pid =3D SAFE_FORK();
> +	if (!pid) {
> +		TST_EXP_PASS(pause());
> +		exit(0);
>  	}
>  =

> -	cleanup();
> -	tst_exit();
> +	TST_PROCESS_STATE_WAIT(pid, 'S', 10000);

Same as with the pause01 we need the checpoints before we check the
process state.

> +	SAFE_KILL(pid, SIGINT);
                         ^
			 SIGKILL

The test does not even work with SIGINT...

> +	SAFE_WAITPID(pid, &status, 0);
>  =

> +	if (WIFSIGNALED(status) && WTERMSIG(status) =3D=3D SIGKILL)
> +		tst_res(TPASS, "pause() did not return after SIGKILL");
> +	else
> +		tst_res(TFAIL, "Child exited with %i", WEXITSTATUS(status));

This is not correct, you should use tst_strstatus(status) that covers
all the possible cases, as:

tst_res(TFAIL, "Child %s", tst_strstatus(status))

>  }
>  =

> -void do_child(void)
> -{
> -	TEST(pause());
> -
> -	tst_resm(TFAIL, "Unexpected return from pause()");
> -
> -	exit(0);
> -}
> -
> -void setup(void)
> -{
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -}
> -
> -
> -void cleanup(void)
> -{
> -	kill(cpid, SIGKILL);
> -}
> +static struct tst_test test =3D {
> +	.test_all =3D run,
> +	.forks_child =3D 1,
> +};
> =

> -- =

> 2.48.1
> =

> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
