From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 May 2021 13:42:39 +0200
Subject: [LTP] [PATCH 1/1] netns_helper.sh: Fix parsing recent iproute2
 versions
In-Reply-To: <20210512103052.9646-1-pvorel@suse.cz>
References: <20210512103052.9646-1-pvorel@suse.cz>
Message-ID: <YJu/L3HssZY14vQa@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index a5b77a0aa..4dac0e306 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -47,16 +47,21 @@ IFCONF_IN6_ARG=
>  
>  tst_check_iproute()
>  {
> -	local cur_ipver="$(ip -V)"
> -	local spe_ipver="$1"
> +	local current_ver="$(ip -V)"
> +	local expected_ver="111010"

So if I'm reading this right, this is 2010 again. I wonder if we can
just remove this check as well.

I guess that the most safe variant at the moment would be pushing this
patch, then dropping the check completely after the release.

> -	cur_ipver=${cur_ipver##*s}
> +	current_ver=${current_ver##*s}
>  
> -	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
> +	if [ -z "$current_ver" ]; then
>  		tst_brk TBROK "failed to obtain valid iproute version"
>  	fi
>  
> -	if [ $cur_ipver -lt $spe_ipver ]; then
> +	# new version scheme since v5.7.0-77-gb687d1067169
> +	if echo "$current_ver" | grep -q 'iproute2-v\?[0-9]\+\.'; then
> +		return
> +	fi
> +
> +	if [ $current_ver -lt $expected_ver ]; then
>  		tst_brk TCONF "too old iproute version"
>  	fi
>  }
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
