From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2021 15:56:27 +0100
Subject: [LTP] [PATCH] netns_helper: Make iproute version check work
 correctly
In-Reply-To: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <YCKim8Pvg+ZTrHXI@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/containers/netns/netns_helper.h b/testcases/kernel/containers/netns/netns_helper.h
> index 8b87645..8337051 100644
> --- a/testcases/kernel/containers/netns/netns_helper.h
> +++ b/testcases/kernel/containers/netns/netns_helper.h
> @@ -37,6 +37,7 @@ static void check_iproute(unsigned int spe_ipver)
>  	FILE *ipf;
>  	int n;
>  	unsigned int ipver = 0;
> +	char ver;
>  
>  	ipf = popen("ip -V", "r");
>  	if (ipf == NULL)
> @@ -44,7 +45,14 @@ static void check_iproute(unsigned int spe_ipver)
>  				"Failed while opening pipe for iproute check");
>  
>  	n = fscanf(ipf, "ip utility, iproute2-ss%u", &ipver);
> +	pclose(ipf);
>  	if (n < 1) {
> +		ipf = popen("ip -V", "r");
> +		n = fscanf(ipf, "ip utility, iproute2-%s", &ver);
> +		if (n >= 1) {
> +			pclose(ipf);
> +			return;
> +		}

Can we please instead read the whole string after the dash (-), skip
the 'ss' prefix when present and then convert the string into an
itneger?

There is absolutely no reason to run the command twice.

>  static int dummy(void *arg)
> diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> index a5b77a0..bec43ac 100755
> --- a/testcases/kernel/containers/netns/netns_helper.sh
> +++ b/testcases/kernel/containers/netns/netns_helper.sh
> @@ -50,6 +50,15 @@ tst_check_iproute()
>  	local cur_ipver="$(ip -V)"
>  	local spe_ipver="$1"
>  
> +	echo $cur_ipver | grep "ip utility, iproute2-ss" > /dev/null
> +	ret1=$?
> +	echo $cur_ipver | grep "ip utility, iproute2-" > /dev/null
> +	ret2=$?
> +
> +	if [ $ret1 -ne 0 -a $ret2 -eq 0 ]; then
> +		return
> +	fi

How is this supposed to fix the problem?

This just skips the test if we haven't found one of the strings in the
version, right? Which is wrong anyway.

>  	cur_ipver=${cur_ipver##*s}

But the version here is still wrong if the original string haven't
contained the ss. We would end up with cur_ipver with iproute2-123456,
which will be used in the numerical comparsion.

>  	if [ -z "$cur_ipver" -o -z "$spe_ipver" ]; then
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
