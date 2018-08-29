From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Aug 2018 08:44:06 -0400 (EDT)
Subject: [LTP] [PATCH 4/4] syscalls/mlock202: Add new testcase
In-Reply-To: <1534844339-8655-4-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1534844339-8655-4-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1782237279.43470847.1535546646343.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Check various errnos for mlock2(2) since kernel v2.6.9.

mlock2() is available since Linux 4.4.

> +static struct tcase {
> +	char **taddr;
> +	int flag;
> +	unsigned long *max_size;
> +	/* 1: nobody expected  0: root expected */
> +	int exp_user;

I'd drop the "expected" prefix here, this isn't something syscall provides as "output".

> +	int exp_err;
> +} tcases[] = {
> +	{&addr, -1, NULL, 0, EINVAL},
> +	{&addr, 0, &max_sz1, 1, ENOMEM},
> +	{&addr, 0, &max_sz2, 1, EPERM},
> +	{&unmapped_addr, 0, NULL, 0, ENOMEM},
> +};
> +
..
> +static void setup(void)
> +{
> +	pgsz = getpagesize();
> +	nobody = SAFE_GETPWNAM("nobody");
> +
> +	addr = SAFE_MMAP(NULL, pgsz, PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	unmapped_addr = SAFE_MMAP(NULL, pgsz, PROT_READ,
> +				  MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	SAFE_MUNMAP(unmapped_addr, pgsz);

I suggest larger map here (couple M) and pick address in middle.
Single page can easily be mapped by glibc for some buffer.

> +
> +	max_sz1 = pgsz - 1;
> +}
> +

Regards,
Jan
