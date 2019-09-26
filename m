From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2019 19:50:36 +0300
Subject: [LTP] copy_file_range() errno changes introduced in v5.3-rc1
In-Reply-To: <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
Message-ID: <CAOQ4uxhpiLyhJ4Tu75V3yC7zjU5THw86V6FCbUC7bHC8RsyAEA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 26, 2019 at 7:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Sep 26, 2019 at 7:19 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi Darrick,
> >
> > > On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> > > > Hi Amir,
> >
> > > > I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> > > > There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> > > > ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> > > > These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?
> >
> > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.
>
> Started to return EXDEV?? quite the opposite.
> But LTP tests where already adapted to that behavior AFAICT:
> 15cac7b46 syscalls/copy_file_range01: add cross-device test
>
>
> > > > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.
> >
> > > I'm not Amir, but by my recollection, yes, those are intentional. :)
> > Thanks for a quick confirmation.
> >
>
> Which reminds me - I forgot to send the man pages patch out to maintainer:
> https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/
>
> At least according to man page -EACCES is also possible.
>

But it looks like man page update is wrong.
I'll fix it and post.

Thanks,
Amir.
