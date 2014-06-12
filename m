Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wv4mL-0004Q5-Kc
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 13:10:53 +0000
Date: Thu, 12 Jun 2014 15:10:41 +0200
From: chrubis@suse.cz
Message-ID: <20140612131041.GB20221@rei>
References: <1401685455.2838.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401685455.2838.8.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] can: add can tests to default
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> ---
>  runtest/can                                        |  2 +-
>  scenario_groups/default                            |  1 +
>  testcases/network/.gitignore                       |  2 +
>  testcases/network/can/filter-tests/Makefile        | 39 +++++----
>  .../network/can/filter-tests/run_ltp-can_tests.sh  | 99 ++++++++++++++++------
>  5 files changed, 101 insertions(+), 42 deletions(-)
> 
> diff --git a/runtest/can b/runtest/can
> index 0928bc1..2fa4424 100644
> --- a/runtest/can
> +++ b/runtest/can
> @@ -1 +1 @@
> -CONTROLLER_AREA_NETWORK_01 ( cd $LTPROOT/testcases/network/can/filter-tests/; make && ./run_ltp-can_tests.sh )
> +CONTROLLER_AREA_NETWORK_01 run_ltp-can_tests.sh

This is no-go. You should really follow one test per runtest record
rule. The best solution here would be to change the run_ltp-can_test.sh
to accept the test to run as a parameter.

Also the script sould be renamed to more saner name, i.e.
can_run_tests.sh or similar. (And please do that in a separate patch.)

> diff --git a/scenario_groups/default b/scenario_groups/default
> index bf7ab79..4e8ce44 100644
> --- a/scenario_groups/default
> +++ b/scenario_groups/default
> @@ -28,3 +28,4 @@ kernel_misc
>  modules
>  fs_ext4
>  pipes
> +can
> diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
> index e5fbb88..16469dc 100644
> --- a/testcases/network/.gitignore
> +++ b/testcases/network/.gitignore
> @@ -1,3 +1,5 @@
> +/can/filter-tests/tst-filter
> +/can/filter-tests/tst-rcv-own-msgs
>  /datafiles/
>  /lib6/asapi_01
>  /lib6/asapi_02
> diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
> index c88f704..c03e8a3 100644
> --- a/testcases/network/can/filter-tests/Makefile
> +++ b/testcases/network/can/filter-tests/Makefile
> @@ -1,24 +1,33 @@
>  #
> +#    Copyright (c) 2014 Fujitsu Ltd.
> +#
> +#    This program is free software; you can redistribute it and/or modify
> +#    it under the terms of the GNU General Public License as published by
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License along
> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +
> +#
>  #  $Id: Makefile,v 1.1 2009/03/02 15:33:55 subrata_modak Exp $

This CVS export line should be removed.

>  #  Send feedback to <socketcan-users@lists.berlios.de>
>  
> -CFLAGS    = -O2 -Wall -Wno-parentheses \
> -	-fno-strict-aliasing \
> -	-DETH_P_CAN=0x000C \
> -	-DPF_CAN=29 \
> -	-DAF_CAN=PF_CAN
> -
> -PROGRAMS =      tst-filter tst-rcv-own-msgs
> -
> -all: $(PROGRAMS)
> +top_srcdir		?= ../../../..
>  
> -install:
> -	cp -f $(PROGRAMS) /usr/local/bin
> +include $(top_srcdir)/include/mk/testcases.mk
>  
> -clean:
> -	rm -f $(PROGRAMS)
> +CPPFLAGS		+= -Wno-parentheses -DETH_P_CAN=0x000C -DPF_CAN=29 \
> +                           -DAF_CAN=PF_CAN
>  
> -distclean:
> -	rm -f $(PROGRAMS) *~
> +INSTALL_TARGETS		:= run_ltp-can_tests.sh
>  
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/can/filter-tests/run_ltp-can_tests.sh b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> index b955ec6..4885f3d 100644
> --- a/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> +++ b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> @@ -14,44 +14,91 @@
>  ## for more details.                                                          ##
>  ##                                                                            ##
>  ## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> +## along with this program;  if not, write to the Free Software Foundation,   ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
>  ##                                                                            ##
>  ################################################################################
>  
> -if [ $(id -ru) -ne 0 ]; then
> -     echo You need to be root to execute these tests
> -     exit 1
> -fi
> +export TCID="run_ltp-can_tests"
> +export TST_TOTAL=2
> +export TST_COUNT=1
>  
> -# load needed CAN networklayer modules
> -modprobe -f can
> -modprobe -f can_raw
> +. cmdlib.sh

cmdlib.sh is deprecated, you should use test.sh instead

> -# ensure the vcan driver to perform the ECHO on driver level
> -modprobe -r vcan
> -modprobe -f vcan echo=1
> +setup()
> +{
> +	tst_require_root
>  
> -VCAN=vcan0
> +	if [ ! -d "/lib/modules/`uname -r`/kernel/net/can" ]; then
> +		tst_resm TCONF "Not find CAN modules"
> +		exit
> +	fi
> +	if [ -e "/lib/modules/`uname -r`/kernel/net/can/can.ko" ] &&\
> +	   [ -e "/lib/modules/`uname -r`/kernel/net/can/can-raw.ko" ]; then
> +		# load needed CAN networklayer modules
> +		modprobe -f can
> +		modprobe -f can_raw
> +	else
> +		tst_resm TCONF "Not find can can_raw modules"
> +		exit
> +	fi

Can't we just use return value from modprobe? It should exit with 0 if
module was succesfuly loaded and non-zero if not.

Also why the -f (force) parameter. This should be only needed when
version information of the module and running kernel does not match.

> -# create virtual CAN device
> -ip link add dev $VCAN type vcan || exit 1
> -ifconfig $VCAN up
> +	if [ -e "/lib/modules/`uname -r`/kernel/drivers/net/can/" ]; then
> +		# ensure the vcan driver to perform the ECHO on driver level
> +		modprobe -r vcan
> +		modprobe -f vcan echo=1
> +	else
> +		tst_resm TCONF "Not find vcan modules"
> +		exit
> +	fi

Here as well.

> -# check precondition for CAN frame flow test
> -HAS_ECHO=`ip link show $VCAN | grep -c ECHO`
> +	VCAN=vcan0
>  
> -if [ $HAS_ECHO -ne 1 ]
> -then
> -    exit 1
> -fi
> +	# create virtual CAN device
> +	ip link add dev $VCAN type vcan || exit 1
> +	ifconfig $VCAN up
> +
> +	# check precondition for CAN frame flow test
> +	HAS_ECHO=`ip link show $VCAN | grep -c ECHO`
> +
> +	if [ $HAS_ECHO -ne 1 ]; then
> +		exit 1
> +	fi
> +
> +	RET=0
> +}
> +
> +cleanup()
> +{
> +	ifconfig $VCAN down
> +	ip link del dev $VCAN
> +	modprobe -r vcan
> +	modprobe -r can_raw
> +	modprobe -r can
> +}
> +
> +setup
>  
>  # test of CAN filters on af_can.c
> -./tst-filter $VCAN || exit 1
> +./tst-filter $VCAN
> +ret=$?
> +if [ $ret -ne 0 ]; then
> +	RET=1
> +	tst_resm TFAIL "Test tst-filter FAIL with exit num: $ret"
> +else
> +	tst_resm TPASS "Test tst-filter PASS"
> +fi

The ./ should be removed here. It expects that the $CWD for the test is
$LTPROOT/testcases/bin/ which is only true if test does not create the
test temporary directory. This will break for no apparent reason if
somebody adds tst_tmpdir() to the test setup.

Also the scripts called from this testcase should be renamed so that
it's clear that they are testing can. I.e. this one should be called
can_filter

>  
>  # test of CAN frame flow down to the netdevice and up again
> -./tst-rcv-own-msgs $VCAN || exit 1
> -
> -exit 0
> +./tst-rcv-own-msgs $VCAN

Here remove the ./ and the binary should be named with can_rcv_own_msgs
or similar.

> +ret=$?
> +if [ $ret -ne 0 ]; then
> +	RET=1
> +	tst_resm TFAIL "Test tst-rcv-own-msgs FAIL with exit num: $ret"
> +else
> +	tst_resm TPASS "Test tst-rcv-own-msgs PASS"
> +fi
>  
> +cleanup
>  
> +exit $RET

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
