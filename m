Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VadJ2-0006FD-TD
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:15:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VadJ1-0003xq-F8
	for ltp-list@lists.sourceforge.net; Mon, 28 Oct 2013 03:15:52 +0000
Message-ID: <526DD69C.2070302@cn.fujitsu.com>
Date: Mon, 28 Oct 2013 11:14:36 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1382704355-27129-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1382704355-27129-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] kernel/connectors: TCONF vs TBROK,
 and fix check for root
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

On 10/25/2013 08:32 PM, Stanislav Kholmanskikh wrote:
> Fixed check for root the same way as in
> 08dcfbb5a4ebad9319c54935a600ab936708c6da.
> 
> If the test is run on unsupported kernels it
> should return TCONF, not TBROK. Fixed this.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/connectors/pec/run_pec_test |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/connectors/pec/run_pec_test b/testcases/kernel/connectors/pec/run_pec_test
> index 7577ffa..2729485 100755
> --- a/testcases/kernel/connectors/pec/run_pec_test
> +++ b/testcases/kernel/connectors/pec/run_pec_test
> @@ -33,14 +33,14 @@ export TST_COUNT=1
>  
>  exit_status=0
>  
> -if [ "$USER" != root ]; then
> -	tst_brkm TBROK ignored "Test must be run as root"
> +if [ $(id -u) != 0 ]; then
> +	tst_brkm TCONF ignored "Test must be run as root"
>  	exit 0;
>  fi
>  
>  grep cn_proc /proc/net/connector > /dev/null
>  if [ $? -ne 0 ]; then
> -	tst_brkm TBROK ignored "Process Event Connector is not supported or kernel is below 2.6.26"
> +	tst_brkm TCONF ignored "Process Event Connector is not supported or kernel is below 2.6.26"
>  	exit 0;
>  fi
>  
> @@ -77,7 +77,7 @@ run_case()
>  	fi
>  
>  	if [ $ret2 -eq 2 ]; then
> -		tst_brkm TBROK NULL "connector may not be supported"
> +		tst_brkm TCONF NULL "connector may not be supported"
>  		exit 0
>  	fi
>  
> 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
