Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QAl0j-000353-N4
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:32:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QAl0i-0002S9-Vu
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:32:41 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3FFWZHN019534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Apr 2011 11:32:35 -0400
Message-ID: <4DA86504.4070703@redhat.com>
Date: Fri, 15 Apr 2011 23:32:20 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302595961.git.czhang@redhat.com>
	<a8c42cda82df15baf9acaf89ed09b41cc8cb5af8.1302595961.git.czhang@redhat.com>
In-Reply-To: <a8c42cda82df15baf9acaf89ed09b41cc8cb5af8.1302595961.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] ksm: mempolicy syscalls not implemented
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 04/12/2011 04:13 PM, Caspar Zhang wrote:
> 
> since NUMA is only supported on a few i386 systems, mempolicy syscalls
> ([gs]et_mempolicy, mbind) may not implemented, thus, an ENOSYS errno
> should be acceptable.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/mem/ksm/ksm02.c |    9 +++++++--
>  testcases/kernel/mem/ksm/ksm04.c |    9 +++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 

Hi, anyone can review this patch and get it merged if suitable?

Thanks,
Caspar

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
