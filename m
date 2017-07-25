From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 25 Jul 2017 11:14:00 +0200
Subject: [LTP] [PATCH v2] getsockopt: Add test for SO_PEERCRED
In-Reply-To: <1500904998-24947-1-git-send-email-vkabatov@redhat.com>
References: <1500904998-24947-1-git-send-email-vkabatov@redhat.com>
Message-ID: <87h8y0anfr.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi Veronika,

vkabatov@redhat.com writes:

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

You don't need this anymore.

>  include $(top_srcdir)/include/mk/testcases.mk
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/getsockopt/getsockopt02.c b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
> new file mode 100644
> index 0000000..50e9034
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getsockopt/getsockopt02.c
> @@ -0,0 +1,106 @@
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
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +static int socket_fd, fork_socket_fd, accepted;
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
> +
> +static void fork_func(void)
> +{
> +	fork_socket_fd = SAFE_SOCKET(sun.sun_family, SOCK_STREAM, 0);
> +	SAFE_CONNECT(fork_socket_fd, (struct sockaddr *)&sun, sizeof(sun));
> +}

To avoid race conditions you probably want to keep the child process
alive until the parent has read the peer creds.

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#229-fork-and-parent-child-synchronization

> +
> +static void test_function(void)
> +{
> +	pid_t fork_id;
> +	struct ucred cred;
> +	int status;
> +	socklen_t cred_len = sizeof(cred);
> +
> +	fork_id = SAFE_FORK();
> +	if (!fork_id) {
> +		fork_func();
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(fork_id, &status, 0);

I'm surprised this works. It is waiting for the child to exit (or
receive some other signal, but I can't see what) then accepts the
connection from the child, but after the child is dead. If it works then
I would guess that some race is happening within the kernel between
socket and process cleanup.

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
> +	if (accepted >= 0) {
> +		(void)shutdown(accepted, SHUT_RDWR);
> +		SAFE_CLOSE(accepted);
> +	}
> +	if (fork_socket_fd >= 0)
> +		SAFE_CLOSE(fork_socket_fd);

Unlike with threads, fork does not share memory with the child
process. So fork_socket_fd will always be zero in the parent. You could
just call SAFE_CLOSE at the end of fork_func().

> +
> +	if (fork_id != cred.pid) {
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

This is probably overkill.

> +		SAFE_CLOSE(accepted);
> +	}
> +	if (fork_socket_fd >= 0)
> +		SAFE_CLOSE(fork_socket_fd);

Again this will always be zero as cleanup() is not called by the child.

> +	if (socket_fd >= 0)
> +		SAFE_CLOSE(socket_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_function,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};
> --
> 2.7.4


--
Thank you,
Richard.
