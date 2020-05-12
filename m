From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 12 May 2020 20:07:07 +0300
Subject: [LTP] [PATCH 1/1] rpc: Warn when tests aren't compiled
In-Reply-To: <20200512152701.23625-1-pvorel@suse.cz>
References: <20200512152701.23625-1-pvorel@suse.cz>
Message-ID: <d011a55b-a5b5-049f-9037-235d1f18cf1b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12.05.2020 18:27, Petr Vorel wrote:
> Without this test failure was wrongly reported:
> rpc_test 1 TFAIL: tirpc_rpcb_getaddr 10.0.0.2 536875000 failed unexpectedly
> 

Hi Petr,

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/network/rpc/rpc-tirpc/rpc_test.sh | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> index 30cfd2564..fd72e6be4 100755
> --- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> +++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
> @@ -35,10 +35,12 @@ EOF
>  
>  rpc_parse_args()
>  {
> +	local err="LTP compiled without TI-RPC support"
> +
>  	case "$1" in
> -		c) CLIENT="$OPTARG" ;;
> -		e) CLIENT_EXTRA_OPTS="$OPTARG" ;;
> -		s) SERVER="$OPTARG" ;;
> +	c) CLIENT="$OPTARG"; tst_cmd_available $OPTARG || tst_brk TCONF $err;;
> +	e) CLIENT_EXTRA_OPTS="$OPTARG";;
> +	s) SERVER="$OPTARG"; tst_cmd_available $OPTARG || tst_brk TCONF $err;;
>  	esac

Perhaps this one, to write about the missing command:
tst_require_cmds $CLIENT $SERVER

or just $CLIENT because it's always used, and if the hint is needed:
tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
