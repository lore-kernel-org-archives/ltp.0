Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M9G2R-0003hq-Gw
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:07:11 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M9G2M-0006s6-Vp
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 10:07:11 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4RA0Yfj018419
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:00:34 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4RA74IH255010
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:07:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4RA746B005707
	for <ltp-list@lists.sourceforge.net>; Wed, 27 May 2009 04:07:04 -0600
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Wed, 27 May 2009 15:36:49 +0530
Message-Id: <20090527100645.18638.75163.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 00/13][2nd Bunch] Port Crackerjack Syscall
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

>On Tue, 2009-05-19 at 00:39 +0530, Manas Kumar Nayak wrote:
>Hi,
> 
> I have ported the following tests from Crackerjack to LTP.
> Kindly include them to LTP:
> 
> [PATCH 01/21] Add add_key01 test for add_key syscall
> [PATCH 02/21] Add add_key02 test for add_key syscall
> [PATCH 03/21] Add bdflush01 test for bdflush syscall
> [PATCH 04/21] Add exit_group01 test for exit_group syscall
> [PATCH 05/21] Add keyctl01 test for keyctl syscall
> [PATCH 06/21] Add newuname01 test for newuname syscall
> [PATCH 07/21] Add rt_sigaction01 test for rt_sigaction syscall
> [PATCH 08/21] Add rt_sigprocmask01 test for rt_sigprocmask syscall
> [PATCH 09/21] Add rt_sigprocmask02 test for rt_sigprocmask syscall
> [PATCH 10/21] Add rt_sigqueueinfo01 test for rt_sigqueueinfo syscall
> [PATCH 11/21] Add rt_sigsuspend01 test for rt_sigsuspend syscall
> [PATCH 12/21] Add set_thread_area01 test for set_thread_area syscall
> [PATCH 13/21] Add set_thread_area02 test for set_thread_area syscall
> [PATCH 14/21] Add set_tid_address01 test for set_tid_address syscall
> [PATCH 15/21] Add sgetmask01 test for sgetmask syscall
> [PATCH 16/21] Add sigreturn01 test for sigreturn syscall
> [PATCH 17/21] Add ssetmask01 test for ssetmask syscall
> [PATCH 18/21] Add timer_getoverrun01 test for timer_getoverrun01 syscall
> [PATCH 19/21] Add timer_gettime01 test for timer_gettime syscall
> [PATCH 20/21] Add tkill01 test for tkill syscall
> [PATCH 21/21] Add tkill02 test for tkill syscall
> 
> Todo:
> 	1) Port the Remaining ones (next week),

As promised earlier, here remains the 2nd Bunch of tests ported
from Crackerjack to LTP:

__001_Add_Utility_Headers_for_these_set_of_tests.patch
__002_Add_get_mempolicy01_test_for_get_mempolicy_syscall.patch
__003_Add_clock_getres01_test_for_clock_getres_syscall.patch
__004_Add_clock_nanosleep01_test_for_clock_nanosleep_syscall.patch
__005_Add_mq_notify01_test_for_mq_notify_syscall.patch
__006_Add_ppoll01_test_for_ppoll_syscall.patch
__007_Add_mq_open01_test_for_mq_open_syscall.patch
__008_Add_mq_timedreceive01_test_for_mq_timedreceive_syscall.patch
__009_Add_utimes01_test_for_utimes_syscall.patch
__010_Add_mq_unlink01_test_for_mq_unlink_syscall.patch
__011_Add_mq_timedsend01_test_for_mq_timedsend_syscall.patch
__012_Add_unshare01_test_for_unshare_syscall.patch
__013_Add_unshare02_test_for_unshare_syscall.patch

Still TODO:
-> The remaining testcases will be ported soon.

Regards--
Manas

> 
> Regards--
> Manas
> 

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
