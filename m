From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Dec 2020 18:05:08 +0100
Subject: [LTP] [PATCH v5 06/10] fanotify: Add helper for mark support
 check
In-Reply-To: <CAOQ4uxg_Kwmx1K=om9aA6Sh=+L129=YpneDW1ZLP2sL96ELNgw@mail.gmail.com>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-7-pvorel@suse.cz>
 <CAOQ4uxg_Kwmx1K=om9aA6Sh=+L129=YpneDW1ZLP2sL96ELNgw@mail.gmail.com>
Message-ID: <X8fJRNgQ0n4nB4lH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir, Cyril,

> On Tue, Dec 1, 2020 at 7:42 PM Petr Vorel <pvorel@suse.cz> wrote:

> > i.e. FAN_MARK_FILESYSTEM and use it in relevant tests setup().
> > The purpose is to reduce checks (cleanup).

> > NOTE: all tests check only for FAN_MARK_FILESYSTEM, but keep helper
> > generic for future use.

> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > New in v5.

> >  testcases/kernel/syscalls/fanotify/fanotify.h | 21 ++++++++++++++++
> >  .../kernel/syscalls/fanotify/fanotify01.c     | 12 +++++----
> >  .../kernel/syscalls/fanotify/fanotify03.c     | 25 +++++++++----------
> >  .../kernel/syscalls/fanotify/fanotify10.c     | 14 +++++------
> >  .../kernel/syscalls/fanotify/fanotify13.c     | 15 +++++------
> >  5 files changed, 55 insertions(+), 32 deletions(-)

> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > index 821e6cb29..2275a1da3 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > @@ -351,4 +351,25 @@ static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *f
> >  #define REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(fname) \
> >         require_fanotify_fan_report_fid_supported_on_fs(__FILE__, __LINE__, (fname))

> > +static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> > +{
> > +       int fd;
> > +       int rval = 0;
> > +
> > +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> > +
> > +       if (fanotify_mark(fd, FAN_MARK_ADD | flag, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
> > +               if (errno == EINVAL) {
> > +                       rval = -1;
> > +               } else {
> > +                       tst_brk(TBROK | TERRNO,
> > +                               "fanotify_mark (%d, FAN_MARK_ADD, ..., FAN_ACCESS_PERM, AT_FDCWD, \".\") failed", fd);
> > +               }

> You meant FAN_ACCESS.

> FAN_ACCESS_PERM requires CONFIG_FANOTIFY_ACCESS_PERMISSIONS which is not
> a requirement for most of the affected tests.
Thanks for explanation, I was thinking about it :).

> Patch set is super! it's the only issue I found, so I don't think you
> need to re-post for that.

Fixing this and Cyril notes in 04/10 and merging tonight.

Kind regards,
Petr

> Thanks,
> Amir.
