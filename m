Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DAAC6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 18:39:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11DC23CD49B
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 19:39:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40F6A3CB113
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 19:39:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 15AF71A010F3
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 19:39:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA978219DF;
 Wed, 15 Mar 2023 18:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678905547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4xWvQeWyQHa7GHkhgvhZTfRsFUegfrwRtwxdIJmMuc=;
 b=p7cVcpCjMbSxOVbybcHc6XpaOsWv6Rqa6XYQNGuhwHmQLPpuH+CA1Ky5ZKL5vS1eM54Lcn
 KmpRIxbHADnE0h7XCpVl3oC+HbErLeaM4ddy54YBMynQrZ+ZCyX/oe7WefwlmyuneNDp59
 9vDzIOSywGnQ2vledFIB8+xhFh2XP60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678905547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f4xWvQeWyQHa7GHkhgvhZTfRsFUegfrwRtwxdIJmMuc=;
 b=mgxTu/lLiw4OQOqyUEdvdITqMSaUOiCX7fJNc0sMz3rq08mrffWrFI/ML3pmhNdUeB+UPL
 yQXwoNYI5TwY+MBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5266613A2F;
 Wed, 15 Mar 2023 18:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nnSgEcsQEmS1SgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 18:39:07 +0000
Date: Wed, 15 Mar 2023 19:39:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230315183905.GB172450@pevik>
References: <20230120010533.11202-1-wegao@suse.com>
 <20230302071555.18420-1-wegao@suse.com>
 <20230302071555.18420-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230302071555.18420-3-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] semop04:Refactor with new API
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

> +// SPDX-License-Identifier: GPL-2.0
Below is "or (at your option) any later version."
=> 
// SPDX-License-Identifier: GPL-2.0-or-later

>  /*
> - *
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
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (C) 2023 Linux Test Project, Inc.
Actually LTP started to work on the file since 2003, i.e.
* Copyright (C) 2003-2023 Linux Test Project, Inc.
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
Probably you should keep these two names (although you can clean formatting a
bit), e.g.:
* Author: 2001 Paul Larson <plars@us.ibm.com>
* Modified: 2001 Manoj Iyer <manjo@ausin.ibm.com>

> - *    Modified.
> - *    - Removed compiler warnings.
> - *      added exit to the end of function main()

...
> -int semup(int semid)
> +static void semup(int semid)
>  {
>  	struct sembuf semops;
> +
>  	semops.sem_num = 0;
> +
nit: I'd remove this blank line (readability)
>  	semops.sem_op = 1;
> +
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
> +
nit: also here remove blank line.
>  	semops.sem_op = -1;
> +
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
> +
>  	if (verbose)
> -		printf("in delay function for %d microseconds\n", delay);
> +		tst_res(TINFO, "in delay function for %d microseconds", delay);
I'd remove this message.

>  	usleep(delay);
>  }

>  void mainloop(int semid)
>  {
>  	int i;
> +
>  	for (i = 0; i < loops; i++) {
> -		if (semdown(semid)) {
> -			printf("semdown failed\n");
> -		}
> +		semdown(semid);


>  		if (verbose)
> -			printf("sem is down\n");
> +			tst_res(TINFO, "Sem is down");
Actually this message is IMHO useless. semdown() uses SAFE_SEMOP() => we will
see where it failed.

>  		delayloop();
> -		if (semup(semid)) {
> -			printf("semup failed\n");
> -		}
> +		semup(semid);
>  		if (verbose)
> -			printf("sem is up\n");
> +			tst_res(TINFO, "Sem is up");
The same applies there => I'd remove verbose and these messages.
>  	}
>  }

> -int main(int argc, char *argv[])
> +static void run(void)
>  {
> -	int semid, opt;
> +	int semid;
>  	union semun semunion;
> -	extern char *optarg;
>  	pid_t pid;
>  	int chstat;

> -	while ((opt = getopt(argc, argv, "l:vh")) != EOF) {
> -		switch ((char)opt) {
> -		case 'l':
> -			loops = atoi(optarg);
> -			break;
> -		case 'v':
> -			verbose = 1;
> -			break;
> -		case 'h':
> -		default:
> -			printf("Usage: -l loops [-v]\n");
> -			exit(1);
> -		}
> -	}
> -
>  	/* set up the semaphore */
> -	if ((semid = semget((key_t) 9142, 1, 0666 | IPC_CREAT)) < 0) {
> -		printf("error in semget()\n");
> -		exit(-1);
> -	}
> +	semid = SAFE_SEMGET((key_t) 9142, 1, 0666 | IPC_CREAT);
> +	if (semid < 0)
> +		tst_brk(TBROK, "Error in semget id=%i", semid);
All safe messages handles error checking and call tst_brk() on error => this if
check is unreachable (useless) => remove it.
> +
>  	semunion.val = 1;
> -	if (semctl(semid, 0, SETVAL, semunion) == -1) {
> -		printf("error in semctl\n");
> -	}

> -	if ((pid = fork()) < 0) {
> -		printf("fork error\n");
> -		exit(-1);
> -	}
> +	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
> +
> +	pid = SAFE_FORK();
> +	if (pid < 0)
> +		tst_brk(TBROK, "Fork failed pid %i", pid);
Also this if check is useless => remove it.
> +
>  	if (pid) {
>  		/* parent */
>  		srand(pid);
> @@ -147,18 +109,29 @@ int main(int argc, char *argv[])
>  			printf("child exited with status\n");
>  			exit(-1);
>  		}
NOTE: waitpid(), WIFEXITED(), printf() and exit(-1) here should be replaced by tst_reap_children(), see
https://github.com/linux-test-project/ltp/wiki/C-Test-API#18-doing-the-test-in-the-child-process
91e6a95b7 ("clone08: convert to new LTP API")

> +		SAFE_SEMCTL(semid, 0, IPC_RMID, semunion);
> +		tst_res(TPASS, "Semaphore up/down check success");
>  	} else {
>  		/* child */
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
I wonder if we need to specify loops, we have -i which can do more runs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
