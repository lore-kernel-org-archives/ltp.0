From: Zirong Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 08:33:38 -0500 (EST)
Subject: [LTP] [PATCH 1/2] tst_mkfs: add new parameter extra_opts to
 tst_mkfs function
In-Reply-To: <1457600856-29034-1-git-send-email-zlang@redhat.com>
References: <1457600856-29034-1-git-send-email-zlang@redhat.com>
Message-ID: <2089489928.28181709.1457616818204.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- 原始邮件 -----
> 发件人: "Zorro Lang" <zlang@redhat.com>
> 收件人: ltp@lists.linux.it
> 抄送: chrubis@suse.cz, "Zorro Lang" <zlang@redhat.com>
> 发送时间: 星期四, 2016年 3 月 10日 下午 5:07:35
> 主题: [PATCH 1/2] tst_mkfs: add new parameter extra_opts to tst_mkfs function
> 
> mmap16 always hit ETIMEDOUT error, if the test device is too large.
> mkfs on the device will take lots of time. So I want to make ext4
> with an appointed size. But the [fs_size] need behind the device
> name, e.g. "mkfs -t ext4 dev [fs_size]".
> 
> Due to above reason, add a new parameter extra_opts to tst_mkfs.
> extra_opts store the options need to behind the device name of mkfs.
> Then mmap16 can make ext4 with an appointed (small) size.
> 
> Because of tst_mkfs be changed, all testcases which use tst_mkfs add
> NULL parameter for extra_opts.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi Cyril,
> 
> As we talked, I make this V3 patch for mmap16 ETIMEDOUT problem. This
> patch follow your suggestion, and I have tested it simply.
> 
> Thanks,
> Zorro
> 
>  doc/test-writing-guidelines.txt                    | 10 ++++++--
>  include/test.h                                     |  6 +++--
>  lib/tests/tst_device.c                             |  2 +-
>  lib/tst_mkfs.c                                     | 30
>  +++++++++++++++++++---
>  testcases/kernel/io/direct_io/dma_thread_diotest.c |  2 +-
>  testcases/kernel/syscalls/access/access06.c        |  2 +-
>  testcases/kernel/syscalls/acct/acct01.c            |  2 +-
>  testcases/kernel/syscalls/chmod/chmod06.c          |  2 +-
>  testcases/kernel/syscalls/chown/chown04.c          |  2 +-
>  testcases/kernel/syscalls/creat/creat06.c          |  2 +-
>  testcases/kernel/syscalls/fchmod/fchmod06.c        |  2 +-
>  testcases/kernel/syscalls/fchown/fchown04.c        |  2 +-
>  testcases/kernel/syscalls/ftruncate/ftruncate04.c  |  2 +-
>  testcases/kernel/syscalls/inotify/inotify03.c      |  2 +-
>  testcases/kernel/syscalls/lchown/lchown03.c        |  2 +-
>  testcases/kernel/syscalls/link/link08.c            |  2 +-
>  testcases/kernel/syscalls/linkat/linkat02.c        |  2 +-
>  testcases/kernel/syscalls/mkdir/mkdir03.c          |  2 +-
>  testcases/kernel/syscalls/mkdirat/mkdirat02.c      |  2 +-
>  testcases/kernel/syscalls/mknod/mknod07.c          |  2 +-
>  testcases/kernel/syscalls/mknodat/mknodat02.c      |  2 +-
>  testcases/kernel/syscalls/mmap/mmap16.c            |  2 +-
>  testcases/kernel/syscalls/mount/mount01.c          |  2 +-
>  testcases/kernel/syscalls/mount/mount02.c          |  2 +-
>  testcases/kernel/syscalls/mount/mount03.c          |  2 +-
>  testcases/kernel/syscalls/mount/mount04.c          |  2 +-
>  testcases/kernel/syscalls/mount/mount05.c          |  2 +-
>  testcases/kernel/syscalls/mount/mount06.c          |  2 +-
>  testcases/kernel/syscalls/open/open12.c            |  2 +-
>  testcases/kernel/syscalls/quotactl/quotactl02.c    |  2 +-
>  testcases/kernel/syscalls/rename/rename11.c        |  2 +-
>  testcases/kernel/syscalls/renameat/renameat01.c    |  2 +-
>  testcases/kernel/syscalls/rmdir/rmdir02.c          |  2 +-
>  testcases/kernel/syscalls/umount/umount01.c        |  2 +-
>  testcases/kernel/syscalls/umount/umount02.c        |  2 +-
>  testcases/kernel/syscalls/umount/umount03.c        |  2 +-
>  testcases/kernel/syscalls/umount2/umount2_01.c     |  2 +-
>  testcases/kernel/syscalls/umount2/umount2_02.c     |  2 +-
>  testcases/kernel/syscalls/umount2/umount2_03.c     |  2 +-
>  testcases/kernel/syscalls/utime/utime06.c          |  2 +-
>  testcases/kernel/syscalls/utimes/utimes01.c        |  2 +-
>  41 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 1f260cb..e9c56c8 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -906,15 +906,21 @@ NOTE: The default filesytem is hardcoded to 'ext2' in
> the sources and can be
>  #include "test.h"
>  
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -              const char *fs_type, const char *const fs_opts[]);
> +              const char *fs_type, const char *const fs_opts[]
> +              const char *extra_opts);
>  -------------------------------------------------------------------------------
>  
>  This function takes a path to a device, filesystem type and an array of
>  extra
>  options passed to mkfs.
>  
> -The extra options 'fs_opts' should either be 'NULL' if there are none, or a
> +The fs options 'fs_opts' should either be 'NULL' if there are none, or a
>  'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
>  
> +The extra options 'extra_opts' should either be 'NULL' if there are none, or
> +a string such as "102400". 'extra_opts' will be used behind device name.
> e.g:
> +mkfs -t ext4 -b 1024 /dev/sda1 102400
> +                               ^^^^^^
> +
>  2.2.16 Verifying a filesystem's free space
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/include/test.h b/include/test.h
> index 5c78b1d..211ffb6 100644
> --- a/include/test.h
> +++ b/include/test.h
> @@ -316,10 +316,12 @@ int tst_system(const char *command);
>   *
>   * @dev: path to a device
>   * @fs_type: filesystem type
> - * @fs_opts: NULL or NULL terminated array of extra mkfs options
> + * @fs_opts: NULL or NULL terminated array of mkfs options
> + * @extra_opts: extranal mkfs options which need to behind the device name
>   */
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -	      const char *fs_type, const char *const fs_opts[]);
> +              const char *fs_type, const char *const fs_opts[],
> +              const char *extra_opts);
>  
>  /*
>   * Returns filesystem type to be used for the testing. Unless your test is
> diff --git a/lib/tests/tst_device.c b/lib/tests/tst_device.c
> index 6a7925e..525bdc0 100644
> --- a/lib/tests/tst_device.c
> +++ b/lib/tests/tst_device.c
> @@ -46,7 +46,7 @@ int main(void)
>  
>  	printf("Test device='%s'\n", dev);
>  
> -	tst_mkfs(cleanup, dev, "ext2", NULL);
> +	tst_mkfs(cleanup, dev, "ext2", NULL, NULL);
>  
>  	cleanup();
>  	tst_exit();
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 5f959a4..7b02578 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -21,12 +21,24 @@
>  
>  #define OPTS_MAX 32
>  
> +/*
> + * tst_mkfs: mkfs.$fs_type on $dev with options $fs_opts and $extra_opts
> + *     cleanup_fn - run it when exit with error.
> + *     dev        - device path name
> + *     fs_opts    - store the options for mkfs (except -t fs_type). Set
> + *                  NULL if don't need options.
> + *     extra_opts - extranal mkfs options for mkfs, these options need
> + *                  behind the device name, e.g. [fs_size] for ext4.
> + *                  Set NULL, if don't need options behind device name.
> + */
>  void tst_mkfs(void (cleanup_fn)(void), const char *dev,
> -	      const char *fs_type, const char *const fs_opts[])
> +              const char *fs_type, const char *const fs_opts[],
> +              const char *extra_opts)
>  {
>  	int i, pos = 3;
>  	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
>  	char fs_opts_str[1024] = "";
> +	const char *fs_extra_opts = extra_opts;
>  
>  	if (!fs_type)
>  		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
> @@ -68,10 +80,22 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>  	}
>  
>  	argv[pos++] = dev;
> +
> +	if (fs_extra_opts) {
> +		argv[pos++] = extra_opts;
> +
> +		if (pos + 1 > OPTS_MAX) {
> +			tst_brkm(TBROK, cleanup_fn,
> +			         "Too much mkfs options");
> +		}
> +	} else {
> +		fs_extra_opts = "None";
> +	}
> +
>  	argv[pos] = NULL;
>  
> -	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
> -		 dev, fs_type, fs_opts_str);
> +	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
> +	         dev, fs_type, fs_opts_str, fs_extra_opts);
>  	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
>  }
>  
<skip>
>  
> diff --git a/testcases/kernel/syscalls/mmap/mmap16.c
> b/testcases/kernel/syscalls/mmap/mmap16.c
> index c5828ea..2eb10a0 100644
> --- a/testcases/kernel/syscalls/mmap/mmap16.c
> +++ b/testcases/kernel/syscalls/mmap/mmap16.c
> @@ -158,7 +158,7 @@ static void setup(void)
>  	device = tst_acquire_device(cleanup);
>  	if (!device)
>  		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> -	tst_mkfs(cleanup, device, fs_type, fs_opts);
> +	tst_mkfs(cleanup, device, fs_type, fs_opts, "102400");

Sorry, the 100M size is bigger than the default ltp loop device(if no -b option
used). I will change this size to smaller and send another version patch.

Thanks,
Zorro
