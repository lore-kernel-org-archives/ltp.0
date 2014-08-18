Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XJJjr-0007kd-8X
	for ltp-list@lists.sourceforge.net; Mon, 18 Aug 2014 10:00:31 +0000
Date: Mon, 18 Aug 2014 11:59:31 +0200
From: chrubis@suse.cz
Message-ID: <20140818095931.GA3627@rei.suse.cz>
References: <02d3651008f483ee4298d802ace785c4944ce1de.1408015922.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <02d3651008f483ee4298d802ace785c4944ce1de.1408015922.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] profil01: rewrite testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + *   Copyright (c) International Business Machines  Corp., 2002
> + *   Copyright (C) 2014 Linux Test Project, Inc.
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + */
> +/*
> + * ALGORITHM
> + *	Set up a profiling buffer, turn profiling on, set a timer for
> + *	cpu time, spin the pc and wait for timer to go off.
> + *	The profiling buffer should contain some info, highly concentrated.
> + *	We just do a "looks reasonable" check.
> + */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/types.h>
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "usctest.h"
> +
> +#define PROFIL_TIME 5
> +
> +/* should be large enough to hold data for test_profil() .text
> + * on x86_64 this is ~600 bytes, so 16k should enough for all arches */
> +#define PROFIL_BUFLEN (16*1024)
> +#define PROFIL_BUFSZ (16*1024*sizeof(short))
> +
> +char *TCID = "profil01";
> +int TST_TOTAL = 1;
> +
> +#ifndef __UCLIBC__

We can add profil to FILTER_OUT_DIRS for UCLINUX into the
kernel/syscalls/Makefile and drop these ifdefs completly.

> +static volatile sig_atomic_t profil_done;
> +
> +static void alrm_handler(int sig)
> +{
> +	(void) sig;
> +	profil_done = 1;
> +}
> +
> +static void test_profil(void)
> +{
> +	unsigned short buf[PROFIL_BUFSZ] = { 0 };
                           ^
			   PROFIL_BUFLEN ?
> +	size_t offset = (size_t) &test_profil, count = 0;
> +	int ret, i, data[8];
> +
> +	/* make data depend on runtime value, so gcc can't make assumptions */
> +	memset(data, getpid(), sizeof(data));
> +
> +	/* reset for test looping */
> +	profil_done = 0;
> +
> +	/* profil_count in glibc calculates offset as
> +	 *   i = (pc - pc_offset - (void *) 0) / 2
> +	 *   i = i * pc_scale / 65536
> +	 * set scale to 2*65536 to have 1:1 mapping for $pc */
> +	ret = profil(buf, PROFIL_BUFSZ, offset, 2*65536);
                            ^                   ^
			    sizeof(buf) ?       why 2* ?
> +	if (ret)
> +		tst_brkm(TBROK, NULL, "profil returned: %d\n", ret);
> +
> +	signal(SIGALRM, alrm_handler);
> +	alarm(PROFIL_TIME);
> +
> +	while (!profil_done) {
> +		if (data[0])
> +			data[0] = -data[7];
> +		else
> +			data[1] = data[0] / 2;
> +		if (data[2])
> +			data[2] = data[1] * 2;
> +		else
> +			data[3] = data[2] + data[0];
> +		if (data[4])
> +			data[4] = data[3] - data[1];
> +		else
> +			data[5] = data[4] * data[2];
> +		if (data[6])
> +			data[6] = data[5] + data[3];
> +		else
> +			data[7] = data[6] - data[4];
> +	}
> +
> +	for (i = 0; i < PROFIL_BUFLEN; i++)
> +		if (buf[i]) {
> +			tst_resm(TINFO, "buf[0x%04x]=%d", i, buf[i]);
> +			count += buf[i];
> +		}
> +
> +	if (count > 0) {
> +		tst_resm(TPASS, "profil recorded some data");
> +	} else {
> +		/* don't let gcc optimize data away, use it */
> +		tst_resm(TINFO, "data[7]: %d", data[7]);

		It may be more future proof to mark the data as volatile
		instead of assuming something about the compiler.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
