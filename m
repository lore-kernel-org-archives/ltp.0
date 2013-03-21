Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UITij-0000hL-QH
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 00:51:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UITii-0008VS-9I
	for ltp-list@lists.sourceforge.net; Thu, 21 Mar 2013 00:51:05 +0000
Message-ID: <514A59C0.1060301@cn.fujitsu.com>
Date: Thu, 21 Mar 2013 08:52:16 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1363664213.git.zliu@redhat.com>
In-Reply-To: <cover.1363664213.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v4 0/7] mm/oom: extend the coverage of OOM
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/19/2013 11:40 AM, Zhouping Liu wrote:
> changed log from v1 to v2:
>  1. added a new is_numa() function instead of ISNUMA global variable;
>  2. added new patch to remove the prefix underscroe '_' of the
>     internal function name;
>  3. used SAFE_FILE_SCANF() instead of read_file().
>  4. some cleanup...
> 
> changed log from v2 to v3:
>  1. as Jan's suggestion, pass 'nodes=NULL' to get_allowed_nodes_arr()
>     in is_numa(), and free 'nodes' variable when it passed a non-NULL
>     value inside testoom().
> 
> changed log from v3 to v4:
>  1. fixed some patch style error
> 
> The patch set updated all OOM testcases, and added a new testcase.
> 
> Inside old version, OOM only test MPOL_MBIND mempolicy in NUMA
> system, and the combination of CPUSET, MEMCG & NUMA is complex,
> and not clear. Also CPUSET is only used in NUMA system.
> 
> These patch set adjust them, now we can coverage the below tests:
>  1) OOM under normal - oom01
>  2) OOM under all mempolicy - oom02
>  3) OOM under MEMCG (+ mempolicy) - oom03
>  4) OOM under CPUSET (+ mempolicy)  - oom04
>  5) OOM under CPUSET & MEMCG - oom05


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
