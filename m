From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 2 Jun 2020 12:53:04 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: set loop blksize to bdev
 blksize
In-Reply-To: <0e99163dd0deef5e3c0e7276533998e80a93d16e.1591016352.git.jstancek@redhat.com>
References: <0e99163dd0deef5e3c0e7276533998e80a93d16e.1591016352.git.jstancek@redhat.com>
Message-ID: <7d68e6dc-bd11-6ade-436f-f04989eed2a6@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan


> Test is failing on s390, where default loop blksize is less than
> backing dev's blksize (4096):
>    tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
>    tst_device.c:88: INFO: Found free device 0 '/dev/loop0'
>    ioctl_loop05.c:116: INFO: /dev/loop0 default logical_block_size is 512
>    ioctl_loop05.c:62: INFO: Without setting lo_offset or sizelimit
>    ioctl_loop05.c:63: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)
> 
After looking kernel code, I think removing BLKSSZGET ioctl is ok.
Also since kernel commit 85560117d00 ("loop: change queue block size to 
match when using DIO"), it will change logic block size automaticly when 
fd is opened with O_DIRECT. Can we use it?just a suggestion??
> Per kernel comment at __loop_update_dio(), direct io is supported
> when "logical block size of loop is bigger than the backing device's".
> 
> Set loop blksize to one of backing device. Retry is there to avoid
> EAGAIN warning "loop0 (test.img) has still dirty pages".
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   .../kernel/syscalls/ioctl/ioctl_loop05.c      | 21 +++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> index 6c9ea2802981..a969978239a5 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
> @@ -96,6 +96,9 @@ static void verify_ioctl_loop(void)
>   
>   static void setup(void)
>   {
> +	int fd;
> +	struct stat buf;
> +
>   	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
>   		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
>   
> @@ -105,6 +108,14 @@ static void setup(void)
>   
>   	sprintf(sys_loop_diopath, "/sys/block/loop%d/loop/dio", dev_num);
>   	tst_fill_file("test.img", 0, 1024, 1024);
> +
> +	fd = SAFE_OPEN("test.img", O_RDONLY);
> +	SAFE_FSTAT(fd, &buf);
> +	SAFE_CLOSE(fd);
> +
> +	logical_block_size = buf.st_blksize;
> +	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
> +
>   	tst_attach_device(dev_path, "test.img");
>   	attach_flag = 1;
>   	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
> @@ -112,8 +123,14 @@ static void setup(void)
>   	if (ioctl(dev_fd, LOOP_SET_DIRECT_IO, 0) && errno == EINVAL)
>   		tst_brk(TCONF, "LOOP_SET_DIRECT_IO is not supported");
>   
> -	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_block_size);
> -	tst_res(TINFO, "%s default logical_block_size is %d", dev_path, logical_block_size);
> +	/*
> +	 * from __loop_update_dio():
> +	 *   We support direct I/O only if lo_offset is aligned with the
> +	 *   logical I/O size of backing device, and the logical block
> +	 *   size of loop is bigger than the backing device's and the loop
> +	 *   needn't transform transfer.
> +	 */
> +	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
LOOP_SET_DIRECT_IO was introduce since 4.10 and  LOOP_SET_BLOCK_SIZE 
ioctl was introduced since kernel 4.14, I guess we should add a check 
for LOOP_SET_BLOCK_SIZE in here.

Best Regards
Yang Xu
>   }
>   
>   static void cleanup(void)
> 


