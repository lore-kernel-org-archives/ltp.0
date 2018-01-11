From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 11 Jan 2018 13:26:28 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
In-Reply-To: <20180110155505.28433-1-mmoese@suse.de>
References: <20180110155505.28433-1-mmoese@suse.de>
Message-ID: <87o9m0k2dn.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Michael,

Welcome to LTP :-)

Michael Moese writes:

> +
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/shm.h>
> +#include <sys/types.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_safe_sysv_ipc.h"

It is better to use a shared mapping created with mmap. The SYSV safe
macros are only for testing SYSV shared memory itself and otherwise
should be avoided.

-- 
Thank you,
Richard.
