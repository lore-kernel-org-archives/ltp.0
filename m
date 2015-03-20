Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <satish.gedela@lge.com>) id 1YYvJd-0000Yc-4N
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 11:42:13 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YYvJa-0000QY-O8
	for ltp-list@lists.sourceforge.net; Fri, 20 Mar 2015 11:42:13 +0000
From: Satish Gedela <satish.gedela@lge.com>
Date: Fri, 20 Mar 2015 20:42:00 +0900
Message-ID: <756183AD4F83414184BA6A0635785E70A55C4BDC@LGEVEXMBAPSVC1.LGE.NET>
References: <756183AD4F83414184BA6A0635785E70A55C4B3C@LGEVEXMBAPSVC1.LGE.NET>
	<1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>
In-Reply-To: <1848532869.446726.1426839071051.JavaMail.zimbra@redhat.com>
Content-Language: en-US
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
To: Jan Stancek <jstancek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>



> -----Original Message-----
> From: Jan Stancek [mailto:jstancek@redhat.com]
> Sent: Friday, March 20, 2015 1:41 PM
> To: Satish Gedela/LGSIA CSP-2(satish.gedela@lge.com)
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
> 
> 
> 
> ----- Original Message -----
> > From: "Satish Gedela" <satish.gedela@lge.com>
> > To: ltp-list@lists.sourceforge.net
> > Sent: Friday, 20 March, 2015 6:28:34 AM
> > Subject: [LTP] MAP_LOCKED issue in mmap with MAP_ANYNOMOUS
> >
> > Dear all,
> >
> > I am newbie to open source, forgive me with text format I am trying to
> > run  LTP with kernel 3.16 on target board having cortex A9 processor ,
> > Facing issue with below test case:
> > Test script  name: "memcg_function_test.sh"
> > Test case description:  "Test mmap(locked) + alloc_mem > limit_in_bytes"
> >
> > Analysis:  memcg_function_test.sh   -----> test_proc_kill
> > 						                  ------->memcg_lib.sh
> >
> -------->memcg_process
> >     memcg_process
> >
> > ------>ltp/testcases/kernel/controllers/memcg/functional/memcg_process
> > .c
> >
> > mmap_lock1 () function is calling in memcg_process.c and it calls mmap
> > function with flags MAP_PRIVATE | MAP_ANYNOMOUS | MAP_LOCKED
> > {noformat} p = mmap(NULL, memsize, PROT_WRITE | PROT_READ,
> >       MAP_PRIVATE | MAP_LOCKED, 0, 0); {noformat}
> >
> > but man page of mmap is mentioned as:
> > {noformat}
> > MAP_ANONYMOUS
> >         The  mapping  is  not  backed  by  any  file; its contents are
> >         initialized to zero.  The fd and offset arguments are
> >         ignored; however, some implementations require fd to be -1 if
> >         MAP_ANONYMOUS (or MAP_ANON) is specified, and portable
> >         applications should ensure this.  The use of MAP_ANONYMOUS in
> >         conjunction with MAP_SHARED is only supported on Linux
> >         since kernel 2.4.
> > {noformat}
> >
> > In my case, we are trying to lock the pages with flags  MAP_PRIVATE |
> > MAP_ANYNOMOUS |  MAP_LOCKED  and  it is failing.
> 
> Hi,
> 
> failing how? EINVAL or something else?
> Do you see mmap14 failing as well? If so, can you run it via strace?
> 
> Regards,
> Jan
> 
Hi Jan,
Failing  to kill process PID.
Not getting EINVAL 
I did not test mmap14 but I replaced 5th argument with  '-1' instead of '0' (Based on mmap14 test case)
still getting test case failure.

Test procedure followed:

Test case description : "kill the process if memory limit exceeds , 
Process memory locked through MAP_LOCKED  in test_ case_ 14 and using mlock() in test_case_ 15"

Running LTP on work station using
	$make configure
	$make 
	$make install
And copy ltp , kernel, sysinfo.sh, tools  into target directory " /opt " 
and on target running below commnad

#./runltp -f controllers  > log.txt

From log report, identified mmap-lock1 (MAP_LOCKED)  is failing and mmap-lock2 (mlock2)  is passing 
So from the memcg_process.c file
	mmap_lock1() is using mmap () with MAP_PRIVATE | MAP_ANYNOMOUS | MAP_LOCKED
	mmap_lock2 is using mmap () with MAP_PRIVATE | MAP_ANYNOMOUS 
	and mlock() function call.

 In process of debugging, I replaced mmap_lock1 with mmap_lock2 , in test _case_ 14 and it is working successfully.
So I identified issue is in mmap() call and 
replaced flag as "MAP_SHARED | MAP_LOCKED"  and  "MAP_PRIVATE  | MAP_LOCKED "in mmap, 
it is working successfully in both cases but not with MAP_ANYNOMOUS flag.

Regards
Satish.G

> > and with  MAP_SHARED | MAP_ANYNOMOUS |  MAP_LOCKED , it is failing
> but
> > with MAP_PRIVATE | MAP_LOCKED and with MAP_SHARED |
> MAP_LOCKED it is
> > working.
> >
> > Is there any changes made to kernel or test case has to update with
> > MAP_SHARED instead of MAP_PRIVATE flag.
> >
> > Thank you in advance.
> > Regards
> > Satish.G
> >
> >
> >
> >
> >
> >
> >
> >
> 
> 
> 
> >
> >
> >
> >
> >
> > ----------------------------------------------------------------------
> > -------- Dive into the World of Parallel Programming The Go Parallel
> > Website, sponsored by Intel and developed in partnership with Slashdot
> > Media, is your hub for all things parallel software development, from
> > weekly thought leadership blogs to news, videos, case studies,
> > tutorials and more. Take a look and join the conversation now.
> > http://goparallel.sourceforge.net/
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
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
