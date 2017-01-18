From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jan 2017 15:24:05 +0100
Subject: [LTP] [PATCH v2 2/3] syscalls/getcwd03.c: cleanup && convert to
	new API
In-Reply-To: <1484719408-28782-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170117134335.GA28074@rei.lan>
 <1484719408-28782-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1484719408-28782-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170118142404.GD29948@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	errno = 0;
> +	res2 = getcwd(NULL, 0);
> +	TEST_ERRNO = errno;

I've simplified this part not to use the TEST_ERRNO.

> +	if (!res2) {
> +		tst_res(TFAIL | TTERRNO, "getcwd() failed to get "
> +			"working directory of a symbolic link");
> +		goto end;
> +	}
> +

And also removed the test cleanup() since the temporary directory is
removed recursively at the test end.

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
