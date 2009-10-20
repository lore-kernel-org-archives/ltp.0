Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rpaulsen@us.ibm.com>) id 1N0HSG-0002ke-En
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 16:21:00 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N0HSC-0008Im-FH
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 16:21:00 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9KGJD10012689
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 12:19:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9KGKdDa247778
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 12:20:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9KGKcbb001442
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Oct 2009 12:20:39 -0400
Message-ID: <OFCE335715.B4309B60-ON85257655.005644B5-86257655.00592CEC@us.ibm.com>
From: Robert Paulsen <rpaulsen@us.ibm.com>
Date: Tue, 20 Oct 2009 11:16:10 -0500
MIME-Version: 1.0
Subject: [LTP] LTP vs. SLES11 -- Some FAILs.
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
To: Linux Test Project <ltp-list@lists.sourceforge.net>
Cc: iranna.ankad@in.ibm.com, Suzuki Poulose <suzuki@in.ibm.com>


Hello,

I ran the latest LTP (20090930) against SLES11:

# cat /etc/issue
Welcome to SUSE Linux Enterprise Server 11 (ppc64) - Kernel \r (\l).
# uname -a
Linux beavis 2.6.27.19-5-ppc64 #1 SMP 2009-02-28 04:40:21 +0100 ppc64 ppc64 ppc64 GNU/Linux

These were all run via "runalltests" so are part of the default set of LTP
tests that run.

There were a number of errors. I didn't expect this as I thought that one
way or another the LTP would have been validated against a standard distro
like SLES11.

Are these known failures? In the LTP or SLES11?

Some of these tests apparently rely on kernel configurations and/or
available resources like real memory that cannot be guaranteed on any
arbitrary installation. Should such tests be run by default?

Some of these tests just look like sloppy tests, for example the
cron_allow01 an cron_deny01 tests.

Some tests assume they will be built on the same system on which they are
run. In his case that assumption was true but it seems like a very unsafe
assumption, especially if a cross build is needed. Even without a cross
build the build and test systems may not always be the same -- the reason
for "make package" as describe in README.ltp-devel and why the Makefile has
a CROSS_COMPILE macro.

Here are the fails from the log file:

eventfd2_03                    FAIL       1
inotify01                      FAIL       1
inotify02                      FAIL       1
ppoll01                        FAIL       2
quotactl01                     FAIL       1
timer_getoverrun01             FAIL       1
timer_gettime01                FAIL       1
utimes01                       FAIL       1
Cap_bounds                     FAIL       127
su01                           FAIL       1
cron02                         FAIL       1
cron_deny01                    FAIL       1
cron_allow01                   FAIL       1
at_deny01                      FAIL       1
at_allow01                     FAIL       1
timer_delete02                 FAIL       1
Numa-testcases                 FAIL       1
hugemmap03                     FAIL       1
hugemmap04                     FAIL       1
hugeshmat01                    FAIL       6
hugeshmat02                    FAIL       6
hugeshmat03                    FAIL       2
hugeshmctl01                   FAIL       6
hugeshmctl02                   FAIL       6
hugeshmctl03                   FAIL       2
hugeshmdt01                    FAIL       6
hugeshmget01                   FAIL       2
hugeshmget02                   FAIL       6
hugeshmget03                   FAIL       6
hugeshmget05                   FAIL       2

A number of tests FAILed despite not showing in the above list. Here is some info from the detailed output file:

pid_namespace4    1  TFAIL  :  Container init is killed by SIGKILL !!!
pid_namespace4    2  TFAIL  :  Container init pid got killed by signal 9
pidns12     1  TFAIL  :  cinit: signalling PID (from other namespace) is not 0, but 27810.
quotactl01    1  TFAIL  :  quotactl01 failed, cmd=0x800002: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    2  TFAIL  :  quotactl01 failed, cmd=0x800003: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    3  TFAIL  :  quotactl01 failed, cmd=0x800007: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    4  TFAIL  :  quotactl01 failed, cmd=0x800008: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    5  TFAIL  :  quotactl01 failed, cmd=0x800005: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    6  TFAIL  :  quotactl01 failed, cmd=0x800006: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    7  TFAIL  :  quotactl01 failed, cmd=0x800004: TEST_ERRNO=EFAULT(14): Bad address
quotactl01    8  TFAIL  :  quotactl01 failed, cmd=0x800001: TEST_ERRNO=EFAULT(14): Bad address

Robert Paulsen
IBM Linux Technology Center, Austin
rpaulsen@us.ibm.com
512-468-0565


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
