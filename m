Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VvdWM-000590-P7
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:44:26 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VvdWL-0003Pf-Co
	for ltp-list@lists.sourceforge.net; Wed, 25 Dec 2013 01:44:26 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBP1iINJ027550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:19 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1iHkU015427
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:18 GMT
Received: from ubhmt111.oracle.com (ubhmt111.oracle.com [156.151.24.16])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBP1iHbA014134
	for <ltp-list@lists.sourceforge.net>; Wed, 25 Dec 2013 01:44:17 GMT
Message-ID: <52BA386D.50903@oracle.com>
Date: Wed, 25 Dec 2013 09:44:13 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1386750816-782-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1386750816-782-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] ip_tests.sh: fix errors
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
To: ltp-list@lists.sourceforge.net

Could anyone help to review this?

Thanks
Simon

On 2013/12/11 16:33, Simon Xu wrote:
> 1) Eliminate '|| RC=$?' because because it may not be excecuted and the
>     original value in RC can mess things up.  Also remove the RC=0
>     initializations that are now unnecessary.
> 2) Exit test immediately with non-zero return code when a test fails.
> 3) Add missing parameters in calling tst_brk and tst_brkm
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/network/iproute/ip_tests.sh | 128 ++++++++++++++++++++--------------
>   1 file changed, 74 insertions(+), 54 deletions(-)
>
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index 0416300..ed20540 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -45,7 +45,6 @@ set +x
>   init()
>   {
>   
> -	export RC=0					# Return code from commands.
>   	export TST_TOTAL=2			# total numner of tests in this file.
>   	export TCID="ip_tests  "		# this is the init function.
>   	export TST_COUNT=0			# init identifier,
> @@ -61,15 +60,17 @@ init()
>   	trap "cleanup" 0
>   
>   	# create the tmp directory for this testcase.
> -	mkdir -p $LTPTMP/ >/dev/null 2>&1 || RC=$?
> +	mkdir -p $LTPTMP/ >/dev/null 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
> -		tst_brkm TBROK "INIT: Unable to create temporary directory"
> +		tst_brkm TBROK NULL "INIT: Unable to create temporary directory"
>   		return $RC
>   	fi
>   
>   	# Check to see if test harness functions are in the path.
> -	which tst_resm  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	which tst_resm  >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brkm TBROK NULL \
> @@ -77,7 +78,8 @@ init()
>   		return $RC
>   	fi
>   
> -	which awk  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	which awk  >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brkm TBROK NULL \
> @@ -85,7 +87,8 @@ init()
>   		return $RC
>   	fi
>   
> -	which ip  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	which ip  >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brkm TBROK NULL \
> @@ -93,7 +96,8 @@ init()
>   		return $RC
>   	fi
>   
> -	which ifconfig  >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	which ifconfig  >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brkm TBROK NULL \
> @@ -104,24 +108,25 @@ init()
>   	tst_resm TINFO "INIT: Inititalizing tests."
>   
>   	# Aliasing eth0 to create private network.
> -	/sbin/ifconfig eth0:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	/sbin/ifconfig eth0:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
> -		tst_brk TBROK "INIT: failed aliasing eth0:1 with IP 10.1.1.12"
> +		tst_brk TBROK NULL NULL "INIT: failed aliasing eth0:1 with IP 10.1.1.12"
>   		return $RC
>   	else
> -		/sbin/route add -host 10.1.1.12 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 \
> -			|| RC=$?
> +		/sbin/route add -host 10.1.1.12 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
> -			tst_brk TBROK "INIT: failed adding route to 10.1.1.12"
> +			tst_brk TBROK NULL NULL "INIT: failed adding route to 10.1.1.12"
>   			return $RC
>   		else
>   			tst_resm TINFO "INIT: added alias: `ifconfig eth0:1`"
>   		fi
>   	fi
>   
> -	cat > $LTPTMP/tst_ip02.exp <<-EOF || RC=$?
> +	cat > $LTPTMP/tst_ip02.exp <<-EOF
>   	1:
>   	link/loopback
>   	2:
> @@ -129,7 +134,7 @@ init()
>   	3:
>   	link/ether
>   	EOF
> -
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brkm TBROK NULL "INIT: failed creating expected output for test02"
> @@ -151,9 +156,9 @@ cleanup()
>   {
>   	TCID=dhcpd
>   	TST_COUNT=0
> -	RC=0
>   
> -	/sbin/ifconfig eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	/sbin/ifconfig eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -eq 0 ]
>   	then
>   		/sbin/ifconfig eth0:1 down >$LTPTMP/tst_ip.err 2>&1
> @@ -178,7 +183,6 @@ cleanup()
>   
>   test01()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip01	    # Name of the test case.
>   	TST_COUNT=1		# Test number.
>   
> @@ -225,7 +229,6 @@ test01()
>   
>   test02()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip02	    # Name of the test case.
>   	TST_COUNT=2		# Test number.
>   
> @@ -236,7 +239,8 @@ test02()
>   	tst_resm TINFO \
>   	 "Test #2: Installing dummy.o in kernel"
>   
> -	modprobe dummy >$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +	modprobe dummy >$LTPTMP/tst_ip.out 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brk TBROK $LTPTMP/tst_ip.out NULL \
> @@ -244,7 +248,8 @@ test02()
>   		return $RC
>   	fi
>   
> -	ip link show dummy0 | grep dummy0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ip link show dummy0 | grep dummy0 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err "Test #2: ip command failed. Reason:"
> @@ -275,14 +280,14 @@ test02()
>   
>   test03()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip03	    # Name of the test case.
>   	TST_COUNT=3		# Test number.
>   
>   	tst_resm TINFO \
>   	 "Test #3: ip addr add - adds a new protolcol address to the device"
>   
> -	ip addr add 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ip addr add 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -291,7 +296,8 @@ test03()
>   	else
>   		tst_resm TINFO \
>   		 "Test #3: ip addr show dev <device> - shows protocol address."
> -		ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +		ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -301,14 +307,16 @@ test03()
>   
>   		tst_resm TINFO \
>   		 "Test #3: ip addr del <ip> dev <device> - deletes protocol address."
> -		ip addr del 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +		ip addr del 127.6.6.6 dev lo >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #3: ip addr del command failed. Reason: "
>   			return $RC
>   		else
> -			ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +			ip addr show dev lo | grep 127.6.6.6 >$LTPTMP/tst_ip.err 2>&1
> +			RC=$?
>   			if [ $RC -eq 0 ]
>   			then
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -342,14 +350,14 @@ test03()
>   
>   test04()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip04	    # Name of the test case.
>   	TST_COUNT=4		# Test number.
>   
>   	tst_resm TINFO \
>   	 "Test #4: ip neigh add - adds a new neighbour to arp tables."
>   
> -	ip neigh add 127.0.0.1 dev lo nud reachable >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ip neigh add 127.0.0.1 dev lo nud reachable >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -363,7 +371,8 @@ test04()
>   		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
>   		EOF
>   
> -		ip neigh show 127.0.0.1 | head -n1 >$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +		ip neigh show 127.0.0.1 | head -n1 >$LTPTMP/tst_ip.out 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -371,7 +380,8 @@ test04()
>   			return $RC
>   		else
>   			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
> -				>$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +				>$LTPTMP/tst_ip.err 2>&1
> +			RC=$?
>   			if [ $RC -ne 0 ]
>   			then
>   				tst_res FAIL $LTPTMP/tst_ip.err \
> @@ -383,14 +393,16 @@ test04()
>   		tst_resm TINFO \
>   		 "Test #4: ip neigh del - deletes neighbour from the arp table."
>   
> -		ip neigh del 127.0.0.1 dev lo >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +		ip neigh del 127.0.0.1 dev lo >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #4: ip neigh del command failed return = $RC. Reason: "
>   			return $RC
>   		else
> -			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$" >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +			ip neigh show | grep 127.0.0.1 | grep -v " FAILED$" >$LTPTMP/tst_ip.err 2>&1
> +			RC=$?
>   			if [ $RC -eq 0 ]
>   			then
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -423,7 +435,6 @@ test04()
>   
>   test05()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip05	    # Name of the test case.
>   	TST_COUNT=5		# Test number.
>   
> @@ -434,7 +445,8 @@ test05()
>   	tst_resm TINFO \
>   	 "Test #5: create an interface with inet 10.6.6.6 alias to eth0"
>   
> -	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
> @@ -442,7 +454,8 @@ test05()
>   		return $RC
>   	fi
>   
> -	ip route add 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ip route add 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -458,7 +471,8 @@ test05()
>   		EOF
>   
>   		ip route show | grep "10.6.6.6 via 127.0.0.1 dev lo" \
> -			>$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +			>$LTPTMP/tst_ip.out 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -466,7 +480,8 @@ test05()
>   			return $RC
>   		else
>   			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
> -				>$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +				>$LTPTMP/tst_ip.err 2>&1
> +			RC=$?
>   			if [ $RC -ne 0 ]
>   			then
>   				tst_res FAIL $LTPTMP/tst_ip.err \
> @@ -478,14 +493,16 @@ test05()
>   		tst_resm TINFO \
>   		 "Test #5: ip route del - deletes route from the route table."
>   
> -		ip route del 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +		ip route del 10.6.6.6 via 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #5: ip route del command failed return = $RC. Reason: "
>   			return $RC
>   		else
> -			ip route show | grep 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +			ip route show | grep 127.0.0.1 >$LTPTMP/tst_ip.err 2>&1
> +			RC=$?
>   			if [ $RC -eq 0 ]
>   			then
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -518,14 +535,14 @@ test05()
>   
>   test06()
>   {
> -	RC=0			# Return value from commands.
>   	TCID=ip06	    # Name of the test case.
>   	TST_COUNT=6		# Test number.
>   
>   	tst_resm TINFO \
>   	 "Test #6: ip maddr add - adds a new multicast addr"
>   
> -	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
> @@ -533,7 +550,8 @@ test06()
>   		return $RC
>   	fi
>   
> -	ip maddr add 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +	ip maddr add 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -547,7 +565,8 @@ test06()
>           link  66:66:00:00:00:66 static
>   		EOF
>   
> -		ip maddr show | grep "66:66:00:00:00:66" >$LTPTMP/tst_ip.out 2>&1 || RC=$?
> +		ip maddr show | grep "66:66:00:00:00:66" >$LTPTMP/tst_ip.out 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -555,7 +574,8 @@ test06()
>   			return $RC
>   		else
>   			diff -iwB  $LTPTMP/tst_ip.out $LTPTMP/tst_ip.exp \
> -				&>$LTPTMP/tst_ip.err || RC=$?
> +				&>$LTPTMP/tst_ip.err
> +			RC=$?
>   			if [ $RC -ne 0 ]
>   			then
>   				tst_res FAIL $LTPTMP/tst_ip.err \
> @@ -567,15 +587,16 @@ test06()
>   		tst_resm TINFO \
>   		 "Test #6: ip maddr del - deletes multicast addr."
>   
> -		ip maddr del 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1 || RC=$?
> +		ip maddr del 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_res TFAIL $LTPTMP/tst_ip.err \
>   				"Test #6: ip maddr del command failed return = $RC. Reason: "
>   			return $RC
>   		else
> -			ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.err \
> -				|| RC=$?
> +			ip maddr show | grep "66:66:00:00:00:66" &>$LTPTMP/tst_ip.err
> +			RC=$?
>   			if [ $RC -eq 0 ]
>   			then
>   				tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -599,15 +620,14 @@ test06()
>   # Exit:			- zero on success
>   # 				- non-zero on failure.
>   TFAILCNT=0			# Set TFAILCNT to 0, increment on failure.
> -RC=0				# Return code from test.
>   
>   init || exit $RC
>   
> -test01 || RC=$?
> -test02 || RC=$?
> -test03 || RC=$?
> -test04 || RC=$?
> -test05 || RC=$?
> -test06 || RC=$?
> +test01 || exit $RC
> +test02 || exit $RC
> +test03 || exit $RC
> +test04 || exit $RC
> +test05 || exit $RC
> +test06 || exit $RC
>   
> -exit $RC
> +exit 0


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
