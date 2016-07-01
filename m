From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 1 Jul 2016 07:32:07 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mount03: Don't read() with an invalid
 buffer	argument
In-Reply-To: <1467280046-19191-1-git-send-email-peter.maydell@linaro.org>
References: <1467280046-19191-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <225204264.1418846.1467372727590.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: ltp@lists.linux.it
> Cc: patches@linaro.org
> Sent: Thursday, 30 June, 2016 11:47:26 AM
> Subject: [LTP] [PATCH] syscalls/mount03: Don't read() with an invalid buffer	argument
> 
> The syscall test mount03 includes a code path to test the MS_NOATIME
> mount flag. This code checks that an attempted read of a file
> does not update the atime, but the read() it uses is passed
> a NULL buffer pointer, which isn't valid. The test passes on the
> kernel because the kernel happens to check for "is this file at
> EOF?" before "is the buffer argument valid?", and so it returns 0
> rather than -1/EFAULT. However the test fails when run under QEMU,
> because QEMU checks for a valid buffer before EOF.
> 
> POSIX and the Linux documentation make no guarantees about what order
> error cases are checked in; pass in a valid buffer so that we aren't
> relying on incidental behaviour of the implementation of read
> in a test for a different syscall.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Pushed.

> ---
> This is my first LTP patch, so please let me know if I got
> anything wrong stylistically or submission-wise...
> 
> This test also has a bug in its error handling code paths:
> if for instance this read() fails then we return from
> test_rwflag() without doing a close() on the filedescriptor.
> This then causes the umount() performed by tst_release_device()
> to fail with EBUSY, and then the loopback device is left
> mounted. Later, other test cases that try to use the loopback
> device then fail unnecessarily. I'm not sure what the best
> way to fix this is -- just call close() in all the error
> handling paths, or is there some kind of automatic cleanup
> on failure arrangement that could be used? In any case,
> that's a matter for a different patch I think.

Yes, a separate patch would be preffered. cleanup() will get
called at the end of test, but since fd is local variable
I think we are left only with close() in error paths.

Thanks,
Jan

> 
>  testcases/kernel/syscalls/mount/mount03.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/mount/mount03.c
> b/testcases/kernel/syscalls/mount/mount03.c
> index 1568c50..1873f0f 100644
> --- a/testcases/kernel/syscalls/mount/mount03.c
> +++ b/testcases/kernel/syscalls/mount/mount03.c
> @@ -132,6 +132,7 @@ int test_rwflag(int i, int cnt)
>  	time_t atime;
>  	struct passwd *ltpuser;
>  	struct stat file_stat;
> +	char readbuf[20];
>  
>  	switch (i) {
>  	case 0:
> @@ -319,7 +320,7 @@ int test_rwflag(int i, int cnt)
>  
>  		sleep(1);
>  
> -		if (read(fd, NULL, 20) == -1) {
> +		if (read(fd, readbuf, sizeof(readbuf)) == -1) {
>  			tst_resm(TWARN | TERRNO, "read %s failed", file);
>  			return 1;
>  		}
> --
> 1.9.1
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
