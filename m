From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 13 Aug 2018 11:18:09 +0200
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add
	set_mempolicy numa tests.
In-Reply-To: <20180809152308.18982-1-chrubis@suse.cz>
References: <20180809152308.18982-1-chrubis@suse.cz>
Message-ID: <87r2j24oby.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Just some shallow comments on the API.

Cyril Hrubis <chrubis@suse.cz> writes:

> This is initial attempt to replace numa.sh tests that despite having
> been fixed several times have still many shortcommings that wouldn't
> easy to fix. It's not finished nor 100% replacement but I'm sending this
> anyway because I would like to get feedback at this point.
>
> The main selling points of these testcases are:
>
> The memory allocated for the testing is tracked exactly. We make sure
> that the mapping has separate record in /proc/$PID/numa_maps by mapping
> a region, then unmapping hole at the start and at the end of the
> mapping, then we fault the pages in the middle of the original mapping.
> We carefuly avoid doing anything that would cause the mapping to expand
> in the child process while the parent takes the measurements, even
> opening a file with fopen() may cause buffers to be allocated which may
> expand the mapping which is the reason we fork and take the measurements
> in the parent after the child process has faulted the pages.
>
> The tests for file based shared interleaved mappings are no longer
> mapping a single small file but rather than that we accumulate statistic
> for larger amount of files over longer period of time and we also allow
> for small offset (currently 10%). We should probably also increase the
> number of samples we take as currently it's about 5MB in total on x86
> although I haven't managed to make this test fail so far. This also
> fixes the test on Btrfs where the synthetic test that expects the pages
> to be distributed exactly equally fails.
>
> What is not finished is compilation without libnuma, that will fail
> currently, but that is only a matter of adding a few ifdefs. And the
> coverage is still lacking, ideas for interesting testcases are welcomed
> as well.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Michal Hocko <mhocko@kernel.org>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_numa.h                                 |  71 +++++++
>  lib/tst_numa.c                                     | 231 +++++++++++++++++++++
>  runtest/numa                                       |   5 +
>  testcases/kernel/syscalls/set_mempolicy/.gitignore |   4 +
>  testcases/kernel/syscalls/set_mempolicy/Makefile   |   7 +
>  .../kernel/syscalls/set_mempolicy/set_mempolicy.h  |  26 +++
>  .../syscalls/set_mempolicy/set_mempolicy01.c       |  98 +++++++++
>  .../syscalls/set_mempolicy/set_mempolicy02.c       |  91 ++++++++
>  .../syscalls/set_mempolicy/set_mempolicy03.c       |  99 +++++++++
>  .../syscalls/set_mempolicy/set_mempolicy04.c       | 112 ++++++++++
>  10 files changed, 744 insertions(+)
>  create mode 100644 include/tst_numa.h
>  create mode 100644 lib/tst_numa.c
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/.gitignore
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/Makefile
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy.h
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
>  create mode 100644 testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
>
> diff --git a/include/tst_numa.h b/include/tst_numa.h
> new file mode 100644
> index 000000000..08833e398
> --- /dev/null
> +++ b/include/tst_numa.h
> @@ -0,0 +1,71 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#ifndef TST_NUMA_H__
> +#define TST_NUMA_H__
> +
> +/**
> + * Numa nodemap.
> + */
> +struct tst_nodemap {
> +        /** Number of nodes in map */
> +	unsigned int cnt;
> +	/** Page allocation counters */
> +	unsigned int *counters;
> +	/** Array of numa ids */
> +	unsigned int map[];
> +};
> +
> +/**
> + * Clears numa counters. The counters are lazy-allocated on first call of this function.
> + *
> + * @nodes Numa nodemap.
> + */
> +void tst_nodemap_reset_counters(struct tst_nodemap *nodes);
> +
> +/**
> + * Allocates requested number of pages, using mmap(), faults them and parsers
               ^the

> + * /proc/$PID/numa_maps and adds amount of pages allocated per node to the
                                   ^the

> + * nodemap counters. We also make sure that only the newly allocated pages are
> + * accounted for correctly, which requires forking a separate process to

I think you mean that only newly allocated pages are counted?
(i.e. previously allocated pages are ignored). The above implies that
previously allocated pages are accounted for incorrectly.

> + * allocate the memory and checkpoints to synchronize parent and child process.
> + * The nodemap has to have counters initialized which happens on first counter
> + * reset.
> + *
> + * @nodes Nodemap with initialized counters.
> + * @path  If non-NULL the mapping is backed up by a file.
> + * @pages Number of pages to be allocated.
> + */
> +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> +                          unsigned int pages);
> +
> +/**
> + * Frees nodemap.
> + *
> + * @nodes Numa nodemap to be freed.
> + */
> +void tst_nodemap_free(struct tst_nodemap *nodes);
> +
> +/**
> + * Bitflags for tst_get_nodemap() function.
> + */
> +enum tst_numa_types {
> +	TST_NUMA_ANY = 0x00,
> +	TST_NUMA_MEM = 0x01,
> +};
> +
> +/**
> + * Allocates and returns numa node map, which is an array of numa nodes which
> + * contain desired resources e.g. memory.
> + *
> + * @types Bitflags of enum tst_numa_types specifying desired resources.
> + *
> + * @return On success returns allocated and initialized struct tst_nodemap which contains
> + *         array of numa node ids that contains desired resources.
> + */
> +struct tst_nodemap *tst_get_nodemap(int type);
> +
> +#endif /* TST_NUMA_H__ */
> diff --git a/lib/tst_numa.c b/lib/tst_numa.c
> new file mode 100644
> index 000000000..2328c2814
> --- /dev/null
> +++ b/lib/tst_numa.c
> @@ -0,0 +1,231 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <stdio.h>
> +#include <ctype.h>
> +#include "config.h"
> +#ifdef HAVE_NUMA_H
> +# include <numa.h>
> +#endif
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_numa.h"
> +
> +static void store_val(unsigned int node, unsigned int val,
> +                      struct tst_nodemap *nodes)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nodes->cnt; i++) {
> +		if (nodes->map[i] == node) {
> +			nodes->counters[i] += val;

Maybe this should be called inc_counter or similar? Because you are
doing += not =.

> +			break;
> +		}
> +	}
> +
> +//	tst_res(TINFO, "Node %u allocated %u pages", node, val);
> +}
> +
> +static void parse_line(char *line, struct tst_nodemap *nodes)
> +{
> +	char *c;
> +	int state = 0;
> +	int node;
> +	int val;
> +
> +	for (c = line; *c && *c != '\n'; c++) {
> +
> +		if (state == 0 && *c == 'N') {
> +			state = 1;
> +			continue;
> +		}

We need to skip the file path because N3=1.txt is a valid file name.
Unless it is guaranteed we will never parse a line with that file name
in it.

> +
> +		if (state == 1) {
> +			if (isdigit(*c)) {
> +				node = *c - '0';
> +				state = 2;
> +			} else {
> +				state = 0;
> +			}
> +			continue;
> +		}
> +
> +		if (state == 2) {
> +			if (isdigit(*c)) {
> +				node *= 10;
> +				node += *c - '0';
> +			} else {
> +				if (*c == '=') {
> +					val = 0;
> +					state = 3;
> +				} else {
> +					state = 0;
> +				}
> +			}
> +			continue;
> +		}
> +
> +		if (state == 3) {
> +			if (isdigit(*c)) {
> +				val *= 10;
> +				val += *c - '0';
> +			} else {
> +				store_val(node, val, nodes);
> +				state = 0;
> +			}
> +		}
> +	}
> +}
> +
> +static char *strip_newline(char *str)
> +{
> +	size_t i;
> +
> +	for (i = 0; str[i]; i++) {
> +		if (str[i] == '\n') {
> +			str[i] = 0;
> +			break;
> +		}
> +	}
> +
> +	return str;
> +}
> +
> +static void tst_parse_numa_maps(void *ptr, int pid, struct tst_nodemap *nodes)
> +{
> +	FILE *f;
> +	char line[2048];
> +	char fname[128];
> +	void *p;
> +
> +	snprintf(fname, sizeof(fname), "/proc/%i/numa_maps", pid);
> +
> +	f = fopen(fname, "r");
> +	if (!f)
> +		tst_brk(TBROK | TERRNO, "open(/proc/self/numa_maps)");
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		sscanf(line, "%p", &p);
> +		if (p == ptr) {
> +			//tst_res(TINFO, "Parsing '%s'", strip_newline(line));
> +			parse_line(line, nodes);
> +			goto out;
> +		}
> +	}
> +
> +	tst_res(TWARN, "Mapping %p not found in numa_maps!", ptr);
> +out:
> +	fclose(f);
> +}
> +
> +void tst_nodemap_reset_counters(struct tst_nodemap *nodes)
> +{
> +	size_t arr_size = sizeof(unsigned int) * nodes->cnt;
> +
> +	if (!nodes->counters)
> +		nodes->counters = SAFE_MALLOC(arr_size);
> +
> +	memset(nodes->counters, 0, arr_size);
> +}
> +
> +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> +                          unsigned int pages)
> +{
> +	size_t page_size = getpagesize();
> +	char *ptr;
> +	int fd = -1;
> +	int flags = MAP_PRIVATE|MAP_ANONYMOUS;

It might be useful to ensure nodes are allocated here by calling
reset_counters if they are not. On the other hand I am not sure this
makes sense with the current usage.

--
Thank you,
Richard.
