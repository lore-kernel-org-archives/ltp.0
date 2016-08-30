From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 Aug 2016 14:21:20 +0200
Subject: [LTP] [PATCH] readahead02: fix read_ahead_kb file not found
In-Reply-To: <1472296459-31507-1-git-send-email-naresh.kamboju@linaro.org>
References: <1472296459-31507-1-git-send-email-naresh.kamboju@linaro.org>
Message-ID: <20160830122119.GA23854@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -193,7 +193,7 @@ static long get_device_readahead(const char *fname)
>  	if (stat(fname, &st) == -1)
>  		tst_brkm(TBROK | TERRNO, cleanup, "stat");
>  	snprintf(buf, sizeof(buf), "/sys/dev/block/%d:%d/queue/read_ahead_kb",
> -		 major(st.st_dev), minor(st.st_dev));
> +		 major(st.st_dev), minor(st.st_dev) & ~31);

So we clear lower five bits of the minor number here. Why exactly that amount?

Shouldn't we just pass zero as a minor number there anyway?

>  	SAFE_FILE_SCANF(cleanup, buf, "%ld", &ra_kb);
>  
>  	return ra_kb * 1024;
> -- 
> 1.9.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
