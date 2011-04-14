Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yamato@redhat.com>) id 1QANoB-0004pD-GJ
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:46:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QANoA-0003Hc-GP
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:46:11 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3EEk4gJ019857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 10:46:04 -0400
Date: Thu, 14 Apr 2011 23:46:02 +0900 (JST)
Message-Id: <20110414.234602.1101608762130835762.yamato@redhat.com>
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <96be7124cab2f3ebaf59fdca1df63018f80baae0.1302791173.git.czhang@redhat.com>
References: <20110414144437.GF3206@saboteur.suse.cz>
	<96be7124cab2f3ebaf59fdca1df63018f80baae0.1302791173.git.czhang@redhat.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v4] [syscalls] io_submit: fix broken testcase
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
To: czhang@redhat.com
Cc: ltp-list@lists.sourceforge.net

> 
> io_submit01 contains 4 negative testing: EINVAL, EFAULT, EINVAL+EFAULT
> and EBADF. The first 3 testcases didn't initialize the content of 'ctx'
> so that they contained invalid argument in the cases. This may cause
> incorrect result on some architectures, like:
> 
> io_submit01    1  TPASS  :  expected failure - returned value = 22 : Invalid argument
> io_submit01    2  TFAIL  :  unexpected returned value - -22 - expected -14
> io_submit01    3  TPASS  :  expected failure - returned value = 22 : Invalid argument
> io_submit01    4  TPASS  :  expected failure - returned value = 9 : Bad file descriptor
> 
> I fixed this issue by moving the initialization of ctx before the cases,
> also added some additional negative + positive cases. Now tested on x86
> and s390x system, the results seem good:
> 
> io_submit01    1  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    2  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    3  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    4  TPASS  :  expected failure - returned value = -14 : Bad address
> io_submit01    5  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    6  TPASS  :  expected failure - returned value = -9 : Bad file descriptor
> io_submit01    7  TPASS  :  expected success - returned value = 0
> io_submit01    8  TPASS  :  expected success - returned value = 1
> 
> v2: use tempfile instead of read /etc/fstab directly
> v3: add a function to check results
> v4: code style improvement
> 
> Signed-off-by: Caspar Zhang <czhang@redhat.com>
> ---
>  testcases/kernel/syscalls/io_submit/io_submit01.c |  190 +++++++++++----------
>  1 files changed, 100 insertions(+), 90 deletions(-)
> 

Looks good.

Reviewed-by: Masatake YAMATO <yamato@redhat.com>

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
