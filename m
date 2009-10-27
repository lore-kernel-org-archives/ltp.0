Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2gQe-00046d-M8
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 07:25:16 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2gQX-00064Y-ME
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 07:25:16 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9R7NtHg010395
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:23:55 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9R7OwX0141456
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:24:58 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9R7QTat014680
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Oct 2009 01:26:29 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910262217q7a640805qaef5f6888699f850@mail.gmail.com>
References: <d51f89b0910262146r17a443b7qc6ff84eb68c5a1d0@mail.gmail.com>
	<364299f40910262217q7a640805qaef5f6888699f850@mail.gmail.com>
Date: Tue, 27 Oct 2009 12:54:51 +0530
Message-Id: <1256628291.4957.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Issue while running runpwtests.sh
Reply-To: subrata@linux.vnet.ibm.com
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
To: "poornima.nayak" <poornima.nayak@in.ibm.com>, poornima nayak <mpnayak@linux.vnet.ibm.com>
Cc: rohit verma <rohit.170309@gmail.com>, LTP List <ltp-list@lists.sourceforge.net>

Hi Poornima,

Can you please look into this ?

Regards--
Subrata

On Mon, 2009-10-26 at 22:17 -0700, Garrett Cooper wrote:
> On Mon, Oct 26, 2009 at 9:46 PM, rohit verma <rohit.170309@gmail.com> wrote:
> > hi,
> >     The script is showing test fail even if it has already detected
> > system configuration does not support this test.
> >
> > This is the log output
> > Are we really executing this ?
> > Power_Management    1  TCONF  :  Not a suitable architecture for SCHED_MC test
> > ./test_sched_smt.sh: ---Valid test cases---
> > ./test_sched_smt.sh: Testcase PASS: echo 0 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS: echo 1 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS: echo 2 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: ---Invalid test cases---
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 3 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 4 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 5 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 6 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 7 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 8 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo a >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo abcefg >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo x1999 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo xffff >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo -1 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo -00000 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo
> > 200000000000000000000000000000000000000000000000000000000000000000000000000000
> >> /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo ox324 >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo
> > -0xfffffffffffffffffffff >
> > /sys/devices/system/cpu/sched_smt_power_savings
> > Power_Management    2  TPASS  :  SCHED_SMT sysfs test
> > /home/ltp/ltp-full-20090930/testcases/bin/check_cpufreq_sysfs_files.sh:
> > PASS: Checking cpu freq sysfs files
> > Power_Management    3  TPASS  :  CPUFREQ sysfs tests
> > /home/ltp/ltp-full-20090930/testcases/bin/change_govr.sh: PASS:
> > Changing cpu governors
> > Power_Management    4  TPASS  :  Changing governors
> > /home/ltp/ltp-full-20090930/testcases/bin/change_freq.sh: PASS:
> > Changing cpu frequencies
> > Power_Management    5  TPASS  :  Changing frequncies
> > FATAL: Module cpufreq_conservative not found.
> > /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> > Loading of module cpufreq_conservative or check whether you compiled
> > as module or not
> > FATAL: Module cpufreq_powersave not found.
> > /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> > Loading of module cpufreq_powersave or check whether you compiled as
> > module or not
> > FATAL: Module cpufreq_conservative not found.
> > /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> > Loading of module cpufreq_conservative or check whether you compiled
> > as module or not
> > FATAL: Module cpufreq_powersave not found.
> > /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> > Loading of module cpufreq_powersave or check whether you compiled as
> > module or not
> > Power_Management    6  TFAIL  :  Loading and Unloading of governor
> > kernel         modules got failed
> > /home/ltp/ltp-full-20090930/testcases/bin/check_cpuidle_sysfs_files.sh:
> > PASS: Checking cpu idle sysfs files
> > Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
> > max sched mc 2
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management    8  TFAIL  :  sched domain test for sched_mc=0
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management    9  TPASS  :  sched domain test for sched_mc=0 & sched_smt=0
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   10  TPASS  :  sched domain test for sched_mc=0 & sched_smt=1
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   11  TPASS  :  sched domain test for sched_mc=0 & sched_smt=2
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   12  TFAIL  :  sched domain test for sched_mc=1
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   13  TPASS  :  sched domain test for sched_mc=1 & sched_smt=0
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   14  TPASS  :  sched domain test for sched_mc=1 & sched_smt=1
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   15  TPASS  :  sched domain test for sched_mc=1 & sched_smt=2
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   16  TFAIL  :  sched domain test for sched_mc=2
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   17  TPASS  :  sched domain test for sched_mc=2 & sched_smt=0
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   18  TPASS  :  sched domain test for sched_mc=2 & sched_smt=1
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> > Power_Management   19  TPASS  :  sched domain test for sched_mc=2 & sched_smt=2
> > argument is timer_migrationPower_Management   20  TCONF  :  Kernel
> > version does not support Timer migration
> 
> Hi Rohit,
>     I reported this quite a while ago, but the maintainer at IBM
> appears MIA. Seriously considering checking in my revised version
> because it passes QA a lot better than this one does...
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
