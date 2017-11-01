From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Nov 2017 16:49:43 +0100
Subject: [LTP] [PATCH v6] Add test for CVE-2017-7308 on a raw socket's
 ring buffer
In-Reply-To: <20171013111932.28671-1-rpalethorpe@suse.com>
References: <20171013111932.28671-1-rpalethorpe@suse.com>
Message-ID: <20171101154943.GE11108@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/cve/cve-2017-7308.c b/testcases/cve/cve-2017-7308.c
> new file mode 100644
> index 000000000..d825f3a65
> --- /dev/null
> +++ b/testcases/cve/cve-2017-7308.c
> @@ -0,0 +1,145 @@
> +/*
> + * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
> +/* Test for CVE-2017-7308 on a raw socket's ring buffer
> + *
> + * Try to set tpacket_req3.tp_sizeof_priv to a value with the high bit set. So
> + * that tp_block_size < tp_sizeof_priv. If the vulnerability is present then
> + * this will cause an integer arithmatic overflow and the absurd
                                 ^
				 typo
> + * tp_sizeof_priv value will be allowed. If it has been fixed then setsockopt
> + * will fail with EINVAL.
> + *
> + * We also try a good configuration to make sure it is not failing with EINVAL
> + * for some other reason.
> + *
> + * For a better and more interesting discussion of this CVE see:
> + * https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
> + */
> +
> +#include <errno.h>
> +#include "tst_test.h"
> +#include "tst_safe_net.h"
> +#include "config.h"
> +
> +#ifdef HAVE_LINUX_IF_PACKET_H
> +# include <linux/if_packet.h>
> +#endif
> +
> +#ifdef HAVE_LINUX_IF_ETHER_H
> +# include <linux/if_ether.h>
> +#endif
> +
> +#ifndef ETH_P_ALL
> +# define ETH_P_ALL 0x0003
> +#endif
> +
> +#ifndef PACKET_RX_RING
> +# define PACKET_RX_RING 5
> +#endif
> +
> +#ifndef PACKET_VERSION
> +# define PACKET_VERSION 10
> +#endif
> +
> +#ifndef HAVE_STRUCT_TPACKET_REQ3
> +# define TPACKET_V3 2
> +
> +struct tpacket_req3 {
> +	unsigned int	tp_block_size;
> +	unsigned int	tp_block_nr;
> +	unsigned int	tp_frame_size;
> +	unsigned int	tp_frame_nr;
> +	unsigned int	tp_retire_blk_tov;
> +	unsigned int	tp_sizeof_priv;
> +	unsigned int	tp_feature_req_word;
> +};
> +#endif
> +
> +static int sk;
> +static long pgsz;
> +
> +static void setup(void)
> +{
> +	pgsz = SAFE_SYSCONF(_SC_PAGESIZE);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (sk > 0)
> +		SAFE_CLOSE(sk);
> +}
> +
> +static int create_skbuf(unsigned int sizeof_priv)
> +{
> +	int ver = TPACKET_V3;
> +	struct tpacket_req3 req = {};
> +
> +	req.tp_block_size = pgsz;
> +	req.tp_block_nr = 2;
> +	req.tp_frame_size = req.tp_block_size;
> +	req.tp_frame_nr = req.tp_block_nr;
> +	req.tp_retire_blk_tov = 100;
> +
> +	req.tp_sizeof_priv = sizeof_priv;
> +
> +	sk = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> +	TEST(setsockopt(sk, SOL_PACKET, PACKET_VERSION, &ver, sizeof(ver)));
> +	if (TEST_RETURN && TEST_ERRNO == EINVAL)
> +		tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
> +	if (TEST_RETURN)
> +		tst_brk(TBROK | TTERRNO, "setsockopt(sk, SOL_PACKET, PACKET_VERSION, TPACKET_V3)");
> +
> +	return setsockopt(sk, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
> +}

Also I wonder if we should put it under syscalls/setsockopt(). Maybe we
should adopt a rule that if it's reasonably clear which syscall the test
belongs to we would put it into the syscalls/ directory and use the cve
directory as a fallback for all the rest of the cve reproducers. What do
you think?

-- 
Cyril Hrubis
chrubis@suse.cz
