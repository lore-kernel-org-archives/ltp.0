From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Thu, 25 Oct 2018 17:39:00 +1100
Subject: [LTP] [RFC 3/3] syscalls/fanotify03: add FAN_OPEN_EXEC_PERM
 tcase support
In-Reply-To: <CAOQ4uxj0UGsD+eN-V6cCbgkXcvTB_56Ld+C2Jop2p6CnGfxq5Q@mail.gmail.com>
References: <cover.1540348505.git.mbobrowski@mbobrowski.org>
 <dc279fdedc3c3bf45ee2f8d6f5a9547291eb2ac7.1540348505.git.mbobrowski@mbobrowski.org>
 <CAOQ4uxj0UGsD+eN-V6cCbgkXcvTB_56Ld+C2Jop2p6CnGfxq5Q@mail.gmail.com>
Message-ID: <20181025063757.GA6331@development.internal.lab>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 24, 2018 at 08:56:45AM +0300, Amir Goldstein wrote:
> On Wed, Oct 24, 2018 at 6:28 AM Matthew Bobrowski
> <mbobrowski@mbobrowski.org> wrote:
> >
> > * Defined FAN_OPEN_EXEC_PERM flag in local tests header file to
> >   accommodate for the fact if it's not defined in system user space
> >   headers
> >
> > * Defined new tcase's for each mark type to support new fanotify flag
> >   FAN_OPEN_EXEC_PERM tests
> >
> > * Updated fanotify_mark failure logic to report the instance where
> >   FAN_OPEN_EXEC_PERM flag is not available within the kernel
> >
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> > ---
> 
> Very neat and small change - that's good!
> Do you have the series on a public branch that I can test?
> 
I've pushed the branch with your recommended changes. You can find it
using the link below.

https://github.com/matthewbobrowski/ltp/tree/fanotify03_exec

> 
> Nits below.
> 
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 14 ++++++
> >  .../kernel/syscalls/fanotify/fanotify03.c     | 45 ++++++++++++++++---
> >  2 files changed, 53 insertions(+), 6 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index 535f1cef2..b0a847ab6 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -60,6 +60,20 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
> >  #ifndef FAN_MARK_FILESYSTEM
> >  #define FAN_MARK_FILESYSTEM    0x00000100
> >  #endif
> > +#ifndef FAN_OPEN_EXEC_PERM
> > +#define FAN_OPEN_EXEC_PERM     0x00040000
> > +#endif
> > +
> > +/*
> > + * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
> > + * are not to be added to it. To cover the instance where a new permission
> > + * event is defined, we need to update FAN_ALL_PERM_EVENTS accordingly,
> > + * thus needing to do the undef/define. Any new permission events should
> > + * be added to the newly defined macro below.
> > + */
> > +#undef FAN_ALL_PERM_EVENTS
> 
> Instead of undef/define, let's define and use LTP_ALL_PERM_EVENTS
> that will be more clear to the reader IMO.
> Comment above can stay mostly as it is.
>
I agree with this approach and I initially thought to do the same, but I
didn't want it to be wrong or deviate from using existing fanotify flag
names. Anyway, I've updated this as per recommendations.

> > +#define FAN_ALL_PERM_EVENTS    (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
> > +                                FAN_ACCESS_PERM)
> >
> >  struct fanotify_mark_type {
> >         unsigned int flag;
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > index f9418ee6b..d6d8fb8bf 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> 
> + /*
> +  * Keep first FAN_OPEN_EXEC_PERM test case before first MARK_TYPE(FILESYSTEM)
> +  * to allow for correct detection between exec events not supported
> and filesystem marks
> +  * not supported.
> +  */
> 
Added.

> > @@ -59,7 +59,7 @@ static struct tcase {
> >         struct event event_set[EVENT_MAX];
> >  } tcases[] = {
> >         {
> > -               "inode mark permission events",
> > +               "inode mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
> >                 INIT_FANOTIFY_MARK_TYPE(INODE),
> >                 FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
> >                 {
> > @@ -69,7 +69,16 @@ static struct tcase {
> >                 }
> >         },
> >         {
> > -               "mount mark permission events",
> > +               "inode mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
> > +               INIT_FANOTIFY_MARK_TYPE(INODE),
> > +               FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
> > +               {
> > +                       {FAN_ACCESS_PERM, FAN_DENY},
> > +                       {FAN_OPEN_EXEC_PERM, FAN_DENY}
> > +               }
> > +       },
> > +       {
> > +               "mount mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
> >                 INIT_FANOTIFY_MARK_TYPE(MOUNT),
> >                 FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
> >                 {
> > @@ -79,7 +88,16 @@ static struct tcase {
> >                 }
> >         },
> >         {
> > -               "filesystem mark permission events",
> > +               "mount mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
> > +               INIT_FANOTIFY_MARK_TYPE(MOUNT),
> > +               FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
> > +               {
> > +                       {FAN_ACCESS_PERM, FAN_DENY},
> > +                       {FAN_OPEN_EXEC_PERM, FAN_DENY}
> > +               }
> > +       },
> > +       {
> > +               "filesystem mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
> >                 INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> >                 FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
> >                 {
> > @@ -87,7 +105,16 @@ static struct tcase {
> >                         {FAN_ACCESS_PERM, FAN_DENY},
> >                         {FAN_OPEN_PERM, FAN_DENY}
> >                 }
> > -       }
> > +       },
> > +       {
> > +               "filesystem mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
> > +               INIT_FANOTIFY_MARK_TYPE(MOUNT),
>                  INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> 
> > +               FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
> > +               {
> > +                       {FAN_ACCESS_PERM, FAN_DENY},
> > +                       {FAN_OPEN_EXEC_PERM, FAN_DENY}
> > +               }
> > +       },
> >  };
> >
> >  static void generate_events(void)
> > @@ -182,7 +209,13 @@ static int setup_mark(unsigned int n)
> >                 if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> >                                   tc->mask, AT_FDCWD, files[i]) < 0) {
> >                         if (errno == EINVAL && support_perm_events &&
> > -                           mark->flag == FAN_MARK_FILESYSTEM) {
> > +                               tc->mask & FAN_OPEN_EXEC_PERM) {
> 
> Almost. It's hard to get this right ;-)
> 
> +                               (tc->mask & FAN_OPEN_EXEC_PERM &&
> !support_exec_events)) {
> 
> If EXEC events were proven to be supported by prior test case, we
> won't emit this
> warning and may very well fall through to report no FAN_MARK_FILESYSTEM support.
> It's true that no upstream kernel is expected to support EXEC events
> and not FILESYSTEM
> marks, but who knows what future kernels this test will run on.
> EXEC events are quite easy to backport to old kernels.
>
Thanks :-)

I've updated it based on these recommendations.

> > +                               tst_res(TCONF,
> > +                                       "FAN_OPEN_EXEC_PERM not supported in "
> > +                                       "kernel?");
> > +                               return -1;
> > +                       } else if (errno == EINVAL && support_perm_events &&
> > +                                       mark->flag == FAN_MARK_FILESYSTEM) {
> >                                 tst_res(TCONF,
> >                                         "FAN_MARK_FILESYSTEM not supported in "
> >                                         "kernel?");
> > @@ -193,7 +226,7 @@ static int setup_mark(unsigned int n)
> >                                         "not configured in kernel?");
> >                         } else {
> >                                 tst_brk(TBROK | TERRNO,
> > -                                       "fanotify_mark (%d, FAN_MARK_ADD | %s, "
> > +                                       "fanotify_mark(%d, FAN_MARK_ADD | %s, "
> >                                         "FAN_ACCESS_PERM | FAN_OPEN_PERM, "
> >                                         "AT_FDCWD, %s) failed.",
> >                                         fd_notify, mark->name, fname);
>                 }
> +       }
> -        } else {
> -                /*
> -                 * To distigouish between perm event not supported and
> -                 * filesystem mark not supported.
> -                 */
> -               support_perm_events = 1;
> +       /*
> +        * To distinguish between perm event not supported exec events not
> +        * supported and filesystem mark not supported.
> +        */
> +       support_perm_events = 1;
> +       if (tc->mask & FAN_OPEN_EXEC_PERM)
> +                   support_exec_events = 1;
> -        }
>
Updated.

-- 
Matthew Bobrowski <mbobrowski@mbobrowski.org>
