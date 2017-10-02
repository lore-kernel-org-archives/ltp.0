From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Oct 2017 15:25:16 +0200
Subject: [LTP] [PATCH v2] Add test for CVE-2017-7308 on a raw socket's
 ring buffer
In-Reply-To: <20170725113349.10717-1-rpalethorpe@suse.com>
References: <20170725083657.3581-1-rpalethorpe@suse.com>
 <20170725113349.10717-1-rpalethorpe@suse.com>
Message-ID: <20171002132516.GF1659@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +	SAFE_SETSOCKOPT(sk, SOL_PACKET, PACKET_VERSION, &ver, sizeof(ver));
> +
> +	TEST(setsockopt(sk, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)));
> +	if (i == 0 && TEST_RETURN) {
> +		tst_brk(TBROK | TTERRNO,
> +			"Can't create ring buffer with good settings");
> +	} else if (i == 0) {
> +		tst_res(TPASS, "Can create ring buffer with good settinegs");
> +	} else if (TEST_RETURN && TEST_ERRNO == EINVAL) {
> +		tst_res(TPASS | TTERRNO, "Refused bad tp_sizeof_priv value");
> +	} else if (TEST_RETURN) {
> +		tst_brk(TBROK | TTERRNO, "Unexpected setsockopt() error");
> +	} else {
> +		tst_res(TFAIL, "Allowed bad tp_sizeof_priv value");
> +	}

I guess I would be happier if we split the test function into two in
order to avoid this maze with i == 0 here. If we put the code that
initializes the request and socket into a separate function we would
have avoided 99% of the code duplication anyway.

> +	SAFE_CLOSE(sk);
> +	sk = 0;

The SAFE_CLOSE() resets the fd to -1, there is no need to clear it
yourself here.

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.needs_root = 1,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.13.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
