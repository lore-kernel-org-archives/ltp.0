Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeAwo-00078M-FM
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:57:10 +0000
Received: from qw-out-1920.google.com ([74.125.92.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeAwl-0002np-JE
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:57:10 +0000
Received: by qw-out-1920.google.com with SMTP id 5so22237qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 09:57:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160809.30926.5725.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160809.30926.5725.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 09:57:01 -0700
Message-ID: <364299f40908200957x659a4113y19b97cc6cb60d5c0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] New testcase to test timer_migration interface
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
> This is the new tescase to test timer migration interface.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/test_=
timer_migration.sh ltp-full-20090731/testcases/kernel/power_management/test=
_timer_migration.sh
> --- ltp-full-20090731_orig/testcases/kernel/power_management/test_timer_m=
igration.sh =A0 =A01970-01-01 05:30:00.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/test_timer_migrat=
ion.sh 2009-08-20 20:49:48.000000000 +0530
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +
> +. pm_include.sh
> +
> +valid_input=3D"0 1"
> +invalid_input=3D"3 4 5 6 7 8 a abcefg x1999 xffff -1 -00000
> +200000000000000000000000000000000000000000000000000000000000000000000000=
000000
> +ox324 -0xfffffffffffffffffffff"
> +test_file=3D"/proc/sys/kernel/timer_migration"
> +if [ ! -f ${test_file} ] ; then
> + =A0 =A0 =A0 echo "MISSING_FILE: missing file ${test_file}"
> + =A0 =A0 =A0 exit $MISSING_FILE
> +fi
> +
> +RC=3D0
> +echo "${0}: ---Valid test cases---"
> +check_input "${valid_input}" valid $test_file
> +RC=3D$?
> +echo "${0}: ---Invalid test cases---"
> +check_input "${invalid_input}" invalid $test_file
> +RC=3D$(( RC | $? ))
> +exit $RC

1. Please replace

${0}

with:

${0##*}

2. Wouldn't it make more sense to say `exit $(( RC | $? )'?

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
