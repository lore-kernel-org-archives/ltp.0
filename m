From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Nov 2020 20:52:42 +0200
Subject: [LTP] [PATCH v2 2/5] fanotify: Handle supported features checks
 in setup()
In-Reply-To: <CAOQ4uxixL6f2hApFUjgO2d1ZOstftQwn8-y4dN6Qcd6RE-oyWA@mail.gmail.com>
References: <20201113155123.5959-1-pvorel@suse.cz>
 <20201113155123.5959-3-pvorel@suse.cz>
 <CAOQ4uxixL6f2hApFUjgO2d1ZOstftQwn8-y4dN6Qcd6RE-oyWA@mail.gmail.com>
Message-ID: <CAOQ4uxhWOaarVWE6r_EgvtqSV83WeVghp+crAMo5UpC4KxeP9Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 13, 2020 at 8:33 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 5:51 PM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Create 2 helpers which are used in various tests in setup() to check for
> > FAN_ACCESS_PERM enablement (caused by disabled CONFIG_FANOTIFY_ACCESS_PERMISSIONS)
> > or FAN_OPEN_EXEC and FAN_OPEN_EXEC_PERM support in kernel.
> >
> > That helps to further code simplification in next commit.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi Amir,
> >
>
> Hi Petr,
>
> > New in v2.
> >
> > Is that how you meant the check?
>
> Yes, almost.
>
> FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL()
> does not need to take a mask argument.
> It just needs to check support for FAN_OPEN_EXEC.
> FAN_OPEN_EXEC_PERM will be supported if FAN_OPEN_EXEC
> is supported and permission events are supported.
>
> Alternatively, rename the helper to FANOTIFY_EVENTS_SUPPORTED_BY_KERNEL()
> with the mask argument and then it could be used in the future for
> testing support for more new events.
>
> > Not sure about function names, feel free to suggest better ones.
>
> I am not good with naming ;-)
>
> > Also it's not good that it's not clear from function name whether it
> > uses tst_brk() on EINVAL or it returns value.
>
> I agree with that.
> Better look for precedents in LTP or consult with other LTP developers.
>
> Thanks,
> Amir.
>
> >
> > Kind regards,
> > Petr
> >
> >  testcases/kernel/syscalls/fanotify/fanotify.h | 47 +++++++++++++++
> >  .../kernel/syscalls/fanotify/fanotify03.c     | 30 ++++------
> >  .../kernel/syscalls/fanotify/fanotify07.c     |  2 +
> >  .../kernel/syscalls/fanotify/fanotify10.c     |  8 +++
> >  .../kernel/syscalls/fanotify/fanotify12.c     | 57 ++++++++-----------
> >  5 files changed, 91 insertions(+), 53 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index 0afbc02aa..0c61f8ab7 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -242,4 +242,51 @@ static inline void fanotify_save_fid(const char *path,
> >  #define INIT_FANOTIFY_MARK_TYPE(t) \
> >         { FAN_MARK_ ## t, "FAN_MARK_" #t }
> >
> > +
> > +static inline void fanotify_access_permissions_supported_by_kernel(void)
> > +{
> > +       int fd;
> > +
> > +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> > +
> > +       if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
> > +               if (errno == EINVAL) {
> > +                       tst_brk(TCONF | TERRNO,
> > +                               "CONFIG_FANOTIFY_ACCESS_PERMISSIONS not configured in kernel?");
> > +               } else {
> > +                       tst_brk(TBROK | TERRNO,
> > +                               "fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,"
> > +                               " \".\") failed", fd);
> > +               }
> > +       }
> > +
> > +       SAFE_CLOSE(fd);
> > +}
> > +
> > +static inline int fanotify_exec_events_supported_by_kernel(uint64_t mask,
> > +                                                          const char* smask)
> > +{
> > +       int fd;
> > +       int rval = 0;
> > +
> > +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> > +
> > +       if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> > +               if (errno == EINVAL) {
> > +                       rval = -1;
> > +               } else {
> > +                       tst_brk(TBROK | TERRNO,
> > +                               "fanotify_mark (%d, FAN_MARK_ADD, %s, AT_FDCWD, \".\") failed",
> > +                               fd, smask);
> > +               }
> > +       }
> > +
> > +       SAFE_CLOSE(fd);
> > +
> > +       return rval;
> > +}
> > +
> > +#define FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(mask) \
> > +       fanotify_exec_events_supported_by_kernel(mask, #mask)
> > +
> >  #endif /* __FANOTIFY_H__ */
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > index 1ef1c206b..fbec652f6 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > @@ -212,28 +212,23 @@ static int setup_mark(unsigned int n)
> >         char *const files[] = {fname, FILE_EXEC_PATH};
> >
> >         tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> > +
> > +       if (support_exec_events != 0 && tc->mask & FAN_OPEN_EXEC_PERM) {
> > +               tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC_PERM not supported in kernel?");
> > +               return -1;
> > +       }
> > +

Please remove the comment above tcases[] definition:
"Ensure to keep the first..."

It is no longer needed after this change.

Thanks,
Amir.
