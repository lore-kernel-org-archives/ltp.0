Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mf7W4-0002is-1b
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:28 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf7Vx-0004Kp-OF
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 07:29:28 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7N7NfdE031102
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:23:41 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7N7TGsm220376
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:16 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7N7TFYC025850
	for <ltp-list@lists.sourceforge.net>; Sun, 23 Aug 2009 01:29:16 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090820160800.30926.41644.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160800.30926.41644.sendpatchset@localhost.localdomain>
Date: Sun, 23 Aug 2009 12:58:58 +0530
Message-Id: <1251012538.16822.36.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch to fix cpu consolidation failure for kernbench
	on	HT system
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, 2009-08-20 at 21:38 +0530, Poornima Nayak wrote: 
> Threshold and validation functions modified for testcases run on HT systems. 
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/lib/sched_mc.py ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc.py
> --- ltp-full-20090731_orig/testcases/kernel/power_management/lib/sched_mc.py	2009-08-20 19:59:11.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc.py	2009-08-20 20:33:21.000000000 +0530
> @@ -193,6 +193,8 @@ def trigger_ebizzy (stress, duration, ba
>              threads = get_hyper_thread_count()
>          if stress == "partial":
>              threads = cpu_count / socket_count
> +            if is_hyper_threaded():
> +                threads = threads / get_hyper_thread_count()
>          if stress == "full":
>  	    threads = cpu_count
> 
> @@ -244,9 +246,11 @@ def trigger_kernbench (stress, backgroun
>      olddir = os.getcwd()
>      try:
>          if stress == "thread":
> -	        threads = 2
> +	    threads = 2
>          if stress == "partial":
> -	        threads = cpu_count / socket_count
> +	    threads = cpu_count / socket_count
> +            if is_hyper_threaded():
> +                threads = threads / get_hyper_thread_count()
>          if stress == "full":
>              threads = cpu_count
> 
> @@ -281,7 +285,8 @@ def trigger_kernbench (stress, backgroun
>  	    sys.exit(1)
>     
>          get_proc_data(stats_start)
> -        os.system ( '%s/kernbench -o 2 -M -H -n 1 >/dev/null 2>&1' % benchmark_path)
> +        os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (benchmark_path, threads))
> +        print threads
>          
>          print "INFO: Workload kernbench triggerd"
>          os.chdir(olddir)
> @@ -438,6 +443,8 @@ def validate_cpugrp_map(cpu_group, sched
>                          for i in range(0, len(core_cpus)):
>                              if core_cpus[i] in modi_cpu_grp:
>                                  modi_cpu_grp.remove(core_cpus[i]) 
> +                                if len(modi_cpu_grp) == 0:
> +                                    return 0
>                              else:
>                                  # If sched_smt == 0 then its oky if threads run
>                                  # in different cores of same package 
> @@ -499,24 +506,35 @@ def verify_sched_domain_dmesg(sched_mc_l
>          print "Reading dmesg failed", details
>          sys.exit(1)
> 
> -def validate_cpu_consolidation(sched_mc_level, sched_smt_level):
> +def validate_cpu_consolidation(work_ld, sched_mc_level, sched_smt_level):
>      ''' Verify if cpu's on which threads executed belong to same
>      package
>      '''
>      cpus_utilized = list()
>      try:
>          for l in sorted(stats_percentage.keys()):
> -	    #modify threshold
> -            if stats_percentage[l][1] > 50:
> -                cpu_id = stats_percentage[l][0].split("cpu")
> -                if cpu_id[1] != '':
> -                    cpus_utilized.append(int(cpu_id[1]))
> -        cpus_utilized.sort()
> +            #modify threshold
> +            if is_hyper_threaded():
> +                if stats_percentage[l][1] > 25 and work_ld == "kernbench":
> +                    cpu_id = stats_percentage[l][0].split("cpu")
> +                    if cpu_id[1] != '':
> +                        cpus_utilized.append(int(cpu_id[1]))
> +                else:
> +                    if stats_percentage[l][1] > 50:
> +                        cpu_id = stats_percentage[l][0].split("cpu")
> +                        if cpu_id[1] != '':
> +                            cpus_utilized.append(int(cpu_id[1]))
> +            else:
> +                if stats_percentage[l][1] > 50:
> +                    cpu_id = stats_percentage[l][0].split("cpu")
> +                    if cpu_id[1] != '':
> +                        cpus_utilized.append(int(cpu_id[1]))
> +                    cpus_utilized.sort()
>          print "INFO: CPU's utilized ", cpus_utilized
> 
>          status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
> -	if status == 1:
> -	    print "INFO: CPUs utilized is not in same package or core"
> +        if status == 1:
> +            print "INFO: CPUs utilized is not in same package or core"
>          return(status)
>      except Exception, details:
>          print "Exception in validate_cpu_consolidation: ", details
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
