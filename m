From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 8 Jul 2020 10:06:21 +0800
Subject: [LTP] [PATCH] syscalls/ioctl09: Add test for BLKRRPART ioctl
In-Reply-To: <150668383.1091545.1594129246387.JavaMail.zimbra@redhat.com>
References: <1594016612-7975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <150668383.1091545.1594129246387.JavaMail.zimbra@redhat.com>
Message-ID: <1690c3ad-a7d4-fa18-db19-343e3e345f8c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan

Thanks for your review.
> 
> 
> ----- Original Message -----
> 
> Hi,
> 
>> +static void verify_ioctl(void)
>> +{
>> +	const char *const cmd_parted_old[] = {"parted", "-s", "test.img",
>> "mklabel", "msdos", "mkpart",
>> +						"primary", "ext4", "1M", "10M", NULL};
>> +	const char *const cmd_parted_new[] = {"parted", "-s", "test.img",
>> "mklabel", "msdos", "mkpart",
>> +						"primary", "ext4", "1M", "10M", "mkpart", "primary", "ext4", "10M",
>> "20M", NULL};
> 
> ^^ These (and other lines) goe way over 80 characters.
> 
OK.
>> +	struct loop_info loopinfo = {0};
>> +
>> +	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
>> +	if (dev_num < 0)
>> +		tst_brk(TBROK, "Failed to find free loop device");
>> +
>> +	tst_fill_file("test.img", 0, 1024 * 1024, 20);
> 
> 20MB feels a bit small, even though tests I ran passed on old and new kernels.
> LTP default is 256, to cover various filesystems, but here we don't even
> write anything..
In actually, ioctl_loop01 test case also uses 10M size and we only cover 
ext4 fileystem in here. I don't have objection about changing this size 
to 256M. Just reconfirm. If so, we should also modify ioctl_loop01 code.
> 
> Other than that, it looks good to me:
> Acked-by: Jan Stancek <jstancek@redhat.com>
> 
> 
> 


