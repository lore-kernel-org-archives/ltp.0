From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 19 Sep 2019 09:52:24 +0800
Subject: [LTP] [PATCH] crypto/af_alg05: add comment for a regression
In-Reply-To: <1568720356-29641-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1568720356-29641-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <86a6e3a5-9f17-f7e7-d14a-d60ccdd81ff2@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

This is a patch that I investigated af_alg05 crashes on 3.10.0-1062.el7.x86_64. As af_alg05 describe,
it crashes on some? architectures, such as arm and arm64. But on this kernel, it doesn't backport
commit 160544075f2 ("crypto: scatterwalk - Hide* PageSlab call to optimise away flush_dcache_page"),
so it doesn't have architectures restraint . Also this kernel doesn't support skcipher walk interface
(this interface replaces blkcipher walk and ablkcipher walk.), so this case will crash with blkcipher
walk on x86_64. as below:

IP: [<ffffffff8212d39c>] scatterwalk_done+0x4c/0x60
.....
[? 176.424393] Call Trace:
[? 176.425484]? [<ffffffff8213021e>] ? blkcipher_walk_done+0x21e/0x2b0
[? 176.426568]? [<ffffffff8213060c>] blkcipher_walk_next+0x35c/0x3d0
[? 176.427653]? [<ffffffff8213070a>] blkcipher_walk_first+0x8a/0x1a0
[? 176.428742]? [<ffffffff8213083f>] blkcipher_walk_virt+0x1f/0x30
[? 176.429824]? [<ffffffff8213d876>] crypto_cbc_decrypt+0x66/0x260
[? 176.430892]? [<ffffffff81e7c29f>] ? gup_pud_range+0x13f/0x2a0
[? 176.431968]? [<ffffffff8212f751>] async_decrypt+0x51/0x70
[? 176.433007]? [<ffffffff8212f751>] ? async_decrypt+0x51/0x70
[? 176.434076]? [<ffffffff82142849>] skcipher_recvmsg+0x3a9/0x400
[? 176.435112]? [<ffffffff8242c6ec>] sock_aio_read.part.9+0x14c/0x170
[? 176.436156]? [<ffffffff8242c731>] sock_aio_read+0x21/0x30
[? 176.437189]? [<ffffffff820482d3>] do_sync_read+0x93/0xe0
[? 176.438219]? [<ffffffff82048db5>] vfs_read+0x145/0x170
[? 176.439260]? [<ffffffff82049bcf>] SyS_read+0x7f/0xf0
[? 176.440287]? [<ffffffff8258aede>] system_call_fastpath+0x25/0x2a


Thanks
Yang Xu

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/crypto/af_alg05.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/testcases/kernel/crypto/af_alg05.c b/testcases/kernel/crypto/af_alg05.c
> index 419c65eab..964adffcc 100644
> --- a/testcases/kernel/crypto/af_alg05.c
> +++ b/testcases/kernel/crypto/af_alg05.c
> @@ -10,6 +10,12 @@
>    * block size, and where the destination buffer starts exactly at a page
>    * boundary.  Based on the reproducer from the commit message.  Note that this
>    * issue only reproduces on certain architectures, such as arm and arm64.
> + *
> + * On some older kernel without commit 160544075f2 ("crypto: scatterwalk - Hide
> + * PageSlab call to optimise away flush_dcache_page") , it doesn't use
> + * ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macro. It can crash on all architectures.
> + * Without skcipher walk interface, it is also a regresstion test for commit
> + * 0868def3e410("crypto: blkcipher - fix crash flushing dcache in error path").
>    */
>   
>   #include <errno.h>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190919/4ca763cd/attachment-0001.htm>
