Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WzpIu-0003XT-5M
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 15:40:08 +0000
Date: Wed, 25 Jun 2014 17:39:50 +0200
From: chrubis@suse.cz
Message-ID: <20140625153950.GA5552@rei>
References: <1401685455.2838.8.camel@G08JYZSD130126>
	<20140612131041.GB20221@rei>
	<1403179593.7741.2.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403179593.7741.2.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/3] can: cleanup
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
>  testcases/network/can/filter-tests/Makefile        | 37 +++++----
>  .../network/can/filter-tests/run_ltp-can_tests.sh  | 97 ++++++++++++++++------
>  testcases/network/can/filter-tests/tst-filter.c    | 45 +++++-----
>  .../network/can/filter-tests/tst-rcv-own-msgs.c    | 24 +++---
>  4 files changed, 122 insertions(+), 81 deletions(-)
> 
> diff --git a/testcases/network/can/filter-tests/Makefile b/testcases/network/can/filter-tests/Makefile
> index c88f704..70e2a42 100644
> --- a/testcases/network/can/filter-tests/Makefile
> +++ b/testcases/network/can/filter-tests/Makefile
> @@ -1,24 +1,29 @@
>  #
> -#  $Id: Makefile,v 1.1 2009/03/02 15:33:55 subrata_modak Exp $
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
>  #
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
                               ^
			    This should be removed and warnings (if
			    there are any) fixed

> +                           -DAF_CAN=PF_CAN
>  
> -distclean:
> -	rm -f $(PROGRAMS) *~
> +INSTALL_TARGETS		:= *.sh
>  
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/can/filter-tests/run_ltp-can_tests.sh b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> index b955ec6..17d841d 100644
> --- a/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> +++ b/testcases/network/can/filter-tests/run_ltp-can_tests.sh
> @@ -14,44 +14,89 @@
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
> +setup()
> +{
> +	tst_require_root
> +
> +	# load needed CAN networklayer modules
> +	modprobe can
> +	ret=$?
> +	if [ $ret -ne 0 ]; then
> +		tst_resm TCONF "insmod can modules fail: errno - $ret"
                                 ^
				modprobe
> +		exit 1

                The message says TCONF but then exits with 1, which is
		TFAIL.

		Why don't you use the tst_brkm() which (after sourcing
		test.sh) will exit with correct exit value for you?
> +	fi
> +
> +	modprobe can_raw
> +	ret=$?
> +	if [ $ret -ne 0 ]; then
> +		tst_resm TCONF "insmod can_raw modules fail: errno - $ret"
                                  ^
				modprobe
> +		exit 1
> +	fi
> +
> +	# ensure the vcan driver to perform the ECHO on driver level
> +	modprobe -r vcan
> +	ret=$?
> +	if [ $ret -ne 0 ]; then
> +		tst_resm TCONF "rmsmod vcan modules fail: errno - $ret"
                                 ^
				modprobe -r
> +		exit 1
> +	fi
>  
> -# load needed CAN networklayer modules
> -modprobe -f can
> -modprobe -f can_raw
> +	modprobe vcan echo=1
> +	ret=$?
> +	if [ $ret -ne 0 ]; then
> +		tst_resm TCONF "insmod vcan modules fail: errno - $ret"
                                  ^
				modprobe vcan echo=1
> +		exit 1
> +	fi
>  
> -# ensure the vcan driver to perform the ECHO on driver level
> -modprobe -r vcan
> -modprobe -f vcan echo=1
> +	VCAN=vcan0
>  
> -VCAN=vcan0
> +	# create virtual CAN device
> +	ip link add dev $VCAN type vcan || exit 1
> +	ifconfig $VCAN up

It would be better to stick with just ip.

i.e.

ip link set dev $VCAN up

> -# create virtual CAN device
> -ip link add dev $VCAN type vcan || exit 1
> -ifconfig $VCAN up
> +	# check precondition for CAN frame flow test
> +	HAS_ECHO=`ip link show $VCAN | grep -c ECHO`
>  
> -# check precondition for CAN frame flow test
> -HAS_ECHO=`ip link show $VCAN | grep -c ECHO`
> +	if [ $HAS_ECHO -ne 1 ]; then

There should be some error message here.

> +		exit 1
> +	fi
> +}
>  
> -if [ $HAS_ECHO -ne 1 ]
> -then
> -    exit 1
> +cleanup()
> +{
> +	ifconfig $VCAN down

ip link set dev $VCAN down

> +	ip link del dev $VCAN
> +	modprobe -r vcan
> +	modprobe -r can_raw
> +	modprobe -r can
> +}
> +
> +if [ $# -ne 1 ]; then
> +	echo "Usage: $0 [can_filter | can_rcv_own_msgs]"
> +	exit 1
>  fi
>  
> -# test of CAN filters on af_can.c
> -./tst-filter $VCAN || exit 1
> +TCID="$1"
> +TST_TOTAL=1
> +TST_COUNT=1
> +
> +. test.sh

This should rather be at the start of the script and the TST_COUNT
should not be initialized.

> +TST_CLEANUP=cleanup
>  
> -# test of CAN frame flow down to the netdevice and up again
> -./tst-rcv-own-msgs $VCAN || exit 1
> +setup
>  
> -exit 0
> +"$1" "$VCAN"
> +ret=$?
>  
> +if [ $ret -ne 0 ]; then
> +	tst_resm TFAIL "Test $1 FAIL with exit num: $ret"
> +else
> +	tst_resm TPASS "Test $1 PASS"
> +fi
>  
> +tst_exit
> diff --git a/testcases/network/can/filter-tests/tst-filter.c b/testcases/network/can/filter-tests/tst-filter.c
> index 26eacf7..f248999 100644
> --- a/testcases/network/can/filter-tests/tst-filter.c
> +++ b/testcases/network/can/filter-tests/tst-filter.c
> @@ -1,8 +1,4 @@
>  /*
> - *  $Id: tst-filter.c 1263 2011-07-09 18:00:41Z hartkopp $
> - */
> -
> -/*
>   * tst-filter.c
>   *
>   * Copyright (c) 2011 Volkswagen Group Electronic Research
> @@ -65,9 +61,8 @@
>  #define TC 18			/* # of testcases */
>  
>  const int rx_res[TC] = { 4, 4, 4, 4, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1 };
> -const int rxbits_res[TC] =
> -    { 4369, 4369, 4369, 4369, 17, 4352, 17, 4352, 257, 257, 4112, 4112, 1, 256,
> -16, 4096, 1, 256 };
> +const int rxbits_res[TC] = { 4369, 4369, 4369, 4369, 17, 4352, 17, 4352, 257,
> +			     257, 4112, 4112, 1, 256, 16, 4096, 1, 256 };
>  
>  canid_t calc_id(int testcase)
>  {
> @@ -85,13 +80,12 @@ canid_t calc_mask(int testcase)
>  {
>  	canid_t mask = CAN_SFF_MASK;
>  
> -	if (testcase > 15)
> -		return (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG);
> -
>  	if (testcase & 4)
>  		mask |= CAN_EFF_FLAG;
>  	if (testcase & 8)
>  		mask |= CAN_RTR_FLAG;
> +	if (testcase > 15)
> +		mask = (CAN_EFF_MASK | CAN_EFF_FLAG | CAN_RTR_FLAG);

What is the reason for this change? Does the test fail without it?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
