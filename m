Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0ZTn-0007JJ-CB
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 14:17:07 +0000
Date: Thu, 23 Feb 2012 15:17:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223141737.GA20855@saboteur.suse.cz>
References: <4F432EF6.40601@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F432EF6.40601@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] shmem_2nstest: fix a bug of hang
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> commit d2e9f84 replace fprintf() with snprintf() in tst_print(), but this will
> cause container_test.sh hang in case shmem_2nstest.
> 
> If compile tst_res.c without -O[level], the case will not hang.
> 
> When I test the following cases:
> # ./shmem_2nstest none
> shmem_2nstest    0  TINFO  :  Shared Memory namespace test : none
> shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
> shmem_2nstest    1  TPASS  :  Plain cloned process able to access shmem segment created
> # ./shmem_2nstest unshare
> shmem_2nstest    0  TINFO  :  Shared Memory namespace test : unshare
> shmem_2nstest    0  TINFO  :  Cont1: Able to create shared mem segment
> shmem_2nstest    0  TINFO  :  Cont2: Able to allocate shmem seg with the same key
> shmem_2nstest    1  TPASS  :  unshare : In namespace2 unable to access the shmem seg created in Namespace1
> # ./shmem_2nstest clone
> shmem_2nstest    0  TINFO  :  Shared Memory namespace test : clone
> 
> this will hang up.
> 
> So I think tst_resm("Cont1") will cause hang.

Looked in the code, the stack for cloned process is four pages in size
(see ltp_clone_quick()). And when the tst_resm() is called, the buffer
created on stack to store the message most likely overflows the stack
which results in hang in snprintf(). So I would rather remove this
tst_resm() entirely.

Anyway this is good catch, thanks.

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
