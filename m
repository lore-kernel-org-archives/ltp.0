Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1UIGKv-0003Jd-Sm
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 10:33:37 +0000
Received: from mail-pb0-f44.google.com ([209.85.160.44])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UIGKt-0001Ef-PD
	for ltp-list@lists.sourceforge.net; Wed, 20 Mar 2013 10:33:37 +0000
Received: by mail-pb0-f44.google.com with SMTP id wz12so1244814pbc.31
	for <ltp-list@lists.sourceforge.net>;
	Wed, 20 Mar 2013 03:33:29 -0700 (PDT)
Message-ID: <51498EA1.6060102@casparzhang.com>
Date: Wed, 20 Mar 2013 18:25:37 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <cover.1363664213.git.zliu@redhat.com>
In-Reply-To: <cover.1363664213.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v4 0/7] mm/oom: extend the coverage of OOM
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/19/2013 11:40 AM, Zhouping Liu wrote:
> changed log from v1 to v2:
>   1. added a new is_numa() function instead of ISNUMA global variable;
>   2. added new patch to remove the prefix underscroe '_' of the
>      internal function name;
>   3. used SAFE_FILE_SCANF() instead of read_file().
>   4. some cleanup...
>
> changed log from v2 to v3:
>   1. as Jan's suggestion, pass 'nodes=NULL' to get_allowed_nodes_arr()
>      in is_numa(), and free 'nodes' variable when it passed a non-NULL
>      value inside testoom().
>
> changed log from v3 to v4:
>   1. fixed some patch style error
>
> The patch set updated all OOM testcases, and added a new testcase.
>
> Inside old version, OOM only test MPOL_MBIND mempolicy in NUMA
> system, and the combination of CPUSET, MEMCG & NUMA is complex,
> and not clear. Also CPUSET is only used in NUMA system.
>
> These patch set adjust them, now we can coverage the below tests:
>   1) OOM under normal - oom01
>   2) OOM under all mempolicy - oom02
>   3) OOM under MEMCG (+ mempolicy) - oom03
>   4) OOM under CPUSET (+ mempolicy)  - oom04
>   5) OOM under CPUSET & MEMCG - oom05
>
> Zhouping Liu (7):
>    lib/mem: modified _gather_cpus() as _gather_node_cpus()
>    mm/oom02: modified 'OOM for NUMA' as 'OOM for mempolicy'
>    numa_helper: added a new function is_numa()
>    mm/oom0[3|4]: added 'OOM for CPUSET' and moved 'OOM with MEMCG &
>      numa' to oom03
>    lib/mem: updated testoom() and oom() funcs
>    mm/oom05: new testcase
>    lib/mem: removed the prefix underscore '_' of the internal function
>      name
>
>   runtest/mm                             |   1 +
>   testcases/kernel/include/numa_helper.h |   1 +
>   testcases/kernel/lib/numa_helper.c     |  24 ++++++
>   testcases/kernel/mem/include/mem.h     |   4 +-
>   testcases/kernel/mem/lib/mem.c         | 147 +++++++++++++++++++++------------
>   testcases/kernel/mem/oom/oom01.c       |   6 +-
>   testcases/kernel/mem/oom/oom02.c       |  20 +++--
>   testcases/kernel/mem/oom/oom03.c       |  23 +++++-
>   testcases/kernel/mem/oom/oom04.c       |  60 ++++++--------
>   testcases/kernel/mem/oom/oom05.c       | 147 +++++++++++++++++++++++++++++++++
>   10 files changed, 328 insertions(+), 105 deletions(-)
>   create mode 100644 testcases/kernel/mem/oom/oom05.c
>

Series Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
