Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QAl2E-0000dt-JE
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:34:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QAl2D-0000lx-Nq
	for ltp-list@lists.sourceforge.net; Fri, 15 Apr 2011 15:34:14 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3FFY7NR030926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Apr 2011 11:34:07 -0400
Message-ID: <4DA86561.9040707@redhat.com>
Date: Fri, 15 Apr 2011 23:33:53 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <13c00d6b60ba3b56e0d774ecc06c701417f3a288.1302693113.git.czhang@redhat.com>
In-Reply-To: <13c00d6b60ba3b56e0d774ecc06c701417f3a288.1302693113.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [mm] cpuset01: stop testing if no numa
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

On 04/13/2011 07:12 PM, Caspar Zhang wrote:
> 
> Since NUMA is only supported by a few types of machines on x86, if no
> NUMA support, the numa_count will return 0, this is also acceptable and
> should stop the test without give an error.
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/mem/cpuset/cpuset01.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Hi, any one review this one and get it merged too, or not?

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
