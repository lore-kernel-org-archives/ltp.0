Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C5CC433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 12:26:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BCB13C9C34
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:26:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F5EE3C9751
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:26:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A3CE1A011C9
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 13:26:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90E071F391;
 Wed,  9 Feb 2022 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644409564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVPOxWTAAD6pdkcFrt81eGL1z6gmaWsaNvaWyj2T7is=;
 b=xfH8Ac4rFrWSSq22z+XgbQfBZEF7c0rMtHJdNXRvKfLf8UAiHJKkLE/9R/oNWq/oTd3ham
 NLNDj4MQUuoTiSP3C9N12TJYIZyg/fN6YrdKYvjlj9axte05mMD0botiGsHz3PmCmAN5kz
 AVWNVmDU43yLoDBP2XWJIB9Rbh5TKJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644409564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HVPOxWTAAD6pdkcFrt81eGL1z6gmaWsaNvaWyj2T7is=;
 b=0PnOu73CJvbrUO3v5t7BYbmCoBQowMnUPjhfujkd/BtAQ8ypOQNuYHB9HigWtbe69PIWQz
 DLmOW/XBjXakceDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75BCD13D2F;
 Wed,  9 Feb 2022 12:26:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3E4qG9yyA2KMJQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 12:26:04 +0000
Date: Wed, 9 Feb 2022 13:25:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgOy1i3cfrqui7DX@rei>
References: <20220127123651.1850-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220127123651.1850-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Rewrite process_vm_writev02.c using new LTP API
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
> +/* \
     ^
     Here as well.

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
> + * Fork two children, the first one allocates a chunk of memory and the
> + * other one call process_vm_writev to write known data into the first
> + * child. Then first child verifies that the data is as expected.
>   */
>  
> -#define _GNU_SOURCE
> +#include <stdlib.h>
>  #include <sys/types.h>
>  #include <sys/uio.h>
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <limits.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  
> -char *TCID = "process_vm_writev02";
> -int TST_TOTAL = 1;
> -
> -#define PADDING_SIZE 10
> -#define DEFAULT_CHAR 53
> +static uintptr_t *data_ptr;
> +static char *str_buffsize;
> +static int bufsize = 100000;
>  
> -static int sflag;
> -static char *sz_opt;
> -static option_t options[] = {
> -	{"s:", &sflag, &sz_opt},
> -	{NULL, NULL, NULL}
> -};
> +static void child_alloc_and_verify(int buffsize)
> +{
> +	char foo[buffsize];
> +	int i;
> +	int err;
>  
> -static long bufsz;
> -static int pipe_fd[2];
> -static pid_t pids[2];
> +	tst_res(TINFO, "child 0: allocate memory");
>  
> -static void child_init_and_verify(void);
> -static void child_write(void);
> -static void setup(void);
> -static void cleanup(void);
> -static void help(void);
> +	memset(foo, 'a', buffsize);
> +	*data_ptr = (uintptr_t)foo;
>  
> -int main(int argc, char **argv)
> -{
> -	int lc, status;
> -
> -	tst_parse_opts(argc, argv, options, &help);
> -
> -	setup();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		SAFE_PIPE(cleanup, pipe_fd);
> -
> -		/* the start of child_init_and_verify and child_write is
> -		 * already synchronized via pipe */
> -		pids[0] = fork();
> -		switch (pids[0]) {
> -		case -1:
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork #0");
> -		case 0:
> -			child_init_and_verify();
> -			exit(0);
> -		default:
> -			break;
> -		}
> -
> -		pids[1] = fork();
> -		switch (pids[1]) {
> -		case -1:
> -			tst_brkm(TBROK | TERRNO, cleanup, "fork #1");
> -		case 0:
> -			child_write();
> -			exit(0);
> -		}
> -
> -		/* wait until child_write writes into
> -		 * child_init_and_verify's VM */
> -		SAFE_WAITPID(cleanup, pids[1], &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child 1 returns %d", status);
> -
> -		/* signal child_init_and_verify to verify its VM now */
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
> -
> -		SAFE_WAITPID(cleanup, pids[0], &status, 0);
> -		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -			tst_resm(TFAIL, "child 0 returns %d", status);
> -	}
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	err = 0;
> +	for (i = 0; i < buffsize; i++)
> +		if (foo[i] != 'w')
> +			err++;
>  
> -static void child_init_and_verify(void)
> -{
> -	unsigned char *foo;
> -	char buf[bufsz];
> -	long i, nr_err;
> -
> -	foo = SAFE_MALLOC(tst_exit, bufsz);
> -	for (i = 0; i < bufsz; i++)
> -		foo[i] = DEFAULT_CHAR;
> -	tst_resm(TINFO, "child 0: memory allocated.");
> -
> -	/* passing addr of string "foo" via pipe */
> -	SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -	snprintf(buf, bufsz, "%p", foo);
> -	SAFE_WRITE(tst_exit, 1, pipe_fd[1], buf, strlen(buf) + 1);
> -	SAFE_CLOSE(tst_exit, pipe_fd[1]);
> -
> -	/* wait until child_write() is done writing to our VM */
> -	TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> -
> -	nr_err = 0;
> -	for (i = 0; i < bufsz; i++) {
> -		if (foo[i] != i % 256) {
> -#if DEBUG
> -			tst_resm(TFAIL, "child 0: expected %i, got %i for "
> -				 "byte seq %ld", i % 256, foo[i], i);
> -#endif
> -			nr_err++;
> -		}
> -	}
> -	if (nr_err)
> -		tst_brkm(TFAIL, tst_exit, "child 0: got %ld incorrect bytes.",
> -			 nr_err);
> +	if (err)
> +		tst_res(TFAIL, "child 0: found %d differences from expected data", err);
>  	else
> -		tst_resm(TPASS, "child 0: all bytes are expected.");
> +		tst_res(TPASS, "child 0: read back expected data");
>  }
>  
> -static void child_write(void)
> +static void child_write(int buffsize, pid_t pid_alloc)
>  {
> -	unsigned char *lp, *rp;
> -	char buf[bufsz];
> +	char lp[buffsize];
>  	struct iovec local, remote;
> -	long i;
> -
> -	/* get addr from pipe */
> -	SAFE_CLOSE(tst_exit, pipe_fd[1]);
> -	SAFE_READ(tst_exit, 0, pipe_fd[0], buf, bufsz);
> -	SAFE_CLOSE(tst_exit, pipe_fd[0]);
> -	if (sscanf(buf, "%p", &rp) != 1)
> -		tst_brkm(TBROK | TERRNO, tst_exit, "sscanf");
> -
> -	lp = SAFE_MALLOC(tst_exit, bufsz + PADDING_SIZE * 2);
> -
> -	for (i = 0; i < bufsz + PADDING_SIZE * 2; i++)
> -		lp[i] = DEFAULT_CHAR;
> -	for (i = 0; i < bufsz; i++)
> -		lp[i + PADDING_SIZE] = i % 256;
> -
> -	local.iov_base = lp + PADDING_SIZE;
> -	local.iov_len = bufsz;
> -	remote.iov_base = rp;
> -	remote.iov_len = bufsz;
> -
> -	tst_resm(TINFO, "child 2: write to the same memory location.");
> -	TEST(tst_syscall(__NR_process_vm_writev, pids[0], &local,
> -			 1UL, &remote, 1UL, 0UL));
> -	if (TEST_RETURN != bufsz)
> -		tst_brkm(TFAIL | TTERRNO, tst_exit, "process_vm_readv");
> +
> +	tst_res(TINFO, "child 1: write to the same memory location");
> +
> +	memset(lp, 'w', buffsize);
> +
> +	local.iov_base = lp;
> +	local.iov_len = buffsize;
> +	remote.iov_base = (void *)*data_ptr;
> +	remote.iov_len = buffsize;
> +
> +	TEST(tst_syscall(__NR_process_vm_writev, pid_alloc, &local, 1UL, &remote,
> +					 1UL, 0UL));
> +
> +	if (TST_RET < 0)
> +		tst_brk(TBROK, "process_vm_writev: %s", tst_strerrno(-TST_RET));

The tst_syscall() calls libc syscall() which does it's magic and stores
the error into the errno. So this should really just juse TBROK |
TTERRNO flags instead of the tst_strerrno() with invalid value.

Also this could be converted into TST_EXP_POSSITIVE_SILENT() call
followed by a check if the TST_RET mathces bufsize and doing pass/fail
based on that.

> +	if (TST_RET != buffsize)
> +		tst_brk(TBROK, "process_vm_writev: expected %d bytes but got %ld",
> +				buffsize, TST_RET);
>  }
>  
>  static void setup(void)
>  {
> -	tst_require_root();
> -
>  	/* Just a sanity check of the existence of syscall */
>  	tst_syscall(__NR_process_vm_writev, getpid(), NULL, 0UL, NULL, 0UL, 0UL);
>  
> -	bufsz =
> -	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
> -	    : 100000;
> +	if (tst_parse_int(str_buffsize, &bufsize, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid buffer size '%s'", str_buffsize);
>  
> -	tst_tmpdir();
> -	TST_CHECKPOINT_INIT(cleanup);
> -
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
> -	printf("    -s NUM  Set the size of total buffer size.\n");
> +	pid_t pid_alloc;
> +	pid_t pid_write;
> +	int status;
> +
> +	pid_alloc = SAFE_FORK();
> +	if (!pid_alloc) {
> +		child_alloc_and_verify(bufsize);
> +		return;
> +	}
> +
> +	/* wait until child_alloc_and_verify has allocated VM */

I do not think that these comments add too much value, I would have just
removed them. It's pretty clear which chekpoint we are waiting for here.

> +	TST_CHECKPOINT_WAIT(0);
> +
> +	pid_write = SAFE_FORK();
> +	if (!pid_write) {
> +		child_write(bufsize, pid_alloc);
> +		return;
> +	}
> +
> +	/* wait until pid_write reads from child_alloc_and_verify's VM */

And for which children we are waiting here.

> +	SAFE_WAITPID(pid_write, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "child 1: returns %d", status);

Can we use the tst_strstatus() here instead of the raw number here? And
also this is more likely TBROK instead of TFAIL if the process segfaults
of something. So maybe:

		tst_res(TBROK, "child write: %s", tst_strstatus(status));

> +	/* child_alloc_and_verify is free to exit now */

And here.

> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(pid_alloc, &status, 0);
> +	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> +		tst_res(TFAIL, "child 0: returns %d", status);

We don't have to wait for the second child, the library will coolect it
just fine.

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
