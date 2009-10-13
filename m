Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxeNT-00076l-Kw
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:11 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxeNL-0001H4-BB
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:11 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DA5kgW023866
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:05:46 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DACvOo255124
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:12:57 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DA9Vvk031889
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 06:09:31 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091013074405.22414.27163.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074405.22414.27163.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 15:42:40 +0530
Message-Id: <1255428760.8438.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 4/6] Enhanced & Modified cpu_consolidation	testcase
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Tue, 2009-10-13 at 13:14 +0530, Poornima Nayak wrote: 
> We can pass additional argument performance to use the same testcase for 
> Performance test. Fixed issues in cpu consolidation test.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090930/testcases/kernel/power_management/cpu_consolidation.py ltp-full-20090930_patched/testcases/kernel/power_management/cpu_consolidation.py
> --- ltp-full-20090930/testcases/kernel/power_management/cpu_consolidation.py	2009-10-05 02:10:56.000000000 -0400
> +++ ltp-full-20090930_patched/testcases/kernel/power_management/cpu_consolidation.py	2009-10-12 23:03:04.000000000 -0400
> @@ -34,40 +34,37 @@ def main(argv=None):
>          default="ebizzy", help="Workload can be ebizzy/kernbench")
>      parser.add_option("-s", "--stress", dest="stress",
>          default="partial", help="Load on system is full/partial [i.e 50%]/thread")
> +    parser.add_option("-p", "--performance", dest="perf_test",
> +        default=False, action="store_true", help="Enable performance test")
>      (options, args) = parser.parse_args()
> 
>      try:
>          count_num_cpu()
>          count_num_sockets()
> -        # User would set option -v / -vc / -vt to test cpu consolidation
> -        # gets disabled when sched_mc &(/) sched_smt is disabled when
> -        # workload is already running in the system 
> +        if is_hyper_threaded():
> +            generate_sibling_list()
> +        
> +        # User should set option -v to test cpu consolidation
> +        # resets when sched_mc &(/) sched_smt is disabled when
> +        # workload is already running in the system
> + 
>          if options.vary_mc_smt:
> 
>              # Since same code is used for testing package consolidation and core
>              # consolidation is_multi_socket & is_hyper_threaded check is done
> -            if is_multi_socket():
> -                if options.mc_value:
> -                    set_sched_mc_power(options.mc_value)
> -                    mc_value=int(options.mc_value)
> -                else:    
> -                    set_sched_mc_power(1)
> -                    mc_value=int(options.mc_value)
> -            if is_hyper_threaded():
> -                if options.smt_value:
> -                    set_sched_smt_power(options.smt_value)
> -                    smt_value=int(options.smt_value)
> -                else:
> -                    set_sched_smt_power(1)
> -                    smt_value=1
> +            if is_multi_socket() and is_multi_core() and options.mc_value:
> +                set_sched_mc_power(options.mc_value)
> +
> +            if is_hyper_threaded() and options.smt_value:
> +                set_sched_smt_power(options.smt_value)
> 
>              #Generate arguments for trigger workload, run workload in background
>              map_cpuid_pkgid()
>              background="yes"
>              duration=360
>              pinned="no"
> -            if int(options.mc_value) < 2:
> -                trigger_ebizzy (smt_value, "partial", duration, background, pinned)
> +            if int(options.mc_value) < 2 and int(options.smt_value) < 2:
> +                trigger_ebizzy (options.smt_value, "partial", duration, background, pinned)
>                  work_ld="ebizzy"
>                  #Wait for 120 seconds and then validate cpu consolidation works
>                  #When sched_mc & sched_smt is set
> @@ -76,27 +73,36 @@ def main(argv=None):
>              else:
>                  #Wait for 120 seconds and then validate cpu consolidation works
>                  #When sched_mc & sched_smt is set
> -                trigger_kernbench (smt_value, "partial", background, pinned) 
> +                trigger_kernbench (options.smt_value, "partial", background, pinned, "no") 
>                  work_ld="kernbench"
>                  import time
> -                time.sleep(240)
> +                time.sleep(300)
> 
>              generate_report()
> -            status = validate_cpu_consolidation(work_ld, mc_value, smt_value)
> +            status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
>              if status == 0:
>                  print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
>                  #Disable sched_smt & sched_mc interface values
> -                if (options.vary_mc_smt and options.mc_value) and is_multi_socket():
> +                if options.vary_mc_smt and options.mc_value > 0:
>                      set_sched_mc_power(0)
> -                    #Reset sched_smt bcoz when sched_smt is set process still
> -                    #continue to consolidate
> -                    if is_hyper_threaded():
> -                        set_sched_smt_power(0)
> -                if (options.vary_mc_smt and options.smt_value) and is_hyper_threaded():
> +                    mc_value = options.mc_value
> +                else:
> +                    mc_value = 0
> +                if options.vary_mc_smt and options.smt_value > 0 and is_hyper_threaded():
>                      set_sched_smt_power(0)
> -                time.sleep(120)
> +                    smt_value = options.smt_value
> +                else:
> +                    smt_value = 0
> +
> +                if work_ld == "kernbench":
> +                    time.sleep(240)
> +                else:
> +                    time.sleep(120)
> +
>                  generate_report()
> -                status = validate_cpu_consolidation(options.work_ld,options.mc_value, options.smt_value)
> +                status = validate_cpu_consolidation("partial", work_ld, mc_value, smt_value)
> +                if background == "yes":
> +                    stop_wkld(work_ld)
>                  #CPU consolidation should fail as sched_mc &(/) sched_smt is disabled
>                  if status == 1:
>                      return(0)
> @@ -113,16 +119,20 @@ sched_smt was enabled. This is pre-requi
>                  set_sched_mc_power(options.mc_value)
>              if is_hyper_threaded():
>                  set_sched_smt_power(options.smt_value)
> -                #Commented after observing changes in behaviour in 2.6.31-rc7
> -                #stress="thread"
>              map_cpuid_pkgid()
>              print "INFO: Created table mapping cpu to package"
>              background="no"
>              duration=60
>              pinned ="no"
> -            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned)
> +
> +            if options.perf_test:
> +                perf_test="yes"
> +            else:
> +                perf_test="no"
> +
> +            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned, perf_test)
>              generate_report()
> -            status = validate_cpu_consolidation(options.work_ld,options.mc_value, options.smt_value)
> +            status = validate_cpu_consolidation(options.stress, options.work_ld,options.mc_value, options.smt_value)
>              reset_schedmc()
>              if is_hyper_threaded():
>                  reset_schedsmt()
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
