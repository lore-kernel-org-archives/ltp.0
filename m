Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XhFTF-0007i7-6F
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 10:18:17 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XhFTC-0007b7-St
	for ltp-list@lists.sourceforge.net; Thu, 23 Oct 2014 10:18:17 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s9NAI8ub001385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Oct 2014 10:18:09 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s9NAI70R020476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Oct 2014 10:18:08 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s9NAI6AL020350
	for <ltp-list@lists.sourceforge.net>; Thu, 23 Oct 2014 10:18:07 GMT
Message-ID: <5448D65C.90308@oracle.com>
Date: Thu, 23 Oct 2014 14:20:12 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1413978094-10616-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH v2 1/3] network/test_net: add support for -6
 option (IPv6 tests)
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
Cc: vasily.isaenko@oracle.com

Hi!

On 10/22/2014 03:41 PM, Alexey Kodanev wrote:
> * copy read_opts() from net_cmdlib.sh library;
> * replace TST_EXEC_SUFFIX with more informative name TST_IPV6;
> * skip other options;
>
> Signed-off-by: Alexey Kodanev<alexey.kodanev@oracle.com>
> ---
>   testcases/lib/test_net.sh |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 8cbcb70..24460f3 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -137,3 +137,18 @@ tst_iface()
>   	link_num=$(( $link_num + 1 ))
>   	echo "$(tst_get_ifaces $type)" | awk '{ print $'"$link_num"' }'
>   }
> +
> +# Blank for an IPV4 test; 6 for an IPV6 test.
> +TST_IPV6=
> +
> +tst_read_opts()
> +{
> +	OPTIND=0
> +	while getopts ":6" opt; do
> +		case "$opt" in
> +		6)
> +			TST_IPV6=6;;
> +		esac
> +	done
> +	OPTIND=0
> +}

Maybe we can run the function inside test_net.sh as well. Any suggestions?

Thanks,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
