From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Feb 2017 16:33:52 +0100
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
Message-ID: <20170207153352.GB3595@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +			} else {
>  				tst_resm(TPASS, "getrandom returned %ld",
>  						TEST_RETURN);
> +				tmp = 0;
> +				for (j = 0; j < TEST_RETURN; j++)
> +					tmp |= buf[j];
> +				if (tmp == 0)
> +					tst_resm(TWARN, "all bytes from random"
> +						" buffer are zero?");

This wouldn't for instance when the random output is filled with
non-zero constant bytes...

What about just fixing the max value to something as:

max = 3 + nb * 0.2;

The constat part should handle cases with small buffer and a few
repeating characters while for larger buffer it's neglectible.

-- 
Cyril Hrubis
chrubis@suse.cz
