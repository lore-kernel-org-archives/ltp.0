From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 19 Jan 2021 17:39:01 +0100
Subject: [LTP] [PATCH v2 4/6] can_recv_own_msgs: Convert to new library
In-Reply-To: <87bldkq41l.fsf@suse.de>
References: <20210119093143.17222-1-rpalethorpe@suse.com>
 <20210119093143.17222-5-rpalethorpe@suse.com>
 <322f1056-0a73-65e6-531a-3275029df256@pengutronix.de>
 <YAb1Wncn2/x6LBYj@yuki.lan>
 <3277a88e-0301-7f3d-b024-c728e1041092@pengutronix.de>
 <87bldkq41l.fsf@suse.de>
Message-ID: <85d808dd-c8c3-1216-ee6e-94d63ddf0f2b@pengutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/19/21 5:34 PM, Richard Palethorpe wrote:
> Hello All,
> 
> Marc Kleine-Budde <mkl@pengutronix.de> writes:
> 
>> On 1/19/21 4:06 PM, Cyril Hrubis wrote:
>>> Hi!
>>>>>  /*
>>>>> - * tst-rcv-own-msgs.c
>>>>> - *
>>>>> - * Copyright (c) 2010 Volkswagen Group Electronic Research
>>>>> - * All rights reserved.
>>>>> - *
>>>>> - * Redistribution and use in source and binary forms, with or without
>>>>> - * modification, are permitted provided that the following conditions
>>>>> - * are met:
>>>>> - * 1. Redistributions of source code must retain the above copyright
>>>>> - *    notice, this list of conditions and the following disclaimer.
>>>>> - * 2. Redistributions in binary form must reproduce the above copyright
>>>>> - *    notice, this list of conditions and the following disclaimer in the
>>>>> - *    documentation and/or other materials provided with the distribution.
>>>>> - * 3. Neither the name of Volkswagen nor the names of its contributors
>>>>> - *    may be used to endorse or promote products derived from this software
>>>>> - *    without specific prior written permission.
>>>>
>>>> IANAL, I think you're missing this license. Is looks like some sort
>>>> of BSD to me.
> 
> Ufff, thanks, I should pay more attention when it is a test imported
> from elsewhere.
> 
>>>>
>>>>> - *
>>>>> - * Alternatively, provided that this notice is retained in full, this
>>>>> - * software may be distributed under the terms of the GNU General
>>>>> - * Public License ("GPL") version 2, in which case the provisions of the
>>>>> - * GPL apply INSTEAD OF those given above.
>>>>
>>>> It doesn't say "or later".
>>>
>>> Looks like we cannot just remove this license. So what about moving this
>>> text into a separate COPYING file and changing the SPDX to GPL-v2.0?
>>
>> This file is dual licensed, better keep it dual licensed.
>>
>> regards,
>> Marc
> 
> HHmm, this appears to be the BSD-3-Clause license with the following
> text inserted in the middle:
> 
>  * Alternatively, provided that this notice is retained in full, this
>  * software may be distributed under the terms of the GNU General
>  * Public License ("GPL") version 2, in which case the provisions of the
>  * GPL apply INSTEAD OF those given above.
>  *
>  * The provided data structures and external interfaces from this code
>  * are not restricted to be used by modules with a GPL compatible license.
> 
> I don't see any corresponding SPDX identifier or exception for this. It
> is probably easiest and safest just to keep it as-is.

I think the Linux kernel uses:

/* SPDX-License-Identifier: ((GPL-2.0-only WITH Linux-syscall-note) OR
BSD-3-Clause) */

e.g.:

https://elixir.bootlin.com/linux/v5.10/source/include/uapi/linux/can/gw.h

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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210119/f1239299/attachment.sig>
