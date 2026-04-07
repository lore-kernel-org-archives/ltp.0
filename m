Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514A6EDB7E3
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 09:54:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7883E2148
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:54:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 835CA3C0424
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:54:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AEFFE60014F
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 11:54:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 181B45BD52;
 Tue,  7 Apr 2026 09:54:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE45C4A0B0;
 Tue,  7 Apr 2026 09:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ROm5MFPU1Gm8dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Apr 2026 09:54:27 +0000
Date: Tue, 7 Apr 2026 11:54:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: =?utf-8?B?4oCcU2FtaXI=?= <samir@linux.ibm.com>
Message-ID: <20260407095418.GA17565@pevik>
References: <20260407062336.127454-1-samir@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260407062336.127454-1-samir@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 181B45BD52
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cfs-scheduler: Fixed "make check" errors and
 warnings.
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

Hi Samir,

> Fixed all make check errors and warnings in cfs_bandwidth01.c and
> hackbench.c to comply with LTP coding style.

I guess you get that info with make check (which is using checkpatch.pl and
other code).

> cfs_bandwidth01.c:
> - Remove initialization of static variable to 0

> hackbench.c:
FYI hackbench.c would deserve to rewrite into new C API. With that many of your
fixes would be not needed because the old code would be deleted.

> - Add SPDX-License-Identifier header
> - Remove FSF mailing address paragraph
> - Remove filename from file header
> - Remove initialization of static variables to 0
> - Convert zero-length array to C99 flexible array
> - Modify barf() function to accept variadic arguments
> - Use __func__ instead of hardcoded function names
> - Separate assignments from if conditions
> - Fix pointer declaration spacing
> - Add blank line after declarations
> - Fix spacing in macro and struct initialization
> - Remove unnecessary braces for single statement

> Both files now pass make check validation with 0 errors and 0 warnings.

> Signed-off-by: Samir <samir@linux.ibm.com>
> ---
>  .../sched/cfs-scheduler/cfs_bandwidth01.c     |   2 +-
>  .../kernel/sched/cfs-scheduler/hackbench.c    | 121 +++++++++---------
>  2 files changed, 58 insertions(+), 65 deletions(-)

> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> index e52858f8e..8c511f060 100644
> --- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> @@ -35,7 +35,7 @@

>  static struct tst_cg_group *cg_level2, *cg_level3a, *cg_level3b;
>  static struct tst_cg_group *cg_workers[3];
> -static int may_have_waiters = 0;
> +static int may_have_waiters;
+1

>  static void set_cpu_quota(const struct tst_cg_group *const cg,
>  			  const float quota_percent)
> diff --git a/testcases/kernel/sched/cfs-scheduler/hackbench.c b/testcases/kernel/sched/cfs-scheduler/hackbench.c
> index 6f37060aa..6a30e1cc8 100644
> --- a/testcases/kernel/sched/cfs-scheduler/hackbench.c
> +++ b/testcases/kernel/sched/cfs-scheduler/hackbench.c
> @@ -1,51 +1,33 @@
> -/******************************************************************************/
> -/* Copyright Rusty Russell,                                                   */
> -/* Copyright Pierre Peiffer                                                   */
> -/* Copyright Zhang, Yanmin,                                                   */
> -/* Copyright Ingo Molnar,                                                     */
> -/* Copyright Arjan van de Ven,                                                */
> -/* Copyright (c) International Business Machines  Corp., 2008                 */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*                                                                            */
> -/******************************************************************************/
> -
> -/******************************************************************************/
> -/*                                                                            */
> -/* File:        hackbench.c                                                   */
> -/*                                                                            */
> -/* Description: hackbench tests the Linux scheduler. Test groups of 20        */
> -/*              processes spraying to 20 receivers                            */
> -/*                                                                            */
> -/* Total Tests: 1                                                             */
> -/*                                                                            */
> -/* Test Name:   hackbench01 and hackbench02                                   */
> -/*                                                                            */
> -/* Test Assertion:                                                            */
> -/*                                                                            */
> -/* Author(s):   Rusty Russell <rusty@rustcorp.com.au>,                        */
> -/*              Pierre Peiffer <pierre.peiffer@bull.net>,                     */
> -/*              Ingo Molnar <mingo@elte.hu>,                                  */
> -/*              Arjan van de Ven <arjan@infradead.org>,                       */
> -/*              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,               */
> -/*              Nathan Lynch <ntl@pobox.com>                                  */
> -/*                                                                            */
> -/* History:     Included into LTP                                             */
> -/*                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>*/
> -/*                                                                            */
> -/******************************************************************************/
> +// SPDX-License-Identifier: GPL-2.0-or-later
FYI we add SPDX only to files which has been converted into new LTP API. I'm ok
to change it, but it would require to add additional cleanup.

> +/*
> + * Copyright Rusty Russell,
> + * Copyright Pierre Peiffer
> + * Copyright Zhang, Yanmin,
> + * Copyright Ingo Molnar,
> + * Copyright Arjan van de Ven,
I know it's not your addition, but I wonder if a copyright without year even
makes sense.

> + * Copyright (c) International Business Machines  Corp., 2008
> + */
> +
> +/*
> + * Description: hackbench tests the Linux scheduler. Test groups of 20
> + * processes spraying to 20 receivers
Missing dot at the end.

> + *
> + * Total Tests: 1
Useless, please remove.
> + *
> + * Test Name:   hackbench01 and hackbench02
Useless, please remove (it can change anyway).
> + *
> + * Test Assertion:
Useless, please remove.
> + *
> + * Author(s):   Rusty Russell <rusty@rustcorp.com.au>,
> + *              Pierre Peiffer <pierre.peiffer@bull.net>,
> + *              Ingo Molnar <mingo@elte.hu>,
> + *              Arjan van de Ven <arjan@infradead.org>,
> + *              "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
> + *              Nathan Lynch <ntl@pobox.com>
Hm, how about to add their mails in copyright section and remove this?

> + *
> + * History:     Included into LTP
> + *                  - June 26 2008 - Subrata Modak<subrata@linux.vnet.ibm.com>
I would remove this (we have git history anyway) and move him to copyright
section.

> + */
>  #include <pthread.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -58,25 +40,26 @@
>  #include <sys/time.h>
>  #include <sys/poll.h>
>  #include <limits.h>
> +#include <stdarg.h>

> -#define SAFE_FREE(p) { if (p) { free(p); (p)=NULL; } }
> +#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }
>  #define DATASIZE 100
>  static struct sender_context **snd_ctx_tab;	/*Table for sender context pointers. */
>  static struct receiver_context **rev_ctx_tab;	/*Table for receiver context pointers. */
> -static int gr_num = 0;		/*For group calculation */
> +static int gr_num;		/*For group calculation */
>  static unsigned int loops = 100;
>  /*
>   * 0 means thread mode and others mean process (default)
>   */
>  static unsigned int process_mode = 1;

> -static int use_pipes = 0;
> +static int use_pipes;
+1

>  struct sender_context {
>  	unsigned int num_fds;
>  	int ready_out;
>  	int wakefd;
> -	int out_fds[0];
> +	int out_fds[];
>  };

>  struct receiver_context {
> @@ -86,9 +69,14 @@ struct receiver_context {
>  	int wakefd;
>  };

> -static void barf(const char *msg)
> +static void barf(const char *fmt, ...)
>  {
> -	fprintf(stderr, "%s (error: %s)\n", msg, strerror(errno));
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vfprintf(stderr, fmt, args);
> +	va_end(args);
> +	fprintf(stderr, " (error: %s)\n", strerror(errno));
>  	exit(1);
FYI in new C API we have tst_brk() and tst_res().
>  }

> @@ -108,18 +96,18 @@ static void fdpair(int fds[2])
>  		if (socketpair(AF_UNIX, SOCK_STREAM, 0, fds) == 0)
>  			return;
>  	}
> -	barf("Creating fdpair");
> +	barf("Creating %s", __func__);
Adding va_*() just to post the name of the function looks useless for me.
Please drop this change.

>  }

>  /* Block until we're ready to go */
>  static void ready(int ready_out, int wakefd)
>  {
>  	char dummy;
> -	struct pollfd pollfd = {.fd = wakefd,.events = POLLIN };
> +	struct pollfd pollfd = {.fd = wakefd, .events = POLLIN };

>  	/* Tell them we're ready. */
>  	if (write(ready_out, &dummy, 1) != 1)
> -		barf("CLIENT: ready write");
> +		barf("CLIENT: %s write", __func__);

>  	/* Wait for "GO" signal */
>  	if (poll(&pollfd, 1, -1) != 1)
> @@ -210,7 +198,8 @@ pthread_t create_worker(void *ctx, void *(*func) (void *))
>  		barf("pthread_attr_setstacksize");
>  #endif

> -	if ((err = pthread_create(&childid, &attr, func, ctx)) != 0) {
> +	err = pthread_create(&childid, &attr, func, ctx);
> +	if (err != 0) {
>  		fprintf(stderr, "pthread_create failed: %s (%d)\n",
>  			strerror(err), err);
>  		exit(-1);
> @@ -235,11 +224,12 @@ void reap_worker(pthread_t id)
>  }

>  /* One group of senders and receivers */
> -static unsigned int group(pthread_t * pth,
> +static unsigned int group(pthread_t *pth,
>  			  unsigned int num_fds, int ready_out, int wakefd)
>  {
>  	unsigned int i;
>  	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context) + num_fds * sizeof(int));
> +
>  	if (!snd_ctx)
>  		barf("malloc()");
>  	else
> @@ -305,8 +295,11 @@ int main(int argc, char *argv[])
>  		argv++;
>  	}

> -	if (argc >= 2 && (num_groups = atoi(argv[1])) == 0)
> -		print_usage_exit();
> +	if (argc >= 2) {
> +		num_groups = atoi(argv[1]);
> +		if (num_groups == 0)
> +			print_usage_exit();
> +	}
+1, assigning variables is really better out of if / while,
although here it's safe, because num_groups is initialized to 10.

Kind regards,
Petr

>  	printf("Running with %d*40 (== %d) tasks.\n",
>  	       num_groups, num_groups * 40);
> @@ -329,7 +322,7 @@ int main(int argc, char *argv[])
>  	snd_ctx_tab = malloc(num_groups * sizeof(void *));
>  	rev_ctx_tab = malloc(num_groups * num_fds * sizeof(void *));
>  	if (!pth_tab || !snd_ctx_tab || !rev_ctx_tab)
> -		barf("main:malloc()");
> +		barf("%s:malloc()", __func__);

>  	fdpair(readyfds);
>  	fdpair(wakefds);
> @@ -363,9 +356,8 @@ int main(int argc, char *argv[])

>  	/* free the memory */
>  	for (i = 0; i < num_groups; i++) {
> -		for (j = 0; j < num_fds; j++) {
> +		for (j = 0; j < num_fds; j++)
>  			SAFE_FREE(rev_ctx_tab[i * num_fds + j])
> -		}
+1
>  		SAFE_FREE(snd_ctx_tab[i]);
>  	}
>  	SAFE_FREE(pth_tab);
> @@ -373,3 +365,4 @@ int main(int argc, char *argv[])
>  	SAFE_FREE(rev_ctx_tab);
>  	exit(0);
>  }
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
