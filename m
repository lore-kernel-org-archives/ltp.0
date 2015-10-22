From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Oct 2015 15:16:00 +0200
Subject: [LTP] [PATCH] syscalls/mallopt: Does not work correctly?
In-Reply-To: <330BE2030BD7834286495D8B7FCF1FB71C9A4D60@mbx01.itr.canon-is.co.jp>
References: <330BE2030BD7834286495D8B7FCF1FB71C99B4FB@mbx01.itr.canon-is.co.jp>
 <20151001112940.GF8256@rei.suse.cz>
 <330BE2030BD7834286495D8B7FCF1FB71C9A4D60@mbx01.itr.canon-is.co.jp>
Message-ID: <20151022131600.GC7192@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've wrote commit description for the change, add your signed-of-by,
did small changes (see below) and pushed, thanks.

> -	free(buf);
> +	if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
> +		tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", MAX_FAST_SIZE);
> +	else
> +		tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", MAX_FAST_SIZE);

I've added cast to (int) for the MAX_FAST_SIZE constant here to supress
warnings.


> +	if ((buf = malloc(1024)) == NULL)
> +		tst_resm(TFAIL, "malloc(1024) failed");
> +	else {
> +		tst_resm(TPASS, "malloc(1024) succeeded");
> +		free(buf);
> +	}

LKML coding style preffers curly braces around both blocks if they are
needed around one of them. So I've added them before I pushed the patch.

FYI, you can use checkpatch.pl (distributed with Linux kernel sources)
to check patches before submission.

-- 
Cyril Hrubis
chrubis@suse.cz
