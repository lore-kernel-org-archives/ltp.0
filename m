From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 5 Jun 2019 13:19:27 +0800
Subject: [LTP] [PATCH v2] syscalls/preadv2/preadv203: set mount_device
	flag
In-Reply-To: <20190605044215.19448-1-jencce.kernel@gmail.com>
References: <20190604082331.uunxtzshdgcnv4xg@XZHOUW.usersys.redhat.com>
 <20190605044215.19448-1-jencce.kernel@gmail.com>
Message-ID: <5CF750DF.9040006@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/06/05 12:42, Murphy Zhou wrote:
> Now the tests are running in MOUNTPOINT without it mounted.
> Fails on ext2:
Hi Murphy,

Did you get EOPNOTSUPP when running preadv203 on ext2?

It seems OK to running preadv203 on ext2, as below:
--------------------------------------------------------
tst_test.c:1172: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
preadv203.c:145: INFO: Number of full_reads 751044, short reads 10, zero
len reads 0, EAGAIN(s) 67021
preadv203.c:180: INFO: Number of writes 1087560
preadv203.c:194: INFO: Cache dropped 149 times
preadv203.c:223: PASS: Got some EAGAIN
-------------------------------------------------------

BTW: I got EOPNOTSUPP when running preadv203 on tmpfs. :-)

Best Regards,
Xiao Yang
>     preadv203.c does not set mount_device, which makes BROK:
>       preadv203.c:122: BROK: preadv2() failed: EOPNOTSUPP
>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  testcases/kernel/syscalls/preadv2/preadv203.c | 1 +
>  1 file changed, 1 insertion(+)
>
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



