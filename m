Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeAzl-0001vX-5l
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 17:00:13 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeAze-0004Eg-VO
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 17:00:12 +0000
Received: by qw-out-1920.google.com with SMTP id 5so23548qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 10:00:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160800.30926.41644.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160800.30926.41644.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 10:00:01 -0700
Message-ID: <364299f40908201000j27cd7e59vc35ec018e88002db@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch to fix cpu consolidation failure for kernbench on
	HT system
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, Aug 20, 2009 at 9:08 AM, Poornima
Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> Threshold and validation functions modified for testcases run on HT syste=
ms.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/lib/s=
ched_mc.py ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc=
.py
> --- ltp-full-20090731_orig/testcases/kernel/power_management/lib/sched_mc=
.py =A0 =A02009-08-20 19:59:11.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/lib/sched_mc.py 2=
009-08-20 20:33:21.000000000 +0530
> @@ -193,6 +193,8 @@ def trigger_ebizzy (stress, duration, ba
> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D get_hyper_thread_count()
> =A0 =A0 =A0 =A0 if stress =3D=3D "partial":
> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count / socket_count
> + =A0 =A0 =A0 =A0 =A0 =A0if is_hyper_threaded():
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0threads =3D threads / get_hyper_thread_c=
ount()
> =A0 =A0 =A0 =A0 if stress =3D=3D "full":
> =A0 =A0 =A0 =A0 =A0 =A0threads =3D cpu_count
>
> @@ -244,9 +246,11 @@ def trigger_kernbench (stress, backgroun
> =A0 =A0 olddir =3D os.getcwd()
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 if stress =3D=3D "thread":
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 threads =3D 2
> + =A0 =A0 =A0 =A0 =A0 threads =3D 2
> =A0 =A0 =A0 =A0 if stress =3D=3D "partial":
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count / socket_count
> + =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count / socket_count
> + =A0 =A0 =A0 =A0 =A0 =A0if is_hyper_threaded():
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0threads =3D threads / get_hyper_thread_c=
ount()
> =A0 =A0 =A0 =A0 if stress =3D=3D "full":
> =A0 =A0 =A0 =A0 =A0 =A0 threads =3D cpu_count
>
> @@ -281,7 +285,8 @@ def trigger_kernbench (stress, backgroun
> =A0 =A0 =A0 =A0 =A0 =A0sys.exit(1)
>
> =A0 =A0 =A0 =A0 get_proc_data(stats_start)
> - =A0 =A0 =A0 =A0os.system ( '%s/kernbench -o 2 -M -H -n 1 >/dev/null 2>&=
1' % benchmark_path)
> + =A0 =A0 =A0 =A0os.system ( '%s/kernbench -o %s -M -H -n 1 >/dev/null 2>=
&1' % (benchmark_path, threads))
> + =A0 =A0 =A0 =A0print threads
>
> =A0 =A0 =A0 =A0 print "INFO: Workload kernbench triggerd"
> =A0 =A0 =A0 =A0 os.chdir(olddir)
> @@ -438,6 +443,8 @@ def validate_cpugrp_map(cpu_group, sched
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for i in range(0, len(cor=
e_cpus)):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if core_cpus[i] i=
n modi_cpu_grp:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 modi_cpu_=
grp.remove(core_cpus[i])
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if len(m=
odi_cpu_grp) =3D=3D 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
return 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # If sche=
d_smt =3D=3D 0 then its oky if threads run
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # in diff=
erent cores of same package
> @@ -499,24 +506,35 @@ def verify_sched_domain_dmesg(sched_mc_l
> =A0 =A0 =A0 =A0 print "Reading dmesg failed", details
> =A0 =A0 =A0 =A0 sys.exit(1)
>
> -def validate_cpu_consolidation(sched_mc_level, sched_smt_level):
> +def validate_cpu_consolidation(work_ld, sched_mc_level, sched_smt_level):
> =A0 =A0 ''' Verify if cpu's on which threads executed belong to same
> =A0 =A0 package
> =A0 =A0 '''
> =A0 =A0 cpus_utilized =3D list()
> =A0 =A0 try:
> =A0 =A0 =A0 =A0 for l in sorted(stats_percentage.keys()):
> - =A0 =A0 =A0 =A0 =A0 #modify threshold
> - =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 50:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0].split(=
"cpu")
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.append(int(cpu_id[=
1]))
> - =A0 =A0 =A0 =A0cpus_utilized.sort()
> + =A0 =A0 =A0 =A0 =A0 =A0#modify threshold
> + =A0 =A0 =A0 =A0 =A0 =A0if is_hyper_threaded():
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 25 and work_=
ld =3D=3D "kernbench":
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0=
].split("cpu")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.append(int=
(cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 50:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percent=
age[l][0].split("cpu")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.ap=
pend(int(cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0else:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if stats_percentage[l][1] > 50:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_id =3D stats_percentage[l][0=
].split("cpu")
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if cpu_id[1] !=3D '':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.append(int=
(cpu_id[1]))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpus_utilized.sort()
> =A0 =A0 =A0 =A0 print "INFO: CPU's utilized ", cpus_utilized
>
> =A0 =A0 =A0 =A0 status =3D validate_cpugrp_map(cpus_utilized, sched_mc_le=
vel, sched_smt_level)
> - =A0 =A0 =A0 if status =3D=3D 1:
> - =A0 =A0 =A0 =A0 =A0 print "INFO: CPUs utilized is not in same package o=
r core"
> + =A0 =A0 =A0 =A0if status =3D=3D 1:
> + =A0 =A0 =A0 =A0 =A0 =A0print "INFO: CPUs utilized is not in same packag=
e or core"
> =A0 =A0 =A0 =A0 return(status)
> =A0 =A0 except Exception, details:
> =A0 =A0 =A0 =A0 print "Exception in validate_cpu_consolidation: ", details

Why hyperthreaded? Why not multicore? I ask because hyperthreaded
processors are more difficult to disable and regulate IIRC (had to be
done at bootup), whereas multicore processors can be regulated by the
kernel scheduler and the relevant core setting.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
