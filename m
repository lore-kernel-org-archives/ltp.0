From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Apr 2021 14:59:59 +0800
Subject: [LTP] [PATCH v3 1/7] API: Add safe openat, printfat,
 readat and unlinkat
In-Reply-To: <20210412145506.26894-2-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-2-rpalethorpe@suse.com>
Message-ID: <CAEemH2dqcf+GRL3P5SZKmOxvdvzFN1O1Y6NXoxG_DJ7GGpQmOg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

On Mon, Apr 12, 2021 at 10:55 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Add 'at' variants for a number of system calls and LTP SAFE API
> functions. This avoids using sprintf everywhere to build paths.
>
> Also adds tst_decode_fd which allows us to retrieve the path for an FD
> for debugging purposes without having to store it ourselves. However
> the proc symlink may not be available on some systems.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  include/tst_safe_file_ops.h |  39 ++++++++
>  lib/tst_safe_file_ops.c     | 171 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 210 insertions(+)
>  create mode 100644 lib/tst_safe_file_ops.c
>
> diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
> index 223eddd1f..dff6a793c 100644
> --- a/include/tst_safe_file_ops.h
> +++ b/include/tst_safe_file_ops.h
> @@ -57,4 +57,43 @@
>  #define TST_MOUNT_OVERLAY() \
>         (mount_overlay(__FILE__, __LINE__, 0) == 0)
>
> +#define SAFE_OPENAT(dirfd, path, oflags, ...)                  \
> +       safe_openat(__FILE__, __LINE__,                         \
> +                   (dirfd), (path), (oflags), ## __VA_ARGS__)
> +
> +#define SAFE_FILE_READAT(dirfd, path, buf, nbyte)                      \
> +       safe_file_readat(__FILE__, __LINE__,                            \
> +                        (dirfd), (path), (buf), (nbyte))
> +
> +
> +#define SAFE_FILE_PRINTFAT(dirfd, path, fmt, ...)                      \
> +       safe_file_printfat(__FILE__, __LINE__,                          \
> +                          (dirfd), (path), (fmt), __VA_ARGS__)
> +
> +#define SAFE_UNLINKAT(dirfd, path, flags)                              \
> +       safe_unlinkat(__FILE__, __LINE__, (dirfd), (path), (flags))
> +
>

The above macros are suggested to leave in this "tst_safe_file_ops.h" file.

But, the function prototypes below should be moved to "safe_file_ops_fn.h",
because that purposely to separate macros and function in different places.
(I remember I had commented this in V2, probably you were missing it:)



> +char *tst_decode_fd(int fd);
> +
> +int safe_openat(const char *file, const int lineno,
> +               int dirfd, const char *path, int oflags, ...);
> +
> +ssize_t safe_file_readat(const char *file, const int lineno,
> +                        int dirfd, const char *path, char *buf, size_t
> nbyte);
> +
> +int tst_file_vprintfat(int dirfd, const char *path, const char *fmt,
> va_list va);
> +int tst_file_printfat(int dirfd, const char *path, const char *fmt, ...)
> +                       __attribute__ ((format (printf, 3, 4)));
> +
> +int safe_file_vprintfat(const char *file, const int lineno,
> +                       int dirfd, const char *path,
> +                       const char *fmt, va_list va);
> +
> +int safe_file_printfat(const char *file, const int lineno,
> +                      int dirfd, const char *path, const char *fmt, ...)
> +                       __attribute__ ((format (printf, 5, 6)));
> +
> +int safe_unlinkat(const char *file, const int lineno,
> +                 int dirfd, const char *path, int flags);

+
>  #endif /* TST_SAFE_FILE_OPS */
>



> diff --git a/lib/tst_safe_file_ops.c b/lib/tst_safe_file_ops.c
> new file mode 100644
> index 000000000..af4157476
> --- /dev/null
> +++ b/lib/tst_safe_file_ops.c
>

And, we'd better achieve all the functions in "lib/safe_file_ops.c"
but not create a separate new C file.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210416/8b6ad04b/attachment.htm>
