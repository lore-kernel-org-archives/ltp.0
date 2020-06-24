From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jun 2020 13:32:17 +0200
Subject: [LTP] [PATCH v3] syscalls/ioctl_loop05: Use correct blockdev to
 get logical_block_size
In-Reply-To: <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <660069492.15476972.1591794243308.JavaMail.zimbra@redhat.com>
 <1591853524-17011-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200624113217.GC30917@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void find_backing_bdpath(char *buf)
> +{
> +	const char *const df_cmd[] = {"df", "-T", ".", NULL};
> +	char line[PATH_MAX];
> +	FILE *file;
> +
> +	SAFE_CMD(df_cmd, "1.txt", NULL);
> +	file = SAFE_FOPEN("1.txt", "r");
> +
> +	while (fgets(line, sizeof(line), file) != NULL) {
> +		sscanf(line, "%s", buf);
> +		if (strstr(buf, "/dev/") != NULL)
> +			break;
> +	}
> +	SAFE_FCLOSE(file);
> +}

I do not like that we are calling df for something like this.

Looking at what that command does it's not that complex. It does
statfs() to get minor and major number, then scans /proc/self/mountinfo
for these, since these are on third column and then just prints whatever
it's in the 10th column. This isn't more complex that what we have here
and avoids needs to execute binaries and parse the output.

Also this function could be in a test library probably in tst_device.h.

>  static void setup(void)
>  {
> -	int fd;
> -	struct stat buf;
> +	char buf[100];
>  
>  	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
>  		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
> @@ -109,13 +126,6 @@ static void setup(void)
>  	sprintf(sys_loop_diopath, "/sys/block/loop%d/loop/dio", dev_num);
>  	tst_fill_file("test.img", 0, 1024, 1024);
>  
> -	fd = SAFE_OPEN("test.img", O_RDONLY);
> -	SAFE_FSTAT(fd, &buf);
> -	SAFE_CLOSE(fd);
> -
> -	logical_block_size = buf.st_blksize;
> -	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
> -
>  	tst_attach_device(dev_path, "test.img");
>  	attach_flag = 1;
>  	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
> @@ -130,13 +140,23 @@ static void setup(void)
>  	 *   size of loop is bigger than the backing device's and the loop
>  	 *   needn't transform transfer.
>  	 */
> -	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
> +	find_backing_bdpath(buf);
> +	block_devfd = SAFE_OPEN(buf, O_RDWR);
> +
> +	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
> +	tst_res(TINFO, "backing dev logical_block_size is %d", logical_block_size);
> +	SAFE_CLOSE(block_devfd);
> +
> +	if (logical_block_size > 512)
> +		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
>  }
>  
>  static void cleanup(void)
>  {
>  	if (dev_fd > 0)
>  		SAFE_CLOSE(dev_fd);
> +	if (block_devfd > 0)
> +		SAFE_CLOSE(block_devfd);
>  	if (attach_flag)
>  		tst_detach_device(dev_path);
>  }
> @@ -150,5 +170,9 @@ static struct tst_test test = {
>  	.needs_drivers = (const char *const []) {
>  		"loop",
>  		NULL
> +	},
> +	.needs_cmds = (const char *const []) {
> +		"df",
> +		NULL
>  	}
>  };
> -- 
> 2.23.0
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
