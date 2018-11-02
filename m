From: Ramon Pantin <pantin@google.com>
Date: Thu, 1 Nov 2018 17:13:01 -0700
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <20181101113857.GB22042@dell5510>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
Message-ID: <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Please see below. Before I email another patch please advise about my response below to each one of your individual items of feedback.

> On Nov 1, 2018, at 4:38 AM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Hi Ramon,
> 
> thank you for moving from github pull request to mailing list.
> 
>> Per Rafael's earlier email about how to proceed, find attached the path with
>> the test cases.
> You sent your patch as an attachment.
> Please, next time, send is at plain text,
> as although patchwork can work with that [1], mailman can't handle it [2].
> Here are some instructions [3].
> Please add your Signed-off-by: tag.

I am still confused where it is that you want that to be added and what is it that it is supposed to contain?

Should I have as the first line of the patch a line that says?
	Signed-off-by: pantin@google.com
If not what should it be?

> 
> I've added some comments in github pull request [4], you didn't change them, so
> I repeat some of it here. But please, read the doc to provide usable patch [5] [6].
> 2165 lines for one file suggest to split file into several.

That is unnecessary, it would then require a header file. Its needless complexity.

> 
> Please have look into the to see code style (short code, easy to read, using
> SAFE_*() helpers to prevent reinventing a wheal, avoiding macros, remove comments
> which has nothing to say, ...).
> 
> LTP code varies, some is really old and ugly. But we try to include reasonably
> clean code. You can have look at this as a good example of code style:
> testcases/kernel/syscalls/inotify/inotify09.c
> 59e0a81c5 inotify07: Add test for kernel crash during event notification
> It has also TST_TEST_TCONF
> 
>> From dea04e5946e8a30787943f347cf3861a8dca6008 Mon Sep 17 00:00:00 2001
>> From: Ramon Pantin <pantin@google.com>
>> Date: Wed, 31 Oct 2018 16:26:50 -0700
>> Subject: [PATCH] recvmmsg(2) test cases
> This should be removed.

In an earlier email you asked me to use this tool:
	git format-patch 
Which I used, which put that in the patch file. Confused. What harm does that cause?

In any case I will delete those lines. You mean delete the 4 lines right?

> 
>> ---
>> testcases/kernel/syscalls/recvmmsg/Makefile   |   27 +
>> .../kernel/syscalls/recvmmsg/recvmmsg01.c     | 2165 +++++++++++++++++
>> 2 files changed, 2192 insertions(+)
>> create mode 100644 testcases/kernel/syscalls/recvmmsg/Makefile
>> create mode 100644 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> 
>> diff --git a/testcases/kernel/syscalls/recvmmsg/Makefile b/testcases/kernel/syscalls/recvmmsg/Makefile
>> new file mode 100644
>> index 000000000..61b3a55e6
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/recvmmsg/Makefile
>> @@ -0,0 +1,27 @@
>> +#  Copyright (c) Google LLC, 2018
>> +#  Copyright (c) International Business Machines  Corp., 2001
> ^ Please delete this IBM copyright.

As I said I said in an earlier email I copied the Makefile from an IBM Makefile that had that copyright.
I will find another one to copy from that uses the SPDX license identifier instead and copy from that.

> 
>> +#  This program is free software;  you can redistribute it and/or modify
>> +#  it under the terms of the GNU General Public License as published by
>> +#  the Free Software Foundation; either version 2 of the License, or
>> +#  (at your option) any later version.
>> +#
>> +#  This program is distributed in the hope that it will be useful,
>> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> +#  the GNU General Public License for more details.
>> +#
>> +#  You should have received a copy of the GNU General Public License
>> +#  along with this program;  if not, write to the Free Software
>> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> Please use just SPDX identifier instead of address:
> # SPDX-License-Identifier: GPL-2.0-or-later
> 
>> +#
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +CPPFLAGS		+= -I$(abs_srcdir)/../utils
> Why this include?

That was there in the file from the test case that I copied. I guess that was needed when using the original “test.h” (which in your earlier email you said was obsolete) so that came from that. I’ll see if it builds removing that.

> 
>> +CFLAGS			= -g -std=c99
> Please can you remove CFLAGS and produce code without warnings?

To be able to use ANSI C99 features on the builds from the continuous integration I have to have at least C99 enabled. The ANSI C99 standard is 19 years old, its silly to ask that the code be C89. I won’t change that. I’ll remove the “-g”

The test code uses variable declarations intermixed with statements, a feature of C99, reorganizing the code to be compatible with a 29 year old C standard would be silly.


> I'm also not sure about -std=c99. While you can grep for some -std=gnu99 in the
> code, these are just some outdated comments in the source, not passed to make.
> 
>> +LDLIBS			+= -lpthread
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
>> new file mode 100644
>> index 000000000..131bcfd66
>> --- /dev/null
>> +++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
>> @@ -0,0 +1,2165 @@
>> + //  Copyright (c) Google LLC, 2018
>> + //  SPDX-License-Identifier: GPL-2.0-or-later
> 
>> + //
>> + //{
> Why these lines?

To navigate better within the source code within various areas in it. You go to the line and press ‘%’ in vi or whatever you use to go to the matching curly-brace in your source code editor.

> 
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <pthread.h>
>> +#include <assert.h>
>> +#include <sys/types.h>
>> +#include <sys/time.h>
>> +#include <sys/signal.h>
>> +#include <sys/uio.h>
>> +#include <sys/file.h>
>> +#include <sys/socket.h>
>> +#include <sys/un.h>
>> +#include <netinet/in.h>
> Some of the includes will not be needed if you use API functions (SAFE_*, [5], [6]).

I’d rather base the test cases on standard UNIX system calls (Linux is mostly UNIX compliant), there is no value in using non standard APIs which I don’t want to have to bother learning about.

> 
>> +
>> +// #define RECVMMSG_USE_SCTP
>> +#ifdef RECVMMSG_USE_SCTP
>> +#include <netinet/sctp.h>
>> +#endif
> Code related to RECVMMSG_USE_SCTP should be checked with autotools. There is our header
> include/lapi/sctp.h, you can include it and add (in separate commit) definitions, which are needed.
> If you really need netinet/sctp.h header, you can add exit clause with TST_TEST_TCONF

I’ll address this later with a later patch. For now it causes no harm. Right?

> 
>> +
>> +#define TST_NO_DEFAULT_MAIN
> You're not supposed to use this
> 

Its there for a reason. I have my own main() program, main() is standard and part of C, don’t want to learn about some other stuff unrelated to what I am testing. In UNIX programs start in main() right?

>> +#include "tst_test.h"
>> +// #include "safe_macros.h"
> Please remove all comments left

I will remove that.

>> +
>> + //}
>> + // 	Declarations.
>> + //
>> + //{	<-- (curly-brace match to move through major sections of this file)
> Please comments like this.
> Please use C style comments /* */

C99 allows for // as comments. I don’t want to make the code bigger needlessly.

> 
>> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov);
>> +int con_receive_iovec_boundary_checks_peeking(con_t *conp, int tn, size_t niov);
>> +int con_receive_file_descriptor(con_t *conp, int tn, int cloexec_flag,
>> +				bool some_data, ssize_t controllen_delta);
>> +int con_message_too_long_to_fit_might_discard_bytes(con_t *conp, int tn,
>> +						    int type);
>> +int con_receive_waits_for_message(con_t *conp, int tn);
>> +int con_receiver_doesnt_wait_for_messages(con_t *conp, int tn);
>> +int con_receive_returns_what_is_available(con_t *conp, int tn);
>> +int con_empty_datagram_received_as_empty_datagram(con_t *conp, int tn);
> Function signatures aren't needed when used just in one file.
> Actually, in this case we declare functions as static.

The ARE required unless you reorganize you code to be all in the order of called functions preceding called functions, which is silly. Furthermore if there were mutually recursive functions you couldn’t do that either.

Having “static” for internal functions only matters if the test program is more than one source file. This is just one file. Its easier to debug when the symbols are visible to the debugger, with some compilers “static” functions can not be debugged because the symbols end up not being in the symbol table.

> 
>> + //  ensure() tests something that shouldn't fail, doesn't abort like assert()
>> +
>> +#define ensure(test_number, expr)					    \
>> +	((expr) ? (test_verbose < 2 ||			    		    \
>> +		   (print_prefix(test_number),				    \
>> +		    printf("%s(): true: " #expr " \n", __FUNCTION__)))	    \
>> +		: (++ensure_failures,					    \
>> +		   printf("test_number = %d: %s(): false: "		    \
>> +			  #expr " : failed\n",				    \
>> +			  test_number, __FUNCTION__)))
> We use tst_res(TINFO, ...) instead of printf.
> We try to avoid macros.

Because printf() is documented. You use macros when there is no other choice. For example when you need to stringify something for example with the #expr above, when you want to use __FUNCTION__, __FILE__, and __LINE__, etc.
> 
>> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov)
>> +{
>> +	size_t iov_max = iovec_max();
>> +	int salt = tn + subtest_number();	// salt test data
>> +
>> +	int client_data[niov];
>> +	iovec_t client_iov[niov];
>> +	for (int i = 0; i < niov; ++i) {
> int i should be defined before.

No it is not needed outside the loop.

> 
>> +		client_data[i] = i + salt;
>> +		iovec_init(&client_iov[i], &client_data[i],
>> +			   sizeof(client_data[0]));
> 
> …
> 

regards,
Ramon

> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/991864/
> [2] http://lists.linux.it/pipermail/ltp/2018-November/009781.html
> [3] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text
> [4] https://github.com/linux-test-project/ltp/pull/414
> [5] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2-writing-a-testcase)
> [6] https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181101/98f6870a/attachment-0001.html>
