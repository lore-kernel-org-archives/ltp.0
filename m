From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jul 2019 15:38:49 +0200
Subject: [LTP] [PATCH] syscalls/ioprio: Add test cases for I/O priority
In-Reply-To: <20190712102409.12906-1-linus.walleij@linaro.org>
References: <20190712102409.12906-1-linus.walleij@linaro.org>
Message-ID: <20190712133849.GB14566@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The ioprio_get/ioprio_set syscalls are used primarily by the
> userspace tool "ionice" to set priority of a process, user or
> process group toward the I/O (block layer) scheduler.
> 
> This adds a simple iprio_get test and two more verbose tests
> for ioprio_set.
> 
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I never did LTP work before. Reviews appreciated.
> If this proves worthwhile I will add test cases for
> real-time and other scheduling requireing root access
> and possibly look into testing user or process group
> scheduling as well.
> ---
>  testcases/kernel/syscalls/ioprio/.gitignore   |   1 +
>  testcases/kernel/syscalls/ioprio/Makefile     |  22 +++
>  testcases/kernel/syscalls/ioprio/ioprio.h     |  44 +++++
>  .../kernel/syscalls/ioprio/ioprio_get01.c     |  72 ++++++++
>  .../kernel/syscalls/ioprio/ioprio_set01.c     | 123 +++++++++++++
>  .../kernel/syscalls/ioprio/ioprio_set02.c     | 166 ++++++++++++++++++
>  6 files changed, 428 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioprio/.gitignore
>  create mode 100644 testcases/kernel/syscalls/ioprio/Makefile
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio.h
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_get01.c
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set01.c
>  create mode 100644 testcases/kernel/syscalls/ioprio/ioprio_set02.c
> 
> diff --git a/testcases/kernel/syscalls/ioprio/.gitignore b/testcases/kernel/syscalls/ioprio/.gitignore
> new file mode 100644
> index 000000000000..fc1c236053a4
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/.gitignore
> @@ -0,0 +1 @@
> +/ioprio_get01.c
        ^
This looks like a mistake.

> diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
> new file mode 100644
> index 000000000000..62183ebcf856
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited
> + */
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +
> +#include "test.h"

So first of all you have picked the deprecated test library that is kept
around only for old tests that haven't been converted to the new library
yet.

Have a look at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

-- 
Cyril Hrubis
chrubis@suse.cz
