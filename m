From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 27 Jun 2018 13:47:56 +0300
Subject: [LTP] [PATCH v2 3/8] tst_net.sh: Harden against multiple loading
In-Reply-To: <20180622151047.13002-4-pvorel@suse.cz>
References: <20180622151047.13002-1-pvorel@suse.cz>
 <20180622151047.13002-4-pvorel@suse.cz>
Message-ID: <56463a10-54b9-2287-6a45-5ecef1f9da24@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 22.06.2018 18:10, Petr Vorel wrote:
> Some tests (macsec0{1,2}.sh) load tst_net.sh twice via loading from
> ipsec_lib.sh and virt_lib.sh.
> That brings duplicity in some variables (TST_OPTS) and create infinite
> loop, as tst_net_setup calls itself.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_net.sh | 42 +++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index aad701952..ac61dfab8 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -19,14 +19,6 @@
>  # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>  #
>  
> -TST_OPTS="6$TST_OPTS"
> -TST_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
> -TST_PARSE_ARGS="tst_net_parse_args"
> -TST_USAGE_CALLER="$TST_USAGE"
> -TST_USAGE="tst_net_usage"
> -TST_SETUP_CALLER="$TST_SETUP"
> -TST_SETUP="tst_net_setup"
> -
>  # Blank for an IPV4 test; 6 for an IPV6 test.
>  TST_IPV6=${TST_IPV6:-}
>  TST_IPVER=${TST_IPV6:-4}
> @@ -73,14 +65,6 @@ tst_net_setup()
>  	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
>  }
>  
> -if [ -z "$TST_LIB_LOADED" ]; then
> -	[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> -fi
> -
> -if [ -n "$TST_USE_LEGACY_API" ]; then
> -	tst_net_read_opts "$@"
> -fi
> -
>  # old vs. new API compatibility layer
>  tst_res_()
>  {
> @@ -659,6 +643,32 @@ tst_cleanup_rhost()
>  	tst_rhost_run -c "rm -rf $TST_TMPDIR"
>  }
>  
> +if [ -z "$TST_LIB_LOADED" ]; then
> +	TST_OPTS="6$TST_OPTS"
> +	TST_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
> +	TST_PARSE_ARGS="tst_net_parse_args"
> +	TST_USAGE_CALLER="$TST_USAGE"
> +	TST_USAGE="tst_net_usage"
> +	TST_SETUP_CALLER="$TST_SETUP"
> +	TST_SETUP="tst_net_setup"
> +
> +	if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
> +		unset TST_PARSE_ARGS_CALLER
> +	fi
> +	if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
> +		unset TST_USAGE_CALLER
> +	fi
> +	if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
> +		unset TST_PARSE_ARGS_CALLER
> +	fi
> +
> +	[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
> +fi
> +

Hi Petr,

Shouldn't we need a similar check as in the patch for tst_test.sh, instead of this?
For example, with TST_LIB_NET_LOADED...

Thanks,
Alexey


> +if [ -n "$TST_USE_LEGACY_API" ]; then
> +	tst_net_read_opts "$@"
> +fi
> +
>  # Management Link
>  [ -z "$RHOST" ] && TST_USE_NETNS="yes"
>  export RHOST="$RHOST"
> 

