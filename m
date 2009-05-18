Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maknayak@in.ibm.com>) id 1M68cb-0004Yb-9L
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:35:37 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M68cS-0000lm-Bq
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 19:35:37 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4IJ58Wg009517
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:05:08 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4IJ9Axu197212
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:09:10 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4IJ79XI028530
	for <ltp-list@lists.sourceforge.net>; Mon, 18 May 2009 15:07:09 -0400
From: Manas Kumar Nayak <maknayak@in.ibm.com>
Date: Tue, 19 May 2009 00:39:05 +0530
Message-Id: <20090518190905.9777.91288.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH 00/21][1st Bunch] Port Crackerjack Syscall
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
Cc: Deepakraj B Himavantharaj <deepakraj@in.ibm.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

Hi,

I have ported the following tests from Crackerjack to LTP.
Kindly include them to LTP:

[PATCH 01/21] Add add_key01 test for add_key syscall
[PATCH 02/21] Add add_key02 test for add_key syscall
[PATCH 03/21] Add bdflush01 test for bdflush syscall
[PATCH 04/21] Add exit_group01 test for exit_group syscall
[PATCH 05/21] Add keyctl01 test for keyctl syscall
[PATCH 06/21] Add newuname01 test for newuname syscall
[PATCH 07/21] Add rt_sigaction01 test for rt_sigaction syscall
[PATCH 08/21] Add rt_sigprocmask01 test for rt_sigprocmask syscall
[PATCH 09/21] Add rt_sigprocmask02 test for rt_sigprocmask syscall
[PATCH 10/21] Add rt_sigqueueinfo01 test for rt_sigqueueinfo syscall
[PATCH 11/21] Add rt_sigsuspend01 test for rt_sigsuspend syscall
[PATCH 12/21] Add set_thread_area01 test for set_thread_area syscall
[PATCH 13/21] Add set_thread_area02 test for set_thread_area syscall
[PATCH 14/21] Add set_tid_address01 test for set_tid_address syscall
[PATCH 15/21] Add sgetmask01 test for sgetmask syscall
[PATCH 16/21] Add sigreturn01 test for sigreturn syscall
[PATCH 17/21] Add ssetmask01 test for ssetmask syscall
[PATCH 18/21] Add timer_getoverrun01 test for timer_getoverrun01 syscall
[PATCH 19/21] Add timer_gettime01 test for timer_gettime syscall
[PATCH 20/21] Add tkill01 test for tkill syscall
[PATCH 21/21] Add tkill02 test for tkill syscall

Todo:
	1) Port the Remaining ones (next week),

Regards--
Manas


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
