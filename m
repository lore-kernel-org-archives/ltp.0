From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2017 17:32:20 +0100
Subject: [LTP] [PATCH v2] diotest6: test readv/writev not read/write
In-Reply-To: <20170315162102.18289-1-eguan@redhat.com>
References: <20170315162102.18289-1-eguan@redhat.com>
Message-ID: <20170315163220.GA22242@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	int i, ret = -1;
> +	struct iovec *iov_r, *iov_w, *iovp;
> +
> +	/* allocate read/write io vectors */
> +	iov_r = calloc(nvector, sizeof(*iov_r));
> +	iov_w = calloc(nvector, sizeof(*iov_w));
> +	if (!iov_r || !iov_w) {
> +		tst_resm(TBROK | TERRNO, "calloc failed for iovector array");
> +		goto err;

Now this would segfault the test if we jump to the err: label. You have
to create two of these (err0 and err1) since we have to jump after the
for loops that free the iov_base.

>  	}
>  
> -	/* Allocate for buffers and data pointers */
> -	seekoff = offset + bufsize * childnum;
> +	/* allocate buffers and setup read/write io vectors */
> +	for (i = 0, iovp = iov_r; i < nvector; i++) {
> +		iovp[i].iov_base = valloc(bufsize);
> +		if (!iovp[i].iov_base) {
> +			tst_resm(TBROK | TERRNO, "valloc error iov_r[%d]", i);
> +			goto err;
> +		}
> +		iovp[i].iov_len = bufsize;
> +	}

What is the point of using iovp instead of iov_r here?

> +	for (i = 0, iovp = iov_w; i < nvector; i++) {
> +		iovp[i].iov_base = valloc(bufsize);
> +		if (!iovp[i].iov_base) {
> +			tst_resm(TBROK | TERRNO, "valloc error iov_w[%d]", i);
> +			goto err;
> +		}
> +		iovp[i].iov_len = bufsize;
> +	}

Here as well.

>  	/* seek, write, read and verify */
> +	seekoff = offset + bufsize * childnum * nvector;
>  	for (i = 0; i < iter; i++) {
> -		fillbuf(buf1, bufsize, childnum+i);
> +		vfillbuf(iov_w, nvector, childnum+i);
>  
>  		if (lseek(fd_w, seekoff, SEEK_SET) < 0) {
>  			tst_resm(TFAIL, "lseek before write failed: %s",
>  				 strerror(errno));
> -			return (-1);
> +			goto err;
>  		}
> -		if (write(fd_w, buf1, bufsize) < bufsize) {
> -			tst_resm(TFAIL, "write failed: %s", strerror(errno));
> -			return (-1);
> +		if (writev(fd_w, iov_w, nvector) < (bufsize * nvector)) {
> +			tst_resm(TFAIL, "writev failed: %s", strerror(errno));
> +			goto err;
>  		}

It would be better if we print the return value from writev() in the
tst_resm() message here as well. And we should use TERRNO instead of
strerror().

>  		if (action == READ_DIRECT) {
>  			/* Make sure data is on to disk before read */
>  			if (fsync(fd_w) < 0) {
>  				tst_resm(TFAIL, "fsync failed: %s",
>  					 strerror(errno));
> -				return (-1);
> +				goto err;
>  			}
>  		}
>  		if (lseek(fd_r, seekoff, SEEK_SET) < 0) {
>  			tst_resm(TFAIL, "lseek before read failed: %s",
>  				 strerror(errno));
> -			return (-1);
> +			goto err;
>  		}
> -		int ret;
> -		if ((ret = read(fd_r, buf2, bufsize)) < bufsize) {
> -			tst_resm(TFAIL, "read failed: %s", strerror(errno));
> -			return (-1);
> +		if (readv(fd_r, iov_r, nvector) < (bufsize * nvector)) {
> +			tst_resm(TFAIL, "readv failed: %s", strerror(errno));
> +			goto err;
>  		}
> -		if (bufcmp(buf1, buf2, bufsize) != 0) {
> +		if (vbufcmp(iov_w, iov_r, nvector) != 0) {
>  			tst_resm(TFAIL, "comparsion failed. Child=%d offset=%d",
>  				 childnum, (int)seekoff);
> -			return (-1);
> +			goto err;
>  		}
>  	}
> -	return 0;
> +	ret = 0;
> +
> +err:
> +	for (i = 0, iovp = iov_r; i < nvector; iovp++, i++)
> +		free(iovp->iov_base);
> +	for (i = 0, iovp = iov_w; i < nvector; iovp++, i++)
> +		free(iovp->iov_base);

Here as well, why do we use the iopv pointer here, when we can simply
write:

	for (i = 0; i < nvector; i++)
		free(iov_r[i].iov_base);

> +	free(iov_r);
> +	free(iov_w);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.9.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
