From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 2 Nov 2016 13:34:51 +0800
Subject: [LTP] [PATCH v2] syscalls/recvmsg03.c: add new testcase
In-Reply-To: <1477967071-12001-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161031133927.GB32461@rei>
 <1477967071-12001-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <58197AFB.2090102@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Cyril

Please ignore the v2 patch=EF=BC=8Ci will resend it.

Thanks,
Xiao Yang
On 2016/11/01 10:24, Xiao Yang wrote:
> If the size of address for receiving data is set larger than actaul
> size, recvmsg() will set msg_namelen incorrectly and destroy sock_fd.
>
> This bug has been fixed by the following kernel patch:
> 'commit 06b6a1cf6e77 ("rds: set correct msg_namelen")'
>
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/.gitignore          |   1 +
>  testcases/kernel/syscalls/recvmsg/recvmsg03.c | 196 ++++++++++++++++++++=
++++++
>  3 files changed, 198 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/recvmsg/recvmsg03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b781241..4c87f45 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -869,6 +869,7 @@ recvfrom01 recvfrom01
> =20
>  recvmsg01 recvmsg01
>  recvmsg02 recvmsg02
> +recvmsg03 recvmsg03
> =20
>  remap_file_pages01 remap_file_pages01
>  remap_file_pages02 remap_file_pages02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/sysc=
alls/.gitignore
> index f53cc05..1229720 100644
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
> diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg03.c b/testcases/ke=
rnel/syscalls/recvmsg/recvmsg03.c
> new file mode 100644
> index 0000000..23ed23b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg03.c
> @@ -0,0 +1,196 @@
> +/*
> + * Copyright(c) 2016 Fujitsu Ltd.
> + * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
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
> + * If the size of address for receiving data is set larger than actaul s=
ize,
> + * recvmsg() will set msg_namelen incorrectly and destroy sock_fd.
> + *
> + * Description:
> + * This is a regression test and has been fixed by kernel commit:
> + * 06b6a1cf6e776426766298d055bb3991957d90a7 (rds: set correct msg_namele=
n)
> + */
> +
> +#include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <stdio.h>
> +
> +#include "tst_test.h"
> +
> +#ifndef AF_RDS
> +# define AF_RDS 21
> +#endif
> +
> +static int rds_flag;
> +
> +static void setup(void)
> +{
> +	int acc_res, load_res;
> +	const char *cmd[] =3D {"modprobe", "-i", "rds", NULL};
> +
> +	acc_res =3D access("/proc/sys/net/rds", F_OK);
> +	if (acc_res =3D=3D -1 && errno !=3D ENOENT)
> +		tst_brk(TFAIL | TERRNO, "failed to check rds module");
> +
> +	if (acc_res =3D=3D -1 && errno =3D=3D ENOENT) {
> +		load_res =3D tst_run_cmd(cmd, NULL, NULL, 1);
> +		if (load_res) {
> +			tst_brk(TCONF, "failed to loaded rds module, "
> +				"so rds modeule was not support by system");
> +		}
> +
> +		tst_res(TINFO, "succeeded to load rds module");
> +		rds_flag =3D 1;
> +	}
> +
> +	tst_res(TINFO, "rds module was supported by system");
> +}
> +
> +static void cleanup(void)
> +{
> +	int unload_res;
> +	const char *cmd[] =3D {"modprobe", "-r", "rds", NULL};
> +
> +	if (rds_flag =3D=3D 1) {
> +		unload_res =3D tst_run_cmd(cmd, NULL, NULL, 1);
> +		if (unload_res)
> +			tst_res(TWARN | TERRNO, "failed to unload rds module");
> +		else
> +			tst_res(TINFO, "succeeded to unload rds modules");
> +	}
> +}
> +
> +static void client(void)
> +{
> +	int sock_fd1;
> +	char send_buf[128] =3D "hello world";
> +	struct sockaddr_in server_addr;
> +	struct sockaddr_in to_addr;
> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd1 =3D SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family =3D AF_INET;
> +	server_addr.sin_addr.s_addr =3D inet_addr("127.0.0.1");
> +	server_addr.sin_port =3D htons(4001);
> +
> +	SAFE_BIND(sock_fd1, (struct sockaddr *) &server_addr, sizeof(server_add=
r));
> +
> +	memset(&to_addr, 0, sizeof(to_addr));
> +
> +	to_addr.sin_family =3D AF_INET;
> +	to_addr.sin_addr.s_addr =3D inet_addr("127.0.0.1");
> +	to_addr.sin_port =3D htons(4000);
> +	msg.msg_name =3D &to_addr;
> +	msg.msg_namelen =3D sizeof(to_addr);
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_iov->iov_base =3D send_buf;
> +	msg.msg_iov->iov_len =3D strlen(send_buf) + 1;
> +	msg.msg_control =3D 0;
> +	msg.msg_controllen =3D 0;
> +	msg.msg_flags =3D 0;
> +
> +	if (sendmsg(sock_fd1, &msg, 0) =3D=3D -1) {
> +		tst_brk(TFAIL | TERRNO,
> +			"sendmsg() failed to send data to server");
> +	}
> +
> +	SAFE_CLOSE(sock_fd1);
> +}
> +
> +static void server(void)
> +{
> +	int sock_fd, sock_fd2;
> +	static char recv_buf[128];
> +	struct sockaddr_in server_addr;
> +	struct sockaddr_in from_addr;
> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd2 =3D SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +	sock_fd =3D sock_fd2;
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family =3D AF_INET;
> +	server_addr.sin_addr.s_addr =3D inet_addr("127.0.0.1");
> +	server_addr.sin_port =3D htons(4000);
> +
> +	SAFE_BIND(sock_fd2, (struct sockaddr *) &server_addr, sizeof(server_add=
r));
> +
> +	msg.msg_name =3D &from_addr;
> +	msg.msg_namelen =3D sizeof(from_addr) + 16;
> +	msg.msg_iov =3D &iov;
> +	msg.msg_iovlen =3D 1;
> +	msg.msg_iov->iov_base =3D recv_buf;
> +	msg.msg_iov->iov_len =3D 128;
> +	msg.msg_control =3D 0;
> +	msg.msg_controllen =3D 0;
> +	msg.msg_flags =3D 0;
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	TEST(recvmsg(sock_fd2, &msg, 0));
> +	if (TEST_RETURN =3D=3D -1) {
> +		tst_res(TFAIL | TERRNO,
> +		"recvmsg() failed to recvice data from client");
> +		goto end;
> +	}
> +
> +	if (msg.msg_namelen !=3D sizeof(from_addr)) {
> +		tst_res(TFAIL, "msg_namelen was set to %u incorrectly, "
> +			"expected %lu", msg.msg_namelen, sizeof(from_addr));
> +		goto end;
> +	}
> +
> +	if (sock_fd2 !=3D sock_fd) {
> +		tst_res(TFAIL, "sock_fd was destroyed");
> +		goto end;
> +	}
> +
> +	tst_res(TPASS, "msg_namelen was set to %u correctly and sock_fd was "
> +		"not destroyed", msg.msg_namelen);
> +
> +end:
> +	SAFE_CLOSE(sock_fd2);
> +}
> +
> +static void verify_recvmsg(void)
> +{
> +	pid_t pid;
> +
> +	pid =3D SAFE_FORK();
> +	if (pid =3D=3D 0) {
> +		TST_CHECKPOINT_WAIT(0);
> +		client();
> +	} else {
> +		server();
> +	}
> +}
> +
> +static struct tst_test test =3D {
> +	.tid =3D "recvmsg03",
> +	.forks_child =3D 1,
> +	.needs_checkpoints =3D 1,
> +	.setup =3D setup,
> +	.cleanup =3D cleanup,
> +	.test_all =3D verify_recvmsg
> +};



