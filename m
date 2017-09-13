From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Sep 2017 17:05:14 +0200
Subject: [LTP] [PATCH v3] Add test for CVE-2017-7308 on a raw socket's
 ring buffer
In-Reply-To: <20170911132233.19658-1-rpalethorpe@suse.com>
References: <20170911132233.19658-1-rpalethorpe@suse.com>
Message-ID: <20170913150514.GB29584@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/m4/ltp-tpacket-v3.m4 b/m4/ltp-tpacket-v3.m4
> new file mode 100644
> index 000000000..fce2e0ebf
> --- /dev/null
> +++ b/m4/ltp-tpacket-v3.m4
> @@ -0,0 +1,22 @@
> +dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
> +
> +AC_DEFUN([LTP_CHECK_TPACKET_V3],[
> +AC_CHECK_TYPES([struct tpacket_req3],,,[
> +#ifdef HAVE_LINUX_IF_PACKET_H
> +# include <linux/if_packet.h>
> +#endif

Do we really need these ifdefs here? Wouldn't the check fail anyway in
a case that the header is ifdefed out?

Or does autoconf break somehow if the header couldn't be included?

> +])
> +])
> diff --git a/runtest/cve b/runtest/cve
> index e789b6667..6d4bde6ee 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -15,5 +15,6 @@ cve-2017-2618 cve-2017-2618
>  cve-2017-2671 cve-2017-2671
>  cve-2017-5669 cve-2017-5669
>  cve-2017-6951 cve-2017-6951
> +cve-2017-7308 cve-2017-7308
>  cve-2017-7472 keyctl04
>  cve-2017-1000364 stack_clash
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index 24036bc40..cd805d3ee 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -7,4 +7,5 @@ cve-2017-2618
>  cve-2017-2671
>  cve-2017-6951
>  cve-2017-5669
> +cve-2017-7308
>  stack_clash
> diff --git a/testcases/cve/cve-2017-7308.c b/testcases/cve/cve-2017-7308.c
> new file mode 100644
> index 000000000..b3304d391
> --- /dev/null
> +++ b/testcases/cve/cve-2017-7308.c
> @@ -0,0 +1,125 @@
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
> +
> +static void cleanup(void)
> +{
> +	if (sk > 0)
> +		SAFE_CLOSE(sk);
> +}
> +
> +static void run(unsigned int i)
> +{
> +	int ver = TPACKET_V3;
> +	struct tpacket_req3 req = {};
> +
> +	req.tp_block_size = 4096;
> +	req.tp_block_nr = 2;
> +	req.tp_frame_size = req.tp_block_size;
> +	req.tp_frame_nr = req.tp_block_nr;
> +	req.tp_retire_blk_tov = 100;
> +
> +	if (i == 0)
> +		req.tp_sizeof_priv = 1024;
> +	else
> +		req.tp_sizeof_priv += (3U << 30);
> +
> +	sk = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
> +	TEST(setsockopt(sk, SOL_PACKET, PACKET_VERSION, &ver, sizeof(ver)));
> +	if (TEST_RETURN && TEST_ERRNO == EINVAL)
> +		tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
> +	else if (TEST_RETURN)
> +		tst_brk(TBROK | TTERRNO, "setsockopt(sk, SOL_PACKET, PACKET_VERSION, TPACKET_V3)");

No need for the else branch here.

> +	TEST(setsockopt(sk, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)));
> +	if (i == 0 && TEST_RETURN) {
> +		tst_brk(TBROK | TTERRNO,
> +			"Can't create ring buffer with good settings");
> +	} else if (i == 0) {
> +		tst_res(TPASS, "Can create ring buffer with good settinegs");

And here.

Just remeber that tst_brk() actually exits the test...

> +	} else if (TEST_RETURN && TEST_ERRNO == EINVAL) {
> +		tst_res(TPASS | TTERRNO, "Refused bad tp_sizeof_priv value");
> +	} else if (TEST_RETURN) {
> +		tst_brk(TBROK | TTERRNO, "Unexpected setsockopt() error");
> +	} else {
> +		tst_res(TFAIL, "Allowed bad tp_sizeof_priv value");
> +	}
> +	SAFE_CLOSE(sk);
> +	sk = 0;

The SAFE_CLOSE() zeroes the argument for you :-).

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.needs_root = 1,
> +	.cleanup = cleanup,
> +	.min_kver = "3.2",
> +};

-- 
Cyril Hrubis
chrubis@suse.cz
