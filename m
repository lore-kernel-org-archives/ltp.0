From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Nov 2020 21:08:37 +0200
Subject: [LTP] [PATCH v2 3/5] fanotify: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <20201113155123.5959-4-pvorel@suse.cz>
References: <20201113155123.5959-1-pvorel@suse.cz>
 <20201113155123.5959-4-pvorel@suse.cz>
Message-ID: <CAOQ4uxgrLSPcoTHY_yjr7XbUDpzQ4-O7sadiNzG0mB6Qx2D=Lg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Nov 13, 2020 at 5:51 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> and function and use it in all tests which use fanotify_mark().
>
> Motivation was not only to simplify the code but also check for
> unsupported filesystems which was missing least for exfat on fanotify16,
> because filesystem can be set via LTP_DEV_FS_TYPE environment variable
> on tests which don't tests all filesystems.
>
> Previous commit added check for FAN_ACCESS_PERM enablement (caused by
> disabled CONFIG_FANOTIFY_ACCESS_PERMISSIONS) or FAN_OPEN_EXEC and
> FAN_OPEN_EXEC_PERM support in kernel, which are tested in setup
> functions for relevant tests, thus only FAN_MARK_FILESYSTEM is needed to
> check in safe_fanotify_mark().

So previous commit should have removed the check for exec event support
on failure instead of including this change in this commit.
IOW, the paragraph above should not have been needed.

>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi Amir,
>
> to be honest, I'm not sure if it's worth to remove
> FAN_ACCESS_PERM (CONFIG_FANOTIFY_ACCESS_PERMISSIONS) check from
> safe_fanotify_mark(). The downside of
> fanotify_access_permissions_supported_by_kernel() is that you have to
> remember to add it to the relevant test.

It's a problem.
If anotify_mark() has FAN_MARK_FILESYSTEM in flags and
FAN_ACCESS_PERM and FAN_OPEN_EXEC in mask you
cannot know what the reason of failure was, but see suggestion below.

>
> Kind regards,
> Petr
>
>  testcases/kernel/syscalls/fanotify/fanotify.h | 37 ++++++++++++-
>  .../kernel/syscalls/fanotify/fanotify01.c     | 53 ++++---------------
>  .../kernel/syscalls/fanotify/fanotify02.c     | 22 ++------
>  .../kernel/syscalls/fanotify/fanotify03.c     | 18 +------
>  .../kernel/syscalls/fanotify/fanotify04.c     | 32 +++--------
>  .../kernel/syscalls/fanotify/fanotify05.c     |  9 +---
>  .../kernel/syscalls/fanotify/fanotify06.c     | 21 ++------
>  .../kernel/syscalls/fanotify/fanotify07.c     | 15 +-----
>  .../kernel/syscalls/fanotify/fanotify09.c     | 19 ++-----
>  .../kernel/syscalls/fanotify/fanotify10.c     | 36 ++-----------
>  .../kernel/syscalls/fanotify/fanotify11.c     |  5 +-
>  .../kernel/syscalls/fanotify/fanotify12.c     | 24 ++-------
>  .../kernel/syscalls/fanotify/fanotify13.c     | 33 ++----------
>  .../kernel/syscalls/fanotify/fanotify15.c     | 24 ++-------
>  .../kernel/syscalls/fanotify/fanotify16.c     | 20 ++-----
>  15 files changed, 90 insertions(+), 278 deletions(-)

I like that diffstat :-)

>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 0c61f8ab7..8452f983a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -60,9 +60,13 @@ int safe_fanotify_init(const char *file, const int lineno,
>
>         return rval;
>  }
> +
>  #define SAFE_FANOTIFY_INIT(fan, mode)  \
>         safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
>
> +#define SAFE_FANOTIFY_MARK(fd, flags, mask, dfd, pathname)  \
> +       safe_fanotify_mark(__FILE__, __LINE__, (fd), (flags), (mask), (dfd), (pathname))
> +
>  #ifndef FAN_REPORT_TID
>  #define FAN_REPORT_TID         0x00000100
>  #endif
> @@ -242,7 +246,6 @@ static inline void fanotify_save_fid(const char *path,
>  #define INIT_FANOTIFY_MARK_TYPE(t) \
>         { FAN_MARK_ ## t, "FAN_MARK_" #t }
>
> -
>  static inline void fanotify_access_permissions_supported_by_kernel(void)
>  {
>         int fd;
> @@ -289,4 +292,36 @@ static inline int fanotify_exec_events_supported_by_kernel(uint64_t mask,
>  #define FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(mask) \
>         fanotify_exec_events_supported_by_kernel(mask, #mask)
>
> +static inline int safe_fanotify_mark(const char *file, const int lineno,
> +                       int fd, unsigned int flags, uint64_t mask,
> +                       int dfd, const char *pathname)
> +{
> +       int rval;
> +
> +       rval = fanotify_mark(fd, flags, mask, dfd, pathname);
> +
> +       if (rval == -1) {
> +               if (errno == ENODEV || errno == EOPNOTSUPP || errno == EXDEV)
> +                       tst_brk(TCONF,
> +                               "%s:%d: FAN_REPORT_FID not supported on %s filesystem",

It would be better to check that flags actually have FAN_REPORT_FID
before emitting this error




> +                               file, lineno, tst_device->fs_type);
> +
> +               if (errno == EINVAL && (flags & FAN_MARK_FILESYSTEM) == FAN_MARK_FILESYSTEM) {
> +                               tst_brk(TCONF,
> +                                       "%s:%d: FAN_MARK_FILESYSTEM not supported by kernel?",
> +                                       file, lineno);
> +               }
> +

I find it weird to give the wrong hint, if there could be more than one
reason for EINVAL, but if you like you could give all the hints, i.e.:
  "FAN_MARK_FILESYSTEM not supported by kernel?"
and
  "permission events not supported by kernel?"
per every possible reason found in flags and mask.

You could also make the support_exec_events variable from fanotify03
global, which fanotify_exec_events_supported_by_kernel() will set
and work that knowledge into safe_fanotify_mark(). You could do
the same with fanotify_access_permissions_supported_by_kernel().

So in case test setup() does have those checks, there will be no
wrong hints in safe_fanotify_mark().

Thanks,
Amir.
