From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 14:39:27 +0100
Subject: [LTP] [PATCH] syscalls/recvmsg03.c: add new testcase
In-Reply-To: <1477913034-20459-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1477913034-20459-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161031133927.GB32461@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static void setup(void)
> +{
> +	int acc_res, load_res;
> +	const char *cmd[] = {"modprobe", "-i", "rds", NULL};
> +
> +	acc_res = access("/proc/sys/net/rds", F_OK);
> +	if (acc_res == -1 && errno == ENOENT) {
> +		load_res = tst_run_cmd(cmd, NULL, NULL, 1);
> +		if (load_res) {
> +			tst_brk(TCONF, "failed to loaded rds module, "
> +				"so rds modeule was not support by system");
> +		} else {
> +			tst_res(TINFO, "succeeded to load rds module");
> +			rds_flag = 1;

No need for the else branch here, the tst_brk() will exit test if it's
reached.

Also if you just do return; here then you can just later do:

tst_brk(TFAIL | TERRNO, "failed to check rds module");

> +		}
> +	}
> +
> +	if (acc_res == -1 && errno != ENOENT)
> +		tst_brk(TFAIL | TERRNO, "failed to check rds module");

Once you get here the errno may be changed several times by library
functions called from tst_run_cmd() and tst_res().

The errno is per thread global variable used by most of the glibc
functions. Once you call something that may change its value is
undefined.

> +	tst_res(TINFO, "rds module was supported by system");
> +}
> +
> +static void cleanup(void)
> +{
> +	int unload_res;
> +	const char *cmd[] = {"modprobe", "-r", "rds", NULL};
> +
> +	if (rds_flag == 1) {
> +		unload_res = tst_run_cmd(cmd, NULL, NULL, 1);
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
> +	char sendBuffer[128] = "hello world";
> +	struct sockaddr_in serverAddr;
> +	struct sockaddr_in toAddr;

Mixed case is frowned upon in LKML coding style. So these should rather
be send_buf, server_addr, etc...

> +	struct msghdr msg;
> +	struct iovec iov;
> +
> +	sock_fd1 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +
> +	memset(&serverAddr, 0, sizeof(serverAddr));
> +	serverAddr.sin_family = AF_INET;
> +	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	serverAddr.sin_port = htons(4001);
> +
> +	SAFE_BIND(sock_fd1, (struct sockaddr *) &serverAddr, sizeof(serverAddr));
> +
> +	memset(&toAddr, 0, sizeof(toAddr));
> +
> +	toAddr.sin_family = AF_INET;
> +	toAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	toAddr.sin_port = htons(4000);
> +	msg.msg_name = &toAddr;
> +	msg.msg_namelen = sizeof(toAddr);
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_iov->iov_base = sendBuffer;
> +	msg.msg_iov->iov_len = strlen(sendBuffer) + 1;
> +	msg.msg_control = 0;
> +	msg.msg_controllen = 0;
> +	msg.msg_flags = 0;
> +
> +	if (sendmsg(sock_fd1, &msg, 0) == -1) {
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
> +	static char recvBuffer[128];
> +	struct sockaddr_in serverAddr;
> +	struct sockaddr_in fromAddr;
> +	struct msghdr msg;
> +	struct iovec iov;

Here as well.

> +	sock_fd2 = SAFE_SOCKET(AF_RDS, SOCK_SEQPACKET, 0);
> +	sock_fd = sock_fd2;
> +
> +	memset(&serverAddr, 0, sizeof(serverAddr));
> +	serverAddr.sin_family = AF_INET;
> +	serverAddr.sin_addr.s_addr = inet_addr("127.0.0.1");
> +	serverAddr.sin_port = htons(4000);
> +
> +	SAFE_BIND(sock_fd2, (struct sockaddr *) &serverAddr, sizeof(serverAddr));
> +
> +	msg.msg_name = &fromAddr;
> +	msg.msg_namelen = sizeof(fromAddr) + 16;
> +	msg.msg_iov = &iov;
> +	msg.msg_iovlen = 1;
> +	msg.msg_iov->iov_base = recvBuffer;
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
> +		return;
> +	}
> +
> +	if (msg.msg_namelen != sizeof(fromAddr)) {
> +		tst_res(TFAIL, "msg_namelen was set to %u incorrectly, "
> +			"expected %lu", msg.msg_namelen, sizeof(fromAddr));
> +		return;
> +	}
> +
> +	if (sock_fd2 != sock_fd) {
> +		tst_res(TFAIL, "sock_fd was destroyed");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "msg_namelen was set to %u correctly and sock_fd was "
> +		"not destroyed", msg.msg_namelen);
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
> +	}
> +}
> +
> +static struct tst_test test = {
> +	.tid = "recvmsg03",
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_recvmsg
> +};
> -- 
> 1.8.3.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
