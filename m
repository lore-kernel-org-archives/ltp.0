Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UajsG-0004Cb-0R
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:44:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UajsE-0006QI-Ci
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:44:23 +0000
Message-ID: <518CC158.20108@cn.fujitsu.com>
Date: Fri, 10 May 2013 17:43:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
In-Reply-To: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob
 before testing
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

On 05/10/2013 05:13 PM, Zhouping Liu wrote:
> This kernel commit 90bd6fd31c809(ksm: allow trees per NUMA node)
> introduced a new KSM sysfs knob /sys/kernel/mm/ksm/merge_across_nodes,
> when it is set to zero, only pages from the same node are merged,
> which is different with the previous behavior, and ksm test cases
> sometimes will fail in NUMA system.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>

While how about wrap the set and reset "merge_across_nodes" value to functions,
so that we can reduce the dup code and dup comments?

Thanks,
Wanlong Gao


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
