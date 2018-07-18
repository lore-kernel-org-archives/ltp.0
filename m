From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 18 Jul 2018 14:46:38 +0200
Subject: [LTP] [PATCH] zram/zram_lib.sh: Check fielsystem support more
 throughly
In-Reply-To: <1531299325-27779-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1531299325-27779-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180718124638.GD7117@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +zram_check_fs_support()
> +{
> +	tst_check_cmds which modprobe
> +	local filesystem=$1
> +
> +	# Check if mkfs command supports fs
> +	which mkfs.$filesystem > /dev/null 2>&1 || return 1
> +
> +	# Check if kernel supports fs
> +	if ! grep -qw $filesystem /proc/filesystems; then

Actually grepping /proc/filesystems is not enough to figure out if
filesystem is supported or not, since for example ext2 and ext3 are
handled with ext4 these days.

But happily we do already have all the code in tst_supported_fs_types.c
in the test library, we all that is needed to to do is to create a C
helper on the top of tst_get_supported_fs_types() function that returns
array of supported filesystems. So we can write a small helper binary on
the top of that.

I would be for adding a tst_supported_fs binary into the testcases/lib/
that would, without any parameter print the list of supported
filesystems into the stdout. and if passed a fs type as a parameter
would use return value to indicate if the filesystem is supported or
not.

> +		modprobe $filesystem > /dev/null 2>&1 || return 1
> +	fi
> +}
> +
>  zram_makefs()
>  {
> -	tst_check_cmds mkfs which
> +	tst_check_cmds mkfs
>  	local i=0
>  	for fs in $zram_filesystems; do
>  		# if requested fs not supported default it to ext2
> -		which mkfs.$fs > /dev/null 2>&1 || fs=ext2
> +		zram_check_fs_support $fs || fs=ext2
>  
>  		tst_resm TINFO "make $fs filesystem on /dev/zram$i"
>  		mkfs.$fs /dev/zram$i > err.log 2>&1
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
