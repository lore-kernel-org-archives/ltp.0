Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R20ed-0002qI-J8
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 12:57:59 +0000
Date: Fri, 9 Sep 2011 14:58:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909125842.GC5501@saboteur.suse.cz>
References: <509849466.139019.1314187429984.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1255783292.60926.1315553206606.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1255783292.60926.1315553206606.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v4 2/2] mem/tunable: new testcase about
 overcommiting memory
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> @@ -0,0 +1,282 @@
> +/*
> + * Description:
> + *
> + * There are two tunables overcommit_memory and overcommit_ratio under
> + * /proc/sys/vm/, which can control memory overcommitment.
> + *
> + * The overcommit_memory contains a flag that enables memory
> + * overcommitment, it has three values:
> + * - When this flag is 0, the kernel attempts to estimate the amount
> + *   of free memory left when userspace requests more memory.
> + * - When this flag is 1, the kernel pretends there is always enough
> + *   memory until it actually runs out.
> + * - When this flag is 2, the kernel uses a "never overcommit" policy
> + *   that attempts to prevent any overcommit of memory.
> + *
> + * The overcommit_ratio tunable defines the amount by which the kernel
> + * overextends its memory resources in the event that overcommit_memory
> + * is set to the value of 2. The value in this file represents a
> + * percentage added to the amount of actual RAM in a system when
> + * considering whether to grant a particular memory request.
> + * The general formula for this tunable is:
> + * CommitLimit = SwapTotal + MemTotal * overcommit_ratio
> + * CommitLimit, SwapTotal and MemTotal can read from /proc/meminfo.
> + *
> + * The program is designed to test the two tunables:
> + *
> + * When overcommit_memory = 0, allocatable memory can't overextends
> + * the amount of free memory. I choose the three cases:
> + * a. less than free_total:    free_total / 2, alloc should pass.
> + * b. equal to free_total:     free_total,     alloc should pass.
> + * c. greater than free_total: free_total * 2, alloc should fail.
> + *
> + * When overcommit_memory = 1, it can alloc enough much memory, I
> + * choose the three cases:
> + * a. less than sum_total:    sum_total / 2, alloc should pass
> + * b. equal to sum_total:     sum_total,     alloc should pass
> + * c. greater than sum_total: sum_total * 2, alloc should pass
> + * *note: sum_total = SwapTotal + MemTotal
> + *
> + * When overcommit_memory = 2,
> + * allocatable memory = CommitLimit - Committed_AS
> + * I define it as commit_left, also I choose three cases:
> + * a. less than commit_left:    commit_left / 2, alloc should pass
> + * b. greater than commit_left: commit_left * 2, alloc should fail
> + * c. overcommit limit:         CommitLimit,     alloc should fail
> + * *note: CommitLimit is the current overcommit limit.
> + *        Committed_AS is the amount of memory that system has used.
> + * why I din't choose 'equal to commit_left' as a case, because in
> + * this case, the result is not fixed after I tested some times.
> + *
> + * References:
> + * - Documentation/sysctl/vm.txt
> + * - Documentation/vm/overcommit-accounting
> + *
> + * ********************************************************************
> + * Copyright (C) 2011 Red Hat, Inc.
> + *
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
> + * ********************************************************************
> + */


Maybe the licese should be on the top of the file followed with the test
description (at least most of the tests are organized this way).

> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <linux/mman.h>
> +#include "test.h"
> +#include "usctest.h"
> +#include "../include/mem.h"
> +
> +#define FILE_OVER_MEM		PATH_SYSVM "overcommit_memory"
> +#define FILE_OVER_RATIO		PATH_SYSVM "overcommit_ratio"
> +#define DEFAULT_OVER_RATIO	50LL
> +#define EXPECT_PASS		0
> +#define EXPECT_FAIL		1
> +
> +char *TCID = "overcommit_memory";
> +static long long old_overcommit_memory;
> +static long long old_overcommit_ratio;
> +static long long overcommit_ratio;
> +static long long sum_total;
> +static long long free_total;
> +static long long commit_limit;
> +static long long commit_left;
> +static int R_flag;
> +static char *R_opt;
> +option_t options[] = {
> +	{ "R:", &R_flag, &R_opt },
> +	{ NULL, NULL, NULL }
> +};
> +
> +
> +static void overcommit_memory_test(void);
> +static int heavy_malloc(long long size);
> +static void alloc_and_check(long long size, int expect_result);
> +static void usage(void);
> +static void update_mem(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	int lc;
> +
> +	overcommit_ratio = DEFAULT_OVER_RATIO;
> +
> +	msg = parse_opts(argc, argv, options, &usage);
> +	if (msg != NULL) {
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +		tst_exit();

As said before, please drop the tst_exit() here, it's not needed
anymore after tst_brkm().

> +	}
> +
> +	if (R_flag) {
> +		overcommit_ratio = atoll(R_opt);
> +		if (overcommit_ratio < 0) {
> +			tst_brkm(TBROK, NULL, "-R option is required a"
> +				"Non-negative");
> +			tst_exit();

Here as well.

> +		}
> +	}
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		overcommit_memory_test();
> +	}
> +
> +	cleanup();
> +
> +	tst_exit();
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
