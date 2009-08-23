Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7Wp-0002nI-CR
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:15 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Wd-0002Ai-EM
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:30:10 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N3TYZY023306
	for <ltp-list@lists.sourceforge.net>; Sat, 22 Aug 2009 23:29:34 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7Tw6a256372
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:29:58 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7Tvhj015092
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 03:29:57 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40908200951h2fed6a68gec2eace5879917ca@mail.gmail.com>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160731.30926.75897.sendpatchset@localhost.localdomain>
	<364299f40908200951h2fed6a68gec2eace5879917ca@mail.gmail.com>
Date: Sun, 23 Aug 2009 12:59:14 +0530
Message-Id: <1251012555.16822.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] New & modified reusable functions for new &
	existing	testcases
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
To: Garrett Cooper <yanegomi@gmail.com>, Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>, arun@linux.vnet.ibm.com

On Thu, 2009-08-20 at 09:51 -0700, Garrett Cooper wrote: 
> On Thu, Aug 20, 2009 at 9:07 AM, Poornima
> Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> > Implemented reusable functions to learn system architecture before executing
> > architecture specific testcases.
> >
> > Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> >
> > diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/pm_include.sh ltp-full-20090731/testcases/kernel/power_management/pm_include.sh
> > --- ltp-full-20090731_orig/testcases/kernel/power_management/pm_include.sh      2009-08-20 19:59:11.000000000 +0530
> > +++ ltp-full-20090731/testcases/kernel/power_management/pm_include.sh   2009-08-20 20:29:21.000000000 +0530
> > @@ -112,6 +112,46 @@ function is_multi_socket() {
> >        fi
> >  }
> >
> > +function is_multi_core() {
> > +       siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> > +       cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> > +       echo "siblings count $siblings cores count $cpu_cores"
> > +       if [ $siblings -eq $cpu_cores ]; then
> > +               if [ $cpu_cores -gt 1 ]; then
> > +                       return 0
> > +               else
> > +                       return 1
> > +               fi
> > +       else
> > +               : $(( num_of_cpus = siblings / cpu_cores ))
> > +               if [ $num_of_cpus -gt 1 ]; then
> > +                       return 0
> > +               else
> > +                       return 1
> > +               fi
> > +       fi
> > +}
> > +
> > +function is_dual_core() {
> > +       siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> > +        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> > +        if [ $siblings -eq $cpu_cores ]; then
> > +                if [ $cpu_cores -eq 2 ]; then
> > +                        return 1
> > +                else
> > +                        return 0
> > +                fi
> > +        else
> > +                : $(( num_of_cpus = siblings / cpu_cores ))
> > +                if [ $num_of_cpus -eq 2 ]; then
> > +                        echo "number of cpus $num_of_cpus"
> > +                        return 1
> > +                else
> > +                        return 0
> > +                fi
> > +        fi
> > +}
> > +
> >  function get_kernel_version() {
> >        # Get kernel minor version
> >        export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
> > @@ -120,42 +160,12 @@ function get_kernel_version() {
> >  function get_valid_input() {
> >        kernel_version=$1
> >        case "$kernel_version" in
> > -       '2.6.29' | '2.6.30' | '2.6.31')
> > -                       export valid_input="0 1 2" ;;
> > -               *) export valid_input="0 1" ;;
> > +       '2.6.26' | '2.6.27' | '2.6.28')
> > +                       export valid_input="0 1" ;;
> > +               *) export valid_input="0 1 2" ;;
> >        esac
> >  }
> >
> > -function get_max_sched_mc() {
> > -       get_kernel_version
> > -       case "$kernel_version" in
> > -       '2.6.29' | '2.6.30' | '2.6.31')
> > -               return 2
> > -               ;;
> > -       '2.6.26' | '2.6.27' | '2.6.28')
> > -               return 1
> > -               ;;
> > -       *)
> > -               return 0
> > -               ;;
> > -       esac
> > -}
> > -
> > -function get_max_sched_smt() {
> > -    get_kernel_version
> > -    case "$kernel_version" in
> > -        '2.6.29' | '2.6.30' | '2.6.31')
> > -                    return 2
> > -                               ;;
> > -        '2.6.26' | '2.6.27' | '2.6.28')
> > -                    return 1
> > -                               ;;
> > -        *)
> > -                       return 0
> > -                       ;;
> > -       esac
> > -}
> > -
> >  function check_supp_wkld() {
> >        sched_mcsmt=$1
> >        work_load=$2
> > @@ -184,58 +194,33 @@ function analyze_wrt_workload_hyperthrea
> >     work_load=$2
> >     pass_count=$3
> >     sched_smt=$4
> > -    stress=$5
> >
> > -       if [ $sched_mc > $sched_smt ]; then
> > +       if [ $sched_mc -gt $sched_smt ]; then
> >                check_supp_wkld $sched_mc $work_load; valid_workload=$?
> >        else
> >                check_supp_wkld $sched_smt $work_load; valid_workload=$?
> >        fi
> >
> > -       if [ "$stress" = "thread" ]; then
> > -               case "$valid_workload" in
> > -        0)
> > -                       if [ $pass_count -lt 5 ]; then
> > -                               RC=1
> > -                               tst_resm TFAIL "Consolidation at core level failed for \
> > -sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
> > -                       else
> > -                               tst_resm TPASS "Consolidation at core level passed for \
> > -sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
> > -                       fi ;;
> > -        1)
> > -            if [ $pass_count -lt 5 ]; then
> > -                tst_resm TPASS "Consolidation at core level failed for \
> > -unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > -            else
> > -                               RC=1
> > -                tst_resm TFAIL "Consolidation at core level passed for \
> > -unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > -            fi ;;
> > -        esac
> > -       else
> > -               case "$valid_workload" in
> > -        0)
> > -            if [ $pass_count -lt 5 ]; then
> > -                               RC=1
> > -                tst_resm TFAIL "Consolidation at package level failed for \
> > +       case "$valid_workload" in
> > +       0)
> > +               if [ $pass_count -lt 5 ]; then
> > +                       RC=1
> > +                       tst_resm TFAIL "Consolidation at package level failed for \
> >  sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
> > -            else
> > -                tst_resm TPASS "Consolidation at package level passed for \
> > +               else
> > +                       tst_resm TPASS "Consolidation at package level passed for \
> >  sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
> > -            fi ;;
> > -        1)
> > -                       echo "pass count is $pass_count"
> > -            if [ $pass_count -lt 5 ]; then
> > -                tst_resm TPASS "Consolidation at package level failed for \
> > +               fi ;;
> > +       1)
> > +               if [ $pass_count -lt 5 ]; then
> > +                       tst_resm TPASS "Consolidation at package level failed for \
> >  unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > -            else
> > -                               RC=1
> > -                tst_resm TFAIL "Consolidation at package level passed for \
> > +               else
> > +                       RC=1
> > +                       tst_resm TFAIL "Consolidation at package level passed for \
> >  unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > -            fi ;;
> > +               fi ;;
> >         esac
> > -       fi
> >  }
> >
> >  function analyze_wrt_wkld() {
> > @@ -243,12 +228,11 @@ function analyze_wrt_wkld() {
> >     work_load=$2
> >     pass_count=$3
> >        sched_smt=$4
> > -       stress=$5
> >
> >        check_supp_wkld $sched_mc $work_load; valid_workload=$?
> >        if [ $hyper_threaded -eq $YES ]; then
> >                analyze_wrt_workload_hyperthreaded $sched_mc $work_load $pass_count\
> > -                $sched_smt $stress
> > +                $sched_smt
> >        else
> >                case "$valid_workload" in
> >                0)
> > @@ -278,74 +262,56 @@ function analyze_result_hyperthreaded()
> >     work_load=$2
> >     pass_count=$3
> >     sched_smt=$4
> > -    stress=$5
> >
> > +       echo "sched_mc =$sched_mc  work-load=$work_load  pass_count=$pass_count  sched_smt=$sched_smt"
> >        case "$sched_mc" in
> >        0)
> >                if [ $sched_smt ]; then
> >                        case "$sched_smt" in
> >                        0)
> > -                               if [ "$stress" = "thread" ]; then
> > -                                       if [ $pass_count -lt 1 ]; then
> > -                                               tst_resm TPASS "Consolidation at core level failed for sched_mc=\
> > -$sched_mc & sched_smt=$sched_smt for workload=$work_load"
> > -                                       else
> > -                                               RC=1
> > -                                               tst_resm TFAIL "Consolidation at core level passed for sched_mc=\
> > +                               if [ "$pass_count" -lt 5 ]; then
> > +                                       tst_resm TPASS "cpu consolidation failed for sched_mc=\
> >  $sched_mc & sched_smt=$sched_smt for workload=$work_load"
> > -                                       fi
> >                                else
> > -                                       if [ "$pass_count" -lt 1 ]; then
> > -                                               tst_resm TPASS "cpu consolidation failed for sched_mc=\
> > -$sched_mc & sched_smt=$sched_smt for workload=$work_load"
> > -                                       else
> > -                                               RC=1
> > -                                               tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> > +                                       RC=1
> > +                               tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> >  $sched_mc & sched_smt=$sched_smt for workload=$work_load"
> > -                                       fi
> >                                fi
> >                                ;;
> >                        *)
> > -                               if [ "$stress" = "thread" ]; then
> > -                                       analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
> > -                               else
> > -                                       analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
> > -                               fi ;;
> > +                               analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
> > +                               ;;
> >                        esac
> >                else
> > -                       if [ $pass_count -lt 1 ]; then
> > +                       if [ $pass_count -lt 5 ]; then
> >                                tst_resm TPASS "cpu consolidation failed for sched_mc=\
> >  $sched_mc for workload=$work_load"
> >                        else
> >                                RC=1
> >                                tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> > -$sched_mc & sched_smt=$sched_smt for workload=$work_load"
> > +$sched_mc for workload=$work_load"
> >                        fi
> >                fi
> >                ;;
> >        *)
> > -               if [ "$stress" = "thread" ]; then
> > -                       analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
> > -               else
> >                        analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
> > -               fi
> >                ;;
> >        esac
> >  }
> >
> > -function analyze_consolidation_result() {
> > +function analyze_package_consolidation_result() {
> >        sched_mc=$1
> >     work_load=$2
> >     pass_count=$3
> >        sched_smt=$4
> > -       stress=$5
> >
> > +       echo "sched mc $sched_mc sched smt is $sched_smt workload $work_load pass count $pass_count"
> >        if [ $hyper_threaded -eq $YES ]; then
> > -               analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt $stress
> > +               analyze_result_hyperthreaded $sched_mc $work_load $pass_count $sched_smt
> >        else
> >                case "$sched_mc" in
> >            0)
> > -           if [ $pass_count -lt 1 ]; then
> > +           if [ $pass_count -lt 5 ]; then
> >                    tst_resm TPASS "cpu consolidation failed for sched_mc=\
> >  $sched_mc for workload=$work_load"
> >                else
> > @@ -360,6 +326,33 @@ $sched_mc for workload=$work_load"
> >        fi
> >  }
> >
> > +function analyze_core_consolidation_result() {
> > +       sched_smt=$1
> > +       work_load=$2
> > +       pass_count=$3
> > +
> > +       case "$valid_workload" in
> > +       0)
> > +               if [ $pass_count -lt 5 ]; then
> > +                       RC=1
> > +                       tst_resm TFAIL "Consolidation at core level failed for \
> > +sched_mc=$sched_mc, sched_smt=$sched_smt for workload=$work_load"
> > +               else
> > +                       tst_resm TPASS "Consolidation at core level passed for \
> > +sched_mc=$sched_mc, sched_smt=$sched_smt & workload=$work_load"
> > +               fi ;;
> > +       1)
> > +               if [ $pass_count -lt 5 ]; then
> > +                       tst_resm TPASS "Consolidation at core level failed for \
> > +unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > +               else
> > +                       RC=1
> > +                       tst_resm TFAIL "Consolidation at core level passed for \
> > +unsupported workload $work_load when sched_mc=$sched_mc & sched_smt=$sched_smt"
> > +               fi ;;
> > +       esac
> > +}
> > +
> >  function analyze_sched_domain_result(){
> >        sched_mc=$1
> >        result=$2
> 
> 1. Check for files before cat'ing or at least redirect stderr to /dev/null.
> 2. Please quote any and all variables from files cat'ed out.
> 3. Please convert bash-ism's to bourne compatible routines, e.g.
> 
> function foo() {
> 
> }
> 
> ... to...
> 
> foo() {
> 
> }
> 
> 4. This form:
> 
> if [ $num_of_cpus -gt 1 ]; then
> +                       return 0
> +               else
> +                       return 1
> +               fi
> 
> Can be replaced by:
> 
> [ $num_of_cpus -gt 1 ]; return $?
> 
> etc.

Poornima,

Please address them as well.

Regards--
Subrata

> 
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
