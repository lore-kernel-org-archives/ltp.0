From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 12 Nov 2018 19:19:38 +0300
Subject: [LTP] [PATCH v3 1/2] net: Add tst_net_run helper
In-Reply-To: <20181108142409.4955-1-pvorel@suse.cz>
References: <20181108142409.4955-1-pvorel@suse.cz>
Message-ID: <d25987dd-f70b-224e-19cf-f887fbb342f0@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 08.11.2018 17:24, Petr Vorel wrote:
...  
> +# Run command on both lhost and rhost.
> +# tst_net_run [-s] [-l LPARAM] [-r RPARAM] CMD [ARG [ARG2]]
> +# LPARAM: parameter passed to $1 in lhost
> +# RPARAM: parameter passed to $1 in rhost
> +tst_net_run()
> +{
> +	local cmd
> +	local lparams
> +	local rparams
> +	local safe
> +
> +	local OPTIND
> +	while getopts l:r:s opt; do
> +		case "$opt" in
> +		l) lparams="$OPTARG" ;;
> +		r) rparams="$OPTARG" ;;
> +		s) safe="-s" ;;
> +		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
> +		esac
> +	done
> +	shift $((OPTIND - 1))
> +
> +	cmd="$1"
> +	shift
> +	cmd="$cmd $lparams $@"
> +	[ -n "$safe" ] && ROD $cmd || sh -c "$cmd"
                                      ^
                                  just $cmd?

> +
> +	cmd="$cmd $rparams $@"
               ^
So, now it is "$cmd $lparams $@", we need to store $1 in a separate variable.


> +	tst_rhost_run $safe -c "$cmd"
> +}
> +
