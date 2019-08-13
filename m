From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Aug 2019 16:20:38 +0200
Subject: [LTP] [PATCH v2 1/3] syscalls/ftruncate: Rewrite ftruncate01
 and merge ftruncate02
In-Reply-To: <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1564395109-7165-3-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1564645349-10859-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20190813142038.GA23369@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor change, thanks.

> +	SAFE_FSTAT(fd, &stat_buf);
> +	file_length = stat_buf.st_size;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	if (file_length != trunc_len) {
> +		tst_brk(TBROK, "ftruncate() got incorrected size: %d",
> +			file_length);

Changed this to tst_res(TFAIL, ...) followed by return, since this is by
no means TBROK.

> +	}
>  
> -	TEST_PAUSE;
> +	SAFE_LSEEK(fd, offset, SEEK_SET);
> +	SAFE_READ(0, fd, buf, sizeof(buf));
>  
> -	tst_tmpdir();
> +	for (i = 0; i < TRUNC_LEN1; i++) {
> +		if (buf[i] != data)
> +			tst_brk(TBROK, "ftruncate() got incorrect data");

And here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
