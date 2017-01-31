From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Jan 2017 11:07:45 +0100
Subject: [LTP] [PATCH 1/2] test_net.sh: add tst_set_sysctl()
In-Reply-To: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
References: <1485354100-24769-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20170131100744.GD29227@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# tst_set_sysctl NAME VALUE [safe]
> +# It can handle netns case when sysctl not namespaceified.
> +tst_set_sysctl()
> +{
> +	local name="$1"
> +	local value="$2"
> +	local safe=
> +	[ "$3" = "safe" ] && safe="-s" || safe=""

Uh, this syntax is confusing, besides isn't safe set to empty string
anyway?

> +	local add_opt=
> +	[ "$TST_USE_NETNS" = "yes" ] && add_opt="-e"
> +
> +	if [ "$safe" ]; then
> +		ROD sysctl -qw $name=$value
> +	else
> +		sysctl -qw $name=$value
> +	fi
> +
> +	tst_rhost_run $safe -c "sysctl -qw $add_opt $name=$value"
> +}

And maybe the function name should say that we are changing the
parameter both on local and remote machine. Maybe just rename the
function to tst_set_sysctls().

>  # Management Link
>  [ -z "$RHOST" ] && TST_USE_NETNS="yes"
>  export RHOST="$RHOST"
> -- 
> 1.7.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
