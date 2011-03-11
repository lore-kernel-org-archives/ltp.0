Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PxuJ7-0003KR-Sh
	for ltp-list@lists.sourceforge.net; Fri, 11 Mar 2011 04:50:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PxuJ6-0004F0-MO
	for ltp-list@lists.sourceforge.net; Fri, 11 Mar 2011 04:50:33 +0000
Date: Fri, 11 Mar 2011 12:54:51 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110311045451.GC2974@hpt.nay.redhat.com>
References: <20110225103620.GA10350@hpt.nay.redhat.com>
	<AANLkTi=_K2Q1iYtN0T6izFmnmeEe1Tyyst1CzRHiN+Yg@mail.gmail.com>
	<20110307072901.GB2877@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110307072901.GB2877@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH] thp testcase come from CVE reproducer
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Mon, Mar 07, 2011 at 03:29:01PM +0800, Han Pingtian wrote:
> On Fri, Mar 04, 2011 at 02:38:51AM -0800, Garrett Cooper wrote:
> > On Fri, Feb 25, 2011 at 2:36 AM, Han Pingtian <phan@redhat.com> wrote:
> > > This is a reproducer of =A0CVE-2011-0999, which fixed by mainline com=
mit
> > > a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
> > >
> > > "Transparent hugepages can only be created if rmap is fully
> > > functional. So we must prevent hugepages to be created while
> > > is_vma_temporary_stack() is true."
> > >
> > > When running in a loop, it can trigger panic like this, if kernel
> > > unpatched:
> > >
> > > kernel BUG at mm/huge_memory.c:1260!
> > > invalid opcode: 0000 [#1] SMP
> > > last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cp=
u_map
> > =

> > ...
> > =

> > > +static option_t options[] =3D {
> > > + =A0 =A0 =A0 {NULL, NULL, NULL}
> > > +};
> > > +
> > > +static void usage(void)
> > > +{
> > > + =A0 =A0return;
> > > +}
> > =

> > You can delete this if you do what I suggest below...
> > =

> > ...
> > =

> > > + =A0 =A0 =A0 msg =3D parse_opts(argc, argv, options, usage);
> > > + =A0 =A0 =A0 if (msg !=3D NULL)
> > =

> > `if ((msg =3D parse_opts(argc, argv, NULL, NULL)) !=3D NULL)' is prefer=
red.
> Thanks. I have updated this according to your suggestion.
> > =

> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (exe=
cve("/bin/true", c, c) =3D=3D -1)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 tst_brkm(TBROK|TERRNO, NULL, "execve");
> > =

> > Not all systems have /bin/true. It would be better to do:
> > =

> > /bin/sh -c ':'
> > =

> > etc, as we have code that depends on this type of shell-required POSIX =
behavior.
> > =

> I'm sorry for I cannot figure out how to do this way. I tried, but
> cannot crash unpatched kernel anymore. So I think the simple workaround
> is checking if /bin/true installed in the program:
> =

> +
> +                               if (WEXITSTATUS(st) =3D=3D 2)
> +                                       tst_brkm(TBROK, NULL, "Do you hav=
e /bin/true installed?");
> +
> =

Is this acceptable, please?

Thanks.
> Please review the updated version.
> > Thanks,
> > -Garrett
> =

> -- =

> Han Pingtian
> Quality Engineer
> hpt @ #kernel-qe
> Red Hat, Inc
> Freedom ... courage ... Commitment ... ACCOUNTABILITY

> >From 38c3526fdb59c0b18015914745f2d43fc6c6b1a3 Mon Sep 17 00:00:00 2001
> From: Han Pingtian <phan@redhat.com>
> Date: Fri, 25 Feb 2011 17:51:24 +0800
> Subject: [PATCH] thp testcase come from CVE reproducer
> =

> This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
> a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
> =

> "Transparent hugepages can only be created if rmap is fully
> functional. So we must prevent hugepages to be created while
> is_vma_temporary_stack() is true."
> =

> When running in a loop, it can trigger panic like this, if kernel
> unpatched:
> =

> kernel BUG at mm/huge_memory.c:1260!
> invalid opcode: 0000 [#1] SMP
> last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cpu_map
> ....
> =

> So I recommend to run it as 'thp01 -I xxx'.
> =

> Signed-off-by: Han Pingtian <phan@redhat.com>
> ---
>  runtest/mm                        |    2 +
>  testcases/kernel/mem/thp/Makefile |   23 +++++++++
>  testcases/kernel/mem/thp/thp01.c  |   95 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 120 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/thp/Makefile
>  create mode 100644 testcases/kernel/mem/thp/thp01.c
> =

> diff --git a/runtest/mm b/runtest/mm
> index 1296e59..51cc82d 100644
> --- a/runtest/mm
> +++ b/runtest/mm
> @@ -85,3 +85,5 @@ oom01 oom01
>  oom02 oom02
>  oom03 oom03
>  oom04 oom04
> +
> +thp01 thp01 -I 600
> diff --git a/testcases/kernel/mem/thp/Makefile b/testcases/kernel/mem/thp=
/Makefile
> new file mode 100644
> index 0000000..dbfbc1b
> --- /dev/null
> +++ b/testcases/kernel/mem/thp/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (C) 2010  Red Hat, Inc.
> +#
> +#  This program is free software; you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or (at
> +#  your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful, but
> +#  WITHOUT ANY WARRANTY; without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +#  General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program; if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> +#  02110-1301, USA.
> +#
> +
> +top_srcdir              ?=3D ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/mem/thp/thp01.c b/testcases/kernel/mem/thp/=
thp01.c
> new file mode 100644
> index 0000000..0b6ec1a
> --- /dev/null
> +++ b/testcases/kernel/mem/thp/thp01.c
> @@ -0,0 +1,95 @@
> +/*
> + * This is a reproducer of  CVE-2011-0999, which fixed by mainline commit
> + * a7d6e4ecdb7648478ddec76d30d87d03d6e22b31:
> + *
> + * "Transparent hugepages can only be created if rmap is fully
> + * functional. So we must prevent hugepages to be created while
> + * is_vma_temporary_stack() is true."
> + *
> + * It will cause a panic something like this, if the patch didn't get ap=
plied:
> + *
> + * kernel BUG at mm/huge_memory.c:1260!
> + * invalid opcode: 0000 [#1] SMP
> + * last sysfs file: /sys/devices/system/cpu/cpu23/cache/index2/shared_cp=
u_map
> + * ....
> + *
> + * Copyright (C) 2010  Red Hat, Inc.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +#include "test.h"
> +#include "usctest.h"
> +#include "config.h"
> +
> +char *TCID =3D "thp01";
> +int TST_TOTAL =3D 1;
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/resource.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +
> +int main(int argc, char **argv) {
> +	int i, lc, st;
> +	pid_t pid;
> +	char *msg;
> +	char *c[257];
> +	char cc[32*4096];
> +	struct rlimit rl =3D {
> +		.rlim_cur =3D RLIM_INFINITY,
> +		.rlim_max =3D RLIM_INFINITY,
> +	};
> +
> +	if ((msg =3D parse_opts(argc, argv, NULL, NULL)) !=3D NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> +		switch (pid =3D fork()) {
> +			case -1:
> +				tst_brkm(TBROK|TERRNO, NULL, "fork");
> +			case 0:
> +				memset(cc, 'c', 32*4096-1);
> +				for (i=3D0;i<256;i++)
> +					c[i] =3D cc;
> +				if (setrlimit(RLIMIT_STACK, &rl) =3D=3D -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "setrlimit");
> +				if (execve("/bin/true", c, c) =3D=3D -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "execve");
> +			default:
> +				if (waitpid(pid, &st, 0) =3D=3D -1)
> +					tst_brkm(TBROK|TERRNO, NULL, "waitpid");
> +
> +				if (! WIFEXITED(st))
> +					tst_brkm(TBROK, NULL, "child exits abnormally");
> +
> +				if (WEXITSTATUS(st) =3D=3D 2)
> +					tst_brkm(TBROK, NULL, "Do you have /bin/true installed?");
> +
> +				if (WEXITSTATUS(st) !=3D 0)
> +					tst_brkm(TBROK, NULL, "chaild exits with non-zero value");
> +
> +				tst_resm(TPASS, "thp01 pass");
> +		}
> +	}
> +
> +        tst_exit();
> +}
> -- =

> 1.7.1
> =


> -------------------------------------------------------------------------=
-----
> What You Don't Know About Data Connectivity CAN Hurt You
> This paper provides an overview of data connectivity, details
> its effect on application quality, and explores various alternative
> solutions. http://p.sf.net/sfu/progress-d2d

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- =

Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

---------------------------------------------------------------------------=
---
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
