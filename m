Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mple9-0004ul-9p
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:49 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mple3-0006wj-Ig
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:21:49 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LGEL59001735
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:14:21 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LGLcGv212280
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:21:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LGLbDk031283
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:21:37 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
Date: Mon, 21 Sep 2009 21:50:35 +0530
Message-Id: <1253550037.6736.26.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 1/6] To test consolidation resets when
	interfaces	are set to 0
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Mon, 2009-09-21 at 12:54 +0530, Poornima Nayak wrote: 
> CPU consolidation testcase modified to test when sched_mc &(/) sched_smt
> is set to Zero processes dont consolidate to single package or CPU.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090831/testcases/kernel/power_management/cpu_consolidation.py ltp-full-20090831_patched/testcases/kernel/power_management/cpu_consolidation.py
> --- ltp-full-20090831/testcases/kernel/power_management/cpu_consolidation.py	2009-08-31 10:45:45.000000000 +0530
> +++ ltp-full-20090831_patched/testcases/kernel/power_management/cpu_consolidation.py	2009-09-21 12:16:50.790630427 +0530
> @@ -5,6 +5,7 @@
> 
>  import os
>  import sys
> +import time
>  LIB_DIR = "%s/testcases/kernel/power_management/lib" % os.environ['LTPROOT']
>  sys.path.append(LIB_DIR)
>  from optparse import OptionParser
> @@ -22,9 +23,12 @@ def main(argv=None):
> 
>      usage = "-w"
>      parser = OptionParser(usage)
> -    parser.add_option("-c", "--mc_level", dest="mc_level",
> +    parser.add_option("-v", "--variation_test", dest="vary_mc_smt",
> +        default=False, action="store_true", help="Vary sched_mc & sched_smt. \
> +            -c and -t inputs are initial value of sched_mc & sched_smt")
> +    parser.add_option("-c", "--mc_value", dest="mc_value",
>          default=0, help="Sched mc power saving value 0/1/2")
> -    parser.add_option("-t", "--smt_level", dest="smt_level",
> +    parser.add_option("-t", "--smt_value", dest="smt_value",
>          default=0, help="Sched smt power saving value 0/1/2")
>      parser.add_option("-w", "--workload", dest="work_ld",
>          default="ebizzy", help="Workload can be ebizzy/kernbench")
> @@ -35,22 +39,94 @@ def main(argv=None):
>      try:
>          count_num_cpu()
>          count_num_sockets()
> -        if is_multi_socket():
> -            set_sched_mc_power(options.mc_level)
> -        if is_hyper_threaded():
> -            set_sched_smt_power(options.smt_level)
> -        map_cpuid_pkgid()
> -        print "INFO: Created table mapping cpu to package"
> -        background="no"
> -        duration=60
> -        pinned ="no"
> -        trigger_workld(options.work_ld, options.stress, duration, background, pinned)
> -        generate_report()
> -        status = validate_cpu_consolidation(options.work_ld,options.mc_level, options.smt_level)
> -        reset_schedmc()
> -        if is_hyper_threaded():
> -            reset_schedsmt()
> -        return(status)        
> +        # User would set option -v / -vc / -vt to test cpu consolidation
> +        # gets disabled when sched_mc &(/) sched_smt is disabled when
> +        # workload is already running in the system 
> +        if options.vary_mc_smt:
> +
> +            # Since same code is used for testing package consolidation and core
> +            # consolidation is_multi_socket & is_hyper_threaded check is done
> +            if is_multi_socket():
> +                if options.mc_value:
> +                    set_sched_mc_power(options.mc_value)
> +                    mc_value=int(options.mc_value)
> +                else:    
> +                    set_sched_mc_power(1)
> +                    mc_value=int(options.mc_value)
> +            if is_hyper_threaded():
> +                if options.smt_value:
> +                    set_sched_smt_power(options.smt_value)
> +                    smt_value=int(options.smt_value)
> +                else:
> +                    set_sched_smt_power(1)
> +                    smt_value=1
> +
> +            #Generate arguments for trigger workload, run workload in background
> +            map_cpuid_pkgid()
> +            background="yes"
> +            duration=360
> +            pinned="no"
> +            if int(options.mc_value) < 2:
> +                trigger_ebizzy (smt_value, "partial", duration, background, pinned)
> +                work_ld="ebizzy"
> +                #Wait for 120 seconds and then validate cpu consolidation works
> +                #When sched_mc & sched_smt is set
> +                import time
> +                time.sleep(120)
> +            else:
> +                #Wait for 120 seconds and then validate cpu consolidation works
> +                #When sched_mc & sched_smt is set
> +                trigger_kernbench (smt_value, "partial", background, pinned) 
> +                work_ld="kernbench"
> +                import time
> +                time.sleep(240)
> +
> +            generate_report()
> +            status = validate_cpu_consolidation(work_ld, mc_value, smt_value)
> +            if status == 0:
> +                print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
> +                #Disable sched_smt & sched_mc interface values
> +                if (options.vary_mc_smt and options.mc_value) and is_multi_socket():
> +                    set_sched_mc_power(0)
> +                    #Reset sched_smt bcoz when sched_smt is set process still
> +                    #continue to consolidate
> +                    if is_hyper_threaded():
> +                        set_sched_smt_power(0)
> +                if (options.vary_mc_smt and options.smt_value) and is_hyper_threaded():
> +                    set_sched_smt_power(0)
> +                time.sleep(120)
> +                generate_report()
> +                status = validate_cpu_consolidation(options.work_ld,options.mc_value, options.smt_value)
> +                #CPU consolidation should fail as sched_mc &(/) sched_smt is disabled
> +                if status == 1:
> +                    return(0)
> +                else:
> +                    return(1)
> +            else:
> +                print "INFO: CPU consolidation failed when sched_mc &(/) \
> +sched_smt was enabled. This is pre-requisite to proceed"
> +                return(status)
> +        else:           
> +            #The else part of the code validates behaviour of sched_mc
> +            # and sched_smt set to 0, 1 & 2
> +            if is_multi_socket():
> +                set_sched_mc_power(options.mc_value)
> +            if is_hyper_threaded():
> +                set_sched_smt_power(options.smt_value)
> +                #Commented after observing changes in behaviour in 2.6.31-rc7
> +                #stress="thread"
> +            map_cpuid_pkgid()
> +            print "INFO: Created table mapping cpu to package"
> +            background="no"
> +            duration=60
> +            pinned ="no"
> +            trigger_workld( options.smt_value, options.work_ld, options.stress, duration, background, pinned)
> +            generate_report()
> +            status = validate_cpu_consolidation(options.work_ld,options.mc_value, options.smt_value)
> +            reset_schedmc()
> +            if is_hyper_threaded():
> +                reset_schedsmt()
> +            return(status)        
>      except Exception, details:
>          print "INFO: CPU consolidation failed", details
>          return(1)
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
