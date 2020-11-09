From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 9 Nov 2020 14:09:24 +0300
Subject: [LTP] [PATCH v2] tcp_cmds/ping/ping02: Make it compatible with
 Busybox
In-Reply-To: <20201106143605.27230-1-kory.maincent@bootlin.com>
References: <20201106143605.27230-1-kory.maincent@bootlin.com>
Message-ID: <5de346c3-ccd6-743e-c83c-e16c592c7ac5@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06.11.2020 17:36, Kory Maincent wrote:
> The ping from busybox does not have -f parameter, use -i parameter instead.
> BusyBox does not accept pattern longer than 2 bytes.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  testcases/network/tcp_cmds/ping/ping02.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
> index e0a63c5f6..2784c8160 100755
> --- a/testcases/network/tcp_cmds/ping/ping02.sh
> +++ b/testcases/network/tcp_cmds/ping/ping02.sh
> @@ -20,7 +20,7 @@ do_setup()
>  
>  do_test()
>  {
> -	local pat="000102030405060708090a0b0c0d0e0f"
> +	local pat="aa"
>  

Hi Kory,

I think we should replace the options only if ping doesn't support
'-f', i.e. something like in the first version and this patch:

local ping_opts="-f -p 000102030405060708090a0b0c0d0e0f"
local ipaddr=$(tst_ipaddr rhost)
local s

$PING -h 2>&1 | grep -q '[-]f' || ping_opts="-i 0.01 -p aa"

for s in $PACKETSIZES; do
	EXPECT_PASS $PING -c $COUNT -s $s $ipaddr $ping_opts \>/dev/null
done


>  	tst_res TINFO "flood $PING: ICMP packets filled with pattern '$pat'"
>  
> @@ -28,7 +28,7 @@ do_test()
>  	local s
>  
>  	for s in $PACKETSIZES; do
> -		EXPECT_PASS $PING -c $COUNT -f -s $s $ipaddr -p "$pat" \>/dev/null
> +		EXPECT_PASS $PING -c $COUNT -i 0.001 -s $s $ipaddr -p "$pat" \>/dev/null
>  	done
>  }
>  
> 

