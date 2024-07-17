Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF95C3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 12:28:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495803D1ADE
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 14:28:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1BE63D1A69
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 14:28:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C476D20172A
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 14:28:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 233E51FB7C;
 Wed, 17 Jul 2024 12:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721219288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGpYt5E0xxXYO1upp6mwUR1fpBNPweXt6vSDCEwVvYc=;
 b=ScIn0cpVV8MDZ6Ek5ACfJNzwRrJgchVwbzL5dsyq+ABC6fNV0tR7aYpmDBGZ2KfYkiBtWx
 XEi8s2tX99j/RFrI+rM7J7ue20YTBvikEtNscxYeKab5VZBwadr98iljjxyTmoVAW7j99h
 Hyb1l4kyyuy7j+nohZMfq3WDuu8QW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721219288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGpYt5E0xxXYO1upp6mwUR1fpBNPweXt6vSDCEwVvYc=;
 b=Kyr+tA73JHRfQ453PETH2bcyvbP+PtLPIq9RvCP1q4O85xiCbF1Wlc7NQnmHS6yjKEjYkp
 gw6jqQlGZaudgHDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721219288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGpYt5E0xxXYO1upp6mwUR1fpBNPweXt6vSDCEwVvYc=;
 b=ScIn0cpVV8MDZ6Ek5ACfJNzwRrJgchVwbzL5dsyq+ABC6fNV0tR7aYpmDBGZ2KfYkiBtWx
 XEi8s2tX99j/RFrI+rM7J7ue20YTBvikEtNscxYeKab5VZBwadr98iljjxyTmoVAW7j99h
 Hyb1l4kyyuy7j+nohZMfq3WDuu8QW6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721219288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGpYt5E0xxXYO1upp6mwUR1fpBNPweXt6vSDCEwVvYc=;
 b=Kyr+tA73JHRfQ453PETH2bcyvbP+PtLPIq9RvCP1q4O85xiCbF1Wlc7NQnmHS6yjKEjYkp
 gw6jqQlGZaudgHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB5B21368F;
 Wed, 17 Jul 2024 12:28:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id goZ0ONe4l2bkXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 12:28:07 +0000
Date: Wed, 17 Jul 2024 14:30:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Zpe5cWS4Q_1j0C6Z@rei>
References: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
X-Spamd-Result: default: False [0.20 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] connect01: Convert to new API
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
> --- a/testcases/kernel/syscalls/connect/connect01.c
> +++ b/testcases/kernel/syscalls/connect/connect01.c
> @@ -1,308 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2006-2024
>   */
>  
> -/*
> - * Test Name: connect01
> +/*\
> + * [Description]
>   *
> - * Test Description:
> - *  Verify that connect() returns the proper errno for various failure cases
> - *
> - * Usage:  <for command-line>
> - *  connect01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - * RESTRICTIONS:
> - *  None.
> + * Verify that connect() returns the proper errno for various failure case
>   *
>   */
>  
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -
>  #include <sys/types.h>
>  #include <sys/socket.h>
> -#include <sys/signal.h>
> -#include <sys/un.h>
> -
> -#include <netinet/in.h>
> -
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "connect01";
> -int testno;
> -
> -int s, s2;			/* socket descriptor */
> -struct sockaddr_in sin1, sin2, sin3, sin4;
> -static int sfd;			/* shared between start_server and do_child */
> -
> -void setup(void), setup0(void), setup1(void), setup2(void),
> -cleanup(void), cleanup0(void), cleanup1(void), do_child(void);
> -
> -static pid_t start_server(struct sockaddr_in *);
> +#include <sys/wait.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
>  
> -struct test_case_t {		/* test case structure */
> -	int domain;		/* PF_INET, PF_UNIX, ... */
> -	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
> -	int proto;		/* protocol number (usually 0 = default) */
> -	struct sockaddr *sockaddr;	/* socket address buffer */
> -	int salen;		/* connect's 3rd argument */
> -	int retval;		/* syscall return value */
> -	int experrno;		/* expected errno */
> -	void (*setup) (void);
> -	void (*cleanup) (void);
> +static int fd_share;
> +static int fd_server;
> +
> +static struct sockaddr_in sock1;
> +static struct sockaddr_in sock2;
> +static struct sockaddr_in sock3;
> +
> +static pid_t pid;
> +
> +static void setup1(unsigned int);
> +static void setup2(unsigned int);
> +static void setup3(unsigned int);
> +static void cleanup1(void);
> +
> +static struct test_case_t {
> +	int domain;
> +	int type;
> +	int proto;
> +	struct sockaddr *sockaddr;
> +	int salen;
> +	int exp_errno;
> +	void (*setup)(unsigned int i);
> +	void (*cleanup)(void);
>  	char *desc;
> -} tdat[] = {
> -	{
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
> -		    sizeof(struct sockaddr_in), -1, EBADF, setup0,
> -		    cleanup0, "bad file descriptor"},
> -	{
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
> -		    sizeof(struct sockaddr_in), -1, EFAULT, setup1,
> -		    cleanup1, "invalid socket buffer"},
> -	{
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
> -		    3, -1, EINVAL, setup1, cleanup1, "invalid salen"}, {
> -	0, 0, 0, (struct sockaddr *)&sin1,
> -		    sizeof(sin1), -1, ENOTSOCK, setup0, cleanup0,
> -		    "invalid socket"}
> -	, {
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
> -		    sizeof(sin1), -1, EISCONN, setup2, cleanup1,
> -		    "already connected"}
> -	, {
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin2,
> -		    sizeof(sin2), -1, ECONNREFUSED, setup1, cleanup1,
> -		    "connection refused"}
> -	, {
> -	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin4,
> -		    sizeof(sin4), -1, EAFNOSUPPORT, setup1, cleanup1,
> -		    "invalid address family"}
> -,};
> -
> -int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
> -
> -/**
> - * bionic's connect() implementation calls netdClientInitConnect() before
> - * sending the request to the kernel.  We need to bypass this, or the test will
> - * segfault during the addr = (struct sockaddr *)-1 testcase. We had cases where
> - * tests started to segfault on glibc upgrade or in special conditions where
> - * libc had to convert structure layouts between 32bit/64bit userspace/kernel =>
> - * safer to call the raw syscall regardless of the libc implementation.
> - */
> -#include "lapi/syscalls.h"
> +} tcases[] = {
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
> +		sizeof(struct sockaddr_in), EBADF, setup1, cleanup1,
> +		"sockfd is not a valid open file descriptor"},
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
> +		sizeof(struct sockaddr_in), EFAULT, setup2, cleanup1,
> +		"socket structure address is outside the user's address space"},
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
> +		3, EINVAL, setup2, cleanup1,
> +		"addrlen is not valid"},
> +	{0, 0, 0, (struct sockaddr *)&sock1,
> +		sizeof(sock1), ENOTSOCK, setup1, cleanup1,
> +		"file descriptor sockfd does not refer to a socket"},
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
> +		sizeof(sock1), EISCONN, setup3, cleanup1,
> +		"socket is already connected"},
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock2,
> +		sizeof(sock2), ECONNREFUSED, setup2, cleanup1,
> +		"connect on a socket found no one listening on remote address"},
> +	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock3,
> +		sizeof(sock3), EAFNOSUPPORT, setup2, cleanup1,
> +		"address doesn't have the correct address family in sa_family"},
> +};
>  
>  static int sys_connect(int sockfd, const struct sockaddr *addr,
> -		socklen_t addrlen)
> +	socklen_t addrlen)
>  {
>  	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
>  }
>  
> -#define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
> -
> -int main(int argc, char *argv[])
> +static void do_child(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> +	struct sockaddr_in sock;
> +	fd_set fd_set_all;
> +	fd_set fd_set_read;
> +	int nfds;
> +	ssize_t bytes;
> +	int fd;
> +	char data;
> +
> +	FD_ZERO(&fd_set_all);
> +	FD_SET(fd_server, &fd_set_all);
> +	nfds = fd_server + 1;
>  
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); ++lc) {
> -		tst_count = 0;
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> -			tdat[testno].setup();
> +	while (1) {
> +		socklen_t len;
>  
> -			TEST(connect
> -			     (s, tdat[testno].sockaddr, tdat[testno].salen));
> +		memcpy(&fd_set_read, &fd_set_all, sizeof(fd_set_read));
> +		if (select(nfds, &fd_set_read, NULL, NULL, NULL) < 0)
> +			if (errno != EINTR)
> +				exit(1);
> +		if (FD_ISSET(fd_server, &fd_set_read)) {
> +			int newfd;
>  
> -			if (TEST_RETURN != tdat[testno].retval ||
> -			    (TEST_RETURN < 0 &&
> -			     TEST_ERRNO != tdat[testno].experrno)) {
> -				tst_resm(TFAIL, "%s ; returned"
> -					 " %ld (expected %d), errno %d (expected"
> -					 " %d)", tdat[testno].desc,
> -					 TEST_RETURN, tdat[testno].retval,
> -					 TEST_ERRNO, tdat[testno].experrno);
> -			} else {
> -				tst_resm(TPASS, "%s successful",
> -					 tdat[testno].desc);
> +			len = sizeof(sock);
> +			newfd = SAFE_ACCEPT(fd_server, (struct sockaddr *)&sock,
> +				&len);
> +			if (newfd >= 0) {
> +				FD_SET(newfd, &fd_set_all);
> +				nfds = MAX(nfds, newfd + 1);
>  			}
> -			tdat[testno].cleanup();
>  		}
> +		for (fd = 0; fd < nfds; fd++)
> +			if (fd != fd_server && FD_ISSET(fd, &fd_set_read)) {
> +				bytes = read(fd, &data, 1);
> +				if (bytes == 0) {
> +					close(fd);
> +					FD_CLR(fd, &fd_set_all);
> +				}
> +			}
>  	}
> -	cleanup();
> -
> -	tst_exit();

First of all since this is a test that tests invalid connect()
parameters there is no point in having a full blown server that reads
the data from the socket. I guess that this could be simplified just
a loop over SAFE_ACCEPT() that would ingore the file descriptor since we
are not actually writing to the socket anything.

So the whole function could be just:

	while (1)
		SAFE_ACCEPT(fd_server, ...);

Which could be moved into the start_server() function.

>  }
>  
> -pid_t pid;
> -
> -void setup(void)
> +static void start_server(struct sockaddr_in *sock)
>  {
> -	TEST_PAUSE;		/* if -p option specified */
> -
> -	pid = start_server(&sin1);
> +	socklen_t slen = sizeof(*sock);
>  
> -	sin2.sin_family = AF_INET;
> -	/* this port must be unused! */
> -	sin2.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
> -	sin2.sin_addr.s_addr = INADDR_ANY;
> +	sock->sin_family = AF_INET;
> +	sock->sin_port = 0;
> +	sock->sin_addr.s_addr = INADDR_ANY;
>  
> -	sin3.sin_family = AF_INET;
> -	sin3.sin_port = 0;
> -	/* assumes no route to this network! */
> -	sin3.sin_addr.s_addr = htonl(0x0AFFFEFD);
> -
> -	sin4.sin_family = 47;	/* bogus address family */
> -	sin4.sin_port = 0;
> -	sin4.sin_addr.s_addr = htonl(0x0AFFFEFD);
> +	fd_server = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
> +	SAFE_BIND(fd_server, (struct sockaddr *)sock, slen);
> +	SAFE_LISTEN(fd_server, 10);
> +	SAFE_GETSOCKNAME(fd_server, (struct sockaddr *)sock, &slen);
>  
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		do_child();
> +		exit(0);
> +	}
> +	close(fd_server);
>  }
>  
> -void cleanup(void)
> +static void setup(void)
>  {
> -	(void)kill(pid, SIGKILL);
> +	sock2.sin_family = AF_INET;
> +	sock2.sin_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
> +	sock2.sin_addr.s_addr = INADDR_ANY;
>  
> +	sock3.sin_family = 47;
> +	sock3.sin_port = 0;
> +	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
>  }
>  
> -void setup0(void)
> +static void setup1(unsigned int i)
>  {
> -	if (tdat[testno].experrno == EBADF)
> -		s = 400;	/* anything not an open file */
> -	else if ((s = open("/dev/null", O_WRONLY)) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
> +	struct test_case_t *tc = &tcases[i];
>  
> +	if (tc->exp_errno == EBADF)
> +		fd_share = -1;
> +	else
> +		fd_share = SAFE_OPEN("/dev/null", O_WRONLY);
>  }
>  
> -void cleanup0(void)
> +static void setup2(unsigned int i)
>  {
> -	close(s);
> -	s = -1;
> -}
> +	struct test_case_t *tc = &tcases[i];
>  
> -void setup1(void)
> -{
> -	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
> -		        tdat[testno].proto);
> +	fd_share = SAFE_SOCKET(tc->domain, tc->type, tc->proto);
>  }
>  
> -void cleanup1(void)
> +static void setup3(unsigned int i)
>  {
> -	(void)close(s);
> -	s = -1;
> +	setup2(i);
> +	SAFE_CONNECT(fd_server, (const struct sockaddr *)&sock1, sizeof(sock1));

And if we move this SAFE_CONNECT() to the test setup we can start the
server once in the test setup, then SAFE_CONNECT() there and the EISCON
would be set up once for the duration of the test and we would stop the
server once in the test cleanup.


And if we put a pointer to a fd into the test structure we can
initialize all the different setups once in the test setup and get rid
of the setup and cleanup function from the testcase structure as well.
We do the same for the sockaddr and I do not see a reason why we cannot
do so for the file descriptor.

>  }
>  
> -void setup2(void)
> +static void cleanup1(void)
>  {
> -	setup1();		/* get a socket in s */
> -	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
> +	if (fd_share > 0)
> +		SAFE_CLOSE(fd_share);
>  }
>  
> -pid_t start_server(struct sockaddr_in *sin0)
> +static void verify_connect(unsigned int i)
>  {
> -	pid_t pid;
> -	socklen_t slen = sizeof(*sin0);
> -
> -	sin0->sin_family = AF_INET;
> -	sin0->sin_port = 0; /* pick random free port */
> -	sin0->sin_addr.s_addr = INADDR_ANY;
> -
> -	sfd = socket(PF_INET, SOCK_STREAM, 0);
> -	if (sfd < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
> -		return -1;
> -	}
> -	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
> -		return -1;
> -	}
> -	if (listen(sfd, 10) < 0) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
> -		return -1;
> -	}
> -	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
> -
> -	switch ((pid = tst_fork())) {
> -	case 0:		/* child */
> -		do_child();
> -		break;
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
> -		/* fall through */
> -	default:		/* parent */
> -		(void)close(sfd);
> -		return pid;
> -	}
> -
> -	return -1;
> +	struct test_case_t *tc = &tcases[i];
> +
> +	start_server(&sock1);


> +	if (tc->setup)
> +		tc->setup(i);
> +	TST_EXP_FAIL(sys_connect(fd_share, tc->sockaddr, tc->salen),
> +		tc->exp_errno, "%s", tc->desc);
> +	SAFE_KILL(pid, SIGKILL);
> +	SAFE_WAITPID(pid, NULL, 0);
> +	if (tc->cleanup)
> +		tc->cleanup();
>  }
>  
> -void do_child(void)
> -{
> -	struct sockaddr_in fsin;
> -	fd_set afds, rfds;
> -	int nfds, cc, fd;
> -	char c;
> -
> -	FD_ZERO(&afds);
> -	FD_SET(sfd, &afds);
> -
> -	nfds = sfd + 1;
> -
> -	/* accept connections until killed */
> -	while (1) {
> -		socklen_t fromlen;
> -
> -		memcpy(&rfds, &afds, sizeof(rfds));
> -
> -		if (select(nfds, &rfds, NULL, NULL,
> -			   NULL) < 0)
> -			if (errno != EINTR)
> -				exit(1);
> -		if (FD_ISSET(sfd, &rfds)) {
> -			int newfd;
> -
> -			fromlen = sizeof(fsin);
> -			newfd = accept(sfd, (struct sockaddr *)&fsin, &fromlen);
> -			if (newfd >= 0) {
> -				FD_SET(newfd, &afds);
> -				nfds = MAX(nfds, newfd + 1);
> -			}
> -		}
> -		for (fd = 0; fd < nfds; ++fd)
> -			if (fd != sfd && FD_ISSET(fd, &rfds)) {
> -				if ((cc = read(fd, &c, 1)) == 0) {
> -					(void)close(fd);
> -					FD_CLR(fd, &afds);
> -				}
> -			}
> -	}
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_connect,
> +	.forks_child = 1,
> +};
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
