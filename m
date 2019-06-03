From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 3 Jun 2019 16:12:51 +0200
Subject: [LTP] [PATCH 2/2] syscalls/mbind0{2, 3,
	4}: Add basic mbind tests
In-Reply-To: <20190228153425.10286-3-chrubis@suse.cz>
References: <20190228153425.10286-1-chrubis@suse.cz>
 <20190228153425.10286-3-chrubis@suse.cz>
Message-ID: <20190603141251.GC13662@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril,

> +#include <errno.h>
> +#include "config.h"
> +#ifdef HAVE_NUMA_H
> +# include <numa.h>
> +# include <numaif.h>
> +#endif
> +#include "tst_test.h"
> +#include "tst_numa.h"
> +
> +#ifdef HAVE_NUMA_H
This needs to be tested against HAVE_NUMA_V2 to get proper libnuma detection in
cross-compilation [1] [2]:

/tmp/cclVNEz5.o: In function `verify_policy':
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:46: undefined reference to `numa_allocate_nodemask'
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:51: undefined reference to `numa_bitmask_setbit'
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:53: undefined reference to `tst_numa_map'
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:55: undefined reference to `mbind'
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:58: undefined reference to `tst_numa_mode_name'
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:64: undefined reference to `tst_numa_mode_name'
/tmp/cclVNEz5.o: In function `numa_free_nodemask':
/usr/include/numa.h:183: undefined reference to `numa_bitmask_free'
/tmp/cclVNEz5.o: In function `verify_policy':
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:78: undefined reference to `tst_nodemap_count_pages'
/tmp/cclVNEz5.o: In function `setup':
/usr/src/ltp/testcases/kernel/syscalls/mbind/mbind04.c:34: undefined reference to `tst_get_nodemap'
collect2: error: ld returned 1 exit status

Id' personally move numa includes after it.

Kind regards,
Petr

[1] https://api.travis-ci.org/v3/job/540754157/log.txt
[2] https://travis-ci.org/pevik/ltp/builds/540754154
