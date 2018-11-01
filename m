From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 1 Nov 2018 12:38:57 +0100
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
Message-ID: <20181101113857.GB22042@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Ramon,

thank you for moving from github pull request to mailing list.

> Per Rafael's earlier email about how to proceed, find attached the path with
> the test cases.
You sent your patch as an attachment.
Please, next time, send is at plain text,
as although patchwork can work with that [1], mailman can't handle it [2].
Here are some instructions [3].
Please add your Signed-off-by: tag.

I've added some comments in github pull request [4], you didn't change them, so
I repeat some of it here. But please, read the doc to provide usable patch [5] [6].
2165 lines for one file suggest to split file into several.

Please have look into the to see code style (short code, easy to read, using
SAFE_*() helpers to prevent reinventing a wheal, avoiding macros, remove comments
which has nothing to say, ...).

LTP code varies, some is really old and ugly. But we try to include reasonably
clean code. You can have look at this as a good example of code style:
testcases/kernel/syscalls/inotify/inotify09.c
59e0a81c5 inotify07: Add test for kernel crash during event notification
It has also TST_TEST_TCONF

> From dea04e5946e8a30787943f347cf3861a8dca6008 Mon Sep 17 00:00:00 2001
> From: Ramon Pantin <pantin@google.com>
> Date: Wed, 31 Oct 2018 16:26:50 -0700
> Subject: [PATCH] recvmmsg(2) test cases
This should be removed.

> ---
>  testcases/kernel/syscalls/recvmmsg/Makefile   |   27 +
>  .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 2165 +++++++++++++++++
>  2 files changed, 2192 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/recvmmsg/Makefile
>  create mode 100644 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c

> diff --git a/testcases/kernel/syscalls/recvmmsg/Makefile b/testcases/kernel/syscalls/recvmmsg/Makefile
> new file mode 100644
> index 000000000..61b3a55e6
> --- /dev/null
> +++ b/testcases/kernel/syscalls/recvmmsg/Makefile
> @@ -0,0 +1,27 @@
> +#  Copyright (c) Google LLC, 2018
> +#  Copyright (c) International Business Machines  Corp., 2001
^ Please delete this IBM copyright.

> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
Please use just SPDX identifier instead of address:
# SPDX-License-Identifier: GPL-2.0-or-later

> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CPPFLAGS		+= -I$(abs_srcdir)/../utils
Why this include?

> +CFLAGS			= -g -std=c99
Please can you remove CFLAGS and produce code without warnings?
I'm also not sure about -std=c99. While you can grep for some -std=gnu99 in the
code, these are just some outdated comments in the source, not passed to make.

> +LDLIBS			+= -lpthread
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> new file mode 100644
> index 000000000..131bcfd66
> --- /dev/null
> +++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> @@ -0,0 +1,2165 @@
> + //  Copyright (c) Google LLC, 2018
> + //  SPDX-License-Identifier: GPL-2.0-or-later

> + //
> + //{
Why these lines?

> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <assert.h>
> +#include <sys/types.h>
> +#include <sys/time.h>
> +#include <sys/signal.h>
> +#include <sys/uio.h>
> +#include <sys/file.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <netinet/in.h>
Some of the includes will not be needed if you use API functions (SAFE_*, [5], [6]).

> +
> +// #define RECVMMSG_USE_SCTP
> +#ifdef RECVMMSG_USE_SCTP
> +#include <netinet/sctp.h>
> +#endif
Code related to RECVMMSG_USE_SCTP should be checked with autotools. There is our header
include/lapi/sctp.h, you can include it and add (in separate commit) definitions, which are needed.
If you really need netinet/sctp.h header, you can add exit clause with TST_TEST_TCONF

> +
> +#define TST_NO_DEFAULT_MAIN
You're not supposed to use this

> +#include "tst_test.h"
> +// #include "safe_macros.h"
Please remove all comments left

> +
> + //}
> + // 	Declarations.
> + //
> + //{	<-- (curly-brace match to move through major sections of this file)
Please comments like this.
Please use C style comments /* */

> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov);
> +int con_receive_iovec_boundary_checks_peeking(con_t *conp, int tn, size_t niov);
> +int con_receive_file_descriptor(con_t *conp, int tn, int cloexec_flag,
> +				bool some_data, ssize_t controllen_delta);
> +int con_message_too_long_to_fit_might_discard_bytes(con_t *conp, int tn,
> +						    int type);
> +int con_receive_waits_for_message(con_t *conp, int tn);
> +int con_receiver_doesnt_wait_for_messages(con_t *conp, int tn);
> +int con_receive_returns_what_is_available(con_t *conp, int tn);
> +int con_empty_datagram_received_as_empty_datagram(con_t *conp, int tn);
Function signatures aren't needed when used just in one file.
Actually, in this case we declare functions as static.

> + //  ensure() tests something that shouldn't fail, doesn't abort like assert()
> +
> +#define ensure(test_number, expr)					    \
> +	((expr) ? (test_verbose < 2 ||			    		    \
> +		   (print_prefix(test_number),				    \
> +		    printf("%s(): true: " #expr " \n", __FUNCTION__)))	    \
> +		: (++ensure_failures,					    \
> +		   printf("test_number = %d: %s(): false: "		    \
> +			  #expr " : failed\n",				    \
> +			  test_number, __FUNCTION__)))
We use tst_res(TINFO, ...) instead of printf.
We try to avoid macros.

> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov)
> +{
> +	size_t iov_max = iovec_max();
> +	int salt = tn + subtest_number();	// salt test data
> +
> +	int client_data[niov];
> +	iovec_t client_iov[niov];
> +	for (int i = 0; i < niov; ++i) {
int i should be defined before.

> +		client_data[i] = i + salt;
> +		iovec_init(&client_iov[i], &client_data[i],
> +			   sizeof(client_data[0]));

...


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/991864/
[2] http://lists.linux.it/pipermail/ltp/2018-November/009781.html
[3] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text
[4] https://github.com/linux-test-project/ltp/pull/414
[5] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2-writing-a-testcase)
[6] https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
