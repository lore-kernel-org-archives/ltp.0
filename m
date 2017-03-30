From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 13:12:14 +0200
Subject: [LTP] [PATCH v1 1/1] syscalls/splice04: add test for splice()
 from pipe to pipe
In-Reply-To: <1490859154-10037-1-git-send-email-bxue@redhat.com>
References: <1490859154-10037-1-git-send-email-bxue@redhat.com>
Message-ID: <20170330111214.GD12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
The code has a couple of style problems, please make use of
checkpatch.pl (distributed with linux kernel sources) next time.

> ---
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/splice/splice04.c | 130 ++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 15ae66e..c95da04 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1222,6 +1222,7 @@ sockioctl01 sockioctl01
>  splice01 splice01
>  splice02 seq 1 20000 | splice02 splice02-temp
>  splice03 splice03
> +splice04 splice04 -l 65536
                     ^
		     Can we avoid passing options for a default test run?


It's good that we can pass a test different buffers sizes, but the
default one should be hardcoded so that we can run the test just by
executing the test binary.

>  tee01 tee01
>  tee02 tee02
> diff --git a/testcases/kernel/syscalls/splice/splice04.c b/testcases/kernel/syscalls/splice/splice04.c
> new file mode 100644
> index 0000000..951c004
> --- /dev/null
> +++ b/testcases/kernel/syscalls/splice/splice04.c
> @@ -0,0 +1,130 @@
> +/*
> + * Copyright (C) 2017 Red Hat, Inc.
> + * Author: Boyang Xue <bxue@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.

GPLv2+ (the one with any later clause) is sligtly prefered.

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
> +
> +/*
> + * Functional test for splice(2): pipe to pipe
> + *
> + * This test case tests splice(2) from a pipe to another
> + */
> +
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdlib.h>

The tst_test.h should be included last.

> +#define MAX_DATA_LEN (64*1024)
> +
> +static void cleanup(void);
> +static void setup(void);
> +static void tc_dispatcher(unsigned int n);
> +static int pipe_pipe(void);
> +static int cmp_data(char *arr);
> +
> +static char *str_len_data;
> +static int num_len_data;
> +static char *arr_data;
> +
> +static struct tst_option options[] = {
> +	{"l:", &str_len_data, "-l <num> Length of test data (in bytes)"},
> +	{NULL, NULL, NULL},
> +};
> +
> +static void cleanup(void){
> +}

No empty cleanup, if there is no cleanu to be done just do not set the
.cleanup pointer in the test struture.

> +static void setup(void){
> +	int i;
> +
> +	if (tst_parse_int(str_len_data, &num_len_data, 1, MAX_DATA_LEN)){
> +		tst_brk(TBROK, "Invalid length of test data: '%s'", str_len_data);
> +	}
> +	arr_data = (char *) SAFE_MALLOC(num_len_data);
                     ^
		     This cast is useless, void* is converted
		     automatically to any other kind of pointer.

> +	for(i = 0; i < num_len_data; i++){
> +		*(arr_data + i) = i & 0xff;
> +	}
> +}
> +
> +static void tc_dispatcher(unsigned int n){
> +	int ret;
> +
> +	switch (n){
> +		case 0:
> +			ret = pipe_pipe();
> +			if (ret < 0){
> +				tst_res(TFAIL, "splice(2) from pipe to pipe fails.");
> +			} else {
> +				tst_res(TPASS, "splice(2) from pipe to pipe run pass.");
> +			}
> +			break;
> +		default:
> +			tst_res(TBROK, "No corresponding test case exists.");
> +			break;
> +	}
> +}

If there is just a single test use the test_all function pointer in the
test structure instead.

> +static int cmp_data(char *arr){
> +	int i;
> +
> +	for (i = 0; i < num_len_data; i++){
> +		if (*(arr_data + i) != *(arr + i)){
> +			tst_res(TBROK, "Error in comparing original data with data after splice(2): data mismatch.");
> +			free(arr);
> +			return -1;
> +		}
> +	}
> +	free(arr);

The test function could be called in a loop (-i test paramter). Freeing
any allocated buffers here is wrong. That is what the cleanup funciton
is for.

> +	return 0;
> +}
> +
> +static int pipe_pipe(void){
> +	char *arr;
> +	int pp1[2], pp2[2];
> +
> +	arr = (char *) SAFE_MALLOC(num_len_data);
> +	SAFE_PIPE(pp1);
> +	SAFE_PIPE(pp2);
> +	SAFE_WRITE(1, pp1[1], arr_data, num_len_data);
> +	splice(pp1[0], NULL, pp2[1], NULL, num_len_data, SPLICE_F_MOVE);
> +	SAFE_READ(1, pp2[0], arr, num_len_data);
> +
> +	SAFE_CLOSE(pp1[1]);
> +	SAFE_CLOSE(pp1[0]);
> +	SAFE_CLOSE(pp2[1]);
> +	SAFE_CLOSE(pp2[0]);
> +
> +	return cmp_data(arr);
> +}
> +
> +static struct tst_test test = {
> +	.tid = "splice04",
> +	.needs_tmpdir = 0,
            ^
	    No need to set anything to 0 here, these are global variables.
> +	.test = tc_dispatcher,
> +	.tcnt = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.options = options,
> +	.min_kver = "2.6.31"
> +};
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
