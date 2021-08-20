From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 20 Aug 2021 12:43:40 +0200
Subject: [LTP] [PATCH 2/3] network/tst_net.sh: fix busybox/sysctl in
 tst_set_sysctl()
In-Reply-To: <20210804120446.32835-2-aleksei.kodanev@bell-sw.com>
References: <20210804120446.32835-1-aleksei.kodanev@bell-sw.com>
 <20210804120446.32835-2-aleksei.kodanev@bell-sw.com>
Message-ID: <YR+HXE01R1RE8TTH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> busybox/sysctl expects -e option to be set before 'name=value'.
> This can easily be fixed by splitting the string in tst_set_sysctl(),
> so that 'rparam' with '-e' option is added in between.
Good catch.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> index 511fb7eb1..bb30c13ec 100644
> --- a/testcases/lib/tst_net.sh
> +++ b/testcases/lib/tst_net.sh
> @@ -918,7 +918,7 @@ tst_set_sysctl()
>  	local rparam=
>  	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"

> -	tst_net_run $safe $rparam "sysctl -q -w $name=$value"
> +	tst_net_run $safe $rparam "sysctl -q -w" "$name=$value"

I wonder if it were a bit clearer if we moves all params to second arg:
	tst_net_run $safe "sysctl" "$name=$value -q -w"

Kind regards,
Petr
