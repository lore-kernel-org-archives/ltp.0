From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Jan 2018 16:30:45 +0100
Subject: [LTP] [PATCH v4 2/2] syscalls/migrate_pages03.c: Add new
 regression test
In-Reply-To: <1515059054-20875-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180103143836.GA7370@rei>
 <1515059054-20875-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1515059054-20875-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20180104153045.GA25335@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#include <errno.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#if HAVE_NUMA_H
> +#include <numa.h>
> +#endif
> +#if HAVE_NUMAIF_H
> +#include <numaif.h>
> +#endif
> +
> +#include "config.h"

One small nit, the HAVE_NUMA* macros are defined in config.h so they are
defined only after the config.h header is included. I wonder if these
haders are needed to be included here at all, because they were not
included at all.

Also it's customary to use #ifdef instead of #if for autoconf macros.

-- 
Cyril Hrubis
chrubis@suse.cz
