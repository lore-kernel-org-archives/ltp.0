Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C5C74A5B
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 05:17:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E22F3CC984
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 07:17:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F31643CA2AB
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:17:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 23C40600827
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 07:17:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C49E1FE34;
 Thu, 30 Mar 2023 05:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680153431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEqRybAsmLaLwMfBlx0Qp9QkIPZLX7oC9h5U+6e8F7w=;
 b=RfXaQlc0vMe7lrfbBN2BcY17wZHSG7ZpHc3hqIKJ85nNSXhYSxpRh1v8KXz+/qR/QJgmLD
 Fjt3Y/l+T/Rs78fTTnxDRlNPpn8ZOOGhJmsAJVI/GJFT+QXAfUJnxqzOS+S/xwqlgYSVfy
 wGuPgkhN/oFkKYppJlmVpz3HfAvHh+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680153431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nEqRybAsmLaLwMfBlx0Qp9QkIPZLX7oC9h5U+6e8F7w=;
 b=FYNHFBfdja4ZUGVSCeZ3vymI2MmokTKVFc3CJ4iwhdMrh7c6lXfZ08xHI+8umeullgllew
 +bClC6II31JcFeBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54ABE1348E;
 Thu, 30 Mar 2023 05:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VmulE1cbJWS5PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 30 Mar 2023 05:17:11 +0000
Date: Thu, 30 Mar 2023 07:17:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230330051709.GA937278@pevik>
References: <20230329133828.24835-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230329133828.24835-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] recvmsg01: Refactor using new LTP API
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Thanks for your work. A bit more cleanup will be needed.

> +++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
> @@ -1,51 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> + * Copyright (c) 2001 International Business Machines
There should have been (we've been changing the file after it was created):
 * Copyright (c) Linux Test Project, 2002-2022
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
>   */

> -/*
> - * Test Name: recvmsg01
> +/*\
> + * [Description]
>   *
> - * Test Description:
> - *  Verify that recvmsg() returns the proper errno for various failure cases
> - *
> - * Usage:  <for command-line>
> - *  recvmsg01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> + * Verify that recvmsg() returns the proper errno for various failure cases
>   *
>   * HISTORY
>   *	07/2001 Ported by Wayne Boyer
This line should have been added to the copyright section.
Have look at the output of docparse - run:
cd metadata/ && make
and then see the output of ../docparse/metadata.html#recvmsg01
We certainly don't want this info there.

> - *
> - * RESTRICTIONS:
> - *  None.
> - *
>   */

> +
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <errno.h>
>  #include <fcntl.h>
> -
> +#include <stdlib.h>
>  #include <sys/wait.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> @@ -54,42 +28,38 @@
>  #include <sys/un.h>
>  #include <sys/file.h>

> -#include <netinet/in.h>
> +#include "tst_test.h"
> +#include "tst_net.h"
> +#include "tst_safe_macros.h"

> -#include "test.h"
> -#include "safe_macros.h"

Only these 4 headers are needed:
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include "tst_test.h"

> +#define TM "from recvmsg01 server"
What is TM? Maybe MSG or other less cryptic constant name?

Also, you added struct tcase. Most of the comments are useless, could you please
remove it?

static struct tcase {		/* test case structure */
	int domain;		/* PF_INET, PF_UNIX, ... */
	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
	int proto;		/* protocol number (usually 0 = default) */
Maybe rename this to protocol and that it's obvious without comment?

	struct iovec *iov;
	int iovcnt;
	void *buf;		/* recv data buffer */
Maybe this comment is the only relevant to keep. But name it recv_buf would
describe it without comment.

	int buflen;		/* recv buffer length */
	struct msghdr *msg;
	unsigned int flags;
	struct sockaddr *from;	/* from address */
	int fromlen;		/* from address value/result buffer length */
	int retval;		/* syscall return value */
Maybe just ret?

	int experrno;		/* expected errno */
Maybe exp_errno or just err?

	void (*setup)(int n);
	void (*cleanup)(void);
	char *desc;
} tcases[] = {
/* 1 */
We don't comment the number of the testcase, one can find the problematic
testcase via the description.
	{
	PF_INET, SOCK_STREAM, 0, iov, 1, buf, sizeof(buf), &msgdat, 0,
		    (struct sockaddr *)&from, sizeof(from),
		    -1, EBADF, setup0, cleanup0, "bad file descriptor"}
	,

Also, better we define structures as:

	{
		.domain = PF_INET,
		.type = SOCK_STREAM,
		.iov = iov,
		.iovcnt = 1,
		...
	},
	{
		.iov = iov,
		.iovcnt = 1,
		...
	},
	...

Using struct member name is much readable.
NOTE: you can omit values which are zero.

Also, recvmsg() for "invalid socket buffer" and "invalid cmsg length" (below) passes
(return 0, errno is obviously also 0).
	{
	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
		    &msgdat, 0, (struct sockaddr *)-1, sizeof(from), 0,
		    // TODO: ENOTSOCK, setup1, cleanup1, "invalid socket buffer"}
		    0, setup1, cleanup1, "invalid socket buffer"}
	,
	{
	PF_UNIX, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
		    // TODO: 0, EINVAL, setup3, cleanup2, "invalid cmsg length"}
		    0, 0, setup3, cleanup2, "invalid cmsg length"}
	,

i.e. if instead of
	if (TST_RET != tc->retval || (TST_RET < 0 && TST_ERR != tc->experrno)) {
we evaluate expected errno:
	if (TST_RET != tc->retval || (TST_ERR != tc->experrno)) {

Either they it should be fixed (to really fail) or the testcases should be removed as invalid.

> +static char buf[1024], cbuf[1024];
Maybe replace 1024 with some constant (BUF_SIZE ?)

The code 
static void setup4(int n)
{
	setup2(n);
	controllen = 128 * 1024;
}

> +static int s;				/* socket descriptor */

Please could this be just sock?
static int sock;

Having single letter for variable which requires comment is not a good code.

> +static struct sockaddr_in sin1, from;
> +static struct sockaddr_un sun1;
> +static struct msghdr msgdat;
> +static struct cmsghdr *control;
> +static int controllen;
> +static struct iovec iov[1];
>  static int sfd;			/* shared between do_child and start_server */
>  static int ufd;			/* shared between do_child and start_server */

> +static void setup(void);
> +static void setup0(int);
Could all the specific setup and cleanup be more descriptive instead of using
number? E.g. setup_open instead of setup0 ?

> +static void setup1(int);
> +static void setup2(int);
> +static void setup3(int);
> +static void setup4(int);
> +static void cleanup(void);
> +static void cleanup0(void);
> +static void cleanup1(void);
> +static void cleanup2(void);
> +static void do_child(void);
> +static void sender(int);
I don't like defining stubs in LTP tests (stubs are for headers in libraries),
but understand that struct tcase is usually defined at the beginning, thus it's
necessary to have stubs. But at least the stub for sender() does not have to be
specified, if you move sender() function above do_child() which uses it.

> +static pid_t start_server(struct sockaddr_in *, struct sockaddr_un *);

> +	tc->setup(n);
> +
> +	/* setup common to all tests */
This comment is obvious, please remove it.
> +	iov[0].iov_base = tc->buf;
> +	iov[0].iov_len = tc->buflen;
> +	msgdat.msg_name = tc->from;
> +	msgdat.msg_namelen = tc->fromlen;
> +	msgdat.msg_iov = tc->iov;
> +	msgdat.msg_iovlen = tc->iovcnt;
> +	msgdat.msg_control = control;
> +	msgdat.msg_controllen = controllen;
> +	msgdat.msg_flags = 0;
> +
> +	TEST(recvmsg(s, tc->msg, tc->flags));
> +	if (TST_RET >= 0)
> +		TST_RET = 0;	/* all nonzero equal here */
I'd remove the comment.
Please add space here (readability).
> +	if (TST_RET != tc->retval ||
> +			(TST_RET < 0 &&
> +			 TST_ERR != tc->experrno)) {
> +		tst_res(TFAIL, "%s ; returned"
> +				" %ld (expected %d), errno %d (expected"
> +				" %d)", tc->desc,
> +				TST_RET, tc->retval,
> +				TST_ERR, tc->experrno);
I'd
* use TTERRNO for printing the actual errno (prints also constant name: EINVAL (22))
* have condition 
> +	} else {
> +		tst_res(TPASS, "%s successful",
> +				tc->desc);
> +	}
> +	tc->cleanup();
> +
> +	cleanup();


	TEST(recvmsg(s, tc->msg, tc->flags));
	if (TST_RET >= 0)
		TST_RET = 0;

	if (TST_RET != tc->retval || (TST_RET < 0 && TST_ERR != tc->experrno)) {
		tst_res(TFAIL | TTERRNO,
				"%s: expected return: %d, returned: %ld, expected errno: %d", 
				tc->desc, tc->retval, TST_RET, tc->experrno);
	} else {
		tst_res(TPASS, "%s passed", tc->desc);
	}
	tc->cleanup();

	cleanup();

>  pid_t pid;
>  char tmpsunpath[1024];
These two should be static.
BTW make check-recvmsg01 would tell you it.

...
> -void cleanup(void)
> +static void cleanup(void)
>  {
>  	if (pid > 0) {
>  		(void)kill(pid, SIGKILL);	/* kill server */
>  		wait(NULL);
>  	}
>  	if (tmpsunpath[0] != '\0')
> -		(void)unlink(tmpsunpath);
> -	tst_rmdir();
> -
> +		(void)SAFE_UNLINK(tmpsunpath);
>  }

> -void setup0(void)
> +static void setup0(int n)
>  {
> -	if (tdat[testno].experrno == EBADF)
> +	if (tcases[n].experrno == EBADF)
>  		s = 400;	/* anything not an open file */
> -	else if ((s = open("/dev/null", O_WRONLY)) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
> +	else
> +		s = SAFE_OPEN("/dev/null", O_WRONLY);
>  }

> -void cleanup0(void)
> +static void cleanup0(void)
>  {
>  	s = -1;
>  }

> -void setup1(void)
> +static void setup1(int n)
>  {
>  	fd_set rdfds;
>  	struct timeval timeout;
> -	int n;

> -	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
> -			tdat[testno].proto);
> -	if (tdat[testno].type == SOCK_STREAM) {
> -		if (tdat[testno].domain == PF_INET) {
> -			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1,
> +	s = SAFE_SOCKET(tcases[n].domain, tcases[n].type,
> +			tcases[n].proto);
> +	if (tcases[n].type == SOCK_STREAM) {
> +		if (tcases[n].domain == PF_INET) {
> +			SAFE_CONNECT(s, (struct sockaddr *)&sin1,
>  				     sizeof(sin1));
>  			/* Wait for something to be readable, else we won't detect EFAULT on recv */
>  			FD_ZERO(&rdfds);
> @@ -311,54 +257,45 @@ void setup1(void)
>  			timeout.tv_usec = 0;
>  			n = select(s + 1, &rdfds, 0, 0, &timeout);
>  			if (n != 1 || !FD_ISSET(s, &rdfds))
> -				tst_brkm(TBROK, cleanup,
> -					 "client setup1 failed - no message ready in 2 sec");
> -		} else if (tdat[testno].domain == PF_UNIX) {
> -			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sun1,
> +				tst_brk(TBROK, "client setup1 failed - no message ready in 2 sec");
> +		} else if (tcases[n].domain == PF_UNIX) {
> +			SAFE_CONNECT(s, (struct sockaddr *)&sun1,
>  				     sizeof(sun1));
>  		}
>  	}
>  }

> -void setup2(void)
> +static void setup2(int n)
>  {
> -	setup1();
> -	if (write(s, "R", 1) < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "test setup failed: write:");
> +	setup1(n);
> +	SAFE_SEND(1, s, "R", 1, 0);
>  	control = (struct cmsghdr *)cbuf;
>  	controllen = control->cmsg_len = sizeof(cbuf);
>  }

> -void setup3(void)
> +static void setup3(int n)
>  {
> -	setup2();
> +	setup2(n);
>  	controllen = sizeof(struct cmsghdr) - 1;
>  }

> -void setup4(void)
> +static void setup4(int n)
>  {
> -	setup2();
> +	setup2(n);
>  	controllen = 128 * 1024;
>  }

> -void cleanup1(void)
> +static void cleanup1(void)
>  {
> -	(void)close(s);
> -	close(ufd);
> -	close(sfd);
> +	SAFE_CLOSE(s);
>  	s = -1;
>  }

> -void cleanup2(void)
> +static void cleanup2(void)
>  {
> -	close(ufd);
> -	close(sfd);
> -	(void)close(s);
> +	SAFE_CLOSE(s);
>  	s = -1;

> -	if (passed_fd >= 0)
> -		(void)close(passed_fd);
> -	passed_fd = -1;
>  	control = 0;
>  	controllen = 0;
>  }
> @@ -373,63 +310,37 @@ pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
>  	ssin->sin_addr.s_addr = INADDR_ANY;

>  	/* set up inet socket */
> -	sfd = socket(PF_INET, SOCK_STREAM, 0);
> -	if (sfd < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
> -		return -1;
> -	}
> -	if (bind(sfd, (struct sockaddr *)ssin, sizeof(*ssin)) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
> -		return -1;
> -	}
> -	if (listen(sfd, 10) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
> -		return -1;
> -	}
> -	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)ssin, &slen);
> +	sfd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
> +	SAFE_BIND(sfd, (struct sockaddr *)ssin, sizeof(*ssin));
> +	SAFE_LISTEN(sfd, 10);
> +	SAFE_GETSOCKNAME(sfd, (struct sockaddr *)ssin, &slen);

>  	/* set up UNIX-domain socket */
> -	ufd = socket(PF_UNIX, SOCK_STREAM, 0);
> -	if (ufd < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server UD socket failed");
> -		return -1;
> -	}
> -	if (bind(ufd, (struct sockaddr *)ssun, sizeof(*ssun))) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server UD bind failed");
> -		return -1;
> -	}
> -	if (listen(ufd, 10) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server UD listen failed");
> -		return -1;
> -	}
> +	ufd = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
> +	SAFE_BIND(ufd, (struct sockaddr *)ssun, sizeof(*ssun));
> +	SAFE_LISTEN(ufd, 10);

> -	switch ((pid = FORK_OR_VFORK())) {
> +	switch ((pid = SAFE_FORK())) {
>  	case 0:		/* child */
> -#ifdef UCLINUX
> -		if (self_exec(argv0, "dd", sfd, ufd) < 0)
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "server self_exec failed");
> -#else
>  		do_child();
> -#endif
>  		break;
>  	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
> +		tst_brk(TBROK | TERRNO, "server fork failed");
tst_brk() for failed fork() is done in SAFE_FORK(), it is redundant here.
Therefore there is only parent and child handling, please use if for child with
exit and then parent code:

	pid = SAFE_FORK();
	if (!pid) {
		do_child();
		exit(1);
	}

	SAFE_CLOSE(sfd);
	SAFE_CLOSE(ufd);

	return pid;


>  		/* fall through */
>  	default:		/* parent */
> -		(void)close(sfd);
> -		(void)close(ufd);
> +		SAFE_CLOSE(sfd);
> +		SAFE_CLOSE(ufd);
>  		return pid;
>  	}
>  	exit(1);
>  }

> +static void do_child(void)
>  {
...
>  			fromlen = sizeof(fsun);
> -			newfd = accept(ufd, (struct sockaddr *)&fsun, &fromlen);
> +			newfd = SAFE_ACCEPT(ufd, (struct sockaddr *)&fsun, &fromlen);
>  			if (newfd >= 0) {
>  				FD_SET(newfd, &afds);
>  				nfds = MAX(nfds, newfd + 1);
> @@ -477,21 +388,20 @@ void do_child(void)
>  			if (fd != sfd && fd != ufd && FD_ISSET(fd, &rfds)) {
>  				char rbuf[1024];
Maybe replace 1024 with some constant (BUF_SIZE).

> -				cc = read(fd, rbuf, sizeof(rbuf));
> -				if (cc && rbuf[0] == 'R')
> +				TEST(read(fd, rbuf, sizeof(rbuf)));
> +				if (TST_RET > 0 && rbuf[0] == 'R')
>  					sender(fd);
> -				if (cc == 0 || (cc < 0 && errno != EINTR)) {
> -					(void)close(fd);
> +				if (TST_RET == 0 || (TST_RET < 0 && TST_ERR != EINTR)) {
> +					SAFE_CLOSE(fd);
>  					FD_CLR(fd, &afds);
>  				}
>  			}
> +
>  	}
>  }

...
> +static struct tst_test test = { .test = run,
Please put ".test = run," on the separate line.
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
> +};

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
