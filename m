From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Sep 2019 18:19:06 +0200
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
In-Reply-To: <20190926160432.GC9916@magnolia>
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
Message-ID: <20190926161906.GD23296@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Darrick,

> On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> > Hi Amir,

> > I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> > There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> > ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> > These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?

> > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
> > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

> I'm not Amir, but by my recollection, yes, those are intentional. :)
Thanks for a quick confirmation.

> --D

Kind regards,
Petr
