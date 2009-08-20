Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeB1U-00027E-Hh
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 17:02:00 +0000
Received: from qw-out-1920.google.com ([74.125.92.144])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeB1Q-0007ns-V5
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 17:02:00 +0000
Received: by qw-out-1920.google.com with SMTP id 5so24394qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 10:01:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160741.30926.293.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160741.30926.293.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 10:01:50 -0700
Message-ID: <364299f40908201001q30e8859t85aa3cd38205872e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch for PM makefile for new testcases & fix
	test_sched_smt integration issue
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

On Thu, Aug 20, 2009 at 9:07 AM, Poornima
Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> Patch to integrate test_sched_smt and timer_migration testcase to LTP.
> Also intergrates the new file get_sched_value to LTP.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/Makef=
ile ltp-full-20090731/testcases/kernel/power_management/Makefile
> --- ltp-full-20090731_orig/testcases/kernel/power_management/Makefile =A0=
 2009-08-20 19:59:11.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/Makefile =A0 =A0 =
=A0 =A02009-08-20 20:26:39.000000000 +0530
> @@ -23,12 +23,16 @@ SUBDIRS :=3D
> =A0all:
> =A0 =A0 =A0 =A0@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done;
> =A0 =A0 =A0 =A0$(MAKE) check_kv_arch ;
> + =A0 =A0 =A0 $(MAKE) get_sched_values ;
>
> -check_kv_arch: check_kv_arch.c
> +check_kv_arch: check_kv_arch.c
> + =A0 =A0 =A0 $(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../include
> +get_sched_values: get_sched_values.c
> =A0 =A0 =A0 =A0$(CC) -o $@ $< ../../../lib/tst_kvercmp.c -I../../../inclu=
de
>
> =A0install:
> =A0 =A0 =A0 =A0@set -e; ln -f check_kv_arch ../../bin/check_kv_arch; \
> + =A0 =A0 =A0 ln -f get_sched_values ../../bin/get_sched_values; \
> =A0 =A0 =A0 =A0ln -f =A0change_freq.sh ../../bin/change_freq.sh; \
> =A0 =A0 =A0 =A0ln -f =A0change_govr.sh ../../bin/change_govr.sh; \
> =A0 =A0 =A0 =A0ln -f =A0check_cpufreq_sysfs_files.sh ../../bin/check_cpuf=
req_sysfs_files.sh; \
> @@ -37,6 +41,8 @@ install:
> =A0 =A0 =A0 =A0ln -f =A0pm_include.sh ../../bin/pm_include.sh; \
> =A0 =A0 =A0 =A0ln -f =A0runpwtests.sh ../../bin/runpwtests.sh; \
> =A0 =A0 =A0 =A0ln -f =A0test_sched_mc.sh ../../bin/test_sched_mc.sh; \
> + =A0 =A0 =A0 ln -f =A0test_sched_mc.sh ../../bin/test_sched_smt.sh; \
> + =A0 =A0 =A0 ln -f =A0test_sched_mc.sh ../../bin/test_timer_migration.sh=
; \
> =A0 =A0 =A0 =A0ln -f =A0config_cpu_freq ../../bin/config_cpu_freq; \
> =A0 =A0 =A0 =A0ln -f =A0config_cpu_idle ../../bin/config_cpu_idle; \
> =A0 =A0 =A0 =A0ln -f =A0config_sched_mc ../../bin/config_sched_mc;
> @@ -47,4 +53,4 @@ install:
> =A0clean:
> =A0 =A0 =A0 =A0@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i $@ ; done
> =A0 =A0 =A0 =A0rm -f check_kv_arch
> -
> + =A0 =A0 =A0 rm -f get_sched_values

Please don't worry about this. It's handled in my makefile-infra-rework pat=
ch.
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
