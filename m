Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1UcVi0-0004fe-Mp
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 07:01:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UcVhy-00084C-RR
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 07:01:08 +0000
Message-ID: <51933287.6050007@cn.fujitsu.com>
Date: Wed, 15 May 2013 15:00:23 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
In-Reply-To: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2 1/3] mm/ksm: enable merge_across_nodes knob
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

On 05/13/2013 04:43 PM, Zhouping Liu wrote:
> This kernel commit 90bd6fd31c809(ksm: allow trees per NUMA node)
> introduced a new KSM sysfs knob /sys/kernel/mm/ksm/merge_across_nodes,
> when it is set to zero, only pages from the same node are merged,
> which is different with the previous behavior, and ksm test cases
> sometimes will fail in NUMA system.
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>


Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
