Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABF5C433EF
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 10:36:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 402D43C0FBC
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 11:36:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59DD3C0FBC
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 11:35:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A208B1A01126
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 11:35:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D32151F380;
 Wed,  9 Mar 2022 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646822153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/MHs/BOfn3v5vYQ4GqIocqoLcvjSrhP/4YLQNTnBpU=;
 b=ZItaNd/CClKSI7oBN6o8rwKYHGqtBSJo/zRIdUNVNWaXAjEbfn22G9H8uabyB1LZaguNHU
 zQfzyPuLovkpVf4ighD1yJi8RgMxd03AYMYiZg8iwPlpL47eUshjnTncRvckZ1VxtAols8
 ag1Xs2iyefWxN0kVU+QIVodhuAJOGBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646822153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B/MHs/BOfn3v5vYQ4GqIocqoLcvjSrhP/4YLQNTnBpU=;
 b=corfp9sR15fyongnodO8Zl/qcVoZWJdjDc8kIPEuZ38eDxfPjbTBNtlQk4rFRKmBAjcd0h
 aFlP/FplTvyjfLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B054113D79;
 Wed,  9 Mar 2022 10:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v90gKgmDKGJiSwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Mar 2022 10:35:53 +0000
Date: Wed, 9 Mar 2022 11:38:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <YiiDlHcCscQqPJBi@yuki>
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
 <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
 <Yhxu8elhUJakYJHH@pevik> <YiAqwHabM9qCUjAU@xzhouw.hosts>
 <YiDdRhIdh12/23HM@pevik>
 <20220308013853.yr5qhlkcdjy3a5d2@xzhouw.hosts.qa.psi.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308013853.yr5qhlkcdjy3a5d2@xzhouw.hosts.qa.psi.rdu2.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] kernel/fs/fsnotify-stress: fsnotify stress test
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This is a stress tests that exercises fanotify and inotify interfaces
> while IO going on. It ignores some failures of syscalls to let the
> stress go on. If the kernel does not panic or hang after a certain
> period of time of testing, test pass.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
> v3:
> 	remove fs_racer.sh part.
> 
>  runtest/fs                                    |   2 +
>  testcases/kernel/fs/fsnotify-stress/Makefile  |  13 +
>  .../fs/fsnotify-stress/fsnotify-stress.c      | 654 ++++++++++++++++++
>  3 files changed, 669 insertions(+)
>  create mode 100644 testcases/kernel/fs/fsnotify-stress/Makefile
>  create mode 100644 testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
> 
> diff --git a/runtest/fs b/runtest/fs
> index 1d753e0dd..beb43aae4 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -87,3 +87,5 @@ binfmt_misc01 binfmt_misc01.sh
>  binfmt_misc02 binfmt_misc02.sh
>  
>  squashfs01 squashfs01
> +
> +fsnotify-stress fsnotify-stress
> diff --git a/testcases/kernel/fs/fsnotify-stress/Makefile b/testcases/kernel/fs/fsnotify-stress/Makefile
> new file mode 100644
> index 000000000..cf4a28e42
> --- /dev/null
> +++ b/testcases/kernel/fs/fsnotify-stress/Makefile
> @@ -0,0 +1,13 @@
> +#
> +#    kernel/fs/fs-notify testcases Makefile.
> +#
> +
> +top_srcdir	?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS	:= fsnotify-stress
> +
> +MAKE_TARGETS	:= fsnotify-stress

I do not think that we have to set these two variables at all, the test
source should be compiled and installed automatically.

> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
> new file mode 100644
> index 000000000..8297cad25
> --- /dev/null
> +++ b/testcases/kernel/fs/fsnotify-stress/fsnotify-stress.c
> @@ -0,0 +1,654 @@
> +// SPDX-License-Identifier: GPL-2.0

The default license for new code should be GPL-2.0-or-later, but if you
think that the code should be strictly GPL-2.0 it's your choice.

> +/*
> + * This is an irregular stress test for Linux kernel fanotify/inotify
> + * interfaces. It calls thoese interfaces with possible best coverage
> + * arguments, in a loop. It ignores some return values in the loop to
> + * let the stress going on. At the same time, it initiates IO traffics
> + * by calling IO syscalls.
> + *
> + * If kernel does no panic or hang after the test, test pass.
> + *
> + * It detected a leak in fsnotify code which was fixed by Amir through
> + * this Linux commit:
> + *     4396a731 fsnotify: fix sb_connectors leak
> + *
> + * Author: Murphy Zhou <jencce.kernel@gmail.com>
> + *
> + */

Please convert this into the docparse format. We do parse special types
of comments during LTP build to render html documentation for the
testsuite. These comments start with:

/*\
 * [Description]
 *

And are formatted in asciidoc.

> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <sys/fanotify.h>
> +#include <sys/inotify.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "../../syscalls/fanotify/fanotify.h"
> +#include "../../syscalls/inotify/inotify.h"
> +
> +static int fd0;
> +static char *str_timeout;
> +static int arg_timeout = 60;
> +
> +#define TESTDIR "testdir"
> +#define TESTFILE "testdir/file"
> +
> +static void cleanup(void)
> +{
> +	if (fd0 > 0) {
> +		SAFE_CLOSE(fd0);
> +		SAFE_UNLINK(TESTFILE);
> +	}
> +	SAFE_RMDIR(TESTDIR);

The files and directories will be removed automatically at the end of
the test, all that has to be done here is to close the file descriptor.

> +}
> +
> +static void setup(void)
> +{
> +	if (tst_parse_int(str_timeout, &arg_timeout, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid timeout '%s'", str_timeout);
> +	SAFE_MKDIR(TESTDIR, 0777);
> +	fd0 = SAFE_OPEN(TESTFILE, O_CREAT|O_RDWR, 0666);
> +}
> +
> +static void fanotify_flushes(char *fn, unsigned int timeout)
> +{
> +	int fd, ret;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	/* Create the file descriptor for accessing the fanotify API */
> +	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +					   O_RDONLY | O_LARGEFILE);
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");

First of all using gettimeofday() for any time measurement is wrong, as
the system wall clock is not monotonic and may jump at any time.

Secondly we do have a system in place to run tests for a certain amount
of time already. All you have to do is:


	while (tst_timeout_remaining() > 10) {
		/* do the work here */
	}

And then set the .timeout in the tst_test structure to a some sane
default value. No need to reinvent the wheel.

> +	/* Loop marking all kinds of events and flush */

This comment comments obvious fact, please do not add comments like
these.

> +	while (1) {
> +		/* As a stress test, we ignore the return values here to
> +		 * proceed with the stress.
> +		 */
> +		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +			  FAN_EVENT_ON_CHILD, -1, fn);
> +
> +		fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
> +						0, -1, fn);
> +
> +		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +			  FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +			  FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +			  FAN_EVENT_ON_CHILD, -1, fn);
> +
> +		fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, fn);
> +
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +
> +	close(fd);
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static void fanotify_inits(char *fn, unsigned int timeout)
> +{
> +	int fd, ret;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	while (1) {
> +		/* As a stress test, we ignore the return values here to
> +		 * proceed with the stress.
> +		 */
> +		fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
> +				FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
> +		fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +				FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +				FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +				FAN_ONDIR | FAN_EVENT_ON_CHILD, -1, fn);
> +		close(fd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static void add_mark(int fd, uint64_t mask, char *path)
> +{
> +	fanotify_mark(fd, FAN_MARK_ADD, mask, -1, path);
> +}
> +
> +static void remove_mark(int fd, uint64_t mask, char *path)
> +{
> +	fanotify_mark(fd, FAN_MARK_REMOVE, mask, -1, path);
> +}
> +
> +static void fanotify_marks(char *fn, unsigned int timeout)
> +{
> +	int fd, ret;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	/* Create the file descriptor for accessing the fanotify API */
> +	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +					   O_RDONLY | O_LARGEFILE);
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +	/* Loop marking all kinds of events */
> +	while (1) {
> +		add_mark(fd, FAN_ACCESS, fn);
> +		remove_mark(fd, FAN_ACCESS, fn);
> +		add_mark(fd, FAN_MODIFY, fn);
> +		remove_mark(fd, FAN_MODIFY, fn);
> +		add_mark(fd, FAN_OPEN_PERM, fn);
> +		remove_mark(fd, FAN_OPEN_PERM, fn);
> +		add_mark(fd, FAN_CLOSE, fn);
> +		remove_mark(fd, FAN_CLOSE, fn);
> +		add_mark(fd, FAN_OPEN, fn);
> +		remove_mark(fd, FAN_OPEN, fn);
> +		add_mark(fd, FAN_ACCESS_PERM, fn);
> +		remove_mark(fd, FAN_ACCESS_PERM, fn);
> +		add_mark(fd, FAN_ONDIR, fn);
> +		remove_mark(fd, FAN_ONDIR, fn);
> +		add_mark(fd, FAN_EVENT_ON_CHILD, fn);
> +		remove_mark(fd, FAN_EVENT_ON_CHILD, fn);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +	close(fd);
> +	exit(EXIT_SUCCESS);
> +}
> +
> +/* Read all available fanotify events from the file descriptor 'fd' */
> +static void fa_handle_events(int fd)
> +{
> +	const struct fanotify_event_metadata *metadata;
> +	struct fanotify_event_metadata buf[200];
> +	ssize_t len;
> +	struct fanotify_response response;
> +
> +	/* Loop while events can be read from fanotify file descriptor */
> +	for (;;) {
> +		/* Read some events */
> +		len = read(fd, (void *) &buf, sizeof(buf));
> +		if (len == -1 && errno != EAGAIN)
> +			tst_brk(TBROK | TERRNO, "fanotify read events failed");
> +		/* Check if end of available data reached */
> +		if (len <= 0)
> +			break;
> +		/* Point to the first event in the buffer */
> +		metadata = buf;
> +		/* Loop over all events in the buffer */
> +		while (FAN_EVENT_OK(metadata, len)) {
> +			if (metadata->vers != FANOTIFY_METADATA_VERSION) {
> +				tst_brk(TBROK | TERRNO,
> +				"Mismatch of fanotify metadata version.\n");
> +			}
> +			/* metadata->fd contains either FAN_NOFD, indicating a
> +			 * queue overflow, or a file descriptor (a nonnegative
> +			 * integer). Here, we simply ignore queue overflow.
> +			 */
> +			if (metadata->fd >= 0) {
> +				/* Handle open permission event */
> +				if (metadata->mask & FAN_OPEN_PERM) {
> +					/* Allow file to be opened */
> +					response.fd = metadata->fd;
> +					response.response = FAN_ALLOW;
> +					write(fd, &response,
> +					    sizeof(struct fanotify_response));
> +				}
> +
> +				/* Handle access permission event */
> +				if (metadata->mask & FAN_ACCESS_PERM) {
> +					/* Allow file to be accessed */
> +					response.fd = metadata->fd;
> +					response.response = FAN_ALLOW;
> +					write(fd, &response,
> +					    sizeof(struct fanotify_response));
> +				}
> +				/* Ignore read/write access events */
> +				/* Close the file descriptor of the event */
> +				close(metadata->fd);
> +			}
> +			/* Advance to next event */
> +			metadata = FAN_EVENT_NEXT(metadata, len);
> +		}
> +	}
> +}
> +
> +/* This is from fanotify(7) man page example */
> +static void fanotify_watch(char *fn, unsigned int timeout)
> +{
> +	int fd, poll_num, ret, ecnt = 0;
> +	nfds_t nfds;
> +	struct pollfd fds[2];
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	/* Create the file descriptor for accessing the fanotify API */
> +	fd = SAFE_FANOTIFY_INIT(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +					   O_RDONLY | O_LARGEFILE);
> +	/* Mark the mount for:
> +	 * - permission events before opening files
> +	 * - notification events after closing a write-enabled file descriptor
> +	 */
> +	SAFE_FANOTIFY_MARK(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +			FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +			FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +			FAN_ONDIR | FAN_EVENT_ON_CHILD, -1, "/");
> +
> +	/* Prepare for polling */
> +	nfds = 1;
> +	/* Fanotify input */
> +	fds[0].fd = fd;
> +	fds[0].events = POLLIN;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	/* This is the loop to wait for incoming events */
> +	while (1) {
> +		poll_num = poll(fds, nfds, timeout/2);
> +		if (poll_num == -1)
> +			tst_brk(TBROK | TERRNO, "fanotify watch poll failed");
> +		if (poll_num > 0) {
> +			if (fds[0].revents & POLLIN) {
> +				/* Fanotify events are available */
> +				fa_handle_events(fd);
> +				ecnt++;
> +			}
> +		}
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +	tst_printf("Got %d fanotify events\n", ecnt);
> +	tst_flush();
> +	exit(EXIT_SUCCESS);
> +}
> +
> +static void freadfiles(char *fn, unsigned int timeout)
> +{
> +	int ret;
> +	char buf[BUFSIZ];
> +	FILE *f;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	memset(buf, 1, BUFSIZ);
> +	while (1) {
> +		f = fopen(fn, "r+");
> +		if (f == NULL) {
> +			ret = gettimeofday(&te, NULL);
> +			if (ret == -1)
> +				tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +			if (te.tv_sec - ts.tv_sec > timeout)
> +				break;
> +			continue;
> +		}
> +		ret = fread(buf, sizeof(char), BUFSIZ, f);
> +		usleep(1);
> +		fclose(f);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +}
> +
> +static void fwritefiles(char *fn, unsigned int timeout)
> +{
> +	int ret;
> +	char buf[BUFSIZ];
> +	FILE *f;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	memset(buf, 1, BUFSIZ);
> +	while (1) {
> +		f = fopen(fn, "w+");
> +		if (f == NULL) {
> +			ret = gettimeofday(&te, NULL);
> +			if (ret == -1)
> +				tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +			if (te.tv_sec - ts.tv_sec > timeout)
> +				break;
> +			continue;
> +		}
> +		fwrite(buf, sizeof(char), BUFSIZ, f);
> +		usleep(1);
> +		fclose(f);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +}
> +
> +static void readfiles(char *fn, unsigned int timeout)
> +{
> +	int fd, ret;
> +	char buf[BUFSIZ];
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	memset(buf, 1, BUFSIZ);
> +	while (1) {
> +		fd = open(fn, O_RDONLY);
> +		if (fd == -1) {
> +			ret = gettimeofday(&te, NULL);
> +			if (ret == -1)
> +				tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +			if (te.tv_sec - ts.tv_sec > timeout)
> +				break;
> +			continue;
> +		}
> +		ret = read(fd, buf, BUFSIZ);
> +		usleep(1);
> +		close(fd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +}
> +
> +static void writefiles(char *fn, unsigned int timeout)
> +{
> +	int ret, fd;
> +	char buf[BUFSIZ];
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	memset(buf, 1, BUFSIZ);
> +	while (1) {
> +		fd = open(fn, O_RDWR);
> +		if (fd == -1) {
> +			ret = gettimeofday(&te, NULL);
> +			if (ret == -1)
> +				tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +			if (te.tv_sec - ts.tv_sec > timeout)
> +				break;
> +			continue;
> +		}
> +		ret = write(fd, buf, BUFSIZ);
> +		usleep(1);
> +		close(fd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +}
> +
> +static void inotify_add_rm(char *fn, unsigned int timeout)
> +{
> +	int notify_fd;
> +	int wd, ret;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	notify_fd = SAFE_MYINOTIFY_INIT1(IN_CLOEXEC);
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	while (1) {
> +		wd = inotify_add_watch(notify_fd, fn,
> +			IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE |
> +			IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE |
> +			IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF |
> +			IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
> +
> +		inotify_rm_watch(notify_fd, wd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +	close(notify_fd);
> +}
> +
> +static void inotify_inits(char *fn, unsigned int timeout)
> +{
> +	int notify_fd, ret;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	while (1) {
> +		notify_fd = inotify_init1(IN_CLOEXEC);
> +		close(notify_fd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +}
> +
> +static void inotify_add_rm_watches(char *fn, unsigned int timeout)
> +{
> +	int ret, fd, wd;
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	fd = SAFE_MYINOTIFY_INIT();
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	while (1) {
> +		wd = inotify_add_watch(fd, fn, IN_MODIFY);
> +		inotify_rm_watch(fd, wd);
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +	close(fd);
> +}
> +
> +static void i_handle_events(int fd)
> +{
> +	char buf[4096]
> +		__attribute__((aligned(__alignof__(struct inotify_event))));
> +	ssize_t len;
> +
> +	/* Loop while events can be read from inotify file descriptor. */
> +	for (;;) {
> +		len = read(fd, buf, sizeof(buf));
> +		if (len == -1 && errno != EAGAIN)
> +			tst_brk(TBROK | TERRNO, "inotify read event failed");
> +		/* If the nonblocking read() found no events to read, then
> +		 * it returns -1 with errno set to EAGAIN. In that case,
> +		 * we exit the loop.
> +		 */
> +		if (len <= 0)
> +			break;
> +	}
> +}
> +
> +static void inotify_watch(char *fn, unsigned int timeout)
> +{
> +	int fd, poll_num, wd, ret, ecnt = 0;
> +	nfds_t nfds;
> +	struct pollfd fds[2];
> +	struct timeval ts;
> +	struct timeval te;
> +
> +	/* Create the file descriptor for accessing the inotify API. */
> +	fd = SAFE_MYINOTIFY_INIT1(IN_NONBLOCK);
> +
> +	/* Mark directories for events
> +	 * - file was opened
> +	 * - file was closed
> +	 */
> +	wd = SAFE_MYINOTIFY_ADD_WATCH(fd, fn, IN_OPEN | IN_CLOSE);
> +
> +	/* Prepare for polling. */
> +	nfds = 2;
> +	fds[0].fd = STDIN_FILENO;       /* Console input */
> +	fds[0].events = POLLIN;
> +	fds[1].fd = fd;                 /* Inotify input */
> +	fds[1].events = POLLIN;
> +
> +	ret = gettimeofday(&ts, NULL);
> +	if (ret == -1)
> +		tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +
> +	/* Wait for events and/or terminal input. */
> +	while (1) {
> +		poll_num = poll(fds, nfds, timeout/2);
> +		if (poll_num == -1)
> +			tst_brk(TBROK | TERRNO, "inotify watch poll failed");
> +		if (poll_num > 0) {
> +			if (fds[1].revents & POLLIN) {
> +				/* Inotify events are available. */
> +				i_handle_events(fd);
> +				ecnt++;
> +			}
> +		}
> +		ret = gettimeofday(&te, NULL);
> +		if (ret == -1)
> +			tst_brk(TBROK | TERRNO, "gettimeofday failed");
> +		if (te.tv_sec - ts.tv_sec > timeout)
> +			break;
> +	}
> +
> +	inotify_rm_watch(fd, wd);
> +	close(fd);
> +	tst_printf("Got %d inotify events\n", ecnt);
> +	tst_flush();
> +	exit(EXIT_SUCCESS);
> +}
> +
> +struct tcase {
> +	char *desc;
> +	void (*func_test)(char *fn, unsigned int timeout);
> +	int ondir;  /* run stress on directory */
> +	int onfile;  /* run stress on file */
> +};
> +static struct tcase tcases[] = {
> +	{"fanotify_flush stress", fanotify_flushes, 1, 1},
> +	{"fanotify_init stress", fanotify_inits, 1, 1},
> +	{"fanotify_mark stress", fanotify_marks, 1, 1},
> +	{"fanotify watching stress", fanotify_watch, 1, 0},
> +	{"fread stress", freadfiles, 0, 1},
> +	{"fwrite stress", fwritefiles, 0, 1},
> +	{"inotify add rm stress", inotify_add_rm, 1, 1},
> +	{"inotify init stress", inotify_inits, 1, 1},
> +	{"inotify add rm watch stress", inotify_add_rm_watches, 1, 1},
> +	{"inotify watching stress", inotify_watch, 1, 0},
> +	{"read stress", readfiles, 0, 1},
> +	{"write stress", writefiles, 0, 1}
> +};
> +
> +static void run(void)
> +{
> +	int tcnt = ARRAY_SIZE(tcases);
> +	int i = 0;
> +	const struct tst_clone_args args = {
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	setup();

The setup and cleanup has to be passed via the tst_test structure and
shouldn't be called from the run() function at all.

> +	tst_printf("Starting %d stresses\n", tcnt);

This should be tst_res(TINFO, ...);

> +	tst_flush();

The SAFE_CLONE() does flush the buffers before it calls the clone()
syscall, there is no need to flush anything in the test itself.

> +	while (i < tcnt) {
> +		if (tcases[i].ondir && !SAFE_CLONE(&args)) {
> +			tst_printf("Starting %s on dir\n", tcases[i].desc);
> +			tst_flush();

Here as well.

> +			tcases[i].func_test(TESTDIR, arg_timeout);
> +			tst_printf("Ending %s on dir\n", tcases[i].desc);
> +			tst_flush();
> +			exit(EXIT_SUCCESS);

Some of the func_test() calls exit(EXIT_SUCCESS) at the end, in these
casese these  messages will not be printed at all.

> +		}
> +		if (tcases[i].onfile && !SAFE_CLONE(&args)) {
> +			tst_printf("Starting %s on file\n", tcases[i].desc);
> +			tst_flush();

Here as well.

> +			tcases[i].func_test(TESTFILE, arg_timeout);
> +			tst_printf("Ending %s on file\n", tcases[i].desc);
> +			tst_flush();
> +			exit(EXIT_SUCCESS);

And here as well.

> +		}
> +		i++;
> +	}
> +	tst_reap_children();
> +	cleanup();
> +	tst_res(TPASS, "No panic or hang, test pass!");
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = 1,
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.needs_cmds = 0,
> +	.needs_cgroup_ver = 0,
> +	.needs_cgroup_ctrls = 0,

Please do not set anything to 0 here, that is the default value for any
uninitialized variables. Unfortunatelly gcc is buggy and prints warnings
for nearly all tst_test initializations in the LTP tree, there is an
upstream gcc bug for that that haven't been worked on for quite some
time now. But that is not a reason to work around compiler bugs here.

> +	.test = run,
> +	.options = (struct tst_option[]) {
> +		{"t:", &str_timeout, "Seconds for tiemout (default 60)"},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "4396a731 "},
> +		{},
> +	},
> +};
> -- 
> 2.27.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
