Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SyJfw-0002Uq-Rg
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 09:32:36 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SyJfs-0004os-N5
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 09:32:36 +0000
Date: Mon, 6 Aug 2012 05:32:26 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1219564277.410348.1344245546074.JavaMail.root@redhat.com>
In-Reply-To: <a6931ad85f58a40296244d0dd0f9353a5d979125.1344242276.git.caspar@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3 2/2] mm: use new numa_helper
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "LTP List" <ltp-list@lists.sourceforge.net>
> Sent: Monday, 6 August, 2012 10:38:22 AM
> Subject: [LTP] [PATCH v3 2/2] mm: use new numa_helper
> 
> 
> This patch makes the tests in mem/ dir use numa_helper in
> libkerntest.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  testcases/kernel/mem/cpuset/Makefile           |    1 +
>  testcases/kernel/mem/cpuset/cpuset01.c         |   16 ++++----
>  testcases/kernel/mem/hugetlb/Makefile.inc      |    1 +
>  testcases/kernel/mem/hugetlb/hugemmap/Makefile |    1 +
>  testcases/kernel/mem/include/mem.h             |    2 +-
>  testcases/kernel/mem/ksm/Makefile              |    1 +
>  testcases/kernel/mem/ksm/ksm02.c               |    9 ++--
>  testcases/kernel/mem/ksm/ksm04.c               |    9 ++--
>  testcases/kernel/mem/lib/Makefile              |    1 +
>  testcases/kernel/mem/lib/mem.c                 |   50
>  ++++++++++++++++--------
>  testcases/kernel/mem/oom/Makefile              |    1 +
>  testcases/kernel/mem/oom/oom02.c               |    4 --
>  testcases/kernel/mem/oom/oom04.c               |    4 --
>  testcases/kernel/mem/swapping/Makefile         |    1 +
>  testcases/kernel/mem/thp/Makefile              |    1 +
>  testcases/kernel/mem/tunable/Makefile          |    1 +
>  testcases/kernel/mem/vma/Makefile              |    3 +-
>  testcases/kernel/mem/vma/vma02.c               |   19 ++++++---
>  testcases/kernel/mem/vma/vma04.c               |   11 ++++-
>  19 files changed, 81 insertions(+), 55 deletions(-)
> 

V3 looks OK to me.

Regards,
Jan


> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
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
