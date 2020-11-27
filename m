From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2020 16:22:33 +0200
Subject: [LTP] [PATCH v4 5/6] fanotify: Check FAN_REPORT_{FID,
 NAME} support
In-Reply-To: <20201126214121.6836-6-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
 <20201126214121.6836-6-pvorel@suse.cz>
Message-ID: <CAOQ4uxjKjDxUgJQFYn8QcHATziLHDpQxkn7FtExuW1DeyBC9+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 26, 2020 at 11:41 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> in safe_fanotify_init()
>
> That require to move the definition after flags.
>
> Also use tst_res_()/tst_brk_() instead of tst_res()/tst_brk() in
> safe_fanotify_init() (synchronize with safe_fanotify_mark()).
>
> Make use of this simplification in fanotify15.c.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v3->v4:
> * use tst_res_() and tst_brk_() for safe_*() functions
>
>  testcases/kernel/syscalls/fanotify/fanotify.h | 64 +++++++++++--------
>  .../kernel/syscalls/fanotify/fanotify01.c     | 13 +---
>  .../kernel/syscalls/fanotify/fanotify13.c     | 12 +---
>  .../kernel/syscalls/fanotify/fanotify15.c     |  9 +--
>  4 files changed, 41 insertions(+), 57 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 2a5280636..4b725f334 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -38,32 +38,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
>
>  #endif /* HAVE_SYS_FANOTIFY_H */
>
> -int safe_fanotify_init(const char *file, const int lineno,
> -       unsigned int flags, unsigned int event_f_flags)
> -{
> -       int rval;
> -
> -#ifdef HAVE_SYS_FANOTIFY_H
> -       rval = fanotify_init(flags, event_f_flags);
> -
> -       if (rval == -1) {
> -               if (errno == ENOSYS) {
> -                       tst_brk(TCONF,
> -                               "fanotify is not configured in this kernel.");
> -               }
> -               tst_brk(TBROK | TERRNO,
> -                       "%s:%d: fanotify_init() failed", file, lineno);
> -       }
> -#else
> -       tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
> -#endif /* HAVE_SYS_FANOTIFY_H */
> -
> -       return rval;
> -}
> -
> -#define SAFE_FANOTIFY_INIT(fan, mode)  \
> -       safe_fanotify_init(__FILE__, __LINE__, (fan), (mode))
> -
>  #ifndef FAN_REPORT_TID
>  #define FAN_REPORT_TID         0x00000100
>  #endif
> @@ -190,6 +164,44 @@ struct fanotify_event_info_fid {
>  #define MAX_HANDLE_SZ          128
>  #endif
>
> +int safe_fanotify_init(const char *file, const int lineno,
> +       unsigned int flags, unsigned int event_f_flags)
> +{
> +       int rval;
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +       rval = fanotify_init(flags, event_f_flags);
> +
> +       if (rval == -1) {
> +               if (errno == ENOSYS) {
> +                       tst_brk_(file, lineno, TCONF,
> +                                "fanotify not configured in kernel");
> +               }
> +
> +               if (errno == EINVAL) {
> +                       if (flags & FAN_REPORT_FID) {
> +                               tst_brk_(file, lineno, TCONF,
> +                                        "FAN_REPORT_FID not supported in kernel?");
> +                       }

Unless I am missing something, this would make
fanotify_fan_report_fid_supported_on_fs()
break on old kernel in the start of fanotify01. That was not the intention...

The FAN_REPORT_FID test case in fanotify01 should be skipped if either
kernel has no support for FAN_REPORT_FID (checked on fanotify_init) or
filesystem has no support for  FAN_REPORT_FID (checked on fanotify_mark).

I guess you can leave SAFE_FANOTIFY_INIT as is and change the helper
fanotify_fan_report_fid_supported() to return a different value for
unsupported by kernel
and unsupported by fs and then pass that value of
fan_report_fid_unsupported to another
helper to decide if test case should be skipped and print the proper
TCONF message.

> +
> +                       if (flags & FAN_REPORT_NAME) {
> +                               tst_brk_(file, lineno, TCONF,
> +                                        "FAN_REPORT_NAME not supported in kernel?");
> +                       }

This check should be before the check for FAN_REPORT_FID, because
a kernel that does not support FAN_REPORT_FID also does not support
FAN_REPORT_NAME, but not the other way around.

I think that also solves the problem you mentioned in the cover letter
about fanotify16, but if not you can leave that problem to me.

Thanks,
Amir.
