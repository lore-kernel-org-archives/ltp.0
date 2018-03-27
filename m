From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Mar 2018 16:47:31 +0200
Subject: [LTP] [PATCH v2] fcntl37: test posix lock across execve
In-Reply-To: <1522157916-20620-1-git-send-email-xzhou@redhat.com>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <1522157916-20620-1-git-send-email-xzhou@redhat.com>
Message-ID: <20180327144731.GC28115@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/fcntl/Makefile b/testcases/kernel/syscalls/fcntl/Makefile
> index ae37214..7a215c8 100644
> --- a/testcases/kernel/syscalls/fcntl/Makefile
> +++ b/testcases/kernel/syscalls/fcntl/Makefile
> @@ -21,11 +21,14 @@ top_srcdir		?= ../../../..
>  fcntl33: LDLIBS+=-lrt
>  fcntl33_64: LDLIBS+=-lrt
>  
> -fcntl34: LDLIBS += -lpthread
> -fcntl34_64: LDLIBS += -lpthread
> +fcntl34: CFLAGS += -pthread
> +fcntl34_64: CFLAGS += -pthread
>  
> -fcntl36: LDLIBS += -lpthread
> -fcntl36_64: LDLIBS += -lpthread
> +fcntl36: CFLAGS += -pthread
> +fcntl36_64: CFLAGS += -pthread
> +
> +fcntl37: CFLAGS += -pthread
> +fcntl37_64: CFLAGS += -pthread

Unrelated changes (i.e. something that does not belong to the test being
added to LTP) must be put into separate patch.

>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../utils/newer_64.mk
> diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
> new file mode 100644
> index 0000000..d847ae3
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
> @@ -0,0 +1,101 @@
> +/*
> + * Copyright (c) 2018 Red Hat Inc. All Rights Reserved.
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
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Author: "Daniel P. Berrang??" <berrange@redhat.com>
> + *
> + * This is testing for
> + *
> + *	"Record locks are not inherited by a child created via fork(2),
> + *	 but are preserved across an execve(2)."
> + *
> + * from fcntl(2) man page.
> + *
> + */
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/wait.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <limits.h>
> +
> +#define TST_NO_DEFAULT_MAIN

Uh, please don't do this.

The main test process has to use the test library default main.

The helper binary, that is executed by execve(), will use this so that
the test library is not initilized twice. And the main test process will
fork before execve() because it has to stay alive. Just like in the test
I've pointed out previously.

Just have a look at the creat07.c and creat07_child.c.

> +#include "lapi/fcntl.h"
> +#include "tst_safe_pthread.h"
> +#include "tst_test.h"
> +
> +static const char fname[] = "tst_lock_execve";
> +
> +static void *thread_fn(void *arg)
> +{
> +	int fd = *(intptr_t *)arg;
                     ^
		This is still passed by a pointer not by value.


> +	tst_res(TINFO, "Thread running. fd %d", fd);
> +	while(1) sleep(1);
> +	return NULL;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd, ret = 0;
> +
> +	if (argc == 2) {
> +		fd = atoi(argv[1]);
> +		struct flock flck = {
> +			.l_type = F_WRLCK,
> +			.l_whence = SEEK_SET,
> +			.l_start = 0,
> +			.l_len = 1,
> +		};
> +		SAFE_FCNTL(fd, F_GETLK, &flck);
> +		if (flck.l_type == F_UNLCK)
> +			tst_res(TFAIL, "Record lock gets lost after execve");
> +		else
> +			tst_res(TPASS, "Record lock survives execve");
> +		SAFE_CLOSE(fd);
> +		SAFE_UNLINK(fname);
> +		exit(0);
> +	}
> +
> +	fd = SAFE_OPEN(fname, O_RDWR|O_CREAT, 0755);
> +	struct flock64 flck = {
> +		.l_type = F_WRLCK,
> +		.l_whence = SEEK_SET,
> +		.l_start  = 0,
> +		.l_len    = 1,
> +	};
> +	SAFE_FCNTL(fd, F_SETLK, &flck);
> +
> +	pthread_t th;
> +	SAFE_PTHREAD_CREATE(&th, NULL, thread_fn, (void *)&fd);
> +	sleep(1);

No sleep(1) in test in order to synchronize threads/processes.

> +	int flags=SAFE_FCNTL(fd, F_GETFD);
> +	flags &= ~FD_CLOEXEC;
> +	SAFE_FCNTL(fd, F_SETFD, flags);
> +
> +	char fdstr[10];
> +	snprintf(fdstr, 10, "%d", fd);
                         ^
			 sizeof(fdstr)
> +	char * const newargv[] = { argv[0], fdstr, NULL };
> +	tst_res(TINFO, "execve %s with %s locked", argv[0], fname);
> +	ret = execve(argv[0], newargv, NULL);
> +	return ret;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz
