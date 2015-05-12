Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ys5pZ-00006s-0V
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 08:46:25 +0000
Date: Tue, 12 May 2015 10:45:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150512084547.GB3012@rei.suse.de>
References: <1428493449-9784-1-git-send-email-chase.qi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1428493449-9784-1-git-send-email-chase.qi@linaro.org>
Subject: Re: [LTP] [PATCH] cpuhotplug05.sh: fix invalid usage of sar
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
To: Chase Qi <chase.qi@linaro.org>
Cc: ltp-list@lists.sourceforge.net, naresh.kamboju@linaro.org, milosz.wasilewski@linaro.org

Hi!
> Increase the sleep time after online_cpu to
> adapt embedded hardware.
> 
> Signed-off-by: Chase Qi <chase.qi@linaro.org>
> ---
>  .../kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh   | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index bb0e896..f088d25 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -5,6 +5,7 @@
>  
>  export TCID="cpuhotplug05"
>  export TST_TOTAL=1
> +export LC_TIME="POSIX"
>  
>  # Includes:
>  . test.sh
> @@ -80,11 +81,11 @@ TST_CLEANUP=do_clean
>  until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
>  
>  	# Start up SAR and give it a couple cycles to run
> -	sar 1 0 &>/dev/null &
> +	sar 1 &>/dev/null &
>  	sleep 2
>  	if ps -C sar &>/dev/null; then
>  		pkill sar
> -		sar -P ALL 1 0 > $TMP/log_$$ &
> +		sar -P ALL 1 > $TMP/log_$$ &
>  	else
>  		sar -P ALL 1 > $TMP/log_$$ &
>  	fi
> @@ -92,14 +93,14 @@ until [ $LOOP_COUNT -gt $HOTPLUG05_LOOPS ]; do
>  	SAR_PID=$!
>  
>  	# Verify that SAR has correctly listed the missing CPU
> -	while ! awk '{print $9}' $TMP/log_$$ | grep -i "^0.00"; do
> +	while ! awk '{print $8}' $TMP/log_$$ | grep -i "^0.00"; do

Ah, it took me a while to figure out that the output of sar is different
based on LC_TIME. Can you please describe the changes more verbosely
than "fix invalid sar usage" in the commit message?

Otherwise the changes looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
