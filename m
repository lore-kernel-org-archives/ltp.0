From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Jun 2019 14:59:03 +0300
Subject: [LTP] [RFC PATCH v2 6/6] net/route: Rewrite route{4,
 6}-change-{dst, gw} into C
In-Reply-To: <20190510183132.31039-7-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
 <20190510183132.31039-7-pvorel@suse.cz>
Message-ID: <5ae7fa5e-5a95-dd7b-a4cf-b4f6f699804a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10.05.2019 21:31, Petr Vorel wrote:
> Code:
> * use libmnl and new C API
> * reuse code in tst_net.h (added in previous commit)
> * add shell wrapper (set environment with tst_net.sh instead of using
>   deprecated helpers in testcases/network/stress/ns-tools/)
> * Add tst_ipaddr_un() into C API, unlike shell API this implementation
>   does not support -c tst_ipaddr_un [-cCOUNTER] [TYPE] syntax.
> 
> Travis:
> * add libmnl libraries to most of travis jobs
> * replace spaces with tabs some travis shell files
> 
> Cleanup:
> * cleanup test description
> * other cleanup
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
...
> +}
> +
> +static void send_udp(char *local, char *remote)
> +{
> +	fd = SAFE_SOCKET(family, SOCK_DGRAM, IPPROTO_UDP);
> +
> +	struct addrinfo hints;
> +	memset(&hints, 0, sizeof(struct addrinfo));
> +	hints.ai_family = family;
> +	hints.ai_socktype = SOCK_DGRAM;
> +	hints.ai_flags = 0;
> +	hints.ai_protocol = 0;
> +	hints.ai_addr = INADDR_ANY;
> +	setup_addrinfo(local, NULL, &hints, &local_addrinfo);
> +	char *port;
> +	int _port = TST_GET_UNUSED_PORT(family, SOCK_DGRAM);
> +	SAFE_ASPRINTF(&port, "%d", _port);
> +	setup_addrinfo(remote, port, &hints, &remote_addrinfo);
> +

Getting local unused port and using as a remote port?


> +	SAFE_BIND(fd, local_addrinfo->ai_addr, local_addrinfo->ai_addrlen);
> +

TST_GET_UNUSED_PORT and SAFE_BIND look redundant, what is the purpose to use
them here?

> +	SAFE_SENDTO(1, fd, remote, strlen(remote), MSG_CONFIRM,
> +		remote_addrinfo->ai_addr, remote_addrinfo->ai_addrlen);
> +
> +	close(fd);
> +}
> +
> +static void run(void)
> +{
> +	int i, j;
> +	char *destination, *gateway = NULL, *local, *remote;
> +
> +	tst_res(TINFO, "Adding and deleting route with different destination %d times", num_loops);
> +	for (i = 0; i < num_loops; i++) {
> +		j = i % max_ip;
> +		local = tst_ipaddr_un(family, j, lhost);
> +		remote = tst_ipaddr_un(family, j, rhost);
> +		if (g_opt) {
> +			destination = tst_ipaddr_un(family, 0, 0);
> +			gateway = tst_ipaddr_un(family, j, gwhost);
> +		} else {
> +			destination = tst_ipaddr_un(family, j, 0);
> +		}
> +
> +		rtnl_route(iface, destination, prefix, gateway, RTM_NEWROUTE);
> +		send_udp(local, remote);
> +		rtnl_route(iface, destination, prefix, gateway, RTM_DELROUTE);
> +	}
> +
> +	tst_res(TPASS, "Routes created and deleted");
> +}
> +
