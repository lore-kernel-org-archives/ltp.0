From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Jan 2021 15:53:46 +0100
Subject: [LTP] [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
In-Reply-To: <20210119093143.17222-5-rpalethorpe@suse.com>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-5-rpalethorpe@suse.com>
Message-ID: <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/19/21 10:31 AM, Richard Palethorpe wrote:
> Behavior is approximately the same except for the following:
> 
> * Test will continue after non-fatal errors.
> * We now check the return value of `setsocketopt` and that I/O
>   completed the specified number of bytes.
> * The command line arg, device name, must be prepended with `-D`
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  .../can/filter-tests/can_rcv_own_msgs.c       | 273 ++++++------------
>  1 file changed, 88 insertions(+), 185 deletions(-)
> 
> diff --git a/testcases/network/can/filter-tests/can_rcv_own_msgs.c b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
> index 8ad51d298..3726dd6f7 100644
> --- a/testcases/network/can/filter-tests/can_rcv_own_msgs.c
> +++ b/testcases/network/can/filter-tests/can_rcv_own_msgs.c
> @@ -1,88 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
                               ^^^^^^^^^^^^^^^^
>  /*
> - * tst-rcv-own-msgs.c
> - *
> - * Copyright (c) 2010 Volkswagen Group Electronic Research
> - * All rights reserved.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - * 1. Redistributions of source code must retain the above copyright
> - *    notice, this list of conditions and the following disclaimer.
> - * 2. Redistributions in binary form must reproduce the above copyright
> - *    notice, this list of conditions and the following disclaimer in the
> - *    documentation and/or other materials provided with the distribution.
> - * 3. Neither the name of Volkswagen nor the names of its contributors
> - *    may be used to endorse or promote products derived from this software
> - *    without specific prior written permission.

IANAL, I think you're missing this license. Is looks like some sort of BSD to me.

> - *
> - * Alternatively, provided that this notice is retained in full, this
> - * software may be distributed under the terms of the GNU General
> - * Public License ("GPL") version 2, in which case the provisions of the
> - * GPL apply INSTEAD OF those given above.

It doesn't say "or later".

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210119/7ae824d6/attachment.sig>
