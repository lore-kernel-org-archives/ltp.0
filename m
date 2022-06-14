Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB9DC43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 10:19:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB2473C94B4
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:19:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5D963C217F
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:19:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D94DE1400184
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:19:18 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 30D8321B1B;
 Tue, 14 Jun 2022 10:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655201958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+k1j2dvFhUCwxv3RrNlDwqiXPnouzeqL/hjLmUVMIvM=;
 b=e4I69sZElfdrcfaymlmuMNX4KnCmC0aVDvntEC55FXEKOd/1lGlKl2+qIiCf9Tsm4uc+Ov
 vg53lhRIDLugDLo1wHY1nm09fDC1+6rmYFxSWazB5zUHMoK8JCpalVtvts+IHX4Wg846zv
 k6bI7ZC7UtmxfnRLu0vblyrF5edf1W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655201958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+k1j2dvFhUCwxv3RrNlDwqiXPnouzeqL/hjLmUVMIvM=;
 b=oXNe6iTu1Lo6Ycy/JXgcKZchbkNOJPwlS8NRmpMf8Z+9bMpi2kGe/psqRXTS7T9ewPnpJW
 fVoku24/FJ4HOSBg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1DA9F2C141;
 Tue, 14 Jun 2022 10:19:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id C76D0A062E; Tue, 14 Jun 2022 12:19:17 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:19:17 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220614101917.mznczi4oi7a2ih42@quack3.lan>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-3-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/5] syscalls/fanotify23: Introduce
 FAN_MARK_EVICTABLE test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 13-06-22 17:38:23, Amir Goldstein wrote:
> Verify that evictable mark does not pin inode to cache and that
> drop_caches evicts inode from cache and removes the evictable mark.
> 
> Verify that evictable mark can be upgraded to non-evictable but not
> downgraded to evictable afterwards.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/syscalls                              |   1 +
>  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify.h |   4 +
>  .../kernel/syscalls/fanotify/fanotify23.c     | 258 ++++++++++++++++++
>  4 files changed, 264 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify23.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 1259e41f1..e9ee6e5ba 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -612,6 +612,7 @@ fanotify19 fanotify19
>  fanotify20 fanotify20
>  fanotify21 fanotify21
>  fanotify22 fanotify22
> +fanotify23 fanotify23
>  
>  ioperm01 ioperm01
>  ioperm02 ioperm02
> diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> index 6d4ab4ca3..a0a7d20d3 100644
> --- a/testcases/kernel/syscalls/fanotify/.gitignore
> +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> @@ -20,4 +20,5 @@
>  /fanotify20
>  /fanotify21
>  /fanotify22
> +/fanotify23
>  /fanotify_child
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index eb690e332..0ad7ef21b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -101,6 +101,10 @@ static inline int safe_fanotify_mark(const char *file, const int lineno,
>  #ifndef FAN_MARK_FILESYSTEM
>  #define FAN_MARK_FILESYSTEM	0x00000100
>  #endif
> +#ifndef FAN_MARK_EVICTABLE
> +#define FAN_MARK_EVICTABLE	0x00000200
> +#endif
> +
>  /* New dirent event masks */
>  #ifndef FAN_ATTRIB
>  #define FAN_ATTRIB		0x00000004
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
> new file mode 100644
> index 000000000..64787d627
> --- /dev/null
> +++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 CTERA Networks.  All Rights Reserved.
> + *
> + * Author: Amir Goldstein <amir73il@gmail.com>
> + */
> +
> +/*\
> + * [Description]
> + * Check evictable fanotify inode marks.
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include "tst_test.h"
> +
> +#ifdef HAVE_SYS_FANOTIFY_H
> +#include "fanotify.h"
> +
> +#define EVENT_MAX 1024
> +/* size of the event structure, not counting name */
> +#define EVENT_SIZE  (sizeof (struct fanotify_event_metadata))
> +/* reasonable guess as to size of 1024 events */
> +#define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
> +
> +#define MOUNT_PATH "fs_mnt"
> +#define TEST_FILE MOUNT_PATH "/testfile"
> +
> +#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
> +#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
> +
> +static int old_cache_pressure;
> +static int fd_notify;
> +
> +static unsigned long long event_set[EVENT_MAX];
> +
> +static char event_buf[EVENT_BUF_LEN];
> +
> +static void fsync_file(const char *path)
> +{
> +	int fd = SAFE_OPEN(path, O_RDONLY);
> +
> +	SAFE_FSYNC(fd);
> +	SAFE_CLOSE(fd);
> +}
> +
> +/* Flush out all pending dirty inodes and destructing marks */
> +static void mount_cycle(void)
> +{
> +	SAFE_UMOUNT(MOUNT_PATH);
> +	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> +}
> +
> +static int verify_mark_removed(const char *path, const char *when)
> +{
> +	int ret;
> +
> +	/*
> +	 * We know that inode with evictable mark was evicted when a
> +	 * bogus call remove ACCESS from event mask returns ENOENT.
> +	 */
> +	errno = 0;
> +	ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE,
> +			    FAN_ACCESS, AT_FDCWD, path);
> +	if (ret == -1 && errno == ENOENT) {
> +		tst_res(TPASS,
> +			"FAN_MARK_REMOVE failed with ENOENT as expected"
> +			" %s", when);
> +		return 1;
> +	} else {
> +		tst_res(TFAIL | TERRNO,
> +			"FAN_MARK_REMOVE did not fail with ENOENT as expected"
> +			" %s", when);
> +		return 0;
> +	}
> +}
> +
> +static void test_fanotify(void)
> +{
> +	int ret, len, test_num = 0;
> +	struct fanotify_event_metadata *event;
> +	int tst_count = 0;
> +
> +	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_REPORT_FID |
> +				       FAN_NONBLOCK, O_RDONLY);
> +
> +	/*
> +	 * Verify that evictable mark can be upgraded to non-evictable
> +	 * and cannot be downgraded to evictable.
> +	 */
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE,
> +			   FAN_ACCESS,
> +			   AT_FDCWD, TEST_FILE);
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
> +			   FAN_ACCESS,
> +			   AT_FDCWD, TEST_FILE);
> +	errno = 0;
> +	ret = fanotify_mark(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE,
> +			    FAN_ACCESS,
> +			    AT_FDCWD, TEST_FILE);
> +	if (ret == -1 && errno == EEXIST) {
> +		tst_res(TPASS,
> +			"FAN_MARK_ADD failed with EEXIST as expected"
> +			" when trying to downgrade to evictable mark");
> +	} else {
> +		tst_res(TFAIL | TERRNO,
> +			"FAN_MARK_ADD did not fail with EEXIST as expected"
> +			" when trying to downgrade to evictable mark");
> +	}
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_REMOVE,
> +			   FAN_ACCESS,
> +			   AT_FDCWD, TEST_FILE);
> +	verify_mark_removed(TEST_FILE, "after empty mask");
> +
> +
> +	/*
> +	 * Watch ATTRIB events on entire mount
> +	 */
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +			   FAN_ATTRIB, AT_FDCWD, MOUNT_PATH);
> +
> +	/*
> +	 * Generate events
> +	 */
> +	SAFE_CHMOD(TEST_FILE, 0600);
> +	event_set[tst_count] = FAN_ATTRIB;
> +	tst_count++;
> +
> +	/* Read events so far */
> +	ret = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
> +	len = ret;
> +
> +	/*
> +	 * Evictable mark on file ignores ATTRIB events
> +	 */
> +	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD | FAN_MARK_EVICTABLE |
> +			   FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
> +			   FAN_ATTRIB, AT_FDCWD, TEST_FILE);
> +
> +	/* ATTRIB event should be ignored */
> +	SAFE_CHMOD(TEST_FILE, 0600);
> +
> +	/*
> +	 * Read events to verify event was ignored
> +	 */
> +	ret = read(fd_notify, event_buf + len, EVENT_BUF_LEN - len);
> +	if (ret < 0 && errno == EAGAIN) {
> +		tst_res(TPASS, "Got no events as expected");
> +	} else {
> +		tst_res(TFAIL, "Got expected events");
> +		len += ret;
> +	}
> +
> +	/*
> +	 * drop_caches should evict inode from cache and remove evictable mark
> +	 */
> +	fsync_file(TEST_FILE);
> +	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
> +
> +	verify_mark_removed(TEST_FILE, "after drop_caches");
> +
> +	SAFE_CHMOD(TEST_FILE, 0600);
> +	event_set[tst_count] = FAN_ATTRIB;
> +	tst_count++;
> +
> +	/* Read events to verify ATTRIB event was properly generated */
> +	ret = SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
> +	len += ret;
> +
> +	/*
> +	 * Check events
> +	 */
> +	event = (struct fanotify_event_metadata *)event_buf;
> +
> +	/* Iterate over and validate events against expected result set */
> +	while (FAN_EVENT_OK(event, len) && test_num < tst_count) {
> +		if (!(event->mask & event_set[test_num])) {
> +			tst_res(TFAIL,
> +				"got event: mask=%llx (expected %llx)",
> +				(unsigned long long)event->mask,
> +				event_set[test_num]);
> +		} else {
> +			tst_res(TPASS,
> +				"got event: mask=%llx",
> +				(unsigned long long)event->mask);
> +		}
> +		/*
> +		 * Close fd and invalidate it so that we don't check it again
> +		 * unnecessarily
> +		 */
> +		if (event->fd >= 0)
> +			SAFE_CLOSE(event->fd);
> +		event->fd = FAN_NOFD;
> +		event->mask &= ~event_set[test_num];
> +		/* No events left in current mask? Go for next event */
> +		if (event->mask == 0) {
> +			event = FAN_EVENT_NEXT(event, len);
> +		}
> +		test_num++;
> +	}
> +
> +	while (FAN_EVENT_OK(event, len)) {
> +		tst_res(TFAIL,
> +			"got unnecessary event: mask=%llx",
> +			(unsigned long long)event->mask);
> +		if (event->fd != FAN_NOFD)
> +			SAFE_CLOSE(event->fd);
> +		event = FAN_EVENT_NEXT(event, len);
> +	}
> +
> +	SAFE_CLOSE(fd_notify);
> +	/* Flush out all pending dirty inodes and destructing marks */
> +	mount_cycle();
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_TOUCH(TEST_FILE, 0666, NULL);
> +
> +	REQUIRE_MARK_TYPE_SUPPORTED_BY_KERNEL(FAN_MARK_EVICTABLE);
> +	REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(FAN_CLASS_NOTIF|FAN_REPORT_FID,
> +						FAN_MARK_FILESYSTEM,
> +						FAN_ATTRIB, ".");
> +
> +	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
> +	/* Set high priority for evicting inodes */
> +	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_notify > 0)
> +		SAFE_CLOSE(fd_notify);
> +
> +	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = test_fanotify,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MOUNT_PATH,
> +	/* Shrinkers on other fs do not work reliably enough to guarantee mark eviction on drop_caches */
> +	.dev_fs_type = "ext2",
> +};
> +
> +#else
> +	TST_TEST_TCONF("system doesn't have required fanotify support");
> +#endif
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
