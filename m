From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Jul 2017 14:49:13 +0200
Subject: [LTP] [PATCH] Add msync04: verify msync() writes back to file
In-Reply-To: <1499942315-14514-1-git-send-email-vkabatov@redhat.com>
References: <1499942315-14514-1-git-send-email-vkabatov@redhat.com>
Message-ID: <20170720124913.GH32092@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
> new file mode 100644
> index 0000000..a0ae2c0
> --- /dev/null
> +++ b/testcases/kernel/syscalls/msync/msync04.c
> @@ -0,0 +1,114 @@
> +/*
> + * Copyright (C) 2017 Red Hat, Inc.
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Test description: Verify msync() after writing into mmap()-ed file works.
> + *
> + * Write to mapped region and sync the memory back with file. Check the page
> + * is no longer dirty after msync() call.
> + */
> +
> +#include <errno.h>
> +#include "tst_test.h"
> +
> +static int test_fd;
> +static char *mmaped_area;
> +static int pagemap_fd;
> +static int pageflags_fd;
> +static long pagesize;
> +
> +uint64_t get_dirty_bit(unsigned long addr)
> +{
> +	uint64_t pagemap_entry, pfn, index;
> +
> +	index = (addr / pagesize) * sizeof(uint64_t);
> +	pagemap_fd = SAFE_OPEN("/proc/self/pagemap", O_RDONLY);
> +	SAFE_LSEEK(pagemap_fd, index, SEEK_SET);
> +	SAFE_READ(1, pagemap_fd, &pagemap_entry, sizeof(uint64_t));
                                                   ^
						   sizeof(pagemap_entry)
						   please, it's a bit
						   less prone to errors
						   that way
> +	SAFE_CLOSE(pagemap_fd);
> +	pfn = pagemap_entry & ((1ULL << 55) - 1);
> +	if (!pfn)
> +		return 0;
> +	pageflags_fd = SAFE_OPEN("/proc/kpageflags", O_RDONLY);
> +	index = pfn * sizeof(uint64_t);
> +	SAFE_LSEEK(pageflags_fd, index, SEEK_SET);
> +	SAFE_READ(1, pageflags_fd, &pagemap_entry, sizeof(uint64_t));
                                             ^                ^
				   Should probably be         |
				   pageflag_entry to avoid    |
				   confusion.                 |
				                        sizeof(pageflag_entry)

> +	SAFE_CLOSE(pageflags_fd);
> +	return pagemap_entry & (1ULL << 4);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_MKDIR("msync04", 0777);
> +	/*
> +	 * Using a new device to avoid running on tmpfs because of different
> +	 * behavior
> +	 */
> +	SAFE_MOUNT(tst_device->dev, "msync04", tst_device->fs_type, 0, NULL);
> +	pagesize = (off_t)SAFE_SYSCONF(_SC_PAGESIZE);
> +}
> +
> +static void test_msync(void)
> +{
> +	uint64_t dirty;
> +
> +	test_fd = SAFE_OPEN("msync04/testfile", O_CREAT | O_TRUNC | O_RDWR);
> +	SAFE_WRITE(0, test_fd, "AAAAAAAAAA", 10);

Can we pretty please avoid putting in hand computed buffer lengths. You
can define the string then use sizeof() to obtain it's lengh as:

#define FILE_DATA "AAAAAAAAAAAA"

...
	SAFE_WRITE(0, test_fd, FILE_DATA, sizeof(FILE_DATA) - 1);

> +	mmaped_area = SAFE_MMAP(NULL, pagesize, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, test_fd, 0);
> +	mmaped_area[8] = 'B';
> +	dirty = get_dirty_bit((unsigned long)mmaped_area);
> +	if (!dirty) {
> +		tst_res(TFAIL, "Expected dirty bit to be set after writing to"
> +				" mmap()-ed area");
> +		return;
> +	}
> +	if (msync(mmaped_area, pagesize, MS_SYNC) < 0) {
> +		tst_res(TFAIL | TERRNO, "msync() failed with %s",
> +				tst_strerrno(errno));

This is kind of redundant, the TERRNO flag already includes the errno in
the message so all we need to do is:

	tst_res(TFAIL | TERRNO, "msync() failed");

> +		return;

And we exit here without cleaning up. We should goto to the end of this
function where we do the SAFE_MUNMAP() here.

The problem is that even if we have fallback cleanup in the test cleanup
we wouldn't cleanup in a case that the test was called with the -i
paramter. Fallback in test cleanup only works if we use tst_brk() and
exit the test immediately.

To sum it up, things initialized in test setup() are safe to be freed in
test cleanup(). Things initialized in the test function should most of
the time be freed in the test function as well.

> +	}
> +	dirty = get_dirty_bit((unsigned long)mmaped_area);

It would be a bit cleaner if we defined the get_dirty_bit() function
with a void * paramter and then cast the pointer to unsigned long inside
of the function rather than casting it each time the function is called.

> +	if (dirty)
> +		tst_res(TFAIL, "msync() failed to write dirty page despite"
> +				" succeeding");
> +	else
> +		tst_res(TPASS, "msync() working correctly");
> +	SAFE_MUNMAP(mmaped_area, pagesize);
> +	SAFE_CLOSE(test_fd);

Just FYI we could have closed the fd right after the mmap().

> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(mmaped_area, pagesize);
> +	if (test_fd > 0)
> +		SAFE_CLOSE(test_fd);
> +	SAFE_UMOUNT("msync04");
> +}
> +
> +static struct tst_test test = {
> +	.tid = "msync04",

The .tid field is autodetected now, no need to fill it in.

> +	.test_all = test_msync,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.format_device = 1,

The .format_device implies .needs_device there is no need to set both,
moreover we also have mount_device that covers the SAFE_MOUNT() in the
test setup and SAFE_UMOUNT() in the tes cleanup as well. You just have
to set mntpoint and mount_device in this structure.

> +	.min_kver = "2.6.25",
> +};
> -- 
> 2.7.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
