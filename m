From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Jan 2021 13:43:23 +0100
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin
 to 64MB
In-Reply-To: <20210118163240.29558-1-mdoucha@suse.cz>
References: <20210118163240.29558-1-mdoucha@suse.cz>
Message-ID: <YAbT62ecN/lq12cT@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	SAFE_SYSINFO(&info);
> -	safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
> +	safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 64 * 1024 * 1024);
> +	safety /= info.mem_unit;

I guess that this is safe enough for the release, since it will only
increase the safety margin.

Naresh can you please test this patch ASAP?

-- 
Cyril Hrubis
chrubis@suse.cz
