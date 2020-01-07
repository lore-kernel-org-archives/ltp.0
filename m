From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Jan 2020 14:13:14 +0800
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <20200106100540.GA25027@rei.lan>
References: <20200102015236.7400-1-liwang@redhat.com>
 <20200102125759.GE32710@rei.lan>
 <CAEemH2fdY_pPjNCEFmcd_zsye4HAciPuhF+Fiyde9WmBci=+Lg@mail.gmail.com>
 <20200106100540.GA25027@rei.lan>
Message-ID: <CAEemH2fbHPJSqFgQ2C5YLAmoctiAj_wvp27N+U-zc0omJWTCdw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Mon, Jan 6, 2020 at 6:06 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > > To avoid FS deferred IO metadata/cache interferes test result, so we
> > > > do sync simply before the tst_dev_bytes_written invocation.
> > >
> > > Can we do fsync() on the fd instead of full sync()? That should be
> > > slightly faster.
> > >
> >
> > Probably you miss the previous discussed [1], we use sync() here because
> we
> > do want to make sure all FS metadata/cache being written back before the
> > testing since there is no obtainable file descriptor 'fd' for the ext4
> > deferred IO (e.g. initialize the journal and inode tables).
>
> Ah, right, we measure I/O to the whole device, so we would have to sync
> the device in question. Then syncfs() on the fd we got should work
> right? And it should avoid syncing unrelated filesystems as well.
>

Good point, I double read the fsync() and syncfs() manual page. It looks
like syncfs() is not the same as the previous function, it synchronizes the
file system containing file referred to by the open file descriptor fd, I
mixed them before, to be honest.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200107/c94dff56/attachment.htm>
