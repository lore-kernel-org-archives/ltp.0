From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Feb 2021 14:38:30 +0100
Subject: [LTP] [PATCH] netns_helper: Make iproute version check work
 correctly
In-Reply-To: <YCOUXtwBk0ZPjDL3@pevik>
References: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <YCOUXtwBk0ZPjDL3@pevik>
Message-ID: <YCPh1qzZU51C0HY8@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhu,

...
> FYI my shell version.

> Kind regards,
> Petr

> --- testcases/kernel/containers/netns/netns_helper.sh
> +++ testcases/kernel/containers/netns/netns_helper.sh
> @@ -47,16 +47,21 @@ IFCONF_IN6_ARG=

>  tst_check_iproute()
>  {
> -	local cur_ipver="$(ip -V)"
> -	local spe_ipver="$1"
> +	local current_ver="$(ip -V)"
> +	local expected_ver="111010"

> -	cur_ipver=${cur_ipver##*s}
> +	current_ver=${current_ver##*s}

> -	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
> +	if [ -z "$current_ver" -o -z "$expected_ver" ]; then
I'm sorry, this was supposed to be only this:
    if [ -z "$current_ver" ]; then
($expected_ver is set few lines above).

Kind regards,
Petr

>  		tst_brk TBROK "failed to obtain valid iproute version"
>  	fi

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

Kind regards,
Petr
