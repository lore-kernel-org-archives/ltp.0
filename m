Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Poornima.Nayak@in.ibm.com>) id 1NT97w-00037V-2o
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 07:19:20 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT97s-0007Kq-D8
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 07:19:19 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp09.in.ibm.com (8.14.3/8.13.1) with ESMTP id o086oAuw009550
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Jan 2010 12:20:10 +0530
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o087J3KL2502772
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Jan 2010 12:49:04 +0530
Received: from d28av06.in.ibm.com (loopback [127.0.0.1])
	by d28av06.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o087J3Ov016449
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Jan 2010 12:49:03 +0530
In-Reply-To: <53627539-D088-46F6-886F-E4C075C96724@gmail.com>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
	<53627539-D088-46F6-886F-E4C075C96724@gmail.com>
MIME-Version: 1.0
Message-ID: <OF10C19432.74C74A46-ON652576A5.002795D2-652576A5.00283151@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Fri, 8 Jan 2010 12:50:28 +0530
Subject: Re: [LTP] [Patch 1/4]Master script modified to enable testcases
 to	run on Power
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3483148081388789722=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "arun@linux.vnet.ibm.com" <arun@linux.vnet.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com

This is a multipart message in MIME format.
--===============3483148081388789722==
Content-Type: multipart/alternative;
	boundary="=_alternative 0028314D652576A5_="

This is a multipart message in MIME format.
--=_alternative 0028314D652576A5_=
Content-Type: text/plain; charset="US-ASCII"

Garrett Cooper <yanegomi@gmail.com> 
12/25/2009 01:51 AM

To
Poornima Nayak <mpnayak@linux.vnet.ibm.com>
cc
"ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, 
"arun@linux.vnet.ibm.com" <arun@linux.vnet.ibm.com>, 
"svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, 
ego@linux.vnet.ibm.com
Subject
Re: [LTP] [Patch 1/4]Master script modified to enable testcases to run on 
Power






On Dec 24, 2009, at 10:15 AM, Poornima Nayak 
<mpnayak@linux.vnet.ibm.com> wrote:

> Patch to enable Power management testcases in LTP to run on Power 
> platform
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/ 
> power_management/runpwtests.sh ltp-intermediate-20091209.fixes/ 
> testcases/kernel/power_management/runpwtests.sh
> --- ltp-intermediate-20091209.orig/testcases/kernel/power_management/ 
> runpwtests.sh    2009-12-09 13:18:25.000000000 +0530
> +++ ltp-intermediate-20091209.fixes/testcases/kernel/ 
> power_management/runpwtests.sh    2009-12-24 23:16:39.859044825 +0530
> @@ -28,10 +28,21 @@
> # History:      26 Aug 2008 - Created this file
> # 03 Nov 2008 - Added CPUIDLE sysfs testcase
> #
> +# Function:     main
> +#
> +# Description:  - Execute all tests, exit with test status.
> +#
> +# Exit:         - zero on success
> +#               - non-zero on failure.
> +#
> +
> +#List of reusable functions defined in pm_include.sh
> +. ./pm_include.sh
> +
> +RC=0            #Return status
>
> # Exporting Required variables
> export TST_TOTAL=1
> -#LTPTMP=${TMP}
> export PATH=${PATH}:.
> export TCID="Power_Management"
> export TST_COUNT=0
> @@ -40,48 +51,39 @@ export analysis="/proctstat"
>
> YES=0
> NO=1
> -#List of reusable functions defined in pm_include.sh
> -. ./pm_include.sh
> -
> -# Function:     main
> -#
> -# Description:  - Execute all tests, exit with test status.
> -#
> -# Exit:         - zero on success
> -#               - non-zero on failure.
> -#
> -RC=0        #Return status
>
> # Checking required kernel version and architecture
> tst_kvercmp 2 6 21; rc=$?
> if [ $rc -ne 1 -a $rc -ne 2 ] ; then
> -    tst_resm TCONF "Kernel version not supported; not running 
> testcases"
> -    exit 0
> +        tst_resm TCONF "Kernel version not supported; not running 
> testcases"
> +        exit 0
> else
> -    case "$(uname -m)" in
> -    i[4-6]86|x86_64)
> +        case "$(uname -m)" in
> +        i[4-6]86|x86_64)
> +                ;;
> +        powerpc|ppc|powerpc64|ppc64)
>        ;;
> -    *)
> -        tst_resm TCONF "Arch not supported; not running testcases"
> -        exit 0
> -        ;;
> -    esac
> +        *)
> +                tst_resm TCONF "Arch not supported; not running 
> testcases"
> +                exit 0
> +                ;;
> +        esac
> fi
>
> tst_kvercmp 2 6 29; rc=$?
> if [ $rc -eq 2 ] ; then
> -    max_sched_mc=2
> -    max_sched_smt=2
> +        max_sched_mc=2
> +        max_sched_smt=2
> else
> -    max_sched_mc=1
> -    max_sched_smt=1
> +        max_sched_mc=1
> +        max_sched_smt=1
> fi
>
> tst_kvercmp 2 6 31; rc=$?
> if [ $rc -eq 1 -o $rc -eq 2 ] ; then
> -    timer_migr_support_compatible=1
> +        timer_migr_support_compatible=0
> else
> -    timer_migr_support_compatible=0
> +        timer_migr_support_compatible=1
> fi

Why did you invert the logic here? $? => 0 says the kernel version is 
less, 1 that it's equal, and 2 that it's greater than the version 
specified.
If Kernel version is less then that particular kernel is not suitable for 
Timer Migration test.
Only if kernel version is 2.6.31 and above then Timer migration test has 
to be executed. In the script YES=0, NO=1

> is_hyper_threaded; hyper_threaded=$?
> @@ -90,7 +92,6 @@ is_multi_core; multi_core=$?
> is_dual_core; dual_core=$?
>
> #Checking sched_mc sysfs interface
> -#check_config.sh config_sched_mc || RC=$?
> TST_COUNT=1
> if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
>    if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> @@ -103,6 +104,25 @@ if [ $multi_socket -eq $YES -a $multi_co
>    else
>         tst_resm TCONF "Required kernel configuration for SCHED_MC 
> NOT set"
>    fi
> +
> +    : $(( TST_COUNT+=1))
> +    if [ -f /proc/sys/kernel/timer_migration ]; then
> +        if [ $timer_migr_support_compatible -eq $YES ]; then
> +            if test_timer_migration.sh; then
> +                tst_resm TPASS "Timer Migration interface test"
> +            else
> +                RC=$?
> +                tst_resm TFAIL "Timer migration interface test"
> +            fi
> +        fi
> +    else
> +        if [ $supp -eq $YES ]; then
> +            RC=$?
> +            tst_resm TFAIL "Timer migration interface missing"
> +        else
> +            tst_resm TCONF "Kernel version does not support Timer 
> migration"
> +        fi
> +    fi
> else
>    if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
>        tst_resm TFAIL "sched_mc_power_savings interface in system 
> which is not a multi socket &(/) multi core"
> @@ -135,7 +155,6 @@ else
> fi
>
> # Checking cpufreq sysfs interface files
> -#check_config.sh config_cpu_freq || RC=$?
> : $(( TST_COUNT += 1 ))
> if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
>     if check_cpufreq_sysfs_files.sh; then
> @@ -187,12 +206,13 @@ else
> fi
>
> # sched_domain test
> -if ! type python > /dev/null ; then
> +which python > /dev/null
> +if [ $? -ne 0 ] ; then

type is a bourne shell builtin whereas which is a command. 
Furthermore, you  can inline shell true / false checks in branch 
conditionals. So why did you revert this?

Will modify the patch accordingly.
>    tst_resm TCONF "Python is not installed, CPU Consoldation\
> test cannot run"
> else
>    if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> -            echo "max sched mc $max_sched_mc"
> +        get_sched_values sched_mc; max_sched_mc=$?
>        for sched_mc in `seq 0 $max_sched_mc`; do
>            : $(( TST_COUNT+=1))
>            sched_domain.py -c $sched_mc; RC=$?
> @@ -210,25 +230,6 @@ else
>    fi
> fi
>
> -: $(( TST_COUNT+=1))
> -if [ -f /proc/sys/kernel/timer_migration ]; then
> -    if [ $timer_migr_support_compatible -eq $YES ]; then
> -        if test_timer_migration.sh; then
> -            tst_resm TPASS "Timer Migration interface test"
> -        else
> -            RC=$?
> -            tst_resm TFAIL "Timer migration interface test"
> -        fi
> -    fi
> -else
> -    if [ $timer_migr_support_compatible -eq $YES ]; then
> -        RC=$?
> -        tst_resm TFAIL "Timer migration interface missing"
> -    else
> -        tst_resm TCONF "Kernel version does not support Timer 
> migration"
> -    fi
> -fi
> -
> if [ $# -gt 0 -a "$1" = "-exclusive" ]; then

Sorry for not noticing this sooner. $1 and -exclusive should be 
prefixed by a character, e.g. x or this will be reported as a [(1) 
syntax error.
Based on your comments I am doing it, as such I have not observed syntax 
error while executing these testcases
>
>    # Test CPU consolidation
>    if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
> @@ -266,7 +267,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ];
>
>    fi
>
> -    if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES -a 
> $multi_core -eq $NO ]; then
> +    if [ $hyper_threaded -eq $YES ]; then
>            #Testcase to validate consolidation at core level
>            for sched_smt in `seq 0 $max_sched_smt`; do
>                if [ $sched_smt -eq 2 ]; then
> @@ -319,7 +320,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ];
>    fi
>
>     # Verify threads consolidation stops when sched_smt is disabled 
> in HT systems
> -    if [ $hyper_threaded -eq $YES -a $multi_socket -eq $YES ]; then
> +    if [ $hyper_threaded -eq $YES ]; then
>        # Vary only sched_smt from 1 to 0 when workload is running 
> and ensure that
>        # tasks do not consolidate to single core when sched_smt is 
> set to 0
>        : $(( TST_COUNT += 1 ))

Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and 
easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list


--=_alternative 0028314D652576A5_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br>
<table width=100%>
<tr valign=top>
<td width=40%><font size=1 face="sans-serif"><b>Garrett Cooper &lt;yanegomi@gmail.com&gt;</b>
</font>
<p><font size=1 face="sans-serif">12/25/2009 01:51 AM</font>
<td width=59%>
<table width=100%>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">To</font></div>
<td><font size=1 face="sans-serif">Poornima Nayak &lt;mpnayak@linux.vnet.ibm.com&gt;</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">cc</font></div>
<td><font size=1 face="sans-serif">&quot;ltp-list@lists.sourceforge.net&quot;
&lt;ltp-list@lists.sourceforge.net&gt;, &quot;arun@linux.vnet.ibm.com&quot;
&lt;arun@linux.vnet.ibm.com&gt;, &quot;svaidy@linux.vnet.ibm.com&quot;
&lt;svaidy@linux.vnet.ibm.com&gt;, ego@linux.vnet.ibm.com</font>
<tr valign=top>
<td>
<div align=right><font size=1 face="sans-serif">Subject</font></div>
<td><font size=1 face="sans-serif">Re: [LTP] [Patch 1/4]Master script modified
to enable testcases to &nbsp; &nbsp; &nbsp; &nbsp;run on Power</font></table>
<br>
<table>
<tr valign=top>
<td>
<td></table>
<br></table>
<br>
<br>
<br><tt><font size=2>On Dec 24, 2009, at 10:15 AM, Poornima Nayak &nbsp;<br>
&lt;mpnayak@linux.vnet.ibm.com&gt; wrote:<br>
<br>
&gt; Patch to enable Power management testcases in LTP to run on Power
&nbsp;<br>
&gt; platform<br>
&gt;<br>
&gt; Signed-off-by: poornima nayak &lt;mpnayak@linux.vnet.ibm.com&gt;<br>
&gt;<br>
&gt; diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/ <br>
&gt; power_management/runpwtests.sh ltp-intermediate-20091209.fixes/ <br>
&gt; testcases/kernel/power_management/runpwtests.sh<br>
&gt; --- ltp-intermediate-20091209.orig/testcases/kernel/power_management/
<br>
&gt; runpwtests.sh &nbsp; &nbsp;2009-12-09 13:18:25.000000000 +0530<br>
&gt; +++ ltp-intermediate-20091209.fixes/testcases/kernel/ <br>
&gt; power_management/runpwtests.sh &nbsp; &nbsp;2009-12-24 23:16:39.859044825
+0530<br>
&gt; @@ -28,10 +28,21 @@<br>
&gt; # History: &nbsp; &nbsp; &nbsp;26 Aug 2008 - Created this file<br>
&gt; # 03 Nov 2008 - Added CPUIDLE sysfs testcase<br>
&gt; #<br>
&gt; +# Function: &nbsp; &nbsp; main<br>
&gt; +#<br>
&gt; +# Description: &nbsp;- Execute all tests, exit with test status.<br>
&gt; +#<br>
&gt; +# Exit: &nbsp; &nbsp; &nbsp; &nbsp; - zero on success<br>
&gt; +# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non-zero on
failure.<br>
&gt; +#<br>
&gt; +<br>
&gt; +#List of reusable functions defined in pm_include.sh<br>
&gt; +. ./pm_include.sh<br>
&gt; +<br>
&gt; +RC=0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#Return status<br>
&gt;<br>
&gt; # Exporting Required variables<br>
&gt; export TST_TOTAL=1<br>
&gt; -#LTPTMP=${TMP}<br>
&gt; export PATH=${PATH}:.<br>
&gt; export TCID=&quot;Power_Management&quot;<br>
&gt; export TST_COUNT=0<br>
&gt; @@ -40,48 +51,39 @@ export analysis=&quot;/proctstat&quot;<br>
&gt;<br>
&gt; YES=0<br>
&gt; NO=1<br>
&gt; -#List of reusable functions defined in pm_include.sh<br>
&gt; -. ./pm_include.sh<br>
&gt; -<br>
&gt; -# Function: &nbsp; &nbsp; main<br>
&gt; -#<br>
&gt; -# Description: &nbsp;- Execute all tests, exit with test status.<br>
&gt; -#<br>
&gt; -# Exit: &nbsp; &nbsp; &nbsp; &nbsp; - zero on success<br>
&gt; -# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non-zero on
failure.<br>
&gt; -#<br>
&gt; -RC=0 &nbsp; &nbsp; &nbsp; &nbsp;#Return status<br>
&gt;<br>
&gt; # Checking required kernel version and architecture<br>
&gt; tst_kvercmp 2 6 21; rc=$?<br>
&gt; if [ $rc -ne 1 -a $rc -ne 2 ] ; then<br>
&gt; - &nbsp; &nbsp;tst_resm TCONF &quot;Kernel version not supported;
not running &nbsp;<br>
&gt; testcases&quot;<br>
&gt; - &nbsp; &nbsp;exit 0<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TCONF &quot;Kernel version not
supported; not running &nbsp;<br>
&gt; testcases&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;exit 0<br>
&gt; else<br>
&gt; - &nbsp; &nbsp;case &quot;$(uname -m)&quot; in<br>
&gt; - &nbsp; &nbsp;i[4-6]86|x86_64)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;case &quot;$(uname -m)&quot; in<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;i[4-6]86|x86_64)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;powerpc|ppc|powerpc64|ppc64)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;;;<br>
&gt; - &nbsp; &nbsp;*)<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TCONF &quot;Arch not supported;
not running testcases&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;exit 0<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;;;<br>
&gt; - &nbsp; &nbsp;esac<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;*)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm
TCONF &quot;Arch not supported; not running &nbsp;<br>
&gt; testcases&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;exit 0<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;;;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;esac<br>
&gt; fi<br>
&gt;<br>
&gt; tst_kvercmp 2 6 29; rc=$?<br>
&gt; if [ $rc -eq 2 ] ; then<br>
&gt; - &nbsp; &nbsp;max_sched_mc=2<br>
&gt; - &nbsp; &nbsp;max_sched_smt=2<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_sched_mc=2<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_sched_smt=2<br>
&gt; else<br>
&gt; - &nbsp; &nbsp;max_sched_mc=1<br>
&gt; - &nbsp; &nbsp;max_sched_smt=1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_sched_mc=1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;max_sched_smt=1<br>
&gt; fi<br>
&gt;<br>
&gt; tst_kvercmp 2 6 31; rc=$?<br>
&gt; if [ $rc -eq 1 -o $rc -eq 2 ] ; then<br>
&gt; - &nbsp; &nbsp;timer_migr_support_compatible=1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;timer_migr_support_compatible=0<br>
&gt; else<br>
&gt; - &nbsp; &nbsp;timer_migr_support_compatible=0<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;timer_migr_support_compatible=1<br>
&gt; fi<br>
<br>
Why did you invert the logic here? $? =&gt; 0 says the kernel version is
&nbsp;<br>
less, 1 that it's equal, and 2 that it's greater than the version &nbsp;<br>
specified.<br>
If Kernel version is less then that particular kernel is not suitable for
Timer Migration test.</font></tt>
<br><tt><font size=2>Only if kernel version is 2.6.31 and above then Timer
migration test has to be executed. In the script YES=0, NO=1</font></tt>
<br><tt><font size=2><br>
&gt; is_hyper_threaded; hyper_threaded=$?<br>
&gt; @@ -90,7 +92,6 @@ is_multi_core; multi_core=$?<br>
&gt; is_dual_core; dual_core=$?<br>
&gt;<br>
&gt; #Checking sched_mc sysfs interface<br>
&gt; -#check_config.sh config_sched_mc || RC=$?<br>
&gt; TST_COUNT=1<br>
&gt; if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then<br>
&gt; &nbsp; &nbsp;if [ -f /sys/devices/system/cpu/sched_mc_power_savings
] ; then<br>
&gt; @@ -103,6 +104,25 @@ if [ $multi_socket -eq $YES -a $multi_co<br>
&gt; &nbsp; &nbsp;else<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TCONF &quot;Required kernel configuration
for SCHED_MC &nbsp;<br>
&gt; NOT set&quot;<br>
&gt; &nbsp; &nbsp;fi<br>
&gt; +<br>
&gt; + &nbsp; &nbsp;: $(( TST_COUNT+=1))<br>
&gt; + &nbsp; &nbsp;if [ -f /proc/sys/kernel/timer_migration ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if [ $timer_migr_support_compatible -eq
$YES ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if test_timer_migration.sh;
then<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm
TPASS &quot;Timer Migration interface test&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;RC=$?<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm
TFAIL &quot;Timer migration interface test&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; + &nbsp; &nbsp;else<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;if [ $supp -eq $YES ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;RC=$?<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;Timer
migration interface missing&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;else<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TCONF &quot;Kernel
version does not support Timer &nbsp;<br>
&gt; migration&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; + &nbsp; &nbsp;fi<br>
&gt; else<br>
&gt; &nbsp; &nbsp;if [ -f /sys/devices/system/cpu/sched_mc_power_savings
] ; then<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;sched_mc_power_savings
interface in system &nbsp;<br>
&gt; which is not a multi socket &amp;(/) multi core&quot;<br>
&gt; @@ -135,7 +155,6 @@ else<br>
&gt; fi<br>
&gt;<br>
&gt; # Checking cpufreq sysfs interface files<br>
&gt; -#check_config.sh config_cpu_freq || RC=$?<br>
&gt; : $(( TST_COUNT += 1 ))<br>
&gt; if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then<br>
&gt; &nbsp; &nbsp; if check_cpufreq_sysfs_files.sh; then<br>
&gt; @@ -187,12 +206,13 @@ else<br>
&gt; fi<br>
&gt;<br>
&gt; # sched_domain test<br>
&gt; -if ! type python &gt; /dev/null ; then<br>
&gt; +which python &gt; /dev/null<br>
&gt; +if [ $? -ne 0 ] ; then<br>
<br>
type is a bourne shell builtin whereas which is a command. &nbsp;<br>
Furthermore, you &nbsp;can inline shell true / false checks in branch &nbsp;<br>
conditionals. So why did you revert this?<br>
</font></tt>
<br><tt><font size=2>Will modify the patch accordingly.<br>
&gt; &nbsp; &nbsp;tst_resm TCONF &quot;Python is not installed, CPU Consoldation\<br>
&gt; test cannot run&quot;<br>
&gt; else<br>
&gt; &nbsp; &nbsp;if [ -f /sys/devices/system/cpu/sched_mc_power_savings
] ; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;echo &quot;max sched mc
$max_sched_mc&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp;get_sched_values sched_mc; max_sched_mc=$?<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;for sched_mc in `seq 0 $max_sched_mc`;
do<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: $(( TST_COUNT+=1))<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sched_domain.py -c $sched_mc;
RC=$?<br>
&gt; @@ -210,25 +230,6 @@ else<br>
&gt; &nbsp; &nbsp;fi<br>
&gt; fi<br>
&gt;<br>
&gt; -: $(( TST_COUNT+=1))<br>
&gt; -if [ -f /proc/sys/kernel/timer_migration ]; then<br>
&gt; - &nbsp; &nbsp;if [ $timer_migr_support_compatible -eq $YES ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;if test_timer_migration.sh; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TPASS &quot;Timer
Migration interface test&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;else<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;RC=$?<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;Timer
migration interface test&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; - &nbsp; &nbsp;fi<br>
&gt; -else<br>
&gt; - &nbsp; &nbsp;if [ $timer_migr_support_compatible -eq $YES ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;RC=$?<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;Timer migration
interface missing&quot;<br>
&gt; - &nbsp; &nbsp;else<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;tst_resm TCONF &quot;Kernel version does
not support Timer &nbsp;<br>
&gt; migration&quot;<br>
&gt; - &nbsp; &nbsp;fi<br>
&gt; -fi<br>
&gt; -<br>
&gt; if [ $# -gt 0 -a &quot;$1&quot; = &quot;-exclusive&quot; ]; then<br>
<br>
Sorry for not noticing this sooner. $1 and -exclusive should be &nbsp;<br>
prefixed by a character, e.g. x or this will be reported as a [(1) &nbsp;<br>
syntax error.<br>
Based on your comments I am doing it, as such I have not observed syntax
error while executing these testcases<br>
&gt;<br>
&gt; &nbsp; &nbsp;# Test CPU consolidation<br>
&gt; &nbsp; &nbsp;if [ $multi_socket -eq $YES -a $multi_core -eq $YES ];
then<br>
&gt; @@ -266,7 +267,7 @@ if [ $# -gt 0 -a &quot;$1&quot; = &quot;-exclusive&quot;
];<br>
&gt;<br>
&gt; &nbsp; &nbsp;fi<br>
&gt;<br>
&gt; - &nbsp; &nbsp;if [ $hyper_threaded -eq $YES -a $multi_socket -eq
$YES -a &nbsp;<br>
&gt; $multi_core -eq $NO ]; then<br>
&gt; + &nbsp; &nbsp;if [ $hyper_threaded -eq $YES ]; then<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#Testcase to validate consolidation
at core level<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for sched_smt in `seq 0 $max_sched_smt`;
do<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if [ $sched_smt
-eq 2 ]; then<br>
&gt; @@ -319,7 +320,7 @@ if [ $# -gt 0 -a &quot;$1&quot; = &quot;-exclusive&quot;
];<br>
&gt; &nbsp; &nbsp;fi<br>
&gt;<br>
&gt; &nbsp; &nbsp; # Verify threads consolidation stops when sched_smt
is disabled &nbsp;<br>
&gt; in HT systems<br>
&gt; - &nbsp; &nbsp;if [ $hyper_threaded -eq $YES -a $multi_socket -eq
$YES ]; then<br>
&gt; + &nbsp; &nbsp;if [ $hyper_threaded -eq $YES ]; then<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;# Vary only sched_smt from 1 to 0 when
workload is running &nbsp;<br>
&gt; and ensure that<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;# tasks do not consolidate to single core
when sched_smt is &nbsp;<br>
&gt; set to 0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;: $(( TST_COUNT += 1 ))<br>
<br>
Thanks,<br>
-Garrett<br>
<br>
------------------------------------------------------------------------------<br>
This SF.Net email is sponsored by the Verizon Developer Community<br>
Take advantage of Verizon's best-in-class app development support<br>
A streamlined, 14 day to market process makes app distribution fast and
easy<br>
Join now and get one step closer to millions of Verizon customers<br>
</font></tt><a href="http://p.sf.net/sfu/verizon-dev2dev"><tt><font size=2>http://p.sf.net/sfu/verizon-dev2dev</font></tt></a><tt><font size=2>
<br>
_______________________________________________<br>
Ltp-list mailing list<br>
Ltp-list@lists.sourceforge.net<br>
</font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 0028314D652576A5_=--


--===============3483148081388789722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============3483148081388789722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3483148081388789722==--

