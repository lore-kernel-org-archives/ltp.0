From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Jul 2019 13:44:13 +0200
Subject: [LTP] [PATCH 2/3] zram/zram_lib.sh: fix variable name and
 algorithm retrieval
In-Reply-To: <20190703102303.32166-3-po-hsu.lin@canonical.com>
References: <20190703102303.32166-1-po-hsu.lin@canonical.com>
 <20190703102303.32166-3-po-hsu.lin@canonical.com>
Message-ID: <20190709114412.GC5888@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	tst_resm TINFO "test that we can set compression algorithm"
>  
> -	local algs="$(cat /sys/block/zram0/comp_algorithm)"
> -	tst_resm TINFO "supported algs: $algs"
> +	local zram_algs="$(sed 's/[][]//g' /sys/block/zram0/comp_algorithm)"

This has still the same name as the variable set in the zram01.sh.

There are two options what to do here, either we remove zram_algs from
the zram01.sh or set the algorithms to the ones defined in the zram01.sh
test at the end of this function.

> +	tst_resm TINFO "supported algs: $zram_algs"
>  	local i=0
>  	for alg in $zram_algs; do
>  		local sys_path="/sys/block/zram${i}/comp_algorithm"
> -- 
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
