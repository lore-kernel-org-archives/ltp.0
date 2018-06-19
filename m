From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Jun 2018 13:21:48 +0530
Subject: [LTP] [PATCH] fcntl36: fix 32-bit sporadic failures
In-Reply-To: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
References: <8b5ddc69aae83b332b205dbeddb3284ab00f827e.1529082112.git.jstancek@redhat.com>
Message-ID: <CA+G9fYt1VpwXKj+Zahf39uHopUXxqYdW3BogB0HOATyuf4Bdww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 15 June 2018 at 22:52, Jan Stancek <jstancek@redhat.com> wrote:
> fcntl36 testcase has been observed to sporadically fail, when
> running 32-bit user-space on 64-bit kernel.
>
> Strace shows that region length is 0 for some commands:
>   fcntl64(6, F_SETLK, {l_type=F_UNLCK, l_whence=SEEK_SET, l_start=5120, l_len=0}
>
> This is because testcase is passing struct flock64, but
> command is F_SETLK, not F_SETLK64.
>
> So, kernel treats argument for POSIX command as 32-bit "struct flock":
>
>   static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
>   ...
>         case F_SETLK:
>         case F_SETLKW:
>                 err = get_compat_flock(&flock, compat_ptr(arg));
>                 ...
>
> in contrast to F_OFD_* commands, where argument  is treated
> as "struct flock64":
>         case F_SETLK64:
>         case F_SETLKW64:
>         case F_OFD_SETLK:
>         case F_OFD_SETLKW:
>                 err = get_compat_flock64(&flock, compat_ptr(arg));
>                 ...
>
> Switch argument of POSIX commands to 'struct flock' and leave it to
> glibc to pick correct syscall and command.
>
> I tested fcntl36 and fcntl36_64 on x86_64 kernel (as 64bit + 32bit binary)
> and i386 kernel by running 100 iterations.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

> ---
> No kernel bug, problem was found in my reproducer.
> Can anyone confirm this fixes 32-bit arm too?

This patch tested on arm32 Beagleboard x15 for 25 iterations and PASS.
Here you find test log before and after the patch.

Full test log,
https://lkft.validation.linaro.org/scheduler/job/290879#L3056

>
>  testcases/kernel/syscalls/fcntl/fcntl36.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
> index 3246d13892cd..81bd5a647e4c 100644
> --- a/testcases/kernel/syscalls/fcntl/fcntl36.c
> +++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
> @@ -127,7 +127,7 @@ static void *fn_posix_w(void *arg)
>         int fd = SAFE_OPEN(fname, O_RDWR);
>         long wt = pa->cnt;
>
> -       struct flock64 lck = {
> +       struct flock lck = {
>                 .l_whence = SEEK_SET,
>                 .l_start  = pa->offset,
>                 .l_len    = pa->length,
> @@ -227,7 +227,7 @@ static void *fn_posix_r(void *arg)
>         int i;
>         int fd = SAFE_OPEN(fname, O_RDWR);
>
> -       struct flock64 lck = {
> +       struct flock lck = {
>                 .l_whence = SEEK_SET,
>                 .l_start  = pa->offset,
>                 .l_len    = pa->length,
> --
> 1.8.3.1
>

Thanks for the patch !

Best regards
Naresh Kamboju
