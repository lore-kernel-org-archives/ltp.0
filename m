Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uob6d-00085y-NC
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 15:12:31 +0000
Date: Mon, 17 Jun 2013 17:13:59 +0200
From: chrubis@suse.cz
Message-ID: <20130617151358.GA2053@rei>
References: <7258543eb9e994c30bac3c3b9547178c1a1f88f7.1370958327.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7258543eb9e994c30bac3c3b9547178c1a1f88f7.1370958327.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] new testcase: kmsg01
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

Hi!
> diff --git a/runtest/logging b/runtest/logging
> new file mode 100644
> index 0000000..47a667e
> --- /dev/null
> +++ b/runtest/logging
> @@ -0,0 +1 @@
> +kmsg01 kmsg01

I don't think that adding a bunch of new runtest files with one entry is
good way to go. What about adding a kernel runtest file (kernel_misc or
so) and put all the kernel tests that does not match more general group
there?

> --- /dev/null
> +++ b/testcases/kernel/logging/kmsg/kmsg01.c
> @@ -0,0 +1,513 @@
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
> + * Test /dev/kmsg based on kernel doc: Documentation/ABI/testing/dev-kmsg
> + * - read() blocks
> + * - non-blocking read() fails with EAGAIN
> + * - partial read fails (buffer smaller than message)
> + * - can write to /dev/kmsg and message seqno grows
> + * - first read() after open() returns same message
> + * - if messages get overwritten, read() returns -EPIPE
> + * - device supports SEEK_SET, SEEK_END, SEEK_DATA
> + */
> +#define _GNU_SOURCE
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/syscall.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +#include "safe_macros.h"
> +#include "linux_syscall_numbers.h"
> +
> +#define MSG_PREFIX "LTP KMSG "

Perhaps we should include exact test name in the prefix so it's clear
which test created them.

Something as "LTP kmsg01 "

> +#define MAX_MSGSIZE 4096
> +#define NUM_READ_MSGS 3
> +#define NUM_OVERWRITE_MSGS 1024
> +#define READ_TIMEOUT 5
> +
> +char *TCID = "kmsg01";
> +static void setup(void);
> +static void cleanup(void);
> +
> +/*
> + * inject_msg - write message to /dev/kmsg
> + * @msg: null-terminated message to inject, should end with \n
> + *
> + * RETURNS:
> + *   0 on success
> + *  -1 on failure, errno reflects write() errno
> + */
> +static int inject_msg(const char *msg)
> +{
> +	int f;
> +	f = open("/dev/kmsg", O_RDWR);
> +	if (f < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "failed to open /dev/kmsg");
> +	TEST(write(f, msg, strlen(msg)));
> +	close(f);

SAFE_CLOSE() ?

> +	errno = TEST_ERRNO;
> +	return TEST_RETURN;
> +}
> +
> +/*
> + * find_msg - find message in kernel ring buffer
> + * @fd:           fd to use, if < 0 function opens /dev/kmsg itself
> + * @text_to_find: substring to look for in messages
> + * @buf:          buf to store found message
> + * @bufsize:      size of 'buf'
> + * @first:        1 - return first matching message
> + *                0 - return last matching message
> + * RETURNS:
> + *   0 on success
> + *  -1 on failure
> + */
> +static int find_msg(int fd, const char *text_to_find, char *buf, int bufsize,
> +	int first)
> +{
> +	int f, msg_found = 0;
> +	char *msg;
> +
> +	msg = SAFE_MALLOC(cleanup, bufsize);

Is the bufsize expected to be too large to be declared on stack as
msg[bufsize] ?

> +	if (fd < 0) {
> +		f = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> +		if (f < 0)
> +			tst_brkm(TBROK, cleanup, "failed to open /dev/kmsg");
> +	} else {
> +		f = fd;
> +	}
> +
> +	while (1) {
> +		TEST(read(f, msg, bufsize));
> +		if (TEST_RETURN < 0) {
> +			if (TEST_ERRNO == EAGAIN)
> +				/* there are no more messages */
> +				break;
> +			else
> +				tst_brkm(TBROK|TTERRNO, cleanup,
> +					"failed to read /dev/kmsg");
> +		} else if (TEST_RETURN < bufsize) {
> +			/* lines from kmsg are not NULL terminated */
> +			msg[TEST_RETURN] = '\0';
> +			if (strstr(msg, text_to_find) != NULL) {
> +				memcpy(buf, msg, TEST_RETURN+1);
> +				msg_found = 1;
> +				if (first)
> +					break;
> +			}
> +		}
> +	};
> +	free(msg);
> +	if (fd < 0)
> +		close(f);
> +
> +	if (msg_found)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +static int get_msg_fields(const char *msg, unsigned long *prio,
> +	unsigned long *seqno)
> +{
> +	unsigned long s, p;
> +	if (sscanf(msg, "%lu,%lu,", &p, &s) == 2) {
> +		if (prio)
> +			*prio = p;
> +		if (seqno)
> +			*seqno = s;
> +		return 0;
> +	} else {
> +		return 1;
> +	}
> +}
> +
> +/*
> + * timed_read - if possible reads from fd or times out
> + * @fd:           fd to read from
> + * @timeout_sec:  timeout in seconds
> + *
> + * RETURNS:
> + *   read bytes on successful read
> + *  -1 on read() error, errno reflects read() errno
> + *  -2 on timeout
> + */
> +static int timed_read(int fd, int timeout_sec)
> +{
> +	int ret, tmp;
> +	struct timeval timeout;
> +	fd_set read_fds;
> +
> +	FD_ZERO(&read_fds);
> +	FD_SET(fd, &read_fds);
> +	timeout.tv_sec = timeout_sec;
> +	timeout.tv_usec = 0;
> +
> +	ret = select(fd + 1, &read_fds, 0, 0, &timeout);
> +	switch (ret) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "select failed");
> +	case 0:
> +		/* select timed out */
> +		return -2;
> +	}
> +
> +	ret = read(fd, &tmp, 1);
> +	return ret;

return read(fd, &tmp, 1) ? :)

> +}
> +
> +/*
> + * timed_read_file - reads file until it reaches end of file,
> + *                   read fails or times out.
> + * @fd:           fd to read from
> + * @timeout_sec:  timeout in seconds for every read attempt
> + *
> + * RETURNS:
> + *     0 on read reaching eof
> + *    -1 on read error, errno reflects read() errno
> + *    -2 on timeout
> + */
> +static int timed_read_file(int fd, int timeout_sec)
> +{
> +	int child, status;
> +	int pipefd[2];
> +	char msg[MAX_MSGSIZE];
> +
> +	if (pipe(pipefd) != 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "pipe failed");
> +
> +	child = fork();
> +	switch (child) {
> +	case -1:
> +		tst_brkm(TBROK|TERRNO, cleanup, "failed to fork");
> +	case 0:
> +		/* child does all the reading and keeps writing to
> +		 * pipe to let parent know that it didn't block */
> +		close(pipefd[0]);
> +		do {
> +			write(pipefd[1], "", 1);
> +			TEST(read(fd, msg, MAX_MSGSIZE));
> +		} while (TEST_RETURN > 0);
> +
> +		close(pipefd[1]);
> +		if (TEST_RETURN == -1)
> +			exit(TEST_ERRNO);
> +		exit(0);
> +	}
> +	close(pipefd[1]);
> +
> +	/* parent reads pipe until it reaches eof or until read times out */
> +	do {
> +		TEST(timed_read(pipefd[0], timeout_sec));
> +	} while (TEST_RETURN > 0);
> +	close(pipefd[0]);
> +
> +	if (TEST_RETURN == -2)
> +		/* child is blocked, kill it */
> +		kill(child, SIGTERM);

I would put the comment above the if, so that the one line block
underneath has really one line.

> +	if (waitpid(child, &status, 0) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
> +	if (WIFEXITED(status)) {
> +		if (WEXITSTATUS(status) == 0) {
> +			return 0;
> +		} else {
> +			errno = WEXITSTATUS(status);
> +			return -1;
> +		}
> +	}
> +	return -2;
> +}

...

> +static void test_read_returns_first_message(void)
> +{
> +	char msg[NUM_READ_MSGS][MAX_MSGSIZE];
> +	int msgs_match = 1;
> +	int i;
> +
> +	tst_resm(TINFO, "TEST: mult. readers will get same first message");
> +	for (i = 0; i < NUM_READ_MSGS; i++) {
> +		if (find_msg(-1, "", msg[i], MAX_MSGSIZE, 1) != 0)
> +			tst_resm(TFAIL, "failed to find any message");
> +	}
> +
> +	for (i = 0; i < NUM_READ_MSGS-1; i++)
> +		if (strlen(msg[i]) > 0 && strcmp(msg[i], msg[i+1]) != 0)
> +			msgs_match = 0;
> +	if (msgs_match)
> +		tst_resm(TPASS, "all readers got same message on first read");
> +	else
> +		tst_resm(TFAIL, "readers got different messages");

Is here a chance that the log would be overwritten by a kernel writing
urelated message? We do fill the log with a bunch of messages (126)
before this test, how much of the kernel log is filled by this? Looking
in the kernel .config I have LOG_BUF_SHIFT=18 which is 256KB which
should be large enough, but it could be set as low as 12 which is 4KB.

> +}
> +
> +static void test_messages_overwritten(void)
> +{
> +	int i, fd;
> +	char msg[MAX_MSGSIZE];
> +	unsigned long first_seqno, seqno;
> +	char filler_str[] = MSG_PREFIX"FILLER MESSAGE TO OVERWRITE OTHERS\n";
> +
> +	tst_resm(TINFO, "TEST: read returns EPIPE when messages get "
> +		"overwritten");
> +
> +	fd = open("/dev/kmsg", O_RDWR);
> +	if (fd < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
> +
> +	if (find_msg(-1, "", msg, MAX_MSGSIZE, 1) == 0
> +		&& get_msg_fields(msg, NULL, &first_seqno) == 0) {
> +		tst_resm(TINFO, "first seqno: %lu", first_seqno);
> +	} else {
> +		tst_brkm(TBROK, cleanup, "failed to get first seq. number");
> +	}
> +
> +	while (1) {
> +		if (find_msg(-1, "", msg, MAX_MSGSIZE, 1) != 0
> +				|| get_msg_fields(msg, NULL, &seqno) != 0) {
> +			tst_resm(TFAIL, "failed to get first seq. number");
> +			break;
> +		}
> +		if (first_seqno != seqno) {
> +			/* first message was overwritten */
> +			tst_resm(TINFO, "first seqno now: %lu", seqno);
> +			break;
> +		}
> +		for (i = 0; i < NUM_OVERWRITE_MSGS; i++) {
> +			if (inject_msg(filler_str) == -1)
> +				tst_brkm(TBROK|TERRNO, cleanup,
> +					"failed write to /dev/kmsg");
> +		}
> +	}
> +
> +	TEST(read(fd, msg, sizeof(msg)));
> +	if (TEST_RETURN == -1 && TEST_ERRNO == EPIPE)
> +		tst_resm(TPASS, "read failed with EPIPE as expected");
> +	else
> +		tst_resm(TFAIL|TTERRNO, "read returned: %ld", TEST_RETURN);
> +	close(fd);
> +}
> +
> +static void test_seek(void)
> +{
> +	int fd;
> +	char msg[MAX_MSGSIZE], msg2[MAX_MSGSIZE];
> +
> +	tst_resm(TINFO, "TEST: seek");
> +	fd = open("/dev/kmsg", O_RDWR | O_NONBLOCK);
> +	if (fd < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "failed to open /dev/kmsg");
> +
> +	/* read() after SEEK_SET 0 returns same (first) message */
> +	TEST(read(fd, msg, sizeof(msg)));
> +	if (TEST_RETURN == -1)
> +		tst_brkm(TBROK|TTERRNO, cleanup, "failed to read /dev/kmsg");
> +	msg[TEST_RETURN] = '\0';
> +
> +	if (lseek(fd, 0, SEEK_SET) == -1)
> +		tst_resm(TFAIL|TERRNO, "SEEK_SET 0 failed");
> +
> +	TEST(read(fd, msg2, sizeof(msg2)));
> +	if (TEST_RETURN == -1)
> +		tst_brkm(TBROK|TTERRNO, cleanup, "failed to read /dev/kmsg");
> +	msg2[TEST_RETURN] = '\0';
> +
> +	if (strcmp(msg, msg2) != 0)
> +		tst_resm(TFAIL, "SEEK_SET 0\nmsg1: %s\n, msg2: %s", msg, msg2);
> +	else
> +		tst_resm(TPASS, "SEEK_SET 0");
> +
> +	/* messages after SEEK_END 0 shouldn't contain MSG_PREFIX */
> +	if (lseek(fd, 0, SEEK_END) == -1)
> +		tst_resm(TFAIL|TERRNO, "lseek SEEK_END 0 failed");
> +	if (find_msg(fd, MSG_PREFIX, msg, sizeof(msg), 0) != 0)
> +		tst_resm(TPASS, "SEEK_END 0");
> +	else
> +		tst_resm(TFAIL, "SEEK_END 0 found: %s", msg);
> +
> +#ifdef SEEK_DATA
> +	/* messages after SEEK_DATA 0 shouldn't contain MSG_PREFIX */
> +	if (__NR_syslog != __LTP__NR_INVALID_SYSCALL) {

What about we add ltp_syscall_defined() or similar so that we don't have
to use the double underscore internal indentificator in test code?

Or use the ltp_syscall() that does that automatically and exits the test
with TCONF if not available.

> +		/* clear ring buffer */
> +		if (syscall(__NR_syslog, 5, NULL, 0) == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "syslog clear failed");
> +		if (lseek(fd, 0, SEEK_DATA) == -1)
> +			tst_resm(TFAIL|TERRNO, "lseek SEEK_DATA 0 failed");
> +		if (find_msg(fd, MSG_PREFIX, msg, sizeof(msg), 0) != 0)
> +			tst_resm(TPASS, "SEEK_DATA 0");
> +		else
> +			tst_resm(TFAIL, "SEEK_DATA 0 found: %s", msg);
> +	}
> +#endif
> +	close(fd);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/* run test_inject first so log isn't empty for other tests */
> +		test_inject();
> +		test_read_nonblock();
> +		test_read_block();
> +		test_partial_read();
> +		test_read_returns_first_message();
> +		test_messages_overwritten();
> +		test_seek();
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	if (tst_kvercmp(3, 5, 0) < 0)
> +		tst_brkm(TCONF, NULL, "This test requires kernel"
> +			" >= 3.5.0");
> +	srand(getpid());
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
