From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 May 2021 12:04:21 +0200
Subject: [LTP] [PATCH v3 6/6] Add test for CVE 2020-25705
In-Reply-To: <20210505081845.7024-6-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
 <20210505081845.7024-6-mdoucha@suse.cz>
Message-ID: <YJJtpXWM4BxH2ffu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Fixes #742

LGTM. Few unimportant comments below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/testcases/cve/cve-2020-25705.c b/testcases/cve/cve-2020-25705.c
> new file mode 100644
> index 000000000..7d6bbafa8
> --- /dev/null
> +++ b/testcases/cve/cve-2020-25705.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 SUSE LLC
> + * Author: Nicolai Stange <nstange@suse.de>
> + * LTP port: Martin Doucha <mdoucha@suse.cz>
> + *
> + * CVE-2020-25705
> + *
> + * Test of ICMP rate limiting behavior that may be abused for DNS cache
> + * poisoning attack. Send a few batches of 100 packets to a closed UDP port
> + * and count the ICMP errors. If the number of errors is always the same
> + * for each batch (not randomized), the system is vulnerable. Send packets
> + * from multiple IP addresses to bypass per-address ICMP throttling.
We probably turn this into docparse during merge.

> + *
> + * Fixed in:
> + *
> + *  commit b38e7819cae946e2edf869e604af1e65a5d241c5
> + *  Author: Eric Dumazet <edumazet@google.com>
> + *  Date:   Thu Oct 15 11:42:00 2020 -0700
> + *
> + *  icmp: randomize the global rate limiter
> + */
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <linux/if_addr.h>
> +#include <linux/errqueue.h>

#include <time.h>

to fix build failure on MUSL:

cve-2020-25705.c:262:1: warning: missing initializer for field 'needs_cmds' of 'struct tst_test' [-Wmissing-field-initializers]
https://travis-ci.org/github/pevik/ltp/jobs/769551152

> +#include <sched.h>
> +#include <limits.h>
> +#include "tst_test.h"
> +#include "tst_netdevice.h"
> +
> +#define DSTADDR 0xfa444e02 /* 250.68.78.2 */
> +#define SRCADDR_BASE 0xfa444e41 /* 250.68.78.65 */
> +#define SRCADDR_COUNT 50
> +#define BATCH_COUNT 8
> +#define BUFSIZE 1024
> +
> +static int parentns = -1, childns = -1;
> +static int fds[SRCADDR_COUNT];
> +
> +static void setup(void)
> +{
...
> +	/*
> +	 * Create network namespace to hide the destination interface from
> +	 * the test process.
> +	 */
> +	parentns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
> +	SAFE_UNSHARE(CLONE_NEWNET);
> +
> +	/* Do NOT close this FD, or both interfaces will be destroyed */
> +	childns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
> +
> +	/* Configure child namespace */
> +	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
> +	addr = DSTADDR;
> +	NETDEV_ADD_ADDRESS_INET("ltp_veth2", htonl(addr), 26,
> +		IFA_F_NOPREFIXROUTE);

I wonder if it'd be useful *later* (not bothering with it now) to allow tests
just declare .needs_netdevice = 1 and have generic network setup done (similarly
it's done in tst_net.sh). Or just define addresses a prefixes and do library to
do the setup.

> +	NETDEV_SET_STATE("ltp_veth2", 1);
> +	NETDEV_ADD_ROUTE_INET("ltp_veth2", 0, 0, htonl(0xfa444e40), 26,
nit: maybe define 0xfa444e40 (and 0xfa444e00) and 26 as constants?
> +		0);
> +
> +	/* Configure parent namespace */
> +	NETDEV_CHANGE_NS_FD("ltp_veth1", parentns);
> +	SAFE_SETNS(parentns, CLONE_NEWNET);
> +	addr = SRCADDR_BASE; /* 250.68.78.65 */
nit: maybe repeating the address in the comment is not needed.
> +
> +	for (i = 0; i < SRCADDR_COUNT; i++, addr++) {
> +		NETDEV_ADD_ADDRESS_INET("ltp_veth1", htonl(addr), 26,
> +			IFA_F_NOPREFIXROUTE);
> +	}
> +
> +	NETDEV_SET_STATE("ltp_veth1", 1);
> +	NETDEV_ADD_ROUTE_INET("ltp_veth1", 0, 0, htonl(0xfa444e00), 26, 0);

> +	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/conf/ltp_veth1/forwarding", "1");
> +
> +	/* Open test sockets */
> +	for (i = 0; i < SRCADDR_COUNT; i++) {
> +		ipaddr.sin_addr.s_addr = htonl(SRCADDR_BASE + i);
> +		fds[i] = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
> +		SAFE_SETSOCKOPT_INT(fds[i], IPPROTO_IP, IP_RECVERR, 1);
> +		SAFE_BIND(fds[i], (struct sockaddr *)&ipaddr, sizeof(ipaddr));
> +	}
> +}
> +
> +static int count_icmp_errors(int fd)
> +{
> +	int error_count = 0;
> +	ssize_t len;
> +	char msgbuf[BUFSIZE], errbuf[BUFSIZE];
> +	struct sockaddr_in addr;
> +	struct cmsghdr *cmsg;
> +	struct sock_extended_err exterr;
> +	struct iovec iov = {
> +		.iov_base = msgbuf,
> +		.iov_len = BUFSIZE
> +	};
> +
> +	while (1) {
> +		struct msghdr msg = {
> +			.msg_name = (struct sockaddr *)&addr,
> +			.msg_namelen = sizeof(addr),
> +			.msg_iov = &iov,
> +			.msg_iovlen = 1,
> +			.msg_flags = 0,
> +			.msg_control = errbuf,
> +			.msg_controllen = BUFSIZE
> +		};
> +
> +		memset(errbuf, 0, BUFSIZE);
> +		errno = 0;
> +		len = recvmsg(fd, &msg, MSG_ERRQUEUE);
> +
> +		if (len == -1) {
> +			if (errno == EWOULDBLOCK || errno == EAGAIN)
> +				break;
> +
> +			tst_brk(TBROK | TERRNO, "recvmsg() failed");
> +		}
> +
> +		if (len < 0) {
> +			tst_brk(TBROK | TERRNO,
> +				"Invalid recvmsg() return value %zd", len);
> +		}
> +
> +		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
> +			cmsg = CMSG_NXTHDR(&msg, cmsg)) {
> +			if (cmsg->cmsg_level != SOL_IP)
> +				continue;
> +
> +			if (cmsg->cmsg_type != IP_RECVERR)
> +				continue;
> +
> +			memcpy(&exterr, CMSG_DATA(cmsg), sizeof(exterr));
> +
> +			if (exterr.ee_origin != SO_EE_ORIGIN_ICMP)
> +				tst_brk(TBROK, "Unexpected non-ICMP error");
> +
> +			if (exterr.ee_errno != ECONNREFUSED) {
> +				TST_ERR = exterr.ee_errno;
> +				tst_brk(TBROK | TTERRNO,
> +					"Unexpected ICMP error");
> +			}
> +
> +			error_count++;
> +		}
> +	}
> +
> +	return error_count;
> +}

FYI I tested the test on several VM. Very old kernel detects problem only on
more runs. But given it's 3.16 (and b38e7819cae9 is a fix for 4cdf507d5452 from
v3.18-rc1 we can ignore this).

Kind regards,
Petr

# ./cve-2020-25705
tst_kconfig.c:64: TINFO: Parsing kernel config '/boot/config-3.16.0-11-amd64'
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
cve-2020-25705.c:217: TINFO: Batch 0: Got 85 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 1: Got 100 ICMP errors
cve-2020-25705.c:230: TPASS: ICMP rate limit is randomized

-i2
# ./cve-2020-25705 -i2
tst_kconfig.c:64: TINFO: Parsing kernel config '/boot/config-3.16.0-11-amd64'
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
cve-2020-25705.c:217: TINFO: Batch 0: Got 85 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 1: Got 100 ICMP errors
cve-2020-25705.c:230: TPASS: ICMP rate limit is randomized
cve-2020-25705.c:217: TINFO: Batch 0: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 1: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 2: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 3: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 4: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 5: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 6: Got 100 ICMP errors
cve-2020-25705.c:221: TINFO: Batch 7: Got 100 ICMP errors
cve-2020-25705.c:226: TFAIL: ICMP rate limit not randomized, system is vulnerable

HINT: You _MAY_ be missing kernel fixes, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b38e7819cae9

HINT: You _MAY_ be vulnerable to CVE(s), see:

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2020-25705

Summary:
passed   1
failed   1
broken   0
skipped  0
warnings 0
