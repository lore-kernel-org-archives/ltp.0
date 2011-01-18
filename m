Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pf7hq-0007Vm-0i
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:18:26 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf7ho-0001S7-Vx
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:18:25 +0000
Date: Tue, 18 Jan 2011 04:18:18 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1296101387.28447.1295342298146.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1971196114.100790.1293758629841.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] cpuset01: fix pathname to remove underscore
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Garrett, any comment/feedback to merge this too?

CAI Qian

----- Original Message -----
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/cpuset/Makefile | 25 +++++++++++++++++++++++++
> testcases/kernel/mem/cpuset/cpuset01.c | 6 +++---
> 2 files changed, 28 insertions(+), 3 deletions(-)
> create mode 100644 testcases/kernel/mem/cpuset/Makefile
> 
> diff --git a/testcases/kernel/mem/cpuset/Makefile
> b/testcases/kernel/mem/cpuset/Makefile
> new file mode 100644
> index 0000000..822e783
> --- /dev/null
> +++ b/testcases/kernel/mem/cpuset/Makefile
> @@ -0,0 +1,25 @@
> +#
> +# Copyright (C) 2010 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or
> modify
> +# it under the terms of the GNU General Public License as published
> by
> +# the Free Software Foundation; either version 2 of the License, or
> (at
> +# your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> +# General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +# 02110-1301, USA.
> +#
> +
> +top_srcdir ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +LDLIBS += $(NUMA_LIBS) -lm
> diff --git a/testcases/kernel/mem/cpuset/cpuset01.c
> b/testcases/kernel/mem/cpuset/cpuset01.c
> index 966e826..27e2d68 100644
> --- a/testcases/kernel/mem/cpuset/cpuset01.c
> +++ b/testcases/kernel/mem/cpuset/cpuset01.c
> @@ -58,7 +58,7 @@ extern int Tst_count;
> #define MAXNODES 512
> #define CPATH "/dev/cpuset"
> #define CPATH_NEW "/dev/cpuset/1"
> -#define _PATH_SYS_SYSTEM "/sys/devices/system"
> +#define PATH_SYS_SYSTEM "/sys/devices/system"
> 
> static pid_t *pids;
> volatile int end;
> @@ -298,7 +298,7 @@ long count_numa(void)
> {
> int nnodes = 0;
> 
> - while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
> + while(path_exist(PATH_SYS_SYSTEM "/node/node%d", nnodes))
> nnodes++;
> 
> return nnodes;
> @@ -308,7 +308,7 @@ long count_cpu(void)
> {
> int ncpus = 0;
> 
> - while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
> + while(path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
> ncpus++;
> 
> return ncpus;
> --
> 1.7.3.2

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
