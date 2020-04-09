From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Apr 2020 11:45:50 +0200
Subject: [LTP] [PATCH v2 2/2] pty04: Add SLCAN ldisc and check for
 CVE-2020-11494
In-Reply-To: <20200409060745.9619-2-rpalethorpe@suse.com>
References: <20200409060745.9619-1-rpalethorpe@suse.com>
 <20200409060745.9619-2-rpalethorpe@suse.com>
Message-ID: <20200409094550.GB9792@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #define _GNU_SOURCE
> @@ -36,6 +44,14 @@
>  #include <linux/if_ether.h>
>  #include <linux/tty.h>
>  
> +#ifdef HAVE_LINUX_CAN_H
> +# include <linux/can.h>
> +#else
> +# define CAN_MTU 16
> +# define CAN_MAX_DLEN 8
> +#endif

We are we adding fallback definitions here if rest of the code is full
of #ifdef HAVE_LINUX_CAN_H ?

Can't we just add a fallback for the struct can frame and be done with
it?

Or do we even need the fallback at all?

> +#include <stddef.h>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -48,19 +64,23 @@
>  
>  #include "tst_safe_stdio.h"
>  
> +#define str(s) #s
> +#define SLCAN_FRAME "t00185f5f5f5f5f5f5f5f\r"
> +
>  struct ldisc_info {
>  	int n;
>  	char *name;
> -	int max_mtu;
> +	int mtu;
>  };
>  
>  static struct ldisc_info ldiscs[] = {
>  	{N_SLIP, "N_SLIP", 8192},
> +	{N_SLCAN, "N_SLCAN", CAN_MTU},
>  };
>  
>  static volatile int ptmx, pts, sk, mtu, no_check;
>  
> -static int set_ldisc(int tty, struct ldisc_info *ldisc)
> +static int set_ldisc(int tty, const struct ldisc_info *ldisc)
>  {
>  	TEST(ioctl(tty, TIOCSETD, &ldisc->n));
>  
> @@ -79,7 +99,7 @@ static int set_ldisc(int tty, struct ldisc_info *ldisc)
>  	return 1;
>  }
>  
> -static int open_pty(struct ldisc_info *ldisc)
> +static int open_pty(const struct ldisc_info *ldisc)
>  {
>  	char pts_path[PATH_MAX];
>  
> @@ -99,7 +119,8 @@ static int open_pty(struct ldisc_info *ldisc)
>  	return set_ldisc(pts, ldisc);
>  }
>  
> -static ssize_t try_write(int fd, char *data, ssize_t size, ssize_t *written)
> +static ssize_t try_write(int fd, const char *data,
> +			 ssize_t size, ssize_t *written)
>  {
>  	ssize_t ret = write(fd, data, size);
>  
> @@ -109,22 +130,40 @@ static ssize_t try_write(int fd, char *data, ssize_t size, ssize_t *written)
>  	return !written || (*written += ret) >= size;
>  }
>  
> -static void write_pty(void)
> +static void write_pty(const struct ldisc_info *ldisc)
>  {
> -	char *data = tst_alloc(mtu);
> +	char *data;
>  	ssize_t written, ret;
> +	size_t len = 0;
> +
> +	switch (ldisc->n) {
> +	case N_SLIP:
> +		len = mtu; break;
> +	case N_SLCAN:
> +		len = sizeof(SLCAN_FRAME) - 1; break;
> +	}

Hiding the break like this looks like the act of a petty evil, can we
please stick to the LKML switch () coding style?

I.e.:

	switch (foo) {
	case BAR:
		...
	break;
	...
	}

> +	data = tst_alloc(len);
> +
> +	switch (ldisc->n) {
> +	case N_SLIP:
> +		memset(data, '_', len - 1);
> +		data[len - 1] = 0300;
> +		break;
> +	case N_SLCAN:
> +		memcpy(data, SLCAN_FRAME, len);
> +		break;
> +	}

Here it's better, but still not ideal...

> -	memset(data, '_', mtu - 1);
> -	data[mtu - 1] = 0300;
>  
>  	written = 0;
> -	ret = TST_RETRY_FUNC(try_write(ptmx, data, mtu, &written), TST_RETVAL_NOTNULL);
> +	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written), TST_RETVAL_NOTNULL);
>  	if (ret < 0)
>  		tst_brk(TBROK | TERRNO, "Failed 1st write to PTY");
>  	tst_res(TPASS, "Wrote PTY 1");
>  
>  	written = 0;
> -	ret = TST_RETRY_FUNC(try_write(ptmx, data, mtu, &written), TST_RETVAL_NOTNULL);
> +	ret = TST_RETRY_FUNC(try_write(ptmx, data, len, &written), TST_RETVAL_NOTNULL);
>  	if (ret < 0)
>  		tst_brk(TBROK | TERRNO, "Failed 2nd write to PTY");
>  
> @@ -133,7 +172,7 @@ static void write_pty(void)
>  
>  	tst_res(TPASS, "Wrote PTY 2");
>  
> -	while (try_write(ptmx, data, mtu, NULL) >= 0)
> +	while (try_write(ptmx, data, len, NULL) >= 0)
>  		;
>  
>  	tst_res(TPASS, "Writing to PTY interrupted by hangup");
> @@ -141,7 +180,7 @@ static void write_pty(void)
>  	tst_free_all();
>  }
>  
> -static void open_netdev(struct ldisc_info *ldisc)
> +static void open_netdev(const struct ldisc_info *ldisc)
>  {
>  	struct ifreq ifreq = { 0 };
>  	struct sockaddr_ll lla = { 0 };
> @@ -151,12 +190,12 @@ static void open_netdev(struct ldisc_info *ldisc)
>  
>  	sk = SAFE_SOCKET(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
>  
> -	ifreq.ifr_mtu = ldisc->max_mtu;
> +	ifreq.ifr_mtu = ldisc->mtu;
>  	if (ioctl(sk, SIOCSIFMTU, &ifreq))
>  		tst_res(TWARN | TERRNO, "Failed to set netdev MTU to maximum");
>  	SAFE_IOCTL(sk, SIOCGIFMTU, &ifreq);
>  	mtu = ifreq.ifr_mtu;
> -	tst_res(TINFO, "Netdev MTU is %d (we set %d)", mtu, ldisc->max_mtu);
> +	tst_res(TINFO, "Netdev MTU is %d (we set %d)", mtu, ldisc->mtu);
>  
>  	SAFE_IOCTL(sk, SIOCGIFFLAGS, &ifreq);
>  	ifreq.ifr_flags |= IFF_UP | IFF_RUNNING;
> @@ -176,13 +215,45 @@ static void open_netdev(struct ldisc_info *ldisc)
>  	tst_res(TINFO, "Bound netdev %d to socket %d", ifreq.ifr_ifindex, sk);
>  }
>  
> -static void check_data(const char *data, ssize_t len)
> +static void check_data(const struct ldisc_info *ldisc,
> +		       const char *data, ssize_t len)
>  {
>  	ssize_t i = 0, j;
> +#ifdef HAVE_LINUX_CAN_H
> +	struct can_frame frm;
> +#endif
>  
>  	if (no_check)
>  		return;
>  
> +#ifdef HAVE_LINUX_CAN_H
> +	if (ldisc->n == N_SLCAN) {
> +		memcpy(&frm, data, len);
> +
> +		if (frm.can_id != 1) {
> +			tst_res(TFAIL, "can_id = %d != 1",
> +				frm.can_id);
> +			no_check = 1;
> +		}
> +
> +		if (frm.can_dlc != CAN_MAX_DLEN) {
> +			tst_res(TFAIL, "can_dlc = %d != " str(CAN_MAX_DLEN),
> +				frm.can_dlc);
> +			no_check = 1;
> +		}
> +
> +		i = offsetof(struct can_frame, __pad);
> +		if (frm.__pad != frm.__res0 || frm.__res0 != frm.__res1) {
> +			tst_res_hexd(TFAIL, data + i,
> +				     offsetof(struct can_frame, data) - i,
> +				     "Padding bytes may contain stack data");
> +			no_check = 1;
> +		}
> +
> +		i = offsetof(struct can_frame, data);
> +	}
> +#endif
> +
>  	do {
>  		if (i >= len)
>  			return;
> @@ -195,31 +266,45 @@ static void check_data(const char *data, ssize_t len)
>  	j--;
>  
>  	tst_res_hexd(TFAIL, data + i, j - i,
> -		     "Corrupt data (max 64 bytes shown): data[%ld..%ld] = ",
> -		     i, j);
> -	tst_res(TINFO, "Will continue test without data checking");
> +		     "Corrupt data (max 64 of %ld bytes shown): data[%ld..%ld] = ",
> +		     len, i, j);
>  	no_check = 1;
> +
> +	if (no_check)
> +		tst_res(TINFO, "Will continue test without data checking");
>  }
>  
> -static void read_netdev(void)
> +static void read_netdev(const struct ldisc_info *ldisc)
>  {
> -	int rlen, plen = mtu - 1;
> -	char *data = tst_alloc(plen);
> +	int rlen, plen = 0;
> +	char *data;
> +
> +	switch (ldisc->n) {
> +	case N_SLIP:
> +		plen = mtu - 1;
> +		break;
> +
> +#ifdef HAVE_LINUX_CAN_H
> +	case N_SLCAN:
> +		plen = CAN_MTU;
> +		break;
> +#endif
> +	}
> +	data = tst_alloc(plen);
>  
>  	tst_res(TINFO, "Reading from socket %d", sk);
>  
>  	SAFE_READ(1, sk, data, plen);
> -	check_data(data, plen);
> -
> +	check_data(ldisc, data, plen);
>  	tst_res(TPASS, "Read netdev 1");
> -	SAFE_READ(1, sk, data, plen);
> -	check_data(data, plen);
>  
> +	SAFE_READ(1, sk, data, plen);
> +	check_data(ldisc, data, plen);
>  	tst_res(TPASS, "Read netdev 2");
>  
>  	TST_CHECKPOINT_WAKE(0);
>  	while((rlen = read(sk, data, plen)) > 0)
> -		check_data(data, rlen);
> +		check_data(ldisc, data, rlen);
>  
>  	tst_res(TPASS, "Reading data from netdev interrupted by hangup");
>  
> @@ -236,12 +321,12 @@ static void do_test(unsigned int n)
>  	open_netdev(ldisc);
>  
>  	if (!SAFE_FORK()) {
> -		read_netdev();
> +		read_netdev(ldisc);
>  		return;
>  	}
>  
>  	if (!SAFE_FORK()) {
> -		write_pty();
> +		write_pty(ldisc);
>  		return;
>  	}
>  
> @@ -268,11 +353,16 @@ static void cleanup(void)
>  static struct tst_test test = {
>  	.test = do_test,
>  	.cleanup = cleanup,
> -	.tcnt = 1,
> +	.tcnt = 2,

ARRAY_SIZE(ldiscs)?

>  	.forks_child = 1,
>  	.needs_checkpoints = 1,
>  	.needs_root = 1,
> -	.min_kver = "4.10"
> +	.min_kver = "4.10",
> +	.tags = (const struct tst_tag[]){
> +		{"linux-git", "b9258a2cece4ec1f020715fe3554bc2e360f6264"},

All the tags we have in are 12 characters long, can we please shorten
this one as well?

> +		{"CVE", "CVE-2020-11494"},
> +		{}
> +	}
>  };
>  
>  #else
> -- 
> 2.24.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
