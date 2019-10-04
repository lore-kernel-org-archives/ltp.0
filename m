From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Oct 2019 14:40:58 +0200
Subject: [LTP] [PATCH v2 2/4] Create separate .c file for
 include/tst_net.h
In-Reply-To: <20190926151331.25070-3-mdoucha@suse.cz>
References: <20190926151331.25070-1-mdoucha@suse.cz>
 <20190926151331.25070-3-mdoucha@suse.cz>
Message-ID: <20191004124057.GB5442@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_net.h | 118 +++-------------------------------------
>  lib/tst_net.c     | 134 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 142 insertions(+), 110 deletions(-)
>  create mode 100644 lib/tst_net.c

What is the reason for this change?

With this you are polluting the LTP test library with symbols that are
not prefixed by tst_. If nothing else these functions has to be prefixed
in order to avoid conflicts with functions declared in the testcases.

> diff --git a/include/tst_net.h b/include/tst_net.h
> index cb97b7b61..740f25bac 100644
> --- a/include/tst_net.h
> +++ b/include/tst_net.h
> @@ -16,7 +16,7 @@
>   */
>  
>  #include <arpa/inet.h>
> -#include <errno.h>
> +#include <stdio.h>
>  
>  #define MAX_IPV4_PREFIX 32
>  #define MAX_IPV6_PREFIX 128
> @@ -42,112 +42,10 @@ static inline void print_svar_change(const char *name, const char *val)
>  		printf("export %s=\"${%s:-%s}\"\n", name, name, val);
>  }
>  
> -/*
> - * Function bit_count is from ipcalc project, ipcalc.c.
> - */
> -static int bit_count(uint32_t i)
> -{
> -	int c = 0;
> -	unsigned int seen_one = 0;
> -
> -	while (i > 0) {
> -		if (i & 1) {
> -			seen_one = 1;
> -			c++;
> -		} else {
> -			if (seen_one)
> -				return -1;
> -		}
> -		i >>= 1;
> -	}
> -
> -	return c;
> -}
> -
> -/*
> - * Function mask2prefix is from ipcalc project, ipcalc.c.
> - */
> -static int mask2prefix(struct in_addr mask)
> -{
> -	return bit_count(ntohl(mask.s_addr));
> -}
> -
> -/*
> - * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
> - */
> -static int ipv4_mask_to_int(const char *prefix)
> -{
> -	int ret;
> -	struct in_addr in;
> -
> -	ret = inet_pton(AF_INET, prefix, &in);
> -	if (ret == 0)
> -		return -1;
> -
> -	return mask2prefix(in);
> -}
> -
> -/*
> - * Function safe_atoi is from ipcalc project, ipcalc.c.
> - */
> -static int safe_atoi(const char *s, int *ret_i)
> -{
> -	char *x = NULL;
> -	long l;
> -
> -	errno = 0;
> -	l = strtol(s, &x, 0);
> -
> -	if (!x || x == s || *x || errno)
> -		return errno > 0 ? -errno : -EINVAL;
> -
> -	if ((long)(int)l != l)
> -		return -ERANGE;
> -
> -	*ret_i = (int)l;
> -
> -	return 0;
> -}
> -
> -/*
> - * Function get_prefix use code from ipcalc project, str_to_prefix/ipcalc.c.
> - */
> -static int get_prefix(const char *ip_str, int is_ipv6)
> -{
> -	char *prefix_str = NULL;
> -	int prefix = -1, r;
> -
> -	prefix_str = strchr(ip_str, '/');
> -	if (!prefix_str)
> -		return -1;
> -
> -	*(prefix_str++) = '\0';
> -
> -	if (!is_ipv6 && strchr(prefix_str, '.'))
> -		prefix = ipv4_mask_to_int(prefix_str);
> -	else {
> -		r = safe_atoi(prefix_str, &prefix);
> -		if (r != 0)
> -			tst_brk_comment("conversion error: '%s' is not integer",
> -					prefix_str);
> -	}
> -
> -	if (prefix < 0 || ((is_ipv6 && prefix > MAX_IPV6_PREFIX) ||
> -		(!is_ipv6 && prefix > MAX_IPV4_PREFIX)))
> -		tst_brk_comment("bad %s prefix: %s", is_ipv6 ?  "IPv6" : "IPv4",
> -				prefix_str);
> -
> -	return prefix;
> -}
> -
> -static void get_in_addr(const char *ip_str, struct in_addr *ip)
> -{
> -	if (inet_pton(AF_INET, ip_str, ip) <= 0)
> -		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
> -}
> -
> -static void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
> -{
> -	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
> -		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
> -}
> +int bit_count(uint32_t i);
> +int mask2prefix(struct in_addr mask);
> +int ipv4_mask_to_int(const char *prefix);
> +int safe_atoi(const char *s, int *ret_i);
> +int get_prefix(const char *ip_str, int is_ipv6);
> +void get_in_addr(const char *ip_str, struct in_addr *ip);
> +void get_in6_addr(const char *ip_str, struct in6_addr *ip6);
> diff --git a/lib/tst_net.c b/lib/tst_net.c
> new file mode 100644
> index 000000000..4166641f1
> --- /dev/null
> +++ b/lib/tst_net.c
> @@ -0,0 +1,134 @@
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
> +#include <errno.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_net.h"
> +
> +/*
> + * Function bit_count is from ipcalc project, ipcalc.c.
> + */
> +int bit_count(uint32_t i)
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
> +int mask2prefix(struct in_addr mask)
> +{
> +	return bit_count(ntohl(mask.s_addr));
> +}
> +
> +/*
> + * Function ipv4_mask_to_int is from ipcalc project, ipcalc.c.
> + */
> +int ipv4_mask_to_int(const char *prefix)
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
> +int safe_atoi(const char *s, int *ret_i)
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
> +int get_prefix(const char *ip_str, int is_ipv6)
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
> +void get_in_addr(const char *ip_str, struct in_addr *ip)
> +{
> +	if (inet_pton(AF_INET, ip_str, ip) <= 0)
> +		tst_brk_comment("bad IPv4 address: '%s'", ip_str);
> +}
> +
> +void get_in6_addr(const char *ip_str, struct in6_addr *ip6)
> +{
> +	if (inet_pton(AF_INET6, ip_str, ip6) <= 0)
> +		tst_brk_comment("bad IPv6 address: '%s'", ip_str);
> +}
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
