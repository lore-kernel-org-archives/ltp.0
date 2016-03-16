From: Zorro Lang <zlang@redhat.com>
Date: Wed, 16 Mar 2016 23:32:22 +0800
Subject: [LTP] [PATCH v4] tst_mkfs: add new parameter extra_opt to
 tst_mkfs function
In-Reply-To: <20160316144212.GB635@rei.lan>
References: <1458013068-17610-1-git-send-email-zlang@redhat.com>
 <20160316144212.GB635@rei.lan>
Message-ID: <20160316153222.GB6364@dhcp12-237.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 16, 2016 at 03:42:12PM +0100, Cyril Hrubis wrote:
> Hi!
> > mmap16 always hit ETIMEDOUT error, if the test device is too large.
> > mkfs on the device will take lots of time. So I want to make ext4
> > with an appointed size. But the [fs_size] need after the device
> > name for ext4, e.g. "mkfs -t ext4 dev [fs_size]".
> > 
> > Due to above reason, add a new parameter extra_opt to tst_mkfs.
> > extra_opt store the option need after the device name of mkfs.
> > Then mmap16 can make ext4 with an appointed (small) size. And this
> > change can make tst_mkfs() cover one more mkfs usage.
> > 
> > Due to I only find one option maybe need after the device name,
> > so I use extra_opt. If there're more, the extra_opt should be
> > changed to extra_opts[].
> > 
> > Because of tst_mkfs be changed, all testcases which use tst_mkfs add
> > NULL parameter for extra_opt.
> 
> I've changed wording here a bit.
> 
> > +/*
> > + * tst_mkfs: mkfs.$fs_type on $dev with options $fs_opts and $extra_opt
> > + *     cleanup_fn - run it when exit with error.
> > + *     dev        - device path name
> > + *     fs_opts    - store the options for mkfs (except -t fs_type). Set
> > + *                  NULL if don't need options.
> > + *     extra_opt  - extra mkfs option for mkfs, this option is passed
> > + *                  after the device name, e.g. [fs_size] for ext4.
> > + *                  Set NULL, if don't need option after device name.
> > + */
> >  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> > -	      const char *fs_type, const char *const fs_opts[])
> > +              const char *fs_type, const char *const fs_opts[],
> > +              const char *extra_opt)
> >  {
> 
> And removed this comment from the C source file since we have
> documentaion and comment in the header file which is more than enough.
> (Since we have to keep the implementaion and documentation in sync
>  having it just in two places is better than three...).
Yes, you're right. I wrote too many comments to describe one thing:-P

> 
> And pushed, thanks.
> 
> BTW, whith this patch the mmap test runs in 3 seconds instead of 10 when
>      the default 100MB device is used which is nice iprovement.
That's my pleasure to see this improvement. I think if all testcases
think about limit the fs size when they need to full the whole fs,
that will be a good habit:-)

Thanks for your review too.

Zorro

> 
