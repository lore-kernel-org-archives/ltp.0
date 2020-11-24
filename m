From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2020 16:24:46 +0100
Subject: [LTP] [PATCH V3 2/2] syscalls: Add tests for open_by_handle_at()
In-Reply-To: <d4c771f2a43034af28a8b05ee8eb560bcf07713f.1606196558.git.viresh.kumar@linaro.org>
References: <79f282b7796b4b4bcf6936483bb819105e941f77.1606196558.git.viresh.kumar@linaro.org>
 <d4c771f2a43034af28a8b05ee8eb560bcf07713f.1606196558.git.viresh.kumar@linaro.org>
Message-ID: <20201124152446.GC12878@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <sys/stat.h>
> +#include "lapi/name_to_handle_at.h"
> +
> +#define TEST_FILE "test_file"
> +#define TEST_DIR "test_dir"
> +
> +static int dir_fd, fd_atcwd = AT_FDCWD, file_fd;
> +static struct file_handle *fhp;
> +
> +static struct tcase {
> +	int *dfd;
> +	const char *pathname;
> +	int name_flags;
> +	int flags;
> +} tcases[] = {
> +	{&dir_fd, TEST_FILE, 0, O_RDWR},
> +	{&dir_fd, TEST_FILE, 0, O_RDONLY},
> +	{&dir_fd, TEST_FILE, 0, O_WRONLY},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
> +	{&dir_fd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
> +	{&dir_fd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
> +	{&dir_fd, "", AT_EMPTY_PATH, O_RDONLY},
> +	{&file_fd, "", AT_EMPTY_PATH, O_RDONLY},
> +
> +	{&fd_atcwd, TEST_FILE, 0, O_RDWR},
> +	{&fd_atcwd, TEST_FILE, 0, O_RDONLY},
> +	{&fd_atcwd, TEST_FILE, 0, O_WRONLY},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDWR},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_RDONLY},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH, O_WRONLY},
> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDWR},
> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_RDONLY},
> +	{&fd_atcwd, TEST_FILE, AT_SYMLINK_FOLLOW, O_WRONLY},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDWR},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_RDONLY},
> +	{&fd_atcwd, TEST_FILE, AT_EMPTY_PATH | AT_SYMLINK_FOLLOW, O_WRONLY},
> +	{&fd_atcwd, "", AT_EMPTY_PATH, O_RDONLY},
> +};

I guess that we can do better than exact copy of the
name_to_handle_at01.c.

We can as well create two handles in the test setup one for directory
and one for file and then loop over different flags for
open_by_handle_at() instead of getting the handle in each run()
iteration.

-- 
Cyril Hrubis
chrubis@suse.cz
