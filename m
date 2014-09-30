Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XYtxl-0007Kx-IA
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 09:43:17 +0000
Date: Tue, 30 Sep 2014 11:42:34 +0200
From: chrubis@suse.cz
Message-ID: <20140930094234.GA7138@rei.suse.cz>
References: <1409480940.6575.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1409480940.6575.1.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 1/4] multicast/mc_cmds: Some cleanup
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
> * Fix a typo.
> * Delete trace_logic that is used to debug.
> * Use test.sh script and use tst_* instead of end_testcase.
> * Delete some unuseful comments.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/network/multicast/mc_cmds/mc_cmds | 239 ++++++++++------------------
>  1 file changed, 86 insertions(+), 153 deletions(-)
> 
> diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
> index 54fc69c..3799e26 100755
> --- a/testcases/network/multicast/mc_cmds/mc_cmds
> +++ b/testcases/network/multicast/mc_cmds/mc_cmds
> @@ -20,7 +20,7 @@
>  #
>  #  FILE             : mc_cmds
>  #  TEST DESCRIPTION : To determine the stability of the IP Multicast product
> -#                and to verify the accuracy and usablility of IP Multicast
> +#                and to verify the accuracy and usability of IP Multicast
>  #                related publications associated with changes and/or
>  #                additions to command level interfaces for this implementations
>  #                of IP Multicast.
> @@ -30,181 +30,114 @@
>  #
>  #*******************************************************************************
>  
> -#Uncomment line below for debug output.
> -#trace_logic=${trace_logic:-"set -x"}
> -$trace_logic
> -
>  TC=mc_cmds
>  TCtmp=${TCtmp:-$TMPDIR/$TC$$}
>  PING_OUT=${TCtmp}/PING_OUT
> -HOSTNAME=`hostname`
> -CLEANUP=${CLEANUP:-ON}
>  
>  export TCID=$TC
>  export TST_TOTAL=1
>  export TST_COUNT=1
>  
> +. test.sh
> +
>  setup()
>  {
> -   mkdir -p $TCtmp || { tst_brkm TBROK NULL "Could not create $TCtmp"; exit 1; }
> +	cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null

Why the grep?

we can do:

val = $(cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts)
if [ "$val" -ne 0 ]; then
	...

> +	if [ $? -eq 0 ]; then
> +		tst_brkm TCONF "Multicast ping disabled on this system."
> +	fi
> +
> +	mkdir -p $TCtmp
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TBROK NULL "Could not create $TCtmp";
> +	fi

You should rather use tst_tmpdir once the testcase is being converted to
test.sh library.

>  }
>  
> -#*******************************************************************************
> -#
> -# FUNCTION:  do_test
> -# PURPOSE:   Test changes to ifconfig, netstat, and ping commands
> -# INPUT:     None
> -# OUTPUT:    Error messages are logged when any verification test
> -#            fails.
> -#
> -#-----------------------------------------------------------------------
>  do_test()
>  {
> -   $trace_logic
> -   echo "Getting ALL enabled interfaces which are configured !"
> -
> -   IFNAME=${IFNAME:-$(netstat -i -n | grep "^[b-z]\{2,4\}[0-9][^*]"|\
> -      awk '{print $1}')}
> -   INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | awk '{print $2}')}
> -
> -   echo "Testing ifconfig and netstat"
> -
> -# Commented begin
> -#   # See if interface can be used for IP Multicast
> -#   ifconfig $IFNAME | grep -q MULTICAST
> -#   if [ $? != 0 ]; then
> -#	end_testcase "Multicast not listed for $IFNAME"
> -#   fi
> -#   netstat -gn | grep $IFNAME | grep -q 224.0.0.1
> -#   [ $? = 0 ] || end_testcase "all-host-group for $IFNAME not joined"
> -# Commented end
> -
> -#Finds the active ethernet interface
> -for eth in $IFNAME
> -    do
> -         ifconfig $eth | grep -q $INTERFACE
> -          if [ $? -eq 0 ]
> -          then
> -                INTERFACE_DEVICE=$eth
> -		break
> -           fi
> -    done
> -
> -# Added for support for more adapters configured
> -    MulticastAdap=
> -    for eth in $IFNAME
> -    do
> -
> -	$trace_logic
> -	ifconfig $eth | grep -q MULTICAST
> -	if [ $? -eq 0 ]
> -	then
> -	    $trace_logic
> -	    MulticastAdap=$eth
> -	    break
> +	echo "Getting ALL enabled interfaces which are configured !"

This should be tst_resm TINFO but that is rather cosmetic.

> +
> +	IFNAME=${IFNAME:-$(netstat -i -n | sed '1,2 d' | awk '{print $1}')}
> +	INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | \
> +				 awk '{print $2}')}
> +
> +	echo "Testing ifconfig and netstat"

Here as well.

> +	# Finds the active ethernet interface
> +	for eth in $IFNAME
> +	do
> +		ifconfig $eth | grep -q $INTERFACE
> +		if [ $? -eq 0 ]; then
> +			INTERFACE_DEVICE=$eth
> +			break
> +		fi
> +	done
> +
> +	MulticastAdap=
> +	for eth in $IFNAME
> +	do
> +
> +		ifconfig $eth | grep -q MULTICAST
> +		if [ $? -eq 0 ]; then
> +			MulticastAdap=$eth
> +			break
> +		fi
> +	done
> +	if [ -z $MulticastAdap ]; then
> +		tst_brkm TFAIL "Multicast not listed for $IFNAME"
>  	fi
> -    done
> -    if [ -z $MulticastAdap ]
> -    then
> -	end_testcase "Multicast not listed for $IFNAME"
> -    fi
> -    MulticastAdapJoined=
> -    for eth in $IFNAME
> -    do
> -	$trace_logic
> -	netstat -gn | grep $eth | grep -q 224.0.0.1
> -	if [ $? -eq 0 ]
> -	then
> -	    $trace_logic
> -	    MulticastAdapJoined=1
> -	    break
> +	MulticastAdapJoined=
> +	for eth in $IFNAME
> +	do
> +		netstat -gn | grep $eth | grep -q 224.0.0.1
> +		if [ $? -eq 0 ]; then
> +			MulticastAdapJoined=1
> +			break
> +		fi
> +	done
> +	if [ -z $MulticastAdapJoined ]; then
> +		tst_brkm TFAIL "all-host-group for $IFNAME not joined"
>  	fi
> -    done
> -    if [ -z $MulticastAdapJoined ]
> -    then
> -	end_testcase "all-host-group for $IFNAME not joined"
> -    fi
> -# Added end
> -
> -   cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts | grep 1 > /dev/null
> -   if [ $? -eq 0 ]
> -   then
> -       tst_resm TCONF "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
> -       rm -rf $TCtmp
> -       exit 0
> -   fi
> -
> -   # Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
> -   # number of responses are returned.
> -
> -   echo "Ping all-host-groups address(over default route!)"
> -   ping -c2 224.0.0.1 > $PING_OUT
> -   [ $? = 0 ] || end_testcase "No response from MC hosts to ping 224.0.0.1"
> -
> -   echo "Ping all-host-groups over specified interface"
> -   ping -c2 -I $INTERFACE 224.0.0.1 > $PING_OUT
> -  if [ $? -ne 0 ]
> -   then
> -        echo "Trying to ping with $INTERFACE_DEVICE instead of IP address"
> -        echo "with the -I option"
> -        ping -c2 -I $INTERFACE_DEVICE 224.0.0.1 > $PING_OUT
> -   [ $? = 0 ] || end_testcase "No response from MC hosts to ping -c2 -I$INTERFACE 224.0.0.1"
> -fi
> -   grep -q $INTERFACE $PING_OUT
> -   [ $? = 0 ] || end_testcase "Local host did not respond to ping -c2 -I$INTERFACE 224.0.0.1"
>  
> +	# Do the ping tests: Execute ping 224.0.0.1 - Verify that the proper
> +	# number of responses are returned.
> +	echo "Ping all-host-groups address(over default route!)"
> +	ping -c2 224.0.0.1 > $PING_OUT
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TFAIL "No response from MC hosts to ping 224.0.0.1"
> +	fi
>  
> +	echo "Ping all-host-groups over specified interface"
> +	ping -c2 -I $INTERFACE 224.0.0.1 > $PING_OUT
> +	if [ $? -ne 0 ]; then
> +		echo "Trying to ping with $INTERFACE_DEVICE"
> +		echo "with the -I option instead of IP address"
> +		ping -c2 -I $INTERFACE_DEVICE 224.0.0.1 > $PING_OUT
> +		if [ $? -ne 0 ]; then
> +			tst_brkm TFAIL "No response from MC hosts to ping -c2 "\
> +				       "-I$INTERFACE 224.0.0.1"
> +		fi
> +	fi
> +	grep -q $INTERFACE $PING_OUT
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TFAIL "Local host did not respond to ping -c2 "\
> +			       "-I$INTERFACE 224.0.0.1"
> +	fi
>  }
>  
> -#-----------------------------------------------------------------------
> -#
> -# FUNCTION:     do_cleanup
> -# PURPOSE:      Called when the testcase is interrupted by the user
> -#               or by interrupt_testcase() when time limit expired
> -# INPUT:        None.
> -# OUTPUT:       None.
> -#
> -#-----------------------------------------------------------------------
> -
>  do_cleanup()
>  {
> -   $trace_logic
> -   echo "$this_file: doing $0."
> -   rm -rf $TCtmp
> +	rm -rf $TCtmp

And we should do tst_rmdir() here instead.

>  }
>  
> -#=============================================================================
> -# FUNCTION NAME:        end_testcase
> -#
> -# FUNCTION DESCRIPTION: Clean up
> -#
> -# PARAMETERS:           string, IF AND ONLY IF the testcase fails
> -#
> -# RETURNS:              None.
> -#=============================================================================
> -
> -end_testcase()
> -{
> -   $trace_logic
> -   echo "$this_file: doing $0."
> -
> -   # Call other cleanup functions
> -   [ $CLEANUP = "ON" ] && do_cleanup
> -
> -   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
> -   tst_resm TFAIL "Test Failed: $@"
> -   exit 1
> -}
> -
> -#*******************************************************************************
> -#
> -# FUNCTION:  MAIN
> -# PURPOSE:   To invoke functions that perform the tasks as described in
> -#            the design in the prolog above.
> -# INPUT:     See SETUP in the prolog above.
> -# OUTPUT:    Logged run results written to testcase run log
> -#
> -#*******************************************************************************
>  setup
> +TST_CLEANUP=do_cleanup
> +
>  do_test
> -end_testcase
> +if [ $? -ne 0 ]; then
> +	tst_resm TFAIL "Test Failed"

Given that the do_test() now calls tst_brkm when something goes wrong I
doubt that you can get to this tst_resm at all.

What should be sufficient is to add the tst_resm TPASS "Test
successfull" and tst_exit to the end of the do_test function and all
that needs to be done here then is to call the do_test function.

> +else
> +	tst_resm TPASS "Test Successful"
> +fi
> +
> +tst_exit
> -- 
> 1.9.3
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> Slashdot TV.  
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
