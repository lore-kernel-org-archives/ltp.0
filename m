From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 22 Nov 2017 07:51:29 -0500 (EST)
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to ordinary
 syscall
In-Reply-To: <1075630177.43956420.1511354910460.JavaMail.zimbra@redhat.com>
References: <20171110111519.27872-1-liwang@redhat.com>
 <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
 <20171120131952.GA22113@rei.lan>
 <CAEemH2ei8WXrpWLN5J_+tb4cZiZGeE1ovd43TnbUtb=seEdf3Q@mail.gmail.com>
 <20171121094445.GA9443@rei.lan>
 <1075630177.43956420.1511354910460.JavaMail.zimbra@redhat.com>
Message-ID: <1410675646.43959033.1511355089017.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> ----- Original Message -----
> > Hi!
> > > > But I can always change that in a follow up patch...
> > > 
> > > How about this following change:
> > > 
> > > --- a/testcases/kernel/fs/fs_fill/fs_fill.c
> > > +++ b/testcases/kernel/fs/fs_fill/fs_fill.c
> > > @@ -41,21 +41,11 @@ struct worker {
> > > 
> > >  static void *worker(void *p)
> > >  {
> > > -       int ret;
> > >         struct worker *w = p;
> > >         DIR *d;
> > >         struct dirent *ent;
> > >         char file[PATH_MAX];
> > > 
> > > -       ret = mkdir(w->dir, 0700);
> > > -       if (ret == -1) {
> > > -               if (errno != ENOSPC)
> > > -                       tst_brk(TBROK | TERRNO, "mkdir()");
> > > -
> > > -               tst_res(TINFO | TERRNO, "mkdir()");
> > > -               return NULL;
> > > -       }
> > > -
> > >         while (run) {
> > >                 tst_fill_fs(w->dir, 0);
> > > 
> > > @@ -92,6 +82,10 @@ static void testrun(void)
> > >         for (i = 0; i < nthreads; i++) {
> > >                 snprintf(workers[i].dir, sizeof(workers[i].dir),
> > >                          MNTPOINT "/thread%i", i + 1);
> > > +               SAFE_MKDIR(workers[i].dir, 0700);
> > > +       }
> > > +
> > > +       for (i = 0; i < nthreads; i++) {
> > >                 SAFE_PTHREAD_CREATE(&threads[i], NULL, worker,
> > >                 &workers[i]);
> > >         }
> > 
> > This one looks cleaner to me.
> 
> But perhaps this should go to setup(), otherwise with "-i 2"
> it hits TBROK on mkdir.
> 
> I tried adding RMDIR after join, but unlink doesn't seem to remove
> everything:
> safe_macros.c:184: BROK: fs_fill.c:108: rmdir(mntpoint/thread4) failed:
> ENOTEMPTY

I see, there's "break" in loop that does unlink. Which is likely by design,
so we hit ENOSPC sooner.

> 
> Regards,
> Jan
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
