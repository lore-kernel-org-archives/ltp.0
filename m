From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 19 Jul 2017 11:26:39 +0200
Subject: [LTP] [PATCH] getsockopt: Add test for SO_PEERCRED
In-Reply-To: <1500392093-23272-1-git-send-email-vkabatov@redhat.com>
References: <1500392093-23272-1-git-send-email-vkabatov@redhat.com>
Message-ID: <874lu8rd4g.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Veronika,

vkabatov@redhat.com writes:

> From: Veronika Kabatova <vkabatov@redhat.com>
>
> Connect to a socket from a thread anf check SO_PEERCRED returns
> correct PID.
>
> Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
> ---
>  runtest/syscalls                                   |   1 +
>  testcases/kernel/syscalls/.gitignore               |   1 +
>  testcases/kernel/syscalls/getsockopt/Makefile      |   2 +
>  .../kernel/syscalls/getsockopt/getsockopt02.c      | 102 +++++++++++++++++++++
>  4 files changed, 106 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/getsockopt/getsockopt02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 91aba85..11055cf 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -433,6 +433,7 @@ getsid02 getsid02
>  getsockname01 getsockname01
>
>  getsockopt01 getsockopt01
> +getsockopt02 getsockopt02
>
>  gettid01 gettid01
>
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index 3d9bb75..c0e5218 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -361,6 +361,7 @@
>  /getsid/getsid02
>  /getsockname/getsockname01
>  /getsockopt/getsockopt01
> +/getsockopt/getsockopt02
>  /gettid/gettid01
>  /gettimeofday/gettimeofday01
>  /gettimeofday/gettimeofday02
> diff --git a/testcases/kernel/syscalls/getsockopt/Makefile b/testcases/kernel/syscalls/getsockopt/Makefile
> index bd617d8..033d73f 100644
> --- a/testcases/kernel/syscalls/getsockopt/Makefile
> +++ b/testcases/kernel/syscalls/getsockopt/Makefile
> @@ -18,6 +18,8 @@
>
>  top_srcdir		?= ../../../..
>
> +getsockopt02: CFLAGS+=-pthread
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt02.c b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
> new file mode 100644
> index 0000000..27942b9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright (C) 2017 Red Hat, Inc.
> + *
> + * This program is free software;  you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Test description: Test retrieving of peer credentials (SO_PEERCRED)
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <pthread.h>
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
> +
> +static int socket_fd, thread_socket_fd, accepted;
> +static struct sockaddr_un sun;
> +
> +#define SOCKNAME	"testsocket"
> +
> +static void setup(void)
> +{
> +	sun.sun_family = AF_UNIX;
> +	(void)strcpy(sun.sun_path, SOCKNAME);
> +	socket_fd = SAFE_SOCKET(sun.sun_family, SOCK_STREAM, 0);
> +	SAFE_BIND(socket_fd, (struct sockaddr *)&sun, sizeof(sun));
> +	SAFE_LISTEN(socket_fd, SOMAXCONN);
> +}

FYI, this could be simplified with socketpair() although I don't think
there is a SAFE_* function for that yet, but it shouldn't be hard to
implement.

> +
> +void *thread_func(void *args __attribute__((unused)))
> +{
> +	thread_socket_fd = SAFE_SOCKET(sun.sun_family, SOCK_STREAM, 0);
> +	SAFE_CONNECT(thread_socket_fd, (struct sockaddr *)&sun, sizeof(sun));
> +	return NULL;
> +}
> +
> +static void test_function(void)
> +{
> +	pthread_t thread_id;
> +	struct ucred cred;
> +	socklen_t cred_len = sizeof(cred);
> +
> +	SAFE_PTHREAD_CREATE(&thread_id, NULL, thread_func, NULL);

I am wondering if fork() would make for a stronger test? As we are then
communicating between processes.

> +	accepted = accept(socket_fd, NULL, NULL);
> +	if (accepted < 0) {
> +		tst_res(TFAIL | TERRNO, "Error with accepting connection");
> +		return;
> +	}
> +	if (getsockopt(accepted, SOL_SOCKET,
> +				SO_PEERCRED, &cred, &cred_len) < 0) {
> +		tst_res(TFAIL | TERRNO, "Error while getting socket options");
> +		return;
> +	}
> +
> +	SAFE_PTHREAD_JOIN(thread_id, NULL);
> +	if (accepted >= 0) {
> +		(void)shutdown(accepted, SHUT_RDWR);
> +		SAFE_CLOSE(accepted);
> +	}
> +	if (thread_socket_fd >= 0)
> +		SAFE_CLOSE(thread_socket_fd);
> +
> +	if (getpid() != cred.pid) {
> +		tst_res(TFAIL, "Received wrong PID %d, expected %d",
> +				cred.pid, getpid());
> +	} else
> +		tst_res(TPASS, "Test passed");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (accepted >= 0) {
> +		(void)shutdown(accepted, SHUT_RDWR);
> +		SAFE_CLOSE(accepted);
> +	}
> +	if (thread_socket_fd >= 0)
> +		SAFE_CLOSE(thread_socket_fd);
> +	if (socket_fd >= 0)
> +		SAFE_CLOSE(socket_fd);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "getsockopt02",

This is not necessary anymore, the tid is taken from the file name.

> +	.test_all = test_function,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +};
> --
> 2.7.4
--
Thank you,
Richard.
