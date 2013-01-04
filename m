Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Tr0FU-0001tG-1g
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 05:55:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tr0FR-0008Mt-QR
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 05:55:19 +0000
Message-ID: <50E66EDD.2010707@cn.fujitsu.com>
Date: Fri, 04 Jan 2013 13:55:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <38bbdc8adabaf3b66b9442c474b685e8c0838d06.1346072038.git.zliu@redhat.com>
In-Reply-To: <38bbdc8adabaf3b66b9442c474b685e8c0838d06.1346072038.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2] mm/oom05: new testcase
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>, Caspar Zhang <caspar@casparzhang.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 08/27/2012 09:01 PM, Zhouping Liu wrote:
> add a new testcase to test OOM on each NUMA node at the same time.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

Any update, or Caspar, did you finish reviewing this?

Thanks,
Wanlong Gao


> ---
>  runtest/mm                       |   1 +
>  testcases/kernel/mem/oom/oom05.c | 137 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 138 insertions(+)
>  create mode 100644 testcases/kernel/mem/oom/oom05.c
> 
> change log from v1 to v2:
> 
> used numa_helper.h lib
> 
> diff --git a/runtest/mm b/runtest/mm
> index 2dd66f0..a60c04b 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -77,6 +77,7 @@ oom01 oom01
>  oom02 oom02
>  oom03 oom03
>  oom04 oom04
> +oom05 oom05
>  
>  swapping01 swapping01 -i 5
>  
> diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
> new file mode 100644
> index 0000000..5f49447
> --- /dev/null
> +++ b/testcases/kernel/mem/oom/oom05.c
> @@ -0,0 +1,137 @@
> +/*
> + * Out Of Memory (OOM) on Each NUMA node at the same time
> + *
> + * The program is designed to cope with unpredictable like amount and
> + * system physical memory, swap size and other VMM technology like KSM,
> + * memcg, memory hotplug and so on which may affect the OOM
> + * behaviours. It simply increase the memory consumption 3G each time
> + * until all the available memory is consumed and OOM is triggered.
> + *
> + * Copyright (C) 2012  Red Hat, Inc.
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
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "usctest.h"
> +#include "mem.h"
> +#include "numa_helper.h"
> +
> +char *TCID = "oom05";
> +int TST_TOTAL = 1;
> +
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> +        && HAVE_MPOL_CONSTANTS
> +#include <numa.h>
> +#include <numaif.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	char *msg;
> +	int lc;
> +	int *nodes, nnodes, i;
> +	pid_t pids[MAXNODES];
> +	int status;
> +	unsigned long nmasks[MAXNODES];
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +#if __WORDSIZE == 32
> +	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
> +#endif
> +	if (get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &nnodes, &nodes) < 0)
> +		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes_arr");
> +	if (nnodes <= 1)
> +		tst_brkm(TCONF, NULL, "requres a NUMA system.");
> +
> +	setup();
> +
> +	set_sys_tune("overcommit_memory", 1, 1);
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +
> +		for (i = 0; i < nnodes; i++) {
> +			nmasks[i] = 1 << nodes[i];
> +			switch (pids[i] = fork()) {
> +			case -1:
> +				tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +			case 0:
> +				if (set_mempolicy(MPOL_BIND, &nmasks[i],
> +				    MAXNODES)== -1)
> +					tst_brkm(TBROK | TERRNO, cleanup,
> +					    "set_mempolicy");
> +
> +				tst_resm(TINFO, "start oom on numa node%d",
> +				    nodes[i]);
> +
> +				testoom(0, 0, 0);
> +
> +				exit(0);
> +			}
> +		}
> +
> +		for (i = 0; i < nnodes; i++) {
> +			if (waitpid(pids[i], &status, WUNTRACED | WCONTINUED)
> +			    == -1)
> +				tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> +			if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> +				tst_resm(TFAIL,
> +				    "check_monitor child exit with status: %d",
> +				    status);
> +		}
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	tst_require_root(NULL);
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +
> +	overcommit = get_sys_tune("overcommit_memory");
> +}
> +
> +void cleanup(void)
> +{
> +	set_sys_tune("overcommit_memory", overcommit, 0);
> +
> +	TEST_CLEANUP;
> +}
> +
> +#else				/* no NUMA */
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
> +}
> +#endif
> 


------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
