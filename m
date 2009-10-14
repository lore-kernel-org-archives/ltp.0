Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxtQy-0000Vu-L7
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:17:48 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxtQs-00008U-46
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:17:48 +0000
Received: by pzk26 with SMTP id 26so9540568pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Oct 2009 19:17:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20091013074346.22414.9377.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
	<20091013074346.22414.9377.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 19:17:36 -0700
Message-ID: <364299f40910131917v5b82c196id1deb3b77bc578e4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch 2/6] Developed new functions and fixed issues
	causing ilb test failure
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Tue, Oct 13, 2009 at 12:43 AM, Poornima Nayak
<mpnayak@linux.vnet.ibm.com> wrote:
> CPU Consolidation verification function is fixed to handle variations in
> CPU utilization. Threshold is selected based on test conducted on 2.6.31 =
on
> dual core, quad core & hyper threaded system.
> Developed new function to generate hyper threaded siblings list and get j=
ob count
> for hyper threaded system and multisocket system.
> Modified kernbench workload execution time for 5 min, hence test executio=
n time
> will be reduced further. Developed new functions to stop workload.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090930/testcases/kernel/power_management/lib/sched_=
mc.py ltp-full-20090930_patched/testcases/kernel/power_management/lib/sched=
_mc.py
> --- ltp-full-20090930/testcases/kernel/power_management/lib/sched_mc.py 2=
009-10-05 02:10:56.000000000 -0400
> +++ ltp-full-20090930_patched/testcases/kernel/power_management/lib/sched=
_mc.py 2009-10-12 23:00:30.000000000 -0400
> @@ -22,6 +22,7 @@ socket_count =3D 0
> =A0cpu1_max_intr =3D 0
> =A0cpu2_max_intr =3D 0
> =A0intr_stat_timer_0 =3D []
> +siblings_list =3D []
>
> =A0def clear_dmesg():
> =A0 =A0 '''
> @@ -96,6 +97,36 @@ def is_hyper_threaded():
> =A0 =A0 =A0 =A0 print "Failed to check if system is hyper-threaded"
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> +def is_multi_core():
> + =A0 =A0''' Return true if system has sockets has multiple cores
> + =A0 =A0'''
> +
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0file_cpuinfo =3D open("/proc/cpuinfo", 'r')
> + =A0 =A0 =A0 =A0for line in file_cpuinfo:
> + =A0 =A0 =A0 =A0 =A0 =A0if line.startswith('siblings'):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0siblings =3D line.split(":")
> + =A0 =A0 =A0 =A0 =A0 =A0if line.startswith('cpu cores'):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_cores =3D line.split(":")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break
> +
> + =A0 =A0 =A0 =A0if int( siblings[1] ) =3D=3D int( cpu_cores[1] ):
> + =A0 =A0 =A0 =A0 =A0 =A0if int( cpu_cores[1] ) > 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multi_core =3D 1
> + =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multi_core =3D 0
> + =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0num_of_cpus =3D int(siblings[1]) / int(cpu_cores=
[1])
> + =A0 =A0 =A0 =A0 =A0 =A0if num_of_cpus > 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multi_core =3D 1
> + =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0multi_core =3D 0
> + =A0 =A0 =A0 =A0file_cpuinfo.close()
> + =A0 =A0 =A0 =A0return multi_core
> + =A0 =A0except Exception:
> + =A0 =A0 =A0 =A0print "Failed to check if system is multi core system"
> + =A0 =A0 =A0 =A0sys.exit(1)

Here's another suggested method:

http://codeliberates.blogspot.com/2008/05/detecting-cpuscores-in-python.html

unless the `siblings' information has more data that the above method
cannot provide.

> =A0def get_hyper_thread_count():
> =A0 =A0 ''' Return number of threads in CPU. For eg for x3950 this functi=
on
> =A0 =A0 =A0 =A0 would return 2. In future if 4 threads are supported in C=
PU, this
> @@ -153,6 +184,40 @@ def map_cpuid_pkgid():
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sys.exit(1)
>
>
> +def generate_sibling_list():
> + =A0 =A0''' Routine to generate siblings list
> + =A0 =A0'''
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0for i in range(0, cpu_count):
> + =A0 =A0 =A0 =A0 =A0 =A0siblings_file =3D '/sys/devices/system/cpu/cpu%s=
' % i
> + =A0 =A0 =A0 =A0 =A0 =A0siblings_file +=3D '/topology/thread_siblings_li=
st'
> + =A0 =A0 =A0 =A0 =A0 =A0threads_sibs =3D open(siblings_file).read().rstr=
ip()
> + =A0 =A0 =A0 =A0 =A0 =A0thread_ids =3D threads_sibs.split("-")
> +
> + =A0 =A0 =A0 =A0 =A0 =A0if not thread_ids in siblings_list:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0siblings_list.append(thread_ids)
> + =A0 =A0except Exception, details:
> + =A0 =A0 =A0 =A0print "Exception in generate_siblings_list", details
> + =A0 =A0 =A0 =A0sys.exit(1)

sys.exit with the above string might be better. Be sure to do
str(details) too if you follow that method.

> +def get_siblings(cpu_id):
> + =A0 =A0''' Return siblings of cpu_id
> + =A0 =A0'''
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0cpus =3D ""
> + =A0 =A0 =A0 =A0for i in range(0, len(siblings_list)):
> + =A0 =A0 =A0 =A0 =A0 =A0for cpu in siblings_list[i]:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id =3D=3D cpu:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for j in siblings_list[i]:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# Exclude cpu_id in the =
list of siblings
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if j !=3D cpu_id:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus +=3D j
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cpus
> + =A0 =A0 =A0 =A0return cpus
> + =A0 =A0except Exception, details:
> + =A0 =A0 =A0 =A0print "Exception in get_siblings", details
> + =A0 =A0 =A0 =A0sys.exit(1)

This for-loop logic could be reduced to the following:

       cpus =3D ""
       for i in range(len(siblings_list)):
           try:
               i =3D siblings_list.index(cpu_id)
               # XXX (garrcoop): Does a " ".join need to be here?
               cpus =3D [siblings_list[j] for j in
range(len(siblings_list)).remove(i)]
               break
           except ValueError:
               # .index(..) will return ValueError if the object isn't
found in the list.
               pass
       return cpus

This way there's only one exit point in the function and the overall
loop logic has been reduced. Please test before checkin though :).

> =A0def get_proc_data(stats_list):
> =A0 =A0 ''' Read /proc/stat info and store in dictionary
> =A0 =A0 '''
> @@ -168,18 +233,18 @@ def get_proc_data(stats_list):
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> =A0def get_proc_loc_count(loc_stats):
> - =A0 =A0''' Read /proc/stat info and store in dictionary
> + =A0 =A0''' Read /proc/interrupts info and store in list
> =A0 =A0 '''
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 file_procstat =3D open("/proc/interrupts", 'r')
> =A0 =A0 =A0 =A0 for line in file_procstat:
> - =A0 =A0 =A0 =A0 =A0 =A0if line.startswith('LOC:'):
> + =A0 =A0 =A0 =A0 =A0 =A0if line.startswith(' LOC:') or line.startswith('=
LOC:'):

Why not just do lstrip()?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data =3D line.split()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for i in range(0, cpu_count):

range(0, ...) is unneeded. range(cpu_count) is sufficient as 0 as the
starting index for the range is implied in python.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # To skip LOC
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 loc_stats.append(data[i+1])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print data[i+1]
> - =A0 =A0 =A0 =A0file_procstat.close()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0file_procstat.close()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Could not read interrupt statistics", details
> =A0 =A0 =A0 =A0 sys.exit(1)
> @@ -192,6 +257,8 @@ def set_sched_mc_power(sched_mc_level):
> =A0 =A0 =A0 =A0 os.system('echo %s > \
> =A0 =A0 =A0 =A0 =A0 =A0 /sys/devices/system/cpu/sched_mc_power_savings 2>=
/dev/null'
> =A0 =A0 =A0 =A0 =A0 =A0 % sched_mc_level)

^^^ This exit code needs to be checked... or you need to at least
check and make sure that it exists with os.access(, os.R_OK) -- this
is related to the issue I filed earlier ^^^

> +
> + =A0 =A0 =A0 =A0get_proc_data(stats_start)
> =A0 =A0 except OSError, e:
> =A0 =A0 =A0 =A0 print "Could not set sched_mc_power_savings to", sched_mc=
_level, e
> =A0 =A0 =A0 =A0sys.exit(1)
> @@ -203,6 +270,8 @@ def set_sched_smt_power(sched_smt_level)
> =A0 =A0 =A0 =A0 os.system('echo %s > \
> =A0 =A0 =A0 =A0 =A0 =A0 /sys/devices/system/cpu/sched_smt_power_savings 2=
>/dev/null'
> =A0 =A0 =A0 =A0 =A0 =A0 % sched_smt_level)

^^^ This exit code needs to be checked... or you need to at least
check and make sure that it exists with os.access(, os.R_OK) -- this
is related to the issue I filed earlier ^^^

> + =A0 =A0 =A0 =A0get_proc_data(stats_start)
> =A0 =A0 except OSError, e:
> =A0 =A0 =A0 =A0 print "Could not set sched_smt_power_savings to", sched_s=
mt_level, e
> =A0 =A0 =A0 =A0sys.exit(1)
> @@ -218,21 +287,36 @@ def set_timer_migration_interface(value)
> =A0 =A0 =A0 =A0 print "Could not set timer_migration to ", value, e
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> -def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
> - =A0 =A0''' Triggers ebizzy workload for sched_mc=3D1
> - =A0 =A0 =A0 =A0testing
> +def get_job_count(stress, workload, sched_smt):
> + =A0 =A0''' Returns number of jobs/threads to be triggered
> =A0 =A0 '''
> +
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 if stress =3D=3D "thread":
> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D get_hyper_thread_count()
> =A0 =A0 =A0 =A0 if stress =3D=3D "partial":

elif would be better (less if logic -- these values are exclusive).

> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count / socket_count
> + =A0 =A0 =A0 =A0 =A0 =A0if is_hyper_threaded():
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if workload =3D=3D "ebizzy" and int(sche=
d_smt) =3D=3D0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0threads =3D threads / get_hyper_=
thread_count()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if workload =3D=3D "kernbench" and int(s=
ched_smt) < 2:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0threads =3D threads / get_hyper_=
thread_count()

Same as above.

> =A0 =A0 =A0 =A0 if stress =3D=3D "full":
> - =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count
> + =A0 =A0 =A0 =A0 =A0 =A0threads =3D cpu_count
> =A0 =A0 =A0 =A0 if stress =3D=3D "single_job":
> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D 1
> =A0 =A0 =A0 =A0 =A0 =A0 duration =3D 180
> + =A0 =A0 =A0 =A0return threads
> + =A0 =A0except Exception, details:
> + =A0 =A0 =A0 =A0print "get job count failed ", details
> + =A0 =A0 =A0 =A0sys.exit(1)

Same as above comment about sys.exit(...).

> +def trigger_ebizzy (sched_smt, stress, duration, background, pinned):
> + =A0 =A0''' Triggers ebizzy workload for sched_mc=3D1
> + =A0 =A0 =A0 =A0testing
> + =A0 =A0'''
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0threads =3D get_job_count(stress, "ebizzy", sched_smt)
> =A0 =A0 =A0 =A0 olddir =3D os.getcwd()
> =A0 =A0 =A0 =A0 path =3D '%s/utils/benchmark' % os.environ['LTPROOT']

This isn't the path anymore. Should be $LTPROOT/testcases/bin, or
os.path.basename(__file__) if you're concerned about portability.

> =A0 =A0 =A0 =A0 os.chdir(path)
> @@ -282,23 +366,14 @@ def trigger_ebizzy (sched_smt, stress, d
> =A0 =A0 =A0 =A0 print "Ebizzy workload trigger failed ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> -def trigger_kernbench (sched_smt, stress, background, pinned):
> +def trigger_kernbench (sched_smt, stress, background, pinned, perf_test):
> =A0 =A0 ''' Trigger load on system like kernbench.
> =A0 =A0 =A0 =A0 Copys existing copy of LTP into as LTP2 and then builds it
> =A0 =A0 =A0 =A0 with make -j
> =A0 =A0 '''
> =A0 =A0 olddir =3D os.getcwd()
> =A0 =A0 try:
> - =A0 =A0 =A0 =A0if stress =3D=3D "thread":
> - =A0 =A0 =A0 =A0 =A0 threads =3D 2
> - =A0 =A0 =A0 =A0if stress =3D=3D "partial":
> - =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count / socket_count
> - =A0 =A0 =A0 =A0 =A0 =A0if is_hyper_threaded() and int(sched_smt) !=3D2:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0threads =3D threads / get_hyper_thread_c=
ount()
> - =A0 =A0 =A0 =A0if stress =3D=3D "full":
> - =A0 =A0 =A0 =A0 =A0 =A0threads =3D cpu_count
> - =A0 =A0 =A0 =A0if stress =3D=3D "single_job":
> - =A0 =A0 =A0 =A0 =A0 =A0threads =3D 1
> + =A0 =A0 =A0 =A0threads =3D get_job_count(stress, "kernbench", sched_smt)
>
> =A0 =A0 =A0 =A0 dst_path =3D "/root"
> =A0 =A0 =A0 =A0 olddir =3D os.getcwd()
> @@ -335,24 +410,35 @@ def trigger_kernbench (sched_smt, stress
> =A0 =A0 =A0 =A0 get_proc_loc_count(intr_start)
> =A0 =A0 =A0 =A0 if pinned =3D=3D "yes":
> =A0 =A0 =A0 =A0 =A0 =A0 os.system ( 'taskset -c %s %s/kernbench -o %s -M =
-H -n 1 \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>/dev/null 2>&1' % (cpu_count-1, benchma=
rk_path, threads))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>/dev/null 2>&1 &' % (cpu_count-1, bench=
mark_path, threads))
> +
> + =A0 =A0 =A0 =A0 =A0 =A0# We have to delete import in future

???? Why?

> + =A0 =A0 =A0 =A0 =A0 =A0import time
> + =A0 =A0 =A0 =A0 =A0 =A0time.sleep(240)
> + =A0 =A0 =A0 =A0 =A0 =A0stop_wkld("kernbench")
> =A0 =A0 =A0 =A0 else:
> =A0 =A0 =A0 =A0 =A0 =A0 if background =3D=3D "yes":
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 os.system ( '%s/kernbench -o %s -M -H -n =
1 >/dev/null 2>&1 &' \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 % (benchmark_path, threads))
> =A0 =A0 =A0 =A0 =A0 =A0 else:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.system ( '%s/kernbench -o %s -M -H -n=
 1 >/dev/null 2>&1' \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0% (benchmark_path, threads))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if perf_test =3D=3D "yes":
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.system ( '%s/kernbench -o %s =
-M -H -n 1 >/dev/null 2>&1' \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0% (benchmark_path, threa=
ds))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0os.system ( '%s/kernbench -o %s =
-M -H -n 1 >/dev/null 2>&1 &' \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0% (benchmark_path, threa=
ds))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# We have to delete import in fu=
ture
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0import time
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0time.sleep(240)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_wkld("kernbench")
>
> =A0 =A0 =A0 =A0 print "INFO: Workload kernbench triggerd"
> =A0 =A0 =A0 =A0 os.chdir(olddir)
> - =A0 =A0 =A0 =A0#get_proc_data(stats_stop)
> - =A0 =A0 =A0 =A0#get_proc_loc_count(intr_stop)
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Workload kernbench trigger failed ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> -def trigger_workld(sched_smt, workload, stress, duration, background, pi=
nned):
> +def trigger_workld(sched_smt, workload, stress, duration, background, pi=
nned, perf_test):
> =A0 =A0 ''' Triggers workload passed as argument. Number of threads
> =A0 =A0 =A0 =A0 triggered is based on stress value.
> =A0 =A0 '''
> @@ -360,7 +446,7 @@ def trigger_workld(sched_smt, workload,
> =A0 =A0 =A0 =A0 if workload =3D=3D "ebizzy":
> =A0 =A0 =A0 =A0 =A0 =A0 trigger_ebizzy (sched_smt, stress, duration, back=
ground, pinned)
> =A0 =A0 =A0 =A0 if workload =3D=3D "kernbench":
> - =A0 =A0 =A0 =A0 =A0 =A0trigger_kernbench (sched_smt, stress, background=
, pinned)
> + =A0 =A0 =A0 =A0 =A0 =A0trigger_kernbench (sched_smt, stress, background=
, pinned, perf_test)
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "INFO: Trigger workload failed", details
> =A0 =A0 =A0 =A0 sys.exit(1)
> @@ -434,7 +520,7 @@ def generate_report():
> =A0 =A0 =A0 =A0 =A0 =A0 print >> keyvalfile, "package-%s=3D%3.4f" % \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pkg, (float(total_idle)*100/total))
> =A0 =A0 except Exception, details:
> - =A0 =A0 =A0 =A0print "Generating reportfile failed: ", details
> + =A0 =A0 =A0 =A0print "Generating utilization report failed: ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> =A0 =A0 #Add record delimiter '\n' before closing these files
> @@ -454,20 +540,18 @@ def generate_loc_intr_report():
>
> =A0 =A0 =A0 =A0 get_proc_loc_count(intr_stop)
>
> - =A0 =A0 =A0 =A0print "Before substracting"
> - =A0 =A0 =A0 =A0for i in range(0, cpu_count):
> - =A0 =A0 =A0 =A0 =A0 =A0print "CPU",i, intr_start[i], intr_stop[i]
> - =A0 =A0 =A0 =A0 =A0 =A0reportfile =3D open('/procstat/cpu-loc_interrupt=
s', 'a')
> - =A0 =A0 =A0 =A0 =A0 =A0print >> reportfile, "=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> - =A0 =A0 =A0 =A0 =A0 =A0print >> reportfile, " =A0 =A0 Local timer inter=
rupt stats =A0 =A0 =A0 =A0 =A0 =A0 =A0"
> - =A0 =A0 =A0 =A0 =A0 =A0print >> reportfile, "=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> + =A0 =A0 =A0 =A0reportfile =3D open('/procstat/cpu-loc_interrupts', 'a')
> + =A0 =A0 =A0 =A0print >> reportfile, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> + =A0 =A0 =A0 =A0print >> reportfile, " =A0 =A0 Local timer interrupt sta=
ts =A0 =A0 =A0 =A0 =A0 =A0 =A0"
> + =A0 =A0 =A0 =A0print >> reportfile, "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"
> +
> =A0 =A0 =A0 =A0 for i in range(0, cpu_count):
> =A0 =A0 =A0 =A0 =A0 =A0 intr_stop[i] =3D =A0int(intr_stop[i]) - int(intr_=
start[i])
> =A0 =A0 =A0 =A0 =A0 =A0 print >> reportfile, "CPU%s: %s" %(i, intr_stop[i=
])
> =A0 =A0 =A0 =A0 print >> reportfile
> =A0 =A0 =A0 =A0 reportfile.close()
> =A0 =A0 except Exception, details:
> - =A0 =A0 =A0 =A0print "Generating reportfile failed: ", details
> + =A0 =A0 =A0 =A0print "Generating interrupt report failed: ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> =A0def record_loc_intr_count():
> @@ -542,25 +626,24 @@ def validate_cpugrp_map(cpu_group, sched
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 modi_cpu_=
grp.remove(core_cpus[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if len(mo=
di_cpu_grp) =3D=3D 0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r=
eturn 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#This code has t=
o be deleted
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#else:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # If sche=
d_smt =3D=3D 0 then its oky if threads run
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # in diff=
erent cores of same package
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if sched=
_smt_level =3D=3D 1:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
sys.exit(1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
if len(cpu_group) =3D=3D 2 and \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0len(modi_cpu_grp) < len(cpu_group):
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0print "INFO:CPUs utilized not in a core"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0return 1
> - =A0 =A0 =A0 =A0 =A0 =A0print "INFO: CPUs utilized is not in same packag=
e or core"
> - =A0 =A0 =A0 =A0 =A0 =A0return(1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#if sche=
d_smt_level > 0 :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
#return 1
> =A0 =A0 =A0 =A0else:
> =A0 =A0 =A0 =A0 =A0 =A0 for pkg in sorted(cpu_map.keys()):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pkg_cpus =3D cpu_map[pkg]
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if pkg_cpus =3D=3D cpu_group:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return(0)
> -
> - =A0 =A0 =A0 =A0 =A0 =A0return(1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if len(cpu_group) =3D=3D len(pkg_cpus):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if pkg_cpus =3D=3D cpu_group:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return(0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if int(cpus_utilized[0]) in cpu_=
map[pkg] or int(cpus_utilized[1]) in cpu_map[pkg]:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return(0)
> +
> + =A0 =A0 =A0 =A0return(1)
> +
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Exception in validate_cpugrp_map: ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
> @@ -605,36 +688,70 @@ def verify_sched_domain_dmesg(sched_mc_l
> =A0 =A0 =A0 =A0 print "Reading dmesg failed", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> -def validate_cpu_consolidation(work_ld, sched_mc_level, sched_smt_level):
> +def get_cpu_utilization(cpu):
> + =A0 =A0''' Return cpu utilization of cpu_id
> + =A0 =A0'''
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0for l in sorted(stats_percentage.keys()):
> + =A0 =A0 =A0 =A0 =A0 =A0if cpu =3D=3D stats_percentage[l][0]:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return stats_percentage[l][1]
> + =A0 =A0 =A0 =A0return -1
> + =A0 =A0except Exception, details:
> + =A0 =A0 =A0 =A0print "Exception in get_cpu_utilization", details
> + =A0 =A0 =A0 =A0sys.exit(1)
> +
> +def validate_cpu_consolidation(stress, work_ld, sched_mc_level, sched_sm=
t_level):
> =A0 =A0 ''' Verify if cpu's on which threads executed belong to same
> =A0 =A0 package
> =A0 =A0 '''
> =A0 =A0 cpus_utilized =3D list()
> + =A0 =A0threads =3D get_job_count(stress, work_ld, sched_smt_level)
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 for l in sorted(stats_percentage.keys()):
> =A0 =A0 =A0 =A0 =A0 =A0 #modify threshold
> + =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0].split("cpu")
> + =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] =3D=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue
> + =A0 =A0 =A0 =A0 =A0 =A0if int(cpu_id[1]) in cpus_utilized:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue
> =A0 =A0 =A0 =A0 =A0 =A0 if is_hyper_threaded():
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 25 and work_=
ld =3D=3D "kernbench":
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0=
].split("cpu")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if work_ld =3D=3D "kernbench" and sched_=
smt_level < sched_mc_level:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0siblings =3D get_siblings(cpu_id=
[1])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if siblings !=3D "":
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sib_list =3D siblings.sp=
lit()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0utilization =3D int(stat=
s_percentage[l][1])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for i in range(0, len(si=
b_list)):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0utilization +=3D=
 int(get_cpu_utilization("cpu%s" %sib_list[i]))

This could be done with map and sum, like so:

utilization =3D int(stats_percentage[l][1]) + sum( map ( int, [
get_cpu_utilization("cpu%s" % sib_list[i]) for i in
range(len(sib_list)) ] ) )

You may want to break this into 2 steps to make it more readable.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0utilization =3D stats_pe=
rcentage[l][1]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if utilization > 40:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpus_utilized.append(int(=
cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if siblings !=3D "":
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for i in range(0=
, len(sib_list)):
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_uti=
lized.append(int(sib_list[i]))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 70:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percent=
age[l][0].split("cpu")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.ap=
pend(int(cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0# This threshold wuld be modifie=
d based on results
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 40:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.append(int=
(cpu_id[1]))
> =A0 =A0 =A0 =A0 =A0 =A0 else:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 70:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0=
].split("cpu")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if work_ld =3D=3D "kernbench" :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 50:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpus_utilized.append(int(=
cpu_id[1]))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.sort()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 70:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.append(int=
(cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.sort()
> =A0 =A0 =A0 =A0 print "INFO: CPU's utilized ", cpus_utilized
>
> + =A0 =A0 =A0 =A0# If length of CPU's utilized is not =3D number of jobs =
exit with 1
> + =A0 =A0 =A0 =A0if len(cpus_utilized) < threads:
> + =A0 =A0 =A0 =A0 =A0 =A0return 1
> +
> =A0 =A0 =A0 =A0 status =3D validate_cpugrp_map(cpus_utilized, sched_mc_le=
vel, \
> =A0 =A0 =A0 =A0 =A0 =A0 sched_smt_level)
> =A0 =A0 =A0 =A0 if status =3D=3D 1:
> =A0 =A0 =A0 =A0 =A0 =A0 print "INFO: CPUs utilized is not in same package=
 or core"
> +
> =A0 =A0 =A0 =A0 return(status)
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Exception in validate_cpu_consolidation: ", details
> @@ -645,7 +762,8 @@ def get_cpuid_max_intr_count():
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 highest =3D 0
> =A0 =A0 =A0 =A0 second_highest =3D 0
> - =A0 =A0 =A0 =A0global cpu1_max_intr, cpu2_max_intr
> + =A0 =A0 =A0 =A0cpus_utilized =3D []
> +
> =A0 =A0 =A0 =A0 #Skipping CPU0 as it is generally high
> =A0 =A0 =A0 =A0 for i in range(1, cpu_count):
> =A0 =A0 =A0 =A0 =A0 =A0 if int(intr_stop[i]) > int(highest):
> @@ -658,15 +776,19 @@ def get_cpuid_max_intr_count():
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if int(intr_stop[i]) > int(second_highest=
):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 second_highest =3D int(intr_stop[=
i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu2_max_intr =3D i
> + =A0 =A0 =A0 =A0cpus_utilized.append(cpu1_max_intr)
> + =A0 =A0 =A0 =A0cpus_utilized.append(cpu2_max_intr)
> +

cpus_utilized.extend([cpu1_max_intr, cpu2_max_intr])

would be better.

> =A0 =A0 =A0 =A0 for i in range(1, cpu_count):
> =A0 =A0 =A0 =A0 =A0 =A0 if i !=3D cpu1_max_intr and i !=3D cpu2_max_intr:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 diff =3D second_highest - intr_stop[i]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ''' Threshold of difference has to be man=
ipulated '''
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if diff < 10000:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "INFO: Diff in interrupt co=
unt is below threshold"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized =3D []
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cpus_utilized

Why not just return [] (unless you need empty out the iterable
variable's value and there's another shallow copy somewhere else?)

> =A0 =A0 =A0 =A0 print "INFO: Interrupt count in other CPU's low as expect=
ed"
> - =A0 =A0 =A0 =A0return 0
> + =A0 =A0 =A0 =A0return cpus_utilized
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Exception in get_cpuid_max_intr_count: ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
> @@ -675,14 +797,12 @@ def validate_ilb (sched_mc_level, sched_
> =A0 =A0 ''' Validate if ilb is running in same package where work load is=
 running
> =A0 =A0 '''
> =A0 =A0 try:
> - =A0 =A0 =A0 =A0status =3D get_cpuid_max_intr_count()
> - =A0 =A0 =A0 =A0if status =3D=3D 1:
> + =A0 =A0 =A0 =A0cpus_utilized =3D get_cpuid_max_intr_count()
> + =A0 =A0 =A0 =A0if not cpus_utilized:
> =A0 =A0 =A0 =A0 =A0 =A0 return 1

True / False is more desirable with binary return values in python.

> - =A0 =A0 =A0 =A0for pkg in sorted(cpu_map.keys()):
> - =A0 =A0 =A0 =A0 =A0 =A0if cpu1_max_intr in cpu_map[pkg] and cpu2_max_in=
tr in cpu_map[pkg]:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0
> - =A0 =A0 =A0 =A0print "INFO: CPUs with higher interrupt count is not in =
same package"
> - =A0 =A0 =A0 =A0return 1
> +
> + =A0 =A0 =A0 =A0status =3D validate_cpugrp_map(cpus_utilized, sched_mc_l=
evel, sched_smt_level)
> + =A0 =A0 =A0 =A0return status
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Exception in validate_ilb: ", details
> =A0 =A0 =A0 =A0 sys.exit(1)
> @@ -706,3 +826,14 @@ def reset_schedsmt():
> =A0 =A0 except OSError, e:
> =A0 =A0 =A0 =A0 print "Could not set sched_smt_power_savings to 0", e
> =A0 =A0 =A0 =A0 sys.exit(1)
> +
> +def stop_wkld(work_ld):
> + =A0 =A0''' Kill workload triggered in background
> + =A0 =A0'''
> + =A0 =A0try:
> + =A0 =A0 =A0 =A0os.system('pkill %s 2>/dev/null' %work_ld)
> + =A0 =A0 =A0 =A0if work_ld =3D=3D "kernbench":
> + =A0 =A0 =A0 =A0 =A0 =A0os.system('pkill make 2>/dev/null')
> + =A0 =A0except OSError, e:
> + =A0 =A0 =A0 =A0print "Exception in stop_wkld", e
> + =A0 =A0 =A0 =A0sys.exit(1)

Why pkill ... why not killall? I don't remember pkill existing on my system?

Plus, if you have the pids you can nuke 'em with os.kill instead of doing t=
his.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
