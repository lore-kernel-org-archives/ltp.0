From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Dec 2016 14:23:30 +0300
Subject: [LTP] [PATCH] network: fix telnet test for running on single
 machine
In-Reply-To: <20161219154433.19861-1-pvorel@suse.cz>
References: <20161219154433.19861-1-pvorel@suse.cz>
Message-ID: <e6ef2253-fff1-2114-1def-d88cf82df809@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 12/19/2016 06:44 PM, Petr Vorel wrote:
> Since 5f8ca6cf0 it's possible to run network test on single machine
> => don't require setting RHOST in this case.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/network/tcp_cmds/telnet/telnet01 | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
> index a1609f0f6..633fb89dd 100755
> --- a/testcases/network/tcp_cmds/telnet/telnet01
> +++ b/testcases/network/tcp_cmds/telnet/telnet01
> @@ -34,8 +34,13 @@ setup()
>   		tst_brkm TCONF "Please set PASSWD for $RUSER."
>   	fi
>   
> -	if [ -z $RHOST ]; then
> -		tst_brkm TCONF "Please set RHOST."
> +	if [ -n "$TST_USE_NETNS" ]; then
> +		HOST=localhost
> +	else
> +		if [ -z $RHOST ]; then
> +			tst_brkm TCONF "Please set RHOST."
> +		fi
> +		HOST=$RHOST
>   	fi
>   
>   	if [ -z $LOOPCOUNT ]; then
> @@ -58,7 +63,7 @@ telnet_test()
>   	tst_resm TINFO "login with telnet($i/$LOOPCOUNT)"
>   
>   	expect -c "
> -		spawn telnet $RHOST
> +		spawn telnet $HOST

Hmm, instead of $RHOST the test should have used $(tst_ipaddr rhost).
In general, RHOST variable is for management link, but it can be set to the
same IP just the same (when there is only one link between hosts).

Moreover,in case we are using $(tst_ipaddr rhost) here we can run this
test over IPv6 byadding '-6' option.

But if we replaced $RHOST with $(tst_ipaddr rhost) we still wouldn't connect
with telnetto ltp_ns netns as there is no corresponding listening TCP 
socket.

It seems there are several solutions:
1. we could do something similar to ssh/dns/http tests,
    i.e. start the client side from remote host;
2. add $(tst_ipaddr rservice), and in case of netns, it will return 
127.0.0.1/::1 addresses;
3. start those services inside ltp_ns;
4. other suggestions?

Thanks,
Alexey

>   
>   		expect -re \"login:\"
>   		send \"$RUSER\r\"
> @@ -71,15 +76,15 @@ telnet_test()
>   				exit 1
>   			} \"$RUSER@\" {
>   				send \"LC_ALL=C ls -l /etc/hosts | \\
> -				       wc -w > $RUSER.$RHOST\rexit\r\";
> +				       wc -w > $RUSER.$HOST\rexit\r\";
>   				exp_continue}
>   		}
>   
>   	" > /dev/null || return 1
>   
>   	tst_resm TINFO "checking telnet status($i/$LOOPCOUNT)"
> -	tst_rhost_run -u $RUSER -c "grep -q 9 $RUSER.$RHOST" || return 1
> -	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$RHOST"
> +	tst_rhost_run -u $RUSER -c "grep -q 9 $RUSER.$HOST" || return 1
> +	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$HOST"
>   }
>   
>   setup

