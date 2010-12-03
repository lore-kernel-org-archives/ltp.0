Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1POb83-0005xh-RI
	for ltp-list@lists.sourceforge.net; Fri, 03 Dec 2010 19:17:11 +0000
Date: Fri, 3 Dec 2010 20:30:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101203193017.GA3291@saboteur.suse.cz>
References: <1311381980.757701291112760305.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<2137584473.757721291112762914.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2137584473.757721291112762914.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2] mbind_range() vma merge
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
> This is a reproducer from mainline commit
> 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:
> 
> "Strangely, current mbind() doesn't merge vma with neighbor vma although
> it's possible.  Unfortunately, many vma can reduce performance..."
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> v2: add mbind01 to the mm test list; avoid breakage on systems without
>     proper numa libs; code cleanup; fix -lnuma.
> 
>  runtest/mm                           |    2 +
>  testcases/kernel/mem/mbind/Makefile  |   25 ++++++
>  testcases/kernel/mem/mbind/mbind01.c |  150 ++++++++++++++++++++++++++++++++++
>  3 files changed, 177 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/mbind/Makefile
>  create mode 100644 testcases/kernel/mem/mbind/mbind01.c
> 
> diff --git a/runtest/mm b/runtest/mm
> index cf16c0e..16e60d4 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -68,3 +68,5 @@ hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
>  
>  cpuset01 cpuset01 -I 3600
> +
> +mbind01 mbind01
> diff --git a/testcases/kernel/mem/mbind/Makefile b/testcases/kernel/mem/mbind/Makefile
> new file mode 100644
> index 0000000..e202a6b
> --- /dev/null
> +++ b/testcases/kernel/mem/mbind/Makefile
> @@ -0,0 +1,25 @@
> +#
> +#  Copyright (C) 2010  Red Hat, Inc.
> +#
> +#  This program is free software; you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or (at
> +#  your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful, but
> +#  WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program; if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +#  02110-1301, USA.
> +#
> +
> +top_srcdir              ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS 			+= $(NUMA_LIBS)
> \ No newline at end of file
> diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
> new file mode 100644
> index 0000000..a218ad7
> --- /dev/null
> +++ b/testcases/kernel/mem/mbind/mbind01.c
> @@ -0,0 +1,150 @@
> +/*
> + * This is a reproducer from mainline commit
> + * 9d8cebd4bcd7c3878462fdfda34bbcdeb4df7ef4:
> + *
> + * "Strangely, current mbind() doesn't merge vma with neighbor vma
> + * although it's possible.  Unfortunately, many vma can reduce
> + * performance..."
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
> +#include "test.h"
> +#include "usctest.h"
> +#include "config.h"
> +
> +char *TCID = "mbind01";
> +int TST_TOTAL = 1;
> +extern int Tst_count;
> +
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> +	&& HAVE_MPOL_CONSTANTS
> +#include <numaif.h>
> +#include <numa.h>
> +#include <sys/mman.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static unsigned long pagesize;
> +static int opt_node;
> +static char *opt_nodestr;
> +static option_t options[] = {
> +	{ "n:", &opt_node,	&opt_nodestr},
> +	{ NULL, NULL,		NULL}
> +};
> +
> +static void usage(void);
> +
> +int main(int argc, char** argv)
> +{
> +	FILE *fp;
> +	void* addr;
> +	int node, err, lc;
> +	struct bitmask *nmask = numa_allocate_nodemask();
> +	char buf[BUFSIZ], start[BUFSIZ], end[BUFSIZ], string[BUFSIZ];
> +	char *p, *msg;
> +
> +	pagesize = getpagesize();
> +	msg = parse_opts(argc, argv, options, usage);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit,
> +			"OPTION PARSING ERROR - %s", msg);
> +	if (opt_node) {
> +		node = atoi(optarg);
> +		if (node < 1)
> +			tst_brkm(TBROK, tst_exit,
> +				"Number of NUMA nodes cannot be less "
> +				"that 1.");
> +		numa_bitmask_setbit(nmask, node);
> +	} else
> +		numa_bitmask_setbit(nmask, 0);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/* Reset Tst_count in case we are looping. */
> +		Tst_count = 0;
> +
> +		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
> +			MAP_ANON|MAP_PRIVATE, 0, 0);
> +		if (addr == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
> +
> +		tst_resm(TINFO, "pid = %d addr = %p", getpid(), addr);
> +
> +		/* make page populate */
> +		memset(addr, 0, pagesize*3);
> +
> +		/* first mbind */
> +		err = mbind(addr+pagesize, pagesize, MPOL_BIND,
> +			nmask->maskp, nmask->size, MPOL_MF_MOVE_ALL);
> +		if (err != 0)
> +			tst_brkm(TBROK|TERRNO, tst_exit, "mbind1");
> +
> +		/* second mbind */
> +		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);
> +		if (err != 0)
> +			tst_brkm(TBROK|TERRNO, tst_exit, "mbind2 ");
> +
> +		/* /proc/%d/maps in the form of
> +		   "00400000-00406000 r-xp 00000000". */
> +
> +		sprintf(buf, "/proc/%d/maps", getpid());
> +		sprintf(string, "%p", addr);
> +
> +		fp = fopen(buf, "r");

What about using "/proc/self/maps" here and get rid of sprintf() and buf
here.

> +		if (fp == NULL)
> +			tst_brkm(TBROK|TERRNO, tst_exit, "fopen %s",
> +				buf);
> +
> +		while (fgets(buf, BUFSIZ, fp) != NULL) {
> +			/* Find out the 1st VMAs. */
> +			if (sscanf(buf, "%s-%s ", start, end) != 2)
> +				continue;
> +			/* Remove leading 0x. */
> +			if (strcmp(string + 2, start) != 0)
> +				continue;
> +			/* Find out the second VMA. */
> +			if (fgets(buf, BUFSIZ, fp) == NULL)
> +				tst_brkm(TBROK|TERRNO, NULL, "fgets");
> +			p = strtok(buf, "-");
> +			if (p == NULL || strcmp(p, end) != 0)
> +				tst_resm(TPASS, "only 1 VMA.");
> +			else
> +				tst_resm(TFAIL, "more than 1 VMA.");
> +		}
> +		fclose(fp);
> +
> +		if (munmap(addr, pagesize*3) == -1)
> +			tst_brkm(TWARN|TERRNO, tst_exit, "munmap");
> +	}
> +	return 0;
> +}

Empty line here please.

> +void usage(void)
> +{
> +	printf("  -n      Number of NUMA nodes\n");
> +}
> +#else /* no NUMA */
> +int main(void) {
> +	tst_resm(TCONF, "no NUMA development packages installed.");
> +	tst_exit();
> +}
> +#endif

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
