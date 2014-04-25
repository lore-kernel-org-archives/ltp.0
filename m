Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WdfDR-0008Lv-Sj
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 12:26:53 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WdfDP-0004dG-Ui
	for ltp-list@lists.sourceforge.net; Fri, 25 Apr 2014 12:26:53 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3PCQix9005756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 12:26:45 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3PCQin7021538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 12:26:44 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3PCQiVR021533
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Apr 2014 12:26:44 GMT
Message-ID: <535A5482.2010206@oracle.com>
Date: Fri, 25 Apr 2014 16:26:42 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
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
To: Simon Xu <xu.simon@oracle.com>, ltp-list@lists.sourceforge.net

Hi!

On 03/28/2014 05:44 AM, Simon Xu wrote:
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

This would require that the $(hostname) is registered to DNS.

Given that we only need a working device (no matter what ip it has), 
maybe just do something like:
/sbin/ifconfig | grep HWaddr | head -n 1
to get a L2-capable device.

What do you think?

> +	INF=$(ifconfig|grep -B1 $IP|head -1|sed 's/:.*//')
> +
> +	# Aliasing $INF to create private network.
> +	/sbin/ifconfig $INF:1 10.1.1.12 >$LTPTMP/tst_ip.err 2>&1
>   	RC=$?
>   	if [ $RC -ne 0 ]
>   	then

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
