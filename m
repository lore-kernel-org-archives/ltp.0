From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 6 Apr 2018 04:48:08 -0400 (EDT)
Subject: [LTP] [RFC PATCH 2/6] syscalls/pipe11: Rewrite to new library.
In-Reply-To: <20180405145015.7633-3-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
 <20180405145015.7633-3-chrubis@suse.cz>
Message-ID: <1005724876.11698321.1523004488768.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> + Check that the buffer read in the child is correct as well
> 
> + We got rid of sleep(5) as a side effect
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/pipe/pipe11.c | 289
>  +++++++++-----------------------
>  1 file changed, 77 insertions(+), 212 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/pipe/pipe11.c
> b/testcases/kernel/syscalls/pipe/pipe11.c
> index e3b274128..6964f164d 100644
> --- a/testcases/kernel/syscalls/pipe/pipe11.c
> +++ b/testcases/kernel/syscalls/pipe/pipe11.c
> @@ -1,246 +1,111 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
> + *    07/2001 Ported by Wayne Boyer
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301
> USA
>   */
>  
>  /*
> - * NAME
> - *	pipe11.c
> - *
> - * DESCRIPTION
> - *	Check if many children can read what is written to a pipe by the
> - *	parent.
> + * Check if many children can read what is written to a pipe by the parent.
>   *
>   * ALGORITHM
> - *	1. Open a pipe and write to it
> - *	2. Fork a large number of children
> - *	3. Have the children read the pipe and check how many characters
> - *	   each got
> - *
> - * USAGE:  <for command-line>
> - *  pipe11 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *             -i n : Execute test n times.
> - *             -I x : Execute test for x seconds.
> - *             -P x : Pause for x seconds between iterations.
> - *             -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	None
> + *   For a different nchilds number:
> + *	1. Open a pipe and write nchilds * (PIPE_BUF/nchilds) bytes into it
> + *	2. Fork nchilds children
> + *	3. Each child reads PIPE_BUF/nchilds characters and checks that the
> + *	   bytes read are correct
>   */
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <limits.h>
> -#include "test.h"
> -
> -char *TCID = "pipe11";
> -int TST_TOTAL = 1;
> -
> -void do_child(void);
> -void do_child_uclinux(void);
> -void setup(void);
> -void cleanup(void);
> -
> -#define	NUMCHILD	50
> -#define	NCPERCHILD	50
> -char rawchars[] =
> -
> "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
> -int kidid;
> -int numchild;			/* no of children to fork */
> -int ncperchild;			/* no of chars child should read */
> -int szcharbuf;			/* size of char buf */
> -int pipewrcnt;			/* chars written to pipe */
> -char *wrbuf, *rdbuf;
> -int fd[2];			/* fds for pipe read/write */
> -
> -ssize_t do_read(int fd, void *buf, size_t count)
> -{
> -	ssize_t n;
> -
> -	do {
> -		n = read(fd, buf, count);
> -	} while (n < 0 && errno == EINTR);
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -	return n;
> -}
> +static int fd[2];
> +static unsigned char buf[PIPE_BUF];
> +static size_t read_per_child;
>  
> -int main(int ac, char **av)
> +void do_child(void)
>  {
> -	int lc;
> -
> -	int i;
> -	int fork_ret, status;
> -	int written;		/* no of chars read and written */
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -#ifdef UCLINUX
> -	maybe_run_child(&do_child_uclinux, "ddddd", &fd[0], &fd[1], &kidid,
> -			&ncperchild, &szcharbuf);
> -#endif
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> +	size_t nread;
> +	unsigned char rbuf[read_per_child];
> +	unsigned int i;
>  
> -		TEST(pipe(fd));
> +	SAFE_CLOSE(fd[1]);
>  
> -		if (TEST_RETURN != 0) {
> -			tst_resm(TFAIL, "pipe creation failed");
> -			continue;
> -		}
> -
> -		written = write(fd[1], wrbuf, szcharbuf);
> -		if (written != szcharbuf) {
> -			tst_brkm(TBROK, cleanup, "write to pipe failed");
> -		}
> -
> -refork:
> -		++kidid;
> -		fork_ret = FORK_OR_VFORK();
> -
> -		if (fork_ret < 0) {
> -			tst_brkm(TBROK, cleanup, "fork() failed");
> -		}
> -
> -		if ((fork_ret != 0) && (fork_ret != -1) && (kidid < numchild)) {
> -			goto refork;
> -		}
> +	nread = SAFE_READ(0, fd[0], rbuf, sizeof(rbuf));
>  
> -		if (fork_ret == 0) {	/* child */
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "ddddd", fd[0], fd[1], kidid,
> -				      ncperchild, szcharbuf) < 0) {
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> -			}
> -#else
> -			do_child();
> -#endif
> -		}
> +	if (nread != read_per_child) {
> +		tst_res(TFAIL, "Invalid read size child %i size %zu",
> +		        getpid(), nread);
> +		return;
> +	}
>  
> -		/* parent */
> -		sleep(5);
> -		tst_resm(TINFO, "There are %d children to wait for", kidid);
> -		for (i = 1; i <= kidid; ++i) {
> -			wait(&status);
> -			if (status == 0) {
> -				tst_resm(TPASS, "child %d exited successfully",
> -					 i);
> -			} else {
> -				tst_resm(TFAIL, "child %d exited with bad "
> -					 "status", i);
> -			}
> +	for (i = 0; i < read_per_child; i++) {
> +		if (rbuf[i] != (i % 256)) {
> +			tst_res(TFAIL,
> +			        "Invalid byte read child %i byte %i have %i expected %i",
> +				getpid(), i, rbuf[i], i % 256);
> +			return;
>  		}
>  	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -/*
> - * do_child()
> - */
> -void do_child(void)
> -{
> -	int nread;
>  
> -	if (close(fd[1])) {
> -		tst_resm(TINFO, "child %d " "could not close pipe", kidid);
> -		exit(0);
> -	}
> -	nread = do_read(fd[0], rdbuf, ncperchild);
> -	if (nread == ncperchild) {
> -		tst_resm(TINFO, "child %d " "got %d chars", kidid, nread);
> -		exit(0);
> -	} else {
> -		tst_resm(TFAIL, "child %d did not receive expected no of "
> -			 "characters, got %d characters", kidid, nread);
> -		exit(1);
> -	}
> +	tst_res(TPASS, "Child %i read pipe buffer correctly", getpid());
>  }
>  
> -/*
> - * do_child_uclinux() - as above, but mallocs rdbuf first
> - */
> -void do_child_uclinux(void)
> -{
> -	if ((rdbuf = malloc(szcharbuf)) == NULL) {
> -		tst_brkm(TBROK, cleanup, "malloc of rdbuf failed");
> -	}
> -
> -	do_child();
> -}
> +static unsigned int childs[] = {
> +	1,
> +	2,
> +	3,
> +	4,
> +	10,
> +	50
> +};
>  
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void run(unsigned int tcase)
>  {
> -	int i;
> -	unsigned int j;
> +	pid_t pid;
> +	unsigned int nchilds = childs[tcase];
> +	read_per_child = PIPE_BUF/nchilds;
> +	unsigned int i, j;
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	tst_res(TINFO, "Reading %zu per each of %u children",
> +	        read_per_child, nchilds);
>  
> -	TEST_PAUSE;
> -
> -	numchild = NUMCHILD;
> -	ncperchild = NCPERCHILD;
> +	for (i = 0; i < nchilds; i++) {
> +		for (j = 0; j < read_per_child; j++) {
> +			buf[i * read_per_child + j] = j % 256;
> +		}
> +	}
>  
> -	kidid = 0;
> +	SAFE_PIPE(fd);
>  
> -	/* allocate read and write buffers */
> -	szcharbuf = numchild * ncperchild;
> +	SAFE_WRITE(1, fd[1], buf, read_per_child * nchilds);
>  
> -	/* make sure pipe write doesn't block */
> -	if (szcharbuf == PIPE_BUF) {
> -		/* adjust number of characters per child */
> -		ncperchild = szcharbuf / numchild;
> -	}
> +	for (i = 0; i < nchilds; i++) {
> +		pid = SAFE_FORK();
>  
> -	if ((wrbuf = malloc(szcharbuf)) == NULL) {
> -		tst_brkm(TBROK, cleanup, "malloc failed");
> -	}
> -
> -	if ((rdbuf = malloc(szcharbuf)) == NULL) {
> -		tst_brkm(TBROK, cleanup, "malloc of rdbuf failed");
> +		if (!pid) {
> +			do_child();
> +			exit(0);
> +		}
>  	}
>  
> -	/* initialize wrbuf */
> -	j = 0;
> -	for (i = 0; i < szcharbuf;) {
> -		wrbuf[i++] = rawchars[j++];
> -		if (j >= sizeof(rawchars))
> -			j = 0;
> -	}
> +	tst_reap_children();

pipe fds are not closed, and this could in theory repeat many times.
Other than that ACK.

Regards,
Jan

>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *	       completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(childs),
> +};
> --
> 2.13.6
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
