Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2eQo-000155-Kr
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 05:17:18 +0000
Received: from mail-px0-f183.google.com ([209.85.216.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2eQi-00029I-9y
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 05:17:18 +0000
Received: by pxi13 with SMTP id 13so944167pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 22:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d51f89b0910262146r17a443b7qc6ff84eb68c5a1d0@mail.gmail.com>
References: <d51f89b0910262146r17a443b7qc6ff84eb68c5a1d0@mail.gmail.com>
Date: Mon, 26 Oct 2009 22:17:06 -0700
Message-ID: <364299f40910262217q7a640805qaef5f6888699f850@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Issue while running runpwtests.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: rohit verma <rohit.170309@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Oct 26, 2009 at 9:46 PM, rohit verma <rohit.170309@gmail.com> wrote:
> hi,
> =A0 =A0 The script is showing test fail even if it has already detected
> system configuration does not support this test.
>
> This is the log output
> Are we really executing this ?
> Power_Management =A0 =A01 =A0TCONF =A0: =A0Not a suitable architecture fo=
r SCHED_MC test
> ./test_sched_smt.sh: ---Valid test cases---
> ./test_sched_smt.sh: Testcase PASS: echo 0 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS: echo 1 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS: echo 2 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: ---Invalid test cases---
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 3 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 4 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 5 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 6 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 7 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo 8 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo a >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo abcefg >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo x1999 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo xffff >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo -1 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo -00000 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo
> 2000000000000000000000000000000000000000000000000000000000000000000000000=
00000
>> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo ox324 >
> /sys/devices/system/cpu/sched_smt_power_savings
> ./test_sched_smt.sh: Testcase PASS - Unable to execute: echo
> -0xfffffffffffffffffffff >
> /sys/devices/system/cpu/sched_smt_power_savings
> Power_Management =A0 =A02 =A0TPASS =A0: =A0SCHED_SMT sysfs test
> /home/ltp/ltp-full-20090930/testcases/bin/check_cpufreq_sysfs_files.sh:
> PASS: Checking cpu freq sysfs files
> Power_Management =A0 =A03 =A0TPASS =A0: =A0CPUFREQ sysfs tests
> /home/ltp/ltp-full-20090930/testcases/bin/change_govr.sh: PASS:
> Changing cpu governors
> Power_Management =A0 =A04 =A0TPASS =A0: =A0Changing governors
> /home/ltp/ltp-full-20090930/testcases/bin/change_freq.sh: PASS:
> Changing cpu frequencies
> Power_Management =A0 =A05 =A0TPASS =A0: =A0Changing frequncies
> FATAL: Module cpufreq_conservative not found.
> /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> Loading of module cpufreq_conservative or check whether you compiled
> as module or not
> FATAL: Module cpufreq_powersave not found.
> /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> Loading of module cpufreq_powersave or check whether you compiled as
> module or not
> FATAL: Module cpufreq_conservative not found.
> /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> Loading of module cpufreq_conservative or check whether you compiled
> as module or not
> FATAL: Module cpufreq_powersave not found.
> /home/ltp/ltp-full-20090930/testcases/bin/pwkm_load_unload.sh: FAIL:
> Loading of module cpufreq_powersave or check whether you compiled as
> module or not
> Power_Management =A0 =A06 =A0TFAIL =A0: =A0Loading and Unloading of gover=
nor
> kernel =A0 =A0 =A0 =A0 modules got failed
> /home/ltp/ltp-full-20090930/testcases/bin/check_cpuidle_sysfs_files.sh:
> PASS: Checking cpu idle sysfs files
> Power_Management =A0 =A07 =A0TPASS =A0: =A0CPUIDLE sysfs tests passed
> max sched mc 2
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 =A08 =A0TFAIL =A0: =A0sched domain test for sched_mc=
=3D0
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 =A09 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D0 & sched_smt=3D0
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 10 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D0 & sched_smt=3D1
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 11 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D0 & sched_smt=3D2
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 12 =A0TFAIL =A0: =A0sched domain test for sched_mc=
=3D1
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 13 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D1 & sched_smt=3D0
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 14 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D1 & sched_smt=3D1
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 15 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D1 & sched_smt=3D2
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 16 =A0TFAIL =A0: =A0sched domain test for sched_mc=
=3D2
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 17 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D2 & sched_smt=3D0
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 18 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D2 & sched_smt=3D1
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or direc=
tory
> Power_Management =A0 19 =A0TPASS =A0: =A0sched domain test for sched_mc=
=3D2 & sched_smt=3D2
> argument is timer_migrationPower_Management =A0 20 =A0TCONF =A0: =A0Kernel
> version does not support Timer migration

Hi Rohit,
    I reported this quite a while ago, but the maintainer at IBM
appears MIA. Seriously considering checking in my revised version
because it passes QA a lot better than this one does...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
