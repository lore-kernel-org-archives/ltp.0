Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Mplcr-00044w-5e
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:20:29 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mplco-0000Wy-Hu
	for ltp-list@lists.sourceforge.net; Mon, 21 Sep 2009 16:20:29 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8LGICBw014931
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:18:12 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8LGKK4m197496
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:20:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8LGKK2o027259
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Sep 2009 12:20:20 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090921061642.GA3276@us.ibm.com>
References: <20090921061642.GA3276@us.ibm.com>
Date: Mon, 21 Sep 2009 21:50:08 +0530
Message-Id: <1253550009.6736.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Create testcase for p9auth kernel module (v2)
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Subrata Modak1 <subrata.modak@in.ibm.com>, Ashwin Ganti <ashwin.ganti@gmail.com>

On Mon, 2009-09-21 at 01:16 -0500, Serge E. Hallyn wrote: 
> The p9auth module is a driver in the staging/ directory, which
> implements kernel functionality supporting plan 9-style setuid.
> Programs can be completely unprivileged, authorize themselves
> to a privileged server, and obtain a token which they can use to
> authorize a single setuid to a single specified new uid.
> 
> This testcase runs three tests:
> 	1. make sure we can't setuid without a hash
> 		(this is actually short-cut in the kernel code
> 		so it might be worthwhile having a separate
> 		test for having a hash, but an invalid one)
> 	2. make sure we can setuid when there is a valid hash
> 	3. make sure we cannot setuid if there is a valid hash,
> 		but our original uid isn't the one specified
> 		in the token.
> 
> Changelog:
> 	Sep 21: Comment README, add runp9auth.sh to the patch, and
> 		add the openssl check to checkp9auth.sh.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Thanks for the v2. I tested and got the following results on my machine:

<<<test_start>>>
tag=p9auth stime=1253547313
cmdline="       runp9auth.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
p9auth ready for testing
ltptmp is /tmp/p9auth_ltp
cat: /tmp/p9auth_ltp/d/txtfile: No such file or directory
PASS: child couldn't setuid with bad hash
ltptmp is /tmp/p9auth_ltp
PASS: child could setuid with good hash
ltptmp is /tmp/p9auth_ltp
p9unpriv.sh: line 41: echo: write error: Bad address
PASS: child couldn't setuid from wrong source uid
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=0 corefile=no
cutime=24 cstime=33
<<<test_end>>>

There are some more changes i added:

1) It seems that the tests are expecting an user ltp existent in the
system. So, i added that info at ltp/README,
2) You might have forgot to remove the -v from some scripts:
--- /dev/null 
> +++ b/testcases/kernel/security/p9auth/p9priv.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh -v

Thanks for these new tests. I have added them to LTP.

Regards--
Subrata

> ---
>  README                                          |    9 ++
>  runtest/p9auth                                  |    2 +
>  testcases/kernel/security/Makefile              |    2 +-
>  testcases/kernel/security/p9auth/Makefile       |   40 ++++++++
>  testcases/kernel/security/p9auth/checkp9auth.sh |   78 ++++++++++++++++
>  testcases/kernel/security/p9auth/p9priv.sh      |  111 +++++++++++++++++++++++
>  testcases/kernel/security/p9auth/p9unpriv.sh    |   51 +++++++++++
>  testcases/kernel/security/p9auth/runp9auth.sh   |   37 ++++++++
>  testcases/kernel/security/p9auth/unhex.c        |   47 ++++++++++
>  9 files changed, 376 insertions(+), 1 deletions(-)
>  create mode 100644 runtest/p9auth
>  create mode 100644 testcases/kernel/security/p9auth/Makefile
>  create mode 100644 testcases/kernel/security/p9auth/checkp9auth.sh
>  create mode 100644 testcases/kernel/security/p9auth/p9priv.sh
>  create mode 100644 testcases/kernel/security/p9auth/p9unpriv.sh
>  create mode 100644 testcases/kernel/security/p9auth/runp9auth.sh
>  create mode 100644 testcases/kernel/security/p9auth/unhex.c
> 
> diff --git a/README b/README
> index 63dbc72..de8d4f0 100644
> --- a/README
> +++ b/README
> @@ -179,6 +179,15 @@ Enabling Kernel Configuration to test filecaps security feature
>  ---------------------------------
>  CONFIG_SECURITY_FILE_CAPABILITIES=y
>  ---------------------------------
> +Enabling Kernel Configuration to test p9auth security feature
> +---------------------------------
> +CONFIG_CRYPTO=y
> +CONFIG_STAGING=y
> +# CONFIG_STAGING_EXCLUDE_BUILD is not set
> +CONFIG_PLAN9AUTH=m
> +(Or CONFIG_PLAN9AUTH=y)
> +You also will need openssl installed.
> +---------------------------------
>  Enabling Kernel Configuration to test SELinux security feature
>  ---------------------------------
>  Your Kernel should have been built with the following options to
> diff --git a/runtest/p9auth b/runtest/p9auth
> new file mode 100644
> index 0000000..17b1550
> --- /dev/null
> +++ b/runtest/p9auth
> @@ -0,0 +1,2 @@
> +#DESCRIPTION:p9auth /dev/caphash module
> +p9auth		runp9auth.sh
> diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
> index 862691a..3a26b22 100644
> --- a/testcases/kernel/security/Makefile
> +++ b/testcases/kernel/security/Makefile
> @@ -1,4 +1,4 @@
> -SUBDIRS = mmc_security filecaps integrity cap_bound
> +SUBDIRS = mmc_security filecaps integrity cap_bound p9auth
> 
>  all:
>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
> diff --git a/testcases/kernel/security/p9auth/Makefile b/testcases/kernel/security/p9auth/Makefile
> new file mode 100644
> index 0000000..1c03e5b
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/Makefile
> @@ -0,0 +1,40 @@
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2008                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +HAVE_P9AUTH := $(shell sh checkp9auth.sh yesno)
> +
> +SCRIPTS = runp9auth.sh checkp9auth.sh p9priv.sh p9unpriv.sh
> +
> +CFLAGS += -I../../../../include -Wall
> +LDLIBS += -L../../../../lib -lltp -lcap
> +
> +ifeq ($(HAVE_P9AUTH),yes)
> +SRCS    = $(wildcard *.c)
> +TARGETS+= $(patsubst %.c,%,$(SRCS))
> +endif
> +
> +all: $(TARGETS)
> +
> +INSTALLTARGETS = $(TARGETS) $(SCRIPTS)
> +install: $(INSTALLTARGETS)
> +	@set -e; for i in $(INSTALLTARGETS); do ln -f $$i ../../../bin/$$i ; chmod +x ../../../bin/$$i; done
> +
> +clean:
> +	rm -f $(TARGETS) *.o unhex
> diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
> new file mode 100644
> index 0000000..4365427
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/checkp9auth.sh
> @@ -0,0 +1,78 @@
> +#!/bin/sh
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2009                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +yesno=0
> +if [ "$1" = "yesno" ]; then
> +	yesno=1
> +fi
> +
> +# check for openssl
> +OPENSSL=`which openssl`
> +if [ $? -ne 0 ]; then
> +	if [ $yesno -eq 1 ]; then echo
> +		echo "no"
> +	else
> +		echo "Openssl not installed.  Skipping p9auth tests."
> +	fi
> +	exit 1
> +fi
> +# and make sure openssl understands -hmac
> +echo -n "501@0" > plain
> +$OPENSSL sha1 -hmac ab plain > hexed
> +if [ $? -ne 0 ]; then
> +	if [ $yesno -eq 1 ]; then echo
> +		echo "no"
> +	else
> +		echo "Openssl too old (no -hmac).  Skipping p9auth tests."
> +	fi
> +	exit 1
> +fi
> +
> +majfile=/sys/module/p9auth/parameters/cap_major
> +minfile=/sys/module/p9auth/parameters/cap_minor
> +if [ ! -f "$majfile" ]; then
> +	if [ $yesno -eq 1 ]; then echo
> +		echo "no"
> +	else
> +		echo "p9auth not detected.  Skipping p9auth tests."
> +	fi
> +	exit 1
> +fi
> +
> +if [ ! -c "/dev/caphash" ]; then
> +	rm -f /dev/caphash
> +	maj=`cat $majfile`
> +	mknod /dev/caphash c $maj 0
> +fi
> +
> +if [ ! -c "/dev/capuse" ]; then
> +	rm -f /dev/capuse
> +	min=`cat $minfile`
> +	mknod /dev/capuse c $maj 1
> +fi
> +chmod ugo+w /dev/capuse
> +
> +if [ $yesno -eq 1 ]; then
> +	echo "yes"
> +else
> +	echo "p9auth ready for testing"
> +fi
> +exit 0
> diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/kernel/security/p9auth/p9priv.sh
> new file mode 100644
> index 0000000..0ff4ca7
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/p9priv.sh
> @@ -0,0 +1,111 @@
> +#!/bin/sh -v
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2009                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +LTPTMP=/tmp/p9auth_ltp
> +rm -rf $LTPTMP
> +mkdir $LTPTMP
> +chmod 755 $LTPTMP
> +
> +comms="$LTPTMP/childgo $LTPTMP/d/childready $LTPTMP/d/childfail $LTPTMP/d/childpass $LTPTMP/childexit"
> +
> +RM=`which rm`
> +MKDIR=`which mkdir`
> +CHOWN=`which chown`
> +
> +cleanup() {
> +	$RM -rf $LTPTMP/d $comms
> +	$MKDIR -p $LTPTMP/d
> +	$CHOWN -R ltp $LTPTMP/d
> +}
> +
> +if [ `id -u` -ne 0 ]; then
> +	echo "Must start p9auth tests as root"
> +	exit 1
> +fi
> +
> +ltpuid=`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
> +ret=$?
> +if [ $? -ne 0 ]; then
> +	echo "Failed to find ltp userid"
> +	exit 1
> +fi
> +
> +# TEST 1: ltp setuids to 0 but no valid hash
> +# launch an unprivileged helper
> +cleanup
> +
> +su ltp p9unpriv.sh &
> +while [ ! -f $LTPTMP/d/childready ]; do :; done
> +touch $LTPTMP/childgo
> +while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
> +if [ -f $LTPTMP/d/childpass ]; then
> +	echo "FAIL: child could setuid with bad hash"
> +	exit 1
> +fi
> +echo "PASS: child couldn't setuid with bad hash"
> +
> +# TEST 2: ltp setuids to 0 with valid hash
> +
> +# create the hash.  randstr doesn't have to be int, but it's ok
> +cleanup
> +randstr=$RANDOM
> +txt="$ltpuid@0"
> +echo -n "$txt" > $LTPTMP/txtfile
> +openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
> +unhex < $LTPTMP/hex > /dev/caphash
> +# give the child its token
> +echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
> +chown ltp $LTPTMP/d/txtfile
> +
> +su ltp p9unpriv.sh &
> +while [ ! -f $LTPTMP/d/childready ]; do :; done
> +touch $LTPTMP/childgo
> +while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
> +if [ -f $LTPTMP/d/childfail ]; then
> +	echo "FAIL: child couldn't setuid with good hash"
> +	exit 1
> +fi
> +echo "PASS: child could setuid with good hash"
> +
> +# TEST 3: 0 setuids to 0 with hash valid for ltp user
> +cleanup
> +randstr=$RANDOM
> +txt="0@0"
> +echo -n "$txt" > $LTPTMP/txtfile
> +openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
> +unhex < $LTPTMP/hex > /dev/caphash
> +# give the child its token
> +echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
> +chown ltp $LTPTMP/d/txtfile
> +
> +su ltp p9unpriv.sh &
> +while [ ! -f $LTPTMP/d/childready ]; do :; done
> +touch $LTPTMP/childgo
> +while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
> +if [ -f $LTPTMP/d/childpass ]; then
> +	echo "PASS: child could setuid from wrong source uid"
> +	exit 1
> +fi
> +echo "PASS: child couldn't setuid from wrong source uid"
> +
> +touch $LTPTMP/childexit
> +
> +exit 0
> diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/testcases/kernel/security/p9auth/p9unpriv.sh
> new file mode 100644
> index 0000000..8a0f162
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/p9unpriv.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh -v
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2009                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +LTPTMP=/tmp/p9auth_ltp
> +
> +TOUCH=`which touch`
> +ID=`which id`
> +echo ltptmp is $LTPTMP
> +
> +myuid=`id -u`
> +if [ "$myuid" -eq 0 ]; then
> +	echo "Unprivileged child was started as root!"
> +	exit 1
> +fi
> +
> +$TOUCH $LTPTMP/d/childready
> +
> +while [ 1 ]; do
> +	if [ -f $LTPTMP/childexit ]; then
> +		exit 0
> +	fi
> +	if [ -f $LTPTMP/childgo ]; then
> +		echo -n `cat $LTPTMP/d/txtfile` > /dev/capuse
> +		if [ `$ID -u` -eq 0 ]; then
> +			$TOUCH $LTPTMP/d/childpass
> +		else
> +			$TOUCH $LTPTMP/d/childfail
> +		fi
> +		exit 0
> +	fi
> +done
> +
> +exit 0
> diff --git a/testcases/kernel/security/p9auth/runp9auth.sh b/testcases/kernel/security/p9auth/runp9auth.sh
> new file mode 100644
> index 0000000..b61844e
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/runp9auth.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +################################################################################
> +##                                                                            ##
> +## Copyright (c) International Business Machines  Corp., 2008                 ##
> +##                                                                            ##
> +## This program is free software;  you can redistribute it and#or modify      ##
> +## it under the terms of the GNU General Public License as published by       ##
> +## the Free Software Foundation; either version 2 of the License, or          ##
> +## (at your option) any later version.                                        ##
> +##                                                                            ##
> +## This program is distributed in the hope that it will be useful, but        ##
> +## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> +## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> +## for more details.                                                          ##
> +##                                                                            ##
> +## You should have received a copy of the GNU General Public License          ##
> +## along with this program;  if not, write to the Free Software               ##
> +## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
> +##                                                                            ##
> +################################################################################
> +
> +checkp9auth.sh
> +ret=$?
> +if [ $ret -ne 0 ]; then
> +	echo "p9auth module is not supported by this kernel."
> +	exit 0
> +fi
> +
> +exit_code=0
> +
> +p9priv.sh
> +tmp=$?
> +if [ $tmp -ne 0 ]; then
> +	exit_code=$tmp
> +fi
> +
> +exit $exit_code
> diff --git a/testcases/kernel/security/p9auth/unhex.c b/testcases/kernel/security/p9auth/unhex.c
> new file mode 100644
> index 0000000..7c78b6a
> --- /dev/null
> +++ b/testcases/kernel/security/p9auth/unhex.c
> @@ -0,0 +1,47 @@
> +/******************************************************************************/
> +/*                                                                            */
> +/* Copyright (c) International Business Machines  Corp., 2008                 */
> +/*                                                                            */
> +/* This program is free software;  you can redistribute it and/or modify      */
> +/* it under the terms of the GNU General Public License as published by       */
> +/* the Free Software Foundation; either version 2 of the License, or          */
> +/* (at your option) any later version.                                        */
> +/*                                                                            */
> +/* This program is distributed in the hope that it will be useful,            */
> +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> +/* the GNU General Public License for more details.                           */
> +/*                                                                            */
> +/* You should have received a copy of the GNU General Public License          */
> +/* along with this program;  if not, write to the Free Software               */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
> +/*                                                                            */
> +/******************************************************************************/
> +
> +/*
> + * File: unhex.c
> + * Author: Serge Hallyn
> + * Purpose: Read a 40 char hex value from stdin, output 20 char byte
> + * value on stdout.
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *argv[])
> +{
> +	char in[41], out[20];
> +	unsigned int v;
> +	int i, ret;
> +
> +	ret = read(STDIN_FILENO, in, 40);
> +	if (ret != 40)
> +		return 1;
> +	in[40] = '\0';
> +	for (i = 0; i < 20; i++) {
> +		sscanf(&in[2*i], "%02x", &v);
> +		out[i] = v;
> +	}
> +	write(STDOUT_FILENO, out, 20);
> +	return 0;
> +}


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
