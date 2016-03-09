Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1adcpe-0007AJ-6T
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2016 12:03:14 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1adcpY-0005Xn-Ev
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2016 12:03:14 +0000
Message-ID: <56E01222.6020909@oracle.com>
Date: Wed, 09 Mar 2016 15:08:02 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1457334114-10461-1-git-send-email-haliu@redhat.com>
	<1457334114-10461-2-git-send-email-haliu@redhat.com>
In-Reply-To: <1457334114-10461-2-git-send-email-haliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] lib/test_net.sh: add tst_ping() to check icmp
 connectivity
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
To: Hangbin Liu <haliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi,
On 03/07/2016 10:01 AM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>   testcases/lib/test_net.sh | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 418fed3..f75e78e 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -314,3 +314,40 @@ tst_netload()
>   
>   	return $ret
>   }
> +
> +# tst_ping IFACE ADDR [SIZE]
> +# Check icmp connectivity
> +# IFACE: source interface name
> +# ADDR: destination IPv4 or IPv6 address
> +# SIZE: message size
> +tst_ping()
> +{
> +	# The max number of ICMP echo request
> +	PING_MAX=${PING_MAX:-"10"}
> +
> +	# Check the arguments
> +	if [ $# -lt 2 ]; then
> +		tst_resm TBROK "tst_ping src_iface dest_ipv4/6_addr [msg_size]"
> +		return 1
> +	fi
> +
> +	local src_iface=$1
> +	local dst_addr=$2

They could be defaulted to $(tst_iface) and $(tst_ipaddr rhost) accordingly.
Then, we don't have to check the number of arguments and it fits for the 
most cases.

> +	# ping cmd use 56 as default message size
> +	local msg_size=${3:-"56"}
> +
> +	if echo $dst_addr | grep ":"; then
> +		local PING="ping6"
> +		TST_IPV6=6
> +	else
> +		local PING="ping"
> +	fi
> +

if test runs with -6 option, TST_IPV6 will be defined as 6, otherwise is "".
We can use it inside test_net.sh and tests. So here, we could call ping 
command
as follows: "ping$TST_IPV6 ..."


> +	if [ "$dst_addr" == "$(tst_ipaddr)" ]; then
> +		tst_rhost_run -c "$PING -I $src_iface -c $PING_MAX $dst_addr \
> +			-s $msg_size > /dev/null 2>&1"
> +	else
> +		$PING -I $src_iface -c $PING_MAX $dst_addr -s $msg_size > \
> +			/dev/null 2>&1
> +	fi
> +}

Do we actually need to run this command from remote host?

Best regards,
Alexey


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
