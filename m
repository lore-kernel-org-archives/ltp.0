From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 May 2017 16:51:13 +0200
Subject: [LTP] [PATCH v2 02/10] Test for vulnerability CVE-2016-7117 in
 recvmmsg error return path
In-Reply-To: <20170522121341.4663-3-rpalethorpe@suse.com>
References: <20170522121341.4663-1-rpalethorpe@suse.com>
 <20170522121341.4663-3-rpalethorpe@suse.com>
Message-ID: <20170526145113.GA16233@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 22, 2017 at 02:13:33PM +0200, Richard Palethorpe wrote:
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  configure.ac                  |   1 +
>  m4/ltp-mmsghdr.m4             |  22 ++++++
>  testcases/cve/cve-2016-7117.c | 165 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 m4/ltp-mmsghdr.m4
>  create mode 100644 testcases/cve/cve-2016-7117.c
> 
> diff --git a/configure.ac b/configure.ac
> index ecc9a2699..ddfc683a3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -189,5 +189,6 @@ LTP_CHECK_EPOLL_PWAIT
>  LTP_CHECK_KEYUTILS_SUPPORT
>  LTP_CHECK_SYNC_ADD_AND_FETCH
>  LTP_CHECK_BUILTIN_CLEAR_CACHE
> +LTP_CHECK_MMSGHDR
>  
>  AC_OUTPUT
> diff --git a/m4/ltp-mmsghdr.m4 b/m4/ltp-mmsghdr.m4
> new file mode 100644
> index 000000000..05522180e
> --- /dev/null
> +++ b/m4/ltp-mmsghdr.m4
> @@ -0,0 +1,22 @@
> +dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
> +dnl
> +dnl This program is free software;  you can redistribute it and/or modify
> +dnl it under the terms of the GNU General Public License as published by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
> +
> +AC_DEFUN([LTP_CHECK_MMSGHDR],[
> +AC_CHECK_TYPES([struct mmsghdr],,,[
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +])
> +])
> diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
> new file mode 100644
> index 000000000..721e31a45
> --- /dev/null
> +++ b/testcases/cve/cve-2016-7117.c
> @@ -0,0 +1,165 @@
> +/*
> + * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
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
> +/*
> + * CVE-2016-7117
> + *
> + * This tests for a use after free caused by a race between recvmmsg() and
> + * close(). The exit path for recvmmsg() in (a2e2725541f: net: Introduce
> + * recvmmsg socket syscall) called fput() on the active file descriptor before
> + * checking the error state and setting the socket's error field.
> + *
> + * If one or more messages are received by recvmmsg() followed by one which
> + * fails, the socket's error field will be set. If just after recvmmsg() calls
> + * fput(), a call to close() is made on the same file descriptor there is a
> + * race between close() releasing the socket object and recvmmsg() setting its
> + * error field.
> + *
> + * fput() does not release a file descriptor's resources (e.g. a socket)
> + * immediatly, it queues them to be released just before a system call returns
> + * to user land. So the close() system call must call fput() after it is
> + * called in recvmmsg(), exit and release the resources all before the socket
> + * error is set.
> + *
> + * Usually if the vulnerability is present the test will be killed with a
> + * kernel null pointer exception. However this is not guaranteed to happen
> + * every time.
> + *
> + * The following was used for reference
> + * https://blog.lizzie.io/notes-about-cve-2016-7117.html
> + */
> +

Shouldn't we define _GNU_SOURCE here as well? We do that in the m4
check...

> +#include <sys/wait.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/syscall.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +
> +#include "tst_test.h"
> +#include "tst_safe_net.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_timer.h"
> +#include "tst_fuzzy_sync.h"
> +
> +/* The bug was present in the kernel before recvmmsg was exposed by glibc */
> +#include "linux_syscall_numbers.h"
> +
> +#define MSG "abcdefghijklmnop"
> +#define RECV_TIMEOUT 1
> +#define ATTEMPTS 0x1FFFFF
> +
> +#ifndef HAVE_STRUCT_MMSGHDR
> +struct mmsghdr {
> +	struct msghdr msg_hdr;
> +	unsigned int msg_len;
> +};
> +#endif
> +
> +static int socket_fds[2];
> +static struct mmsghdr msghdrs[2] = {
> +	{
> +		.msg_hdr = {
> +			.msg_iov = &(struct iovec) {
> +				.iov_len = sizeof(MSG),
> +			},
> +			.msg_iovlen = 1
> +		}
> +	},
> +	{
> +		.msg_hdr = {
> +			.msg_iov = &(struct iovec) {
> +				.iov_base = (void *)(0xbadadd),
> +				.iov_len = ~0,
> +			},
> +			.msg_iovlen = 1
> +		}
> +	}
> +};
> +static char rbuf[sizeof(MSG)];
> +static struct timespec timeout = { .tv_sec = RECV_TIMEOUT };
> +static struct tst_fzsync_pair fzsync_pair;
> +
> +static void setup(void)
> +{
> +	tst_fzsync_pair_init(&fzsync_pair);
> +}

Just a minor note, we can initialize the fzsync_pair statically
something as:

#define TST_FZSYNC_INITIALIZER { \
	.avg_alpha = 0.25,       \
	.delay_inc = 10,         \
	.update_gap = 0xF        \
}

Then do:

static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_INITIALIZER;

Otherwise this test and the library both looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
