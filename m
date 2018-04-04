From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 4 Apr 2018 16:37:17 +0300
Subject: [LTP] [RFC PATCH v3 1/5] tst_net.sh: Support both old and new
 shell APIs + rename it
In-Reply-To: <20180403154717.22491-2-pvorel@suse.cz>
References: <20180403154717.22491-1-pvorel@suse.cz>
 <20180403154717.22491-2-pvorel@suse.cz>
Message-ID: <9096090e-2c84-5648-22c1-14aa67b5938f@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03.04.2018 18:47, Petr Vorel wrote:
> The new name states that library supports new API.
> 
> This is temporary solution, after migrating all tests to new SHELL API
> the compatibility layer and old SHELL API support should be removed.
...
> -[ -z "$TST_LIB_LOADED" ] && . test.sh
> +TST_OPTS=":6"
> +TST_PARSE_ARGS=parse_args
> +TST_USAGE=usage
> +
> +# Blank for an IPV4 test; 6 for an IPV6 test.
> +TST_IPV6=
> +
> +parse_args()
> +{
> +	case $1 in
> +	6) TST_IPV6=6;;
> +	esac
> +}
> +
> +tst_read_opts()
> +{
> +	local OPTIND
> +	while getopts "$TST_OPTS" opt; do
> +		$TST_PARSE_ARGS "$opt"
> +	done
> +}
> +
> +usage()
> +{
> +	cat << EOF
> +usage: $0 [-6]
> +
> +OPTIONS
> +-6     Use IPv6
> +EOF
> +}

Could we rename it to tst_net_usage() or similar (for parse_arg()
as well) since it is a library, and use the indent with echo, that
way it would be more readable.

Otherwise the patch looks good!
