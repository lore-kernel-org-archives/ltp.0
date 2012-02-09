Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvTwC-00086s-4y
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 13:21:24 +0000
Date: Thu, 9 Feb 2012 14:35:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209133519.GB27782@saboteur.suse.cz>
References: <1328692433-24296-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F323FCD.1090203@casparzhang.com>
	<4F33C2D0.9070801@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F33C2D0.9070801@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v4 0/4] hugemmap: auto mount fix
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>   hugemmap01: auto mount the temporary dir for testing
> >>   hugemmap02: auto mount the temporary dir for testing
> >>   hugemmap03: auto mount the temporary dir for testing
> >>   hugemmap04: auto mount the temporary dir for testing
> >>
> >>  runtest/hugetlb                                    |    8 ++--
> >>  testcases/kernel/mem/hugetlb/hugemmap/Makefile     |   11 ++++
> >>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |   55 +++++++++++++-------
> >>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |   50 ++++++++++++------
> >>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap03.c |   55 +++++++++++++-------
> >>  testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |   53 ++++++++++++-------
> >>  6 files changed, 155 insertions(+), 77 deletions(-)

I've got:

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/metan/Work/git/ltp-dev/testcases/kernel/include -I/home/metan/Work/git/ltp-dev/testcases/kernel/mem/hugetlb/hugemmap/../lib -I/home/metan/Work/git/ltp-dev/testcases/kernel/mem/hugetlb/hugemmap/../../lib -I../../../../../include -I../../../../../include   -L/home/metan/Work/git/ltp-dev/testcases/kernel/mem/hugetlb/hugemmap/../lib -L/home/metan/Work/git/ltp-dev/testcases/kernel/mem/hugetlb/hugemmap/../../lib -L../../../../../lib  hugemmap04.c   -lltp -lipc_hugetlb -lmem -o hugemmap04
/home/metan/Work/git/ltp-dev/testcases/kernel/mem/hugetlb/hugemmap/../../lib/libmem.a(mem.o): In function `oom':
/home/metan/Work/git/ltp-dev/testcases/kernel/mem/lib/mem.c:37: undefined reference to `set_mempolicy'
collect2: ld returned 1 exit status
make: *** [hugemmap04] Error 1

Which looks like forgotten $(NUMA_LIBS) in LDFLAGS when you have numa devel libs installed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
