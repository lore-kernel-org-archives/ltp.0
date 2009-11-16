Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N9x7m-0005uL-97
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:39:50 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9x7h-0005KX-QU
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:39:50 +0000
Received: by pzk31 with SMTP id 31so3453725pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Nov 2009 00:39:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1258359233.5677.36.camel@subratamodak.linux.ibm.com>
References: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
	<OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
	<1258359233.5677.36.camel@subratamodak.linux.ibm.com>
Date: Mon, 16 Nov 2009 00:39:38 -0800
Message-ID: <364299f40911160039w70ed1f57nef1a19ea36ac4f5f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Power Management: Fix missing make targets.
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
To: subrata@linux.vnet.ibm.com
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, Poornima Nayak <Poornima.Nayak@in.ibm.com>

On Mon, Nov 16, 2009 at 12:13 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> Will you be fixing this ?
>
> Regards--
> Subrata
>
> On Mon, 2009-11-16 at 09:49 +0530, Poornima Nayak wrote:
>> Hi
>>
>> Patch to handle this issue was mailed on 20/8/2009. Garret Cooper had
>> replied that makefile-infra-rework patch will take care of this
>> requirement. If makefile-infra-rework patch is in this error should
>> not have come up or makefile-rework-patch might have some issue.
>>
>> Anyway there was reply from maintainer, the patch which I had sent
>> will be integrated till Garret Cooper's patch gets in. I am not sure
>> how this issue would have come up.
>> I feel its better to check in this patch to avoid Power Management
>> test case failures.
>>
>> Regards
>> Poornima
>>
>>
>> From:
>> sachinp@linux.vnet.ibm.com
>> To:
>> ltp-list@lists.sourceforge.net
>> Cc:
>> sachinp@linux.vnet.ibm.com
>> Date:
>> 11/12/2009 06:37 PM
>> Subject:
>> [LTP] [PATCH] Power Management: Fix
>> missing make targets.
>>
>>
>> ______________________________________________________________________
>>
>>
>>
>>
>> Make sure required binaries used by the power management tests are
>> compiled and
>> installed properly. Without the required MAKE TARGETS the test fails
>> with
>>
>> <<<test_output>>>
>> Are we really executing this ?
>> /opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch: command
>> not found
>> .....
>> Power_Management =A0 =A07 =A0TPASS =A0: =A0CPUIDLE sysfs tests passed
>> /opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values:
>> command not
>> found
>>
>> Patch is against LTP October version.
>>
>> Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
>> ---
>> diff -Naurp a/testcases/kernel/power_management/Makefile
>> b/testcases/kernel/power_management/Makefile
>> --- a/testcases/kernel/power_management/Makefile
>> 2009-11-12 13:02:57.000000000 +0530
>> +++ b/testcases/kernel/power_management/Makefile
>> 2009-11-12 13:04:03.000000000 +0530
>> @@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr
>>
>> INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0:=3D lib/*.py *.py *.sh
>>
>> -MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0:=3D
>> +MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0:=3D check_kv_arch
>> get_sched_values
>>
>> include $(top_srcdir)/include/mk/generic_leaf_target.mk

    Just fixed on HEAD by adding proper tst_kvercmp checks. This
script needs to still be seriously cleaned up though, because it's not
doing a _LOT_ of checks, like it should be, resulting in false
positives:

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/power_management $
./runpwtests.sh
Power_Management    1  TCONF  :  Not a suitable architecture for SCHED_MC t=
est
Power_Management    2  TCONF  :  Required Hyper Threading support for
SCHED_SMT test
cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission deni=
ed
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs=
_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: Permission deni=
ed
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs=
_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq: Permission deni=
ed
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs=
_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq: Permission deni=
ed
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs=
_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq
Power_Management    3  TFAIL  :  CPUFREQ sysfs tests
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- ondemand for cpu0
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- powersave for cpu0
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- userspace for cpu0
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- performance for cpu0
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- ondemand for cpu1
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- powersave for cpu1
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- userspace for cpu1
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- performance for cpu1
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- ondemand for cpu2
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- powersave for cpu2
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- userspace for cpu2
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- performance for cpu2
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- ondemand for cpu3
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- powersave for cpu3
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- userspace for cpu3
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:
FAIL: Unable to set governor -- performance for cpu3
Power_Management    4  TFAIL  :  Changing governors
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:
Permission denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:
Permission denied
Power_Management    5  TFAIL  :  Changing frequncies
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/pwkm_load_unload.sh:
line 17: modprobe: command not found
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/pwkm_load_unload.sh:
line 29: modprobe: command not found
Power_Management    6  TPASS  :  Loading and Unloading of governor
kernel modules
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpuidle_sysfs=
_files.sh:
PASS: Checking cpu idle sysfs files
Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
Power_Management    8  TFAIL  :  Timer migration interface missing

Thanks,
-Garrett

Update of /cvsroot/ltp/ltp/testcases/kernel/power_management
In directory ddv4jf1.ch3.sourceforge.com:/tmp/cvs-serv4838

Modified Files:
       Makefile runpwtests.sh
Removed Files:
       check_kv_arch.c get_sched_values.c
Log Message:
1. Remove the .c files and all calls in runpwtests.sh because we can
achieve the same thing through additional shell test logic.
2. Add the apicmds dependency.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>



--- get_sched_values.c DELETED ---

Index: runpwtests.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/power_management/runpwtests.sh,v
retrieving revision 1.16
retrieving revision 1.17
diff -C2 -d -r1.16 -r1.17
*** runpwtests.sh       29 Oct 2009 18:04:21 -0000      1.16
--- runpwtests.sh       16 Nov 2009 08:36:37 -0000      1.17
***************
*** 31,35 ****

 # Exporting Required variables
- echo Are we really executing this ?
 export TST_TOTAL=3D1
 #LTPTMP=3D${TMP}
--- 31,34 ----
***************
*** 55,63 ****

 # Checking required kernel version and architecture
! check_kv_arch
! RC=3D$?
! if [ $RC -eq 1 ] ; then
!       tst_resm TCONF "Kernel version or Architecture not supported:
Not running testcases"
       exit 0
 fi

--- 54,86 ----

 # Checking required kernel version and architecture
! tst_kvercmp 2 6 21; rc=3D$?
! if [ $rc -ne 1 -a $rc -ne 2 ] ; then
!       tst_resm TCONF "Kernel version not supported; not running testcases"
       exit 0
+ else
+       case "$(uname -m)" in
+       i[4-6]86|x86_64)
+               ;;
+       *)
+               tst_resm TCONF "Arch not supported; not running testcases"
+               exit 0
+               ;;
+       esac
+ fi
+
+ tst_kvercmp 2 6 29; rc=3D$?
+ if [ $rc -eq 2 ] ; then
+       max_sched_mc=3D2
+       max_sched_smt=3D2
+ else
+       max_sched_mc=3D1
+       max_sched_smt=3D1
+ fi
+
+ tst_kvercmp 2 6 31; rc=3D$?
+ if [ $rc -eq 1 -o $rc -eq 2 ] ; then
+       timer_migr_support_compatible=3D1
+ else
+       timer_migr_support_compatible=3D0
 fi

***************
*** 165,176 ****

 # sched_domain test
! which python > /dev/null
! if [ $? -ne 0 ] ; then
       tst_resm TCONF "Python is not installed, CPU Consoldation\
 test cannot run"
 else
       if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
!               get_sched_values sched_mc; max_sched_mc=3D$?
!       echo "max sched mc $max_sched_mc"
               for sched_mc in `seq 0 $max_sched_mc`; do
                       : $(( TST_COUNT+=3D1))
--- 188,197 ----

 # sched_domain test
! if ! type python > /dev/null ; then
       tst_resm TCONF "Python is not installed, CPU Consoldation\
 test cannot run"
 else
       if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
!               echo "max sched mc $max_sched_mc"
               for sched_mc in `seq 0 $max_sched_mc`; do
                       : $(( TST_COUNT+=3D1))
***************
*** 191,197 ****

 : $(( TST_COUNT+=3D1))
- check_kv_arch "timer_migration"; supp=3D$?
 if [ -f /proc/sys/kernel/timer_migration ]; then
!       if [ $supp -eq $YES ]; then
               if test_timer_migration.sh; then
               tst_resm TPASS "Timer Migration interface test"
--- 212,217 ----

 : $(( TST_COUNT+=3D1))
 if [ -f /proc/sys/kernel/timer_migration ]; then
!       if [ $timer_migr_support_compatible -eq $YES ]; then
               if test_timer_migration.sh; then
               tst_resm TPASS "Timer Migration interface test"
***************
*** 202,206 ****
       fi
 else
!       if [ $supp -eq $YES ]; then
               RC=3D$?
               tst_resm TFAIL "Timer migration interface missing"
--- 222,226 ----
       fi
 else
!       if [ $timer_migr_support_compatible -eq $YES ]; then
               RC=3D$?
               tst_resm TFAIL "Timer migration interface missing"

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/power_management/Makefile,v
retrieving revision 1.7
retrieving revision 1.8
diff -C2 -d -r1.7 -r1.8
*** Makefile    9 Oct 2009 17:55:49 -0000       1.7
--- Makefile    16 Nov 2009 08:36:37 -0000      1.8
***************
*** 27,31 ****
 INSTALL_TARGETS               :=3D lib/*.py *.py *.sh

! MAKE_TARGETS          :=3D

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
--- 27,31 ----
 INSTALL_TARGETS               :=3D lib/*.py *.py *.sh

! MAKE_DEPS             +=3D $(APICMDS_DIR)/tst_kvercmp

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--- check_kv_arch.c DELETED ---

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
