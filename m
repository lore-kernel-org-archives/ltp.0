From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Jan 2020 11:35:09 +0100
Subject: [LTP] [PATCH COMMITTED] tst_device: do sync() before reading
 test block device stat file
In-Reply-To: <20200106100540.GA25027@rei.lan>
References: <20200102015236.7400-1-liwang@redhat.com>
 <20200102125759.GE32710@rei.lan>
 <CAEemH2fdY_pPjNCEFmcd_zsye4HAciPuhF+Fiyde9WmBci=+Lg@mail.gmail.com>
 <20200106100540.GA25027@rei.lan>
Message-ID: <20200106103509.GB25027@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > To avoid FS deferred IO metadata/cache interferes test result, so we
> > > > do sync simply before the tst_dev_bytes_written invocation.
> > >
> > > Can we do fsync() on the fd instead of full sync()? That should be
> > > slightly faster.
> > >
> > 
> > Probably you miss the previous discussed [1], we use sync() here because we
> > do want to make sure all FS metadata/cache being written back before the
> > testing since there is no obtainable file descriptor 'fd' for the ext4
> > deferred IO (e.g. initialize the journal and inode tables).
> 
> Ah, right, we measure I/O to the whole device, so we would have to sync
> the device in question. Then syncfs() on the fd we got should work
> right? And it should avoid syncing unrelated filesystems as well.

It wouldn't probably harm to create an inline function in the test
library just for a sake of documentation, something as:

static inline void tst_dev_sync(int fd)
{
	syncfs(fd);
}


Then we end up calling:

	tst_dev_sync(fd);
	tst_dev_bytes_written(device);

-- 
Cyril Hrubis
chrubis@suse.cz
