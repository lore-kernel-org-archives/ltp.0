From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 24 Nov 2020 10:39:16 +0800
Subject: [LTP] [PATCH V2 1/2] syscalls: Add tests for name_to_handle_at()
In-Reply-To: <20201123140630.GA17077@yuki.lan>
References: <b758999c1bd02a52a68cbb6449bb3d82dd2a4e69.1606120441.git.viresh.kumar@linaro.org>
 <20201123140630.GA17077@yuki.lan>
Message-ID: <5FBC7254.6070801@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Viresh
> Hi!
>> diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
>> new file mode 100644
>> index 000000000000..19c08545802a
>> --- /dev/null
>> +++ b/include/lapi/name_to_handle_at.h
>> @@ -0,0 +1,54 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 Linaro Limited. All rights reserved.
>> + * Author: Viresh Kumar<viresh.kumar@linaro.org>
>> + */
>> +
>> +#ifndef NAME_TO_HANDLE_AT_H__
>> +#define NAME_TO_HANDLE_AT_H__
>> +
>> +#include<sys/syscall.h>
>> +#include "config.h"
>> +#include "tst_buffers.h"
>> +#include "tst_test.h"
>> +
>> +#ifndef HAVE_NAME_TO_HANDLE_AT
>> +struct file_handle {
>> +	unsigned int handle_bytes;
>> +	int handle_type;
>> +	/* File identifier.  */
>> +	unsigned char f_handle[0];
>> +};
>> +
>> +int name_to_handle_at(int dfd, const char *pathname, struct file_handle *handle,
>> +		      int *mount_id, int flags);
>> +int open_by_handle_at(int mount_fd, struct file_handle *handle, int flags);
>
> This still is not complete solution. As far as I can tell this will fail
> to link on machine where libc does not implement these, so we have to
> make them static inline functions that actually call the tst_syscall().
>
Agree.

> Eitherway these functions were added to glibc 2.14 which is 2011 which
> seems to be old enough, but I'm not sure about musl libc support. Does
> anyone have an idea?
>
musl libc supports them since 2018.9 after this patch[1] and it is about 
2 year ago. We should add a fallback for it like setns.h.

[1]https://git.musl-libc.org/cgit/musl/commit/?id=3e14bbcd1979376b188bfabb816ff828608fb5d7
>> +#endif
>> +
>> +/* Returns a valid pointer on success, NULL on errors */
>> +static inline struct file_handle *
>> +allocate_file_handle(int dfd, const char *pathname)
>> +{
>> +	struct file_handle fh = {}, *fhp;
>> +	int mount_id;
>> +
>> +	/*
>> +	 * Make an initial call to name_to_handle_at() to discover the size
>> +	 * required for the file handle.
>> +	 */
>> +	TEST(name_to_handle_at(dfd, pathname,&fh,&mount_id, 0));
>> +	if (TST_RET != -1 || TST_ERR != EOVERFLOW) {
>> +		tst_res(TFAIL | TTERRNO,
>> +			"name_to_handle_at() should fail with EOVERFLOW");
>> +		return NULL;
>> +	}
>> +
>> +	/* Valid file handle */
>> +	fhp = tst_alloc(sizeof(*fhp) + fh.handle_bytes);
>> +	fhp->handle_type = fh.handle_type;
>> +	fhp->handle_bytes = fh.handle_bytes;
>> +
>> +	return fhp;
>> +}
>> +
>> +#endif /* NAME_TO_HANDLE_AT_H__ */
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index a5363277f478..65f2e58a87e4 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -846,6 +846,9 @@ nanosleep01 nanosleep01
>>   nanosleep02 nanosleep02
>>   nanosleep04 nanosleep04
>>
>> +name_to_handle_at01 name_to_handle_at01
>> +name_to_handle_at02 name_to_handle_at02
>> +
>>   nftw01 nftw01
>>   nftw6401 nftw6401
>>
>> diff --git a/testcases/kernel/syscalls/name_to_handle_at/.gitignore b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
>> new file mode 100644
>> index 000000000000..268a8a34f85e
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/name_to_handle_at/.gitignore
>> @@ -0,0 +1,2 @@
>> +name_to_handle_at01
>> +name_to_handle_at02
>> diff --git a/testcases/kernel/syscalls/name_to_handle_at/Makefile b/testcases/kernel/syscalls/name_to_handle_at/Makefile
>> new file mode 100644
>> index 000000000000..18896b6f28c0
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/name_to_handle_at/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
>> new file mode 100644
>> index 000000000000..1213654d108f
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
>> @@ -0,0 +1,113 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (c) 2020 Viresh Kumar<viresh.kumar@linaro.org>
>> + */
>> +
>> +/*\
>> + * [DESCRIPTION]
>> + *
>> + * Basic name_to_handle_at() tests.
>> + *
>> + * [ALGORITHM]
>> + *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
>> + *  - Check that we were able to access a file's stat with name_to_handle_at()
>> + *    and open_by_handle_at().
>> +\*/
>> +#define _GNU_SOURCE
>> +#include<fcntl.h>
>> +#include<sys/stat.h>
>> +#include "lapi/name_to_handle_at.h"
>> +
>> +#define TEST_FILE "test_file"
>> +#define TEST_DIR "test_dir"
>> +
>> +static int dir_fd, fd_atcwd = AT_FDCWD;
>> +static struct file_handle *fhp;
>> +
>> +static struct tcase {
>> +	int *dfd;
>> +	const char *pathname;
>> +	int name_flags;
>> +	int flags;
>> +} tcases[] = {
>> +	{&dir_fd, TEST_FILE, 0, O_RDWR},
>> +	{&dir_fd, TEST_FILE, 0, O_RDONLY},
>> +	{&dir_fd, TEST_FILE, 0, O_WRONLY},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
>> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
>> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
>> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
>> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
>> +	{&dir_fd, "", AT_EMPTY_PATH, O_RDONLY},
>> +
>> +	{&fd_atcwd, TEST_FILE, 0, O_RDWR},
>> +	{&fd_atcwd, TEST_FILE, 0, O_RDONLY},
>> +	{&fd_atcwd, TEST_FILE, 0, O_WRONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
>> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
>> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
>> +	{&fd_atcwd, "", AT_EMPTY_PATH, O_RDONLY},
>
> Reading manual we can supposedly pass a dirfd reffering to a file with
> AT_EMPTY_PATH, so we may as well add that test here as well.
>
>



