From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 May 2021 11:23:22 +0200
Subject: [LTP] [PATCH v2] read02: Fix the failure of mips architecture
 test
In-Reply-To: <20210527053615.13254-1-zhanglianjie@uniontech.com>
References: <20210527053615.13254-1-zhanglianjie@uniontech.com>
Message-ID: <YK9lCnXHO2k810Sc@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> under mips architecture, writing to the buf of mmap PROT_NONE will
> report an error EPERM.

That is reallly strange as far as I can tell the first check that vfs_read()
does is:

ssize_t vfs_read(struct file *file, char __user *buf, size_t count, loff_t *pos)
{
        ssize_t ret;

        if (!(file->f_mode & FMODE_READ))
                return -EBADF;
        if (!(file->f_mode & FMODE_CAN_READ))
                return -EINVAL;
        if (unlikely(!access_ok(buf, count)))
                return -EFAULT;

...

Here for PROT_NONE the access_ok() will fail and we end up with EFAULT.

And the read syscall entry point calls ksys_read() which calls vfs_read() in a
case that the file descriptor is correct. So the only way how this can fail is
that you are not allowed to read from the file descriptor that the tests opens
for reading in the test setup() which should not happen. This looks more like a
kernel bug than anything else.

> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> 
> diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
> index 9199a95f6..650449e92 100644
> --- a/testcases/kernel/syscalls/read/read02.c
> +++ b/testcases/kernel/syscalls/read/read02.c
> @@ -52,7 +52,9 @@ static struct tcase {
>  } tcases[] = {
>  	{&badfd, &bufaddr, 1, EBADF},
>  	{&fd2, &bufaddr, 1, EISDIR},
> -#ifndef UCLINUX
> +#if defined(__mips)
> +	{&fd3, &outside_buf, 1, EPERM},
> +#elif !defined(UCLINUX)
>  	{&fd3, &outside_buf, 1, EFAULT},
>  #endif
>  	{&fd4, &addr4, 1, EINVAL},
> @@ -98,7 +100,7 @@ static void setup(void)
> 
>  	fd3 = SAFE_OPEN("test_file", O_RDWR);
> 
> -#if !defined(UCLINUX)
> +#if !defined(UCLINUX) || defined(__mips)
>  	outside_buf = SAFE_MMAP(0, 1, PROT_NONE,
>  				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  #endif

We do not support UCLINUX anymore so if anything the UCLINUX ifdefs should be removed first.

-- 
Cyril Hrubis
chrubis@suse.cz
