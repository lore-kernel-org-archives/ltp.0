Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XvmjF-0007xV-Qy
	for ltp-list@lists.sourceforge.net; Tue, 02 Dec 2014 12:38:53 +0000
Date: Tue, 2 Dec 2014 13:38:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141202123840.GA16824@rei.suse.de>
References: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] testcases/lib/test.sh: added tst_timeout()
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
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

Nice idea, comments below.

> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  testcases/lib/test.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
> index eecbfba..1c5bdf2 100644
> --- a/testcases/lib/test.sh
> +++ b/testcases/lib/test.sh
> @@ -129,6 +129,60 @@ tst_check_cmds()
>  	done
>  }
>  
> +# tst_timeout "command arg1 arg2 ..." timeout
> +# Runs command for specified timeout (in seconds).
> +# Function returns retcode of command or 1 if arguments are invalid.
> +tst_timeout()
> +{
> +	local command=$1
> +	local timeout=$2
> +	local usleep_time=100000
> +
> +	# command must be non-empty string with command to run
> +	if [ -z "$command" ]; then
> +		echo "first argument must be non-empty string"
> +		return 1
> +	fi
> +
> +	# accept only numbers as timeout
> +	re='^[0-9]+$'
> +	if ! [[ $timeout =~ $re ]]; then

This is bashism. The portable way to do this seems to be do
tr -d [:digit:] on the string and checking if result is empty or use
grep.

> +		echo "only numbers as second argument"
> +		return 1
> +	fi
> +
> +	if [ -z "$TMPDIR" ]; then
> +		TMPDIR="/tmp"
> +	fi

I guess that better solution would be to move this check from the
tst_tmpdir() after the LTPROOT check in the test.sh so that we have only
one copy of it.

> +	local output=$(mktemp --tmpdir=$TMPDIR)
> +	sh -c "eval $command" >$output 2>&1 &

Do we really need to redirect the output to the file here? Shouldn't
just redirecting stderr to stdout work?

> +	local pid=$!
> +	timeout=$((timeout*1000000))
> +	while [ $timeout -gt 0 ]; do
> +		kill -s 0 $pid 2>/dev/null
> +		if [ $? -ne 0 ]; then
> +			break
> +		fi
> +		timeout=$((timeout - usleep_time))
> +		usleep $usleep_time

The usleep is bashism as well. What is not POSIX but tend to work is
sleep with a real number, i.e. sleep 0.1 but it does not seems to be
supported under BussyBox.

So we can either do the polling once a second or create our own
tst_usleep C source that calls usleep().

Ah and I've found that coreutils even includes timeout command that
can be used to fairly simplify the code.

Try:

timeout $timeout sh -c "eval $command"
echo $?

> +	done
> +
> +	local ret=0
> +	if [ $timeout -le 0 ]; then
> +		ret=128
> +		kill -9 $pid
> +
> +	fi
> +
> +	wait $pid
> +	ret=$((ret | $?))
> +
> +	cat $output
> +	rm -f $output
> +
> +	return $ret
> +}
> +
>  # Check that test name is set
>  if [ -z "$TCID" ]; then
>  	tst_brkm TBROK "TCID is not defined"
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
