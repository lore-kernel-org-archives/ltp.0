Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxeNg-0004Al-Ec
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:24 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxeNa-0001JP-Iu
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:24 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DA2OlO021540
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:02:24 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DAD8n8176370
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:13:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DAD8Ys007811
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:13:08 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091013074346.22414.9377.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074346.22414.9377.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 15:42:44 +0530
Message-Id: <1255428764.8438.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 2/6] Developed new functions and fixed
	issues	causing ilb test failure
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

On Tue, 2009-10-13 at 13:13 +0530, Poornima Nayak wrote: 
> CPU Consolidation verification function is fixed to handle variations in
> CPU utilization. Threshold is selected based on test conducted on 2.6.31 on
> dual core, quad core & hyper threaded system.
> Developed new function to generate hyper threaded siblings list and get job count
> for hyper threaded system and multisocket system.
> Modified kernbench workload execution time for 5 min, hence test execution time
> will be reduced further. Developed new functions to stop workload.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090930/testcases/kernel/power_management/lib/sched_mc.py ltp-full-20090930_patched/testcases/kernel/power_management/lib/sched_mc.py
> --- ltp-full-20090930/testcases/kernel/power_management/lib/sched_mc.py	2009-10-05 02:10:56.000000000 -0400
> +++ ltp-full-20090930_patched/testcases/kernel/power_management/lib/sched_mc.py	2009-10-12 23:00:30.000000000 -0400
> @@ -22,6 +22,7 @@ socket_count = 0
>  cpu1_max_intr = 0
>  cpu2_max_intr = 0
>  intr_stat_timer_0 = []
> +siblings_list = []
> 
>  def clear_dmesg():
>      '''
> @@ -96,6 +97,36 @@ def is_hyper_threaded():
>          print "Failed to check if system is hyper-threaded"
>          sys.exit(1)
> 
> +def is_multi_core():
> +    ''' Return true if system has sockets has multiple cores
> +    '''
> +  
> +    try:
> +        file_cpuinfo = open("/proc/cpuinfo", 'r')
> +        for line in file_cpuinfo:
> +            if line.startswith('siblings'):
> +                siblings = line.split(":")
> +            if line.startswith('cpu cores'):
> +                cpu_cores = line.split(":")
> +                break
> +       
> +        if int( siblings[1] ) == int( cpu_cores[1] ): 
> +            if int( cpu_cores[1] ) > 1:
> +                multi_core = 1
> +            else:
> +                multi_core = 0
> +        else:
> +            num_of_cpus = int(siblings[1]) / int(cpu_cores[1])
> +            if num_of_cpus > 1:
> +                multi_core = 1
> +            else:
> +                multi_core = 0
> +        file_cpuinfo.close()
> +        return multi_core
> +    except Exception:
> +        print "Failed to check if system is multi core system"
> +        sys.exit(1)
> +
>  def get_hyper_thread_count():
>      ''' Return number of threads in CPU. For eg for x3950 this function
>          would return 2. In future if 4 threads are supported in CPU, this
> @@ -153,6 +184,40 @@ def map_cpuid_pkgid():
>                  sys.exit(1)
> 
> 
> +def generate_sibling_list():
> +    ''' Routine to generate siblings list
> +    '''
> +    try:
> +        for i in range(0, cpu_count):
> +            siblings_file = '/sys/devices/system/cpu/cpu%s' % i
> +            siblings_file += '/topology/thread_siblings_list'
> +            threads_sibs = open(siblings_file).read().rstrip()
> +            thread_ids = threads_sibs.split("-")
> +    
> +            if not thread_ids in siblings_list:
> +                siblings_list.append(thread_ids)
> +    except Exception, details:
> +        print "Exception in generate_siblings_list", details
> +        sys.exit(1)
> +
> +def get_siblings(cpu_id):
> +    ''' Return siblings of cpu_id
> +    '''
> +    try:
> +        cpus = ""
> +        for i in range(0, len(siblings_list)):
> +            for cpu in siblings_list[i]:
> +                if cpu_id == cpu:
> +                    for j in siblings_list[i]:
> +                        # Exclude cpu_id in the list of siblings
> +                        if j != cpu_id:
> +                            cpus += j
> +                    return cpus
> +        return cpus
> +    except Exception, details:
> +        print "Exception in get_siblings", details
> +        sys.exit(1)
> +
>  def get_proc_data(stats_list):
>      ''' Read /proc/stat info and store in dictionary
>      '''
> @@ -168,18 +233,18 @@ def get_proc_data(stats_list):
>          sys.exit(1)
> 
>  def get_proc_loc_count(loc_stats):
> -    ''' Read /proc/stat info and store in dictionary
> +    ''' Read /proc/interrupts info and store in list
>      '''
>      try:
>          file_procstat = open("/proc/interrupts", 'r')
>          for line in file_procstat:
> -            if line.startswith('LOC:'):
> +            if line.startswith(' LOC:') or line.startswith('LOC:'):
>                  data = line.split()
>                  for i in range(0, cpu_count):
>                      # To skip LOC
>                      loc_stats.append(data[i+1])
> -                    print data[i+1]
> -        file_procstat.close()
> +                file_procstat.close()
> +                return
>      except Exception, details:
>          print "Could not read interrupt statistics", details
>          sys.exit(1)
> @@ -192,6 +257,8 @@ def set_sched_mc_power(sched_mc_level):
>          os.system('echo %s > \
>              /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null'
>              % sched_mc_level)
> +
> +        get_proc_data(stats_start)
>      except OSError, e:
>          print "Could not set sched_mc_power_savings to", sched_mc_level, e
>  	sys.exit(1)
> @@ -203,6 +270,8 @@ def set_sched_smt_power(sched_smt_level)
>          os.system('echo %s > \
>              /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null'
>              % sched_smt_level)
> +
> +        get_proc_data(stats_start)
>      except OSError, e:
>          print "Could not set sched_smt_power_savings to", sched_smt_level, e
>  	sys.exit(1)
> @@ -218,21 +287,36 @@ def set_timer_migration_interface(value)
>          print "Could not set timer_migration to ", value, e
>          sys.exit(1)
> 
> -def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
> -    ''' Triggers ebizzy workload for sched_mc=1
> -        testing
> +def get_job_count(stress, workload, sched_smt):
> +    ''' Returns number of jobs/threads to be triggered
>      '''
> +    
>      try:
>          if stress == "thread":
>              threads = get_hyper_thread_count()
>          if stress == "partial":
>              threads = cpu_count / socket_count
> +            if is_hyper_threaded():
> +                if workload == "ebizzy" and int(sched_smt) ==0:
> +                    threads = threads / get_hyper_thread_count()
> +                if workload == "kernbench" and int(sched_smt) < 2:
> +                    threads = threads / get_hyper_thread_count()    
>          if stress == "full":
> -	    threads = cpu_count
> +            threads = cpu_count
>          if stress == "single_job":
>              threads = 1
>              duration = 180
> +        return threads
> +    except Exception, details:
> +        print "get job count failed ", details
> +        sys.exit(1)
> 
> +def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
> +    ''' Triggers ebizzy workload for sched_mc=1
> +        testing
> +    '''
> +    try:
> +        threads = get_job_count(stress, "ebizzy", sched_smt)
>          olddir = os.getcwd()
>          path = '%s/utils/benchmark' % os.environ['LTPROOT']
>          os.chdir(path)
> @@ -282,23 +366,14 @@ def trigger_ebizzy (sched_smt, stress, d
>          print "Ebizzy workload trigger failed ", details
>          sys.exit(1)   
> 
> -def trigger_kernbench (sched_smt, stress, background, pinned):
> +def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
>      ''' Trigger load on system like kernbench.
>          Copys existing copy of LTP into as LTP2 and then builds it
>          with make -j
>      '''
>      olddir = os.getcwd()
>      try:
> -        if stress == "thread":
> -	    threads = 2
> -        if stress == "partial":
> -	    threads = cpu_count / socket_count
> -            if is_hyper_threaded() and int(sched_smt) !=2:
> -                threads = threads / get_hyper_thread_count()
> -        if stress == "full":
> -            threads = cpu_count
> -        if stress == "single_job":
> -            threads = 1
> +        threads = get_job_count(stress, "kernbench", sched_smt)
> 
>          dst_path = "/root"
>          olddir = os.getcwd()      
> @@ -335,24 +410,35 @@ def trigger_kernbench (sched_smt, stress
>          get_proc_loc_count(intr_start)
>          if pinned == "yes":
>              os.system ( 'taskset -c %s %s/kernbench -o %s -M -H -n 1 \
> -                >/dev/null 2>&1' % (cpu_count-1, benchmark_path, threads))
> +                >/dev/null 2>&1 &' % (cpu_count-1, benchmark_path, threads))
> +
> +            # We have to delete import in future
> +            import time
> +            time.sleep(240)
> +            stop_wkld("kernbench")
>          else:
>              if background == "yes":
>                  os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
>                      % (benchmark_path, threads))
>              else:
> -                os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
> -                    % (benchmark_path, threads))
> +                if perf_test == "yes":
> +                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1' \
> +                        % (benchmark_path, threads))
> +                else:
> +                    os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>&1 &' \
> +                        % (benchmark_path, threads))
> +                    # We have to delete import in future
> +                    import time
> +                    time.sleep(240)
> +                    stop_wkld("kernbench")
>          
>          print "INFO: Workload kernbench triggerd"
>          os.chdir(olddir)
> -        #get_proc_data(stats_stop)
> -        #get_proc_loc_count(intr_stop)
>      except Exception, details:
>          print "Workload kernbench trigger failed ", details
>          sys.exit(1)
>     
> -def trigger_workld(sched_smt, workload, stress, duration, background, pinned):
> +def trigger_workld(sched_smt, workload, stress, duration, background, pinned, perf_test):
>      ''' Triggers workload passed as argument. Number of threads 
>          triggered is based on stress value.
>      '''
> @@ -360,7 +446,7 @@ def trigger_workld(sched_smt, workload, 
>          if workload == "ebizzy":
>              trigger_ebizzy (sched_smt, stress, duration, background, pinned)
>          if workload == "kernbench":
> -            trigger_kernbench (sched_smt, stress, background, pinned)
> +            trigger_kernbench (sched_smt, stress, background, pinned, perf_test)
>      except Exception, details:
>          print "INFO: Trigger workload failed", details
>          sys.exit(1)
> @@ -434,7 +520,7 @@ def generate_report():
>              print >> keyvalfile, "package-%s=%3.4f" % \
>  		(pkg, (float(total_idle)*100/total))
>      except Exception, details:
> -        print "Generating reportfile failed: ", details
> +        print "Generating utilization report failed: ", details
>          sys.exit(1)
> 
>      #Add record delimiter '\n' before closing these files
> @@ -454,20 +540,18 @@ def generate_loc_intr_report():
> 
>          get_proc_loc_count(intr_stop)
> 
> -        print "Before substracting"
> -        for i in range(0, cpu_count):
> -            print "CPU",i, intr_start[i], intr_stop[i]
> -            reportfile = open('/procstat/cpu-loc_interrupts', 'a')
> -            print >> reportfile, "=============================================="
> -            print >> reportfile, "     Local timer interrupt stats              "
> -            print >> reportfile, "=============================================="
> +        reportfile = open('/procstat/cpu-loc_interrupts', 'a')
> +        print >> reportfile, "=============================================="
> +        print >> reportfile, "     Local timer interrupt stats              "
> +        print >> reportfile, "=============================================="
> +
>          for i in range(0, cpu_count):
>              intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
>              print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
>          print >> reportfile
>          reportfile.close()
>      except Exception, details:
> -        print "Generating reportfile failed: ", details
> +        print "Generating interrupt report failed: ", details
>          sys.exit(1)
> 
>  def record_loc_intr_count():
> @@ -542,25 +626,24 @@ def validate_cpugrp_map(cpu_group, sched
>                                  modi_cpu_grp.remove(core_cpus[i]) 
>                                  if len(modi_cpu_grp) == 0:
>                                      return 0
> -                            else:
> +                            #This code has to be deleted 
> +                            #else:
>                                  # If sched_smt == 0 then its oky if threads run
>                                  # in different cores of same package 
> -                                if sched_smt_level == 1:
> -                                    sys.exit(1)
> -                                else:
> -                                    if len(cpu_group) == 2 and \
> -                                        len(modi_cpu_grp) < len(cpu_group):
> -                                        print "INFO:CPUs utilized not in a core"
> -                                        return 1                                        
> -            print "INFO: CPUs utilized is not in same package or core"
> -            return(1)
> +                                #if sched_smt_level > 0 :
> +                                    #return 1
>  	else:
>              for pkg in sorted(cpu_map.keys()):
>                  pkg_cpus = cpu_map[pkg]
> -                if pkg_cpus == cpu_group:
> -                    return(0)
> -                 
> -            return(1) 
> +                if len(cpu_group) == len(pkg_cpus):
> +                    if pkg_cpus == cpu_group:
> +                        return(0)
> +                else:
> +                    if int(cpus_utilized[0]) in cpu_map[pkg] or int(cpus_utilized[1]) in cpu_map[pkg]:
> +                        return(0)
> +
> +        return(1) 
> +
>      except Exception, details:
>          print "Exception in validate_cpugrp_map: ", details
>          sys.exit(1)
> @@ -605,36 +688,70 @@ def verify_sched_domain_dmesg(sched_mc_l
>          print "Reading dmesg failed", details
>          sys.exit(1)
> 
> -def validate_cpu_consolidation(work_ld, sched_mc_level, sched_smt_level):
> +def get_cpu_utilization(cpu):
> +    ''' Return cpu utilization of cpu_id
> +    '''
> +    try:
> +        for l in sorted(stats_percentage.keys()):
> +            if cpu == stats_percentage[l][0]:
> +                return stats_percentage[l][1]
> +        return -1
> +    except Exception, details:
> +        print "Exception in get_cpu_utilization", details
> +        sys.exit(1)
> +
> +def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level):
>      ''' Verify if cpu's on which threads executed belong to same
>      package
>      '''
>      cpus_utilized = list()
> +    threads = get_job_count(stress, work_ld, sched_smt_level)
>      try:
>          for l in sorted(stats_percentage.keys()):
>              #modify threshold
> +            cpu_id = stats_percentage[l][0].split("cpu")
> +            if cpu_id[1] == '':
> +                continue
> +            if int(cpu_id[1]) in cpus_utilized:
> +                continue
>              if is_hyper_threaded():
> -                if stats_percentage[l][1] > 25 and work_ld == "kernbench":
> -                    cpu_id = stats_percentage[l][0].split("cpu")
> -                    if cpu_id[1] != '':
> +                if work_ld == "kernbench" and sched_smt_level < sched_mc_level:
> +                    siblings = get_siblings(cpu_id[1])
> +                    if siblings != "":
> +                        sib_list = siblings.split()
> +                        utilization = int(stats_percentage[l][1])
> +                        for i in range(0, len(sib_list)):
> +                            utilization += int(get_cpu_utilization("cpu%s" %sib_list[i])) 
> +                    else:
> +                        utilization = stats_percentage[l][1]
> +                    if utilization > 40:
>                          cpus_utilized.append(int(cpu_id[1]))
> +                        if siblings != "":
> +                            for i in range(0, len(sib_list)):
> +                                cpus_utilized.append(int(sib_list[i]))
>                  else:
> -                    if stats_percentage[l][1] > 70:
> -                        cpu_id = stats_percentage[l][0].split("cpu")
> -                        if cpu_id[1] != '':
> -                            cpus_utilized.append(int(cpu_id[1]))
> +                    # This threshold wuld be modified based on results
> +                    if stats_percentage[l][1] > 40:
> +                        cpus_utilized.append(int(cpu_id[1]))
>              else:
> -                if stats_percentage[l][1] > 70:
> -                    cpu_id = stats_percentage[l][0].split("cpu")
> -                    if cpu_id[1] != '':
> +                if work_ld == "kernbench" :
> +                    if stats_percentage[l][1] > 50:
>                          cpus_utilized.append(int(cpu_id[1]))
> -                    cpus_utilized.sort()
> +                else:
> +                    if stats_percentage[l][1] > 70:
> +                        cpus_utilized.append(int(cpu_id[1]))
> +            cpus_utilized.sort()
>          print "INFO: CPU's utilized ", cpus_utilized
> 
> +        # If length of CPU's utilized is not = number of jobs exit with 1
> +        if len(cpus_utilized) < threads:
> +            return 1
> +
>          status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
>              sched_smt_level)
>          if status == 1:
>              print "INFO: CPUs utilized is not in same package or core"
> +
>          return(status)
>      except Exception, details:
>          print "Exception in validate_cpu_consolidation: ", details
> @@ -645,7 +762,8 @@ def get_cpuid_max_intr_count():
>      try:
>          highest = 0
>          second_highest = 0
> -        global cpu1_max_intr, cpu2_max_intr
> +        cpus_utilized = []
> +        
>          #Skipping CPU0 as it is generally high
>          for i in range(1, cpu_count):
>              if int(intr_stop[i]) > int(highest):
> @@ -658,15 +776,19 @@ def get_cpuid_max_intr_count():
>                  if int(intr_stop[i]) > int(second_highest):
>                      second_highest = int(intr_stop[i])
>                      cpu2_max_intr = i
> +        cpus_utilized.append(cpu1_max_intr)
> +        cpus_utilized.append(cpu2_max_intr)
> +        
>          for i in range(1, cpu_count):
>              if i != cpu1_max_intr and i != cpu2_max_intr:
>                  diff = second_highest - intr_stop[i]
>                  ''' Threshold of difference has to be manipulated '''
>                  if diff < 10000:
>                      print "INFO: Diff in interrupt count is below threshold"
> -                    return 1
> +                    cpus_utilized = []
> +                    return cpus_utilized
>          print "INFO: Interrupt count in other CPU's low as expected"
> -        return 0 
> +        return cpus_utilized
>      except Exception, details:
>          print "Exception in get_cpuid_max_intr_count: ", details
>          sys.exit(1)
> @@ -675,14 +797,12 @@ def validate_ilb (sched_mc_level, sched_
>      ''' Validate if ilb is running in same package where work load is running
>      '''
>      try:
> -        status = get_cpuid_max_intr_count()
> -        if status == 1:
> +        cpus_utilized = get_cpuid_max_intr_count()
> +        if not cpus_utilized:
>              return 1
> -        for pkg in sorted(cpu_map.keys()):
> -            if cpu1_max_intr in cpu_map[pkg] and cpu2_max_intr in cpu_map[pkg]:
> -                return 0
> -        print "INFO: CPUs with higher interrupt count is not in same package"
> -        return 1
> +       
> +        status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
> +        return status
>      except Exception, details:
>          print "Exception in validate_ilb: ", details
>          sys.exit(1)
> @@ -706,3 +826,14 @@ def reset_schedsmt():
>      except OSError, e:
>          print "Could not set sched_smt_power_savings to 0", e
>          sys.exit(1)
> +
> +def stop_wkld(work_ld):
> +    ''' Kill workload triggered in background
> +    '''
> +    try:
> +        os.system('pkill %s 2>/dev/null' %work_ld)
> +        if work_ld == "kernbench":
> +            os.system('pkill make 2>/dev/null')
> +    except OSError, e:
> +        print "Exception in stop_wkld", e
> +        sys.exit(1)
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
