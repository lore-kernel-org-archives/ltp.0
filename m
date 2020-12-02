From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 2 Dec 2020 08:27:29 +0200
Subject: [LTP] [PATCH v5 06/10] fanotify: Add helper for mark support
 check
In-Reply-To: <20201201174214.24625-7-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-7-pvorel@suse.cz>
Message-ID: <CAOQ4uxg_Kwmx1K=om9aA6Sh=+L129=YpneDW1ZLP2sL96ELNgw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 1, 2020 at 7:42 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> i.e. FAN_MARK_FILESYSTEM and use it in relevant tests setup().
> The purpose is to reduce checks (cleanup).
>
> NOTE: all tests check only for FAN_MARK_FILESYSTEM, but keep helper
> generic for future use.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v5.
>
>  testcases/kernel/syscalls/fanotify/fanotify.h | 21 ++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify01.c     | 12 +++++----
>  .../kernel/syscalls/fanotify/fanotify03.c     | 25 +++++++++----------
>  .../kernel/syscalls/fanotify/fanotify10.c     | 14 +++++------
>  .../kernel/syscalls/fanotify/fanotify13.c     | 15 +++++------
>  5 files changed, 55 insertions(+), 32 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 821e6cb29..2275a1da3 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -351,4 +351,25 @@ static inline void require_fanotify_fan_report_fid_supported_on_fs(const char *f
>  #define REQUIRE_FANOTIFY_FAN_REPORT_FID_SUPPORTED_ON_FS(fname) \
>         require_fanotify_fan_report_fid_supported_on_fs(__FILE__, __LINE__, (fname))
>
> +static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> +{
> +       int fd;
> +       int rval = 0;
> +
> +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD | flag, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
> +               if (errno == EINVAL) {
> +                       rval = -1;
> +               } else {
> +                       tst_brk(TBROK | TERRNO,
> +                               "fanotify_mark (%d, FAN_MARK_ADD, ..., FAN_ACCESS_PERM, AT_FDCWD, \".\") failed", fd);
> +               }

You meant FAN_ACCESS.

FAN_ACCESS_PERM requires CONFIG_FANOTIFY_ACCESS_PERMISSIONS which is not
a requirement for most of the affected tests.

Patch set is super! it's the only issue I found, so I don't think you
need to re-post for that.

Thanks,
Amir.
