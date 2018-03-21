From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Mar 2018 15:26:59 +0100
Subject: [LTP] [PATCH] cve: new regression test-case for CVE-2018-5803
In-Reply-To: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
References: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <87tvt9mrm4.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Alexey,

Alexey Kodanev writes:

> There are two test-cases in runtest/cve:
> * cve-2018-5803 - for over-sized INIT_ACK packet
> * cve-2018-5803_2 - for over-sized INIT packet

Naming tests purely after a CVE number seems to have been a mistake on
my part because people are unable to recognise them. Could this be given
a more descriptive name and location (i.e something with net and sctp in
the name?). Of course it should still go in the cve runtest file.

>
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
>  include/lapi/socket.h         |    4 +
>  runtest/cve                   |    2 +
>  testcases/cve/.gitignore      |    1 +
>  testcases/cve/cve-2018-5803.c |  124 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 131 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/cve/cve-2018-5803.c
>
> diff --git a/include/lapi/socket.h b/include/lapi/socket.h
> index 426906f..d58c460 100644
> --- a/include/lapi/socket.h
> +++ b/include/lapi/socket.h
> @@ -45,6 +45,10 @@
>  # define SOCK_CLOEXEC 02000000
>  #endif
>
> +#ifndef SOL_SCTP
> +# define SOL_SCTP	132
> +#endif
> +
>  #ifndef SOL_UDPLITE
>  # define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
>  #endif
> diff --git a/runtest/cve b/runtest/cve
> index 0c385c6..826bb0b 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -30,3 +30,5 @@ cve-2017-17807 request_key04
>  cve-2017-1000364 stack_clash
>  cve-2017-5754 meltdown
>  cve-2017-17052 cve-2017-17052
> +cve-2018-5803 cve-2018-5803
> +cve-2018-5803_2 cve-2018-5803 -a 10000
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index c878069..31200c6 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -12,3 +12,4 @@ cve-2017-5669
>  meltdown
>  stack_clash
>  cve-2017-17052
> +cve-2018-5803
> diff --git a/testcases/cve/cve-2018-5803.c b/testcases/cve/cve-2018-5803.c
> new file mode 100644
> index 0000000..3f03d8a
> --- /dev/null
> +++ b/testcases/cve/cve-2018-5803.c
> @@ -0,0 +1,124 @@
> +/*
> + * Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
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
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Regression test-case for the crash caused by over-sized SCTP chunk,
> + * fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a new
> + * chunk in _sctp_make_chunk()")
> + */
> +
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <netdb.h>
> +#include <sys/syscall.h>
> +#include <fcntl.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "lapi/netinet_in.h"
> +#include "lapi/socket.h"
> +
> +static int port;
> +static int sfd, cfd;
> +static struct sockaddr_in6 rmt, loc;
> +
> +static char *addr_param;
> +static int addr_num = 3273;
> +
> +#ifndef SCTP_SOCKOPT_BINDX_ADD
> +# define SCTP_SOCKOPT_BINDX_ADD	100
> +#endif
> +
> +static void setup_server(void)
> +{
> +	loc.sin6_family = AF_INET6;
> +	loc.sin6_addr = in6addr_loopback;
> +
> +	sfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
> +	SAFE_BIND(sfd, (struct sockaddr *)&loc, sizeof(loc));
> +
> +	port = TST_GETSOCKPORT(sfd);
> +	tst_res(TINFO, "sctp server listen on %d", port);
> +
> +	SAFE_LISTEN(sfd, 1);
> +}
> +
> +static void setup_client(void)
> +{
> +	struct sockaddr_in6 addr_buf[addr_num];
> +	int i;
> +
> +	cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
> +	rmt.sin6_family = AF_INET6;
> +	rmt.sin6_addr = in6addr_loopback;
> +	rmt.sin6_port = htons(port);
> +
> +	tst_res(TINFO, "bind %d additional IP addresses", addr_num);
> +
> +	memset(addr_buf, 0, sizeof(addr_buf));
> +	for (i = 0; i < addr_num; ++i) {
> +		addr_buf[i].sin6_family = AF_INET6;
> +		addr_buf[i].sin6_addr = in6addr_loopback;
> +	}
> +
> +	SAFE_SETSOCKOPT(cfd, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, addr_buf,
> +			sizeof(addr_buf));
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_parse_int(addr_param, &addr_num, 1, INT_MAX))
> +		tst_brk(TBROK, "wrong address number '%s'", addr_param);
> +
> +	setup_server();
> +	setup_client();
> +}
> +
> +static void run(void)
> +{
> +	int pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		struct sockaddr_in6 addr6;
> +		socklen_t addr_size = sizeof(addr6);
> +
> +		if (accept(sfd, (struct sockaddr *)&addr6, &addr_size) < 0)
> +			tst_brk(TBROK | TERRNO, "accept() failed");
> +		exit(0);
> +	}
> +
> +	fcntl(cfd, F_SETFL, O_NONBLOCK);
> +	connect(cfd, (struct sockaddr *)&rmt, sizeof(rmt));
> +
> +	SAFE_KILL(pid, SIGKILL);
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	tst_res(TPASS, "test doesn't cause crash");
> +}
> +
> +static struct tst_option options[] = {
> +	{"a:", &addr_param, "-a       number of additional IP address params"},
> +	{NULL, NULL, NULL}
> +};
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.forks_child = 1,
> +	.test_all = run,
> +	.options = options
> +};
> --
> 1.7.1


--
Thank you,
Richard.
