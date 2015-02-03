Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIaEV-0003nQ-3x
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 09:57:23 +0000
Date: Tue, 3 Feb 2015 10:57:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203095709.GB15330@rei.scz.novell.com>
References: <1422876702-3152-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1422876702-3152-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422876702-3152-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/mmap16: regression test for data
 corruption when blocksize < pagesize for mmaped data
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + *   Copyright (c) 2015 Fujitsu Ltd.
> + *   Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + */
> +
> +/*
> + * This is a regression test for commit:
> + * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> + * commit/?id=90a8020
> + * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
> + * commit/?id=d6320cb
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +
> +#include "usctest.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +
> +#define MNTPOINT	"mntpoint"
> +#define FS_BLOCKSIZE	1024
> +
> +static void setup(void);
> +static void cleanup(void);
> +static void do_child(void);
> +static void do_test(void);
> +
> +static const char *device;
> +static const char *fs_type = "ext4";
> +static int mount_flag;
> +
> +static int page_size;
> +static struct tst_checkpoint checkpoint1, checkpoint2;
> +static int bug_reproduced;
> +
> +char *TCID = "mmap16";
> +int TST_TOTAL = 1;
> +
> +int main(int ac, char **av)
> +{
> +	int i;
> +	const char *msg;
> +
> +	msg = parse_opts(ac, av, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	/*
> +	 * If child process was killed by SIGBUS, indeed that can not guarantee
> +	 * this bug must have been fixed, If luckily virtual memory subsystem
> +	 * decides that it is time to write dirty pages, it will make maped
> +	 * pages write-protect, so ->page_mkwrite() still will be called, child
> +	 * process will be killed by SIGBUS, it's not fixed because of above
> +	 * fixing patches. So here we run this test 10 times, if once, child
> +	 * process exits normally, we can sure that this bug is not fixed.
> +	 */
> +	for (i = 0; i < 10; i++)
> +		do_test();
> +
> +	if (bug_reproduced)
> +		tst_resm(TFAIL, "Bug is reproduced!");
> +	else
> +		tst_resm(TPASS, "Bug is not reproduced!");
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void do_test(void)
> +{
> +	int fd, ret, status;
> +	pid_t child;
> +	char buf[FS_BLOCKSIZE];
> +
> +	SAFE_TOUCH(cleanup, "testfilep", 0644, NULL);
> +	SAFE_TOUCH(cleanup, "testfilec", 0644, NULL);
> +
> +	child = tst_fork();
> +	if (child < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
> +	} else if (child == 0) {
> +		do_child();
> +	} else {
> +		fd = SAFE_OPEN(cleanup, "testfilep", O_RDWR);
> +		memset(buf, 'a', FS_BLOCKSIZE);
> +
> +		TST_CHECKPOINT_PARENT_WAIT(cleanup, &checkpoint1);
> +		while (1) {
> +			ret = write(fd, buf, FS_BLOCKSIZE);
> +			if (ret < 0) {
> +				if (errno == ENOSPC) {
> +					break;
> +				} else {
> +					tst_brkm(TBROK | TERRNO, cleanup,
> +						 "write failed unexpectedly");
> +				}
> +			}
> +		}
> +		SAFE_CLOSE(cleanup, fd);
> +		TST_CHECKPOINT_SIGNAL_CHILD(cleanup, &checkpoint2);
> +	}

I tend to write this code as

	switch (child) {
	case -1:
		tst_brkm(...);
	case 0:
		do_child();
	break;
	default:
		...
	break;
	}

> +	wait(&status);
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGBUS) {
> +		;

This empty body if looks strange.

Can't we just write this code as:

if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
	bug_reproduced = 1;
} else {
	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGBUS)) {
		tst_brkm(TBROK | TERRNO, cleanup,
			 "child process terminate unexpectedly");
	}
}

Or add a TINFO message that the child has been killed with SIGBUS, so
that the body is not empty at least?

> +	} else if (WIFEXITED(status) && WEXITSTATUS(status) == 1) {
> +		bug_reproduced = 1;
> +	} else {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "child process terminate unexpectedly");
> +	}
> +
> +	SAFE_UNLINK(cleanup, "testfilep");
> +	SAFE_UNLINK(cleanup, "testfilec");
> +}
> +
> +static void setup(void)
> +{
> +	const char *fs_opts[3] = {"-b", "1024", NULL};
> +
> +	tst_sig(FORK, DEF_HANDLER, NULL);
> +
> +	TEST_PAUSE;
> +	tst_tmpdir();
> +
> +	page_size = getpagesize();
> +	if (page_size == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "Unable to get page size");
> +
> +	device = tst_acquire_device(cleanup);
> +	if (!device)
> +		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> +	tst_mkfs(cleanup, device, fs_type, fs_opts);
> +
> +	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
> +	/*
> +	 * Disable ext4 delalloc feature, so block will be allocated
> +	 * as soon as possible
> +	 */
> +	if (mount(device, MNTPOINT, fs_type, 0, "nodelalloc") < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}

We do have SAFE_MOUNT() as well.

> +	mount_flag = 1;
> +
> +	SAFE_CHDIR(cleanup, MNTPOINT);
> +	TST_CHECKPOINT_CREATE(&checkpoint1);
> +	TST_CHECKPOINT_CREATE(&checkpoint2);
> +}
> +
> +static void do_child(void)
> +{
> +	int fd, offset;
> +	char buf[FS_BLOCKSIZE];
> +	char *addr = NULL;
> +
> +	/*
> +	 * We have changed SIGBUS' handler in parent process,
> +	 * so here just restore it
> +	 */
> +	if (signal(SIGBUS, SIG_DFL) == SIG_ERR)
> +		tst_brkm(TBROK | TERRNO, NULL, "signal(SIGBUS) failed");
> +
> +	memset(buf, 'a', FS_BLOCKSIZE);
> +	fd = SAFE_OPEN(NULL, "testfilec", O_RDWR);
> +	SAFE_PWRITE(NULL, 1, fd, buf, FS_BLOCKSIZE, 0);
> +
> +	/*
> +	 * In case mremap() may fail because that memory area can not be
> +	 * expanded at current virtual address(MREMAP_MAYMOVE is not set),
> +	 * we first do a mmap(page_size * 2) operation to reserve some
> +	 * free address space.
> +	 */
> +	addr = (char *)SAFE_MMAP(NULL, NULL, page_size * 2, PROT_WRITE |
> +				 PROT_READ, MAP_PRIVATE_EXCEPT_UCLINUX|
> +				 MAP_ANONYMOUS, -1, 0);

Casting void* pointers to anything else is meaningless, please don't do
that.

> +	SAFE_MUNMAP(NULL, addr,  page_size * 2);
> +
> +	addr = (char *)SAFE_MMAP(NULL, addr, FS_BLOCKSIZE, PROT_WRITE |
> +				 PROT_READ, MAP_SHARED, fd, 0);
> +
> +	addr[0] = 'a';
> +
> +	SAFE_FTRUNCATE(NULL, fd, page_size * 2);
> +	addr = mremap(addr, FS_BLOCKSIZE, 2 * page_size, 0);
> +	if (addr == MAP_FAILED)
> +		tst_brkm(TBROK | TERRNO, NULL, "mremap failed unexpectedly");
> +
> +	/*
> +	 * Let parent process consume FS free blocks as many as possible, then
> +	 * there'll be no free blocks allocated for this new file mmaping for
> +	 * offset starting at 1024, 2048, or 3072. If this above kernel bug
> +	 * has been fixed, usually child process will killed by SIGBUS signal,
> +	 * if not, the data 'A', 'B', 'C' will be silently discarded later when
> +	 * kernel writepage is called, that means data corruption.
> +	 */
> +	TST_CHECKPOINT_SIGNAL_PARENT(&checkpoint1);
> +	TST_CHECKPOINT_CHILD_WAIT(&checkpoint2);
> +
> +	for (offset = FS_BLOCKSIZE; offset < page_size; offset += FS_BLOCKSIZE)
> +		addr[offset] = 'a';
> +	exit(TFAIL);
> +}
> +
> +static void cleanup(void)
> +{
> +	TEST_CLEANUP;
> +
> +	SAFE_CHDIR(NULL, "..");

It's better not to use SAFE_MACROS here, because we wan't to run the
rest of the cleanup even if this step fails. So what we should do here
is just:

	if (chdir(".."))
		tst_resm(TWARN | TERRNO, "chdir('..') failed");

> +	if (mount_flag && tst_umount(MNTPOINT) < 0)
> +		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
> +
> +	if (device)
> +		tst_release_device(NULL, device);
> +
> +	tst_rmdir();
> +}
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
