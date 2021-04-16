From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 16 Apr 2021 11:19:36 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/chown: rewrite chown/chown01.c
 with the new api
In-Reply-To: <20210415063518.174631-2-xieziyao@huawei.com>
References: <20210415063518.174631-1-xieziyao@huawei.com>
 <20210415063518.174631-2-xieziyao@huawei.com>
Message-ID: <YHlWqG3x4Ea0EGfH@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two changes, thanks.

> diff --git a/testcases/kernel/syscalls/chown/chown01.c b/testcases/kernel/syscalls/chown/chown01.c
> index 2e42153d6..c4898c53a 100644
> --- a/testcases/kernel/syscalls/chown/chown01.c
> +++ b/testcases/kernel/syscalls/chown/chown01.c
> @@ -1,179 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.

Notice that the original code have been under GPL-2.0, we can't change
it to GPL-2.0-or-later unless we completely delete the test and write a
new one. So I've changed the SPDX to GPL-2.0.

> +/*\
> + * [Description]
>   *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> + * This is a Phase I test for the chown(2) system call. It is intended
> + * to provide a limited exposure of the system call, for now. It
> + * should/will be extended when full functional tests are written for
> + * chown(2).
>   *
> + * [Algorithm]
>   *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
> + * - Execute system call
> + * - Check return code, if system call failed (return=-1)
> + * -   Log the errno and Issue a FAIL message
> + * - Otherwise, Issue a PASS message
> + */

The description was way to verbose and the [Algorithm] was completely
useless and described the obvious. So I've shortened the description
before pushing.


-- 
Cyril Hrubis
chrubis@suse.cz
