From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 26 Apr 2021 16:07:21 +0100
Subject: [LTP] [PATCH v3 1/7] API: Add safe openat, printfat,
 readat and unlinkat
In-Reply-To: <CAEemH2dqcf+GRL3P5SZKmOxvdvzFN1O1Y6NXoxG_DJ7GGpQmOg@mail.gmail.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-2-rpalethorpe@suse.com>
 <CAEemH2dqcf+GRL3P5SZKmOxvdvzFN1O1Y6NXoxG_DJ7GGpQmOg@mail.gmail.com>
Message-ID: <87r1ixm6dy.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Mon, Apr 12, 2021 at 10:55 PM Richard Palethorpe <rpalethorpe@suse.com>
> wrote:
>
>> Add 'at' variants for a number of system calls and LTP SAFE API
>> functions. This avoids using sprintf everywhere to build paths.
>>
>> Also adds tst_decode_fd which allows us to retrieve the path for an FD
>> for debugging purposes without having to store it ourselves. However
>> the proc symlink may not be available on some systems.
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  include/tst_safe_file_ops.h |  39 ++++++++
>>  lib/tst_safe_file_ops.c     | 171 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 210 insertions(+)
>>  create mode 100644 lib/tst_safe_file_ops.c
>>
>> diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
>> index 223eddd1f..dff6a793c 100644
>> --- a/include/tst_safe_file_ops.h
>> +++ b/include/tst_safe_file_ops.h
>> @@ -57,4 +57,43 @@
>>  #define TST_MOUNT_OVERLAY() \
>>         (mount_overlay(__FILE__, __LINE__, 0) == 0)
>>
>> +#define SAFE_OPENAT(dirfd, path, oflags, ...)                  \
>> +       safe_openat(__FILE__, __LINE__,                         \
>> +                   (dirfd), (path), (oflags), ## __VA_ARGS__)
>> +
>> +#define SAFE_FILE_READAT(dirfd, path, buf, nbyte)                      \
>> +       safe_file_readat(__FILE__, __LINE__,                            \
>> +                        (dirfd), (path), (buf), (nbyte))
>> +
>> +
>> +#define SAFE_FILE_PRINTFAT(dirfd, path, fmt, ...)                      \
>> +       safe_file_printfat(__FILE__, __LINE__,                          \
>> +                          (dirfd), (path), (fmt), __VA_ARGS__)
>> +
>> +#define SAFE_UNLINKAT(dirfd, path, flags)                              \
>> +       safe_unlinkat(__FILE__, __LINE__, (dirfd), (path), (flags))
>> +
>>
>
> The above macros are suggested to leave in this "tst_safe_file_ops.h"
> file.

I think this is just for legacy reasons. To separate new and old API
function definitions. These *at functions will never be in the old API
though.

>
> But, the function prototypes below should be moved to "safe_file_ops_fn.h",
> because that purposely to separate macros and function in different places.
> (I remember I had commented this in V2, probably you were missing it:)
>

Probably the best thing to do is create tst_safe_file_at.{c,h} and move
these functions there. This would be more consistent with the new API.

I think I was trying to think of a better solution, but then forgot
about it.

>
>
>> +char *tst_decode_fd(int fd);
>> +
>> +int safe_openat(const char *file, const int lineno,
>> +               int dirfd, const char *path, int oflags, ...);
>> +
>> +ssize_t safe_file_readat(const char *file, const int lineno,
>> +                        int dirfd, const char *path, char *buf, size_t
>> nbyte);
>> +
>> +int tst_file_vprintfat(int dirfd, const char *path, const char *fmt,
>> va_list va);
>> +int tst_file_printfat(int dirfd, const char *path, const char *fmt, ...)
>> +                       __attribute__ ((format (printf, 3, 4)));
>> +
>> +int safe_file_vprintfat(const char *file, const int lineno,
>> +                       int dirfd, const char *path,
>> +                       const char *fmt, va_list va);
>> +
>> +int safe_file_printfat(const char *file, const int lineno,
>> +                      int dirfd, const char *path, const char *fmt, ...)
>> +                       __attribute__ ((format (printf, 5, 6)));
>> +
>> +int safe_unlinkat(const char *file, const int lineno,
>> +                 int dirfd, const char *path, int flags);
>
> +
>>  #endif /* TST_SAFE_FILE_OPS */
>>
>
>
>
>> diff --git a/lib/tst_safe_file_ops.c b/lib/tst_safe_file_ops.c
>> new file mode 100644
>> index 000000000..af4157476
>> --- /dev/null
>> +++ b/lib/tst_safe_file_ops.c
>>
>
> And, we'd better achieve all the functions in "lib/safe_file_ops.c"
> but not create a separate new C file.

This would mean they all have a useless argument for the old API.

-- 
Thank you,
Richard.
