Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Y2rFS-0007rs-1h
	for ltp-list@lists.sourceforge.net; Mon, 22 Dec 2014 00:53:22 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y2rFQ-0000jd-3R
	for ltp-list@lists.sourceforge.net; Mon, 22 Dec 2014 00:53:22 +0000
Message-ID: <54976B81.20203@cn.fujitsu.com>
Date: Mon, 22 Dec 2014 08:53:21 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
	<1418987492-17553-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1418987492-17553-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH v3] testcases/lib/test.sh: added tst_timeout()
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
To: Matus Marhefka <mmarhefk@redhat.com>, ltp-list@lists.sourceforge.net

On 12/19/2014 07:11 PM, Matus Marhefka wrote:
> Function tst_timeout() added into LTP test interface:
> 
> 	tst_timeout "command arg1 arg2 ..." timeout
> 
> Function enables waiting for specified command for timeout
> seconds. Example usage:
> 
> 	cmd_output=$(tst_timeout "ping -c 3 localhost" 5)
> 	if [ $? -ne 0 ]; then
> 		tst_brkm TBROK "timeout reached!"
> 	fi
> 
> where $cmd_output contains stdout and stderr of ping command.
> 
> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>

Nice function.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> ---
>  testcases/lib/test.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index eecbfba..ad78a87 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -129,6 +129,49 @@ tst_check_cmds()
>  	done
>  }
>  
> +# tst_timeout "command arg1 arg2 ..." timeout
> +# Runs command for specified timeout (in seconds).
> +# Function returns retcode of command or 1 if arguments are invalid.
> +tst_timeout()
> +{
> +	local command=$1
> +	local timeout=$(echo $2 | grep -o "^[0-9]\+$")
> +
> +	# command must be non-empty string with command to run
> +	if [ -z "$command" ]; then
> +		echo "first argument must be non-empty string"
> +		return 1
> +	fi
> +
> +	# accept only numbers as timeout
> +	if [ -z "$timeout" ]; then
> +		echo "only numbers as second argument"
> +		return 1
> +	fi
> +
> +	setsid sh -c "eval $command" 2>&1 &
> +	local pid=$!
> +	while [ $timeout -gt 0 ]; do
> +		kill -s 0 $pid 2>/dev/null
> +		if [ $? -ne 0 ]; then
> +			break
> +		fi
> +		timeout=$((timeout - 1))
> +		sleep 1
> +	done
> +
> +	local ret=0
> +	if [ $timeout -le 0 ]; then
> +		ret=128
> +		kill -TERM -- -$pid
> +	fi
> +
> +	wait $pid
> +	ret=$((ret | $?))
> +
> +	return $ret
> +}
> +
>  # Check that test name is set
>  if [ -z "$TCID" ]; then
>  	tst_brkm TBROK "TCID is not defined"
> 


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
