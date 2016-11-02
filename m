From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 14:06:47 +0100
Subject: [LTP] [PATCH v2] syscalls/recvmsg03.c: add new testcase
In-Reply-To: <1478064173-5704-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161031133927.GB32461@rei>
 <1478064173-5704-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161102130647.GB22840@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void server(void)
> +{
> +	int sock_fd, sock_fd2;
> +	static char recv_buf[128];
> +	struct sockaddr_in server_addr;
> +	struct sockaddr_in from_addr;
> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd2 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +	sock_fd = sock_fd2;
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
> +		tst_res(TFAIL | TERRNO,
> +		"recvmsg() failed to recvice data from client");
> +		goto end;
> +	}
> +
> +	if (msg.msg_namelen != sizeof(from_addr)) {
> +		tst_res(TFAIL, "msg_namelen was set to %u incorrectly, "
> +			"expected %lu", msg.msg_namelen, sizeof(from_addr));
> +		goto end;
> +	}
> +
> +	if (sock_fd2 != sock_fd) {
> +		tst_res(TFAIL, "sock_fd was destroyed");
> +		goto end;
> +	}
> +
> +	tst_res(TPASS, "msg_namelen was set to %u correctly and sock_fd was "
> +		"not destroyed", msg.msg_namelen);
> +
> +end:
> +	SAFE_CLOSE(sock_fd2);

I'm a bit confused here, which one of the sock_fd/sock_fd2 is destroyed?

Looking at the original code in the kernel commit the sock_fd there is
stored on the stack directly after the sockaddr_in from_addr so I guess
that the kernel will actually write a few bytes after the end of
from_addr structure in this case, which will rewrite the msghrd msg in
your code. Does the test actually fail on kernel without the fix?

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
> +		SAFE_WAIT(NULL);

We should rather call tst_reap_children() in this case instead of the
WAIT since otherwise TBROK from the client() function will not get
propagated.

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
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
