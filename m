From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 2 Aug 2018 08:29:24 -0400 (EDT)
Subject: [LTP] [PATCH 5/5] syscalls/flock06: Rewrite to new library
In-Reply-To: <1533182024-18841-5-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1533182024-18841-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1533182024-18841-5-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1649896669.37585897.1533212964490.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/flock/flock06.c | 213
>  ++++++++----------------------
>  1 file changed, 52 insertions(+), 161 deletions(-)

Hi,

> +	int fd1, fd2;
> +
> +	fd1 = SAFE_OPEN("testfile", O_RDWR);
> +	TEST(flock(fd1, LOCK_EX | LOCK_NB));
> +	if (TST_RET != 0)
> +		tst_res(TFAIL | TTERRNO, "First attempt to flock() failed");
> +	else
> +		tst_res(TPASS, "First attempt to flock() passed");
> +
> +	fd2 = SAFE_OPEN("testfile", O_RDWR);
> +	TEST(flock(fd2, LOCK_EX | LOCK_NB));
> +	if (TST_RET != 1)

This should be == -1
The rest looks good to me.

Regards,
Jan
