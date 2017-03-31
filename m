From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Mar 2017 16:38:29 +0200
Subject: [LTP] [RFC PATCH 1/2] network: Add tool for setup IP variables
In-Reply-To: <20170329093713.28361-2-pvorel@suse.cz>
References: <20170329093713.28361-1-pvorel@suse.cz>
 <20170329093713.28361-2-pvorel@suse.cz>
Message-ID: <20170331143829.GB19588@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/.gitignore                |  13 +-
>  testcases/lib/Makefile                  |   4 +-
>  testcases/lib/setup_network_variables.c | 602 ++++++++++++++++++++++++++++++++
>  3 files changed, 611 insertions(+), 8 deletions(-)
>  create mode 100644 testcases/lib/setup_network_variables.c

I wonder if we can give it shorter name, something as tst_net_vars.c or
similar.

> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index 920817cac..9fc9bc562 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -1,6 +1,7 @@
> -tst_sleep
> -tst_random
> -tst_checkpoint
> -tst_rod
> -tst_kvcmp
> -tst_device
> +/tst_sleep
> +/tst_random
> +/tst_checkpoint
> +/tst_rod
> +/tst_kvcmp
> +/tst_device
> +/setup_network_variables

Prefixing the existing filenames is unrelated change and as such should
be done in a separate patch

> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 1127a59fe..3fb68f75d 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -24,9 +24,9 @@ top_srcdir		?= ../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  
> -INSTALL_TARGETS		:= *.sh
> +INSTALL_TARGETS		:= *.sh setup_network_variables

This is wrong, everything that is MAKE_TARGET is installed as well,
INSTALL_TARGETS is only for files that are not created during the build
process.

>  MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
> -			   tst_device
> +			   tst_device setup_network_variables
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/setup_network_variables.c b/testcases/lib/setup_network_variables.c
> new file mode 100644
> index 000000000..f8d852070
> --- /dev/null
> +++ b/testcases/lib/setup_network_variables.c
> @@ -0,0 +1,602 @@
> +/*
> + * Copyright (c) 2017 Petr Vorel <pvorel@suse.cz>
> + * Copyright (c) 1997-2015 Red Hat, Inc. All rights reserved.
> + * Copyright (c) 2011-2013 Rich Felker, et al.
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

We may also add a comment which points to the original files, something
as:

/*
 * Funciton foo based on musl foo/bar.c
 */

Or something similar.

> +#include <arpa/inet.h>
> +#include <arpa/nameser.h>
> +#include <errno.h>
> +#include <netdb.h>
> +#include <netinet/in.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#define FLAG_GET_NETWORK 1
> +#define FLAG_GET_NETWORK_UNUSED (1 << 1)
> +#define FLAG_GET_HOST (1 << 2)
> +
> +typedef struct ltp_net_variables {
> +	char *ipv4_network;
> +	char *ipv4_net_rev;
> +	char *lhost_ipv4_host;
> +	char *rhost_ipv4_host;
> +	char *ipv6_network;
> +	char *ipv6_net_rev;
> +	char *lhost_ipv6_host;
> +	char *lhost_ipv6_rev;
> +	char *rhost_ipv6_host;
> +	char *rhost_ipv6_rev;
> +	char *ipv4_net16_unused;
> +	char *ipv6_net32_unused;
> +} ltp_net_variables;

Given that there is only one instance of this structure we can also make
it a global variable instead of passing the pointer to most of the
functions here.

> +static char *inet_ntop6_impl(const u_char *restrict a0, unsigned int prefix,
> +	int flags)
> +{
> +	const unsigned char *a = a0;
> +	unsigned int i, j, max, best, tmp2, border = 0;
> +	char buf[100];
> +	char ret[100];
> +	char tmp[100];
> +	char *p_ret = ret;
> +	char *p_tmp = tmp;
> +	size_t offset;
> +
> +	int isNet = !(flags & FLAG_GET_HOST);
> +	int isUnused = flags & FLAG_GET_NETWORK_UNUSED;
> +
> +	snprintf(buf, sizeof buf,
                           ^
			   missing parenthesis
> +		"%x:%x:%x:%x:%x:%x:%x:%x",
> +		256 * a[0] + a[1], 256 * a[2] + a[3],
> +		256 * a[4] + a[5], 256 * a[6] + a[7],
> +		256 * a[8] + a[9], 256 * a[10] + a[11],
> +		256 * a[12] + a[13], 256 * a[14] + a[15]);
> +
> +	for (i = 0; i < 8; i++) {
> +		if (i < prefix >> 4) {
> +			border += sprintf(p_tmp, "%x", 256 * a[2 * i] + a[2 * i + 1]);
> +			if (i > 0)
> +				border++;
> +		}
> +
> +		if (isNet && i >= prefix >> 4)
> +			break;
> +
> +		if (!isNet && i < prefix >> 4)
> +			continue;
> +
> +		/* ':' only if no leading in host or ending in net */
> +		if ((isNet && i > 0)
> +			 || (!isNet && i > prefix >> 4))
> +			*p_ret++ = ':';
> +
> +		tmp2 = 256 * a[2 * i] + a[2 * i + 1];
> +		if (isUnused)
> +			tmp2 = tmp2 < 0xff0d ? 0xff0d : 0xaa10;
> +		offset = sprintf(p_ret, "%x", tmp2);
> +
> +		p_ret += offset;
> +	}
> +
> +	*p_ret = '\0';
> +
> +	/* Find longest /(^0|:)[:0]{2,}/ */
> +	for (i = best = 0, max = 2; buf[i]; i++) {
> +		if (i && buf[i] != ':') continue;
> +		j = strspn(buf + i, ":0");
> +		if (j > max) best = i, max = j;
> +	}
> +
> +	size_t length = strlen(ret);
> +	size_t best_end = best + max - 1;
> +
> +	if (max > 2 && ((isNet && best < border) ||
> +					(!isNet && best_end + 2 > border))) {
> +		p_ret = ret;
> +		/* Replace longest /(^0|:)[:0]{2,}/ with "::" */
> +		if (isNet) {
> +			if (best == 0 && best_end >= border) {
> +				/* zeros in whole net part or continue to host */
> +				if (isUnused)
> +					ret[0] = '\0';
> +				else {
> +					ret[0] = ':';
> +					ret[1] = '\0';
> +				}
> +			} else if (best == 0 && best_end < border) {
> +				/* zeros on beginning, not whole part */
> +				if (isUnused)
> +					memmove(p_ret, p_ret + best_end, border - best_end + 1);
> +				else {
> +					ret[0] = ':';
> +					memmove(p_ret + 1, p_ret + best_end, border - best_end + 1);
> +				}
> +			} else if (best > 0 && best_end >= border) {
> +				/* zeros not from beginning to border or continue to host */
> +				if (isUnused)
> +					ret[best] = '\0';
> +				else {
> +					ret[best] = ':';
> +					ret[best + 1] = '\0';
> +				}
> +			} else {
> +				/* zeros somewhere in the middle */
> +				if (isUnused)
> +					memmove(p_ret + best, p_ret + best_end, border - best + 1);
> +				else {
> +					ret[best] = ':';
> +					memmove(p_ret + best + 1, p_ret + best_end,
> +							border - best + 1);
> +				}
> +			}
> +		} else {
> +			if (best <= border + 1 && best_end >= length + border) {
> +				/* zeros in whole host part or continue to net */
> +				ret[0] = '0';
> +				ret[1] = '\0';
> +			} else if (best <= border + 1 && best_end < length + border) {
> +				if (best == border) {
> +					/* zeros start in host, ends before end */
> +					p_ret[0] = ':';
> +					memmove(p_ret + 1, p_ret + best_end - border, length +
> +							border - best_end + 2);
> +				} else
> +					/* zeros start in net, ends before end */
> +					memmove(p_ret, p_ret + best_end - border, length +
> +							border - best_end + 1);
> +			} else if (best > border && best_end == border + length) {
> +				/* zeros at the end */
> +				ret[best - border] = ':';
> +				ret[best - border + 1] = '\0';
> +			} else {
> +				/* zeros somewhere in the middle */
> +				ret[best - border] = ':';
> +				memmove(p_ret + best - border + 1, p_ret + best_end - border,
> +						length + border - best_end + 1);
> +			}
> +		}
> +	}
> +
> +	if (length < INET6_ADDRSTRLEN)
> +		return strdup(ret);
> +
> +	return NULL;
> +}
> +
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
> +	return c;
> +}
> +
> +static int mask2prefix(struct in_addr mask)
> +{
> +	return bit_count(ntohl(mask.s_addr));
> +}
> +
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
> +	return 0;
> +}
> +
> +static int str_to_prefix(int ipv6, const char *prefixStr)
> +{
> +	int prefix, r;
> +	if (!ipv6 && strchr(prefixStr, '.'))
> +		prefix = ipv4_mask_to_int(prefixStr);
> +	else {
> +		r = safe_atoi(prefixStr, &prefix);
> +		if (r != 0)
> +			return -1;
> +	}
> +
> +	if (prefix < 0 || ((ipv6 && prefix > 128) || (!ipv6 && prefix > 32)))
> +		return -1;
> +
> +	return prefix;
> +}
> +
> +static int get_prefix(const char *ipStr, int isIPv6)
> +{
> +	char *prefixStr = NULL;
> +	int prefix;
> +
> +	if (strchr(ipStr, '/') == NULL) {
> +		fprintf(stderr, "Missing prefix, is that IP address?\n");
                                                    ^
						    The message should
						    include the ipStr
						    here.
> +		return -1;
> +	}
> +
> +	prefixStr = strchr(ipStr, '/');

You are calling the strchr() twice here for no reason, why not:

	prefix_str = strchr(ip_str, '/');
	if (!prefix_str) {
		//error
	}

> +	*prefixStr = '\0';
> +	prefixStr++;

This could be just *(prefix_str++) = '\0'; since post increment returns
value and then increments.

> +	prefix = str_to_prefix(isIPv6, prefixStr);
                                 ^
				 Let's be consistent and pass the flag
				 last to all fucntions.
> +	if (prefix < 0) {
> +		fprintf(stderr, "Bad %s prefix: %s\n", isIPv6 ? "IPv6" : "IPv4",
> +				prefixStr);
> +		return -1;
> +	}

Given that we do exit() in the main() if get_prefix() fails anyway we
can simplify the code by printing this message and calling exit() in the
str_to_prefix() function.

There is no need to propagate the error just to call exit().

Also as far as I can tell the str_to_prefix is called only from this
function. Then there is no need to keep it in a separate function. 

> +	if (prefix == 0 || (!isIPv6 && prefix == 32) || (isIPv6 && prefix == 128)) {
> +		fprintf(stderr, "Please don't use prefix: %d for %s\n",
> +				prefix, isIPv6 ? "IPv6" : "IPv4");
> +		return -2;
> +	}
> +
> +	if ((!isIPv6 && prefix % 8 > 0) || (isIPv6 && prefix % 16 > 0)) {
> +		fprintf(stderr, "Please for %s use prefix divisible by %d (prefix: %d)\n",
> +				isIPv6 ? "IPv6" : "IPv4", isIPv6 ? 16 : 8, prefix);
> +		return -3;
> +	}

> +	return prefix;
> +}
> +
> +static char *get_ipv4_host(int ip, int prefix)
> +{
> +	char buf[INET_ADDRSTRLEN + 1];
> +	char *p_buf = buf;
> +    unsigned char byte;
   ^
   Spaces instead of tab
> +
> +	if (prefix < 0 || prefix > 32)
> +		return NULL;
> +
> +	prefix &= 0x18;
> +
> +	for (int i = 0; i < 32; i+= 8) {
> +		if (i < prefix)
> +			continue;
> +
> +		if (i > prefix) {
> +			sprintf(p_buf, ".");
> +			p_buf++;
> +		}
> +
> +		if (i == 0)
> +			byte = ip & 0xff;
> +		else
> +			byte = (ip >> i) & 0xff;
> +
> +		sprintf(p_buf, "%d", byte);
> +		p_buf += strlen(p_buf);
> +	}
> +
> +	return strdup(buf);
> +}
> +
> +static char *get_ipv4_net_rev(int ip, int prefix)
> +{
> +	char buf[INET_ADDRSTRLEN + 1];
> +	char *p_buf = buf;
> +    unsigned char byte;
> +
> +	if (prefix < 0 || prefix > 32)
> +		return NULL;
> +
> +	prefix &= 0x18;
> +
> +	for (int i = prefix - 8; i >= 0; i-= 8) {
> +
> +		if (i < prefix - 8) {
> +			sprintf(p_buf, ".");
> +			p_buf++;
> +		}
> +
> +		if (i == 0)
> +			byte = ip & 0xff;
> +		else
> +			byte = (ip >> i) & 0xff;
> +
> +		sprintf(p_buf, "%d", byte);
> +		p_buf += strlen(p_buf);
> +	}
> +
> +	return strdup(buf);
> +}
> +
> +static char *get_ipv4_network(int ip, int prefix, int flags)
> +{
> +	char buf[INET_ADDRSTRLEN + 1];
> +	char *p_buf = buf;
> +    unsigned char byte;
> +
> +	if (prefix < 0 || prefix > 32)
> +		return NULL;
> +
> +	prefix &= 0x18;
> +
> +	for (int i = 0; i < 32 && i < prefix; i+= 8) {
> +		if (i == 0) {
> +			byte = ip & 0xff;
> +			if (flags & FLAG_GET_NETWORK_UNUSED)
> +				byte = byte > 10 ? 10 : 192;
> +			sprintf(p_buf, "%d", byte);
> +		} else {
> +			byte = (ip >> i) & 0xff;
> +			sprintf(p_buf, ".%d", byte);
> +		}
> +		p_buf += strlen(p_buf);
> +	}
> +
> +	return strdup(buf);
> +}
> +
> +static char hexchar(unsigned int val)
> +{
> +	if (val < 10)
> +		return '0' + val;
> +	if (val < 16)
> +		return 'a' + val - 10;
> +	abort();
> +}
> +
> +static char *get_ipv6_net_rev(struct in6_addr *ip, unsigned prefix)
> +{
> +	unsigned i, j = 0;
> +	char str[256];
> +	unsigned max = prefix/8;
> +
> +	if (prefix % 4 != 0)
> +		return NULL;
> +
> +	if (prefix % 8 == 4) {
> +		str[j++] = hexchar(ip->s6_addr[(prefix + 4)/8 - 1] >> 4);
> +		str[j++] = '.';
> +	}
> +
> +	for (i = 0; i < max; i++) {
> +		str[j++] = hexchar(ip->s6_addr[max - 1 - i] & 0xf);
> +		str[j++] = '.';
> +
> +		str[j++] = hexchar(ip->s6_addr[max - 1 - i] >> 4);
> +		str[j++] = '.';
> +	}
> +	str[--j] = '\0';
> +
> +	return strdup(str);
> +}
> +
> +static char *get_ipv6_host_rev(struct in6_addr *ip, unsigned prefix)
> +{
> +	unsigned i, j = 0;
> +	char str[256];
> +
> +	if (prefix % 4 != 0)
> +		return NULL;
> +
> +	for (i = 15; i >= (prefix >> 4) * 2; i--) {
> +		str[j++] = hexchar(ip->s6_addr[i] & 0xf);
> +		str[j++] = '.';
> +
> +		str[j++] = hexchar(ip->s6_addr[i] >> 4);
> +		str[j++] = '.';
> +	}
> +	str[--j] = '\0';
> +
> +	return strdup(str);
> +}
> +
> +static int get_in_addr(const char *ipStr, struct in_addr *ip)
> +{
> +	if (inet_pton(AF_INET, ipStr, ip) <= 0) {
> +		fprintf(stderr, "Bad IPv4 address: '%s'\n", ipStr);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int get_ipv4_info(struct in_addr *lIp, struct in_addr *rIp, int prefix,
> +	ltp_net_variables *vars)
> +{
> +	vars->ipv4_network = get_ipv4_network(lIp->s_addr, prefix,
> +		FLAG_GET_NETWORK);
> +	if (strcmp(vars->ipv4_network, get_ipv4_network(rIp->s_addr, prefix,
> +			FLAG_GET_NETWORK))) {
> +		fprintf(stderr, "Please use the same network for both IP addresses\n");
> +		return -1;
> +	}
> +
> +	vars->ipv4_net_rev = get_ipv4_net_rev(lIp->s_addr, prefix);
> +	vars->lhost_ipv4_host = get_ipv4_host(lIp->s_addr, prefix);
> +	vars->rhost_ipv4_host = get_ipv4_host(rIp->s_addr, prefix);
> +	vars->ipv4_net16_unused = get_ipv4_network(lIp->s_addr, prefix,
> +		FLAG_GET_NETWORK_UNUSED);
> +
> +	return 0;
> +}
> +
> +static int get_in6_addr(const char *ipStr, struct in6_addr *ip6)
> +{
> +	if (inet_pton(AF_INET6, ipStr, ip6) <= 0) {
> +		fprintf(stderr, "bad IPv6 address: '%s'\n", ipStr);
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static int get_ipv6_info(struct in6_addr *lIp, struct in6_addr *rIp, int prefix,
> +	ltp_net_variables *vars)
> +{
> +	vars->ipv6_network = inet_ntop6_impl(lIp->s6_addr, prefix, FLAG_GET_NETWORK);
> +	if (strcmp(vars->ipv6_network,
> +			   inet_ntop6_impl(rIp->s6_addr, prefix, FLAG_GET_NETWORK))) {
> +		fprintf(stderr, "Please use the same network for both IP addresses\n");
> +		return -1;
> +	}
> +
> +	vars->ipv6_net_rev = get_ipv6_net_rev(lIp, prefix);
> +	vars->lhost_ipv6_host = inet_ntop6_impl(lIp->s6_addr, prefix, FLAG_GET_HOST);
> +	vars->lhost_ipv6_rev = get_ipv6_host_rev(lIp, prefix);
> +	vars->rhost_ipv6_host = inet_ntop6_impl(rIp->s6_addr, prefix, FLAG_GET_HOST);
> +	vars->rhost_ipv6_rev = get_ipv6_host_rev(rIp, prefix);
> +	vars->ipv6_net32_unused = inet_ntop6_impl(lIp->s6_addr, prefix,
> +		FLAG_GET_NETWORK_UNUSED);
> +
> +	return 0;
> +}
> +
> +static void print_vars(ltp_net_variables *vars, int isIPv6)
> +{
> +	if (!isIPv6) {
> +		if (vars->ipv4_network) {
> +			printf("export IPV4_NETWORK='%s'\n", vars->ipv4_network);
> +		}
> +		if (vars->ipv4_net_rev) {
> +			printf("export IPV4_NET_REV='%s'\n", vars->ipv4_net_rev);
> +		}
> +		if (vars->lhost_ipv4_host) {
> +			printf("export LHOST_IPV4_HOST='%s'\n", vars->lhost_ipv4_host);
> +		}
> +		if (vars->rhost_ipv4_host) {
> +			printf("export RHOST_IPV4_HOST='%s'\n", vars->rhost_ipv4_host);
> +		}
> +		if (vars->ipv4_net16_unused) {
> +			printf("export IPV4_NET16_UNUSED='%s'\n", vars->ipv4_net16_unused);
> +		}
> +	} else {
> +		if (vars->ipv6_network) {
> +			printf("export IPV6_NETWORK='%s'\n", vars->ipv6_network);
> +		}
> +		if (vars->ipv6_net_rev) {
> +			printf("export IPV6_NET_REV='%s'\n", vars->ipv6_net_rev);
> +		}
> +		if (vars->lhost_ipv6_host) {
> +			printf("export LHOST_IPV6_HOST='%s'\n", vars->lhost_ipv6_host);
> +		}
> +		if (vars->lhost_ipv6_rev) {
> +			printf("export LHOST_IPV6_REV='%s'\n", vars->lhost_ipv6_rev);
> +		}
> +		if (vars->rhost_ipv6_host) {
> +			printf("export RHOST_IPV6_HOST='%s'\n", vars->rhost_ipv6_host);
> +		}
> +		if (vars->rhost_ipv6_rev) {
> +			printf("export RHOST_IPV6_REV='%s'\n", vars->rhost_ipv6_rev);
> +		}
> +		if (vars->ipv6_net32_unused) {
> +			printf("export IPV6_NET32_UNUSED='%s'\n", vars->ipv6_net32_unused);
> +		}
> +	}

Here again why is the flag negated?

Also I guess that we can write a function that does:

printf("export %s='%s'\n", name, val);

And use it here to avoid the overly long lines and curly braces.
> +}
> +
> +static void usage(char *name)
> +{
> +	fprintf(stderr, "Usage: %s: IP/PREFIX IP/PREFIX\n"
> +		"IP addresses must be within the same subnet.\n"
> +		"Prefixes must be the same.\n"
> +		"IPv4 prefix must be <1, 24>, divisible by 8.\n"
> +		"IPv6 prefix must be <1, 127>, divisible by 16.\n",
> +		name);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	ltp_net_variables vars;
> +	char *lIpStr = NULL, *rIpStr = NULL;
> +	struct in_addr lIp, rIp;
> +	struct in6_addr lIp6, rIp6;
> +	int isIPv6, prefix, prefix2;
> +	int r = 0;
> +
> +	int isUsage = argc > 1 && (!strcmp(argv[1], "-h") ||
> +		!strcmp(argv[1], "--help"));
> +	if (argc < 3 || isUsage) {
> +		usage(argv[0]);
> +		exit(isUsage ? 0 : 1);
> +	}
> +
> +	lIpStr = argv[1];
> +	rIpStr = argv[2];
> +
> +	isIPv6 = strchr(lIpStr, ':') == NULL ? 0 : 1;

The usuall trick is to use double negation to force boolean value:

	isIPv6 = !!strchr(lIpStr, ':');

Also in LKML conding style mixed-case is frowned upon.

> +	if (isIPv6 != !(strchr(rIpStr, ':') == NULL)) {
> +		fprintf(stderr, "Mixed IPv4 and IPv6 addresses");
> +		exit(2);
> +	}
> +
> +	prefix = get_prefix(lIpStr, isIPv6);
> +	prefix2 = get_prefix(rIpStr, isIPv6);

It's a bit strange to name variables as prefix and prefix2, where is
prefix1?

> +	if (prefix < 0 || prefix2 < 0)
> +		exit(3);
> +
> +	if (!isIPv6) {
> +		if (get_in_addr(lIpStr, &lIp) < 0 || get_in_addr(rIpStr, &rIp) < 0)
> +			exit(4);
> +	} else {
> +		if (get_in6_addr(lIpStr, &lIp6) < 0 || get_in6_addr(rIpStr, &rIp6) < 0)
> +			exit(4);
> +	}

Why do we negate the isIPv6 flag here when we can switch the if and else
blocks?

> +	if (!strcmp(lIpStr, rIpStr)) {
> +		fprintf(stderr, "IP addresses cannot be the same\n");
> +		exit(5);
> +	}
> +
> +	if (prefix != prefix2) {
> +		fprintf(stderr, "Prefixes must be the same\n");
> +		exit(6);
> +	}
> +
> +	if (!isIPv6)
> +		r = get_ipv4_info(&lIp, &rIp, prefix, &vars);
> +	else
> +		r = get_ipv6_info(&lIp6, &rIp6, prefix, &vars);

Here again why do we negate the flag?

> +	if (r < 0)
> +		exit(7);
> +
> +	print_vars(&vars, isIPv6);
> +
> +	exit(0);
> +}
> -- 
> 2.12.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
