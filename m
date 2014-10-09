Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1XcAdD-0002ct-5m
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 10:07:35 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XcAdC-00038n-9z
	for ltp-list@lists.sourceforge.net; Thu, 09 Oct 2014 10:07:35 +0000
Message-ID: <54365ED3.9020805@oracle.com>
Date: Thu, 09 Oct 2014 14:09:23 +0400
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1412837187-5523-1-git-send-email-liuhangbin@gmail.com>
In-Reply-To: <1412837187-5523-1-git-send-email-liuhangbin@gmail.com>
Subject: Re: [LTP] [PATCH] network/test_net: delete obsolete net_cmdlib.sh
 and move read_opts() to test_net
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!

Please find almost the same patch that I've re-sent to ML yesterday.

Moreover, net_cmdlib.sh source cmdlib.sh, so the patch should replace 
all other outdated functions. And it's better to do it in the separate 
patches. Also note that I've already sent patches that fix ping, 
sendfile and tcpdump tests (pending review).

Best regards,
Alexey

On 10/09/2014 10:46 AM, Hangbin Liu wrote:
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   testcases/lib/cmdlib.sh                        |  1 +
>   testcases/lib/net_cmdlib.sh                    | 40 --------------------------
>   testcases/lib/test_net.sh                      | 20 +++++++++++++
>   testcases/network/tcp_cmds/arp/arp01           |  2 +-
>   testcases/network/tcp_cmds/echo/echo01         |  2 +-
>   testcases/network/tcp_cmds/finger/finger01     |  2 +-
>   testcases/network/tcp_cmds/ftp/ftp01           |  2 +-
>   testcases/network/tcp_cmds/host/host01         |  2 +-
>   testcases/network/tcp_cmds/netstat/netstat01   |  2 +-
>   testcases/network/tcp_cmds/perf_lan/perf_lan   |  2 +-
>   testcases/network/tcp_cmds/ping/ping01         |  2 +-
>   testcases/network/tcp_cmds/rcp/rcp01           |  2 +-
>   testcases/network/tcp_cmds/rdist/rdist01       |  2 +-
>   testcases/network/tcp_cmds/rsh/rsh01           |  2 +-
>   testcases/network/tcp_cmds/rwho/rwho01         |  2 +-
>   testcases/network/tcp_cmds/sendfile/sendfile01 |  2 +-
>   testcases/network/tcp_cmds/tcpdump/tcpdump01   |  2 +-
>   17 files changed, 35 insertions(+), 54 deletions(-)
>   delete mode 100644 testcases/lib/net_cmdlib.sh
>
> diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
> index 104504f..fc0529e 100644
> --- a/testcases/lib/cmdlib.sh
> +++ b/testcases/lib/cmdlib.sh
> @@ -24,6 +24,7 @@


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
