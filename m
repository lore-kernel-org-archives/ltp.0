From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Nov 2018 18:36:41 +0200
Subject: [LTP] [PATCH 4/5] syscalls/fanotify03: add test for
 FAN_MARK_FILESYSTEM permission events
In-Reply-To: <20181121131448.GE2954@rei>
References: <20181116065119.6912-1-amir73il@gmail.com>
 <20181116065119.6912-5-amir73il@gmail.com>
 <20181121131448.GE2954@rei>
Message-ID: <CAOQ4uxjQQahvt0b=i50XeoG7Db8BzudqoXwaoHwMZ-qQHhWfxw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 21, 2018 at 3:16 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > -static void setup_mark(unsigned int n)
> > +static int setup_mark(unsigned int n)
> >  {
> >       struct tcase *tc = &tcases[n];
> >       struct fanotify_mark_type *mark = &tc->mark;
> > @@ -144,7 +149,12 @@ static void setup_mark(unsigned int n)
> >       if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> >                         FAN_ACCESS_PERM | FAN_OPEN_PERM,
> >                         AT_FDCWD, fname) < 0) {
> > -             if (errno == EINVAL) {
> > +             if (errno == EINVAL && support_perm_events &&
> > +                 mark->flag == FAN_MARK_FILESYSTEM) {
> > +                     tst_res(TCONF,
> > +                             "FAN_MARK_FILESYSTEM not supported in kernel?");
> > +                     return -1;
> > +             } else if (errno == EINVAL) {
> >                       tst_brk(TCONF | TERRNO,
> >                               "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
> >                               "configured in kernel?");
> > @@ -155,9 +165,16 @@ static void setup_mark(unsigned int n)
> >                               "AT_FDCWD, %s) failed.",
> >                               fd_notify, mark->name, fname);
> >               }
> > +     } else {
> > +             /*
> > +              * To distigouish between perm event not supported and
> > +              * filesystem mark not supported.
> > +              */
> > +             support_perm_events = 1;
>
> I'm a bit puzzled here, so we attempted to cache if perm_events are
> supported here?
>

Yes.

> I guess that we depend on the order of the tcases[] array here, which is
> not very nice.
>

Indeed. It is a simplification. All test cases are permission events,
so the order of failure types is not likely to change, but I could add a
comment about the order near test cases definition.
Would you rather that I did an explicit test for permission support at setup()
time?

> Also it does not have to be in else branch, if we get EINVAL the first
> time we call fanotify_mark() tst_brk() is called, which exits the test,
> so if we ever get to this point in the program, we did at least one
> successful mark.

Right. I'll change that.

Thanks,
Amir.
