Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YYs1b-0007Ra-97
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 08:11:23 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYs1Z-0002l0-Ih
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 08:11:23 +0000
Date: Fri, 20 Mar 2015 04:11:11 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>
In-Reply-To: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>
References: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>
MIME-Version: 1.0
Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
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
To: Satish Gedela <satish.gedela@lge.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Satish Gedela" <satish.gedela@lge.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Friday, 20 March, 2015 6:28:34 AM
> Subject: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
> 
> Dear all,
> 
> I am newbie to open source, forgive me with text format
> I am trying to run  LTP with kernel 3.16 on target board having cortex A9
> processor ,
> Facing issue with below test case:
> Test script  name: "memcg_function_test.sh"
> Test case description:  "Test mmap(locked) + alloc_mem > limit_in_bytes"
> 
> Analysis:  memcg_function_test.sh   -----> test_proc_kill
> 						                  ------->memcg_lib.sh
> 									             -------->memcg_process
>     memcg_process
>     ------>ltp/testcases/kernel/controllers/memcg/functional/memcg_process.c
>   
> mmap_lock1 () function is calling in memcg_process.c and
> it calls mmap function with flags MAP_PRIVATE | MAP_ANYNOMOUS | MAP_LOCKED
> {noformat}
> p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
>       MAP_PRIVATE | MAP_LOCKED, 0, 0);
> {noformat}
> 
> but man page of mmap is mentioned as:
> {noformat}
> MAP_ANONYMOUS
>         The  mapping  is  not  backed  by  any  file; its contents are
>         initialized to zero.  The fd and offset arguments are
>         ignored; however, some implementations require fd to be -1 if
>         MAP_ANONYMOUS (or MAP_ANON) is specified, and portable
>         applications should ensure this.  The use of MAP_ANONYMOUS in
>         conjunction with MAP_SHARED is only supported on Linux
>         since kernel 2.4.
> {noformat}
> 
> In my case, we are trying to lock the pages with flags  MAP_PRIVATE |
> MAP_ANYNOMOUS |  MAP_LOCKED  and  it is failing.

Hi,

failing how? EINVAL or something else?
Do you see mmap14 failing as well? If so, can you run it via strace?

Regards,
Jan

> and with  MAP_SHARED | MAP_ANYNOMOUS |  MAP_LOCKED , it is failing
> but with MAP_PRIVATE | MAP_LOCKED and
> with MAP_SHARED | MAP_LOCKED it is working.
> 
> Is there any changes made to kernel or
> test case has to update with MAP_SHARED instead of MAP_PRIVATE flag.
> 
> Thank you in advance.
> Regards
> Satish.G
> 
>    
> 
> 
> 
> 
> 
>     																															 
> 
> 
> 
>   
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website,
> sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for
> all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
