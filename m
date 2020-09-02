From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 Sep 2020 19:05:03 +0200
Subject: [LTP] [PATCH v2 2/4] Add tst_pollute_memory() helper function
In-Reply-To: <20200825160735.24602-3-mdoucha@suse.cz>
References: <20200825160735.24602-1-mdoucha@suse.cz>
 <20200825160735.24602-3-mdoucha@suse.cz>
Message-ID: <20200902170503.GA26811@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> tst_pollute_memory() fills available RAM up to specified limit with given fill
> byte. Useful for testing data disclosure vulnerablities.

Looks nice.
Minor note below.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/lib/tst_memutils.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 SUSE LLC <mdoucha@suse.cz>
> + */
> +
> +#include <unistd.h>
> +#include <limits.h>
> +#include <sys/sysinfo.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +#define BLOCKSIZE (16 * 1024 * 1024)
> +
> +void tst_pollute_memory(size_t maxsize, int fillchar)
> +{
> +	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
> +	void **map_blocks;
> +	struct sysinfo info;
> +
> +	SAFE_SYSINFO(&info);
> +	safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
Out of curiosity, how did you figure out safety?
> +
> +	if (info.freeswap > safety)
> +		safety = 0;
> +
> +	/* Not enough free memory to avoid invoking OOM killer */
> +	if (info.freeram <= safety)
Maybe print TINFO / TWARN here?
> +		return;
> +
> +	if (!maxsize)
> +		maxsize = SIZE_MAX;
> +
> +	if (info.freeram - safety < maxsize / info.mem_unit)
> +		maxsize = (info.freeram - safety) * info.mem_unit;
Don't we also want to use info.bufferram ?
> +
> +	blocksize = MIN(maxsize, blocksize);
> +	map_count = maxsize / blocksize;
> +	map_blocks = SAFE_MALLOC(map_count * sizeof(void *));
> +
> +	/*
> +	 * Keep allocating until the first failure. The address space may be
> +	 * too fragmented or just smaller than maxsize.
> +	 */
> +	for (i = 0; i < map_count; i++) {
> +		map_blocks[i] = mmap(NULL, blocksize, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +
> +		if (map_blocks[i] == MAP_FAILED) {
> +			map_count = i;
> +			break;
> +		}
> +
> +		memset(map_blocks[i], fillchar, blocksize);
> +	}
> +
> +	for (i = 0; i < map_count; i++)
> +		SAFE_MUNMAP(map_blocks[i], blocksize);
> +
> +	free(map_blocks);
> +}

Kind regards,
Petr
