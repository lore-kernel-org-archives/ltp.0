From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 8 Sep 2017 10:30:10 +0300
Subject: [LTP] [RFC PATCH v9 6/7] network: Add tools for setup IP
 related environment variables
In-Reply-To: <20170824234436.18145-7-pvorel@suse.cz>
References: <20170824234436.18145-1-pvorel@suse.cz>
 <20170824234436.18145-7-pvorel@suse.cz>
Message-ID: <6796162e-c84e-05a4-8350-c94feb5d2513@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 08/25/2017 02:44 AM, Petr Vorel wrote:
> New tools:
> * tst_net_ip_prefix
> Strip prefix from IP address and save both
> If no prefix found sets default prefix.
>
> * tst_net_iface_prefix
> tst_net_iface_prefix reads prefix and interface from rtnetlink.
>
> * tst_net_vars takes input of local and remote address and setup most of
> test link (IP related) environment variables.
>
> NOTABLE CHANGES IN ENVIRONMENT VARIABLES:
> Network variables are defined for both local and remote:
> IPV4_NETWORK was replaced by IPV4_LNETWORK and IPV4_RNETWORK
> IPV6_NETWORK was replaced by IPV6_LNETWORK and IPV6_RNETWORK
>
> NEW VARIABLES:
> IPV4_LHOST, IPV4_RHOST, IPV4_LNETMASK, IPV4_RNETMASK, IPV4_LPREFIX, IPV4_RPREFIX,
> IPV6_LHOST, IPV6_RHOST, IPV6_LNETMASK, IPV6_RNETMASK, IPV6_LPREFIX, IPV6_RPREFIX,
>
> For full list of environment variables which tools setup run:
> tst_net_ip_prefix -h
> tst_net_iface_prefix -h
> tst_net_vars -h
>
> Thanks a lot to Alexey Kodanev who reviewed many versions of this patch
> and give feedback and pointed out errors, as well as to Cyril Hrubis who
> reviewed orignal version of tst_net_vars.c.

Applied with minor changes below, thank you!


> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_net.h                    | 153 +++++++++
>  testcases/lib/.gitignore             |   3 +
>  testcases/lib/Makefile               |   2 +-
>  testcases/lib/tst_net_iface_prefix.c | 180 ++++++++++
>  testcases/lib/tst_net_ip_prefix.c    | 123 +++++++
>  testcases/lib/tst_net_vars.c         | 645 +++++++++++++++++++++++++++++++++++
>  6 files changed, 1105 insertions(+), 1 deletion(-)
>  create mode 100644 include/tst_net.h
>  create mode 100644 testcases/lib/tst_net_iface_prefix.c
>  create mode 100644 testcases/lib/tst_net_ip_prefix.c
>  create mode 100644 testcases/lib/tst_net_vars.c
>
> diff --git a/include/tst_net.h b/include/tst_net.h
> new file mode 100644
> index 000000000..cb97b7b61
> --- /dev/null
> +++ b/include/tst_net.h
> @@ -0,0 +1,153 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <arpa/inet.h>
> +#include <errno.h>
> +
> +#define MAX_IPV4_PREFIX 32
> +#define MAX_IPV6_PREFIX 128
> +
> +#define tst_res_comment(...) { \
> +	fprintf(stderr, "# "); \
> +	tst_res(__VA_ARGS__); } \
> +
> +
> +#define tst_brk_comment(...) { \
> +	fprintf(stderr, "# "); \
> +	tst_brk(TCONF, __VA_ARGS__); } \
> +
> +static inline void print_svar(const char *name, const char *val)
> +{
> +	if (name && val)
> +		printf("export %s=\"%s\"\n", name, val);
> +}
> +
> +static inline void print_svar_change(const char *name, const char *val)
> +{
> +	if (name && val)
> +		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
> +}
> +
> +/*
> + * Function bit_count is from ipcalc project, ipcalc.c.
> + */
> +static int bit_count(uint32_t i)
> +{
> +	int c = 0;
> +	unsigned int seen_one = 0;
> +
> +	while (i > 0) {
> +		if (i & 1) {
> +			seen_one = 1;
> +			c++;
> +		} else {
> +			if (seen_one)
> +				return -1;
> +		}
> +		i >>= 1;
> +	}
> +
> +	return c;
> +}
> +
> +/*
> + * Function mask2prefix is from ipcalc project, ipcalc.c.
> + */
> +static int mask2prefix(struct in_addr mask)
> +{
> +	return bit_count(ntohl(mask.s_addr));
> +}
> +
> +/*
> + * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
> + */
> +static int ipv4_mask_to_int(const char *prefix)
> +{
> +	int ret;
> +	struct in_addr in;
> +
> +	ret = inet_pton(AF_INET, prefix, &in);
> +	if (ret == 0)
> +		return -1;
> +
> +	return mask2prefix(in);
> +}
> +
> +/*
> + * Function safe_atoi is from ipcalc project, ipcalc.c.
> + */
> +static int safe_atoi(const char *s, int *ret_i)
> +{
> +	char *x = NULL;
> +	long l;
> +
> +	errno = 0;
> +	l = strtol(s, &x, 0);
> +
> +	if (!x || x == s || *x || errno)
> +		return errno > 0 ? -errno : -EINVAL;
> +
> +	if ((long)(int)l != l)
> +		return -ERANGE;
> +
> +	*ret_i = (int)l;
> +
> +	return 0;
> +}
> +
> +/*
> + * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
> + */
> +static int get_prefix(const char *ip_str, int is_ipv6)
> +{
> +	char *prefix_str = NULL;
> +	int prefix = -1, r;
> +
> +	prefix_str = strchr(ip_str, '/');
> +	if (!prefix_str)
> +		return -1;
> +
> +	*(prefix_str++) = '\0';
> +
> +	if (!is_ipv6 && strchr(prefix_str, '.'))
> +		prefix = ipv4_mask_to_int(prefix_str);
> +	else {
> +		r = safe_atoi(prefix_str, &prefix);
> +		if (r != 0)
> +			tst_brk_comment("conversion error: '%s' is not integer",
> +					prefix_str);
> +	}
> +
> +	if (prefix < 0 || ((is_ipv6 && prefix > MAX_IPV6_PREFIX) ||
> +		(!is_ipv6 && prefix > MAX_IPV4_PREFIX)))
> +		tst_brk_comment("bad %s prefix: %s", is_ipv6 ?  "IPv6" : "IPv4",
> +				prefix_str);
> +
> +	return prefix;
> +}
> +
> +static void get_in_addr(const char *ip_str, struct in_addr *ip)
> +{
> +	if (inet_pton(AF_INET, ip_str, ip) <= 0)
> +		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
> +}
> +
> +static void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
> +{
> +	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
> +		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
> +}
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index 522889bed..f36ed99fa 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -4,3 +4,6 @@
>  /tst_rod
>  /tst_kvcmp
>  /tst_device
> +/tst_net_iface_prefix
> +/tst_net_ip_prefix
> +/tst_net_vars
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 1127a59fe..398150ae0 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -27,6 +27,6 @@ include $(top_srcdir)/include/mk/testcases.mk
>  INSTALL_TARGETS		:= *.sh
>  
>  MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
> -			   tst_device
> +			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
> new file mode 100644
> index 000000000..c5cc61a0b
> --- /dev/null
> +++ b/testcases/lib/tst_net_iface_prefix.c
> @@ -0,0 +1,180 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/rtnetlink.h>
> +#include <net/if.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +#include "tst_net.h"
> +
> +typedef struct data {
> +	char *ifname;
> +	int prefix;
> +} data;
> +
> +static data vars;

removed struct data

> +
> +static void usage(const char *cmd)
> +{
> +	fprintf(stderr, "USAGE:\n"
> +		"%s IPV4_LHOST/IPV4_LPREFIX\n"
> +		"%s -r IPV4_RHOST/IPV4_RPREFIX\n"
> +		"%s IPV6_LHOST/IPV6_LPREFIX\n"
> +		"%s -r IPV6_RHOST/IPV6_RPREFIX\n\n"
> +		"%s IPV4_LHOST\n"
> +		"%s -r IPV4_RHOST\n\n"
> +		"%s IPV6_LHOST\n"
> +		"%s -r IPV6_RHOST\n\n"
> +		"%s -h\n\n"
> +		"Set prefix and interface name for given IP.\n"
> +		"Tries to find prefix and interface from kernel exported info (rtnetlink).\n\n"
> +		"If prefix is not provided, is tried to be detected from rtnetlink data for local IP address, which is used for remote prefix as well. If is not found use default values.\n"


removed redundant description

> +		"EXPORTED VARIABLES:\n"
> +		"Export one of following variables:\n"
> +		"Export one of following variables:\n"
> +		"IPV4_LPREFIX: IPv4 prefix for IPV4_LNETWORK\n"
> +		"IPV4_RPREFIX: IPv4 prefix for IPV4_RNETWORK\n"
> +		"IPV6_LPREFIX: IPv6 prefix for IPV6_LNETWORK\n"
> +		"IPV6_RPREFIX: IPv6 prefix for IPV6_RNETWORK\n"
> +		"Export one of following variables (if found):\n"
> +		"LHOST_IFACES: iface name of the local host (*)\n"
> +		"RHOST_IFACES: iface name of the remote host (*)\n\n"
> +		"(*): respect user settings\n"
> +		"Iface (LHOST_IFACES, RHOST_IFACES) as user might want to use more ifaces.\n\n"
> +		"PARAMS:\n"
> +		"-h this help\n"
> +		"-r export remote environment variables\n",
> +		cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd, cmd);
> +}
> +
> +static int read_iface_prefix(const char *ip_str, int is_ipv6)
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
> +	int sock = SAFE_SOCKET(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.nlhdr.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifaddrmsg));
> +	msg.nlhdr.nlmsg_flags = NLM_F_REQUEST | NLM_F_ROOT;
> +	msg.nlhdr.nlmsg_type = RTM_GETADDR;
> +	msg.addrmsg.ifa_family = family;
> +
> +	SAFE_SEND(1, sock, &msg, msg.nlhdr.nlmsg_len, 0);
> +	len = recv(sock, buf, sizeof(buf), 0);
> +	retmsg = (struct nlmsghdr *)buf;
> +
> +	while NLMSG_OK(retmsg, len) {
> +		char ifname[IFNAMSIZ];
> +		struct ifaddrmsg *retaddr;
> +		struct rtattr *retrta;
> +		char pradd[128];
> +		int attlen;
> +
> +		retaddr = (struct ifaddrmsg *)NLMSG_DATA(retmsg);
> +		retrta = (struct rtattr *)IFA_RTA(retaddr);
> +		attlen = IFA_PAYLOAD(retmsg);
> +
> +		while RTA_OK(retrta, attlen) {
> +			if (retrta->rta_type == IFA_ADDRESS) {
> +				inet_ntop(family, RTA_DATA(retrta), pradd,
> +					  sizeof(pradd));
> +
> +				if_indextoname(retaddr->ifa_index, ifname);
> +
> +				if (!strcmp(pradd, ip_str)) {
> +					vars.prefix = retaddr->ifa_prefixlen;
> +					vars.ifname = strdup(ifname);
> +					return 0;
> +				}
> +			}
> +			retrta = RTA_NEXT(retrta, attlen);
> +		}
> +		retmsg = NLMSG_NEXT(retmsg, len);
> +	}
> +
> +	return -1;
> +}
> +
> +static void print_ivar(const char *name, unsigned int val)
> +{
> +	if (name)
> +		printf("export %s=%d\n", name, val);

removed the check for 'name' as it's always not NULL.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char *ip_str = NULL, *prefix_str = NULL;
> +	int is_ipv6, is_rhost = 0;
> +	struct in_addr ip;
> +	struct in6_addr ip6;
> +
> +	int is_usage = argc > 1 && (!strcmp(argv[1], "-h") ||
> +		!strcmp(argv[1], "--help"));
> +	if (argc < 2 || is_usage) {
> +		usage(argv[0]);
> +		exit(is_usage ? EXIT_SUCCESS : EXIT_FAILURE);
> +	}
> +	if (!strcmp(argv[1], "-r"))
> +		is_rhost = 1;
> +
> +	ip_str = argv[is_rhost ? 2 : 1];
> +	is_ipv6 = !!strchr(ip_str, ':');
> +
> +	prefix_str = strchr(ip_str, '/');
> +	if (prefix_str) {
> +		vars.prefix = get_prefix(ip_str, is_ipv6);
> +		tst_res_comment(TINFO,
> +			"IP address '%s' contains prefix %d, using it and don't search for iface.\n",
> +			ip_str, vars.prefix);
> +	} else if (read_iface_prefix(ip_str, is_ipv6)) {
> +		tst_res_comment(TINFO,
> +			"prefix and interface not found for '%s'.\n", ip_str);
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	/* checks for validity of IP string */
> +	if (is_ipv6)
> +		get_in6_addr(ip_str, &ip6);
> +	else
> +		get_in_addr(ip_str, &ip);
> +
> +	if (is_ipv6) {
> +		print_svar_change("LHOST_IFACES", vars.ifname);
> +		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX",
> +			vars.prefix);
> +	} else {
> +		print_svar_change("RHOST_IFACES", vars.ifname);
> +		print_ivar(is_rhost ? "IPV4_RPREFIX" : "IPV4_LPREFIX",
> +			vars.prefix);
> +	}
> +
> +	exit(EXIT_SUCCESS);
> +}
> diff --git a/testcases/lib/tst_net_ip_prefix.c b/testcases/lib/tst_net_ip_prefix.c
> new file mode 100644
> index 000000000..6654f75a9
> --- /dev/null
> +++ b/testcases/lib/tst_net_ip_prefix.c
> @@ -0,0 +1,123 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/rtnetlink.h>
> +#include <net/if.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +#include "tst_net.h"
> +
> +#define DEFAULT_IPV4_PREFIX 24
> +#define DEFAULT_IPV6_PREFIX 64
> +
> +typedef struct data {
> +	int prefix;
> +} data;
> +
> +static data vars;

removed 'struct data' here as well and defined 'prefix' as a local
variable in main().

> +
> +static void usage(const char *cmd)
> +{
> +	fprintf(stderr, "USAGE:\n"
> +		"%s IPV4_LHOST/IPV4_LPREFIX\n"
> +		"%s -r IPV4_RHOST/IPV4_RPREFIX\n"
> +		"%s IPV6_LHOST/IPV6_LPREFIX\n"
> +		"%s -r IPV6_RHOST/IPV6_RPREFIX\n\n"
> +		"%s IPV4_LHOST\n"
> +		"%s -r IPV4_RHOST\n\n"
> +		"%s IPV6_LHOST\n"
> +		"%s -r IPV6_RHOST\n\n"
> +		"%s -h\n\n"
> +		"Set IP without prefix and prefix for given IP.\n"
> +		"If prefix is not provided, is tried to be detected from rtnetlink data for local IP address, which is used for remote prefix as well. If is not found use default values.\n"


Fixed description here (it's not using rtnetlink).

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170908/07cd5a93/attachment-0001.html>
