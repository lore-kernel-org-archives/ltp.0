From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Feb 2016 13:31:24 +0100
Subject: [LTP] [PATCH v2] Clean up hugemmap02 testcase
In-Reply-To: <1452659578-3706-1-git-send-email-shuang.qiu@oracle.com>
References: <1452659578-3706-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <20160210123124.GB10106@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #if __WORDSIZE == 64		/* 64-bit process */
> -		if (addr2 == MAP_FAILED) {
> +		if (addr2 == MAP_FAILED)
>  			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
>  				 " with %s (64-bit)", TEMPFILE);
> -			close(fildes);
> -			continue;
> -		} else {
> +		else {
>  			tst_resm(TPASS, "huge mmap succeeded (64-bit)");
>  		}
>  #else /* 32-bit process */
>  		if (addr2 == MAP_FAILED)
>  			tst_resm(TFAIL | TERRNO, "huge mmap failed unexpectedly"
>  				 " with %s (32-bit)", TEMPFILE);
> -		else if (addr2 > 0) {
> +		else if (addr2 > 0)
>  			tst_resm(TCONF,
>  				 "huge mmap failed to test the scenario");
> -			close(fildes);
> -			continue;
> -		} else if (addr == 0)
> +		else if (addr == 0)
>  			tst_resm(TPASS, "huge mmap succeeded (32-bit)");

The LKML coding style says that we should add curly braces to both else
branches if they are around one of them. Or if the function call after
if spans across more lines. So please do not remove them.

Otherwise the change looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
