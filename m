From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 17:44:53 +0200
Subject: [LTP] [PATCH V3 05/23] guard mallocopt() with __GLIBC__
In-Reply-To: <20160722042656.22346-5-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-5-raj.khem@gmail.com>
Message-ID: <20160726154452.GB5868@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#ifdef __GLIBC__
>  	if (never_mmap)
>  		mallopt(M_MMAP_MAX, 0);
> -
> +#else
> +	fprintf(stderr, "Platform does not support mallopt() API\n");

Shouldn't be this message printed only if (never_mmap) ?

> +#endif

-- 
Cyril Hrubis
chrubis@suse.cz
