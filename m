Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1MFAus-0007FJ-Qb
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 17:51:50 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MFAuo-0004W2-VE
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 17:51:50 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5CHkma6017499
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Jun 2009 13:46:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5CHphio243206
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Jun 2009 13:51:43 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5CHphp4024476
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Jun 2009 13:51:43 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Fri, 12 Jun 2009 23:21:33 +0530
Message-Id: <20090612175132.26047.54266.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 00/05] [3rd Bunch] Port Crackerjack Syscall
	tests(missing) to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>
Cc: Manas Kumar Nayak <maknayak@in.ibm.com>

Hi,

As promised earlier, here lies the final bunch of test cases from
Crackerjack. I would however keep contributing new tests to LTP.

>On Wed, 2009-05-27 at 15:36 +0530, Manas Kumar Nayak wrote:
>Hi,
> 
> >On Tue, 2009-05-19 at 00:39 +0530, Manas Kumar Nayak wrote:
> >Hi,
> > 
> > I have ported the following tests from Crackerjack to LTP.
> > Kindly include them to LTP:
> > 
> > [PATCH 01/21] Add add_key01 test for add_key syscall
> > [PATCH 02/21] Add add_key02 test for add_key syscall
> > [PATCH 03/21] Add bdflush01 test for bdflush syscall
> > [PATCH 04/21] Add exit_group01 test for exit_group syscall
> > [PATCH 05/21] Add keyctl01 test for keyctl syscall
> > [PATCH 06/21] Add newuname01 test for newuname syscall
> > [PATCH 07/21] Add rt_sigaction01 test for rt_sigaction syscall
> > [PATCH 08/21] Add rt_sigprocmask01 test for rt_sigprocmask syscall
> > [PATCH 09/21] Add rt_sigprocmask02 test for rt_sigprocmask syscall
> > [PATCH 10/21] Add rt_sigqueueinfo01 test for rt_sigqueueinfo syscall
> > [PATCH 11/21] Add rt_sigsuspend01 test for rt_sigsuspend syscall
> > [PATCH 12/21] Add set_thread_area01 test for set_thread_area syscall
> > [PATCH 13/21] Add set_thread_area02 test for set_thread_area syscall
> > [PATCH 14/21] Add set_tid_address01 test for set_tid_address syscall
> > [PATCH 15/21] Add sgetmask01 test for sgetmask syscall
> > [PATCH 16/21] Add sigreturn01 test for sigreturn syscall
> > [PATCH 17/21] Add ssetmask01 test for ssetmask syscall
> > [PATCH 18/21] Add timer_getoverrun01 test for timer_getoverrun01 syscall
> > [PATCH 19/21] Add timer_gettime01 test for timer_gettime syscall
> > [PATCH 20/21] Add tkill01 test for tkill syscall
> > [PATCH 21/21] Add tkill02 test for tkill syscall
> > 
> > Todo:
> > 	1) Port the Remaining ones (next week),
> 
> As promised earlier, here remains the 2nd Bunch of tests ported
> from Crackerjack to LTP:
> 
> __001_Add_Utility_Headers_for_these_set_of_tests.patch
> __002_Add_get_mempolicy01_test_for_get_mempolicy_syscall.patch
> __003_Add_clock_getres01_test_for_clock_getres_syscall.patch
> __004_Add_clock_nanosleep01_test_for_clock_nanosleep_syscall.patch
> __005_Add_mq_notify01_test_for_mq_notify_syscall.patch
> __006_Add_ppoll01_test_for_ppoll_syscall.patch
> __007_Add_mq_open01_test_for_mq_open_syscall.patch
> __008_Add_mq_timedreceive01_test_for_mq_timedreceive_syscall.patch
> __009_Add_utimes01_test_for_utimes_syscall.patch
> __010_Add_mq_unlink01_test_for_mq_unlink_syscall.patch
> __011_Add_mq_timedsend01_test_for_mq_timedsend_syscall.patch
> __012_Add_unshare01_test_for_unshare_syscall.patch
> __013_Add_unshare02_test_for_unshare_syscall.patch
> 
> Still TODO:
> -> The remaining testcases will be ported soon.

[PATCH 00/05] [3rd Bunch] Port Crackerjack Syscall tests(missing) to LTP
[PATCH 01/05] Add/Port mbind01 test for mbind() syscall
[PATCH 02/05] Add/Port sched_getaffinity01 test for sched_getaffinity() syscall
[PATCH 03/05] Add/Port waitid01 test for waitid() syscall
[PATCH 04/05] Add/Port waitid02 test for waitid() syscall
[PATCH 05/05] Add/Port quotactl01 test for quotactl() syscall

Regards--
Manas

> 
> Regards--
> Manas
> 
> > 
> > Regards--
> > Manas
> > 

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
