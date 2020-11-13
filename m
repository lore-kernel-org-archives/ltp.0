From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Nov 2020 16:04:45 +0100
Subject: [LTP] [PATCH v2] Convert dup03 to new API and clean up
In-Reply-To: <20201113084030.19317-1-radoslav.kolev@suse.com>
References: <20201113084030.19317-1-radoslav.kolev@suse.com>
Message-ID: <20201113150445.GA16315@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	fd = malloc(maxfds * sizeof(int));
> +	fd = SAFE_MALLOC(maxfds * sizeof(int));
>  	if (fd == NULL)
> -		tst_brkm(TBROK | TERRNO, NULL, "malloc failed");
> -	fd[0] = -1;
> +		tst_brk(TBROK | TERRNO, "malloc failed");

I've removed the fd == NULL check, since that cannot happen since you
call SAFE_MALLOC() now and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
