From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Feb 2019 19:04:12 +0530
Subject: [LTP] [PATCH v4 9/9] syscalls/sync_file_range: add sync device
	test-case
In-Reply-To: <20190226114823.kfr4vdk53mgs4vgr@holly.lan>
References: <1550739616-24054-1-git-send-email-sumit.garg@linaro.org>
 <1550739616-24054-10-git-send-email-sumit.garg@linaro.org>
 <20190225152640.GD6132@rei.lan>
 <CAFA6WYP8GF3JuUZfn6wt-cKv+RZ5PDy6W_KOs0L753Mj_xE_xw@mail.gmail.com>
 <20190226105711.GB29783@rei.lan> <20190226114823.kfr4vdk53mgs4vgr@holly.lan>
Message-ID: <CAFA6WYNr7C+6ditJ2WG3bmjU5-F6Vo2UnssY_8Ei+ijz=3iaGw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 26 Feb 2019 at 17:18, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Feb 26, 2019 at 11:57:11AM +0100, Cyril Hrubis wrote:
> > Hi!
> > > > This tests fails for me for fuse based filesystems, the call returns 0
> > > > but does not write anything, the questions is if this is desired
> > > > behavior or not.
> > > >
> > >
> > > Interesting case. Do you see similar behaviour with other sync related syscalls?
> >
> > Just this one, I would have expected that the new syscall is not wired
> > into fuse yet hence it does nothing silently instead of returning
> > EOPNOTSUPP which could break applications...
> >
> > > AFAIK, fuse file-system operations are implemented in user-space
> > > daemons exported to kernel as callbacks via libfuse. Maybe we need to
> > > check fsync() callback operation [1] implementation?
> > >
> > > [1] https://libfuse.github.io/doxygen/structfuse__operations.html
>
> For file syncs I think (admitedly without having much VFS experience)
> that the writeback will end up being requested via the writepages VFS op;
> since we are writing back data from a single fd then the kernel doesn't
> need much help from the filesystem to find out which pages are
> affected so the "big" sync API in fuse is probably not needed here.
>

Hmm, I see in case of sync_file_range(), its handled via writepages
VFS op. And fuse fsync() callback is used for fsync() and fdatasync()
syscalls.

>
> Daniel.
>
>
> > >
> > > > Also we should as well add a second test here that sync only a middle of
> > > > a written region of a file and expects that the data written are
> > > > somewhere between a few percents of the synced size.
> > > >
> > >
> > > Sure, will add a test for this.
> >
> > Ideally this should be put into the existing test in order to spare time
> > needed to format the devices etc.
> >

Agree.


-Sumit

> > --
> > Cyril Hrubis
> > chrubis@suse.cz
