From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Nov 2019 14:02:33 +0800
Subject: [LTP] [PATCH] lib: don't pass NULL to strcmp in safe_mount
In-Reply-To: <1a623a82dfac64c8a6f9805c197fa72cb5e6f046.1574159295.git.jstancek@redhat.com>
References: <1a623a82dfac64c8a6f9805c197fa72cb5e6f046.1574159295.git.jstancek@redhat.com>
Message-ID: <CAEemH2fiyODj=FedbVK8xtrgz1T3JWO5dBiSUbA1L24XOx2yqA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 19, 2019 at 6:29 PM Jan Stancek <jstancek@redhat.com> wrote:

> Rachel reports, that pivot_root01 crashes on latest LTP:
>   Thread 3.1 "pivot_root01" received signal SIGSEGV, Segmentation fault.
>   0x00000000004062c4 in safe_mount (file=file@entry=0x413017
> "pivot_root01.c"
>   733             if (strcmp(filesystemtype, "ntfs")) {
>
> Don't pass NULL ptr to strcmp. Also fix return in unreachable path,
> to suppress warning about returning uninitialized 'rval'.
>

Good catch.

And shouldn't we give a "correct" fs_type in pivot_root01.c too? Otherwise,
the test would be failed on an invalid mounted operation I guess.

--- a/testcases/kernel/syscalls/pivot_root/pivot_root01.c
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -107,7 +107,7 @@ static void run(unsigned int test_case)
         * Create an initial root dir. pivot_root doesn't work if the
initial root
         * dir is a initramfs, so use chroot to create a safe environment
         */
-       SAFE_MOUNT("none", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+       SAFE_MOUNT("none", "/", "none", MS_REC|MS_PRIVATE, NULL);
        SAFE_MOUNT("none", CHROOT_DIR, "tmpfs", 0, 0);
        SAFE_CHROOT(CHROOT_DIR);



>
> Fixes: ae52b6f41bf3 ("lib: Fix safe_mount() when mounting NTFS on kernels
> with NTFS support")
> Reported-by: Rachel Sibley <rasibley@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/safe_macros.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index c725c7d7763f..41fa4ca83004 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -730,7 +730,7 @@ int safe_mount(const char *file, const int lineno,
> void (*cleanup_fn)(void),
>          * Don't try using the kernel's NTFS driver when mounting NTFS,
> since
>          * the kernel's NTFS driver doesn't have proper write support.
>          */
> -       if (strcmp(filesystemtype, "ntfs")) {
> +       if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
>                 rval = mount(source, target, filesystemtype, mountflags,
> data);
>                 if (!rval)
>                         return 0;
> @@ -764,7 +764,7 @@ int safe_mount(const char *file, const int lineno,
> void (*cleanup_fn)(void),
>                          mountflags, data);
>         }
>
> -       return rval;
> +       return -1;
>  }
>
>  int safe_umount(const char *file, const int lineno, void
> (*cleanup_fn)(void),
> --
> 1.8.3.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191120/2741c6a6/attachment-0001.htm>
