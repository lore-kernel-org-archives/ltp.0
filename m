From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 3 Apr 2017 14:29:08 +0300
Subject: [LTP] [RFC PATCH v2 2/3] network: Add tool for setup IP
	variables
In-Reply-To: <20170403071428.11754-3-pvorel@suse.cz>
References: <20170403071428.11754-1-pvorel@suse.cz>
 <20170403071428.11754-3-pvorel@suse.cz>
Message-ID: <7cdee769-8b90-a7d4-bb82-09cadce47f46@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 03.04.2017 10:14, Petr Vorel wrote:
...
> +#define FLAG_GET_NETWORK 1
> +#define FLAG_GET_NETWORK_UNUSED (1 << 1)
> +#define FLAG_GET_HOST (1 << 2)

Can be just 1, 2, 4.

....
> +
> +/*
> + * Function inet_ntop6_impl is based on musl libc project,
> + * inet_ntop/inet_ntop.c.
> + */
> +static char *inet_ntop6_impl(const u_char *restrict a0, unsigned int prefix,
> +	int flags)

'restrict' keyword is from C99. Also u_char is not a standard type I guess.

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

We could use FLAG_GET_NETWORK here instead.

> +	int isUnused = flags & FLAG_GET_NETWORK_UNUSED;
> +
> +	snprintf(buf, sizeof(buf),
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

Hmm, what are '0xff0d' and '0xaa10' prefixes? The first one seems to be a
multicast group address...

I don't quite understand how unused network is calculated in this patch,
is it
just changing the first prefix with these values? What would be if we set
fd00:1/64 and 192.168.1.1/24 addresses?

...
> +
> +	if (lprefix != rprefix) {
> +		fprintf(stderr, "Prefixes must be the same\n");

And why this limitation is needed?

Thanks,
Alexey

