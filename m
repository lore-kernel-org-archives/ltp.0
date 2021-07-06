From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 06 Jul 2021 09:53:51 +0100
Subject: [LTP] [PATCH] vsock01,
 CVE-2021-26708: Add reproducer for race condition
In-Reply-To: <YN8iG1fchuyC/SEI@yuki>
References: <20210702123533.18008-1-rpalethorpe@suse.com>
 <YN8iG1fchuyC/SEI@yuki>
Message-ID: <8735sr961s.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> diff --git a/include/lapi/vm_sockets.h b/include/lapi/vm_sockets.h
>> new file mode 100644
>> index 000000000..94d0248c5
>> --- /dev/null
>> +++ b/include/lapi/vm_sockets.h
>> @@ -0,0 +1,14 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
>> + */
>> +
>> +#include <sys/socket.h>
>> +
>> +#if HAVE_LINUX_VM_SOCKETS_H
>> +#  include <linux/vm_sockets.h>
>> +#endif
>> +
>> +#ifndef VMADDR_CID_LOCAL
>> +#  define VMADDR_CID_LOCAL 1
>> +#endif
>
> I've added guards to this header.
>
>> +#include "config.h"
>> +#include "tst_test.h"
>> +
>> +#if HAVE_LINUX_VM_SOCKETS_H
>> +#  include "tst_fuzzy_sync.h"
>> +#  include "lapi/vm_sockets.h"
>> +
>> +static struct tst_fzsync_pair pair;
>> +int vsock = -1;
>> +
>> +void *writer(LTP_ATTRIBUTE_UNUSED void *unused)
>> +{
>> +	const uint64_t b_buflen = 0x4141;
>> +
>> +	while (tst_fzsync_run_b(&pair)) {
>> +		tst_fzsync_start_race_b(&pair);
>> +		SAFE_SETSOCKOPT(vsock, AF_VSOCK,
>> +				SO_VM_SOCKETS_BUFFER_SIZE,
>> +				&b_buflen, sizeof(b_buflen));
>> +		tst_fzsync_end_race_b(&pair);
>> +	}
>> +
>> +
>> +	return NULL;
>> +}
>
> And sprinkled a few 'static' keywords here, and pushed, thanks.

Just noting; this would be caught by Wmissing-declarations.


-- 
Thank you,
Richard.
