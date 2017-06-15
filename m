From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Jun 2017 18:00:20 +0300
Subject: [LTP] [RFC PATCH v6 10/11] network: Add tools for setup IP
 related environment variables
In-Reply-To: <20170603120022.13415-11-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
 <20170603120022.13415-11-pvorel@suse.cz>
Message-ID: <c1797439-042a-c395-d74a-6d91f66463d3@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
On 06/03/2017 03:00 PM, Petr Vorel wrote:
> tst_net_vars take input of local and remote address and setup most of
> test link (IP related) environment variables.
>
> For full list of environment variables which it setup run:
> tst_net_vars -h
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/.gitignore     |   1 +
>  testcases/lib/Makefile       |   4 +-
>  testcases/lib/tst_net_vars.c | 802 +++++++++++++++++++++++++++++++++++++++++++

Looks good, minor comments below.

> +}
> +
> +static int read_prefix_iface(const char *ip_str, int is_ipv6)
> +{
> +	uint8_t family = is_ipv6 ? AF_INET6 : AF_INET;
> +
> +	char buf[16384];
> +	int len;
> +
> +	struct {
> +		struct nlmsghdr nlhdr;
> +		struct ifaddrmsg addrmsg;
> +	} msg;
> +
> +	struct nlmsghdr *retmsg;
> +
> +	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);

Can we change it to SAFE_SOCKET and use other 'safe' functions in
tst_net_vars?

> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
> +	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
> +	msg.nlhdr.nlmsg_type = RTM_GETADDR;
> +	msg.addrmsg.ifa_family = family;
> +
> +	send(sock, &msg, msg.nlhdr.nlmsg_len, 0);
> +	len = recv(sock, buf, sizeof(buf), 0);

Here as well.


Also I got a couple of warnings from gcc:

tst_net_vars.c: In function ‘get_ipv6_net32_unused’:
tst_net_vars.c:239: warning: missing braces around initializer
tst_net_vars.c:239: warning: (near initialization for ‘mask.__in6_u’)

better use memset() for portability with older gcc.

tst_net_vars.c: In function ‘read_prefix_iface’:
tst_net_vars.c:592: warning: comparison between signed and unsigned
integer expressions

Please also check the patch with checkpatch utility.

Thanks,
Alexey

