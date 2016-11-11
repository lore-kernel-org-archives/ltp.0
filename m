From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 11 Nov 2016 09:30:24 +0800
Subject: [LTP] [PATCH v3] syscalls/recvmsg03.c: add new testcase
In-Reply-To: <1478159398-10268-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161102130647.GB22840@rei.lan>
 <1478159398-10268-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <58251F30.4060502@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril!

Ping :-)

Thanks,
Xiao Yang

On 2016/11/03 15:49, Xiao Yang wrote:
> If the size of address for receiving data is set larger than
> actaul size, recvmsg() will set msg_namelen incorrectly.
>
> This bug has been fixed by the following kernel patch:
> 'commit 06b6a1cf6e77 ("rds: set correct msg_namelen")'
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/.gitignore          |   1 +
>  testcases/kernel/syscalls/recvmsg/recvmsg03.c | 163 ++++++++++++++++++++++++++
>  3 files changed, 165 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/recvmsg/recvmsg03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index e6b36ae..5543eac 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -870,6 +870,7 @@ recvfrom01 recvfrom01
>  
>  recvmsg01 recvmsg01
>  recvmsg02 recvmsg02
> +recvmsg03 recvmsg03
>  
>  remap_file_pages01 remap_file_pages01
>  remap_file_pages02 remap_file_pages02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 0807e17..170b889 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -725,6 +725,7 @@
>  /recvfrom/recvfrom01
>  /recvmsg/recvmsg01
>  /recvmsg/recvmsg02
> +/recvmsg/recvmsg03
>  /remap_file_pages/remap_file_pages01
>  /remap_file_pages/remap_file_pages02
>  /removexattr/removexattr01
> diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
> new file mode 100644
> index 0000000..bee9c12
> --- /dev/null
> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
> @@ -0,0 +1,163 @@
> +/*
> + * Copyright(c) 2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License
> + * alone with this program.
> + */
> +
> +/*
> + * Test Name: recvmsg03
> + *
> + * This test needs that rds socket is supported by system.
> + * If the size of address for receiving data is set larger than
> + * actaul size, recvmsg() will set msg_namelen incorrectly.
> + *
> + * Description:
> + * This is a regression test and has been fixed by kernel commit:
> + * 06b6a1cf6e776426766298d055bb3991957d90a7 (rds: set correct msg_namelen)
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +
> +#include "tst_test.h"
> +
> +#ifndef AF_RDS
> +# define AF_RDS 21
> +#endif
> +
> +static void setup(void)
> +{
> +	int res;
> +
> +	res = socket(AF_RDS, SOCK_SEQPACKET, 0);
> +	if (res == -1) {
> +		if (errno == EAFNOSUPPORT)
> +			tst_brk(TCONF, "rds was not supported");
> +		else
> +			tst_brk(TBROK | TERRNO, "socket() failed with rds");
> +	}
> +
> +	SAFE_CLOSE(res);
> +}
> +
> +static void client(void)
> +{
> +	int sock_fd1;
> +	char send_buf[128] = "hello world";
> +	struct sockaddr_in server_addr;
> +	struct sockaddr_in to_addr;
> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd1 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	server_addr.sin_port = htons(4001);
> +
> +	SAFE_BIND(sock_fd1, (struct sockaddr *) &server_addr, sizeof(server_addr));
> +
> +	memset(&to_addr, 0, sizeof(to_addr));
> +
> +	to_addr.sin_family = AF_INET;
> +	to_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	to_addr.sin_port = htons(4000);
> +	msg.msg_name = &to_addr;
> +	msg.msg_namelen = sizeof(to_addr);
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_iov->iov_base = send_buf;
> +	msg.msg_iov->iov_len = strlen(send_buf) + 1;
> +	msg.msg_control = 0;
> +	msg.msg_controllen = 0;
> +	msg.msg_flags = 0;
> +
> +	if (sendmsg(sock_fd1, &msg, 0) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +			"sendmsg() failed to send data to server");
> +	}
> +
> +	SAFE_CLOSE(sock_fd1);
> +}
> +
> +static void server(void)
> +{
> +	int sock_fd2;
> +	static char recv_buf[128];
> +	struct sockaddr_in server_addr;
> +	struct sockaddr_in from_addr;
> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd2 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	server_addr.sin_port = htons(4000);
> +
> +	SAFE_BIND(sock_fd2, (struct sockaddr *) &server_addr, sizeof(server_addr));
> +
> +	msg.msg_name = &from_addr;
> +	msg.msg_namelen = sizeof(from_addr) + 16;
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_iov->iov_base = recv_buf;
> +	msg.msg_iov->iov_len = 128;
> +	msg.msg_control = 0;
> +	msg.msg_controllen = 0;
> +	msg.msg_flags = 0;
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	TEST(recvmsg(sock_fd2, &msg, 0));
> +	if (TEST_RETURN == -1) {
> +		tst_brk(TBROK | TTERRNO,
> +		"recvmsg() failed to recvice data from client");
> +	}
> +
> +	if (msg.msg_namelen != sizeof(from_addr)) {
> +		tst_res(TFAIL, "msg_namelen was set to %u incorrectly, "
> +			"expected %lu", msg.msg_namelen, sizeof(from_addr));
> +	} else {
> +		tst_res(TPASS, "msg_namelen was set to %u correctly",
> +			msg.msg_namelen);
> +	}
> +
> +	SAFE_CLOSE(sock_fd2);
> +}
> +
> +static void verify_recvmsg(void)
> +{
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		TST_CHECKPOINT_WAIT(0);
> +		client();
> +	} else {
> +		server();
> +		tst_reap_children();
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "recvmsg03",
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.setup = setup,
> +	.test_all = verify_recvmsg
> +};



