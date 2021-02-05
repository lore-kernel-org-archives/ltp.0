From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 5 Feb 2021 07:59:53 +0100
Subject: [LTP] [PATCH 1/3] lib/tst_net.sh: print all netstress results
 in tst_netload()
In-Reply-To: <20210202133454.59224-2-alexey.kodanev@oracle.com>
References: <20210202133454.59224-1-alexey.kodanev@oracle.com>
 <20210202133454.59224-2-alexey.kodanev@oracle.com>
Message-ID: <YBzs6V68xkamzfcx@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> -	res=$((res / $passed))
> -	echo "$res" > $rfile
> +	local mean res_sum
r should be also local.
> +	for r in $results; do
> +		res_sum="$((res_sum + r))"
> +	done
> +	mean=$((res_sum / passed))
> +	echo "$mean" > $rfile

> -	tst_res_ TPASS "netstress passed, mean time '$res' ms"
> +	tst_res_ TPASS "netstress passed, mean time $mean ms, data:$results"

Kind regards,
Petr
