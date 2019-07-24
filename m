From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 24 Jul 2019 14:15:18 +0200
Subject: [LTP] [PATCH 2/2] BPF: Sanity check creating and updating maps
In-Reply-To: <20190724091851.GA4917@dell5510>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
 <20190724080328.16145-3-rpalethorpe@suse.com>
 <20190724091851.GA4917@dell5510>
Message-ID: <87ftmvd3xl.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> LGTM with minor comments.
>
> ...
>> diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
> ...
>> +#include <limits.h>
>> +#include <string.h>
>> +
>> +#include "config.h"
>> +#include "tst_test.h"
>> +#include "lapi/bpf.h"
>> +
>> +#define KEY_SZ 8
>> +#define VAL_SZ 1024
>> +
>> +struct map_type {
>> +	uint32_t id;
>> +	char *name;
>> +};
>> +
>> +static const struct map_type map_types[] = {
>> +	{BPF_MAP_TYPE_HASH, "hash"},
>> +	{BPF_MAP_TYPE_ARRAY, "array"}
>> +};
>> +
>> +static void *key;
>> +static void *val0;
>> +static void *val1;
>> +
>> +static void setup(void)
>> +{
>> +	key = SAFE_MALLOC(KEY_SZ);
>> +	memset(key, 0, (size_t) KEY_SZ);
>> +	val0 = SAFE_MALLOC(VAL_SZ);
>> +	val1 = SAFE_MALLOC(VAL_SZ);
>> +	memset(val1, 0, (size_t) VAL_SZ);
>> +}
>> +
>> +void run(unsigned int n)
>> +{
>> +	int fd, i;
>> +	union bpf_attr attr;
>> +	memset(&attr, 0, sizeof(attr));
>> +	attr.map_type = map_types[n].id;
>> +	attr.key_size = n == 0 ? KEY_SZ : 4;
> Out of curiosity why 4? As whole test is working for KEY_SZ >= 1 (but for second
> test it's needed to be 4).

The second test is for an array map type which only supports 32bit integer indexes.

-- 
Thank you,
Richard.
