From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 5 Jun 2019 16:06:39 +0200
Subject: [LTP] [PATCH v3] syscalls/preadv2/preadv203: set mount_device
	flag
In-Reply-To: <20190605053312.17369-1-jencce.kernel@gmail.com>
References: <5CF750DF.9040006@cn.fujitsu.com>
 <20190605053312.17369-1-jencce.kernel@gmail.com>
Message-ID: <20190605140638.GA25618@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
> index 810d1e8db..e4f68a51b 100644
> --- a/testcases/kernel/syscalls/preadv2/preadv203.c
> +++ b/testcases/kernel/syscalls/preadv2/preadv203.c
> @@ -261,6 +261,7 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.test_all = verify_preadv2,
>  	.mntpoint = MNTPOINT,
> +	.mount_device = 1,
>  	.all_filesystems = 1,
>  	.needs_tmpdir = 1,
>  	.needs_root = 1,

What a silly mistake of mine, thanks for fixing that.

Unfortunately it seems that this breaks the test on a subset of
filesystems. For me it fails when files are written in the test setup,
guess that writing 1000 files with 66 blocks of size 4123 is about 236MB
is too much for the default 256MB loop device.

I will look into that and send a patch later on.

-- 
Cyril Hrubis
chrubis@suse.cz
