From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jun 2018 21:12:12 +0800
Subject: [LTP] [PATCH] swapon: commit swapfile caches to disk
In-Reply-To: <1468267167.25962192.1528808172867.JavaMail.zimbra@redhat.com>
References: <1528806239-14297-1-git-send-email-liwang@redhat.com>
 <1468267167.25962192.1528808172867.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cyoZB__UCyPGEb3Afo_UtqkdP2Au-NWSX8SCTjPcvMfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Tue, Jun 12, 2018 at 8:56 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > Testcase include swapon(8) fails on mainline kernel-v4.17+ as:
> >   swapon01    1  TFAIL  :  swapon01.c:47: Failed to turn on swapfile:
> >   TEST_ERRNO=3DEINVAL(22): Invalid argument
> >   swapon02    4  TFAIL  :  swapon02.c:91: swapon(2) failed to produce
> >   expected error: 16, errno: EBUSY and got 22.
> >   swapon03    1  TFAIL  :  swapon03.c:243: Failed to setup swaps
> >   swapoff01   1  TBROK  :  swapoff01.c:64: Failed to turn on the swap
> file,
> >   skipping test iteration
> >
> > And dmesg shows that:
> >   [  128.698981] swapon: file is not committed
> >
> > The error located in IOMAP_F_DIRTY(linux/fs/iomap.c) checking, which
> means
> > this swapfile have uncommitted metadata in caches. After adding sync() =
to
> > the end of all mkswap opertaion, these errors were gone.
> >
> > linux/fs/iomap.c:
> >       static loff_t iomap_swapfile_activate_actor(
> >               struct inode *inode,
> >               loff_t pos,
> >               loff_t count,
> >               void *data,
> >               struct iomap *iomap)
> >       {
> >               struct iomap_swapfile_info *isi =3D data;
> >               int error;
> >               ...
> >
> >               /* No uncommitted metadata or shared blocks. */
> >               if (iomap->flags & IOMAP_F_DIRTY) {
> >                       pr_err("swapon: file is not committed\n");
> >                       return -EINVAL;
> >               }
> >               ...
> >       }
> >                                                                       }
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >
> > Notes:
> >     The new changes about swapfile activation function were merged in
> >     kernel-4.17
> >     recently, so we didn't hit this failures before.
>
> Comment/code in mkswap, that has been present for years:
>         /*
>          * A subsequent swapon() will fail if the signature
>          * is not actually on disk. (This is a kernel bug.)
>          * The fsync() in close_fd() will take care of writing.
>          */
>
> I'm assuming your mkswap is recent enough. Any idea why fsync()
> in mkswap is no longer enough?
>


=E2=80=8BGood catch, Jan. It sounds like a mkswap/fsync issue.

Both of my mkswap failed to sync that, let me re-check it later.

#  rpm -qf /usr/sbin/mkswap
util-linux-2.23.2-43.el7.x86_64

# rpm -qf /usr/sbin/mkswap
util-linux-2.23.2-52.el7.x86_64




>
> Regards,
> Jan
>
> >
> >  testcases/kernel/syscalls/swapoff/swapoff01.c | 2 ++
> >  testcases/kernel/syscalls/swapoff/swapoff02.c | 2 ++
> >  testcases/kernel/syscalls/swapon/libswapon.c  | 2 ++
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > index a63e661..b587b0d 100644
> > --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> > +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> > @@ -105,6 +105,8 @@ static void setup(void)
> >
> >       if (system("mkswap swapfile01 > tmpfile 2>&1") !=3D 0)
> >               tst_brkm(TBROK, cleanup, "Failed to make swapfile");
> > +
> > +     sync();
> >  }
> >
> >  static void cleanup(void)
> > diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c
> > b/testcases/kernel/syscalls/swapoff/swapoff02.c
> > index b5c6312..d8c5889 100644
> > --- a/testcases/kernel/syscalls/swapoff/swapoff02.c
> > +++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
> > @@ -154,6 +154,8 @@ static void setup(void)
> >
> >       if (tst_fill_file("./swapfile01", 0x00, 1024, 1))
> >               tst_brkm(TBROK, cleanup, "Failed to create swapfile");
> > +
> > +     sync();
> >  }
> >
> >  static void cleanup(void)
> > diff --git a/testcases/kernel/syscalls/swapon/libswapon.c
> > b/testcases/kernel/syscalls/swapon/libswapon.c
> > index cf6a988..49fa5ed 100644
> > --- a/testcases/kernel/syscalls/swapon/libswapon.c
> > +++ b/testcases/kernel/syscalls/swapon/libswapon.c
> > @@ -46,4 +46,6 @@ void make_swapfile(void (cleanup)(void), const char
> > *swapfile)
> >       argv[2] =3D NULL;
> >
> >       tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null", 0);
> > +
> > +     sync();
> >  }
> > --
> > 1.9.3
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
>



--=20
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180612/2924ebc9/att=
achment.html>
