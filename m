From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 1 Aug 2018 08:35:20 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib: Fix result propagation after exec()
	+	tst_reinit()
In-Reply-To: <20180731130852.22739-1-chrubis@suse.cz>
References: <20180731130852.22739-1-chrubis@suse.cz>
Message-ID: <1077521162.37312079.1533126920056.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The result pointer wasn't initialized in tst_reinit(), which haven't
> allowed for test result propagation to the main test process and there
> is actually no reason not to do that. So this commit initializes the
> results pointer in tst_reinit()

This is obviously correct.

> and also adds a needs_ipc_path flag to
> tst_test structure, which causes the library not to unlink the IPC file
> after it has been mapped and also inserts LTP_IPC_PATH to the
> environment.

What is the negative of skipping unlink() for all tests?
Test itself runs in separate process, so cleanup_ipc() should run
anyway and clean it.

.needs_ipc_path - I'm worried users won't know what this is for.
Maybe if it was called ".child_needs_reinit"? reinit appears
to be the only reason we need to keep shm_path around.

Regards,
Jan

> 
> This commit also adds a test that also shows the usage of the API.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Eddie Horng <eddiehorng.tw@gmail.com>
> ---
>  include/tst_test.h                 |  1 +
>  lib/newlib_tests/.gitignore        |  2 ++
>  lib/newlib_tests/test_exec.c       | 43
>  ++++++++++++++++++++++++++++++++++++++
>  lib/newlib_tests/test_exec_child.c | 27 ++++++++++++++++++++++++
>  lib/tst_test.c                     |  3 ++-
>  5 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 lib/newlib_tests/test_exec.c
>  create mode 100644 lib/newlib_tests/test_exec_child.c
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 90938bc29..420597afa 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -127,6 +127,7 @@ struct tst_test {
>  	int format_device:1;
>  	int mount_device:1;
>  	int needs_rofs:1;
> +	int needs_ipc_path:1;
>  	/*
>  	 * If set the test function will be executed for all available
>  	 * filesystems and the current filesytem type would be set in the
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index 8c0981ec8..99edc6404 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -20,3 +20,5 @@ tst_res_hexd
>  tst_strstatus
>  test17
>  tst_expiration_timer
> +test_exec
> +test_exec_child
> diff --git a/lib/newlib_tests/test_exec.c b/lib/newlib_tests/test_exec.c
> new file mode 100644
> index 000000000..e5b90ffb8
> --- /dev/null
> +++ b/lib/newlib_tests/test_exec.c
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +/*
> + * Assert that tst_res() from child started by exec() is propagated to the
> main
> + * test process.
> + *
> + * This test should be executed as:
> + * $ PATH=$PATH:$PWD ./test_exec
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +	char *const argv[] = {"test_exec_child", NULL};
> +
> +	execvpe(argv[0], argv, environ);
> +
> +	tst_res(TBROK | TERRNO, "EXEC!");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_ipc_path = 1,
> +};
> diff --git a/lib/newlib_tests/test_exec_child.c
> b/lib/newlib_tests/test_exec_child.c
> new file mode 100644
> index 000000000..696ff5be2
> --- /dev/null
> +++ b/lib/newlib_tests/test_exec_child.c
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +
> +int main(void)
> +{
> +	tst_reinit();
> +	tst_res(TPASS, "Child passed!");
> +	return 0;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 008bcefe0..8b577fde8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -105,7 +105,7 @@ static void setup_ipc(void)
>  	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd,
>  	0);
>  
>  	/* Checkpoints needs to be accessible from processes started by exec() */
> -	if (tst_test->needs_checkpoints) {
> +	if (tst_test->needs_checkpoints || tst_test->needs_ipc_path) {
>  		sprintf(ipc_path, IPC_ENV_VAR "=%s", shm_path);
>  		putenv(ipc_path);
>  	} else {
> @@ -152,6 +152,7 @@ void tst_reinit(void)
>  	fd = SAFE_OPEN(path, O_RDWR);
>  
>  	ptr = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	results = ptr;
>  	tst_futexes = (char*)ptr + sizeof(struct results);
>  	tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
>  
> --
> 2.13.6
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
