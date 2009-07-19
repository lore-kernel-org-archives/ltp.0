Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSOjw-0006X6-3y
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:15:12 +0000
Received: from wf-out-1314.google.com ([209.85.200.174])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSOjo-0007h8-Qy
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:15:12 +0000
MIME-Version: 1.0
In-Reply-To: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
Date: Sat, 18 Jul 2009 22:15:04 -0700
Message-ID: <364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp: IMA cross platform fixes
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list <ltp-list@lists.sf.net>, Shaz <shazalive@gmail.com>

On Thu, Jul 16, 2009 at 3:59 AM, Mimi Zohar<zohar@linux.vnet.ibm.com> wrote:
> - Instead of using the default platform shell, explicitly use bash.
> - To create a file using 'sudo -u', some platforms require 'user' to exis=
t.
> - Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.
>
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
>
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/im=
a_measurements.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/=
ima_measurements.sh
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_m=
easurements.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>
> =A0######################################################################=
##########
> =A0## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0##
> @@ -137,12 +137,13 @@ test03()
>
> =A0 =A0 =A0 =A0# create file user-test.txt
> =A0 =A0 =A0 =A0mkdir -m 0700 $LTPIMA/user
> - =A0 =A0 =A0 chown 99.99 $LTPIMA/user
> + =A0 =A0 =A0 chown nobody.nobody $LTPIMA/user
> =A0 =A0 =A0 =A0cd $LTPIMA/user
> =A0 =A0 =A0 =A0hash=3D0
>
> - =A0 =A0 =A0 # As user 99, create and cat the new file
> - =A0 =A0 =A0 sudo -u \#99 sh -c "echo `date` - create test.txt > ./test.=
txt;
> + =A0 =A0 =A0 # As user nobody, create and cat the new file
> + =A0 =A0 =A0 # (The LTP tests assumes existence of 'nobody'.)
> + =A0 =A0 =A0 sudo -u nobody sh -c "echo `date` - create test.txt > ./tes=
t.txt;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cat ./test=
.txt > /dev/null"
>
> =A0 =A0 =A0 =A0# Calculating the hash will add the measurement to the mea=
surement
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/im=
a_policy.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/=
ima_policy.sh
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_p=
olicy.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
> =A0######################################################################=
##########
> =A0## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0##
> =A0## Copyright (C) 2009 IBM Corporation =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/im=
a_setup.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/=
ima_setup.sh
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_s=
etup.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
> =A0######################################################################=
##########
> =A0## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0##
> =A0## Copyright (C) 2009 IBM Corporation =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/im=
a_tpm.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/=
ima_tpm.sh
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_t=
pm.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>
> =A0######################################################################=
##########
> =A0## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0##
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/im=
a_violations.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/=
ima_violations.sh
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_v=
iolations.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
> =A0######################################################################=
##########
> =A0## =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0##
> =A0## Copyright (C) 2009 IBM Corporation =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ##
> Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/README
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/README
> +++ ltp-full-20090531/testcases/kernel/security/integrity/ima/README
> @@ -52,6 +52,10 @@ open for read by root. If the default po
> =A0another measurement policy will fail, as the policy may only be replac=
ed
> =A0once per boot. Some of the policy dependency tests might also fail as =
well.
>
> +ima_tpm.sh: test02, verifying the PCR-10 value, requires a hard reboot.
> +[On Ubuntu, before running the ltp tests, disable /etc/init.d/kexec-load
> +and reboot.]
> +
> =A0Run tests

Hi Mimi,
    The change to
testcases/kernel/security/integrity/ima/tests/ima_measurements.sh,
minus the shebang change looks ok.
    /bin/sh should remain the standard, but a number of changes need
to happen to the .sh scripts to make them POSIX compatible, e.g.
backticks execution should become $(), etc. Let's not make things
bash-only...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
