Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UUXqz-0006Im-Kc
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 07:41:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUXqx-0003NH-KI
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 07:41:29 +0000
Message-ID: <51763A9B.6080501@cn.fujitsu.com>
Date: Tue, 23 Apr 2013 15:39:07 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
In-Reply-To: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] sendmsg testcase for
	ded34e0fe8fe8c2d595bfa30626654e4b87621e0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 04/15/2013 03:58 PM, Jan Stancek wrote:
> reproducer for:
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000250
> 
> fixed in 3.9.0-0.rc5:
>   commit ded34e0fe8fe8c2d595bfa30626654e4b87621e0
>   Author: Paul Moore <pmoore@redhat.com>
>   Date:   Mon Mar 25 03:18:33 2013 +0000
>     unix: fix a race condition in unix_release()
> 
> This reproducer should be able to trigger it easily on 4+ CPU systems
> just within couple of seconds.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                              |    1 +
>  testcases/kernel/syscalls/.gitignore          |    1 +
>  testcases/kernel/syscalls/sendmsg/sendmsg02.c |  230 +++++++++++++++++++++++++
>  3 files changed, 232 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/sendmsg/sendmsg02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index f58b6a1..90b4542 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -908,6 +908,7 @@ sendfile08_64 sendfile08_64
>  
>  
>  sendmsg01 sendmsg01
> +sendmsg02 sendmsg02
>  
>  sendto01 sendto01
>  
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index ce62f3f..3869193 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -721,6 +721,7 @@
>  /sendfile/sendfile08
>  /sendfile/sendfile08_64
>  /sendmsg/sendmsg01
> +/sendmsg/sendmsg02
>  /sendto/sendto01
>  /set_robust_list/set_robust_list01
>  /set_thread_area/set_thread_area01
> diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg02.c b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
> new file mode 100644
> index 0000000..8f38f2c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/sendmsg/sendmsg02.c
> @@ -0,0 +1,230 @@
> +/*
> + * Copyright (C) 2013 Linux Test Project
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + */
> +/*
> + * reproducer for:
> + * BUG: unable to handle kernel NULL ptr deref in selinux_socket_unix_may_send
> + * fixed in 3.9.0-0.rc5:
> + *   commit ded34e0fe8fe8c2d595bfa30626654e4b87621e0
> + *   Author: Paul Moore <pmoore@redhat.com>
> + *   Date:   Mon Mar 25 03:18:33 2013 +0000
> + *     unix: fix a race condition in unix_release()
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/ipc.h>
> +#include <sys/stat.h>
> +#include <sys/sem.h>
> +#include <sys/socket.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +
> +char *TCID = "sendmsg02";
> +
> +static int sem_id;
> +static int tflag;
> +static char *t_opt;
> +static option_t options[] = {
> +	{"s:", &tflag, &t_opt},
> +	{NULL, NULL, NULL}
> +};
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void client(int id, int pipefd[])
> +{
> +	int fd, semval;
> +	char data[] = "123456789";
> +	struct iovec w;
> +	struct sockaddr_un sa;
> +	struct msghdr mh;
> +	struct cmsghdr cmh;
> +
> +	close(pipefd[0]);
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sun_family = AF_UNIX;
> +	snprintf(sa.sun_path, sizeof(sa.sun_path), "socket_test%d", id);
> +
> +	w.iov_base = data;
> +	w.iov_len = 10;
> +
> +	memset(&cmh, 0, sizeof(cmh));
> +	mh.msg_control = &cmh;
> +	mh.msg_controllen = sizeof(cmh);
> +
> +	memset(&mh, 0, sizeof(mh));
> +	mh.msg_name = &sa;
> +	mh.msg_namelen = sizeof(struct sockaddr_un);
> +	mh.msg_iov = &w;
> +	mh.msg_iovlen = 1;
> +
> +	do {
> +		fd = socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC, 0);
> +		write(pipefd[1], &fd, 1);
> +		sendmsg(fd, &mh, MSG_NOSIGNAL);
> +		close(fd);
> +		semval = semctl(sem_id, 0, GETVAL);
> +	} while (semval != 0);
> +	close(pipefd[1]);
> +}
> +
> +static void server(int id, int pipefd[])
> +{
> +	int fd, semval;
> +	struct sockaddr_un sa;
> +
> +	close(pipefd[1]);
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sun_family = AF_UNIX;
> +	snprintf(sa.sun_path, sizeof(sa.sun_path), "socket_test%d", id);
> +
> +	do {
> +		fd = socket(AF_UNIX, SOCK_DGRAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);

Hi Jan,

The two features SOCK_CLOEXEC and SOCK_NONBLOCK were introduced since Linux 2.6.27.
So, this case will meet a compile error for kernel under 2.6.27.

Could you please fix it?

Thanks,
DAN LI

> +		unlink(sa.sun_path);
> +		bind(fd, (struct sockaddr *) &sa, sizeof(struct sockaddr_un));
> +		read(pipefd[0], &fd, 1);
> +		close(fd);
> +		semval = semctl(sem_id, 0, GETVAL);
> +	} while (semval != 0);
> +	close(pipefd[0]);
> +}
> +
> +static void reproduce(int seconds)
> +{
> +	int i, status, pipefd[2];
> +	int child_pairs = sysconf(_SC_NPROCESSORS_ONLN)*4;
> +	int child_count = 0;
> +	int *child_pids;
> +	int child_pid;
> +
> +	child_pids = SAFE_MALLOC(cleanup, sizeof(int) * child_pairs * 2);
> +
> +	if (semctl(sem_id, 0, SETVAL, 1) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "couldn't set semval to 1");
> +
> +	/* fork child for each client/server pair */
> +	for (i = 0; i < child_pairs*2; i++) {
> +		if (i%2 == 0) {
> +			if (pipe(pipefd) < 0) {
> +				tst_resm(TBROK | TERRNO, "pipe failed");
> +				break;
> +			}
> +		}
> +
> +		child_pid = fork();
> +		switch (child_pid) {
> +		case -1:
> +			tst_resm(TBROK | TERRNO, "fork");
> +			break;
> +		case 0:
> +			if (i%2 == 0)
> +				server(i, pipefd);
> +			else
> +				client(i-1, pipefd);
> +			exit(0);
> +		default:
> +			child_pids[child_count++] = child_pid;
> +		};
> +
> +		/* this process can close the pipe now */
> +		if (i%2 == 0) {
> +			close(pipefd[0]);
> +			close(pipefd[1]);
> +		}
> +	}
> +
> +	/* let clients/servers run for a while, then clear semval to signal
> +	 * they should stop running now */
> +	if (child_count == child_pairs*2)
> +		sleep(seconds);
> +
> +	if (semctl(sem_id, 0, SETVAL, 0) == -1) {
> +		/* kill children if setting semval failed */
> +		for (i = 0; i < child_count; i++)
> +			kill(child_pids[i], SIGKILL);
> +		tst_resm(TBROK | TERRNO, "couldn't set semval to 0");
> +	}
> +
> +	for (i = 0; i < child_count; i++) {
> +		if (waitpid(child_pids[i], &status, 0) == -1)
> +			tst_resm(TBROK | TERRNO, "waitpid for %d failed",
> +				child_pids[i]);
> +		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +			tst_resm(TFAIL, "child %d returns %d", i, status);
> +	}
> +	free(child_pids);
> +}
> +
> +static void help(void)
> +{
> +	printf("  -s NUM  Number of seconds to run.\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +	long seconds;
> +
> +	msg = parse_opts(argc, argv, options, &help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +	setup();
> +
> +	seconds = tflag ? SAFE_STRTOL(NULL, t_opt, 1, LONG_MAX) : 15;
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		reproduce(seconds);
> +	tst_resm(TPASS, "finished after %ld seconds", seconds);
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +
> +	sem_id = semget(IPC_PRIVATE, 1, IPC_CREAT | S_IRWXU);
> +	if (sem_id == -1)
> +		tst_brkm(TBROK | TERRNO, NULL, "Couldn't allocate semaphore");
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +	semctl(sem_id, 0, IPC_RMID);
> +	tst_rmdir();
> +}
> 



------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
