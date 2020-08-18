From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 16:37:15 +0200
Subject: [LTP] [PATCH v3 2/2] syscalls/{send|recv}mmsg: add a test case
 for timeout and errno test
In-Reply-To: <20200817102232.5902-3-Filip.Bozuta@syrmia.com>
References: <20200817102232.5902-1-Filip.Bozuta@syrmia.com>
 <20200817102232.5902-3-Filip.Bozuta@syrmia.com>
Message-ID: <20200818143715.GC27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
> index 54febf661..d7d5d33cc 100644
> --- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
> +++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
> @@ -24,6 +24,36 @@ static int receive_sockfd;
>  static struct mmsghdr *snd_msg, *rcv_msg;
>  static struct iovec *snd1, *snd2, *rcv1, *rcv2;
>  
> +enum test_type {
> +	NORMAL,
> +	TIMEOUT,
> +};
> +
> +#define TYPE_NAME(x) .ttype = x, .desc = #x
> +
> +struct test_case {
> +	int ttype;
> +	const char *desc;
> +	long tv_sec;
> +	long tv_nsec;
> +	int exp_ret;
> +};
> +
> +static struct test_case tcase[] = {
> +	{
> +		TYPE_NAME(NORMAL),
> +		.tv_sec = 1,
> +		.tv_nsec = 0,
> +		.exp_ret = 2,
> +	},
> +	{
> +		TYPE_NAME(TIMEOUT),
> +		.tv_sec = 0,
> +		.tv_nsec = 1,
> +		.exp_ret = 1,

The manual states that the timeout is checked after each datagram is
received so I guess that we can as well set the timeout here to both sec
and nsec to zero which would be a bit more clear than nsec = 1.

> +	},
> +};
> +
>  static struct test_variants {
>  	int (*receive)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
>  		       unsigned int flags, void *timeout);
> @@ -43,14 +73,17 @@ static struct test_variants {
>  #endif
>  };
>  
> -static void run(void)
> +static void do_test(unsigned int i)
>  {
>  	struct test_variants *tv = &variants[tst_variant];
> +	struct test_case *tc = &tcase[i];
>  	struct tst_ts timeout;
> -	int retval;
>  
> -	retval = tv->send(send_sockfd, snd_msg, VLEN, 0);
> -	if (retval < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
> +	tst_res(TINFO, "case %s", tc->desc);
> +
> +	TEST(tv->send(send_sockfd, snd_msg, VLEN, 0));
> +
> +	if (TST_RET < 0 || snd_msg[0].msg_len != 6 || snd_msg[1].msg_len != 6) {
>  		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
>  		return;
>  	}
> @@ -59,18 +92,18 @@ static void run(void)
>  	memset(rcv2->iov_base, 0, rcv2->iov_len);
>  
>  	timeout.type = tv->type;
> -	tst_ts_set_sec(&timeout, 1);
> -	tst_ts_set_nsec(&timeout, 0);
> +	tst_ts_set_sec(&timeout, tc->tv_sec);
> +	tst_ts_set_nsec(&timeout, tc->tv_nsec);
>  
> -	retval = tv->receive(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout));
> +	TEST(tv->receive(receive_sockfd, rcv_msg, VLEN, 0, tst_ts_get(&timeout)));
>  
> -	if (retval == -1) {
> +	if (TST_RET == -1) {
>  		tst_res(TFAIL | TERRNO, "recvmmsg() failed");
>  		return;
>  	}
> -	if (retval != 2) {
> +	if (tc->exp_ret != TST_RET) {
>  		tst_res(TFAIL, "Received unexpected number of messages (%d)",
> -			retval);
> +			TST_RET);
>  		return;
>  	}
>  
> @@ -79,10 +112,14 @@ static void run(void)
>  	else
>  		tst_res(TPASS, "First message received successfully");
>  
> -	if (memcmp(rcv2->iov_base, "three", 5))
> -		tst_res(TFAIL, "Error in second received message");
> -	else
> -		tst_res(TPASS, "Second message received successfully");
> +	if (tc->ttype == NORMAL) {
> +		if (memcmp(rcv2->iov_base, "three", 5))
> +			tst_res(TFAIL, "Error in second received message");
> +		else
> +			tst_res(TPASS, "Second message received successfully");
> +	} else {
> +		tst_res(TPASS, "Timeout successfully reached before second message");

	This actually breaks the test with -i 2 option, which runs the run()
	function twice.

	We have to receive the second message here as well for the timeout test.

> +	}
>  }
>  
>  static void setup(void)
> @@ -128,7 +165,8 @@ static void cleanup(void)
>  }
>  
>  static struct tst_test test = {
> -	.test_all = run,
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.test_variants = ARRAY_SIZE(variants),
> diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
> new file mode 100644
> index 000000000..37e6ea66e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Can we please include a comment with a high level description of the
test here?

> +#define _GNU_SOURCE
> +#include <netinet/ip.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +
> +#include "tst_test.h"
> +#include "lapi/socket.h"
> +#include "tst_safe_macros.h"
> +#include "sendmmsg_var.h"
> +
> +#define BUFSIZE 16
> +#define VLEN 2
> +
> +static int send_sockfd;
> +static int receive_sockfd;
> +static struct mmsghdr *snd_msg, *rcv_msg;
> +static struct iovec *snd1, *snd2, *rcv1, *rcv2;
> +static struct tst_ts ts;
> +
> +enum test_type {
> +	BAD_SEND_FD,
> +	BAD_RECV_FD,
> +	BAD_SEND_MSGVEC,
> +	BAD_RECV_MSGVEC,
> +	BAD_TS_VALUE_1,
> +	BAD_TS_VALUE_2,
> +	BAD_TS_ADDR,
> +};
> +
> +#define TYPE_NAME(x) .ttype = x, .desc = #x
> +
> +static void *bad_addr;
> +
> +struct test_case {
> +	int ttype;
> +	const char *desc;
> +	int send_fd;
> +	int recv_fd;
> +	long tv_sec;
> +	long tv_nsec;
> +	int exp_send_ret;
> +	int exp_send_errno;
> +	int exp_recv_errno;
> +};
> +
> +static struct test_case tcase[] = {
> +	{
> +		TYPE_NAME(BAD_SEND_FD),
> +		.send_fd = -1,
> +		.exp_send_ret = -1,
> +		.exp_send_errno = EBADF,
> +	},
> +	{
> +		TYPE_NAME(BAD_RECV_FD),
> +		.exp_send_ret = VLEN,
> +		.recv_fd = -1,
> +		.exp_recv_errno = EBADF,
> +	},
> +	{
> +		TYPE_NAME(BAD_SEND_MSGVEC),
> +		.exp_send_ret = -1,
> +		.exp_send_errno = EFAULT,
> +	},
> +	{
> +		TYPE_NAME(BAD_RECV_MSGVEC),
> +		.exp_send_ret = VLEN,
> +		.exp_recv_errno = EFAULT,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_VALUE_1),
> +		.exp_send_ret = VLEN,
> +		.tv_sec = -1,
> +		.tv_nsec = 0,
> +		.exp_recv_errno = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_VALUE_2),
> +		.exp_send_ret = VLEN,
> +		.tv_sec = 1,
> +		.tv_nsec = 1000000001,
> +		.exp_recv_errno = EINVAL,
> +	},
> +	{
> +		TYPE_NAME(BAD_TS_ADDR),
> +		.exp_send_ret = VLEN,
> +		.exp_recv_errno = EFAULT,
> +	}
> +};
> +
> +static struct test_variants {
> +	int (*receive)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
> +		       unsigned int flags, void *timeout);
> +	int (*send)(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
> +		    unsigned int flags);
> +	enum tst_ts_type type;
> +	char *desc;
> +} variants[] = {
> +	{ .receive = libc_recvmmsg, .send = libc_sendmmsg, .type = TST_LIBC_TIMESPEC, .desc = "vDSO or syscall with libc spec"},
> +
> +#if (__NR_recvmmsg != __LTP__NR_INVALID_SYSCALL)
> +	{ .receive = sys_recvmmsg, .send = sys_sendmmsg, .type = TST_KERN_OLD_TIMESPEC, .desc = "syscall with old kernel spec"},
> +#endif
> +
> +#if (__NR_recvmmsg_time64 != __LTP__NR_INVALID_SYSCALL)
> +	{ .receive = sys_recvmmsg64, .send = sys_sendmmsg, .type = TST_KERN_TIMESPEC, .desc = "syscall time64 with kernel spec"},
> +#endif
> +};

Technically the recvmmsg tests should be in a recvmmsg01.c.

We can put the test_variants array to a common header though.

> +static void cleanup(void)
> +{
> +	if (send_sockfd > 0)
> +		SAFE_CLOSE(send_sockfd);
> +	if (receive_sockfd > 0)
> +		SAFE_CLOSE(receive_sockfd);
> +}
> +
> +static void do_test(unsigned int i)
> +{
> +	struct test_variants *tv = &variants[tst_variant];
> +	struct test_case *tc = &tcase[i];
> +	void *snd_msgvec, *rcv_msgvec, *timeout;
> +
> +	tst_res(TINFO, "case %s", tc->desc);
> +
> +	if (tc->ttype != BAD_SEND_FD)
> +		tc->send_fd = send_sockfd;
> +	if (tc->ttype != BAD_RECV_FD)
> +		tc->recv_fd = receive_sockfd;
> +
> +	if (tc->ttype == BAD_SEND_MSGVEC)
> +		snd_msgvec = bad_addr;
> +	else
> +		snd_msgvec = snd_msg;
> +
> +	TEST(tv->send(tc->send_fd, snd_msgvec, VLEN, 0));
> +
> +	if (TST_RET < 0) {
> +		if (tc->exp_send_ret != TST_RET || errno != tc->exp_send_errno)
> +			tst_res(TFAIL | TERRNO, "sendmmsg() failed unexpectedly");
> +		else
> +			tst_res(TPASS | TERRNO, "sendmmg() failed successfully");
> +		return;
> +	}
> +
> +	if (tc->exp_send_ret != TST_RET || snd_msg[0].msg_len != 6 ||
> +	    snd_msg[1].msg_len != 6) {
> +		tst_res(TFAIL | TERRNO, "sendmmsg() failed");
> +		return;
> +	}
> +
> +	memset(rcv1->iov_base, 0, rcv1->iov_len);
> +	memset(rcv2->iov_base, 0, rcv2->iov_len);
> +
> +	ts.type = tv->type;
> +	tst_ts_set_sec(&ts, tc->tv_sec);
> +	tst_ts_set_nsec(&ts, tc->tv_nsec);
> +
> +	if (tc->ttype == BAD_RECV_MSGVEC)
> +		rcv_msgvec = bad_addr;
> +	else
> +		rcv_msgvec = rcv_msg;
> +
> +	if (tc->ttype == BAD_TS_ADDR)
> +		timeout = bad_addr;
> +	else
> +		timeout = tst_ts_get(&ts);
> +
> +	TEST(tv->receive(tc->recv_fd, rcv_msgvec, VLEN, 0, timeout));
> +
> +	if (TST_RET < 0) {
> +		if (tc->exp_recv_errno == errno)
> +			tst_res(TPASS | TERRNO, "receivemmsg() failed successfully");
> +		else
> +			tst_res(TFAIL | TERRNO, "receivemmsg() failed unexpectedly");
> +	} else {
> +		tst_res(TFAIL | TERRNO, "receivemmsg() succeded unexpectedly");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	struct sockaddr_in addr;
> +	unsigned int port = TST_GET_UNUSED_PORT(AF_INET, SOCK_DGRAM);
> +
> +	send_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +	receive_sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +
> +	addr.sin_family = AF_INET;
> +	addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
> +	addr.sin_port = port;
> +
> +	SAFE_BIND(receive_sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +	SAFE_CONNECT(send_sockfd, (struct sockaddr *)&addr, sizeof(addr));
> +
> +	memcpy(snd1[0].iov_base, "one", snd1[0].iov_len);
> +	memcpy(snd1[1].iov_base, "two", snd1[1].iov_len);
> +	memcpy(snd2->iov_base, "three3", snd2->iov_len);
> +
> +	memset(snd_msg, 0, VLEN * sizeof(*snd_msg));
> +	snd_msg[0].msg_hdr.msg_iov = snd1;
> +	snd_msg[0].msg_hdr.msg_iovlen = 2;
> +	snd_msg[1].msg_hdr.msg_iov = snd2;
> +	snd_msg[1].msg_hdr.msg_iovlen = 1;
> +
> +	memset(rcv_msg, 0, VLEN * sizeof(*rcv_msg));
> +	rcv_msg[0].msg_hdr.msg_iov = rcv1;
> +	rcv_msg[0].msg_hdr.msg_iovlen = 1;
> +	rcv_msg[1].msg_hdr.msg_iov = rcv2;
> +	rcv_msg[1].msg_hdr.msg_iovlen = 1;
> +
> +	bad_addr = tst_get_bad_addr(cleanup);
                                    ^
				    This must be NULL in new-library API
				    tests.

Since in the new-library API the cleanup is passed in the tst_test
structure and handled in the test library.


> +	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcase),
> +	.test = do_test,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = ARRAY_SIZE(variants),
> +	.bufs = (struct tst_buffers []) {
> +		{&snd1, .iov_sizes = (int[]){3, 3, -1}},
> +		{&snd2, .iov_sizes = (int[]){6, -1}},
> +		{&rcv1, .iov_sizes = (int[]){6, -1}},
> +		{&rcv2, .iov_sizes = (int[]){5, -1}},
> +		{&snd_msg, .size = VLEN * sizeof(*snd_msg)},
> +		{&rcv_msg, .size = VLEN * sizeof(*rcv_msg)},
> +		{},
> +	}
> +};
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
