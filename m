From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 2 Sep 2021 10:18:36 +0200
Subject: [LTP] [PATCH v5 3/3] controllers/cpuacct: fix rmdir failures on
 early test abort
In-Reply-To: <20210901151655.95760-3-krzysztof.kozlowski@canonical.com>
References: <20210901151655.95760-1-krzysztof.kozlowski@canonical.com>
 <20210901151655.95760-3-krzysztof.kozlowski@canonical.com>
Message-ID: <YTCI3O7Et+VvYJfc@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Krzysztof,

...
> -	if [ -d "$testpath/subgroup_1" ]; then
> -		rmdir $testpath/subgroup_*
> +	if [ "$testpath" ]; then
> +		if [ -d "$testpath/subgroup_1" ]; then
> +			rmdir $testpath/subgroup_*
> +		fi
> +		rmdir $testpath
>  	fi

> -	rmdir $testpath
> -

LGTM, but how about use `rm -rf' instead?

e.g.

if [ "$testpath" ]; then
	rm -rf $testpath
fi

That could simplify checks. Or is it needed to use `rmdir' to make sure there is
no content in the directory? I suppose check like this is needed in cleanup,
thus no problem to use `rm -rf'.

Kind regards,
Petr
