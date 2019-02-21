From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 21 Feb 2019 13:36:18 +0000
Subject: [LTP] [PATCH v4 2/9] lib: split tst_fill_file() to create new
 tst_fill_fd()
In-Reply-To: <20190221120442.GB17813@rei.lan>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-3-git-send-email-sumit.garg@linaro.org>
 <20190221113840.l2ffu4d22u72uakm@holly.lan>
 <20190221120442.GB17813@rei.lan>
Message-ID: <20190221133618.kfnvhvznztz75ksp@holly.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 21, 2019 at 01:04:42PM +0100, Cyril Hrubis wrote:
> Hi!
> > > -int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
> > > +int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount)
> > >  {
> > > -	int fd;
> > > -	size_t counter;
> > > +	size_t i;
> > 
> > Nitpicking perhaps but gratuitous variable renames don't make patches
> > containing other changes easier to read. Nor, to be honest, does 
> > "counter" seem any more descriptive then i (since i is more idiomatic
> > and therefore quicker to read).
> 
> It seems you misread the patch as we are replacing the counter with i
> here and I asked for that since i is the idiomatic way of naming loop
> variables, so all the blame for this change goes to me :-).

Quite right. I misread it. Sorry for the noise.


Daniel.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
