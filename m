Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Sly4s-0008De-IK
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 08:03:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sly4k-00077c-EX
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 08:03:18 +0000
Date: Tue, 03 Jul 2012 04:03:00 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <0ca795c6-6a2b-46b3-a1e5-b9057cafd331@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <dce1058c-b9d4-4670-aee2-c39c7cf970a1@zmail13.collab.prod.int.phx2.redhat.com>
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>, CAI Qian <caiqian@redhat.com>



----- Original Message -----
> From: "Zhouping Liu" <zliu@redhat.com>
> To: gaowanlong@cn.fujitsu.com
> Cc: "LTP List" <ltp-list@lists.sourceforge.net>, "Jan Stancek" <jstancek@redhat.com>, "Caspar Zhang"
> <caspar@casparzhang.com>, "CAI Qian" <caiqian@redhat.com>
> Sent: Friday, 29 June, 2012 6:37:19 AM
> Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
> 
> Hi,
> 
> ----- Original Message -----
> > From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> > To: "Zhouping Liu" <zliu@redhat.com>
> > Cc: "LTP List" <ltp-list@lists.sourceforge.net>, "Jan Stancek"
> > <jstancek@redhat.com>
> > Sent: Friday, June 29, 2012 10:39:57 AM
> > Subject: Re: [LTP] [PATCH] mm/oom05: new testcase
> > 
> > On 06/29/2012 10:23 AM, Zhouping Liu wrote:
> > > Hi,
> > > 
> > > ----- Original Message -----
> > >> From: "Zhouping Liu" <zliu@redhat.com>
> > >> To: "LTP List" <ltp-list@lists.sourceforge.net>
> > >> Sent: Tuesday, June 26, 2012 11:57:35 PM
> > >> Subject: [LTP]  [PATCH] mm/oom05: new testcase
> > >>
> > >> add a new testcase to test OOM on each NUMA node
> > > 
> > > I have tested it in several systems with 2 NUMA nodes and 8 NUMA
> > > nodes,
> > > they are all good, any comment?
> > > 
> > > Thanks,
> > > Zhouping
> > > 
> > >>
> > >> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> > >> ---
> > >>  runtest/mm                       |    1 +
> > >>  testcases/kernel/mem/oom/oom05.c |  131
> > >>  ++++++++++++++++++++++++++++++++++++++
> > >>  2 files changed, 132 insertions(+)
> > >>  create mode 100644 testcases/kernel/mem/oom/oom05.c
> > >>
> > >> diff --git a/runtest/mm b/runtest/mm
> > >> index 2dd66f0..a60c04b 100644
> > >> --- a/runtest/mm
> > >> +++ b/runtest/mm
> > >> @@ -77,6 +77,7 @@ oom01 oom01
> > >>  oom02 oom02
> > >>  oom03 oom03
> > >>  oom04 oom04
> > >> +oom05 oom05
> > >>  
> > >>  swapping01 swapping01 -i 5
> > >>  
> > >> diff --git a/testcases/kernel/mem/oom/oom05.c
> > >> b/testcases/kernel/mem/oom/oom05.c
> > >> new file mode 100644
> > >> index 0000000..046ddbb
> > >> --- /dev/null
> > >> +++ b/testcases/kernel/mem/oom/oom05.c
> > >> @@ -0,0 +1,131 @@
> > >> +/*
> > >> + * Out Of Memory (OOM) on Each NUMA nodes
> > >> + *
> > >> + * The program is designed to cope with unpredictable like
> > >> amount
> > >> and
> > >> + * system physical memory, swap size and other VMM technology
> > >> like
> > >> KSM,
> > >> + * memcg, memory hotplug and so on which may affect the OOM
> > >> + * behaviours. It simply increase the memory consumption 3G
> > >> each
> > >> time
> > >> + * until all the available memory is consumed and OOM is
> > >> triggered.
> > >> + *
> > >> + * Copyright (C) 2012  Red Hat, Inc.
> > >> + * This program is free software; you can redistribute it
> > >> and/or
> > >> + * modify it under the terms of version 2 of the GNU General
> > >> Public
> > >> + * License as published by the Free Software Foundation.
> > >> + *
> > >> + * This program is distributed in the hope that it would be
> > >> useful,
> > >> + * but WITHOUT ANY WARRANTY; without even the implied warranty
> > >> of
> > >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > >> + *
> > >> + * Further, this software is distributed without any warranty
> > >> that
> > >> it
> > >> + * is free of the rightful claim of any third person regarding
> > >> + * infringement or the like.  Any license provided herein,
> > >> whether
> > >> + * implied or otherwise, applies only to this software file.
> > >>  Patent
> > >> + * licenses, if any, provided herein do not apply to
> > >> combinations
> > >> of
> > >> + * this program with other software, or any other product
> > >> whatsoever.
> > >> + *
> > >> + * You should have received a copy of the GNU General Public
> > >> License
> > >> + * along with this program; if not, write the Free Software
> > >> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> > >> MA
> > >> + * 02110-1301, USA.
> > >> + */
> > >> +#include <sys/types.h>
> > >> +#include <sys/stat.h>
> > >> +#include <sys/wait.h>
> > >> +#include <errno.h>
> > >> +#include <fcntl.h>
> > >> +#include <stdio.h>
> > >> +#include <stdlib.h>
> > >> +#include <unistd.h>
> > >> +#include "test.h"
> > >> +#include "safe_macros.h"
> > >> +#include "usctest.h"
> > >> +#include "mem.h"
> > >> +
> > >> +char *TCID = "oom05";
> > >> +int TST_TOTAL = 1;
> > >> +
> > >> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> > >> +	&& HAVE_MPOL_CONSTANTS
> > >> +#include <numa.h>
> > >> +#include <numaif.h>
> > >> +
> > >> +int main(int argc, char *argv[])
> > >> +{
> > >> +	char *msg;
> > >> +	int lc;
> > >> +	long nodes[MAXNODES];
> > >> +	int nnodes, i;
> > >> +	pid_t pids[MAXNODES];
> > >> +	int status;
> > >> +	unsigned long nmasks[MAXNODES];
> > >> +
> > >> +	msg = parse_opts(argc, argv, NULL, NULL);
> > >> +	if (msg != NULL)
> > >> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> > >> +
> > >> +#if __WORDSIZE == 32
> > >> +	tst_brkm(TCONF, NULL, "test is not designed for 32-bit
> > >> system.");
> > >> +#endif
> > >> +	nnodes = count_numa(nodes);
> > >> +	if (nnodes <= 1)
> > >> +		tst_brkm(TCONF, NULL, "required a NUMA system.");
> > >> +
> > >> +	setup();
> > >> +
> > >> +	set_sys_tune("overcommit_memory", 1, 1);
> > >> +
> > >> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> > >> +		Tst_count = 0;
> > >> +
> > >> +		for (i = 0; i < nnodes; i++) {
> > >> +			nmasks[i] = 1 << nodes[i];
> > >> +			switch (pids[i] = fork()) {
> > >> +			case -1:
> > >> +				tst_brkm(TBROK|TERRNO, cleanup, "fork");
> > >> +			case 0:
> > >> +				if (set_mempolicy(MPOL_BIND, &nmasks[i],
> > >> +				    MAXNODES) == -1)
> > >> +					tst_brkm(TBROK|TERRNO, cleanup,
> > >> +					    "set_mempolicy");
> > >> +				tst_resm(TINFO, "start oom on numa node%lu",
> > >> +				    nodes[i]);
> > >> +				oom(NORMAL, 0, 0);
> > >> +				exit(0);
> > >> +			}
> > >> +		}
> > 
> > Hi Zhouping,
> > 
> > Does it need get_allowed_nodes() that Jan added?
> > 
> 
> yes, I met some errors when the system has unbalance NUMA system:
> 
> the follow test machine has 2 numa nodes 0-1, I offline all node1's
> cpu
> # echo 0 > /sys/devices/system/node1/cpu*/online
> 
> then you will find node1 don't contain any available cpus:
> 
> # numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3
> node 0 size: 4084 MB
> node 0 free: 2929 MB
> node 1 cpus:
> node 1 size: 4096 MB
> node 1 free: 3949 MB
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
> 
> under such above setup, oom[2|4] will failed:
> 
> ...
> oom02       0  TINFO  :  process cpuset.
> oom02       1  TBROK  :  write /dev/cpuset/1/cpuset.cpus:
> errno=EINVAL(22): Invalid argument
> oom02       2  TBROK  :  Remaining cases broken
> oom02       0  TINFO  :  set overcommit_memory to 0
> oom02       0  TWARN  :  umount /dev/cpuset: errno=EBUSY(16): Device
> or resource busy
> oom02       0  TWARN  :  rmdir /dev/cpuset: errno=EBUSY(16): Device
> or resource busy
> 
> the failure is because node1 didn't have available cpus, but it tried
> to write node1's cpus to /dev/cpuset/1/cpuset.cpus.
> 
> and I tested get_allowed_nodes(), it didn't fix the error,
> with above setup, I expected get_allowed_nodes_arr() can mark node1
> is a unavailable node,
> but in actual it didn't, and it's the similar with count_numa()
> inside testcase/kernel/mem/lib/mem.c.
> so, Jan, do you have any thoughts to avoid the issues? if
> get-allowed_nodes* can fix these issues, I also suggest we can
> define them in ltp/include/numa_helper.h or other file name,
> comments?

Zhouping,

Are other tests, such as move_pages also failing on this setup?

Regards,
Jan

> 
> Thansk,
> Zhuoping
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
