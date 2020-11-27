From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2020 15:47:11 +0200
Subject: [LTP] [PATCH v4 3/6] fanotify: Check for FAN_REPORT_FID support
 on fs
In-Reply-To: <20201126214121.6836-4-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
 <20201126214121.6836-4-pvorel@suse.cz>
Message-ID: <CAOQ4uxh8yb+GRc2cN=MNcgBu8KZO=NPzmO9tSMkgRAvbUCXjZg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 26, 2020 at 11:41 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> This is related to kernel fix
> a8b13aa20afb ("fanotify: enable FAN_REPORT_FID init flag")
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Just a minor nit below.
you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

As far as I am concerned, you do not need to re-post for the nits
if Cyril is going to fix my nit on merge (or even if he doesn't)

> ---
> New in v4.
> Maybe it'd deserve better commit message.
>
> There might be even more cleanup: not sure if nofid_fd in fanotify13.c
> is required. According to the description is probably required:

You're right, It is required.

>
> static void do_setup(void)
> {
>         require_fanotify_fan_report_fid_supported_on_fs(MOUNT_PATH);
>
>         nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
>
>         /* Create file and directory objects for testing */
>         create_objects();
>
>         /*
>          * Create a mark on first inode without FAN_REPORT_FID, to test
>          * uninitialized connector->fsid cache. This mark remains for all test
>          * cases and is not expected to get any events (no writes in this test).
>          */
>         SAFE_FANOTIFY_MARK(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
>                           FILE_PATH_ONE);
>
>         /* Get the filesystem fsid and file handle for each created object */
>         get_object_stats();
>
>  testcases/kernel/syscalls/fanotify/fanotify.h | 31 +++++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify01.c     |  9 +++++-
>  .../kernel/syscalls/fanotify/fanotify13.c     |  4 ++-
>  .../kernel/syscalls/fanotify/fanotify15.c     |  6 ++--
>  .../kernel/syscalls/fanotify/fanotify16.c     |  6 +---
>  5 files changed, 45 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index 413034336..c690b82d3 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -283,4 +283,35 @@ static inline int fanotify_exec_events_supported_by_kernel(uint64_t mask)
>         return rval;
>  }
>
> +static inline int fanotify_fan_report_fid_supported_on_fs(const char *fname)
> +{
> +       int fd;
> +       int rval = 0;
> +
> +       fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +                         FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
> +                         AT_FDCWD, fname) < 0) {

All those flags are not really needed for the test.
This minimal arg list would have been enough:

fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS, AT_FDCWD, fname)

Thanks,
Amir.
