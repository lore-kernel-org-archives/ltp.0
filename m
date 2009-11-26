Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Poornima.Nayak@in.ibm.com>) id 1NDiHz-0003bB-Sj
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 17:37:55 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NDiHx-0006wU-8B
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 17:37:55 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAQHbhoD023478
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Nov 2009 23:07:43 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAQHbgaR2920696
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Nov 2009 23:07:42 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAQHbgsY007749
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Nov 2009 04:37:42 +1100
In-Reply-To: <364299f40911160039w70ed1f57nef1a19ea36ac4f5f@mail.gmail.com>
References: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>	<OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
	<1258359233.5677.36.camel@subratamodak.linux.ibm.com>
	<364299f40911160039w70ed1f57nef1a19ea36ac4f5f@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <OFF890576D.887755E8-ON6525767A.0060753E-6525767A.0060D54C@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Thu, 26 Nov 2009 23:09:08 +0530
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
Content-Type: multipart/mixed; boundary="===============1573277464070942628=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.
--===============1573277464070942628==
Content-Type: multipart/alternative;
	boundary="=_alternative 0060D5486525767A_="

This is a multipart message in MIME format.
--=_alternative 0060D5486525767A_=
Content-Type: text/plain; charset="US-ASCII"

Hi Garret

I will fix those false positives displayed. But I have never seen them on 
my test setups.

Regards
Poornima



Garrett Cooper <yanegomi@gmail.com> 
11/16/2009 02:09 PM

To
subrata@linux.vnet.ibm.com
cc
sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, Poornima 
Nayak/India/IBM@IBMIN
Subject
Re: [LTP] [PATCH] Power Management: Fix missing make targets.






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
>> Power_Management    7  TPASS  :  CPUIDLE sysfs tests passed
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
>> INSTALL_TARGETS                                  := lib/*.py *.py *.sh
>>
>> -MAKE_TARGETS                                  :=
>> +MAKE_TARGETS                                  := check_kv_arch
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
Power_Management    1  TCONF  :  Not a suitable architecture for SCHED_MC 
test
Power_Management    2  TCONF  :  Required Hyper Threading support for
SCHED_SMT test
cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission 
denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: Permission 
denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq: Permission 
denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:
FAIL: cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq
cat: /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq: Permission 
denied
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:
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
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpuidle_sysfs_files.sh:
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
===================================================================
RCS file: 
/cvsroot/ltp/ltp/testcases/kernel/power_management/runpwtests.sh,v
retrieving revision 1.16
retrieving revision 1.17
diff -C2 -d -r1.16 -r1.17
*** runpwtests.sh       29 Oct 2009 18:04:21 -0000      1.16
--- runpwtests.sh       16 Nov 2009 08:36:37 -0000      1.17
***************
*** 31,35 ****

 # Exporting Required variables
- echo Are we really executing this ?
 export TST_TOTAL=1
 #LTPTMP=${TMP}
--- 31,34 ----
***************
*** 55,63 ****

 # Checking required kernel version and architecture
! check_kv_arch
! RC=$?
! if [ $RC -eq 1 ] ; then
!       tst_resm TCONF "Kernel version or Architecture not supported:
Not running testcases"
       exit 0
 fi

--- 54,86 ----

 # Checking required kernel version and architecture
! tst_kvercmp 2 6 21; rc=$?
! if [ $rc -ne 1 -a $rc -ne 2 ] ; then
!       tst_resm TCONF "Kernel version not supported; not running 
testcases"
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
+ tst_kvercmp 2 6 29; rc=$?
+ if [ $rc -eq 2 ] ; then
+       max_sched_mc=2
+       max_sched_smt=2
+ else
+       max_sched_mc=1
+       max_sched_smt=1
+ fi
+
+ tst_kvercmp 2 6 31; rc=$?
+ if [ $rc -eq 1 -o $rc -eq 2 ] ; then
+       timer_migr_support_compatible=1
+ else
+       timer_migr_support_compatible=0
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
!               get_sched_values sched_mc; max_sched_mc=$?
!       echo "max sched mc $max_sched_mc"
               for sched_mc in `seq 0 $max_sched_mc`; do
                       : $(( TST_COUNT+=1))
--- 188,197 ----

 # sched_domain test
! if ! type python > /dev/null ; then
       tst_resm TCONF "Python is not installed, CPU Consoldation\
 test cannot run"
 else
       if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
!               echo "max sched mc $max_sched_mc"
               for sched_mc in `seq 0 $max_sched_mc`; do
                       : $(( TST_COUNT+=1))
***************
*** 191,197 ****

 : $(( TST_COUNT+=1))
- check_kv_arch "timer_migration"; supp=$?
 if [ -f /proc/sys/kernel/timer_migration ]; then
!       if [ $supp -eq $YES ]; then
               if test_timer_migration.sh; then
               tst_resm TPASS "Timer Migration interface test"
--- 212,217 ----

 : $(( TST_COUNT+=1))
 if [ -f /proc/sys/kernel/timer_migration ]; then
!       if [ $timer_migr_support_compatible -eq $YES ]; then
               if test_timer_migration.sh; then
               tst_resm TPASS "Timer Migration interface test"
***************
*** 202,206 ****
       fi
 else
!       if [ $supp -eq $YES ]; then
               RC=$?
               tst_resm TFAIL "Timer migration interface missing"
--- 222,226 ----
       fi
 else
!       if [ $timer_migr_support_compatible -eq $YES ]; then
               RC=$?
               tst_resm TFAIL "Timer migration interface missing"

Index: Makefile
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/power_management/Makefile,v
retrieving revision 1.7
retrieving revision 1.8
diff -C2 -d -r1.7 -r1.8
*** Makefile    9 Oct 2009 17:55:49 -0000       1.7
--- Makefile    16 Nov 2009 08:36:37 -0000      1.8
***************
*** 27,31 ****
 INSTALL_TARGETS               := lib/*.py *.py *.sh

! MAKE_TARGETS          :=

 include $(top_srcdir)/include/mk/generic_leaf_target.mk
--- 27,31 ----
 INSTALL_TARGETS               := lib/*.py *.py *.sh

! MAKE_DEPS             += $(APICMDS_DIR)/tst_kvercmp

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--- check_kv_arch.c DELETED ---

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 
30-Day 
trial. Simplify your report design, integration and deployment - and focus 
on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list


--=_alternative 0060D5486525767A_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi Garret</font>
<br>
<br><font size=2 face="sans-serif">I will fix those false positives displayed.
But I have never seen them on my test setups.</font>
<br>
<br><font size=2 face="sans-serif">Regards</font>
<br><font size=2 face="sans-serif">Poornima</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Garrett Cooper &lt;yanegomi@gmail.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">11/16/2009 02:09 PM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">subrata@linux.vnet.ibm.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net,
Poornima Nayak/India/IBM@IBMIN</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [LTP] [PATCH] Power Management:
Fix missing make targets.</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Mon, Nov 16, 2009 at 12:13 AM, Subrata Modak<br>
&lt;subrata@linux.vnet.ibm.com&gt; wrote:<br>
&gt; Garret,<br>
&gt;<br>
&gt; Will you be fixing this ?<br>
&gt;<br>
&gt; Regards--<br>
&gt; Subrata<br>
&gt;<br>
&gt; On Mon, 2009-11-16 at 09:49 +0530, Poornima Nayak wrote:<br>
&gt;&gt; Hi<br>
&gt;&gt;<br>
&gt;&gt; Patch to handle this issue was mailed on 20/8/2009. Garret Cooper
had<br>
&gt;&gt; replied that makefile-infra-rework patch will take care of this<br>
&gt;&gt; requirement. If makefile-infra-rework patch is in this error should<br>
&gt;&gt; not have come up or makefile-rework-patch might have some issue.<br>
&gt;&gt;<br>
&gt;&gt; Anyway there was reply from maintainer, the patch which I had
sent<br>
&gt;&gt; will be integrated till Garret Cooper's patch gets in. I am not
sure<br>
&gt;&gt; how this issue would have come up.<br>
&gt;&gt; I feel its better to check in this patch to avoid Power Management<br>
&gt;&gt; test case failures.<br>
&gt;&gt;<br>
&gt;&gt; Regards<br>
&gt;&gt; Poornima<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; From:<br>
&gt;&gt; sachinp@linux.vnet.ibm.com<br>
&gt;&gt; To:<br>
&gt;&gt; ltp-list@lists.sourceforge.net<br>
&gt;&gt; Cc:<br>
&gt;&gt; sachinp@linux.vnet.ibm.com<br>
&gt;&gt; Date:<br>
&gt;&gt; 11/12/2009 06:37 PM<br>
&gt;&gt; Subject:<br>
&gt;&gt; [LTP] [PATCH] Power Management: Fix<br>
&gt;&gt; missing make targets.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ______________________________________________________________________<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Make sure required binaries used by the power management tests
are<br>
&gt;&gt; compiled and<br>
&gt;&gt; installed properly. Without the required MAKE TARGETS the test
fails<br>
&gt;&gt; with<br>
&gt;&gt;<br>
&gt;&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt;&gt; Are we really executing this ?<br>
&gt;&gt; /opt/ltp/testcases/bin/runpwtests.sh: line 57: check_kv_arch:
command<br>
&gt;&gt; not found<br>
&gt;&gt; .....<br>
&gt;&gt; Power_Management &nbsp; &nbsp;7 &nbsp;TPASS &nbsp;: &nbsp;CPUIDLE
sysfs tests passed<br>
&gt;&gt; /opt/ltp/testcases/bin/runpwtests.sh: line 173: get_sched_values:<br>
&gt;&gt; command not<br>
&gt;&gt; found<br>
&gt;&gt;<br>
&gt;&gt; Patch is against LTP October version.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Sachin Sant &lt;sachinp@in.ibm.com&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; diff -Naurp a/testcases/kernel/power_management/Makefile<br>
&gt;&gt; b/testcases/kernel/power_management/Makefile<br>
&gt;&gt; --- a/testcases/kernel/power_management/Makefile<br>
&gt;&gt; 2009-11-12 13:02:57.000000000 +0530<br>
&gt;&gt; +++ b/testcases/kernel/power_management/Makefile<br>
&gt;&gt; 2009-11-12 13:04:03.000000000 +0530<br>
&gt;&gt; @@ -26,6 +26,6 @@ $(eval $(call generate_vpath_rule,c,$(sr<br>
&gt;&gt;<br>
&gt;&gt; INSTALL_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:=
lib/*.py *.py *.sh<br>
&gt;&gt;<br>
&gt;&gt; -MAKE_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:=<br>
&gt;&gt; +MAKE_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:=
check_kv_arch<br>
&gt;&gt; get_sched_values<br>
&gt;&gt;<br>
&gt;&gt; include $(top_srcdir)/include/mk/generic_leaf_target.mk<br>
<br>
 &nbsp; &nbsp;Just fixed on HEAD by adding proper tst_kvercmp checks. This<br>
script needs to still be seriously cleaned up though, because it's not<br>
doing a _LOT_ of checks, like it should be, resulting in false<br>
positives:<br>
<br>
gcooper@orangebox<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management $<br>
./runpwtests.sh<br>
Power_Management &nbsp; &nbsp;1 &nbsp;TCONF &nbsp;: &nbsp;Not a suitable
architecture for SCHED_MC test<br>
Power_Management &nbsp; &nbsp;2 &nbsp;TCONF &nbsp;: &nbsp;Required Hyper
Threading support for<br>
SCHED_SMT test<br>
cat: /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq: Permission
denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:<br>
FAIL: cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq<br>
cat: /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq: Permission
denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:<br>
FAIL: cat /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_cur_freq<br>
cat: /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq: Permission
denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:<br>
FAIL: cat /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_cur_freq<br>
cat: /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq: Permission
denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpufreq_sysfs_files.sh:<br>
FAIL: cat /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_cur_freq<br>
Power_Management &nbsp; &nbsp;3 &nbsp;TFAIL &nbsp;: &nbsp;CPUFREQ sysfs
tests<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- ondemand for cpu0<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- powersave for cpu0<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- userspace for cpu0<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- performance for cpu0<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- ondemand for cpu1<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- powersave for cpu1<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- userspace for cpu1<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- performance for cpu1<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- ondemand for cpu2<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- powersave for cpu2<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- userspace for cpu2<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- performance for cpu2<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- ondemand for cpu3<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- powersave for cpu3<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- userspace for cpu3<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_govr.sh:<br>
FAIL: Unable to set governor -- performance for cpu3<br>
Power_Management &nbsp; &nbsp;4 &nbsp;TFAIL &nbsp;: &nbsp;Changing governors<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:<br>
line 14: /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:<br>
line 14: /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:<br>
line 14: /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor:<br>
Permission denied<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/change_freq.sh:<br>
line 14: /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor:<br>
Permission denied<br>
Power_Management &nbsp; &nbsp;5 &nbsp;TFAIL &nbsp;: &nbsp;Changing frequncies<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/pwkm_load_unload.sh:<br>
line 17: modprobe: command not found<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/pwkm_load_unload.sh:<br>
line 29: modprobe: command not found<br>
Power_Management &nbsp; &nbsp;6 &nbsp;TPASS &nbsp;: &nbsp;Loading and Unloading
of governor<br>
kernel modules<br>
/scratch/ltp-dev2/ltp/testcases/kernel/power_management/check_cpuidle_sysfs_files.sh:<br>
PASS: Checking cpu idle sysfs files<br>
Power_Management &nbsp; &nbsp;7 &nbsp;TPASS &nbsp;: &nbsp;CPUIDLE sysfs
tests passed<br>
Power_Management &nbsp; &nbsp;8 &nbsp;TFAIL &nbsp;: &nbsp;Timer migration
interface missing<br>
<br>
Thanks,<br>
-Garrett<br>
<br>
Update of /cvsroot/ltp/ltp/testcases/kernel/power_management<br>
In directory ddv4jf1.ch3.sourceforge.com:/tmp/cvs-serv4838<br>
<br>
Modified Files:<br>
 &nbsp; &nbsp; &nbsp; Makefile runpwtests.sh<br>
Removed Files:<br>
 &nbsp; &nbsp; &nbsp; check_kv_arch.c get_sched_values.c<br>
Log Message:<br>
1. Remove the .c files and all calls in runpwtests.sh because we can<br>
achieve the same thing through additional shell test logic.<br>
2. Add the apicmds dependency.<br>
<br>
Signed-off-by: Garrett Cooper &lt;yanegomi@gmail.com&gt;<br>
<br>
<br>
<br>
--- get_sched_values.c DELETED ---<br>
<br>
Index: runpwtests.sh<br>
===================================================================<br>
RCS file: /cvsroot/ltp/ltp/testcases/kernel/power_management/runpwtests.sh,v<br>
retrieving revision 1.16<br>
retrieving revision 1.17<br>
diff -C2 -d -r1.16 -r1.17<br>
*** runpwtests.sh &nbsp; &nbsp; &nbsp; 29 Oct 2009 18:04:21 -0000 &nbsp;
&nbsp; &nbsp;1.16<br>
--- runpwtests.sh &nbsp; &nbsp; &nbsp; 16 Nov 2009 08:36:37 -0000 &nbsp;
&nbsp; &nbsp;1.17<br>
***************<br>
*** 31,35 ****<br>
<br>
 # Exporting Required variables<br>
- echo Are we really executing this ?<br>
 export TST_TOTAL=1<br>
 #LTPTMP=${TMP}<br>
--- 31,34 ----<br>
***************<br>
*** 55,63 ****<br>
<br>
 # Checking required kernel version and architecture<br>
! check_kv_arch<br>
! RC=$?<br>
! if [ $RC -eq 1 ] ; then<br>
! &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Kernel version or Architecture
not supported:<br>
Not running testcases&quot;<br>
 &nbsp; &nbsp; &nbsp; exit 0<br>
 fi<br>
<br>
--- 54,86 ----<br>
<br>
 # Checking required kernel version and architecture<br>
! tst_kvercmp 2 6 21; rc=$?<br>
! if [ $rc -ne 1 -a $rc -ne 2 ] ; then<br>
! &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Kernel version not supported;
not running testcases&quot;<br>
 &nbsp; &nbsp; &nbsp; exit 0<br>
+ else<br>
+ &nbsp; &nbsp; &nbsp; case &quot;$(uname -m)&quot; in<br>
+ &nbsp; &nbsp; &nbsp; i[4-6]86|x86_64)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;;<br>
+ &nbsp; &nbsp; &nbsp; *)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Arch
not supported; not running testcases&quot;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; exit 0<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ;;<br>
+ &nbsp; &nbsp; &nbsp; esac<br>
+ fi<br>
+<br>
+ tst_kvercmp 2 6 29; rc=$?<br>
+ if [ $rc -eq 2 ] ; then<br>
+ &nbsp; &nbsp; &nbsp; max_sched_mc=2<br>
+ &nbsp; &nbsp; &nbsp; max_sched_smt=2<br>
+ else<br>
+ &nbsp; &nbsp; &nbsp; max_sched_mc=1<br>
+ &nbsp; &nbsp; &nbsp; max_sched_smt=1<br>
+ fi<br>
+<br>
+ tst_kvercmp 2 6 31; rc=$?<br>
+ if [ $rc -eq 1 -o $rc -eq 2 ] ; then<br>
+ &nbsp; &nbsp; &nbsp; timer_migr_support_compatible=1<br>
+ else<br>
+ &nbsp; &nbsp; &nbsp; timer_migr_support_compatible=0<br>
 fi<br>
<br>
***************<br>
*** 165,176 ****<br>
<br>
 # sched_domain test<br>
! which python &gt; /dev/null<br>
! if [ $? -ne 0 ] ; then<br>
 &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Python is not installed, CPU
Consoldation\<br>
 test cannot run&quot;<br>
 else<br>
 &nbsp; &nbsp; &nbsp; if [ -f /sys/devices/system/cpu/sched_mc_power_savings
] ; then<br>
! &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; get_sched_values sched_mc;
max_sched_mc=$?<br>
! &nbsp; &nbsp; &nbsp; echo &quot;max sched mc $max_sched_mc&quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for sched_mc in `seq
0 $max_sched_mc`; do<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; : $(( TST_COUNT+=1))<br>
--- 188,197 ----<br>
<br>
 # sched_domain test<br>
! if ! type python &gt; /dev/null ; then<br>
 &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Python is not installed, CPU
Consoldation\<br>
 test cannot run&quot;<br>
 else<br>
 &nbsp; &nbsp; &nbsp; if [ -f /sys/devices/system/cpu/sched_mc_power_savings
] ; then<br>
! &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; echo &quot;max sched
mc $max_sched_mc&quot;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; for sched_mc in `seq
0 $max_sched_mc`; do<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; : $(( TST_COUNT+=1))<br>
***************<br>
*** 191,197 ****<br>
<br>
 : $(( TST_COUNT+=1))<br>
- check_kv_arch &quot;timer_migration&quot;; supp=$?<br>
 if [ -f /proc/sys/kernel/timer_migration ]; then<br>
! &nbsp; &nbsp; &nbsp; if [ $supp -eq $YES ]; then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if test_timer_migration.sh;
then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TPASS &quot;Timer
Migration interface test&quot;<br>
--- 212,217 ----<br>
<br>
 : $(( TST_COUNT+=1))<br>
 if [ -f /proc/sys/kernel/timer_migration ]; then<br>
! &nbsp; &nbsp; &nbsp; if [ $timer_migr_support_compatible -eq $YES ];
then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if test_timer_migration.sh;
then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TPASS &quot;Timer
Migration interface test&quot;<br>
***************<br>
*** 202,206 ****<br>
 &nbsp; &nbsp; &nbsp; fi<br>
 else<br>
! &nbsp; &nbsp; &nbsp; if [ $supp -eq $YES ]; then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RC=$?<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TFAIL &quot;Timer
migration interface missing&quot;<br>
--- 222,226 ----<br>
 &nbsp; &nbsp; &nbsp; fi<br>
 else<br>
! &nbsp; &nbsp; &nbsp; if [ $timer_migr_support_compatible -eq $YES ];
then<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; RC=$?<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TFAIL &quot;Timer
migration interface missing&quot;<br>
<br>
Index: Makefile<br>
===================================================================<br>
RCS file: /cvsroot/ltp/ltp/testcases/kernel/power_management/Makefile,v<br>
retrieving revision 1.7<br>
retrieving revision 1.8<br>
diff -C2 -d -r1.7 -r1.8<br>
*** Makefile &nbsp; &nbsp;9 Oct 2009 17:55:49 -0000 &nbsp; &nbsp; &nbsp;
1.7<br>
--- Makefile &nbsp; &nbsp;16 Nov 2009 08:36:37 -0000 &nbsp; &nbsp; &nbsp;1.8<br>
***************<br>
*** 27,31 ****<br>
 INSTALL_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; := lib/*.py
*.py *.sh<br>
<br>
! MAKE_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;:=<br>
<br>
 include $(top_srcdir)/include/mk/generic_leaf_target.mk<br>
--- 27,31 ----<br>
 INSTALL_TARGETS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; := lib/*.py
*.py *.sh<br>
<br>
! MAKE_DEPS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; += $(APICMDS_DIR)/tst_kvercmp<br>
<br>
 include $(top_srcdir)/include/mk/generic_leaf_target.mk<br>
<br>
--- check_kv_arch.c DELETED ---<br>
<br>
------------------------------------------------------------------------------<br>
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day
<br>
trial. Simplify your report design, integration and deployment - and focus
on <br>
what you do best, core application coding. Discover what's new with<br>
Crystal Reports now. &nbsp;</font></tt><a href="http://p.sf.net/sfu/bobj-july"><tt><font size=2>http://p.sf.net/sfu/bobj-july</font></tt></a><tt><font size=2><br>
_______________________________________________<br>
Ltp-list mailing list<br>
Ltp-list@lists.sourceforge.net<br>
</font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0060D5486525767A_=--


--===============1573277464070942628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1573277464070942628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1573277464070942628==--

