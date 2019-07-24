From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 24 Jul 2019 11:55:05 +0200
Subject: [LTP] [PATCH 1/2] Essential headers for BPF map creation
In-Reply-To: <20190724092715.GB4917@dell5510>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
 <20190724080328.16145-2-rpalethorpe@suse.com>
 <20190724092715.GB4917@dell5510>
Message-ID: <87h87bdafa.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> ---
>>  include/lapi/bpf.h               | 242 +++++++++++++++++++++++++++++++
>>  include/lapi/syscalls/aarch64.in |   1 +
>>  include/lapi/syscalls/i386.in    |   1 +
>>  include/lapi/syscalls/s390.in    |   1 +
>>  include/lapi/syscalls/sparc.in   |   1 +
>>  include/lapi/syscalls/x86_64.in  |   1 +
>>  6 files changed, 247 insertions(+)
>>  create mode 100644 include/lapi/bpf.h
>
>> diff --git a/include/lapi/bpf.h b/include/lapi/bpf.h
>> new file mode 100644
>> index 000000000..369de0175
>> --- /dev/null
>> +++ b/include/lapi/bpf.h
>> @@ -0,0 +1,242 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2019 Richard Palethorpe <rpalethorpe@suse.com>
>> + *
>> + * Essential Extended Berkeley Packet Filter (eBPF) headers
>> + *
>> + * Mostly copied/adapted from linux/bpf.h and libbpf so that we can perform
>> + * some eBPF testing without any external dependencies.
> Probably the only sane way. But it will be uncomfortable to keep the header
> updated. Simple copy of include/uapi/linux/bpf.h would be easier
> (but we'd require to have kernel headers anyway (<linux/types.h> and
> <linux/bpf_common.h>).

It hasn't been a problem in the past, we just need to add the missing
parts when adding a new test.

--
Thank you,
Richard.
