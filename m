Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SkViQ-0005eK-D5
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 07:34:06 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkViM-0006ws-69
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 07:34:06 +0000
Date: Fri, 29 Jun 2012 03:33:51 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <f706d745-82b7-4c67-875b-da6ed84d5e2e@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FED157D.3050703@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Zhouping Liu" <zliu@redhat.com>
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>, "Jan Stancek" <jstancek@redhat.com>
> Sent: Friday, 29 June, 2012 4:39:57 AM
> Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
> 
> On 06/29/2012 10:23 AM, Zhouping Liu wrote:
> > Hi,
> > 
> > ----- Original Message -----
> >> From: "Zhouping Liu" <zliu@redhat.com>
> >> To: "LTP List" <ltp-list@lists.sourceforge.net>
> >> Sent: Tuesday, June 26, 2012 11:57:35 PM
> >> Subject: [LTP]  [PATCH] mm/oom05: new testcase
> >>
> >> add a new testcase to test OOM on each NUMA node
> > 
> > I have tested it in several systems with 2 NUMA nodes and 8 NUMA
> > nodes,
> > they are all good, any comment?
> > 
> > Thanks,
> > Zhouping
> > 
> >>
> >> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> >> ---
> >>  runtest/mm                       |    1 +
> >>  testcases/kernel/mem/oom/oom05.c |  131
> >>  ++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 132 insertions(+)
> >>  create mode 100644 testcases/kernel/mem/oom/oom05.c
> >>
> >> diff --git a/runtest/mm b/runtest/mm
> >> index 2dd66f0..a60c04b 100644
> >> --- a/runtest/mm
> >> +++ b/runtest/mm
> >> @@ -77,6 +77,7 @@ oom01 oom01
> >>  oom02 oom02
> >>  oom03 oom03
> >>  oom04 oom04
> >> +oom05 oom05
> >>  
> >>  swapping01 swapping01 -i 5
> >>  
> >> diff --git a/testcases/kernel/mem/oom/oom05.c
> >> b/testcases/kernel/mem/oom/oom05.c
> >> new file mode 100644
> >> index 0000000..046ddbb
> >> --- /dev/null
> >> +++ b/testcases/kernel/mem/oom/oom05.c
> >> @@ -0,0 +1,131 @@
> >> +/*
> >> + * Out Of Memory (OOM) on Each NUMA nodes
> >> + *
> >> + * The program is designed to cope with unpredictable like amount
> >> and
> >> + * system physical memory, swap size and other VMM technology
> >> like
> >> KSM,
> >> + * memcg, memory hotplug and so on which may affect the OOM
> >> + * behaviours. It simply increase the memory consumption 3G each
> >> time
> >> + * until all the available memory is consumed and OOM is
> >> triggered.
> >> + *
> >> + * Copyright (C) 2012  Red Hat, Inc.
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of version 2 of the GNU General
> >> Public
> >> + * License as published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it would be
> >> useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> >> + *
> >> + * Further, this software is distributed without any warranty
> >> that
> >> it
> >> + * is free of the rightful claim of any third person regarding
> >> + * infringement or the like.  Any license provided herein,
> >> whether
> >> + * implied or otherwise, applies only to this software file.
> >>  Patent
> >> + * licenses, if any, provided herein do not apply to combinations
> >> of
> >> + * this program with other software, or any other product
> >> whatsoever.
> >> + *
> >> + * You should have received a copy of the GNU General Public
> >> License
> >> + * along with this program; if not, write the Free Software
> >> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> >> + * 02110-1301, USA.
> >> + */
> >> +#include <sys/types.h>
> >> +#include <sys/stat.h>
> >> +#include <sys/wait.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <unistd.h>
> >> +#include "test.h"
> >> +#include "safe_macros.h"
> >> +#include "usctest.h"
> >> +#include "mem.h"
> >> +
> >> +char *TCID = "oom05";
> >> +int TST_TOTAL = 1;
> >> +
> >> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> >> +	&& HAVE_MPOL_CONSTANTS
> >> +#include <numa.h>
> >> +#include <numaif.h>
> >> +
> >> +int main(int argc, char *argv[])
> >> +{
> >> +	char *msg;
> >> +	int lc;
> >> +	long nodes[MAXNODES];
> >> +	int nnodes, i;
> >> +	pid_t pids[MAXNODES];
> >> +	int status;
> >> +	unsigned long nmasks[MAXNODES];
> >> +
> >> +	msg = parse_opts(argc, argv, NULL, NULL);
> >> +	if (msg != NULL)
> >> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> >> +
> >> +#if __WORDSIZE == 32
> >> +	tst_brkm(TCONF, NULL, "test is not designed for 32-bit
> >> system.");
> >> +#endif
> >> +	nnodes = count_numa(nodes);
> >> +	if (nnodes <= 1)
> >> +		tst_brkm(TCONF, NULL, "required a NUMA system.");
> >> +
> >> +	setup();
> >> +
> >> +	set_sys_tune("overcommit_memory", 1, 1);
> >> +
> >> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> >> +		Tst_count = 0;
> >> +
> >> +		for (i = 0; i < nnodes; i++) {
> >> +			nmasks[i] = 1 << nodes[i];
> >> +			switch (pids[i] = fork()) {
> >> +			case -1:
> >> +				tst_brkm(TBROK|TERRNO, cleanup, "fork");
> >> +			case 0:
> >> +				if (set_mempolicy(MPOL_BIND, &nmasks[i],
> >> +				    MAXNODES) == -1)
> >> +					tst_brkm(TBROK|TERRNO, cleanup,
> >> +					    "set_mempolicy");
> >> +				tst_resm(TINFO, "start oom on numa node%lu",
> >> +				    nodes[i]);
> >> +				oom(NORMAL, 0, 0);
> >> +				exit(0);
> >> +			}
> >> +		}
> 
> Hi Zhouping,
> 
> Does it need get_allowed_nodes() that Jan added?

count_numa goes over nodes in /sys/devices/system/node/, so I'm guessing
it will find 2 nodes on this setup:

 4.
 # numactl -H
 available: 2 nodes (0-1)
 node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
 node 0 size: 0 MB
 node 0 free: 0 MB
 node 1 cpus:
 node 1 size: 12288 MB
 node 1 free: 9689 MB
 node distances:
 node   0   1
   0:  10  40
   1:  40  10 

I'll provision that host and check it.

Regards,
Jan

> 
> Thanks,
> Wanlong Gao
> 
> >> +
> >> +		for (i = 0; i < nnodes; i++) {
> >> +			if (waitpid(pids[i], &status, WUNTRACED|WCONTINUED) == -1)
> >> +				tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
> >> +
> >> +			if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> >> +				tst_resm(TFAIL, "child[%d] exit with "
> >> +				    "status: %d", pids[i], status);
> >> +		}
> >> +	}
> >> +	cleanup();
> >> +	tst_exit();
> >> +}
> >> +
> >> +void setup(void)
> >> +{
> >> +	tst_require_root(NULL);
> >> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> >> +	TEST_PAUSE;
> >> +
> >> +	overcommit = get_sys_tune("overcommit_memory");
> >> +}
> >> +
> >> +void cleanup(void)
> >> +{
> >> +	set_sys_tune("overcommit_memory", overcommit, 0);
> >> +
> >> +	TEST_CLEANUP;
> >> +}
> >> +
> >> +#else /* no NUMA */
> >> +int main(void)
> >> +{
> >> +	tst_brkm(TCONF, NULL, "no NUMA development packages
> >> installed.");
> >> +}
> >> +#endif
> >> --
> >> 1.7.10.2
> >>
> >>
> >> ------------------------------------------------------------------------------
> >> Live Security Virtual Conference
> >> Exclusive live event will cover all the ways today's security and
> >> threat landscape has changed and how IT managers can respond.
> >> Discussions
> >> will include endpoint security, mobile security and the latest in
> >> malware
> >> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >>
> > 
> 
> 
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
