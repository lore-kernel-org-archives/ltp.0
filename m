From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 May 2016 16:16:54 +0200
Subject: [LTP] [PATCH 1/4] memcg_process_stress: cleanup
In-Reply-To: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160511141653.GF24701@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -void sigusr_handler(int __attribute__ ((unused)) signo)
> +static void sigusr_handler(int __attribute__ ((unused)) signo)
>  {
>  	int i;
>  	int pagesize;
>  
> -	pagesize = getpagesize();
> +	pagesize = sysconf(_SC_PAGE_SIZE);

Well sysconf() unlinek getpagesize() can fail and even if it's unlikely
with _SC_PAGE_SIZE this change may generate warnings in static analysis
of the code.

I would not bother and left the code with getpagesize() here.


Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
