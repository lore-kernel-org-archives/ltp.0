Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WdUal-0000Zn-KL
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 01:06:15 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WdUak-000394-M3
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 01:06:15 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3P1689p013262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 01:06:09 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3P167hg022324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 01:06:08 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3P166DO009177
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 01:06:06 GMT
Message-ID: <5359B4F9.6040405@oracle.com>
Date: Fri, 25 Apr 2014 09:06:01 +0800
From: Simon Xu <xu.simon@oracle.com>
MIME-Version: 1.0
References: <1395971064-625-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <1395971064-625-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] ip_tests.sh: don't use hardcoded eth0
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

On 2014/3/28 9:44, Simon Xu wrote:
> The script uses hardcoded 'eth0' which used to work on most systems.
> This fix tries to find a 'working' network interface using the hostname.
>
> Signed-off-by: Simon Xu <xu.simon@oracle.com>
> ---
>   testcases/network/iproute/ip_tests.sh | 50 +++++++++++++++++++----------------
>   1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> index ed20540..4bba243 100755
> --- a/testcases/network/iproute/ip_tests.sh
> +++ b/testcases/network/iproute/ip_tests.sh
> @@ -38,7 +38,7 @@ set +x
>   # Description:	- Check if command ip is available.
>   #               - Check if command ifconfig is available.
>   #               - check if command awk is available.
> -#               - alias eth0 to eth0:1 with IP 10.1.1.12
> +#               - alias $INF to $INF:1 with IP 10.1.1.12
>   #
>   # Return		- zero on success
>   #               - non zero on failure. return value from commands ($RC)
> @@ -46,7 +46,7 @@ init()
>   {
>   
>   	export TST_TOTAL=2			# total numner of tests in this file.
> -	export TCID="ip_tests  "		# this is the init function.
> +	export TCID="ip_tests"			# this is the init function.
>   	export TST_COUNT=0			# init identifier,
>   
>   	if [ -z $TMP ]
> @@ -107,22 +107,26 @@ init()
>   
>   	tst_resm TINFO "INIT: Inititalizing tests."
>   
> -	# Aliasing eth0 to create private network.
> -	/sbin/ifconfig eth0:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1
> +	# Get network interface.
> +	IP=$(dig +short $(hostname))
> +	INF=$(ifconfig|grep -B1 $IP|head -1|sed 's/:.*//')
> +
> +	# Aliasing $INF to create private network.
> +	/sbin/ifconfig $INF:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
> -		tst_brk TBROK NULL NULL "INIT: failed aliasing eth0:1 with IP 10.1.1.12"
> +		tst_brk TBROK NULL NULL "INIT: failed aliasing $INF:1 with IP 10.1.1.12"
>   		return $RC
>   	else
> -		/sbin/route add -host 10.1.1.12 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +		/sbin/route add -host 10.1.1.12 dev $INF:1 >$LTPTMP/tst_ip.err 2>&1
>   		RC=$?
>   		if [ $RC -ne 0 ]
>   		then
>   			tst_brk TBROK NULL NULL "INIT: failed adding route to 10.1.1.12"
>   			return $RC
>   		else
> -			tst_resm TINFO "INIT: added alias: `ifconfig eth0:1`"
> +			tst_resm TINFO "INIT: added alias: `ifconfig $INF:1`"
>   		fi
>   	fi
>   
> @@ -148,7 +152,7 @@ init()
>   # Function:		cleanup
>   #
>   # Description	- remove temporary files and directories.
> -#               - remove alias to eth0
> +#               - remove alias to $INF
>   #
>   # Return		- zero on success
>   #               - non zero on failure. return value from commands ($RC)
> @@ -157,11 +161,11 @@ cleanup()
>   	TCID=dhcpd
>   	TST_COUNT=0
>   
> -	/sbin/ifconfig eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +	/sbin/ifconfig $INF:1 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -eq 0 ]
>   	then
> -		/sbin/ifconfig eth0:1 down >$LTPTMP/tst_ip.err 2>&1
> +		/sbin/ifconfig $INF:1 down >$LTPTMP/tst_ip.err 2>&1
>   	fi
>   
>   	rm -fr $LTPTMP
> @@ -189,11 +193,11 @@ test01()
>   	tst_resm TINFO \
>   	 "Test #1: ip link set DEVICE mtu MTU changes the device mtu size"
>   
> -	tst_resm TINFO "Test #1: changing mtu size of eth0:1 device."
> +	tst_resm TINFO "Test #1: changing mtu size of $INF:1 device."
>   
>   	MTUSZ_BAK=`ifconfig eth0:1 | grep -i MTU | sed "s/^.*MTU://" \
>   		| awk '{print $1}'`
> -	ip link set eth0:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
> +	ip link set $INF:1 mtu 300 >$LTPTMP/tst_ip.err 2>&1
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_res TFAIL $LTPTMP/tst_ip.err \
> @@ -204,7 +208,7 @@ test01()
>   		if [ $MTUSZ -eq 300 ]
>   		then
>   			tst_resm TPASS "Test #1: changing mtu size success"
> -			ip link set eth0:1 mtu $MTUSZ_BAK \
> +			ip link set $INF:1 mtu $MTUSZ_BAK \
>   				>$LTPTMP/tst_ip.err 2>&1
>   		else
>   			tst_resm FAIL NULL \
> @@ -256,7 +260,7 @@ test02()
>   		return $RC
>   	else
>   		tst_resm TPASS \
> -			"Test #2: Listed eth0:1 and returned correct attributes"
> +			"Test #2: Listed $INF:1 and returned correct attributes"
>   	fi
>   	return $RC
>   }
> @@ -365,7 +369,7 @@ test04()
>   		return $RC
>   	else
>   		tst_resm TINFO \
> -		 "Test #4: ip neigh show - shows all neighbour entries in arp tables."
> +			"Test #4: ip neigh show - shows all neighbour entries in arp tables."
>   
>   		cat > $LTPTMP/tst_ip.exp <<-EOF
>   		127.0.0.1 dev lo lladdr 00:00:00:00:00:00 REACHABLE
> @@ -443,14 +447,14 @@ test05()
>   
>   
>   	tst_resm TINFO \
> -	 "Test #5: create an interface with inet 10.6.6.6 alias to eth0"
> +	 "Test #5: create an interface with inet 10.6.6.6 alias to $INF"
>   
> -	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
> +	ifconfig $INF:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
> -			"Test #5: unable to create interface eth0:1 inet 10.6.6.6. Reason:"
> +			"Test #5: unable to create interface $INF:1 inet 10.6.6.6. Reason:"
>   		return $RC
>   	fi
>   
> @@ -541,16 +545,16 @@ test06()
>   	tst_resm TINFO \
>   	 "Test #6: ip maddr add - adds a new multicast addr"
>   
> -	ifconfig eth0:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
> +	ifconfig $INF:1 10.6.6.6 netmask 255.255.255.0 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
>   		tst_brk TBROK $LTPTMP/tst_ip.err NULL \
> -			"Test #6: unable to create interface eth0:1 inet 10.6.6.6. Reason:"
> +			"Test #6: unable to create interface $INF:1 inet 10.6.6.6. Reason:"
>   		return $RC
>   	fi
>   
> -	ip maddr add 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +	ip maddr add 66:66:00:00:00:66 dev $INF:1 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -ne 0 ]
>   	then
> @@ -579,7 +583,7 @@ test06()
>   			if [ $RC -ne 0 ]
>   			then
>   				tst_res FAIL $LTPTMP/tst_ip.err \
> -					"Test #6: multicast addr not added to eth0:1. Details:"
> +					"Test #6: multicast addr not added to $INF:1. Details:"
>   				return $RC
>   			fi
>   		fi
> @@ -587,7 +591,7 @@ test06()
>   		tst_resm TINFO \
>   		 "Test #6: ip maddr del - deletes multicast addr."
>   
> -		ip maddr del 66:66:00:00:00:66 dev eth0:1 >$LTPTMP/tst_ip.err 2>&1
> +		ip maddr del 66:66:00:00:00:66 dev $INF:1 >$LTPTMP/tst_ip.err 2>&1
>   		RC=$?
>   		if [ $RC -ne 0 ]
>   		then


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
