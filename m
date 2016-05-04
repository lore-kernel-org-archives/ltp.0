From: Eryu Guan <eguan@redhat.com>
Date: Wed, 4 May 2016 11:25:53 +0800
Subject: [LTP] [PATCH 2/2] ltp-aiodio: report posix_memalign errors
 properly
In-Reply-To: <20160503124908.GE6059@rei.lan>
References: <1462268030-21958-1-git-send-email-eguan@redhat.com>
 <1462268030-21958-2-git-send-email-eguan@redhat.com>
 <20160503124908.GE6059@rei.lan>
Message-ID: <20160504032553.GZ5140@eguan.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 03, 2016 at 02:49:08PM +0200, Cyril Hrubis wrote:
> Hi!
> >  int dio_sparse(char *filename, int align, int writesize, int filesize)
> >  {
> > -	int fd;
> > +	int fd, ret;
> >  	void *bufptr;
> >  	int i, w;
> >  
> > @@ -68,9 +69,10 @@ int dio_sparse(char *filename, int align, int writesize, int filesize)
> >  
> >  	SAFE_FTRUNCATE(cleanup, fd, filesize);
> >  
> > -	if (posix_memalign(&bufptr, align, writesize)) {
> > +	ret = posix_memalign(&bufptr, align, writesize);
> > +	if (ret) {
> > +		tst_resm(TBROK, "posix_memalign(): %s", strerror(ret));
> 
> We should use tst_strerrno() instead of strerror().

Thanks, new stuff learned, I'm still not so familiar with ltp APIs :)

> 
> >  		close(fd);
> > -		tst_resm(TBROK | TERRNO, "posix_memalign()");
> >  		return 1;
> >  	}
> 
> Otherwise this looks fine.

Thanks for the review!

Eryu
