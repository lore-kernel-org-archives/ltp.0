From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Aug 2017 08:10:37 +0200
Subject: [LTP] [RFC PATCH v8 10/11] network: Add tools for setup IP
 related environment variables
In-Reply-To: <20170818164437.13556-11-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
 <20170818164437.13556-11-pvorel@suse.cz>
Message-ID: <20170821061037.orndqewgxw3nhqxv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> New tools:
> * tst_net_ip_prefix
> Strip prefix from IP address and save both
> If no prefix found sets default prefix.
...
> +++ b/testcases/lib/tst_net_vars.c
> @@ -0,0 +1,637 @@
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
> +
> +#include <arpa/inet.h>
> +#include <arpa/nameser.h>
> +#include <assert.h>
> +#include <errno.h>
> +#include <linux/rtnetlink.h>
> +#include <net/if.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <time.h>
> +#include <stdarg.h>
> +
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +#include "tst_net.h"
> +
> +#define BASE_IPV4_PREFIX 8
> +#define BASE_IPV6_PREFIX 16
> +
> +#define MAX_IPV4_PREFIX 32
> +#define MAX_IPV6_PREFIX 128
> +
> +#define DEFAULT_IPV4_UNUSED_PART1 10
> +#define DEFAULT_IPV6_UNUSED_PART1 0xfd
> +
> +#define DEFAULT_IPV4_UNUSED_PART2 23
> +#define DEFAULT_IPV6_UNUSED_PART2 0x23
> +
> +typedef struct ltp_net_variables {
> +	char *ipv4_lbroadcast;
> +	char *ipv4_rbroadcast;
> +	char *ipv4_lnetmask;
> +	char *ipv4_rnetmask;
> +	char *ipv4_lnetwork;
> +	char *ipv4_rnetwork;
> +	char *lhost_ipv4_host;
> +	char *rhost_ipv4_host;
> +	char *ipv6_lnetmask;
> +	char *ipv6_rnetmask;
> +	char *ipv6_lnetwork;
> +	char *ipv6_rnetwork;
> +	char *lhost_ipv6_host;
> +	char *rhost_ipv6_host;
> +	char *ipv4_net16_unused;
> +	char *ipv6_net32_unused;
> +	char *lhost_ifaces;
I left unused struct member lhost_ifaces :-(.


Kind regards,
Petr
