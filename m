Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oo8am-00005i-5l
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 05:32:08 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oo8aj-0003q4-L1
	for ltp-list@lists.sourceforge.net; Wed, 25 Aug 2010 05:32:08 +0000
Received: by bwz12 with SMTP id 12so431956bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Aug 2010 22:31:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C73452A.3020006@cn.fujitsu.com>
References: <4C73452A.3020006@cn.fujitsu.com>
Date: Tue, 24 Aug 2010 22:31:59 -0700
Message-ID: <AANLkTi=Dky57c3S+NS_adO9Z-Tytp0d0hcyxPJA_DqrM@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Add ftrace-stress-test to LTP
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Aug 23, 2010 at 9:06 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
> We test ftrace by forking processes to simultaneously and
> constantly read/write different tracing files in debugfs
> and procfs.
>
> The test will be skipped if the kernel is older than 2.6.34,
> mainly because it can crash old kernels.
>
> The test will run by default and will run for 90 seconds.
>
> To run this test only:
>
> =A0 =A0 =A0 =A0# ./runltp -f tracing
>
> Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
> ---
> =A0runltp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> =A0runtest/tracing =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0testcases/kernel/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A02 +-
> =A0testcases/kernel/tracing/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A05 +
> =A0.../kernel/tracing/ftrace_stress_test/Makefile =A0 =A0 | =A0 =A07 +
> =A0.../ftrace_stress_test/ftrace_get_page_size.c =A0 =A0 =A0| =A0 10 +
> =A0.../tracing/ftrace_stress_test/ftrace_kvercmp.c =A0 =A0| =A0 37 +++
> =A0.../ftrace_stress/ftrace_buffer_size.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 4=
3 ++++
> =A0.../ftrace_stress/ftrace_current_tracer.sh =A0 =A0 =A0 =A0 | =A0 34 +++
> =A0.../ftrace_stress/ftrace_ftrace_enabled.sh =A0 =A0 =A0 =A0 | =A0 39 ++=
++
> =A0.../ftrace_stress/ftrace_profile_enabled.sh =A0 =A0 =A0 =A0| =A0 50 ++=
++
> =A0.../ftrace_stress/ftrace_set_event.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 44 ++++
> =A0.../ftrace_stress/ftrace_set_ftrace_pid.sh =A0 =A0 =A0 =A0 | =A0 44 ++=
++
> =A0.../ftrace_stress/ftrace_stack_max_size.sh =A0 =A0 =A0 =A0 | =A0 39 ++=
++
> =A0.../ftrace_stress/ftrace_stack_trace.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 4=
6 ++++
> =A0.../ftrace_stress/ftrace_trace.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 27 +++
> =A0.../ftrace_stress/ftrace_trace_clock.sh =A0 =A0 =A0 =A0 =A0 =A0| =A0 4=
6 ++++
> =A0.../ftrace_stress/ftrace_trace_options.sh =A0 =A0 =A0 =A0 =A0| =A0 42 =
++++
> =A0.../ftrace_stress/ftrace_trace_pipe.sh =A0 =A0 =A0 =A0 =A0 =A0 | =A0 4=
3 ++++
> =A0.../ftrace_stress/ftrace_trace_stat.sh =A0 =A0 =A0 =A0 =A0 =A0 | =A0 4=
5 ++++
> =A0.../ftrace_stress/ftrace_tracing_enabled.sh =A0 =A0 =A0 =A0| =A0 39 ++=
++
> =A0.../ftrace_stress/ftrace_tracing_max_latency.sh =A0 =A0| =A0 38 +++
> =A0.../ftrace_stress/ftrace_tracing_on.sh =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
9 ++++
> =A0.../ftrace_stress_test/ftrace_stress_test.sh =A0 =A0 =A0 | =A0237 ++++=
++++++++++++++++
> =A024 files changed, 959 insertions(+), 2 deletions(-)
> =A0create mode 100644 runtest/tracing
> =A0create mode 100644 testcases/kernel/tracing/Makefile
> =A0create mode 100644 testcases/kernel/tracing/ftrace_stress_test/Makefile
> =A0create mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
get_page_size.c
> =A0create mode 100644 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
kvercmp.c
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_buffer_size.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_current_tracer.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_ftrace_enabled.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_profile_enabled.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_set_event.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_set_ftrace_pid.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_stack_max_size.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_stack_trace.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace_clock.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace_options.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace_pipe.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace_stat.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_tracing_enabled.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_tracing_max_latency.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_tracing_on.sh
> =A0create mode 100755 testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress_test.sh
>
> diff --git a/runltp b/runltp
> index b385984..89b1717 100755
> --- a/runltp
> +++ b/runltp
> @@ -593,7 +593,8 @@ main()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/runtest/num=
a =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/runtest/hug=
etlb =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0${LTPROOT}/runtest/com=
mands =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LTPROOT}/runtest/hype=
rthreading
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LTPROOT}/runtest/hype=
rthreading =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LTPROOT}/runtest/trac=
ing
> =A0 =A0 =A0 =A0 do
> =A0 =A0 =A0 =A0 =A0 =A0 [ -e "$SCENFILES" ] || \
> =A0 =A0 =A0 =A0 =A0 =A0 {
> diff --git a/runtest/tracing b/runtest/tracing
> new file mode 100644
> index 0000000..ef3a048
> --- /dev/null
> +++ b/runtest/tracing
> @@ -0,0 +1,2 @@
> +#DESCRIPTION:Tracing testing
> +ftrace-stress-test =A0 =A0 ftrace_stress_test.sh 90
> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index e2a9d8e..8c50025 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -30,7 +30,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
> =A0ifneq ($(UCLINUX),1)
> =A0SUBDIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D containers connectors cont=
rollers fs hotplug io ipc mem \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 numa performance_counters power_manag=
ement pty sched \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0security syscalls timers
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0security syscalls timers tracing
> =A0else
> =A0SUBDIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D syscalls
> =A0endif
> diff --git a/testcases/kernel/tracing/Makefile b/testcases/kernel/tracing=
/Makefile
> new file mode 100644
> index 0000000..e9f96c3
> --- /dev/null
> +++ b/testcases/kernel/tracing/Makefile
> @@ -0,0 +1,5 @@
> +top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D ../../..
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/Makefile b/testc=
ases/kernel/tracing/ftrace_stress_test/Makefile
> new file mode 100644
> index 0000000..e4a913a
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/Makefile
> @@ -0,0 +1,7 @@
> +top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS =A0 =A0 =A0 =A0 :=3D *.sh ftrace_stress/*
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_=
size.c b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> new file mode 100644
> index 0000000..b52a109
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_get_page_size.c
> @@ -0,0 +1,10 @@
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +int main(void)
> +{
> + =A0 =A0 =A0 printf("%d\n", getpagesize());
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c=
 b/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
> new file mode 100644
> index 0000000..bd67b37
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
> @@ -0,0 +1,37 @@
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/utsname.h>
> +
> +int main(int argc, char **argv)
> +{
> + =A0 =A0 =A0 struct utsname uval;
> + =A0 =A0 =A0 int k1, k2, k3;
> + =A0 =A0 =A0 int a1, a2, a3;
> + =A0 =A0 =A0 unsigned long r1, r2;
> +
> + =A0 =A0 =A0 if (argc !=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Wrong arguments!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 a1 =3D strtol(argv[1], NULL, 10);
> + =A0 =A0 =A0 a2 =3D strtol(argv[2], NULL, 10);
> + =A0 =A0 =A0 a3 =3D strtol(argv[3], NULL, 10);
> +
> + =A0 =A0 =A0 uname(&uval);
> +
> + =A0 =A0 =A0 sscanf(uval.release, "%d.%d.%d", &k1, &k2, &k3);
> +
> + =A0 =A0 =A0 r1 =3D (a1 << 16) + (a2 << 8) + a3;
> + =A0 =A0 =A0 r2 =3D (k1 << 16) + (k2 << 8) + k3;
> +
> + =A0 =A0 =A0 if (r1 > r2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 else if (r1 =3D=3D r2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
> +}

This application could be replaced with tst_kvercmp out of the box;
there's no reason why another program needs to be created for this.

> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_buffer_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_st=
ress/ftrace_buffer_size.sh
> new file mode 100755
> index 0000000..af5a98e
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_bu=
ffer_size.sh
> @@ -0,0 +1,43 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D200
> +
> +# Use up to 10% of free memory
> +free_mem=3D`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
> +step=3D$(( $free_mem / 10 / $LOOP ))
> +if [ $step -eq 0 ]; then
> + =A0 =A0 =A0 $step=3D1
> + =A0 =A0 =A0 LOOP=3D50
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 new_size=3D1
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $new_size > "$TRACING_PATH"/buffer_siz=
e_kb
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_size=3D$(( $new_size + $step ))
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_size=3D$(( $new_size - $step ))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $new_size > "$TRACING_PATH"/buffer_siz=
e_kb
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_current_tracer.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace=
_stress/ftrace_current_tracer.sh
> new file mode 100755
> index 0000000..1baed96
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_cu=
rrent_tracer.sh
> @@ -0,0 +1,34 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D200
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for tracer in `cat "$TRACING_PATH"/availabl=
e_tracers`;

If you're going to split the for section of the loop from the do
section, there's no need to use a semicolon.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$tracer" =3D=3D mmiot=
race ]; then

Bashism. Replace =3D=3D with =3D .

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $tracer > "$TRACING_PA=
TH"/current_tracer 2> /dev/null
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 done
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_ftrace_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace=
_stress/ftrace_ftrace_enabled.sh
> new file mode 100755
> index 0000000..20bb234
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_ft=
race_enabled.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_LOOP=3D1500
> +count=3D0
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 count=3D$(( $count + 1 ))
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /proc/sys/kernel/ftrace_enabled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > /proc/sys/kernel/ftrace_enabled
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 enable=3D$(( $count % 3 ))
> +
> + =A0 =A0 =A0 if [ $enable -eq 0 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > /proc/sys/kernel/ftrace_enabled
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /proc/sys/kernel/ftrace_enabled
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_profile_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrac=
e_stress/ftrace_profile_enabled.sh
> new file mode 100755
> index 0000000..9c6162a
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_pr=
ofile_enabled.sh
> @@ -0,0 +1,50 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_LOOP=3D1500
> +count=3D0
> +
> +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> + =A0 =A0 =A0 should_skip=3D1
> +else
> + =A0 =A0 =A0 should_skip=3D0
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 count=3D$(( $count + 1 ))
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/function_profile_e=
nabled 2> /dev/null
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/function_profile_e=
nabled 2> /dev/null
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 enable=3D$(( $count % 3 ))
> +
> + =A0 =A0 =A0 if [ $enable -eq 0 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/function_profile_e=
nabled 2> /dev/null
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/function_profile_e=
nabled 2> /dev/null
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_set_event.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stre=
ss/ftrace_set_event.sh
> new file mode 100755
> index 0000000..f876414
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_se=
t_event.sh
> @@ -0,0 +1,44 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 for ((i =3D 0; i < 100; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/events/enable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/events/enable
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for dir in `ls $TRACING_PATH/events/`;
> + =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ ! -d $dir -o "$dir" =3D=3D ftrace ]; t=
hen
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ((i =3D 0; i < 20; i++))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/ev=
ents/$dir/enable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/ev=
ents/$dir/enable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 done
> +
> + =A0 =A0 =A0 for event in `cat $TRACING_PATH/available_events`;
> + =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $event >> "$TRACING_PATH"/set_event
> + =A0 =A0 =A0 done
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace=
_stress/ftrace_set_ftrace_pid.sh
> new file mode 100755
> index 0000000..541215c
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_se=
t_ftrace_pid.sh
> @@ -0,0 +1,44 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D300
> +
> +if [ ! -e "$TRACING_PATH"/set_ftrace_pid ]; then
> + =A0 =A0 =A0 should_skip=3D1
> +else
> + =A0 =A0 =A0 should_skip=3D0
> +fi
> +
> +for ((; ; ))
> +{
> + =A0 =A0 =A0 if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 for ((j =3D 0; j < $LOOP; j++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ((k =3D 1; k <=3D NR_PIDS; k++))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=3D"\$pid$k"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eval echo $str >> "$TRACING=
_PATH"/set_ftrace_pid
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo > "$TRACING_PATH"/set_ftrace_pid
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_stack_max_size.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace=
_stress/ftrace_stack_max_size.sh
> new file mode 100755
> index 0000000..682d05e
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_st=
ack_max_size.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_STACK_SIZE=3D8192
> +
> +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> + =A0 =A0 =A0 should_skip=3D1
> +else
> + =A0 =A0 =A0 should_skip=3D0
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_STACK_SIZE; i +=3D 70))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $i > "$TRACING_PATH"/stack_max_size
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TRACING_PATH"/stack_max_size > /dev/n=
ull
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_stack_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_st=
ress/ftrace_stack_trace.sh
> new file mode 100755
> index 0000000..a406c51
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_st=
ack_trace.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D400
> +
> +if [ ! -e /proc/sys/kernel/stack_tracer_enabled ]; then
> + =A0 =A0 =A0 should_skip=3D1
> +else
> + =A0 =A0 =A0 should_skip=3D0
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TRACING_PATH"/stack_trace > /dev/null
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > /proc/sys/kernel/stack_tracer_enab=
led
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > /proc/sys/kernel/stack_tracer_enab=
led
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_trace.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/f=
trace_trace.sh
> new file mode 100755
> index 0000000..e36712b
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
ace.sh
> @@ -0,0 +1,27 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D200
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TRACING_PATH"/trace > /dev/null
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_trace_clock.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_st=
ress/ftrace_trace_clock.sh
> new file mode 100755
> index 0000000..51f2507
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
ace_clock.sh
> @@ -0,0 +1,46 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D400
> +
> +# In kernel which is older than 2.6.32, we set global clock
> +# via trace_options.
> +./ftrace_kvercmp 2 6 32
> +if [ $? -eq 0 ]; then
> + =A0 =A0 =A0 =A0old_kernel=3D1
> +else
> + =A0 =A0 =A0 =A0old_kernel=3D0
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 if [ $old_kernel -eq 1 ];
> + =A0 =A0 =A0 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/op=
tions/global-clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/op=
tions/global-clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo local > "$TRACING_PATH=
"/trace_clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo global > "$TRACING_PAT=
H"/trace_clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_trace_options.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_=
stress/ftrace_trace_options.sh
> new file mode 100755
> index 0000000..47d2a62
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
ace_options.sh
> @@ -0,0 +1,42 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D200
> +
> +trace_options=3D(print-parent sym-offset sym-addr verbose raw hex bin bl=
ock trace_printk ftrace_preempt branch annotate userstacktrace sym-userobj =
printk-msg-only context-info latency-format sleep-time graph-time)
> +
> +NR_TRACE_OPTIONS=3D19
> +
> +for ((; ; ))
> +{
> + =A0 =A0 =A0 for ((j =3D 0; j < $LOOP; j++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num=3D`date +%N`
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 num=3D`printf 1%s $num`
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for ((i =3D 0; i < $NR_TRACE_OPTIONS; i++))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 n=3D$(( ( $num >> $i ) % 2 =
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $n -eq 0 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$=
TRACING_PATH"/options/${trace_options[$i]}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$=
TRACING_PATH"/options/${trace_options[$i]}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_trace_pipe.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_str=
ess/ftrace_trace_pipe.sh
> new file mode 100755
> index 0000000..cccb7ae
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
ace_pipe.sh
> @@ -0,0 +1,43 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +kill_this_pid()
> +{
> + =A0 =A0 =A0 /bin/kill -SIGKILL $this_pid

kill shouldn't be explicitly called out as /bin/kill. IIRC there are
some distros out there that place this elsewhere.

> + =A0 =A0 =A0 wait $this_pid
> + =A0 =A0 =A0 exit 0
> +}
> +
> +trap kill_this_pid SIGUSR1
> +
> +LOOP=3D20
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TRACING_PATH"/trace_pipe > /dev/null &
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 this_pid=3D$!
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep 200000

Is usleep a standard linux command (I didn't think so, but I could be wrong=
..)?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /bin/kill -SIGINT $this_pid
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait $this_pid
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 this_pid=3D0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep 200000
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 2
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_trace_stat.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_str=
ess/ftrace_trace_stat.sh
> new file mode 100755
> index 0000000..ad6859f
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
ace_stat.sh
> @@ -0,0 +1,45 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +LOOP=3D200
> +
> +should_skip=3D0
> +
> +if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
> + =A0 =A0 =A0 =A0should_skip=3D1
> +fi
> +
> +# For kernels older than 2.6.36, this testcase can result in
> +# divide-by-zero kernel bug
> +"$TPATH"/ftrace_kvercmp 2 6 36
> +if [ $? -eq 0 ]; then
> + =A0 =A0 =A0 should_skip=3D1
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cat "$TRACING_PATH"/trace_stat/function0 > =
/dev/null 2>&1
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_tracing_enabled.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrac=
e_stress/ftrace_tracing_enabled.sh
> new file mode 100755
> index 0000000..69f2ae6
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
acing_enabled.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_LOOP=3D1500
> +count=3D0
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 count=3D$(( $count + 1 ))
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/tracing_enabled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/tracing_enabled
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 enable=3D$(( $count % 3 ))
> +
> + =A0 =A0 =A0 if [ $enable -eq 0 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/tracing_enabled
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/tracing_enabled
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_tracing_max_latency.sh b/testcases/kernel/tracing/ftrace_stress_test/f=
trace_stress/ftrace_tracing_max_latency.sh
> new file mode 100755
> index 0000000..f19d734
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
acing_max_latency.sh
> @@ -0,0 +1,38 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_LATENCY=3D100000
> +
> +if [ ! -e "$TRACING_PATH"/tracing_max_latency ]; then
> + =A0 =A0 =A0 =A0should_skip=3D1
> +else
> + =A0 =A0 =A0 =A0should_skip=3D0
> +fi
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 =A0if [ $should_skip -eq 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sleep 2
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue
> + =A0 =A0 =A0 =A0fi
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_LATENCY; i +=3D 400))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $i > "$TRACING_PATH"/tracing_max_laten=
cy
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ft=
race_tracing_on.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_str=
ess/ftrace_tracing_on.sh
> new file mode 100755
> index 0000000..672c223
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_tr=
acing_on.sh
> @@ -0,0 +1,39 @@
> +#! /bin/sh
> +
> +########################################################################=
#######
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# This program is free software; you can redistribute it and/or modify i=
t =A0 =A0 #
> +# under the terms of the GNU General Public License as published by the =
Free =A0#
> +# Software Foundation; either version 2 of the License, or (at your opti=
on) =A0 #
> +# any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +# Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 #
> +########################################################################=
#######
> +
> +MAX_LOOP=3D1500
> +count=3D0
> +
> +for ((; ;))
> +{
> + =A0 =A0 =A0 count=3D$(( $count + 1 ))
> +
> + =A0 =A0 =A0 for ((i =3D 0; i < $MAX_LOOP; i++))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/tracing_on
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/tracing_on
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 enable=3D$(( $count % 3 ))
> +
> + =A0 =A0 =A0 if [ $enable -eq 0 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > "$TRACING_PATH"/tracing_on
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 1 > "$TRACING_PATH"/tracing_on
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 sleep 1
> +}
> +
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_te=
st.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> new file mode 100755
> index 0000000..3e6c4b7
> --- /dev/null
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress_test.sh
> @@ -0,0 +1,237 @@
> +#! /bin/sh
> +
> +########################################################################=
########
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## Copyright (c) 2010 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is free software; =A0you can redistribute it and#or modi=
fy =A0 =A0 =A0##
> +## it under the terms of the GNU General Public License as published by =
=A0 =A0 =A0 ##
> +## the Free Software Foundation; either version 2 of the License, or =A0=
 =A0 =A0 =A0 =A0##
> +## (at your option) any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## This program is distributed in the hope that it will be useful, but =
=A0 =A0 =A0 =A0##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTAB=
ILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE. =A0See the GNU General Public Li=
cense =A0 ##
> +## for more details. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## You should have received a copy of the GNU General Public License =A0=
 =A0 =A0 =A0 =A0##
> +## along with this program; =A0if not, write to the Free Software =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA =A0 =A0##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +## Author: Li Zefan <lizf@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> +## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0##
> +########################################################################=
########
> +
> +cd $LTPROOT/testcases/bin
> +
> +export TCID=3D"ftrace-stress-test"
> +export TST_TOTAL=3D1
> +export TST_COUNT=3D1
> +
> +export TPATH=3D"$PWD"
> +export DEBUGFS_PATH=3D"$PWD/debugfs"
> +export TRACING_PATH=3D"$PWD/debugfs/tracing"
> +export SPATH=3D"$TPATH/ftrace_stress"
> +
> +test_interval=3D$1
> +
> +save_old_setting()
> +{
> + =A0 =A0 =A0 cd $TRACING_PATH
> +
> + =A0 =A0 =A0 old_trace_options=3D( `cat trace_options` )
> + =A0 =A0 =A0 old_tracing_on=3D`cat tracing_on`
> + =A0 =A0 =A0 old_tracing_enabled=3D`cat tracing_enabled`
> + =A0 =A0 =A0 old_buffer_size=3D`cat buffer_size_kb`
> +
> + =A0 =A0 =A0 if [ -e stack_max_size ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_stack_tracer_enabled=3D`cat /proc/sys/k=
ernel/stack_tracer_enabled`
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_ftrace_enabled=3D`cat /proc/sys/kernel/=
ftrace_enabled`
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 if [ -e "function_profile_enabled" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_profile_enabled=3D`cat function_profile=
_enabled`
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 cd - > /dev/null
> +}
> +
> +restore_old_setting()
> +{
> + =A0 =A0 =A0 cd $TRACING_PATH
> +
> + =A0 =A0 =A0 echo nop > current_tracer
> + =A0 =A0 =A0 echo 0 > events/enable
> + =A0 =A0 =A0 echo 0 > tracing_max_latency 2> /dev/null
> +
> + =A0 =A0 =A0 if [ -e trace_clock ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo local > trace_clock
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 if [ -e "function_pofile_enabled" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $old_profile_enabled > function_profil=
e_enabled
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 if [ -e "/proc/sys/kernel/ftrace_enabled" ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $old_ftrace_enabled > /proc/sys/kernel=
/ftrace_enabled
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 if [ -e stack_max_size ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $old_stack_tracer_enabled > /proc/sys/=
kernel/stack_tracer_enabled
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo 0 > stack_max_size
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 echo $old_buffer_size > buffer_size_kb
> + =A0 =A0 =A0 echo $old_tracing_on > tracing_on
> + =A0 =A0 =A0 echo $old_tracing_enabled > tracing_enabled
> +
> + =A0 =A0 =A0 for option in ${old_trace_options[*]};

Arrays don't exist in portable shell; just do something like:

for option in $old_trace_options

Will the options contain spaces (and hence, be split by accident)?

> + =A0 =A0 =A0 do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo $option > trace_options 2> /dev/null
> + =A0 =A0 =A0 done
> +
> + =A0 =A0 =A0 echo > trace
> +
> + =A0 =A0 =A0 cd - > /dev/null
> +}
> +
> +clean_up()
> +{
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid1
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid2
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid3
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid4
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid5
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid6
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid7
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid8
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid9
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid10
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid11
> + =A0 =A0 =A0 /bin/kill -SIGUSR1 $pid12
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid13
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid14
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid15
> + =A0 =A0 =A0 /bin/kill -SIGKILL $pid16
> +
> + =A0 =A0 =A0 sleep 2
> + =A0 =A0 =A0 restore_old_setting
> +
> + =A0 =A0 =A0 umount $DEBUGFS_PATH
> + =A0 =A0 =A0 rmdir $DEBUGFS_PATH
> +}
> +
> +clean_up_exit()
> +{
> + =A0 =A0 =A0 clean_up
> + =A0 =A0 =A0 exit 1
> +}
> +
> +export_pids()
> +{
> + =A0 =A0 =A0 export pid1 pid2 pid3 pid4 pid5 pid6 pid7 pid8 pid9 pid10 p=
id11 pid12 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pid13 pid14 pid15 pid16
> +
> + =A0 =A0 =A0 export NR_PIDS=3D16
> +}
> +
> +test_begin()
> +{
> + =A0 =A0 =A0 start_time=3D`date +%s`
> +}
> +
> +test_wait()
> +{
> + =A0 =A0 =A0 for ((; ;))
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep 2
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cur_time=3D`date +%s`
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 elapsed=3D$(( $cur_time - $start_time ))
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 # run the stress test for $test_interval se=
cs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $elapsed -ge $test_interval ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 }
> +}
> +
> +trap clean_up_exit SIGINT
> +
> +# Should be run by root user
> +if [ "`whoami`" !=3D "root" ]; then

id -ru =3D 0 is better.

> + =A0 =A0 =A0 tst_brkm TCONF ignored "The test should be run by root user=
. Skip the test..."
> + =A0 =A0 =A0 exit 0
> +fi
> +
> +# Don't run the test on kernels older than 2.6.34, otherwise
> +# it can crash the system if the kernel is not latest-stable
> +./ftrace_kvercmp 2 6 34
> +if [ $? -eq 0 ]; then
> + =A0 =A0 =A0 tst_brkm TCONF ignored "The test should be run in kernels >=
=3D 2.6.34. Skip the test..."
> + =A0 =A0 =A0 exit 0
> +fi
> +
> +mkdir $DEBUGFS_PATH
> +mount -t debugfs xxx $DEBUGFS_PATH
> +
> +# Check to see tracing feature is supported or not
> +if [ ! -d $TRACING_PATH ]; then
> + =A0 =A0 =A0 tst_brkm TCONF ignored "Tracing is not supported. Skip the =
test..."
> + =A0 =A0 =A0 umount $DEBUGFS_PATH
> + =A0 =A0 =A0 rmdir $DEBUGFS_PATH
> + =A0 =A0 =A0 exit 0
> +fi
> +
> +echo "Ftrace Stress Test Begin"
> +
> +save_old_setting
> +
> +test_begin
> +
> +$SPATH/ftrace_trace_clock.sh &
> +pid1=3D$!
> +$SPATH/ftrace_current_tracer.sh &
> +pid2=3D$!
> +$SPATH/ftrace_trace_options.sh &
> +pid3=3D$!
> +$SPATH/ftrace_tracing_max_latency.sh &
> +pid4=3D$!
> +$SPATH/ftrace_stack_trace.sh &
> +pid5=3D$!
> +$SPATH/ftrace_stack_max_size.sh &
> +pid6=3D$!
> +$SPATH/ftrace_tracing_on.sh &
> +pid7=3D$!
> +$SPATH/ftrace_tracing_enabled.sh &
> +pid8=3D$!
> +$SPATH/ftrace_set_event.sh &
> +pid9=3D$!
> +$SPATH/ftrace_buffer_size.sh &
> +pid10=3D$!
> +$SPATH/ftrace_trace.sh &
> +pid11=3D$!
> +$SPATH/ftrace_trace_pipe.sh &
> +pid12=3D$!
> +$SPATH/ftrace_ftrace_enabled.sh &
> +pid13=3D$!
> +$SPATH/ftrace_set_ftrace_pid.sh &
> +pid14=3D$!
> +$SPATH/ftrace_profile_enabled.sh &
> +pid15=3D$!
> +$SPATH/ftrace_trace_stat.sh &
> +pid16=3D$!
> +
> +export_pids
> +
> +test_wait
> +
> +clean_up
> +
> +echo "Ftrace Stress Test End"
> +
> +tst_resm TPASS "finished running the test. Run dmesg to double-check for=
 bugs"

---------------------------------------------------------------------------=
---
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users =

worldwide. Take advantage of special opportunities to increase revenue and =

speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
