Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B58AC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 10:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6D23C9B8D
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 11:30:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E82D3C9B8C
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:30:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 297DC600C75
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 11:30:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 380101F391;
 Wed,  9 Feb 2022 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644402616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RoIh6g/tHQU/uA5oQopbub4Wshj+TNtAqubYfjFlL4=;
 b=Fb+mjrzSeIVbVNzjF5dYg/54+x0+2m4+i43VMPPwLYWmtX+KUEmF9n6YfAD9cbo0ETI3ge
 SftbYi+mRieDsk+yEgsFIGSWm/YqaQfnMc28gCwpwH6M+mOYq7IKT8dXwDn04vSe0slzSV
 BqQunvenmt/ddGYiViTEnNKBIPuO81w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644402616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RoIh6g/tHQU/uA5oQopbub4Wshj+TNtAqubYfjFlL4=;
 b=GG8xSD2dl3r81VQURBbtqu8hfoly/j3aR98hOij31nmHdsZ2l/zMGpt6rODTRaa8iTksB2
 Nmr+akQv4taVUcDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1562E13D23;
 Wed,  9 Feb 2022 10:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Xl38A7iXA2IEYgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 10:30:16 +0000
Date: Wed, 9 Feb 2022 11:30:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgOXUL6S8yien+Xn@rei>
References: <20220127094925.1619-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220127094925.1619-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite process_vm_readv03.c test with new LTP
 API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Removed pipe and replaced it with shared memory.
> Replaced TST_CHECKPOINT_INIT usage with .needs_checkpoints from the new
> LTP API.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
> In v2 fixed a memory allocation in the child_alloc function.
> 
>  .../kernel/syscalls/cma/process_vm_readv03.c  | 311 ++++++++----------
>  1 file changed, 133 insertions(+), 178 deletions(-)
> 
Hi!
> +/* \
     ^
     This space preents from the comment to be picked up by the
     docparser.
> + * [Description]
>   *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program;  if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Fork two children, one child mallocs randomly sized trunks of memory
> + * and initializes them; the other child calls process_vm_readv with
> + * the remote iovecs initialized to the original process memory
> + * locations and the local iovecs initialized to randomly sized and
> + * allocated local memory locations. The second child then verifies
> + * that the data copied is correct.
>   */
>  
> -#define _GNU_SOURCE
> -#include <sys/types.h>
> -#include <sys/uio.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <limits.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
> -#include <time.h>
> -#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
>  #include <limits.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -char *TCID = "process_vm_readv03";
> -int TST_TOTAL = 1;
> -
> -#define NUM_LOCAL_VECS 4
> -
> -static int nflag, sflag;
> -static char *nr_opt, *sz_opt;
> -static option_t options[] = {
> -	{"n:", &nflag, &nr_opt},
> -	{"s:", &sflag, &sz_opt},
> -	{NULL, NULL, NULL}
> -};
> -
> -static int nr_iovecs;
> -static long bufsz;
> -static int pipe_fd[2];
> -static pid_t pids[2];
> -
> -static void gen_random_arr(int *arr, int arr_sz);
> -static void child_alloc(int *bufsz_arr);
> -static void child_invoke(int *bufsz_arr);
> -static long *fetch_remote_addrs(void);
> -static void setup(void);
> -static void cleanup(void);
> -static void help(void);
> -
> -int main(int argc, char **argv)
> -{
> -	int lc, status;
> -	int *bufsz_arr;
> -
> -	tst_parse_opts(argc, argv, options, &help);
> -
> -	setup();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		SAFE_PIPE(cleanup, pipe_fd);
> -
> -		bufsz_arr = SAFE_MALLOC(cleanup, nr_iovecs * sizeof(int));
> -		gen_random_arr(bufsz_arr, nr_iovecs);
> -
> -		/* the start of child_alloc and child_invoke is already
> -		 * synchronized via pipe */
> -		pids[0] = fork();
> -		switch (pids[0]) {
> -		case -1:
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork #0");
> -		case 0:
> -			child_alloc(bufsz_arr);
> -			exit(0);
> -		}
> -
> -		pids[1] = fork();
> -		switch (pids[1]) {
> -		case -1:
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
> -		case 0:
> -			child_invoke(bufsz_arr);
> -			exit(0);
> -		}
> -
> -		/* wait until child_invoke reads from child_alloc's VM */
> -		SAFE_WAITPID(cleanup, pids[1], &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child 1 returns %d", status);
> -
> -		/* child_alloc is free to exit now */
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> +static uintptr_t *data_ptr;
>  
> -		SAFE_WAITPID(cleanup, pids[0], &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child 0 returns %d", status);
> +static char *str_buffsize;
> +static char *str_nr_iovecs;
>  
> -		free(bufsz_arr);
> -	}
> -
> -	cleanup();
> -	tst_exit();
> -}
> +static int bufsize = 100000;
> +static int nriovecs = 10;
>  
> -static void gen_random_arr(int *arr, int arr_sz)
> +static void create_data_size(int *arr, int arr_sz, int buffsize)
>  {
>  	long bufsz_left, bufsz_single;
>  	int i;
>  
> -	bufsz_left = bufsz;
> +	bufsz_left = buffsize;
>  	for (i = 0; i < arr_sz - 1; i++) {
> -		bufsz_single = rand() % (bufsz_left / 2) + 1;
> +		bufsz_single = rand() % ((bufsz_left / 2) + 1);

It was correct before you added the parenthesis, the + 1 was there to
make sure we do not end up with an empty buffer if rand() returned
multiple of bufsz_left/2.

Also I guess that this only works reasonably only for bufsize >
2^nriovecs otherwise you may end up doing modulo (%) operation by a
zero which is undefined operation, I guess that the process would end up
killed with SIGFPE.

Looking at the code we actually depend on the fact that we have two
iovec sets whose size is the same, and this of course works only if the
buffer size is large enoug. This is actually quite complicated.

I guess that we will have to change the code to make sure that bufz is
not consumed until the very end, so maybe:

	for (i = 0; i < arr_sz - 1; i++) {
		int mod = MAX(1, (bufz_left-arr_sz)/2);
		arr[i] = rand() % mod + 1
		bufz_left -= arr[i];
	}

With that we make sure that bufz_left is large enough as long as the
bufsize >= arr_size (which is something that has to be so anyways).

But thinking of it again, as long as we allow the iovec_len to be 0 your
change is actually correct as malloc(0) returns a valid pointer on Linux
(which is not generally guaranteed). But if we are going to use that
version we should explicitly check the size == 0 when we allocate the
iovec buffers and set the iov_base to NULL and iov_len to 0 in that
case to make it clear that the buffers can have zero size.


>  		arr[i] = bufsz_single;
>  		bufsz_left -= bufsz_single;
>  	}
> +
>  	arr[arr_sz - 1] = bufsz_left;
>  }
>  
> -static void child_alloc(int *bufsz_arr)
> +static void child_alloc(const int *sizes, int nr_iovecs)
>  {
>  	char **foo;
>  	int i, j;
> -	char buf[BUFSIZ];
>  	long count;
>  
> -	foo = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(char *));
> +	foo = SAFE_MALLOC(nr_iovecs * sizeof(char *));
>  
>  	count = 0;
>  	for (i = 0; i < nr_iovecs; i++) {
> -		foo[i] = SAFE_MALLOC(tst_exit, bufsz_arr[i]);
> -		for (j = 0; j < bufsz_arr[i]; j++) {
> +		foo[i] = SAFE_MALLOC(sizes[i]);
> +		for (j = 0; j < sizes[i]; j++) {
>  			foo[i][j] = count % 256;
>  			count++;
>  		}
>  	}
> -	tst_resm(TINFO, "child 0: %d iovecs allocated and initialized.",
> -		 nr_iovecs);
>  
> -	/* passing addr via pipe */
> -	SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -	snprintf(buf, BUFSIZ, "%p", (void *)foo);
> -	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
> -	SAFE_CLOSE(tst_exit, pipe_fd[1]);
> +	*data_ptr = (uintptr_t)foo;
> +
> +	tst_res(TINFO, "child 0: memory allocated and initialized");
>  
> -	/* wait until child_invoke is done reading from our VM */
> -	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> +	/* wake and wait until child_invoke is done reading from our VM */
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  }
>  
> -static long *fetch_remote_addrs(void)
> +static long *fetch_remote_addrs(int nr_iovecs, pid_t pid_alloc)
>  {
> -	long *foo, *bar;
> -	char buf[BUFSIZ];
> +	long *bar;
>  	long len;
>  	struct iovec local, remote;
>  
> -	/* get addr from pipe */
> -	SAFE_CLOSE(tst_exit, pipe_fd[1]);
> -	SAFE_READ(tst_exit, 0, pipe_fd[0], buf, BUFSIZ);
> -	SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -	if (sscanf(buf, "%p", &foo) != 1)
> -		tst_brkm(TBROK | TERRNO, tst_exit, "sscanf");
> -
>  	len = nr_iovecs * sizeof(long);
> -	bar = SAFE_MALLOC(tst_exit, len);
> +	bar = SAFE_MALLOC(len);
>  	local.iov_base = bar;
>  	local.iov_len = len;
> -	remote.iov_base = foo;
> +	remote.iov_base = (void *)*data_ptr;
>  	remote.iov_len = len;
>  
> -	TEST(tst_syscall(__NR_process_vm_readv, pids[0], &local,
> -			 1UL, &remote, 1UL, 0UL));
> -	if (TEST_RETURN != len)
> -		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
> +	TEST(tst_syscall(__NR_process_vm_readv, pid_alloc, &local, 1UL, &remote,
> +					 1UL, 0UL));
> +	if (TST_RET != len)
> +		tst_brk(TBROK, "process_vm_readv");
>  
>  	return local.iov_base;

Given that we do mmap a pointer to begin with I would just map the whole
array of remote addresses instead of reading them like this...

>  }
>  
> -static void child_invoke(int *bufsz_arr)
> +static void child_invoke(const int *sizes, int nr_iovecs, pid_t pid_alloc,
> +						 int buffsize)
>  {
> -	int i, j, count, nr_error;
> +	const int num_local_vecs = 4;

So we have the number of remote iovecs passed in paraemter but the local
one is hardcoded? That does not sound right...

Maybe we should just add an array with several different combinations of
sizes and let the program loop over them with .tcnt.

> +	struct iovec local[num_local_vecs];
> +	struct iovec remote[nr_iovecs];
> +	int i, j;
> +	int count;
> +	int nr_error;
> +	int *local_sizes;
>  	unsigned char expect, actual;
>  	long *addrs;
> -	struct iovec local[NUM_LOCAL_VECS], *remote;
> -	int rcv_arr[NUM_LOCAL_VECS];
>  
> -	addrs = fetch_remote_addrs();
> +	addrs = fetch_remote_addrs(nr_iovecs, pid_alloc);
>  
> -	remote = SAFE_MALLOC(tst_exit, nr_iovecs * sizeof(struct iovec));
>  	for (i = 0; i < nr_iovecs; i++) {
>  		remote[i].iov_base = (void *)addrs[i];
> -		remote[i].iov_len = bufsz_arr[i];
> +		remote[i].iov_len = sizes[i];
>  	}
> -	tst_resm(TINFO, "child 1: %d remote iovecs received.", nr_iovecs);
>  
> -	gen_random_arr(rcv_arr, NUM_LOCAL_VECS);
> -	for (i = 0; i < NUM_LOCAL_VECS; i++) {
> -		local[i].iov_base = SAFE_MALLOC(tst_exit, rcv_arr[i]);
> -		local[i].iov_len = rcv_arr[i];
> +	/* use different buffer sizes for local memory */
> +	local_sizes = SAFE_MALLOC(num_local_vecs * sizeof(int));
> +	create_data_size(local_sizes, num_local_vecs, buffsize);
> +	for (i = 0; i < num_local_vecs; i++) {
> +		local[i].iov_base = SAFE_MALLOC(local_sizes[i]);
> +		local[i].iov_len = local_sizes[i];
>  	}
> -	tst_resm(TINFO, "child 1: %d local iovecs initialized.",
> -		 NUM_LOCAL_VECS);
>  
> -	TEST(tst_syscall(__NR_process_vm_readv, pids[0], local,
> -			    (unsigned long)NUM_LOCAL_VECS, remote,
> -			    (unsigned long)nr_iovecs, 0UL));
> -	if (TEST_RETURN != bufsz)
> -		tst_brkm(TBROK | TTERRNO, tst_exit, "process_vm_readv");
> +	tst_res(TINFO, "child 1: reading string from same memory location");
> +
> +	TEST(tst_syscall(__NR_process_vm_readv, pid_alloc, local, num_local_vecs,
> +					 remote, nr_iovecs, 0UL));
> +
> +	if (TST_RET < 0)
> +		tst_brk(TBROK, "process_vm_readv: %s", tst_strerrno(-TST_RET));
> +
> +	if (TST_RET != buffsize)
> +		tst_brk(TBROK, "process_vm_readv: expected %d bytes but got %ld",
> +				buffsize, TST_RET);
>  
>  	/* verify every byte */
>  	count = 0;
>  	nr_error = 0;
> -	for (i = 0; i < NUM_LOCAL_VECS; i++) {
> +	for (i = 0; i < num_local_vecs; i++) {
>  		for (j = 0; j < (int)local[i].iov_len; j++) {
>  			expect = count % 256;
>  			actual = ((unsigned char *)local[i].iov_base)[j];
> -			if (expect != actual) {
> -#if DEBUG
> -				tst_resm(TFAIL, "child 1: expected %i, got %i "
> -					 "for byte seq %d",
> -					 expect, actual, count);
> -#endif
> +			if (expect != actual)
>  				nr_error++;
> -			}
> +
>  			count++;
>  		}
>  	}
> +
>  	if (nr_error)
> -		tst_brkm(TFAIL, tst_exit, "child 1: %d incorrect bytes "
> -			 "received.", nr_error);
> +		tst_brk(TFAIL, "child 1: %d incorrect bytes received", nr_error);
>  	else
> -		tst_resm(TPASS, "child 1: all bytes are correctly received.");
> +		tst_res(TPASS, "child 1: all bytes are correctly received");
>  }
>  
>  static void setup(void)
>  {
> -	tst_require_root();
> +	int iov_max;
>  
>  	/* Just a sanity check of the existence of syscall */
>  	tst_syscall(__NR_process_vm_readv, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
>  
> -	nr_iovecs = nflag ? SAFE_STRTOL(NULL, nr_opt, 1, IOV_MAX) : 10;
> -	bufsz = sflag ? SAFE_STRTOL(NULL, sz_opt, NUM_LOCAL_VECS, LONG_MAX)
> -	    : 100000;
> +	if (tst_parse_int(str_buffsize, &bufsize, 4, INT_MAX))
> +		tst_brk(TBROK, "Invalid buffer size '%s'", str_buffsize);
>  
> -	tst_tmpdir();
> -	TST_CHECKPOINT_INIT(cleanup);
> -	srand(time(NULL));
> +	iov_max = SAFE_SYSCONF(_SC_IOV_MAX);
> +	if (tst_parse_int(str_nr_iovecs, &nriovecs, 1, iov_max))
> +		tst_brk(TBROK, "Invalid IO vectors '%s'", str_nr_iovecs);
>  
> -	TEST_PAUSE;
> +	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
> +						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
>  
>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +	if (data_ptr)
> +		SAFE_MUNMAP(data_ptr, sizeof(uintptr_t));
>  }
>  
> -static void help(void)
> +static void run(void)
>  {
> -	printf("    -n NUM  Set the number of iovecs to be allocated.\n");
> -	printf("    -s NUM  Set the size of total buffer size.\n");
> +	pid_t pid_alloc;
> +	pid_t pid_invoke;
> +	int status;
> +	int *sizes;
> +
> +	/* create random iovec data size */
> +	sizes = SAFE_MALLOC(nriovecs * sizeof(int));
> +	create_data_size(sizes, nriovecs, bufsize);
> +
> +	pid_alloc = SAFE_FORK();
> +	if (!pid_alloc) {
> +		child_alloc(sizes, nriovecs);
> +		return;
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	pid_invoke = SAFE_FORK();
> +	if (!pid_invoke) {
> +		child_invoke(sizes, nriovecs, pid_alloc, bufsize);
> +		return;
> +	}
> +
> +	/* wait until child_invoke reads from child_alloc's VM */
> +	SAFE_WAITPID(pid_invoke, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "child 1: returns %d", status);
> +
> +	/* child_alloc is free to exit now */
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(pid_alloc, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "child 0: returns %d", status);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +	.options = (struct tst_option[]) {
> +		{"s:", &str_buffsize, "Total buffer size (default 100000)"},
> +		{"n:", &str_nr_iovecs, "Number of iovecs to be allocated (default 10)"},
> +		{},
> +	},
> +};
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
