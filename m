Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mpld6-00080g-Nk
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:20:44 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mpld1-0003UV-JT
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:20:44 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LGJguR022328
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:19:42 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LGKXor233264
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:20:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LGKX6i025348
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:20:33 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090921072529.7307.95690.sendpatchset@localhost.localdomain>
References: <20090921072444.7307.84825.sendpatchset@localhost.localdomain>
	<20090921072529.7307.95690.sendpatchset@localhost.localdomain>
Date: Mon, 21 Sep 2009 21:50:12 +0530
Message-Id: <1253550014.6736.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 6/6] Modified python functions based
	on	requirement	for new testcase
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

On Mon, 2009-09-21 at 12:55 +0530, Poornima Nayak wrote: 
> Fixed some issues that affect verification code of new test scenarios.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090831/testcases/kernel/power_management/lib/sched_mc.py ltp-full-20090831_patched/testcases/kernel/power_management/lib/sched_mc.py
> --- ltp-full-20090831/testcases/kernel/power_management/lib/sched_mc.py	2009-08-31 10:45:45.000000000 +0530
> +++ ltp-full-20090831_patched/testcases/kernel/power_management/lib/sched_mc.py	2009-09-21 12:23:17.342934615 +0530
> @@ -21,6 +21,7 @@ cpu_count = 0
>  socket_count = 0
>  cpu1_max_intr = 0
>  cpu2_max_intr = 0
> +intr_stat_timer_0 = []
> 
>  def clear_dmesg():
>      '''
> @@ -177,6 +178,7 @@ def get_proc_loc_count(loc_stats):
>                  for i in range(0, cpu_count):
>                      # To skip LOC
>                      loc_stats.append(data[i+1])
> +                    print data[i+1]
>          file_procstat.close()
>      except Exception, details:
>          print "Could not read interrupt statistics", details
> @@ -216,12 +218,7 @@ def set_timer_migration_interface(value)
>          print "Could not set timer_migration to ", value, e
>          sys.exit(1)
> 
> -def start_cyclictest():
> -    ''' Trigger cyclictest in background to increase
> -        timer interrupts
> -    '''
> -    
> -def trigger_ebizzy (stress, duration, background, pinned):
> +def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
>      ''' Triggers ebizzy workload for sched_mc=1
>          testing
>      '''
> @@ -230,8 +227,6 @@ def trigger_ebizzy (stress, duration, ba
>              threads = get_hyper_thread_count()
>          if stress == "partial":
>              threads = cpu_count / socket_count
> -            if is_hyper_threaded():
> -                threads = threads / get_hyper_thread_count()
>          if stress == "full":
>  	    threads = cpu_count
>          if stress == "single_job":
> @@ -255,24 +250,30 @@ def trigger_ebizzy (stress, duration, ba
>          if workload_dir != "":
>              new_path = os.path.join(path,"%s" % workload_dir)
>              get_proc_data(stats_start)
> +            get_proc_loc_count(intr_start)
>              try:
>                  os.chdir(new_path)
>                  if background == "yes":
> -                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &' % (threads, duration))
> +                    succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
> +                        % (threads, duration))
>                  else:
>                      if pinned == "yes":
> -                        succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null' % (cpu_count -1, threads, duration))
> +                        succ = os.system('taskset -c %s ./ebizzy -t%s -s4096 -S %s >/dev/null' 
> +                            % (cpu_count -1, threads, duration))
>                      else:
> -                        succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null' % (threads, duration))
> +                        succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null' 
> +                            % (threads, duration))
>           
>                  if succ == 0: 
>                      print "INFO: ebizzy workload triggerd"
>                      os.chdir(olddir)
> -                    get_proc_data(stats_stop)
> +                    #Commented bcoz it doesnt make sense to capture it when workload triggered 
> +                    #in background
> +                    #get_proc_loc_count(intr_stop)
> +                    #get_proc_data(stats_stop)
>  		else:
>                      print "INFO: ebizzy workload triggerd failed"
>                      os.chdir(olddir)
> -                    get_proc_data(stats_stop)
>                      sys.exit(1)
>              except Exception, details:
>                  print "Ebizzy workload trigger failed ", details
> @@ -281,7 +282,7 @@ def trigger_ebizzy (stress, duration, ba
>          print "Ebizzy workload trigger failed ", details
>          sys.exit(1)   
> 
> -def trigger_kernbench (stress, background, pinned):
> +def trigger_kernbench (sched_smt, stress, background, pinned):
>      ''' Trigger load on system like kernbench.
>          Copys existing copy of LTP into as LTP2 and then builds it
>          with make -j
> @@ -292,7 +293,7 @@ def trigger_kernbench (stress, backgroun
>  	    threads = 2
>          if stress == "partial":
>  	    threads = cpu_count / socket_count
> -            if is_hyper_threaded():
> +            if is_hyper_threaded() and int(sched_smt) !=2:
>                  threads = threads / get_hyper_thread_count()
>          if stress == "full":
>              threads = cpu_count
> @@ -326,33 +327,40 @@ def trigger_kernbench (stress, backgroun
>          if linux_source_dir != "":
>              os.chdir(linux_source_dir)
>          else:
> -            print "INFO: Linux kernel source not found. Kernbench cannot be executed"
> +            print "INFO: Linux kernel source not found in /root. Workload\
> +               Kernbench cannot be executed"
>  	    sys.exit(1)
>    
>          get_proc_data(stats_start)
>          get_proc_loc_count(intr_start)
>          if pinned == "yes":
> -            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (cpu_count-1, benchmark_path, threads))
> +            os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 \
> +                >/dev/null 2>&1' % (cpu_count-1, benchmark_path, threads))
>          else:
> -            os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' % (benchmark_path, threads))
> +            if background == "yes":
> +                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
> +                    % (benchmark_path, threads))
> +            else:
> +                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
> +                    % (benchmark_path, threads))
>          
>          print "INFO: Workload kernbench triggerd"
>          os.chdir(olddir)
> -        get_proc_data(stats_stop)
> -        get_proc_loc_count(intr_stop)
> +        #get_proc_data(stats_stop)
> +        #get_proc_loc_count(intr_stop)
>      except Exception, details:
>          print "Workload kernbench trigger failed ", details
>          sys.exit(1)
>     
> -def trigger_workld(workload, stress, duration, background, pinned):
> +def trigger_workld(sched_smt, workload, stress, duration, background, pinned):
>      ''' Triggers workload passed as argument. Number of threads 
>          triggered is based on stress value.
>      '''
>      try:
>          if workload == "ebizzy":
> -            trigger_ebizzy (stress, duration, background, pinned)
> +            trigger_ebizzy (sched_smt, stress, duration, background, pinned)
>          if workload == "kernbench":
> -            trigger_kernbench (stress, background, pinned)
> +            trigger_kernbench (sched_smt, stress, background, pinned)
>      except Exception, details:
>          print "INFO: Trigger workload failed", details
>          sys.exit(1)
> @@ -365,6 +373,8 @@ def generate_report():
>      if (not os.path.exists('/procstat')):
>          os.mkdir('/procstat')
> 
> +    get_proc_data(stats_stop)
> +
>      reportfile = open('/procstat/cpu-utilisation', 'a')
>      debugfile = open('/procstat/cpu-utilisation.debug', 'a')
>      for l in stats_stop:
> @@ -438,18 +448,40 @@ def generate_report():
>  def generate_loc_intr_report():
>      ''' Generate interrupt report of CPU's
>      '''
> -    if (not os.path.exists('/procstat')):
> -        os.mkdir('/procstat')
> +    try:
> +        if (not os.path.exists('/procstat')):
> +            os.mkdir('/procstat')
> 
> -    reportfile = open('/procstat/cpu-loc_interrupts', 'a')
> -    print >> reportfile, "=============================================================="
> -    print >> reportfile, "                Local timer interrupt stats                   "
> -    print >> reportfile, "=============================================================="
> -    for i in range(0, cpu_count):
> -        intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
> -        print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
> -    print >> reportfile
> -    reportfile.close()
> +        get_proc_loc_count(intr_stop)
> +
> +        print "Before substracting"
> +        for i in range(0, cpu_count):
> +            print "CPU",i, intr_start[i], intr_stop[i]
> +            reportfile = open('/procstat/cpu-loc_interrupts', 'a')
> +            print >> reportfile, "=============================================="
> +            print >> reportfile, "     Local timer interrupt stats              "
> +            print >> reportfile, "=============================================="
> +        for i in range(0, cpu_count):
> +            intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
> +            print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
> +        print >> reportfile
> +        reportfile.close()
> +    except Exception, details:
> +        print "Generating reportfile failed: ", details
> +        sys.exit(1)
> +
> +def record_loc_intr_count():
> +    ''' Record Interrupt statistics when timer_migration
> +        was disabled
> +    '''
> +    try:
> +        global intr_start, intr_stop
> +        for i in range(0, cpu_count):
> +            intr_stat_timer_0.append(intr_stop[i]) 
> +        intr_start = []
> +        intr_stop = []
> +    except Exception, details:
> +        print "INFO: Record interrupt statistics when timer_migration=0",details 
> 
>  def expand_range(range_val):
>      '''
> @@ -519,7 +551,7 @@ def validate_cpugrp_map(cpu_group, sched
>                                      if len(cpu_group) == 2 and \
>                                          len(modi_cpu_grp) < len(cpu_group):
>                                          print "INFO:CPUs utilized not in a core"
> -                                        return 0                                        
> +                                        return 1                                        
>              print "INFO: CPUs utilized is not in same package or core"
>              return(1)
>  	else:
> @@ -550,7 +582,8 @@ def verify_sched_domain_dmesg(sched_mc_l
>                      if group_info.find("(") != -1:
>                          openindex=group_info.index("(")
>                          closeindex=group_info.index(")")
> -                        group_info=group_info.replace(group_info[openindex:closeindex+1],"")
> +                        group_info=group_info.replace\
> +                            (group_info[openindex:closeindex+1],"")
> 
>                      subgroup = group_info.split()
>                      for j in range(0, len(subgroup)):
> @@ -586,19 +619,20 @@ def validate_cpu_consolidation(work_ld, 
>                      if cpu_id[1] != '':
>                          cpus_utilized.append(int(cpu_id[1]))
>                  else:
> -                    if stats_percentage[l][1] > 50:
> +                    if stats_percentage[l][1] > 70:
>                          cpu_id = stats_percentage[l][0].split("cpu")
>                          if cpu_id[1] != '':
>                              cpus_utilized.append(int(cpu_id[1]))
>              else:
> -                if stats_percentage[l][1] > 50:
> +                if stats_percentage[l][1] > 70:
>                      cpu_id = stats_percentage[l][0].split("cpu")
>                      if cpu_id[1] != '':
>                          cpus_utilized.append(int(cpu_id[1]))
>                      cpus_utilized.sort()
>          print "INFO: CPU's utilized ", cpus_utilized
> 
> -        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
> +        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
> +            sched_smt_level)
>          if status == 1:
>              print "INFO: CPUs utilized is not in same package or core"
>          return(status)
> @@ -627,9 +661,9 @@ def get_cpuid_max_intr_count():
>          for i in range(1, cpu_count):
>              if i != cpu1_max_intr and i != cpu2_max_intr:
>                  diff = second_highest - intr_stop[i]
> -                ''' Threshold of difference has to be manipulated with multiple test'''
> +                ''' Threshold of difference has to be manipulated '''
>                  if diff < 10000:
> -                    print "INFO: Difference in interrupt count is below threshold"
> +                    print "INFO: Diff in interrupt count is below threshold"
>                      return 1
>          print "INFO: Interrupt count in other CPU's low as expected"
>          return 0 
> @@ -652,7 +686,7 @@ def validate_ilb (sched_mc_level, sched_
>      except Exception, details:
>          print "Exception in validate_ilb: ", details
>          sys.exit(1)
> -    
> +
>  def reset_schedmc():
>      ''' Routine to reset sched_mc_power_savings to Zero level
>      '''
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
