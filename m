From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Jul 2018 14:37:12 +0200
Subject: [LTP] [PATCH] add new testcase for bind
In-Reply-To: <20180726084620.14645-1-mmoese@suse.de>
References: <20180726084620.14645-1-mmoese@suse.de>
Message-ID: <20180726123712.GA6687@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Michael,

> With
>   0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
> the behavior of bind() for STREAM UNIX sockets changed in
> case a socket that is already bound is passed to bind() again.

> This testcase fails for the new behavior and passes for the
> old one.

> Signed-off-by: Michael Moese <mmoese@suse.de>
Acked-by: Petr Vorel <pvorel@suse.cz>
Nice patch, minor nits mentioned bellow.


Kind regards,
Petr

> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/bind/.gitignore |   1 +
>  testcases/kernel/syscalls/bind/bind03.c   | 120 ++++++++++++++++++++++
>  3 files changed, 122 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/bind/bind03.c
...

> +++ b/testcases/kernel/syscalls/bind/bind03.c
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright (c) 2018 Michael Moese <mmoese@suse.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */
You can use SPDX license identifier if you like:
SPDX-License-Identifier: GPL-2.0-or-later

> +/* The commit 0fb44559ffd6  af_unix: move unix_mknod() out of bindlock
> + * changed the behavior of bind() for STREAM UNIX domain sockets if
> + */
> +
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
These headers are included by tst_safe_net.h, maybe we don't need to include them.
The same applies for limits.h and unistd.h (loaded by tst_test.h).

> +
> +#include <err.h>
This header is not needed (we don't need warn() etc.).

> +#include <errno.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_net.h"
> +
> +#define SOCK_NAME "socket.1"
...

> +	/*
> +	 * Once a STREAM UNIX domain socket has been bound, it can't be
> +	 * rebound. Expected error is EINVAL.
> +	 * cannot use SAFE_BIND() here.
I wouldn't note SAFE_BIND().

> +	 */
> +	if (bind(sock1, (struct sockaddr *)&sun, sizeof(sun)) == 0) {
> +		tst_res(TFAIL, "re-binding of socket succeeded");
> +		return;
> +	}
> +
> +	if (errno != EINVAL) {
> +		tst_res(TFAIL | TERRNO, "expected EINVAL");
> +		return;
> +	}
> +
> +	sock2 = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
> +
> +	/*
> +	 * Since a socket is already bound to the pathname, it can't be bound
> +	 * to a second socket. Expected error is EADDRINUSE.
> +	 * again, cannot use SAFE_BIND().
> +	 */
The same here.


Kind regards,
Petr
