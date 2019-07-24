From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 24 Jul 2019 11:18:51 +0200
Subject: [LTP] [PATCH 2/2] BPF: Sanity check creating and updating maps
In-Reply-To: <20190724080328.16145-3-rpalethorpe@suse.com>
References: <20190724080328.16145-1-rpalethorpe@suse.com>
 <20190724080328.16145-3-rpalethorpe@suse.com>
Message-ID: <20190724091851.GA4917@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

LGTM with minor comments.

...
> diff --git a/testcases/kernel/syscalls/bpf/bpf_map01.c b/testcases/kernel/syscalls/bpf/bpf_map01.c
...
> +#include <limits.h>
> +#include <string.h>
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/bpf.h"
> +
> +#define KEY_SZ 8
> +#define VAL_SZ 1024
> +
> +struct map_type {
> +	uint32_t id;
> +	char *name;
> +};
> +
> +static const struct map_type map_types[] = {
> +	{BPF_MAP_TYPE_HASH, "hash"},
> +	{BPF_MAP_TYPE_ARRAY, "array"}
> +};
> +
> +static void *key;
> +static void *val0;
> +static void *val1;
> +
> +static void setup(void)
> +{
> +	key = SAFE_MALLOC(KEY_SZ);
> +	memset(key, 0, (size_t) KEY_SZ);
> +	val0 = SAFE_MALLOC(VAL_SZ);
> +	val1 = SAFE_MALLOC(VAL_SZ);
> +	memset(val1, 0, (size_t) VAL_SZ);
> +}
> +
> +void run(unsigned int n)
> +{
> +	int fd, i;
> +	union bpf_attr attr;
> +	memset(&attr, 0, sizeof(attr));
> +	attr.map_type = map_types[n].id;
> +	attr.key_size = n == 0 ? KEY_SZ : 4;
Out of curiosity why 4? As whole test is working for KEY_SZ >= 1 (but for second
test it's needed to be 4).

> +	attr.value_size = VAL_SZ;
> +	attr.max_entries = 1;
+ we usually use struct test_case + description at the test start, but I guess
it's ok like this.

> +
> +	if ((fd = bpf(BPF_MAP_CREATE, &attr, sizeof(attr))) == -1) {
> +		tst_brk(TFAIL | TERRNO, "Failed to create %s map",
> +			map_types[n].name);
> +	} else {
> +		tst_res(TPASS, "Created %s map", map_types[n].name);
> +	}
> +
> +	if (n == 0)
> +		memcpy(key, "12345678", KEY_SZ);
> +	else
> +		memset(key, 0, 4);
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.map_fd = fd;
> +	attr.key = ptr_to_u64(key);
> +	attr.value = ptr_to_u64(val1);
> +
> +	TEST(bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr)));
> +	if (n == 0) {
> +		if (TST_RET != -1 || TST_ERR != ENOENT) {
> +			tst_res(TFAIL | TTERRNO,
> +				"Empty hash map lookup should fail with ENOENT");
> +		} else {
> +			tst_res(TPASS | TTERRNO, "Empty hash map lookup");
> +		}
> +	} else if (TST_RET != -1) {
> +		for (i = 0;;) {
> +			if (*(char *) val1 != 0) {
> +				tst_res(TFAIL,
> +					"Preallocated array map val not zero");
I guess here is missing break.

> +			} else if (++i >= VAL_SZ) {
> +				tst_res(TPASS,
> +					"Preallocated array map lookup");
> +				break;
> +			}
> +		}
> +	} else {
> +		tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
> +	}
...

Kind regards,
Petr
