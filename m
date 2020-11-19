From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2020 12:54:57 +0200
Subject: [LTP] [PATCH v3 3/5] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201119102740.GD2785@yuki.lan>
References: <20201113164944.26101-1-pvorel@suse.cz>
 <20201113164944.26101-4-pvorel@suse.cz>
 <20201119102740.GD2785@yuki.lan>
Message-ID: <CAOQ4uxigsk5e7GHgDHydd03D1bAih1SJv36dB4209mpE_dU6PQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 19, 2020 at 12:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >       return rval;
> >  }
> > +
> >  #define SAFE_FANOTIFY_INIT(fan, mode)  \
> >       safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
> >
> > @@ -189,6 +190,41 @@ struct fanotify_event_info_fid {
> >  #define MAX_HANDLE_SZ                128
> >  #endif
> >
> > +static inline int safe_fanotify_mark(const char *file, const int lineno,
> > +                     int fd, unsigned int flags, uint64_t mask,
> > +                     int dfd, const char *pathname)
> > +{
> > +     int rval;
> > +
> > +     rval = fanotify_mark(fd, flags, mask, dfd, pathname);
> > +
> > +     if (rval == -1) {
> > +             if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
> > +                     tst_brk(TCONF,
> > +                             "%s:%d: FAN_REPORT_FID not supported on %s filesystem",
> > +                             file, lineno, tst_device->fs_type);
>
> I guess that we should use tst_brk_() and pass the file and lineno here
> and in the rest of the tst_ calls in this function.
>
> > +             if (errno == EINVAL && (flags & FAN_MARK_FILESYSTEM) == FAN_MARK_FILESYSTEM) {
>
> The comparsion in (flags & FAN_MARK_FILESYSTEM) == FAN_MARK_FILESYSTEM
> seems to be useless. How is this different from a simple
> (flags & MARK_FILESYSTEM) when converted into a boolean value?
>
> > +                             tst_brk(TCONF,
> > +                                     "%s:%d: FAN_MARK_FILESYSTEM not supported by kernel?",
> > +                                     file, lineno);
> > +             }
> > +
> > +             tst_brk(TBROK | TERRNO, "%s:%d: fanotify_mark() failed",
> > +                     file, lineno);
> > +     }
> > +
> > +     if (rval < -1) {
> > +             tst_brk(TBROK | TERRNO, "%s:%d: invalid fanotify_mark() return %d",
> > +                     file, lineno, rval);
> > +     }
> > +
> > +     return rval;
> > +}
> > +
> > +#define SAFE_FANOTIFY_MARK(fd, flags, mask, dfd, pathname)  \
> > +     safe_fanotify_mark(__FILE__, __LINE__, (fd), (flags), (mask), (dfd), (pathname))
> > +
> >  /*
> >   * Helper function used to obtain fsid and file_handle for a given path.
> >   * Used by test files correlated to FAN_REPORT_FID functionality.
> > @@ -242,7 +278,6 @@ static inline void fanotify_save_fid(const char *path,
> >  #define INIT_FANOTIFY_MARK_TYPE(t) \
> >       { FAN_MARK_ ## t, "FAN_MARK_" #t }
> >
> > -
> >  static inline void fanotify_access_permissions_supported_by_kernel(void)
> >  {
> >       int fd;
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
> > index 03e453f41..7690f6b88 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify01.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
> > @@ -101,19 +101,8 @@ static void test_fanotify(unsigned int n)
> >                       "failed", tc->init_flags);
> >       }
> >
> > -     if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
> > -                       FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> > -                       AT_FDCWD, fname) < 0) {
> > -             if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
> > -                     tst_res(TCONF,
> > -                             "FAN_MARK_FILESYSTEM not supported in kernel?");
> > -                     return;
> > -             }
>
> Here we had tst_res(TCONF, ...) followed by a return but we will can
> tst_brk() after the change. I guess that we may skip part of the test on
> older kernels with that change.
>

That's not good. I missed that in my review.
There are many tests where only the FAN_MARK_FILESYSTEM
test cases are expected to result in TCONF, but the rest of the test
cases should run.

In most of these tests the FAN_MARK_FILESYSTEM test cases are
last because they were added later. This is not the case with fanotify01
and fanotify15 and we do not want to reply on the ordering anyway.

Thanks,
Amir.
