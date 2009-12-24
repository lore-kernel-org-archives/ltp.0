Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpnayak@linux.vnet.ibm.com>) id 1NNsEd-00010C-64
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:27 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NNsEX-0006mY-Td
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 18:16:27 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBOIDHiC030708
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:13:17 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBOIG9C5127348
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:16:09 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBOIG5dO016471
	for <ltp-list@lists.sourceforge.net>; Thu, 24 Dec 2009 11:16:05 -0700
From: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Date: Thu, 24 Dec 2009 23:46:01 +0530
Message-Id: <20091224181601.12571.78565.sendpatchset@localhost.localdomain>
In-Reply-To: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
Subject: [LTP] [Patch 4/4]Readme modified based on review comments
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
To: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

Patch to update readme with information on how to use Power management testcases
to test consolidation testcases.

Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/power_management/README ltp-intermediate-20091209.fixes/testcases/kernel/power_management/README
--- ltp-intermediate-20091209.orig/testcases/kernel/power_management/README	2009-12-09 13:18:25.000000000 +0530
+++ ltp-intermediate-20091209.fixes/testcases/kernel/power_management/README	2009-12-24 23:12:55.293026448 +0530
@@ -77,6 +77,8 @@ Power Management    1  FAIL  :  Required
 
 Then either configuration is not set or the system won't support.
 
+Command to test CPU consolidation & ILB testcases on any system syntax is 'runltp -f power_management_tests_exclusive'. CPU consolidation testcases has to be triggered on a system which is totally idle i.e do not execute exclusive testcases on KVM/xen test setup. 
+
 For CPU consolidation verification ebizzy is included in utils directory of LTP.
 To run cpu consolidation test user has to provide -w <workload> -l <sched_mc_level>.
 Refer to README in LTPROOT/utils/benchmark/ebizzy-0.2 directory for details of ebizzy.
@@ -84,4 +86,6 @@ Refer to README in LTPROOT/utils/benchma
 To test CPU consolidation for sched_mc 2 kernbench has to run. Kernbench needs linux kernel source as input in /root directory . For example download from http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.29.4.tar.bz2. If Linux kernel source not found kernbench wiil  not execute.
 CPU consolidation testcases will not execute if number of CPU's in package is less then 2. If system is hyper threaded but number of CPU is 1 only sched_smt testcases will be excuted. For better coverage of testcases select a system which is atleast quad core and then hyper threaded so that you will observe 8 CPU's in each package.
 
-Timer migration interface test will execute on kernel versions 2.6.31 and above. Timer migration functionality verification testcases will be executed only on suitable architecture like quad core or the number of CPU's in each package should be atleast 4 and above
+Timer migration interface test will execute on kernel versions 2.6.31 and above. 
+
+On Power platform sched_smt & cpu_idle testcases will be executed.

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
