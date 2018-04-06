From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 6 Apr 2018 04:47:50 -0400 (EDT)
Subject: [LTP] [RFC PATCH 1/6] exit02: Rewrite to new library
In-Reply-To: <20180405145015.7633-2-chrubis@suse.cz>
References: <20180405145015.7633-1-chrubis@suse.cz>
 <20180405145015.7633-2-chrubis@suse.cz>
Message-ID: <1256448349.11698313.1523004470265.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> We get rid of the ridiculous sleep(2) in the test as a side effect.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

ACK to 3/6 4/6 5/6 patches.

Just a small observation here, subject doesn't have "syscalls/" as
the rest of series.

One more note below.

> ---
>  testcases/kernel/syscalls/exit/exit02.c | 249
>  ++++++++------------------------
>  1 file changed, 60 insertions(+), 189 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/exit/exit02.c
> b/testcases/kernel/syscalls/exit/exit02.c
> index 7858c894d..8143870e8 100644
> --- a/testcases/kernel/syscalls/exit/exit02.c
> +++ b/testcases/kernel/syscalls/exit/exit02.c
> @@ -1,212 +1,83 @@
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
> -
>  /*
> - * NAME
> - * 	exit02.c
> - *
> - * DESCRIPTION
> - *	Check that exit flushes output file buffers and closes files upon
> - *	exitting
> - *
> - * ALGORITHM
> - * 	Fork a process that creates a file and writes a few bytes, and
> - * 	calls exit WITHOUT calling close(). The parent then reads the
> - * 	file.  If everything that was written is present in the file, then
> - *	the test passes.
> - *
> - * USAGE
> - * 	exit02
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS
> - * 	None
> + * Fork a process that creates a file and writes a few bytes, and
> + * calls exit WITHOUT calling close(). The parent then reads the
> + * file.  If everything that was written is present in the file, then
> + * the test passes.
>   */
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <sys/stat.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <fcntl.h>
> -#include <string.h>
> -#include "test.h"
> -
> -void cleanup(void);
> -void setup(void);
> -
> -char *TCID = "exit02";
> -int TST_TOTAL = 1;
> -
> -#define READ  0
> -#define WRITE 1
> -#define MODE 0666
> -
> -char filen[40];
> -
> -int main(int ac, char **av)
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define FNAME "test_file"
> +
> +static void child_write(void)
>  {
> -	int pid, npid, sig, nsig, exno, nexno, status;
> -	int filed;
> -	char wbuf[BUFSIZ], rbuf[BUFSIZ];
> -	int len, rlen;
> -	int rval = 0;
> -	int lc;
> -
> -	/*
> -	 * parse standard options
> -	 */
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup for test */
> -
> -	/*
> -	 * The following loop checks looping state if -i option given
> -	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/*
> -		 * reset tst_count in case we are looping.
> -		 */
> -		tst_count = 0;
> -
> -		strcpy(wbuf, "abcd");
> -		len = strlen(wbuf);
> -
> -		exno = sig = 0;
> -
> -		if ((pid = FORK_OR_VFORK()) == -1)
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
> -
> -		if (pid == 0) {	/* child */
> -			sleep(1);
> -			if ((filed = creat(filen, MODE)) == -1) {
> -				tst_resm(TINFO, "creat error: unable to"
> -					 "open output file");
> -				exit(2);
> -			}
> -			if (write(filed, wbuf, len) != len) {
> -				tst_resm(TINFO, "write error");
> -				exit(2);
> -			}
> -			exit(exno);
> -		} else {	/* parent */
> -			npid = wait(&status);
> -
> -			if (npid != pid) {
> -				tst_resm(TFAIL, "wait error: "
> -					 "unexpected pid returned");
> -				rval = 1;
> -			}
> -
> -			nsig = status % 256;
> -
> -			/*
> -			 * to check if the core dump bit has been
> -			 * set, bit # 7
> -			 */
> -			if (nsig >= 128)
> -				nsig = nsig - 128;
> -
> -			/*
> -			 * nsig is the signal number returned by
> -			 * wait
> -			 */
> -			if (nsig != sig) {
> -				tst_resm(TFAIL, "wait error: unexpected "
> -					 "signal returned %d", nsig);
> -				rval = 1;
> -			}
> -
> -			/*
> -			 * nexno is the exit number returned by wait
> -			 */
> -			nexno = status / 256;
> -			if (nexno != exno) {
> -				tst_resm(TFAIL, "wait error: unexpected exit "
> -					 "number %d", nexno);
> -				rval = 1;
> -			}
> -
> -			sleep(2);	/* let child's exit close opened file */
> -
> -			filed = open(filen, O_RDONLY, READ);
> -			if (filed == -1) {
> -				tst_resm(TFAIL, "open error: "
> -					 "unable to open input file");
> -				rval = 1;
> -			} else {
> -				rlen = read(filed, rbuf, len);
> -				if (len != rlen) {
> -					tst_resm(TFAIL, "exit error: file "
> -						 "buffer was not flushed");
> -					rval = 1;
> -				} else if (strncmp(rbuf, wbuf, len) != 0) {
> -					tst_resm(TFAIL, "exit error: file "
> -						 "buffer was not flushed");
> -					rval = 1;
> -				}
> -			}
> -			close(filed);
> -			unlink(filen);
> -		}
> -		if (!rval) {
> -			tst_resm(TPASS, "exit() test PASSED");
> -		}
> -	}
> -	cleanup();
> -	tst_exit();
> +	int fd;
> +
> +	fd = SAFE_CREAT(FNAME, 0666);
> +	SAFE_WRITE(1, fd, FNAME, sizeof(FNAME));
> +	exit(0);
>  }
>  
> -/*
> - * setup() - perform all ONE TIME setup for this test
> - */
> -void setup(void)
> +static void check_file(void)
>  {
> +	int fd, len;
> +	char buf[256];
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	fd = SAFE_OPEN(FNAME, O_RDONLY);
> +	len = SAFE_READ(0, fd, buf, sizeof(buf));
>  
> -	umask(0);
> +	if (len != sizeof(FNAME)) {
> +		tst_res(TFAIL, "Wrong length %i expected %zu", len, sizeof(buf));
> +		return;
> +	}
>  
> -	TEST_PAUSE;
> +	if (memcmp(buf, FNAME, sizeof(FNAME))) {
> +		tst_res(TFAIL, "Wrong data read back");

We don't close fd here, but things are already going south,
so it's not that big deal.

ACK

Regards,
Jan

> +		return;
> +	}
>  
> -	tst_tmpdir();
> +	SAFE_CLOSE(fd);
>  
> -	sprintf(filen, "tfile_%d", getpid());
> +	tst_res(TPASS, "File written by child read back correctly");
>  }
>  
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at completion or
> - *	       premature exit.
> - */
> -void cleanup(void)
> +static void run(void)
>  {
> +	int pid;
>  
> -	/*
> -	 * Remove tmp dir and all files in it
> -	 */
> -	tst_rmdir();
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		child_write();
>  
> -	/*
> -	 * exit with return code appropriate for results
> -	 */
> +	tst_reap_children();
>  
> +	check_file();
> +
> +	SAFE_UNLINK(FNAME);
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.test_all = run,
> +};
> --
> 2.13.6
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
