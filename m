From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Sep 2016 11:25:11 +0800
Subject: [LTP] [PATCH v5] lib: make the loop device size can be increased
In-Reply-To: <20160926130715.GB4164@rei.suse.cz>
References: <1474884724-19972-1-git-send-email-liwang@redhat.com>
 <20160926130715.GB4164@rei.suse.cz>
Message-ID: <20160927032511.GA24779@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 26, 2016 at 03:07:15PM +0200, Cyril Hrubis wrote:
> Hi!
> > diff --git a/lib/tst_device.c b/lib/tst_device.c
> > index 30b1be2..7effac8 100644
> > --- a/lib/tst_device.c
> > +++ b/lib/tst_device.c
> > @@ -184,8 +184,18 @@ static void detach_device(const char *dev)
> >  
> >  const char *tst_acquire_device(void (cleanup_fn)(void))
> >  {
> > +	return tst_acquire_device_(cleanup_fn, 0);
> > +}
> 
> This can be implemented as static inline function inside the header
> file.

Great! no problem.

> > -	if (tst_fill_file(DEV_FILE, 0, 1024, 153600)) {
> > +	if (tst_fill_file(DEV_FILE, 0, 1024, 1024 * acq_dev_size)) {
> >  		tst_brkm(TBROK | TERRNO, cleanup_fn,
> >  		         "Failed to create " DEV_FILE);
> >  
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 12ca051..1c2995e 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -596,7 +596,10 @@ static void do_setup(int argc, char *argv[])
> >  	}
> >  
> >  	if (tst_test->needs_device) {
> > -		tdev.dev = tst_acquire_device(NULL);
> > +		if(!tst_test->device_min_size)
> > +			tst_test->device_min_size = 150;
> 
> The tst_acquire_device_ will make sure that the size is at least 150MB
> anyway. So this part is useless, isn't it?

Yes, it's useless! From what I test on removing them, tst_device.c also works fine.

> 
> Otherwise it looks good.

Thanks for reviewing. Patch v6 is coming...


Li Wang
