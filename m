Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A991C7EE23
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 18:35:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0ABA3CE733
	for <ltp@archiver.kernel.org>; Mon, 29 May 2023 20:35:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29E033CCFCB
 for <ltp@lists.linux.it>; Mon, 29 May 2023 20:34:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 80711600747
 for <ltp@lists.linux.it>; Mon, 29 May 2023 20:34:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5B211F8B2;
 Mon, 29 May 2023 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685385295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdPjBA9r0eqakY+xCdDy/QndyJ1Rtro6SCaz2U1o/uw=;
 b=DMCND/0VaL+JTlCdIclWYQQ7zuh+RHqBSc8A1uEd3Qnlx68MZlnXRNovbV+vSj4b4MUE9h
 4Xvl/hRHJRhJB/5L3aWtT7Yj5Sv75/Km749I20vkXFrqKOm9SrZTNtHss+mKWG6625pKad
 0XliBJyOPe0LQbC2Ifdr03m5enVH7o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685385295;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pdPjBA9r0eqakY+xCdDy/QndyJ1Rtro6SCaz2U1o/uw=;
 b=sE+SH1QJee3U3voM1/HrQvi0jb+iCsHd2lVaBh46boDDglPffwRy6v/CiE4sihaRzh4VlV
 NkxzsSgBR5N6LRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8164513466;
 Mon, 29 May 2023 18:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cmZ5HU/wdGSlcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 May 2023 18:34:55 +0000
Date: Mon, 29 May 2023 20:34:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230529183453.GC17253@pevik>
References: <20230302071555.18420-1-wegao@suse.com>
 <20230316072231.19157-1-wegao@suse.com>
 <20230316072231.19157-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230316072231.19157-3-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] semop04:Refactor with new API
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

Hi Wei

nit: in subject we use space after colon (readability): 
"semop04:Refactor with new API" => "semop04: Refactor with new API"

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/ipc/semop/semop04.c | 159 ++++++------------
>  1 file changed, 56 insertions(+), 103 deletions(-)

> diff --git a/testcases/kernel/syscalls/ipc/semop/semop04.c b/testcases/kernel/syscalls/ipc/semop/semop04.c
> index 582624d60..589d9b0b4 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop04.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop04.c
> @@ -1,36 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (C) 2003-2023 Linux Test Project, Inc.
> + * Author: 2001 Paul Larson <plars@us.ibm.com>
> + * Modified: 2001 Manoj Iyer <manjo@ausin.ibm.com>
>   *
nit: Please remove this line with just star ('*'), when it follows */

> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>   */

> -/*
> - *  FILE        : sem01.c
> - *  DESCRIPTION : Creates a semaphore and two processes.  The processes
> - *                each go through a loop where they semdown, delay for a
> - *                random amount of time, and semup, so they will almost
> - *                always be fighting for control of the semaphore.
> - *  HISTORY:
> - *    01/15/2001 Paul Larson (plars@us.ibm.com)
> - *      -written
> - *    11/09/2001 Manoj Iyer (manjo@ausin.ibm.com)
> - *    Modified.
> - *    - Removed compiler warnings.
> - *      added exit to the end of function main()
> +/*\
> + * [Description]
>   *
> + * Creates a semaphore and two processes.  The processes
> + * each go through a loop where they semdown, delay for a
> + * random amount of time, and semup, so they will almost
> + * always be fighting for control of the semaphore.
>   */

>  #include <unistd.h>
> @@ -41,124 +24,94 @@
>  #include <sys/wait.h>
nit: I'd remove this (we no longer use waitpid()).
Also I'd remove <errno.h> (IMHO no errno is used).

>  #include <sys/ipc.h>
>  #include "lapi/sem.h"
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"

> -int verbose = 0;
> -int loops = 100;
> -int errors = 0;
> +static int loops = 100;
> +static char *opt_loops_str;
I'm not sure if this worth to have opt for loops.
I'd just define it:
#define LOOPS 1000
and not allow to overwrite (even with 1000 it's fast).

> -int semup(int semid)
> +static void semup(int semid)
>  {
>  	struct sembuf semops;
> +
>  	semops.sem_num = 0;
>  	semops.sem_op = 1;
>  	semops.sem_flg = SEM_UNDO;
> -	if (semop(semid, &semops, 1) == -1) {
> -		perror("semup");
> -		errors++;
> -		return 1;
> -	}
> -	return 0;
> +
> +	SAFE_SEMOP(semid, &semops, 1);
>  }

> -int semdown(int semid)
> +static void semdown(int semid)
>  {
>  	struct sembuf semops;
> +
>  	semops.sem_num = 0;
>  	semops.sem_op = -1;
>  	semops.sem_flg = SEM_UNDO;
> -	if (semop(semid, &semops, 1) == -1) {
> -		perror("semdown");
> -		errors++;
> -		return 1;
> -	}
> -	return 0;
> +
> +	SAFE_SEMOP(semid, &semops, 1);
>  }

> -void delayloop()
> +static void delayloop(void)
>  {
>  	int delay;
> +
>  	delay = 1 + ((100.0 * rand()) / RAND_MAX);
> -	if (verbose)
> -		printf("in delay function for %d microseconds\n", delay);
>  	usleep(delay);
>  }

>  void mainloop(int semid)
This should also be static.

>  {
>  	int i;
...
> +	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
> +
> +	pid = SAFE_FORK();
> +
>  	if (pid) {
>  		/* parent */
Please remove this obvious comment.
>  		srand(pid);
>  		mainloop(semid);
...
> +		tst_reap_children();
> +		SAFE_SEMCTL(semid, 0, IPC_RMID, semunion);
> +		tst_res(TPASS, "Semaphore up/down check success");
>  	} else {
>  		/* child */
And this one.
>  		mainloop(semid);
>  	}
> -	exit(0);
>  }
> +
> +static void setup(void)
> +{
> +	if (opt_loops_str)
> +		loops = SAFE_STRTOL(opt_loops_str, 1, INT_MAX);
> +}
This is to be removed.

> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.options = (struct tst_option[]) {
> +		{"l:", &opt_loops_str, "Internal loops for semup/down"},
> +		{}
This is going to be removed.
> +	},
> +	.needs_root = 1,
Do we really need root? I guess no.

Kind regards,
Petr

> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
