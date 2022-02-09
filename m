Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F81C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:02:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C57AD3C9C40
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 14:02:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76523C23B0
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:02:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E2D111A00A3D
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:02:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3FF51F383;
 Wed,  9 Feb 2022 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644411729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8y7v6iWUtlm9H4XWj9rTdT7T4QoYDauOSmdxbAVzxe4=;
 b=CZ53dwNlfgpOyP6uySTOQLBQLTKJhKcriZNR4hCyFoGd1JqLayFwAHDlMcIdWSY9mMCn08
 R+Tci/6K8rzjQAWQP4HQcFkZa+KsRgeM+FDCGL3Py0Zdf49RFUbDrdCj7FlViDdkMLs55G
 uPafbEgJAo8HgiYsC2I4BqahtojZguk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644411729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8y7v6iWUtlm9H4XWj9rTdT7T4QoYDauOSmdxbAVzxe4=;
 b=6ypSZFRlsGt8tQ+ISt1Pl0ESHTQQ7wLI2rmvJ5G+aNURbohPAND0HmRB65LeNEokPhuMVn
 A206XoOdatKHNyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C325B13D2F;
 Wed,  9 Feb 2022 13:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QjMYLlG7A2L/OQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 13:02:09 +0000
Date: Wed, 9 Feb 2022 14:02:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YgO7S13yB8XVqTIr@rei>
References: <20220127154317.2238-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220127154317.2238-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactoring mmap16.c test using new LTP API
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
> Removed TST_CHECKPOINT_INIT and replaced it with the .needs_checkpoints
> LTP test feature. Simplified source code.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> ---
>  testcases/kernel/syscalls/mmap/mmap16.c | 310 +++++++++---------------
>  1 file changed, 121 insertions(+), 189 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
> index 0d1fc3e96..1f1e88874 100644
> --- a/testcases/kernel/syscalls/mmap/mmap16.c
> +++ b/testcases/kernel/syscalls/mmap/mmap16.c
> @@ -1,245 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *   Copyright (c) 2015 Fujitsu Ltd.
> - *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
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
> + * Copyright (c) 2015 Fujitsu Ltd. Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
> -/*
> - * This is a regression test for commit:
> - * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> - * commit/?id=90a8020
> - * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> - * commit/?id=d6320cb
> +/*\
> + * [Description]
> + *
> + * This is a regression test for Linux kernel commit:
> + *
> + * commit d6320cbfc92910a3e5f10c42d98c231c98db4f60
> + * Author: Jan Kara <jack@suse.cz>
> + * Date:   Wed Oct 1 21:49:46 2014 -0400
> + * ext4: fix mmap data corruption when blocksize < pagesize
>   */

There were two commits listed previously. Why did you drop the first
one?

Also the commit hashes should really be added as proper tags to the
tst_test structure.

>  #define _GNU_SOURCE
>  
> -#include <stdio.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <sys/types.h>
> -#include <sys/wait.h>
> -#include <unistd.h>
> -#include <sys/mount.h>
> +#include <signal.h>
> +#include <time.h>
>  #include <sys/mman.h>
> +#include <sys/wait.h>
> +#include "tst_test.h"
>  
> -#include "test.h"
> -#include "safe_macros.h"
> +#define MNTPOINT "mntpoint"
> +#define FILE_PARENT "mntpoint/testfilep"
> +#define FILE_CHILD "mntpoint/testfilec"
> +#define FS_BLOCKSIZE 1024
>  
> -#define MNTPOINT	"mntpoint"
> -#define FS_BLOCKSIZE	1024
> -#define SUB_LOOPCOUNT	10
> +static int page_size = 1024;

It does not make any sense to initialize this variable, moreover to such
unexpected value...

> +static int parentfd = -1;
> +static int childfd = -1;
>  
> -static void setup(void);
> -static void cleanup(void);
> -static void do_child(void);
> -static void do_test(void);
> +static void do_child(void)
> +{
> +	int offset;
> +	char buf[FS_BLOCKSIZE];
> +	char *addr = NULL;
>  
> -static const char *device;
> -static const char *fs_type = "ext4";
> -static int mount_flag;
> -static int chdir_flag;
> -static int parentfd = -1;
> +	while ((childfd = SAFE_OPEN(FILE_CHILD, O_RDWR | O_CREAT)) < 0)
> +		usleep(100);

Again there is no point in doing a loop about O_CREAT open(), rather
than that the mode should be passed properly.

> -static int page_size;
> -static int bug_reproduced;
> +	memset(buf, 'a', FS_BLOCKSIZE);
> +	SAFE_WRITE(1, childfd, buf, FS_BLOCKSIZE);
> +
> +	/*
> +	 * In case mremap() may fail because that memory area can not be
> +	 * expanded at current virtual address(MREMAP_MAYMOVE is not set),
> +	 * we first do a mmap(page_size * 2) operation to reserve some
> +	 * free address space.
> +	 */
> +	addr = SAFE_MMAP(NULL, page_size * 2, PROT_WRITE | PROT_READ,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MUNMAP(addr, page_size * 2);
>  
> -char *TCID = "mmap16";
> -int TST_TOTAL = 1;
> +	addr = SAFE_MMAP(addr, FS_BLOCKSIZE, PROT_WRITE | PROT_READ, MAP_SHARED,
> +			 childfd, 0);
>  
> -int main(int ac, char **av)
> -{
> -	int i, lc;
> +	addr[0] = 'a';
>  
> -	tst_parse_opts(ac, av, NULL, NULL);
> +	SAFE_FTRUNCATE(childfd, page_size * 2);
>  
> -	setup();
> +	addr = mremap(addr, FS_BLOCKSIZE, 2 * page_size, 0);
> +	if (addr == MAP_FAILED)
> +		tst_brk(TBROK, "mremap failed unexpectedly");
>  
>  	/*
> -	 * If child process was killed by SIGBUS, indeed that can not guarantee
> -	 * this bug must have been fixed, If we're luckily enough, virtual
> -	 * memory subsystem happen to decide that it is time to write dirty
> -	 * pages, it will make mapped pages write-protect, so ->page_mkwrite()
> -	 * still will be called, child process will be killed by SIGBUS, but
> -	 * it's not because of above fixing patches. So here we run this test
> -	 * 10 times, if once, child process exits normally, we can sure that
> -	 * this bug is not fixed.
> +	 * Let parent process consume FS free blocks as many as possible, then
> +	 * there'll be no free blocks allocated for this new file mmaping for
> +	 * offset starting at 1024, 2048, or 3072. If this above kernel bug
> +	 * has been fixed, usually child process will killed by SIGBUS signal,
> +	 * if not, the data 'A', 'B', 'C' will be silently discarded later when
> +	 * kernel writepage is called, that means data corruption.
>  	 */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -		for (i = 0; i < SUB_LOOPCOUNT; i++)
> -			do_test();
> -	}
> -
> -	if (bug_reproduced)
> -		tst_resm(TFAIL, "Bug is reproduced!");
> -	else
> -		tst_resm(TPASS, "Bug is not reproduced!");
> +	for (offset = FS_BLOCKSIZE; offset < page_size; offset += FS_BLOCKSIZE)
> +		addr[offset] = 'a';
>  
> -	cleanup();
> -	tst_exit();
> +	SAFE_MUNMAP(addr, 2 * page_size);
> +	SAFE_CLOSE(childfd);
>  }
>  
> -static void do_test(void)
> +static void run(void)
>  {
>  	int ret, status;
>  	pid_t child;
>  	char buf[FS_BLOCKSIZE];
> +	int bug_reproduced = 0;
>  
> -	SAFE_TOUCH(cleanup, "testfilep", 0644, NULL);
> -	SAFE_TOUCH(cleanup, "testfilec", 0644, NULL);
> -
> -	child = tst_fork();
> -	switch (child) {
> -	case -1:
> -		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> -	case 0:
> +	child = SAFE_FORK();
> +	if (!child) {
>  		do_child();
> -	default:
> -		parentfd = SAFE_OPEN(cleanup, "testfilep", O_RDWR);
> -		memset(buf, 'a', FS_BLOCKSIZE);
> -
> -		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
> -		while (1) {
> -			ret = write(parentfd, buf, FS_BLOCKSIZE);
> -			if (ret < 0) {
> -				if (errno == ENOSPC) {
> -					break;
> -				} else {
> -					tst_brkm(TBROK | TERRNO, cleanup,
> -						 "write failed unexpectedly");
> -				}
> -			}
> +		return;
> +	}
> +
> +	while ((parentfd = SAFE_OPEN(FILE_PARENT, O_RDWR | O_CREAT)) < 0)
> +		usleep(100);

Here as well.

> +	memset(buf, 'a', FS_BLOCKSIZE);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	while (1) {
> +		ret = write(parentfd, buf, FS_BLOCKSIZE);
> +		if (ret < 0) {
> +			if (errno == ENOSPC)
> +				break;
> +
> +			tst_brk(TBROK, "write failed unexpectedly");

Please add the TERRNO flag here, so that the message includes the
actuall error.

>  		}
> -		SAFE_CLOSE(cleanup, parentfd);
> -		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
>  	}
>  
> -	wait(&status);
> +	SAFE_CLOSE(parentfd);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(child, &status, 0);
>  	if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
>  		bug_reproduced = 1;

This actually looks like it will be never triggered after the changes
you did. The previous version did exit(TFAIL) at the end of the child.
Now the child returns to the library which does exit(0), so this should
be adjusted properly.

>  	} else {
>  		/*
>  		 * If child process was killed by SIGBUS, bug is not reproduced.
>  		 */
> -		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGBUS) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "child process terminate unexpectedly");
> -		}
> +		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGBUS)
> +			tst_brk(TBROK, "child process terminate unexpectedly");

Please use the tst_strstatus() here.

>  	}
>  
> -	SAFE_UNLINK(cleanup, "testfilep");
> -	SAFE_UNLINK(cleanup, "testfilec");
> +	SAFE_UNLINK(FILE_PARENT);
> +	SAFE_UNLINK(FILE_CHILD);
> +
> +	if (bug_reproduced)
> +		tst_res(TFAIL, "bug is reproduced");
> +	else
> +		tst_res(TPASS, "bug is not reproduced");
>  }
>  
>  static void setup(void)
>  {
>  	const char *fs_opts[3] = {"-b", "1024", NULL};
> -	const char *extra_opts[] = {"10240", NULL};
> -
> -	tst_sig(FORK, DEF_HANDLER, NULL);
> -	tst_require_root();
> -
> -	TEST_PAUSE;
> -	tst_tmpdir();
> -
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> +	const char *extra_opts[2] = {"10240", NULL};
>  
>  	page_size = getpagesize();
>  
> -	device = tst_acquire_device(cleanup);
> -	if (!device)
> -		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> -	tst_mkfs(cleanup, device, fs_type, fs_opts, extra_opts);
> -
> -	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
> -	/*
> -	 * Disable ext4 delalloc feature, so block will be allocated
> -	 * as soon as possible
> -	 */
> -	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, "nodelalloc");
> -	mount_flag = 1;
> -
> -	SAFE_CHDIR(cleanup, MNTPOINT);
> -	chdir_flag = 1;
> -
> +	SAFE_MKDIR(MNTPOINT, 0777);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, extra_opts);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);

We can just move all the parameters to the tst_test structure and set
the .mount_device flag.

>  }
>  
> -static void do_child(void)
> +static void cleanup(void)
>  {
> -	int fd, offset;
> -	char buf[FS_BLOCKSIZE];
> -	char *addr = NULL;
> -
> -	/*
> -	 * We have changed SIGBUS' handler in parent process by calling
> -	 * tst_sig(FORK, DEF_HANDLER, NULL), so here just restore it.
> -	 */
> -	if (signal(SIGBUS, SIG_DFL) == SIG_ERR)
> -		tst_brkm(TBROK | TERRNO, NULL, "signal(SIGBUS) failed");
> -
> -	memset(buf, 'a', FS_BLOCKSIZE);
> -	fd = SAFE_OPEN(NULL, "testfilec", O_RDWR);
> -	SAFE_WRITE(NULL, 1, fd, buf, FS_BLOCKSIZE);
> -
> -	/*
> -	 * In case mremap() may fail because that memory area can not be
> -	 * expanded at current virtual address(MREMAP_MAYMOVE is not set),
> -	 * we first do a mmap(page_size * 2) operation to reserve some
> -	 * free address space.
> -	 */
> -	addr = SAFE_MMAP(NULL, NULL, page_size * 2, PROT_WRITE | PROT_READ,
> -			 MAP_PRIVATE_EXCEPT_UCLINUX | MAP_ANONYMOUS, -1, 0);
> -	SAFE_MUNMAP(NULL, addr, page_size * 2);
> -
> -	addr = SAFE_MMAP(NULL, addr, FS_BLOCKSIZE, PROT_WRITE | PROT_READ,
> -			 MAP_SHARED, fd, 0);
> -
> -	addr[0] = 'a';
> -
> -	SAFE_FTRUNCATE(NULL, fd, page_size * 2);
> -	addr = mremap(addr, FS_BLOCKSIZE, 2 * page_size, 0);
> -	if (addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, NULL, "mremap failed unexpectedly");
> -
> -	/*
> -	 * Let parent process consume FS free blocks as many as possible, then
> -	 * there'll be no free blocks allocated for this new file mmaping for
> -	 * offset starting at 1024, 2048, or 3072. If this above kernel bug
> -	 * has been fixed, usually child process will killed by SIGBUS signal,
> -	 * if not, the data 'A', 'B', 'C' will be silently discarded later when
> -	 * kernel writepage is called, that means data corruption.
> -	 */
> -	TST_SAFE_CHECKPOINT_WAKE(NULL, 0);
> -	TST_SAFE_CHECKPOINT_WAIT2(NULL, 0, 60*1000);
> +	if (childfd >= 0)
> +		SAFE_CLOSE(childfd);
>  
> -	for (offset = FS_BLOCKSIZE; offset < page_size; offset += FS_BLOCKSIZE)
> -		addr[offset] = 'a';
> +	if (parentfd >= 0)
> +		SAFE_CLOSE(parentfd);
>  
> -	SAFE_MUNMAP(NULL, addr, 2 * page_size);
> -	SAFE_CLOSE(NULL, fd);
> -	exit(TFAIL);
> +	if (tst_is_mounted(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
>  }
>  
> -static void cleanup(void)
> -{
> -	if (parentfd >= 0)
> -		close(parentfd);
> -	if (chdir_flag && chdir(".."))
> -		tst_resm(TWARN | TERRNO, "chdir('..') failed");
> -	if (mount_flag && tst_umount(MNTPOINT) < 0)
> -		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
> -	if (device)
> -		tst_release_device(device);
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.dev_fs_type = "ext4",
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.needs_checkpoints = 1,
> +	.needs_tmpdir = 1,
> +	.needs_cmds = (const char *const []) {
> +		"mkfs.ext4",
> +		NULL,
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
