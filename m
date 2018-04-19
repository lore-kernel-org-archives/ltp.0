From: Yong Sun <yosun@suse.com>
Date: Thu, 19 Apr 2018 18:10:38 +0800
Subject: [LTP] [PATCH] *.py : convert python2 to python3
Message-ID: <20180419101038.22451-1-yosun@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: yosun <yosun@suse.com>

Convert python code to use python3.

Signed-off-by: Yong Sun <yosun@suse.com>
---
 .../kernel/power_management/lib/pm_sched_mc.py     | 210 ++++++++++-----------
 .../power_management/pm_cpu_consolidation.py       |  12 +-
 testcases/kernel/power_management/pm_ilb_test.py   |   6 +-
 .../kernel/power_management/pm_sched_domain.py     |   6 +-
 testcases/network/nfsv4/acl/cleangroups.py         |   2 +-
 testcases/network/nfsv4/acl/cleanusers.py          |   2 +-
 testcases/network/nfsv4/acl/random_gen.py          |  30 +--
 testcases/network/nfsv4/acl/setacl_stress.py       |   2 +-
 testcases/network/nfsv4/acl/test_long_acl.py       |  16 +-
 testcases/network/nfsv4/locks/locktests.py         |  56 +++---
 testcases/realtime/scripts/parser.py               |   2 +-
 testcases/realtime/tools/ftqviz.py                 |  12 +-
 testscripts/build/ltp-missing-install-files.py     |   4 +-
 tools/pounder21/src/time_tests/drift-test.py       |  14 +-
 14 files changed, 187 insertions(+), 187 deletions(-)

diff --git a/testcases/kernel/power_management/lib/pm_sched_mc.py b/testcases/kernel/power_management/lib/pm_sched_mc.py
index feb4b24d3..92a6dd5c4 100755
--- a/testcases/kernel/power_management/lib/pm_sched_mc.py
+++ b/testcases/kernel/power_management/lib/pm_sched_mc.py
@@ -30,8 +30,8 @@ def clear_dmesg():
     '''
     try:
         os.system('dmesg -c >/dev/null')
-    except OSError, e:
-        print 'Clearing dmesg failed', e
+    except OSError as e:
+        print('Clearing dmesg failed', e)
         sys.exit(1)
 
 def count_num_cpu():
@@ -44,8 +44,8 @@ def count_num_cpu():
             if line.startswith('processor'):
                 cpu_count += 1
         cpuinfo.close()
-    except IOError, e:
-        print "Could not get cpu count", e
+    except IOError as e:
+        print("Could not get cpu count", e)
         sys.exit(1)
 
 def count_num_sockets():
@@ -61,8 +61,8 @@ def count_num_sockets():
             if socket_id not in socket_list:
                 socket_list.append(socket_id)
                 socket_count = socket_count + 1
-    except Exception, details:
-        print "INFO: Failed to get number of sockets in system", details
+    except Exception as details:
+        print("INFO: Failed to get number of sockets in system", details)
         sys.exit(1)
 
 def is_multi_socket():
@@ -74,7 +74,7 @@ def is_multi_socket():
         else:
             return 0
     except Exception:
-        print "Failed to check if system is multi socket system"
+        print("Failed to check if system is multi socket system")
         sys.exit(1)
 
 def is_hyper_threaded():
@@ -94,7 +94,7 @@ def is_hyper_threaded():
         else:
             return 0
     except Exception:
-        print "Failed to check if system is hyper-threaded"
+        print("Failed to check if system is hyper-threaded")
         sys.exit(1)
 
 def is_multi_core():
@@ -124,7 +124,7 @@ def is_multi_core():
         file_cpuinfo.close()
         return multi_core
     except Exception:
-        print "Failed to check if system is multi core system"
+        print("Failed to check if system is multi core system")
         sys.exit(1)
 
 def get_hyper_thread_count():
@@ -142,7 +142,7 @@ def get_hyper_thread_count():
                 break
         return( int( siblings[1] ) / int( cpu_cores[1] ) )
     except Exception:
-        print "Failed to check if system is hyper-threaded"
+        print("Failed to check if system is hyper-threaded")
         sys.exit(1)
 
 def map_cpuid_pkgid():
@@ -158,17 +158,17 @@ def map_cpuid_pkgid():
                 core_file += '/topology/core_id'
                 core_id = open(core_file).read().rstrip()
                 cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in cpu_map.keys():
+                if not cpu_phy_id in list(cpu_map.keys()):
                     core_info = {}
                 else:
                     core_info = cpu_map[cpu_phy_id]
-                if not core_id in core_info.keys():
+                if not core_id in list(core_info.keys()):
                     core_info[core_id] = [i]
                 else:
                     core_info[core_id].append(i)
                 cpu_map[cpu_phy_id] = core_info
-        except Exception, details:
-            print "Package, core & cpu map table creation failed", e
+        except Exception as details:
+            print("Package, core & cpu map table creation failed", e)
             sys.exit(1)
     else:
         for i in range(0, cpu_count):
@@ -176,12 +176,12 @@ def map_cpuid_pkgid():
                 phy_pkg_file = '/sys/devices/system/cpu/cpu%s' %i
                 phy_pkg_file += '/topology/physical_package_id'
                 cpu_phy_id = open(phy_pkg_file).read().rstrip()
-                if not cpu_phy_id in cpu_map.keys():
+                if not cpu_phy_id in list(cpu_map.keys()):
                     cpu_map[cpu_phy_id] = [i]
                 else:
                     cpu_map[cpu_phy_id].append(i)
-            except IOError, e:
-                print "Mapping of CPU to pkg id failed", e
+            except IOError as e:
+                print("Mapping of CPU to pkg id failed", e)
                 sys.exit(1)
 
 
@@ -197,8 +197,8 @@ def generate_sibling_list():
 
             if not thread_ids in siblings_list:
                 siblings_list.append(thread_ids)
-    except Exception, details:
-        print "Exception in generate_siblings_list", details
+    except Exception as details:
+        print("Exception in generate_siblings_list", details)
         sys.exit(1)
 
 def get_siblings(cpu_id):
@@ -215,8 +215,8 @@ def get_siblings(cpu_id):
                             cpus += j
                     return cpus
         return cpus
-    except Exception, details:
-        print "Exception in get_siblings", details
+    except Exception as details:
+        print("Exception in get_siblings", details)
         sys.exit(1)
 
 def get_proc_data(stats_list):
@@ -229,8 +229,8 @@ def get_proc_data(stats_list):
                 data = line.split()
                 stats_list[data[0]] = data
         file_procstat.close()
-    except OSError, e:
-        print "Could not read statistics", e
+    except OSError as e:
+        print("Could not read statistics", e)
         sys.exit(1)
 
 def get_proc_loc_count(loc_stats):
@@ -246,8 +246,8 @@ def get_proc_loc_count(loc_stats):
                     loc_stats.append(data[i+1])
                 file_procstat.close()
                 return
-    except Exception, details:
-        print "Could not read interrupt statistics", details
+    except Exception as details:
+        print("Could not read interrupt statistics", details)
         sys.exit(1)
 
 
@@ -260,8 +260,8 @@ def set_sched_mc_power(sched_mc_level):
             % sched_mc_level)
 
         get_proc_data(stats_start)
-    except OSError, e:
-        print "Could not set sched_mc_power_savings to", sched_mc_level, e
+    except OSError as e:
+        print("Could not set sched_mc_power_savings to", sched_mc_level, e)
 	sys.exit(1)
 
 def set_sched_smt_power(sched_smt_level):
@@ -273,8 +273,8 @@ def set_sched_smt_power(sched_smt_level):
             % sched_smt_level)
 
         get_proc_data(stats_start)
-    except OSError, e:
-        print "Could not set sched_smt_power_savings to", sched_smt_level, e
+    except OSError as e:
+        print("Could not set sched_smt_power_savings to", sched_smt_level, e)
 	sys.exit(1)
 
 def set_timer_migration_interface(value):
@@ -284,8 +284,8 @@ def set_timer_migration_interface(value):
     try:
         os.system('echo %s > \
             /proc/sys/kernel/timer_migration 2>/dev/null' % value)
-    except OSError, e:
-        print "Could not set timer_migration to ", value, e
+    except OSError as e:
+        print("Could not set timer_migration to ", value, e)
         sys.exit(1)
 
 def get_job_count(stress, workload, sched_smt):
@@ -308,8 +308,8 @@ def get_job_count(stress, workload, sched_smt):
             threads = 1
             duration = 180
         return threads
-    except Exception, details:
-        print "get job count failed ", details
+    except Exception as details:
+        print("get job count failed ", details)
         sys.exit(1)
 
 def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
@@ -328,7 +328,7 @@ def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
                 workload_file = file_name
                 break
         if workload_file == "":
-            print "INFO: ebizzy benchmark not found"
+            print("INFO: ebizzy benchmark not found")
             os.chdir(olddir)
             sys.exit(1)
         get_proc_data(stats_start)
@@ -346,21 +346,21 @@ def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
                         % (threads, duration))
 
             if succ == 0:
-                print "INFO: ebizzy workload triggerd"
+                print("INFO: ebizzy workload triggerd")
                 os.chdir(olddir)
                 #Commented bcoz it doesnt make sense to capture it when workload triggered
                 #in background
                 #get_proc_loc_count(intr_stop)
                 #get_proc_data(stats_stop)
             else:
-                print "INFO: ebizzy workload triggerd failed"
+                print("INFO: ebizzy workload triggerd failed")
                 os.chdir(olddir)
                 sys.exit(1)
-        except Exception, details:
-            print "Ebizzy workload trigger failed ", details
+        except Exception as details:
+            print("Ebizzy workload trigger failed ", details)
             sys.exit(1)
-    except Exception, details:
-        print "Ebizzy workload trigger failed ", details
+    except Exception as details:
+        print("Ebizzy workload trigger failed ", details)
         sys.exit(1)
 
 def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
@@ -385,7 +385,7 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
         if workload_file != "":
             benchmark_path = path
         else:
-            print "INFO: kernbench benchmark not found"
+            print("INFO: kernbench benchmark not found")
             os.chdir(olddir)
             sys.exit(1)
 
@@ -398,8 +398,8 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
         if linux_source_dir != "":
             os.chdir(linux_source_dir)
         else:
-            print "INFO: Linux kernel source not found in /root. Workload\
-               Kernbench cannot be executed"
+            print("INFO: Linux kernel source not found in /root. Workload\
+               Kernbench cannot be executed")
             sys.exit(1)
 
         get_proc_data(stats_start)
@@ -428,10 +428,10 @@ def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
                     time.sleep(240)
                     stop_wkld("kernbench")
 
-        print "INFO: Workload kernbench triggerd"
+        print("INFO: Workload kernbench triggerd")
         os.chdir(olddir)
-    except Exception, details:
-        print "Workload kernbench trigger failed ", details
+    except Exception as details:
+        print("Workload kernbench trigger failed ", details)
         sys.exit(1)
 
 def trigger_workld(sched_smt, workload, stress, duration, background, pinned, perf_test):
@@ -443,8 +443,8 @@ def trigger_workld(sched_smt, workload, stress, duration, background, pinned, pe
             trigger_ebizzy (sched_smt, stress, duration, background, pinned)
         if workload == "kernbench":
             trigger_kernbench (sched_smt, stress, background, pinned, perf_test)
-    except Exception, details:
-        print "INFO: Trigger workload failed", details
+    except Exception as details:
+        print("INFO: Trigger workload failed", details)
         sys.exit(1)
 
 def generate_report():
@@ -472,29 +472,29 @@ def generate_report():
         stats_percentage[l] = percentage_list
 
     for i in range(0, len(cpu_labels)):
-        print >> debugfile, cpu_labels[i], '\t',
-    print >> debugfile
+        print(cpu_labels[i], '\t', end=' ', file=debugfile)
+    print(file=debugfile)
     for l in sorted(stats_stop.keys()):
-        print >> debugfile, l, '\t',
+        print(l, '\t', end=' ', file=debugfile)
         for i in range(1, len(stats_stop[l])):
-            print >> debugfile, stats_stop[l][i], '\t',
-        print >> debugfile
+            print(stats_stop[l][i], '\t', end=' ', file=debugfile)
+        print(file=debugfile)
 
     for i in range(0, len(cpu_labels)):
-        print >> reportfile, cpu_labels[i], '\t',
-    print >> reportfile
+        print(cpu_labels[i], '\t', end=' ', file=reportfile)
+    print(file=reportfile)
     for l in sorted(stats_percentage.keys()):
-        print >> reportfile, l, '\t',
+        print(l, '\t', end=' ', file=reportfile)
         for i in range(1, len(stats_percentage[l])):
-            print >> reportfile, " %3.4f" % stats_percentage[l][i],
-        print >> reportfile
+            print(" %3.4f" % stats_percentage[l][i], end=' ', file=reportfile)
+        print(file=reportfile)
 
     #Now get the package ID information
     try:
-        print >> debugfile, "cpu_map: ", cpu_map
+        print("cpu_map: ", cpu_map, file=debugfile)
         keyvalfile = open('/procstat/keyval', 'a')
-        print >> keyvalfile, "nr_packages=%d" % len(cpu_map)
-        print >> keyvalfile, "system-idle=%3.4f" % (stats_percentage['cpu'][4])
+        print("nr_packages=%d" % len(cpu_map), file=keyvalfile)
+        print("system-idle=%3.4f" % (stats_percentage['cpu'][4]), file=keyvalfile)
         for pkg in sorted(cpu_map.keys()):
             if is_hyper_threaded():
                 for core in sorted(cpu_map[pkg].keys()):
@@ -511,20 +511,20 @@ def generate_report():
                     total_idle += stats_stop["cpu%d" % cpu][4]
                     for i in range(1, len(stats_stop["cpu%d" % cpu])):
                         total += stats_stop["cpu%d" % cpu][i]
-            print >> reportfile, "Package: ", pkg, "Idle %3.4f%%" \
-	        % (float(total_idle)*100/total)
-            print >> keyvalfile, "package-%s=%3.4f" % \
-		(pkg, (float(total_idle)*100/total))
-    except Exception, details:
-        print "Generating utilization report failed: ", details
+            print("Package: ", pkg, "Idle %3.4f%%" \
+	        % (float(total_idle)*100/total), file=reportfile)
+            print("package-%s=%3.4f" % \
+		(pkg, (float(total_idle)*100/total)), file=keyvalfile)
+    except Exception as details:
+        print("Generating utilization report failed: ", details)
         sys.exit(1)
 
     #Add record delimiter '\n' before closing these files
-    print >> debugfile
+    print(file=debugfile)
     debugfile.close()
-    print >> reportfile
+    print(file=reportfile)
     reportfile.close()
-    print >> keyvalfile
+    print(file=keyvalfile)
     keyvalfile.close()
 
 def generate_loc_intr_report():
@@ -537,17 +537,17 @@ def generate_loc_intr_report():
         get_proc_loc_count(intr_stop)
 
         reportfile = open('/procstat/cpu-loc_interrupts', 'a')
-        print >> reportfile, "=============================================="
-        print >> reportfile, "     Local timer interrupt stats              "
-        print >> reportfile, "=============================================="
+        print("==============================================", file=reportfile)
+        print("     Local timer interrupt stats              ", file=reportfile)
+        print("==============================================", file=reportfile)
 
         for i in range(0, cpu_count):
             intr_stop[i] =  int(intr_stop[i]) - int(intr_start[i])
-            print >> reportfile, "CPU%s: %s" %(i, intr_stop[i])
-        print >> reportfile
+            print("CPU%s: %s" %(i, intr_stop[i]), file=reportfile)
+        print(file=reportfile)
         reportfile.close()
-    except Exception, details:
-        print "Generating interrupt report failed: ", details
+    except Exception as details:
+        print("Generating interrupt report failed: ", details)
         sys.exit(1)
 
 def record_loc_intr_count():
@@ -560,8 +560,8 @@ def record_loc_intr_count():
             intr_stat_timer_0.append(intr_stop[i])
         intr_start = []
         intr_stop = []
-    except Exception, details:
-        print "INFO: Record interrupt statistics when timer_migration=0",details
+    except Exception as details:
+        print("INFO: Record interrupt statistics when timer_migration=0",details)
 
 def expand_range(range_val):
     '''
@@ -578,8 +578,8 @@ def expand_range(range_val):
                 for j in range(int(hyphen_values[0]), int(hyphen_values[1])+1):
                     ids_list.append(j)
         return(ids_list)
-    except Exception, details:
-        print "INFO: expand_pkg_grps failed ", details
+    except Exception as details:
+        print("INFO: expand_pkg_grps failed ", details)
 
 def is_quad_core():
     '''
@@ -596,8 +596,8 @@ def is_quad_core():
                     return(1)
                 else:
                     return(0)
-    except IOError, e:
-        print "Failed to get cpu core information", e
+    except IOError as e:
+        print("Failed to get cpu core information", e)
         sys.exit(1)
 
 def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
@@ -640,8 +640,8 @@ def validate_cpugrp_map(cpu_group, sched_mc_level, sched_smt_level):
 
         return(1)
 
-    except Exception, details:
-        print "Exception in validate_cpugrp_map: ", details
+    except Exception as details:
+        print("Exception in validate_cpugrp_map: ", details)
         sys.exit(1)
 
 
@@ -680,8 +680,8 @@ def verify_sched_domain_dmesg(sched_mc_level, sched_smt_level):
             return(0)
         else:
             return(1)
-    except Exception, details:
-        print "Reading dmesg failed", details
+    except Exception as details:
+        print("Reading dmesg failed", details)
         sys.exit(1)
 
 def get_cpu_utilization(cpu):
@@ -692,8 +692,8 @@ def get_cpu_utilization(cpu):
             if cpu == stats_percentage[l][0]:
                 return stats_percentage[l][1]
         return -1
-    except Exception, details:
-        print "Exception in get_cpu_utilization", details
+    except Exception as details:
+        print("Exception in get_cpu_utilization", details)
         sys.exit(1)
 
 def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level):
@@ -737,7 +737,7 @@ def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level)
                     if stats_percentage[l][1] > 70:
                         cpus_utilized.append(int(cpu_id[1]))
             cpus_utilized.sort()
-        print "INFO: CPU's utilized ", cpus_utilized
+        print("INFO: CPU's utilized ", cpus_utilized)
 
         # If length of CPU's utilized is not = number of jobs exit with 1
         if len(cpus_utilized) < threads:
@@ -746,11 +746,11 @@ def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_smt_level)
         status = validate_cpugrp_map(cpus_utilized, sched_mc_level, \
             sched_smt_level)
         if status == 1:
-            print "INFO: CPUs utilized is not in same package or core"
+            print("INFO: CPUs utilized is not in same package or core")
 
         return(status)
-    except Exception, details:
-        print "Exception in validate_cpu_consolidation: ", details
+    except Exception as details:
+        print("Exception in validate_cpu_consolidation: ", details)
         sys.exit(1)
 
 def get_cpuid_max_intr_count():
@@ -780,13 +780,13 @@ def get_cpuid_max_intr_count():
                 diff = second_highest - intr_stop[i]
                 ''' Threshold of difference has to be manipulated '''
                 if diff < 10000:
-                    print "INFO: Diff in interrupt count is below threshold"
+                    print("INFO: Diff in interrupt count is below threshold")
                     cpus_utilized = []
                     return cpus_utilized
-        print "INFO: Interrupt count in other CPU's low as expected"
+        print("INFO: Interrupt count in other CPU's low as expected")
         return cpus_utilized
-    except Exception, details:
-        print "Exception in get_cpuid_max_intr_count: ", details
+    except Exception as details:
+        print("Exception in get_cpuid_max_intr_count: ", details)
         sys.exit(1)
 
 def validate_ilb (sched_mc_level, sched_smt_level):
@@ -799,8 +799,8 @@ def validate_ilb (sched_mc_level, sched_smt_level):
 
         status = validate_cpugrp_map(cpus_utilized, sched_mc_level, sched_smt_level)
         return status
-    except Exception, details:
-        print "Exception in validate_ilb: ", details
+    except Exception as details:
+        print("Exception in validate_ilb: ", details)
         sys.exit(1)
 
 def reset_schedmc():
@@ -809,8 +809,8 @@ def reset_schedmc():
     try:
         os.system('echo 0 > \
             /sys/devices/system/cpu/sched_mc_power_savings 2>/dev/null')
-    except OSError, e:
-        print "Could not set sched_mc_power_savings to 0", e
+    except OSError as e:
+        print("Could not set sched_mc_power_savings to 0", e)
         sys.exit(1)
 
 def reset_schedsmt():
@@ -819,8 +819,8 @@ def reset_schedsmt():
     try:
         os.system('echo 0 > \
             /sys/devices/system/cpu/sched_smt_power_savings 2>/dev/null')
-    except OSError, e:
-        print "Could not set sched_smt_power_savings to 0", e
+    except OSError as e:
+        print("Could not set sched_smt_power_savings to 0", e)
         sys.exit(1)
 
 def stop_wkld(work_ld):
@@ -830,6 +830,6 @@ def stop_wkld(work_ld):
         os.system('pkill %s 2>/dev/null' %work_ld)
         if work_ld == "kernbench":
             os.system('pkill make 2>/dev/null')
-    except OSError, e:
-        print "Exception in stop_wkld", e
+    except OSError as e:
+        print("Exception in stop_wkld", e)
         sys.exit(1)
diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
index 734db2759..0a1772806 100755
--- a/testcases/kernel/power_management/pm_cpu_consolidation.py
+++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
@@ -79,7 +79,7 @@ def main(argv=None):
             generate_report()
             status = validate_cpu_consolidation("partial", work_ld, options.mc_value, options.smt_value)
             if status == 0:
-                print "INFO: Consolidation worked sched_smt &(/) sched_mc is set"
+                print("INFO: Consolidation worked sched_smt &(/) sched_mc is set")
                 #Disable sched_smt & sched_mc interface values
                 if options.vary_mc_smt and options.mc_value > 0:
                     set_sched_mc_power(0)
@@ -107,8 +107,8 @@ def main(argv=None):
                 else:
                     return(1)
             else:
-                print "INFO: CPU consolidation failed when sched_mc &(/) \
-sched_smt was enabled. This is pre-requisite to proceed"
+                print("INFO: CPU consolidation failed when sched_mc &(/) \
+sched_smt was enabled. This is pre-requisite to proceed")
                 return(status)
         else:
             #The else part of the code validates behaviour of sched_mc
@@ -118,7 +118,7 @@ sched_smt was enabled. This is pre-requisite to proceed"
             if is_hyper_threaded():
                 set_sched_smt_power(options.smt_value)
             map_cpuid_pkgid()
-            print "INFO: Created table mapping cpu to package"
+            print("INFO: Created table mapping cpu to package")
             background="no"
             duration=60
             pinned ="no"
@@ -135,8 +135,8 @@ sched_smt was enabled. This is pre-requisite to proceed"
             if is_hyper_threaded():
                 reset_schedsmt()
             return(status)
-    except Exception, details:
-        print "INFO: CPU consolidation failed", details
+    except Exception as details:
+        print("INFO: CPU consolidation failed", details)
         return(1)
 
 if __name__ == "__main__":
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
index 0b447d804..749c0273e 100755
--- a/testcases/kernel/power_management/pm_ilb_test.py
+++ b/testcases/kernel/power_management/pm_ilb_test.py
@@ -36,7 +36,7 @@ def main(argv=None):
         if is_hyper_threaded():
             set_sched_smt_power(options.smt_level)
         map_cpuid_pkgid()
-        print "INFO: Created table mapping cpu to package"
+        print("INFO: Created table mapping cpu to package")
         background="no"
         duration=120
         pinned="yes"
@@ -49,8 +49,8 @@ def main(argv=None):
             reset_schedsmt()
         return(status)
 
-    except Exception, details:
-        print "INFO: Idle Load Balancer test failed", details
+    except Exception as details:
+        print("INFO: Idle Load Balancer test failed", details)
         return(1)
 
 if __name__ == "__main__":
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
index a54b0e9be..f6fd5ae99 100755
--- a/testcases/kernel/power_management/pm_sched_domain.py
+++ b/testcases/kernel/power_management/pm_sched_domain.py
@@ -43,10 +43,10 @@ def main(argv=None):
                 reset_schedsmt()
                 return(status)
         else:
-            print "INFO: Invalid arguments given"
+            print("INFO: Invalid arguments given")
             return 1
-    except Exception, details:
-        print "INFO: sched domain test failed: ", details
+    except Exception as details:
+        print("INFO: sched domain test failed: ", details)
         return(1)
 
 # Run test based on the command line arguments
diff --git a/testcases/network/nfsv4/acl/cleangroups.py b/testcases/network/nfsv4/acl/cleangroups.py
index 341746e83..fbf5dcbf7 100755
--- a/testcases/network/nfsv4/acl/cleangroups.py
+++ b/testcases/network/nfsv4/acl/cleangroups.py
@@ -1,6 +1,6 @@
 from random_gen import *
 from optparse import OptionParser
-import commands
+import subprocess
 import os
 import random
 
diff --git a/testcases/network/nfsv4/acl/cleanusers.py b/testcases/network/nfsv4/acl/cleanusers.py
index 7ac435087..ef9088449 100755
--- a/testcases/network/nfsv4/acl/cleanusers.py
+++ b/testcases/network/nfsv4/acl/cleanusers.py
@@ -1,6 +1,6 @@
 from random_gen import *
 from optparse import OptionParser
-import commands
+import subprocess
 import os
 import random
 
diff --git a/testcases/network/nfsv4/acl/random_gen.py b/testcases/network/nfsv4/acl/random_gen.py
index d39dbb3db..dcf63860a 100755
--- a/testcases/network/nfsv4/acl/random_gen.py
+++ b/testcases/network/nfsv4/acl/random_gen.py
@@ -1,4 +1,4 @@
-import commands
+import subprocess
 import random
 import re
 
@@ -30,20 +30,20 @@ class RandomGen(object):
 	def createUser(self,username):
 		group = self.gList[random.randint(0,len(self.gList)-1)][0]
 		opts = "-g" + group + " -p" + "1pilot" + " -m " + username
-		u = commands.getoutput('/usr/sbin/useradd '+ opts)
+		u = subprocess.getoutput('/usr/sbin/useradd '+ opts)
 		if u != "":
-			print "create user " + username + "failed" + u
+			print("create user " + username + "failed" + u)
 
 	def createFile(self,path,n):
 		for i in range(n):
 			fName = 'file' + str(i)
-			u = commands.getoutput('touch ' + path + '/'+ fName)
+			u = subprocess.getoutput('touch ' + path + '/'+ fName)
 			self.fList.append(fName)
 
 	def createGroup(self, grpname, gid):
-		u = commands.getoutput('/usr/sbin/groupadd -g' + gid + " " + grpname)
+		u = subprocess.getoutput('/usr/sbin/groupadd -g' + gid + " " + grpname)
 		if u != "":
-			print u
+			print(u)
 
 	def createNGroup(self, n):
 		for i in range(n):
@@ -61,13 +61,13 @@ class RandomGen(object):
 	""" clean all users created to do the tests """
 	def cleanUsers(self):
 		for name in self.uList:
-			u = commands.getoutput('/usr/sbin/userdel -r '+ name)
+			u = subprocess.getoutput('/usr/sbin/userdel -r '+ name)
 		self.uList = []
 
 	""" clean all users created to do the tests """
 	def cleanGroups(self):
 		for name in self.gList:
-			u = commands.getoutput('/usr/sbin/groupdel '+ name[0])
+			u = subprocess.getoutput('/usr/sbin/groupdel '+ name[0])
 		self.gList = []
 
 	""" Retrieve the list of user from /etc/passwd file """
@@ -86,7 +86,7 @@ class RandomGen(object):
 		f.close()
 
 	def getFileList(self,path):
-		u = commands.getoutput('ls ' + path)
+		u = subprocess.getoutput('ls ' + path)
 		tmp = u.split('\n')
 		for i in range (len(tmp)-1):
 			NameOK = re.match("file",tmp[i])
@@ -142,10 +142,10 @@ class RandomGen(object):
 		f.close()
 
 	def printUserList(self):
-		print self.uList
+		print(self.uList)
 
 	def printGroupList(self):
-		print self.gList
+		print(self.gList)
 
 	""" Create a random name of random length """
 	def createOneNameRandomLength(self,maxlength):
@@ -211,19 +211,19 @@ class RandomGen(object):
 		file = self.fList[random.randint(0,len(self.fList)-1)]
 		if a == 1:	# creation/modification
 			user = self.uList[random.randint(0,len(self.uList)-1)]
-			u = commands.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + file)
+			u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + file)
 
 		if a == 2:	# with group
 			group = self.gList[random.randint(0,len(self.gList)-1)][0]
-			u = commands.getoutput('setfacl -m g:' + group + ':' + mode + " " + path + "/" + file)
+			u = subprocess.getoutput('setfacl -m g:' + group + ':' + mode + " " + path + "/" + file)
 
 		if a == 3:	# deletation
 			user = self.uList[random.randint(0,len(self.uList)-1)]
-			u = commands.getoutput('setfacl -x u:' + user + " " + path + "/" + file)
+			u = subprocess.getoutput('setfacl -x u:' + user + " " + path + "/" + file)
 
 		if a == 4:	# with group
 			group = self.gList[random.randint(0,len(self.gList)-1)][0]
-			u = commands.getoutput('setfacl -x g:' + group + " " + path + "/" + file)
+			u = subprocess.getoutput('setfacl -x g:' + group + " " + path + "/" + file)
 
 		# request on a unexisting group
 		'''if a == 5:
diff --git a/testcases/network/nfsv4/acl/setacl_stress.py b/testcases/network/nfsv4/acl/setacl_stress.py
index 3713ff6a9..2001e9f78 100755
--- a/testcases/network/nfsv4/acl/setacl_stress.py
+++ b/testcases/network/nfsv4/acl/setacl_stress.py
@@ -6,7 +6,7 @@
 
 from random_gen import *
 from optparse import OptionParser
-import commands
+import subprocess
 import os
 import random
 
diff --git a/testcases/network/nfsv4/acl/test_long_acl.py b/testcases/network/nfsv4/acl/test_long_acl.py
index a7c8cb1a1..8b3c33b84 100755
--- a/testcases/network/nfsv4/acl/test_long_acl.py
+++ b/testcases/network/nfsv4/acl/test_long_acl.py
@@ -4,7 +4,7 @@
 '''
 from random_gen import *
 from optparse import OptionParser
-import commands
+import subprocess
 import os
 import threading
 import time
@@ -19,20 +19,20 @@ def test_longacl(l,path):
 	# mesures sur le getfacl
 	test = RandomGen()
 
-	u = commands.getoutput('rm ' + path + "/*")	# clean directory
-	print "test acl getfacl\n"
+	u = subprocess.getoutput('rm ' + path + "/*")	# clean directory
+	print("test acl getfacl\n")
 	for i in range(l):
 		test.getUserList()
 		testfile = 'testfile' + str(i)
-		u = commands.getoutput('touch ' + path + "/" + testfile)
-		print "setfacl with " + str(i) + " entries\n " + u
+		u = subprocess.getoutput('touch ' + path + "/" + testfile)
+		print("setfacl with " + str(i) + " entries\n " + u)
 		for j in range(i):
 			user = test.uList.pop()
 			mode = test.createRandomMode()
-                        u = commands.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
+                        u = subprocess.getoutput('setfacl -m u:' + user + ':' + mode + " " + path + "/" + testfile)
 	                if u != "":
-                                print "setfacl -m u:" + user + ':' + mode + " " + path + "/" + testfile
-                                print u
+                                print("setfacl -m u:" + user + ':' + mode + " " + path + "/" + testfile)
+                                print(u)
 def main():
 	parser = OptionParser()
 	parser.add_option("-l", "--length", dest="length",type="int",help="max lentgh of ACL")
diff --git a/testcases/network/nfsv4/locks/locktests.py b/testcases/network/nfsv4/locks/locktests.py
index dd518ab6e..6aa9392b2 100755
--- a/testcases/network/nfsv4/locks/locktests.py
+++ b/testcases/network/nfsv4/locks/locktests.py
@@ -38,8 +38,8 @@ class Machine:
         self.do()
 
     def printc(self):
-        print "->"+self.command
-        print "\n"
+        print("->"+self.command)
+        print("\n")
 
 class Client(Machine):
 
@@ -95,25 +95,25 @@ class Serveur(Machine):
         self.unexport(unexportDir)
         self.rmdir(unexportDir)
 def usage():
-        print "\n"
-        print "usage:"
-        print "locktests.py <-n process -f testfile ><--setup -s fs_server> -c host1, host2, host3 ... "
-        print "--setup : setup the configuration, deploy test on other test machines; This option also requires -c and -s"
-        print "-c <machine>     : host list to deploy/run/clean the test"
-        print "-s <machine>     : NFS server to use to setup the test"
-        print "-n <num>         : number of processes each test machine will lauch to perform the test"
-        print "-f <file>        : test file. This must be the same on each machine"
-	print " "
-        print "Example :"
-        print "========="
-        print "*Setup machines for testing"
-        print "./locktests.py --setup -c testmachine1 testmachine2 testmachine3 -s my_nfs_server:/"
-        print "\n"
-        print "*Run test on testmachine1,testmachine2 with 50 process on each machine using /mnt/nfsv4/testfile"
-        print "./locktests.py -n 50 -f /mnt/nfsv4/testfile -c testmachine1 testmachine2"
-        print "\n"
-        print "_________________________________"
-        print "Vincent ROQUETA - Bull SA - 2005\n"
+        print("\n")
+        print("usage:")
+        print("locktests.py <-n process -f testfile ><--setup -s fs_server> -c host1, host2, host3 ... ")
+        print("--setup : setup the configuration, deploy test on other test machines; This option also requires -c and -s")
+        print("-c <machine>     : host list to deploy/run/clean the test")
+        print("-s <machine>     : NFS server to use to setup the test")
+        print("-n <num>         : number of processes each test machine will lauch to perform the test")
+        print("-f <file>        : test file. This must be the same on each machine")
+	print(" ")
+        print("Example :")
+        print("=========")
+        print("*Setup machines for testing")
+        print("./locktests.py --setup -c testmachine1 testmachine2 testmachine3 -s my_nfs_server:/")
+        print("\n")
+        print("*Run test on testmachine1,testmachine2 with 50 process on each machine using /mnt/nfsv4/testfile")
+        print("./locktests.py -n 50 -f /mnt/nfsv4/testfile -c testmachine1 testmachine2")
+        print("\n")
+        print("_________________________________")
+        print("Vincent ROQUETA - Bull SA - 2005\n")
 
         return 0
 
@@ -124,14 +124,14 @@ def setup():
     fichier=SRC_PATH+"/"+SRC
     commande=""
     for i in clients:
-        print "Setting up machine "+i
+        print("Setting up machine "+i)
         c=Client(i)
         c.mkdir(path)
         c.cp(fichier, path)
         c.install(path)
         c.isomount(NFS4_PATH)
     #Setup localhost
-    print "Setting up localhost"
+    print("Setting up localhost")
     commande="make; mkdir -p "+NFS4_PATH+" ; mount -t nfs4 "+NFS4_SERVER+" "+NFS4_PATH+" &"
     os.system(commande)
 
@@ -159,7 +159,7 @@ def clean():
 
 
 args=sys.argv[1:]
-rge=range(len(args))
+rge=list(range(len(args)))
 a=""
 r=True
 s=False
@@ -213,17 +213,17 @@ if s:
     if (not c) or (not nfsServer):
         usage()
         sys.exit(1)
-    print "Setup"
-    print NFS4_SERVER
+    print("Setup")
+    print(NFS4_SERVER)
     setup()
-    print "Setup complete"
+    print("Setup complete")
 
 if r:
     if (not c) or (not f) or (not n):
         usage()
         sys.exit(1)
 
-    print "Running test"
+    print("Running test")
     run()
 
 
diff --git a/testcases/realtime/scripts/parser.py b/testcases/realtime/scripts/parser.py
index 6b2dc7370..d43ce5318 100644
--- a/testcases/realtime/scripts/parser.py
+++ b/testcases/realtime/scripts/parser.py
@@ -34,7 +34,7 @@ class Log:
 	    log_file=filename
 	try:
 	    self.__log_file = open(log_file, "r")
-	except IOError, errmsg:
+	except IOError as errmsg:
 	    sys.exit(errmsg)
 
     def read(self):
diff --git a/testcases/realtime/tools/ftqviz.py b/testcases/realtime/tools/ftqviz.py
index 19ae093a0..22f102e53 100644
--- a/testcases/realtime/tools/ftqviz.py
+++ b/testcases/realtime/tools/ftqviz.py
@@ -37,7 +37,7 @@ NS_PER_US = 1000
 
 def smooth(x, wlen):
     if x.size < wlen:
-        raise ValueError, "Input vector needs to be bigger than window size."
+        raise ValueError("Input vector needs to be bigger than window size.")
 
     # reflect the signal to avoid transients... ?
     s = r_[2*x[0]-x[wlen:1:-1], x, 2*x[-1]-x[-1:-wlen:-1]]
@@ -62,8 +62,8 @@ def smooth_fft(timefile, countfile, sample_hz, wlen):
     # same factor
     ns_per_sample = NS_PER_S / sample_hz
 
-    print "Interpolated Sample Rate: ", sample_hz, " HZ"
-    print "Hamming Window Length: ", wlen
+    print("Interpolated Sample Rate: ", sample_hz, " HZ")
+    print("Hamming Window Length: ", wlen)
 
     t = fromfile(timefile, dtype=int64, sep='\n')
     x = fromfile(countfile, dtype=int64, sep='\n')
@@ -83,7 +83,7 @@ def smooth_fft(timefile, countfile, sample_hz, wlen):
     # smooth the signal (low pass filter)
     try:
         y = smooth(xi, wlen)
-    except ValueError, e:
+    except ValueError as e:
         exit(e)
 
     # generate the fft
@@ -121,7 +121,7 @@ def smooth_fft(timefile, countfile, sample_hz, wlen):
 
 
 def usage():
-        print "usage: "+argv[0]+" -t times-file -c counts-file [-s SAMPLING_HZ] [-w WINDOW_LEN] [-h]"
+        print("usage: "+argv[0]+" -t times-file -c counts-file [-s SAMPLING_HZ] [-w WINDOW_LEN] [-h]")
 
 
 if __name__=='__main__':
@@ -143,7 +143,7 @@ if __name__=='__main__':
             usage()
             exit()
         if o == "-s":
-            sample_hz = long(a)
+            sample_hz = int@
         if o == "-t":
             times_file = a
         if o == "-w":
diff --git a/testscripts/build/ltp-missing-install-files.py b/testscripts/build/ltp-missing-install-files.py
index 1ab40a09f..a1af30e48 100755
--- a/testscripts/build/ltp-missing-install-files.py
+++ b/testscripts/build/ltp-missing-install-files.py
@@ -111,6 +111,6 @@ for logfile in logfiles:
         fd.close()
 
     if len(missing_ents):
-        print "\n".join(["%s: %s" % (os.path.basename(logfile), i) for i in ["Tag | App"] + missing_ents])
+        print("\n".join(["%s: %s" % (os.path.basename(logfile), i) for i in ["Tag | App"] + missing_ents]))
     elif opts.verbose:
-        print "%s: CONGRATULATIONS -- no missing files found!" % os.path.basename(logfile)
+        print("%s: CONGRATULATIONS -- no missing files found!" % os.path.basename(logfile))
diff --git a/tools/pounder21/src/time_tests/drift-test.py b/tools/pounder21/src/time_tests/drift-test.py
index aba1909e3..c765d6f4b 100755
--- a/tools/pounder21/src/time_tests/drift-test.py
+++ b/tools/pounder21/src/time_tests/drift-test.py
@@ -24,7 +24,7 @@
 
 # Usage: drift-test.py [-s] [ntp_server [sleep_time]]
 
-import commands
+import subprocess
 import sys
 import string
 import time
@@ -52,9 +52,9 @@ if sleep_time == 0:
 
 #set time
 if (set_time == 1):
-	cmd = commands.getoutput('/usr/sbin/ntpdate -ub ' + server)
+	cmd = subprocess.getoutput('/usr/sbin/ntpdate -ub ' + server)
 
-cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
+cmd = subprocess.getoutput('/usr/sbin/ntpdate -uq ' + server)
 line = string.split(cmd)
 
 #parse original offset
@@ -65,7 +65,7 @@ datestr = time.strftime("%d %b %Y %H:%M:%S", start_time)
 
 time.sleep(1)
 while 1:
-	cmd = commands.getoutput('/usr/sbin/ntpdate -uq ' + server)
+	cmd = subprocess.getoutput('/usr/sbin/ntpdate -uq ' + server)
 	line = string.split(cmd)
 
 	#parse offset
@@ -81,9 +81,9 @@ while 1:
 	drift =  delta_offset / delta_time * 1000000
 
 	#print output
-	print time.strftime("%d %b %H:%M:%S",now_time),
-	print "	offset:", now_offset ,
-	print "	drift:", drift ,"ppm"
+	print(time.strftime("%d %b %H:%M:%S",now_time), end=' ')
+	print("	offset:", now_offset, end=' ')
+	print("	drift:", drift ,"ppm")
 	sys.stdout.flush()
 
 	#sleep
-- 
2.13.6

