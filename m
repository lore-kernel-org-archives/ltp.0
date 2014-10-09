Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1XcDiQ-0002zS-V4
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 13:25:10 +0000
Received: from mail-ig0-f178.google.com ([209.85.213.178])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XcDiP-00071W-V6
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 13:25:10 +0000
Received: by mail-ig0-f178.google.com with SMTP id h3so4060783igd.11
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Oct 2014 06:25:04 -0700 (PDT)
Date: Thu, 9 Oct 2014 21:24:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20141009132453.GI24933@Leo.nay.redhat.com>
References: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412769465-16030-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH 1/3] network/test_net: add support for -6 option
 (IPv6 tests)
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Ah, find your patch here :)

Just as you said, net_cmdlib.sh source cmdlib.sh, so how about do it like
test.sh, add a global variable $CMD_LIB_LOADED in cmdlib.sh and add

[ -z "$CMD_LIB_LOADED" ] && . cmdlib.sh

in test_net.sh ?

For function read_opts(), I greped ltp and only found tests under tcp_cmds use
it. So I think it's OK to change all net_cmdlib.sh directly. But as your wish,
you can send it separately, not a big deal.

Thanks
Hangbin Liu
On Wed, Oct 08, 2014 at 03:57:43PM +0400, Alexey Kodanev wrote:
> copy read_opts() from net_cmdlib.sh library
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  testcases/lib/test_net.sh |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 8cbcb70..2436264 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -137,3 +137,21 @@ tst_iface()
>  	link_num=$(( $link_num + 1 ))
>  	echo "$(tst_get_ifaces $type)" | awk '{ print $'"$link_num"' }'
>  }
> +
> +# Blank for an IPV4 test; 6 for an IPV6 test.
> +TST_EXEC_SUFFIX=
> +
> +tst_read_opts()
> +{
> +	OPTIND=0
> +	while getopts "6" opt; do
> +		case "$opt" in
> +		6)
> +			TST_EXEC_SUFFIX=6;;
> +		*)
> +			tst_brkm TBROK "tst_read_opts: unknown option: $opt"
> +		;;
> +		esac
> +	done
> +	OPTIND=0
> +}
> -- 
> 1.7.1
> 
> 
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 

Thanks & Best Regards
Hangbin Liu <liuhangbin@gmail.com>

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
