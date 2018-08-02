From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 07:12:51 -0400 (EDT)
Subject: [LTP] [PATCH 2/5] syscalls/flock02: Rewrite to new library
In-Reply-To: <1533182024-18841-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1533182024-18841-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1224365348.37572968.1533208371341.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>

ACK, one note below.

> +static void verify_flock(unsigned n)
> +{
> +	struct tcase *tc = &tcases[n];
>  
> +	fd = SAFE_OPEN("testfile", O_RDWR);
> +	TEST(flock(*tc->fd, tc->operation));
> +	if (TST_RET == 0) {
> +		tst_res(TFAIL | TTERRNO, "flock() succeeded unexpectedly");
> +		return;

You are not closing fd here, but we'll get many TFAILs before
we run out of open file descriptors. (no need to repost)

Regards,
Jan
