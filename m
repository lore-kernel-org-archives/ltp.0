From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Nov 2019 16:29:02 +0100
Subject: [LTP] [PATCH v2 1/1] Fix compression ratio calculation in zram01
In-Reply-To: <20191105090339.6522-2-mdoucha@suse.cz>
References: <20191105082322.GA16218@dell5510>
 <20191105090339.6522-1-mdoucha@suse.cz>
 <20191105090339.6522-2-mdoucha@suse.cz>
Message-ID: <20191108152902.GA8931@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		if [ ! -f "/sys/block/zram$i/mm_stat" ]; then
> +			if [ $i -eq 0 ]; then
> +				tst_resm TCONF "zram compression ratio test requires zram mm_stat sysfs file"
> +			fi
>  
> -	tst_resm TINFO "zram used ${used_mem}M, zram disk sizes ${total_size}M"
> +			continue
> +		fi
>  
> -	local v=$((100 * $total_size / $used_mem))
> +		local compr_size=`cat "/sys/block/zram$i/mm_stat" | awk '{print $2}'`

Why not just:

	awk '{print $2}' /sys/block/zram$i/mm_stat

Other than this it looks good. Also no need to send v3, I can fix this
when applying.


-- 
Cyril Hrubis
chrubis@suse.cz
