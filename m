From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 4 Sep 2018 16:25:59 +0200
Subject: [LTP] [PATCH v7 2/4] Testing statx syscall * statx02.c: This
 file will check flag like AT_EMPTY_PATH,
 AT_SYMLINK_NOFOLLOW * AT_EMPTY_PATH: If pathname is an empty string,
 operate on the file referred to by dirfd. * AT_SYMLINK_NOFOLLOW:If pathname
 is a symbolic link,
 do not dereference it: instead return information about the link itself.
In-Reply-To: <20180903121713.3706-1-vaishnavi.d@zilogic.com>
References: <20180903121713.3706-1-vaishnavi.d@zilogic.com>
Message-ID: <20180904142559.GB5625@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few adjustements.

First of all, please make sure there is an empty line before the first
line of the patch description and the paragraphs that describe the patch
that follow. Otherwise the whole description will end up mangled into a
single line like in this patch.

> Signed-off-by: Tarun.T.U <tarun@zilogic.com>
> Signed-off-by: Vaishnavi.D <vaishnavi.d@zilogic.com>
> ---
>  runtest/syscalls                           |   3 +-
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx02.c  | 144 +++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/statx/statx02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b7c74446b..079c18fc7 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1496,4 +1496,5 @@ memfd_create04 memfd_create04
>  
>  copy_file_range01 copy_file_range01
>  
> -statx01 statx01
> \ No newline at end of file
> +statx01 statx01
> +statx02 statx02
> \ No newline at end of file

Also please make sure that the file ends up with a newline, otherwise
each newly added line produces ugly diffs like this one.

> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index aec497382..1849891d6 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -1 +1,2 @@
>  /statx01
> +/statx02
> \ No newline at end of file

Here as well.

> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
> new file mode 100644
> index 000000000..2f79bec1c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx02.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0 or later
> +/*
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email: code@zilogic.com
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> + */

I've removed the long license and fixed SPDX identifier.

...

> +static void test_empty_path(void)
> +{
> +	struct statx buf;
> +
> +	TEST(statx(file_fd, "", AT_EMPTY_PATH, 0, &buf));
> +	if (TST_RET == 0)
> +		tst_res(TPASS,
> +			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buf)");
> +	else
> +		tst_brk(TFAIL | TTERRNO,
> +			"statx(file_fd, \" \", AT_EMPTY_PATH, 0, &buff)");
> +
> +	if (buf.stx_size == SIZE)
> +		tst_res(TPASS,
> +			"stx_size(%"PRIu64") obtained is correct",
> +			buf.stx_size);
> +	else
> +		tst_res(TFAIL,
> +			"stx_size(%"PRIu64") obtained is not same as expected(%u)",
> +			buf.stx_size, SIZE);

And removed the "obtained" here as well.

> +
> +}
> +

...

> +static void run(unsigned int i)
> +{
> +	struct tcase *t;
> +
> +	t = &tcases[i];
> +	t->tfunc();
> +}

And simplified this part.


And pushed, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
