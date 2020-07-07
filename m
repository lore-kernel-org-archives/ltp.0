From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Jul 2020 09:40:46 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/ioctl09: Add test for BLKRRPART ioctl
In-Reply-To: <1594016612-7975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1594016612-7975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <150668383.1091545.1594129246387.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----

Hi,

> +static void verify_ioctl(void)
> +{
> +	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
> "mklabel", "msdos", "mkpart",
> +						"primary", "ext4", "1M", "10M", NULL};
> +	const char *const cmd_parted_new[] = {"parted", "-s", "test.img",
> "mklabel", "msdos", "mkpart",
> +						"primary", "ext4", "1M", "10M", "mkpart", "primary", "ext4", "10M",
> "20M", NULL};

^^ These (and other lines) goe way over 80 characters.

> +	struct loop_info loopinfo = {0};
> +
> +	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
> +	if (dev_num < 0)
> +		tst_brk(TBROK, "Failed to find free loop device");
> +
> +	tst_fill_file("test.img", 0, 1024 * 1024, 20);

20MB feels a bit small, even though tests I ran passed on old and new kernels.
LTP default is 256, to cover various filesystems, but here we don't even
write anything..

Other than that, it looks good to me:
Acked-by: Jan Stancek <jstancek@redhat.com>

