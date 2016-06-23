From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Jun 2016 13:54:39 +0200
Subject: [LTP] [PATCH 2/2] nfs05: rewrite the test,
 make use of new library
In-Reply-To: <576BCE87.5070403@oracle.com>
References: <1466076425-12790-1-git-send-email-alexey.kodanev@oracle.com>
 <1466076425-12790-2-git-send-email-alexey.kodanev@oracle.com>
 <20160622123017.GC13962@rei.lan> <576BCE87.5070403@oracle.com>
Message-ID: <20160623115438.GB19250@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>   
> >> -			dprt("pid[%d]: init_compile(): status = %d\n",
> >> -			     gettid(), status);
> >> -			dprt("we are here %d\n", __LINE__);
> >> -			return status;
> >> +			SAFE_WRITE(1, fd, prog_buf, prog_buf_size);
> >> +			fsync(fd);
> > Why do we fsync(fd) here? Isn't the whole point of this test to find a
> > race conditions?
> 
> And given the fact that we have close(fd) thereafter, should make it 
> useless...

fsync() should cause the page caches to be written to the disk, close()
just frees the associated file descriptor and page caches are written on
background.

-- 
Cyril Hrubis
chrubis@suse.cz
