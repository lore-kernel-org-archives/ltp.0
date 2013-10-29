Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Vazno-0004iw-My
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 03:17:08 +0000
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vaznm-00076h-Bw
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 03:17:08 +0000
Received: by mail-pa0-f48.google.com with SMTP id kq14so3388032pab.7
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Oct 2013 20:17:00 -0700 (PDT)
Date: Tue, 29 Oct 2013 11:16:51 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <20131029031651.GA14331@localhost.localdomain>
References: <1382969894-9814-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1382969894-9814-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] network: tcp_fastopen: add TCP Fast Open test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

On Mon, Oct 28, 2013 at 06:18:14PM +0400, Alexey Kodanev wrote:
> This is a perfomance test for TCP Fast Open (TFO) which is an extension to
> speed up the opening of TCP connections between two endpoints. It reduces
> the number of round time trips (RTT) required in TCP conversations. TFO could
> result in speed improvements of between 4% and 41% in the page load times on
> popular web sites.
> 
> The default test scenario simulates an average conversation between a
> web-browser and an application server, so the test results with TFO enabled
> must be at least 3 percent faster.
> 
> The test must be run on Linux versions higher then 3.7. (TFO client side
> implemented in Linux 3.6, server side in Linux 3.7).
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  runtest/tcp_cmds                                   |    1 +
>  testcases/network/tcp_fastopen/.gitignore          |    1 +
>  testcases/network/tcp_fastopen/Makefile            |   24 +
>  testcases/network/tcp_fastopen/README              |   16 +
>  testcases/network/tcp_fastopen/tcp_fastopen.c      |  823 ++++++++++++++++++++
>  testcases/network/tcp_fastopen/tcp_fastopen_run.sh |  190 +++++
>  6 files changed, 1055 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/network/tcp_fastopen/.gitignore
>  create mode 100644 testcases/network/tcp_fastopen/Makefile
>  create mode 100644 testcases/network/tcp_fastopen/README
>  create mode 100644 testcases/network/tcp_fastopen/tcp_fastopen.c
>  create mode 100755 testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> 
> diff --git a/runtest/tcp_cmds b/runtest/tcp_cmds
> index 4722ca8..68d1ede 100644
> --- a/runtest/tcp_cmds
> +++ b/runtest/tcp_cmds
> @@ -20,3 +20,4 @@ tcpdump tcpdump01
>  telnet telnet01
>  iptables iptables_tests.sh
>  dhcpd dhcpd_tests.sh
> +tcp_fastopen tcp_fastopen_run.sh
> diff --git a/testcases/network/tcp_fastopen/.gitignore b/testcases/network/tcp_fastopen/.gitignore
> new file mode 100644
> index 0000000..f321cf0
> --- /dev/null
> +++ b/testcases/network/tcp_fastopen/.gitignore
> @@ -0,0 +1 @@
> +/tcp_fastopen
> diff --git a/testcases/network/tcp_fastopen/Makefile b/testcases/network/tcp_fastopen/Makefile
> new file mode 100644
> index 0000000..bff25e5
> --- /dev/null
> +++ b/testcases/network/tcp_fastopen/Makefile
> @@ -0,0 +1,24 @@
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS		:= tcp_fastopen_run.sh
> +LDLIBS			+= -lpthread
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/network/tcp_fastopen/README b/testcases/network/tcp_fastopen/README
> new file mode 100644
> index 0000000..4e19add
> --- /dev/null
> +++ b/testcases/network/tcp_fastopen/README
> @@ -0,0 +1,16 @@
> +TCP Fast Open (TFO) is an extension to speed up the opening of TCP connections
> +between two endpoints. It reduces the number of round time trips (RTT)
> +required in TCP conversations.
> +
> +The test must be run on Linux versions higher then 3.7. (client side
> +implemented in Linux 3.6, server side in Linux 3.7).
> +
> +Developers reported (in "TCP Fast Open", CoNEXT 2011), TFO could result in
> +speed improvements of between 4% and 41% in the page load times on popular web
> +sites.
> +
> +With the default test scenario, a client is constantly sending requests to
> +a server and waiting for replies. The server is closing a connection after 3
> +requests from the client. This scenario was chosen to simulate an average
> +conversation between a web-browser and an application server. So the test
> +results with TFO support enabled must be at least 3 percent faster.
> diff --git a/testcases/network/tcp_fastopen/tcp_fastopen.c b/testcases/network/tcp_fastopen/tcp_fastopen.c
> new file mode 100644
> index 0000000..c698628
> --- /dev/null
> +++ b/testcases/network/tcp_fastopen/tcp_fastopen.c
> @@ -0,0 +1,823 @@
> +/*
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + *
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> + *
> + */
> +
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <sys/sysinfo.h>
> +#include <sys/poll.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <netdb.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "tcp_fastopen";
> +
> +static const int max_msg_len = 1500;
> +
> +/* TCP server requiers */
> +#ifndef TCP_FASTOPEN
> +#define TCP_FASTOPEN	23
> +#endif
> +
> +/* TCP client requiers */
> +#ifndef MSG_FASTOPEN
> +#define MSG_FASTOPEN	0x20000000 /* Send data in TCP SYN */
> +#endif
> +
> +enum {
> +	TCP_SERVER = 0,
> +	TCP_CLIENT,
> +};
> +static int tcp_mode;
> +
> +enum {
> +	TFO_ENABLED = 0,
> +	TFO_DISABLED,
> +};
> +static int tfo_support;
> +
> +enum {
> +	TCP_NEW_API = 0,
> +	TCP_OLD_API
> +};
> +static int tcp_api;
> +
> +static const char tfo_cfg[]		= "/proc/sys/net/ipv4/tcp_fastopen";
> +static const char tcp_tw_reuse[]	= "/proc/sys/net/ipv4/tcp_tw_reuse";
> +static int tw_reuse_changed;
> +static int tfo_cfg_value;
> +static int tfo_bit_num;
> +static int tfo_cfg_changed;
> +
> +static int sfd;
> +
> +static int tfo_queue_size	= 100;
> +static int max_queue_len	= 100;
> +static int client_byte		= 1;
> +static int server_byte		= 2;
> +static const int start_byte	= 0x24;
> +static const int end_byte	= 0x0a;
> +static int client_msg_size	= 32;
> +static int server_msg_size	= 128;
> +static char *client_msg;
> +static char *server_msg;
> +
> +/*
> + * The number of requests from client after
> + *  which server has to close the connection.
> + */
> +static int server_max_requests	= 3;
> +static int client_max_requests	= 10;
> +static int clients_num		= 2;
> +static char *tcp_port		= "61000";
> +static char *server_addr	= "localhost";
> +static char *rpath		= "./tfo_result";
> +
> +static int main_pid;
> +
> +socklen_t sock_len, csock_len;
> +
> +static int force_run;
> +
> +/* test options */
> +static char *narg, *Narg, *qarg, *barg, *Barg,
> +	*rarg, *Rarg, *aarg, *Targ;
> +static int nflag, Nflag, qflag, bflag, Bflag, dflag,
> +	rflag, Rflag, aflag, Hflag, Tflag, gflag;
> +
> +/* how long a client must wait for the server's reply, microsec */
> +static long wait_timeout = 10000000;
> +
> +/* common params */
> +static int skip_cleanup;
> +static int verbose;
> +
> +static const option_t options[] = {
> +	/* server params */
> +	{"R:", &Rflag, &Rarg},
> +	{"q:", &qflag, &qarg},
> +
> +	/* client params */
> +	{"H:", &Hflag, &server_addr},
> +	{"a:", &aflag, &aarg},
> +	{"n:", &nflag, &narg},
> +	{"b:", &bflag, &barg},
> +	{"N:", &Nflag, &Narg},
> +	{"B:", &Bflag, &Barg},
> +	{"T:", &Tflag, &Targ},
> +	{"r:", &rflag, &rarg},
> +	{"d:", &dflag, &rpath},
> +
> +	/* common */
> +	{"g:", &gflag, &tcp_port},
> +	{"F", &force_run, NULL},
> +	{"l", &tcp_mode, NULL},
> +	{"o", &tcp_api, NULL},
> +	{"O", &tfo_support, NULL},
> +	{"s", &skip_cleanup, NULL},
> +	{"v", &verbose, NULL},
> +	{NULL, NULL, NULL}
> +};
> +
> +static void help(void)
> +{
> +	printf("\n  -s      Skip cleanup\n");
> +	printf("  -F      Force to run\n");
> +	printf("  -v      Verbose\n");
> +	printf("  -o      Use old TCP API, default is new TCP API\n");
> +	printf("  -O      TFO support is off, default is on\n");
> +	printf("  -l      Become TCP Client, default is TCP server\n");
> +	printf("  -g x    x - server port, default is %s\n", tcp_port);
> +
> +	printf("\n          Client:\n");
> +	printf("  -H x    x - server name or ip address, default is '%s'\n",
> +		server_addr);
> +	printf("  -a x    x - num of clients running in parallel\n");
> +	printf("  -r x    x - num of client requests\n");
> +	printf("  -n x    Client message size, max msg size is '%d'\n",
> +		max_msg_len);
> +	printf("  -b x    x is a byte of client message\n");
> +	printf("  -N x    Server message size, max msg size is '%d'\n",
> +		max_msg_len);
> +	printf("  -B x    x is a byte of server message\n");
> +	printf("  -T x    Reply timeout, default is '%ld' (microsec)\n",
> +		wait_timeout);
> +	printf("  -d x    x is a path to the file where results are saved\n");
> +
> +	printf("\n          Server:\n");
> +	printf("  -R x    x - num of requests, after which conn. closed\n");
> +	printf("  -q x    x - server's limit on the queue of TFO requests\n");
> +}
> +
> +struct tcp_func {
> +	void (*init)(void);
> +	void (*run)(void);
> +	void (*cleanup)(void);
> +};
> +static struct tcp_func tcp;
> +
> +#define MAX_THREADS	10000
> +
> +/* current thread size */
> +static pthread_attr_t attr;
> +static pthread_t *thread_ids;
> +static int threads_num;
> +static struct addrinfo *remote_addrinfo;
> +static struct addrinfo *local_addrinfo;
> +static const struct linger clo = { 1, 3 };
> +
> +static void cleanup(void)
> +{
> +	static int first = 1;
> +	if (!first)
> +		return;
> +	first = 0;
> +
> +	tst_resm(TINFO, "cleanup");
> +
> +	free(client_msg);
> +	free(server_msg);
> +
> +	if (skip_cleanup)
> +		return;
> +
> +	tcp.cleanup();
> +
> +	if (tfo_cfg_changed) {
> +		SAFE_FILE_SCANF(NULL, tfo_cfg, "%d", &tfo_cfg_value);
> +		tfo_cfg_value &= ~tfo_bit_num;
> +		tfo_cfg_value |= !tfo_support << (tfo_bit_num - 1);
> +		tst_resm(TINFO, "unset '%s' back to '%d'",
> +			tfo_cfg, tfo_cfg_value);
> +		SAFE_FILE_PRINTF(NULL, tfo_cfg, "%d", tfo_cfg_value);
> +	}
> +
> +	if (tw_reuse_changed) {
> +		SAFE_FILE_PRINTF(NULL, tcp_tw_reuse, "0");
> +		tst_resm(TINFO, "unset '%s' back to '0'", tcp_tw_reuse);
> +	}
> +	TEST_CLEANUP;
> +}
> +
> +int sock_recv_poll(int *fd, char *buf, const int *buf_size, int *offset)
> +{
> +	struct pollfd pfd;
> +	pfd.fd = *fd;
> +	pfd.events = POLLIN;
> +	int len = -1;
> +	while (1) {
> +		errno = 0;
> +		int ret = poll(&pfd, 1, wait_timeout / 1000);
> +		if (ret == -1) {
> +			if (errno == EINTR)
> +				continue;
> +			tst_resm(TFAIL | TERRNO, "poll failed at %s:%d",
> +				__FILE__, __LINE__);
> +			break;
> +		}
> +		if (ret == 0) {
> +			tst_resm(TFAIL, "msg timeout, sock '%d'", *fd);
> +			break;
> +		}
> +
> +		if (ret != 1 || !(pfd.revents & POLLIN))
> +			break;
> +
> +		errno = 0;
> +		len = recv(*fd, buf + *offset,
> +			*buf_size - *offset, MSG_DONTWAIT);
> +
> +		if (len == -1 && (errno == EINTR ||
> +			errno == EWOULDBLOCK || errno == EAGAIN))
> +			continue;
> +		else
> +			break;
> +	}
> +
> +	if (len == 0)
> +		tst_resm(TINFO, "sock was closed '%d'", *fd);
> +
> +	return len;
> +}
> +
> +void client_recv(int *fd, char *buf)
> +{
> +	int len, offset = 0;
> +
> +	while (1) {
> +
> +		len = sock_recv_poll(fd, buf, &server_msg_size, &offset);
> +
> +		/* socket closed or msg is not valid */
> +		if (len < 1 || (offset + len) > server_msg_size ||
> +			(buf[0] != start_byte && buf[0] != start_byte + 1)) {
> +			tst_resm(TFAIL | TERRNO,
> +				"recv failed, sock '%d'", *fd);
> +			shutdown(*fd, SHUT_WR);
> +			SAFE_CLOSE(NULL, *fd);
> +			*fd = -1;
> +			break;
> +		}
> +
> +		offset += len;
> +
> +		if (buf[offset - 1] != end_byte)
> +			continue;
> +
> +		if (verbose) {
> +			tst_resm_hexd(TINFO, buf, offset,
> +				"msg recv from sock %d:", *fd);
> +		}
> +
> +		if (buf[0] == start_byte + 1) {
> +			/* recv last msg, close socket */
> +			shutdown(*fd, SHUT_WR);
> +			SAFE_CLOSE(NULL, *fd);
> +			*fd = -1;
> +		}
> +		break;
> +	}
> +}
> +
> +int client_connect_send(int *cfd)
> +{
> +	*cfd = socket(AF_INET, SOCK_STREAM, 0);
> +	const int flag = 1;
> +	setsockopt(*cfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
> +
> +	if (*cfd == -1) {
> +		tst_resm(TWARN | TERRNO, "socket failed at %s:%d",
> +			__FILE__, __LINE__);
> +		return -1;
> +	}
> +
> +	if (tcp_api == TCP_NEW_API) {
> +		/* Replaces connect() + send()/write() */
> +		if (sendto(*cfd, client_msg, client_msg_size,
> +			MSG_FASTOPEN | MSG_NOSIGNAL,
> +			remote_addrinfo->ai_addr,
> +			remote_addrinfo->ai_addrlen) != client_msg_size) {
> +			tst_resm(TFAIL | TERRNO, "sendto failed");
> +			SAFE_CLOSE(NULL, *cfd);
> +			return -1;
> +		}
> +	} else {
> +		/* old TCP API */
> +		if (connect(*cfd, remote_addrinfo->ai_addr,
> +			remote_addrinfo->ai_addrlen)) {
> +			tst_resm(TFAIL | TERRNO, "connect failed");
> +			SAFE_CLOSE(NULL, *cfd);
> +			return -1;
> +		}
> +
> +		if (send(*cfd, client_msg, client_msg_size,
> +			MSG_NOSIGNAL) != client_msg_size) {
> +			tst_resm(TFAIL | TERRNO,
> +				"send failed on sock '%d'", *cfd);
> +			SAFE_CLOSE(NULL, *cfd);
> +			return -1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void *client_fn(void *arg)
> +{
> +	char buf[server_msg_size];
> +	int cfd, i;
> +
> +	/* connect & send requests */
> +	if (client_connect_send(&cfd))
> +		return NULL;
> +	client_recv(&cfd, buf);
> +
> +	for (i = 1; i < client_max_requests; ++i) {
> +
> +		/* check connection, it can be closed */
> +		int ret = 0;
> +		if (cfd != -1)
> +			ret = recv(cfd, buf, 1, MSG_DONTWAIT);
> +
> +		if (ret == 0) {
> +			/* try to reconnect and send */
> +			if (cfd != -1)
> +				SAFE_CLOSE(NULL, cfd);
> +
> +			if (client_connect_send(&cfd))
> +				return NULL;
> +			client_recv(&cfd, buf);
> +
> +			continue;
> +
> +		} else if (ret > 0) {
> +			tst_resm_hexd(TFAIL, buf, 1,
> +				"received after recv, sock '%d':", cfd);
> +		}
> +
> +		if (verbose) {
> +			tst_resm_hexd(TINFO, client_msg, client_msg_size,
> +				"try to send msg[%d]", i);
> +		}
> +
> +		if (send(cfd, client_msg, client_msg_size,
> +			MSG_NOSIGNAL) != client_msg_size) {
> +			tst_resm(TFAIL | TERRNO, "send failed");
> +			break;
> +		}
> +		client_recv(&cfd, buf);
> +	}
> +
> +	if (cfd != -1)
> +		SAFE_CLOSE(NULL, cfd);
> +	return NULL;
> +}
> +
> +union un_uint16 {
> +	char b[2];
> +	uint16_t val;
> +};
> +
> +static struct timeval tv_client_start;
> +static struct timeval tv_client_end;
> +
> +static void client_init(void)
> +{
> +	if (clients_num >= MAX_THREADS) {
> +		tst_brkm(TBROK, cleanup,
> +			"Unexpected num of clients '%d'",
> +			clients_num);
> +	}
> +
> +	thread_ids = SAFE_MALLOC(NULL, sizeof(pthread_t) * clients_num);
> +
> +	client_msg = SAFE_MALLOC(NULL, client_msg_size);
> +	memset(client_msg, client_byte, client_msg_size);
> +	client_msg[0] = start_byte;
> +	client_msg[1] = server_byte;
> +
> +	union un_uint16 un;
> +	un.val = htons(server_msg_size);
> +	memcpy(client_msg + 2, un.b, 2);
> +	client_msg[client_msg_size - 1] = end_byte;
> +
> +	struct addrinfo hints;
> +	memset(&hints, 0, sizeof(struct addrinfo));
> +	hints.ai_family = AF_INET;
> +	hints.ai_socktype = SOCK_STREAM;
> +	if (getaddrinfo(server_addr, tcp_port, &hints, &remote_addrinfo) != 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
> +
> +	gettimeofday(&tv_client_start, NULL);
> +	int i;
> +	for (i = 0; i < clients_num; ++i) {
> +		if (pthread_create(&thread_ids[i], 0, client_fn, NULL) != 0) {
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				"pthread_create failed at %s:%d",
> +				__FILE__, __LINE__);
> +		}
> +		++threads_num;
> +	}
> +}
> +
> +static void client_run(void)
> +{
> +	void *res = NULL;
> +	long clnt_time = 0;
> +
> +	int i;
> +	for (i = 0; i < clients_num; ++i)
> +		pthread_join(thread_ids[i], &res);
> +
> +	threads_num = 0;
> +
> +	gettimeofday(&tv_client_end, NULL);
> +	clnt_time = (tv_client_end.tv_sec - tv_client_start.tv_sec) * 1000000 +
> +		tv_client_end.tv_usec - tv_client_start.tv_usec;
> +
> +	tst_resm(TINFO, "total time '%ld' ms", clnt_time / 1000);
> +
> +	/* ask server to terminate */
> +	int cfd;
> +	client_msg[0] = start_byte + 1;
> +	if (!client_connect_send(&cfd)) {
> +		shutdown(cfd, SHUT_WR);
> +		SAFE_CLOSE(NULL, cfd);
> +	}
> +
> +	/* the script tcp_fastopen_run.sh will remove it */
> +	SAFE_FILE_PRINTF(cleanup, rpath, "%ld", clnt_time / 1000);
> +}
> +
> +static void client_cleanup(void)
> +{
> +	void *res = NULL;
> +	int i;
> +	for (i = 0; i < threads_num; ++i)
> +		pthread_join(thread_ids[i], &res);
> +
> +	free(thread_ids);
> +
> +	if (remote_addrinfo)
> +		freeaddrinfo(remote_addrinfo);
> +}
> +
> +void make_server_reply(const char *buf, char **msg, uint16_t *size)
> +{
> +	union un_uint16 un;
> +	memcpy(un.b, buf + 2, 2);
> +	*size = ntohs(un.val);
> +	if (*size < 2 || *size > max_msg_len)
> +		*size = 2;
> +
> +	if (msg == NULL) {
> +		tst_resm(TWARN, "failed to make a reply");
> +		return;
> +	}
> +
> +	*msg = SAFE_MALLOC(NULL, *size);
> +	memset(*msg, buf[1], *size - 1);
> +	(*msg)[*size - 1] = end_byte;
> +}
> +
> +void *server_fn(void *cfd)
> +{
> +	int *client_fd = cfd;
> +	int num_requests = 0, offset = 0;
> +	uint16_t reply_size = 0;
> +	char *msg = NULL, buf[max_msg_len];
> +	setsockopt(*client_fd, SOL_SOCKET, SO_LINGER, &clo, sizeof(clo));
> +	ssize_t len;
> +
> +	while (1) {
> +		errno = 0;
> +		len = sock_recv_poll(client_fd, buf, &max_msg_len, &offset);
> +
> +		if (len == 0) {
> +			break;
> +		} else if (len < 0 || (offset + len) > max_msg_len ||
> +			(buf[0] != start_byte && buf[0] != start_byte + 1)) {
> +			tst_resm(TFAIL, "recv failed, sock '%d'", *client_fd);
> +			break;
> +		}
> +
> +		offset += len;
> +
> +		if (buf[offset - 1] != end_byte) {
> +			tst_resm(TINFO, "msg is not complete, continue recv");
> +			continue;
> +		}
> +
> +		if (buf[0] == start_byte + 1)
> +			tst_brkm(TBROK, cleanup, "client asks to terminate...");
> +
> +		if (verbose) {
> +			tst_resm_hexd(TINFO, buf, offset,
> +				"msg recv from sock %d:", *client_fd);
> +		}
> +
> +		if (msg == NULL)
> +			make_server_reply(buf, &msg, &reply_size);
> +
> +		++num_requests;
> +
> +		/* if last message */
> +		if (num_requests >= server_max_requests)
> +			msg[0] = start_byte + 1;
> +		else
> +			msg[0] = start_byte;
> +
> +		if (send(*client_fd, msg, reply_size, MSG_NOSIGNAL) == -1)
> +			tst_resm(TWARN | TERRNO, "Error while sending msg");
> +		else {
> +			if (verbose) {
> +				tst_resm_hexd(TINFO, msg, reply_size,
> +					"msg sent:");
> +			}
> +		}
> +
> +		offset = 0;
> +
> +		if (num_requests >= server_max_requests) {
> +			if (verbose)
> +				tst_resm(TINFO, "Max reqs, close socket");
> +			shutdown(*client_fd, SHUT_WR);
> +			break;
> +		}
> +	}
> +
> +	free(msg);
> +	SAFE_CLOSE(NULL, *client_fd);
> +	free(client_fd);
> +
> +	return NULL;
> +}
> +
> +static void server_thread_add(int *client_fd)
> +{
> +	int *cfd = SAFE_MALLOC(NULL, sizeof(int));
> +	*cfd = *client_fd;
> +	pthread_t id;
> +	if (pthread_create(&id, &attr, server_fn, cfd) != 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"pthread_create failed at %s:%d", __FILE__, __LINE__);
> +	}
> +}
> +
> +static void server_init(void)
> +{
> +	struct addrinfo hints;
> +	memset(&hints, 0, sizeof(struct addrinfo));
> +	hints.ai_family = AF_INET;
> +	hints.ai_socktype = SOCK_STREAM;
> +	hints.ai_flags = AI_PASSIVE;
> +	if (getaddrinfo(NULL, tcp_port, &hints, &local_addrinfo) != 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "getaddrinfo failed");
> +
> +	sfd = socket(AF_INET, SOCK_STREAM, 0);
> +	if (sfd == -1)
> +		tst_brkm(TBROK, cleanup, "Failed to create a socket");
> +
> +	tst_resm(TINFO, "assigning a name to the server socket...");
> +	if (!local_addrinfo)
> +		tst_brkm(TBROK, cleanup, "failed to get the address");
> +
> +	while (bind(sfd, local_addrinfo->ai_addr,
> +		local_addrinfo->ai_addrlen) == -1) {
> +		sleep(1);
> +	}
> +	tst_resm(TINFO, "the name assigned");
> +
> +	const int flag = 1;
> +	setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &flag, sizeof(flag));
> +
> +	if (tcp_api == TCP_NEW_API) {
> +		if (setsockopt(sfd, IPPROTO_TCP, TCP_FASTOPEN, &tfo_queue_size,
> +			sizeof(tfo_queue_size)) == -1)
> +			tst_brkm(TBROK, cleanup, "Can't set TFO sock. options");
> +	}
> +
> +	listen(sfd, max_queue_len);
> +	tst_resm(TINFO, "Listen on the socket '%d', port '%s'", sfd, tcp_port);
> +}
> +
> +static void server_cleanup(void)
> +{
> +	SAFE_CLOSE(NULL, sfd);
> +	if (local_addrinfo)
> +		freeaddrinfo(local_addrinfo);
> +}
> +
> +static void server_run(void)
> +{
> +	struct sockaddr_in client_addr;
> +	socklen_t addr_size = sizeof(client_addr);
> +	pthread_attr_init(&attr);
> +
> +	/*
> +	 * detaching threads allow to reclaim thread's resources
> +	 * ones a thread finishs its work.
> +	 */
> +	if (pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED) != 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "setdetached failed");
> +
> +	while (1) {
> +		int client_fd = accept(sfd, (struct sockaddr *) &client_addr,
> +			&addr_size);
> +		if (client_fd == -1) {
> +			tst_brkm(TBROK, cleanup, "Can't create client socket");
> +			continue;
> +		}
> +
> +		if (client_addr.sin_family == AF_INET) {
> +			if (verbose) {
> +				tst_resm(TINFO, "conn: port '%d', addr '%s'",
> +					client_addr.sin_port,
> +					inet_ntoa(client_addr.sin_addr));
> +			}
> +		}
> +		server_thread_add(&client_fd);
> +	}
> +}
> +
> +static void check_opt(const char *name, int *flag,
> +	char *arg, int *val, int lim)
> +{
> +	if (*flag) {
> +		if (sscanf(arg, "%i", val) != 1)
> +			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
> +				 name);
> +		if (clients_num < lim)
> +			tst_brkm(TBROK, NULL, "-%s option arg is less than %d",
> +				name, lim);
> +	}
> +}
> +
> +static void check_opt_l(const char *name, int *flag,
> +	char *arg, long *val, long lim)
> +{
> +	if (*flag) {
> +		if (sscanf(arg, "%ld", val) != 1)
> +			tst_brkm(TBROK, NULL, "-%s option arg is not a number",
> +				 name);
> +		if (clients_num < lim)
> +			tst_brkm(TBROK, NULL, "-%s option arg is less than %ld",
> +				name, lim);
> +	}
> +}
> +
> +/* cleanup flags */
> +void setup(int argc, char *argv[])
> +{
> +	char *msg;
> +	msg = parse_opts(argc, argv, options, help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	/* if client num is not set, use num of processors */
> +	struct sysinfo si;
> +	if (sysinfo(&si) == 0)
> +		clients_num = si.procs;
> +
> +	check_opt("a", &aflag, aarg, &clients_num, 1);
> +	check_opt("r", &rflag, rarg, &client_max_requests, 1);
> +	check_opt("R", &Rflag, Rarg, &server_max_requests, 1);
> +	check_opt("n", &nflag, narg, &client_msg_size, 1);
> +
> +	check_opt("b", &bflag, barg, &client_byte, 0);
> +	if (client_byte == start_byte || client_byte == end_byte)
> +		tst_brkm(TBROK, NULL, "-b option, wrong arg");
> +
> +	check_opt("N", &Nflag, Narg, &server_msg_size, 1);
> +
> +	check_opt("B", &Bflag, Barg, &server_byte, 0);
> +	if (server_byte == start_byte || server_byte == end_byte)
> +		tst_brkm(TBROK, NULL, "-B option, wrong arg");
> +
> +	check_opt("q", &qflag, qarg, &tfo_queue_size, 1);
> +	check_opt_l("T", &Tflag, Targ, &wait_timeout, 0L);
> +
> +	if (!force_run)
> +		tst_require_root(NULL);
> +
> +	if (!force_run && tst_kvercmp(3, 7, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			"Test must be run with kernel 3.7 or newer");
> +	}
> +
> +	/* check tcp fast open knob */
> +	if (!force_run && access(tfo_cfg, F_OK) == -1)
> +		tst_brkm(TCONF, NULL, "Failed to find '%s'", tfo_cfg);
> +
> +	if (!force_run) {
> +		SAFE_FILE_SCANF(cleanup, tfo_cfg, "%d", &tfo_cfg_value);
> +		tst_resm(TINFO, "'%s' is %d", tfo_cfg, tfo_cfg_value);
> +	}
> +
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +
> +	main_pid = getpid();
> +	tst_resm(TINFO, "pid '%d'", main_pid);
> +	tst_resm(TINFO, "TCP %s is using %s TCP API.",
> +		(tcp_mode == TCP_SERVER) ? "server" : "client",
> +		(tcp_api == TCP_NEW_API) ? "new" : "old");
> +
> +	switch (tcp_mode) {
> +	case TCP_SERVER:
> +		tst_resm(TINFO, "max requests '%d'",
> +			server_max_requests);
> +		tcp.init	= server_init;
> +		tcp.run		= server_run;
> +		tcp.cleanup	= server_cleanup;
> +		tfo_bit_num = 2;
> +	break;
> +	case TCP_CLIENT:
> +		tst_resm(TINFO, "connection: %s:%s",
> +		server_addr, tcp_port);
> +		tst_resm(TINFO, "client max req: %d", client_max_requests);
> +		tst_resm(TINFO, "clients num: %d", clients_num);
> +		tst_resm(TINFO, "client msg size: %d", client_msg_size);
> +		tst_resm(TINFO, "server msg size: %d", server_msg_size);
> +		tst_resm(TINFO, "client msg byte: %02x", client_byte);
> +		tst_resm(TINFO, "server msg byte: %02x", server_byte);
> +
> +		tcp.init	= client_init;
> +		tcp.run		= client_run;
> +		tcp.cleanup	= client_cleanup;
> +		tfo_bit_num = 1;
> +	break;
> +	}
> +
> +	tfo_support = TFO_ENABLED == tfo_support;
> +	if (((tfo_cfg_value & tfo_bit_num) == tfo_bit_num) != tfo_support) {
> +		int value = (tfo_cfg_value & ~tfo_bit_num)
> +			| (tfo_support << (tfo_bit_num - 1));
> +		tst_resm(TINFO, "set '%s' to '%d'", tfo_cfg, value);
> +		SAFE_FILE_PRINTF(cleanup, tfo_cfg, "%d", value);
> +		tfo_cfg_changed = 1;
> +	}
> +
> +	int reuse_value = 0;
> +	SAFE_FILE_SCANF(cleanup, tcp_tw_reuse, "%d", &reuse_value);
> +	if (!reuse_value) {
> +		SAFE_FILE_PRINTF(cleanup, tcp_tw_reuse, "1");
> +		tw_reuse_changed = 1;
> +		tst_resm(TINFO, "set '%s' to '1'", tcp_tw_reuse);
> +	}
> +
> +	tst_resm(TINFO, "TFO support %s",
> +		(tfo_support) ? "enabled" : "disabled");
> +
> +	tcp.init();
> +}
> +
> +static void test_run()
> +{
> +	tcp.run();
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	setup(argc, argv);
> +
> +	test_run();
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> new file mode 100755
> index 0000000..d56c510
> --- /dev/null
> +++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
> @@ -0,0 +1,190 @@
> +#!/bin/bash
> +
> +# Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
> +#
> +
> +# default command-line options
> +user_name="root"
> +remote_addr=$RHOST
> +use_ssh=0
> +client_requests=2000000
> +server_port=$[ $RANDOM % 28232 + 32768 ]
> +
> +while getopts :hu:H:sr:p: opt; do
> +	case "$opt" in
> +	h)
> +		echo "Usage:"
> +		echo "h        help"
> +		echo "u x      server user name"
> +		echo "H x      server hostname or IP address"
> +		echo "s        use ssh to run remote cmds"
> +		echo "r x      the number of requests"
> +		echo "p x      server port"
> +		exit 0
> +	;;
> +	u) user_name=$OPTARG ;;
> +	H) remote_addr=$OPTARG ;;
> +	s) use_ssh=1 ;;
> +	r) client_requests=$OPTARG ;;
> +	p) server_port=$OPTARG ;;
> +	*)
> +		tst_brkm TBROK NULL "unknown option: $opt"
> +		exit 2
> +	;;
> +	esac
> +done
> +
> +run_remote_cmd()
> +{
> +	tst_resm TINFO "run cmd on $remote_addr: $1"
> +
> +	if [ "$use_ssh" = 1 ]; then
> +		ssh -n -f $user_name@$remote_addr "sh -c 'nohup $1 &'"
> +	else
> +		rsh -n -l $user_name $remote_addr "sh -c 'nohup $1 &'"
> +	fi
> +}
> +
> +cleanup()
> +{
> +	rm -f $tfo_result
> +	run_remote_cmd "pgrep tcp_fastopen && killall -9 tcp_fastopen"
> +	# remove test files on remote host
> +	sleep 2
> +	run_remote_cmd "[ -e ${tdir}tcp_fastopen ] && rm -f ${tdir}tcp_fastopen"
> +	sleep 2
> +}
> +
> +read_result_file()
> +{
> +	if [ -f $tfo_result ]; then
> +		if [ -r $tfo_result ]; then
> +			cat $tfo_result
> +		else
> +			tst_brkm TBROK NULL "Failed to read result file"
> +			exit 2
> +		fi
> +	else
> +		tst_brkm TBROK NULL "Failed to find result file"
> +		exit 2
> +	fi
> +}
> +
> +check_exit_status()
> +{
> +	if [ "$1" -ne "0" ]; then
> +		tst_brkm TBROK NULL "Last test has failed"
> +		exit $1;
> +	fi
> +}
> +
> +export RC=0
> +export TST_TOTAL=1
> +export TCID="tcp_fastopen"
> +export TST_COUNT=0
> +
> +tfo_result_ms=0
> +bind_timeout=10
> +clients_num=2
> +max_requests=3
> +msg_timeout=10000000
> +
> +# Setup
> +type tst_resm > /dev/null 2>&1
> +if [ $? -eq 1 ]; then
> +	echo "$TCID    0  TCONF  :  failed to find LTP tst_* utilities"
> +	exit 2
> +fi
> +
> +tst_kvercmp 3 7 0
> +if [ $? -eq 0 ]; then
> +	tst_brkm TCONF NULL "test must be run with kernel 3.7 or newer"
> +	exit 0
> +fi
> +
> +if [ -z $remote_addr ]; then
> +	tst_brkm TBROK NULL "you must specify server address"
> +	exit 2
> +fi
> +
> +
> +if [ -z $LTPROOT ]; then
> +	tdir="./"
> +else
> +	tdir=${LTPROOT}/testcases/bin/
> +fi
> +
> +if [ -z "$TMPDIR" ]; then
> +	tfo_result="${tdir}tfo_result"
> +else
> +	tfo_result="${TMPDIR}/tfo_result"
> +fi
> +
> +trap "cleanup" EXIT
> +
> +run_remote_cmd "[ ! -e $tdir ] && mkdir -p $tdir"
> +
> +if [ "$use_ssh" = 1 ]; then
> +	scp ${tdir}tcp_fastopen $user_name@$remote_addr:$tdir > /dev/null
> +else
> +	rcp ${tdir}tcp_fastopen $user_name@$remote_addr:$tdir > /dev/null
> +fi
> +
> +
> +# Run
> +tcp_api_opt=("-o -O" "")
> +vtime=(0 0)
> +
> +for (( i = 0; i < 2; ++i )); do
> +	# kill tcp server on remote machine
> +	run_remote_cmd "pgrep tcp_fastopen && killall -9 tcp_fastopen"
> +
> +	sleep 2
> +
> +	# run tcp server on remote machine
> +	run_remote_cmd "${tdir}tcp_fastopen -R $max_requests -q 100 \
> +${tcp_api_opt[$i]} -g $server_port > /dev/null 2>&1"
> +
> +	sleep $bind_timeout
> +
> +	# run local tcp client
> +	${tdir}tcp_fastopen -a $clients_num -r $client_requests -l \
> +-n 32 -b 23 -N 128 -B 8 -T $msg_timeout -H $remote_addr \
> +${tcp_api_opt[$i]} -g $server_port -d $tfo_result
> +
> +	check_exit_status $?
> +
> +	vtime[$i]=`read_result_file`
> +
> +	if [ -z ${vtime[$i]} -o ${vtime[$i]} -eq "0" ]; then
> +		tst_brkm TBROK NULL "Last test result isn't valid: ${vtime[$i]}"
> +		exit 2
> +	fi
> +	server_port=$[ $server_port + 1 ]
> +done
> +
> +tfo_cmp=$[ 100 - (${vtime[1]} * 100) / ${vtime[0]} ]
> +
> +if (( $tfo_cmp < 3 )); then
> +	tst_resm TFAIL "TFO performance result is $tfo_cmp percent"
> +	exit 1
> +fi
> +
> +tst_resm TPASS "TFO performance result is $tfo_cmp percent"
> +exit 0
> -- 
> 1.7.1

Tested on F18 and looks good.

Acked-by Hangbin Liu <liuhangbin@gmail.com>
> 
> 
> ------------------------------------------------------------------------------
> October Webinars: Code for Performance
> Free Intel webinars can help you accelerate application performance.
> Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
> the latest Intel processors and coprocessors. See abstracts and register >
> http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 

Thanks & Best Regards
Hangbin Liu <liuhangbin@gmail.com>

------------------------------------------------------------------------------
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
