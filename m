From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Dec 2018 14:01:07 +0100
Subject: [LTP] [PATCH v5] syscalls/readahead02: test readahead using
 posix_fadvise()
In-Reply-To: <20181204153528.26176-1-amir73il@gmail.com>
References: <20181204153528.26176-1-amir73il@gmail.com>
Message-ID: <20181218130107.GB18871@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Sorry for the delay.

...

> -	if (ret == EINVAL &&
> -	    (!tc->use_overlay || !readahead_supported)) {
> -		readahead_supported = 0;
> -		tst_res(TCONF, "readahead not supported on %s",
> -			tst_device->fs_type);
> -		return;
> +	if (ret == EINVAL) {
> +		if (tc->use_fadvise &&
> +		    (!tc->use_overlay || !fadvise_supported)) {
> +			fadvise_supported = 0;
> +			tst_res(TCONF, "CONFIG_ADVISE_SYSCALLS not configured "
> +				"in kernel?");
> +			return;
> +		} else if (!tc->use_overlay || !readahead_supported) {

I got rid of the else block here, since we do return at the end of the
if block before it anyways and pushed, thanks.

> +			readahead_supported = 0;
> +			tst_res(TCONF, "readahead not supported on %s",
> +				tst_device->fs_type);
> +			return;
> +		}
>  	}

-- 
Cyril Hrubis
chrubis@suse.cz
