Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1POXCB-0004dP-9R
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 15:05:11 +0000
Date: Fri, 3 Dec 2010 16:18:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101203151816.GB28084@saboteur.suse.cz>
References: <619032683.757781291112821349.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<563618248.757801291112823614.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <563618248.757801291112823614.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] Stack size mapping is decreased through
 mlock/munlock call
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
To: caiqian@redhat.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> - mlock all lines on /proc/self/maps
> - show mapping
> - munlock all lines on /proc/self/maps
> - show again
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
>  runtest/mm                                |    1 +
>  testcases/kernel/syscalls/mlock/mlock03.c |  106 +++++++++++++++++++++++++++++
>  2 files changed, 107 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/mlock/mlock03.c
> 
> diff --git a/runtest/mm b/runtest/mm
> index 16e60d4..09a339d 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -70,3 +70,4 @@ hugemmap05_3 hugemmap05 -s -m
>  cpuset01 cpuset01 -I 3600
>  
>  mbind01 mbind01
> +mlock01 mlock01 -i 20

Here you are adding mlock01 but the test name below is mlock03.

> diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
> new file mode 100644
> index 0000000..7e66053
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mlock/mlock03.c
> @@ -0,0 +1,106 @@
> +/*
> + * Stack size mapping is decreased through mlock/munlock call.
> + *
> + * - mlock all lines on /proc/self/maps
> + * - show mapping
> + * - munlock all lines on /proc/self/maps
> + * - show again
> + *
> + * Copyright (C) 2010  Red Hat, Inc.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include "test.h"
> +#include "usctest.h"
> +
> +#define KB 1024
> +
> +char *TCID = "mlock03";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	long from, to, first = -1, last = -1;
> +	char b[KB], pid[BUFSIZ];
> +	FILE *fp;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",
> +			msg);
> +	sprintf(pid, "cat /proc/%d/maps", getpid());

I suppose pid was used for opening maps before changing line below to
open("/proc/self/maps", "r") so pid could be removed now.

> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		fp = fopen("/proc/self/maps", "r");
> +		if (fp == NULL)
> +			tst_brkm(TBROK|TERRNO, tst_exit, "fopen");
> +
> +		while (!feof(fp)) {
> +			if (!fgets(b, KB - 1, fp))
> +				break;
> +			b[strlen(b) - 1] = '\0';
> +			sscanf(b, "%lx-%lx", &from, &to);
> +
> +			/* Record the initial stack size. */
> +			if ((lc == 0) && (strstr(b, "[stack]") != NULL))
> +				first = (to - from)/KB;
> +
> +			switch (lc & 1) {
> +			case 0:
> +				if (mlock((const void*)from,
> +						(to - from)) == -1)
> +					tst_resm(TINFO|TERRNO, "mlock");
> +				break;
> +			case 1:
> +				if (munlock((const void*)from,
> +						(to - from)) == -1)
> +					tst_resm(TINFO|TERRNO,
> +						"munlock");
> +				break;
> +			default:
> +				break;
> +			}
> +			tst_resm(TINFO, "%s from %lx to %0lx",
> +				(lc&1) ? "munlock" : "mlock  ",
> +				from, to);
> +
> +			/* Record the final stack size. */
> +			if (strstr(b, "[stack]") != NULL)
> +				last = (to - from)/KB;
> +		}
> +		printf("\n");
> +		fclose(fp);
> +	}
> +	tst_resm(TINFO, "starting stack size is %ld", first);
> +	tst_resm(TINFO, "final stack size is %ld", last);
> +
> +	if (last < first)
> +		tst_resm(TFAIL, "stack size is decreased.");
> +	else
> +		tst_resm(TPASS, "stack size is not decreased.");
> +		
> +	tst_exit();
> +}

Perhaps it would be more consistent to do both mlock() and munlock() for
each test iteration.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
