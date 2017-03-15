From: Eryu Guan <eguan@redhat.com>
Date: Wed, 15 Mar 2017 18:48:32 +0800
Subject: [LTP] [PATCH 2/3] diotest6: test readv/writev not read/write
In-Reply-To: <20170315103112.GB17618@rei.lan>
References: <20170302133323.5262-1-eguan@redhat.com>
 <20170302133323.5262-2-eguan@redhat.com>
 <20170315103112.GB17618@rei.lan>
Message-ID: <20170315104832.GP14226@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 15, 2017 at 11:31:12AM +0100, Cyril Hrubis wrote:
> Hi!
> > -	if (!buf1 || !buf2) {
> > -		tst_resm(TBROK | TERRNO, "valloc() failed");
> > -		free(buf1);
> > -		free(buf2);
> > +	/* allocate read/write io vectors */
> > +	iov_r = calloc(nvector, sizeof(*iov_r));
> > +	if (!iov_r) {
> > +		tst_resm(TBROK | TERRNO, "calloc failed for iov_r array");
> > +		return -1;
> > +	}
> > +	iov_w = calloc(nvector, sizeof(*iov_w));
> > +	if (!iov_w) {
> > +		tst_resm(TBROK | TERRNO, "calloc failed for iov_w array");
> > +		free(iov_r);
> >  		return -1;
> >  	}
> 
> Doing free(NULL) is no-op. So we can simplify this code by allocating
> both arrays at once and then checking if !iow_r || !iow_w just like we
> did with the normal buffers.

OK.

> 
> > -	/* Allocate for buffers and data pointers */
> > -	seekoff = offset + bufsize * childnum;
> > +	/* allocate buffers and setup read/write io vectors */
> > +	for (i = 0, iovp = iov_r; i < nvector; iovp++, i++) {
> > +		iovp->iov_base = valloc(bufsize);
> > +		if (!iovp->iov_base) {
> > +			tst_resm(TBROK | TERRNO, "valloc error iov_r[%d]", i);
> > +			goto free_out;
> > +		}
> > +		iovp->iov_len = bufsize;
> > +	}
> 
> Uh, why do we increment both iovp and i here?
> 
> When we can simply do:
> 
> for (i = 0; i < nvector; i++) {
> 	iovp[i].iov_base = valloc(bufsize);
> 	...
> }

You're right, no need to increase both iovp and i. I "copied" this
pattern from diotest5.c, and "i" isn't even used in similar loop there.

> 
> > +	for (i = 0, iovp = iov_w; i < nvector; iovp++, i++) {
> > +		iovp->iov_base = valloc(bufsize);
> > +		if (!iovp->iov_base) {
> > +			tst_resm(TBROK | TERRNO, "valloc error iov_w[%d]", i);
> > +			goto free_out;
> > +		}
> > +		iovp->iov_len = bufsize;
> > +	}
> 
> Here as well.
> 
> >  	/* seek, write, read and verify */
> > +	seekoff = offset + bufsize * childnum * nvector;
> >  	for (i = 0; i < iter; i++) {
> > -		fillbuf(buf1, bufsize, childnum+i);
> > +		vfillbuf(iov_w, nvector, childnum+i);
> >  
> >  		if (lseek(fd_w, seekoff, SEEK_SET) < 0) {
> >  			tst_resm(TFAIL, "lseek before write failed: %s",
> >  				 strerror(errno));
> > -			return (-1);
> > +			goto free_out;
> >  		}
> > -		if (write(fd_w, buf1, bufsize) < bufsize) {
> > -			tst_resm(TFAIL, "write failed: %s", strerror(errno));
> > -			return (-1);
> > +		if (writev(fd_w, iov_w, nvector) < 0) {
> > +			tst_resm(TFAIL, "writev failed: %s", strerror(errno));
> > +			goto free_out;
> >  		}
> 
> We have to check here that the whole vector was written as well.

Sure, I noticed that there're other diotests break out if write[v]
didn't write bufsize data.

> 
> >  		if (action == READ_DIRECT) {
> >  			/* Make sure data is on to disk before read */
> >  			if (fsync(fd_w) < 0) {
> >  				tst_resm(TFAIL, "fsync failed: %s",
> >  					 strerror(errno));
> > -				return (-1);
> > +				goto free_out;
> >  			}
> >  		}
> >  		if (lseek(fd_r, seekoff, SEEK_SET) < 0) {
> >  			tst_resm(TFAIL, "lseek before read failed: %s",
> >  				 strerror(errno));
> > -			return (-1);
> > +			goto free_out;
> >  		}
> > -		int ret;
> > -		if ((ret = read(fd_r, buf2, bufsize)) < bufsize) {
> > -			tst_resm(TFAIL, "read failed: %s", strerror(errno));
> > -			return (-1);
> > +		if (readv(fd_r, iov_r, nvector) < 0) {
> > +			tst_resm(TFAIL, "readv failed: %s", strerror(errno));
> > +			goto free_out;
> >  		}
> 
> Here as well.
> 
> > -		if (bufcmp(buf1, buf2, bufsize) != 0) {
> > +		if (vbufcmp(iov_w, iov_r, nvector) != 0) {
> >  			tst_resm(TFAIL, "comparsion failed. Child=%d offset=%d",
> >  				 childnum, (int)seekoff);
> > -			return (-1);
> > +			goto free_out;
> >  		}
> >  	}
> > -	return 0;
> > +	ret = 0;
> > +
> > +free_out:
> 
> I would call this label err: or just out: but that is minor.

OK, I'll rename it to "err".

Thanks for the review!

Eryu

> 
> > +	for (i = 0, iovp = iov_r; i < nvector; iovp++, i++)
> > +		free(iovp->iov_base);
> > +	for (i = 0, iovp = iov_w; i < nvector; iovp++, i++)
> > +		free(iovp->iov_base);
> > +	free(iov_r);
> > +	free(iov_w);
> > +	return ret;
> >  }
> >  
> >  /*
> > -- 
> > 2.9.3
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
