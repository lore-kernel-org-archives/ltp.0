From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 27 Jan 2021 08:52:45 +0100
Subject: [LTP] [PATCH v3 2/7] can: Add can_common.h for vcan device setup
In-Reply-To: <20210126212855.GC15365@pevik>
References: <20210120143723.26483-1-rpalethorpe@suse.com>
 <20210120143723.26483-3-rpalethorpe@suse.com>
 <058a6f05-d5ca-0746-dc4e-007253d3a84d@hartkopp.net> <87bldd9t9i.fsf@suse.de>
 <20210126212855.GC15365@pevik>
Message-ID: <64f599af-f2a7-901d-06a6-a5ff56a107a2@hartkopp.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 26.01.21 22:28, Petr Vorel wrote:
> Hi Oliver, Richie,
> 
>>>> --- /dev/null
>>>> +++ b/testcases/network/can/filter-tests/can_common.h
>>>> @@ -0,0 +1,75 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (c) 2021 SUSE LLC
>>>> + */
>>>> +
>>>> +#include <stdio.h>
>>>> +#include <stdlib.h>
>>>> +#include <unistd.h>
>>>> +#include <string.h>
>>>> +
>>>> +#include <sys/types.h>
>>>> +#include <sys/socket.h>
>>>> +#include <sys/ioctl.h>
>>>> +#include <sys/time.h>
>>>> +
>>>> +#include "tst_cmd.h"
>>>> +#include "tst_safe_stdio.h"
>>>> +#include "tst_safe_file_ops.h"
>>>> +
>>>> +#include <linux/if.h>
>>>> +#include <linux/can.h>
>>>> +#include <linux/can/raw.h>
>>>> +
>>>> +#ifndef IFF_ECHO
>>>> +# define IFF_ECHO (1<<18)
>>>> +#endif
> Thanks a lot, Richie!
> 
>>> IFF_ECHO was included into Linux 2.6.25 together with the CAN
>>> subsystem itself.
> 
>>> So when you run the tests on Kernels < 2.6.25 you don't have CAN
>>> support and don't need IFF_ECHO too.
> 
>> Petr, what kernel version and/or distro version did compilation fail on?
> 
>> There is a small chance someone might be compiling with old kernel
>> headers relative to their kernel. However it is a challenge to compile
>> LTP with such an old user land.
> 
> No, we don't support 2.6.25 :). I was playing with Buildroot distro in my spare time.
> These embedded toolchains suffer compatibility problems (usually uclibc-ng and
> sometimes musl lack the support). This problem was when using sourcery-arm-*.

:-/

> But this is definitely not a blocker for this patchset. That lapi is not a must,
> I can fix it some time later. I usually fix few of these problems before each
> LTP release.

Ok. No problem. I wasn't aware that e.g. musl or other toolchains select 
such strange starting points for their include files.

Thanks,
Oliver
