From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Nov 2018 11:52:06 +0100
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
Message-ID: <20181102105206.GA22411@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You sent your patch as an attachment.
> > Please, next time, send is at plain text,
> > as although patchwork can work with that [1], mailman can't handle it [2].
> > Here are some instructions [3].
> > Please add your Signed-off-by: tag.
> 
> I am still confused where it is that you want that to be added and what is it that it is supposed to contain?
> 
> Should I have as the first line of the patch a line that says?
> 	Signed-off-by: pantin@google.com
> If not what should it be?

See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

The process for LTP is more or less the same as for the linux kernel so
most of it applies here as well.

> >> +CFLAGS			= -g -std=c99
> > Please can you remove CFLAGS and produce code without warnings?
> 
> To be able to use ANSI C99 features on the builds from the continuous integration I have to have at least C99 enabled. The ANSI C99 standard is 19 years old, its silly to ask that the code be C89. I won???t change that. I???ll remove the ???-g???
> 
> The test code uses variable declarations intermixed with statements, a feature of C99, reorganizing the code to be compatible with a 29 year old C standard would be silly.

Actually the default for gcc is gnu90 which is close to c99 anyways, so
we do not have to do anything about it.

> > I'm also not sure about -std=c99. While you can grep for some -std=gnu99 in the
> > code, these are just some outdated comments in the source, not passed to make.
> > 
> >> +LDLIBS			+= -lpthread
> >> +
> >> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >> diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> >> new file mode 100644
> >> index 000000000..131bcfd66
> >> --- /dev/null
> >> +++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
> >> @@ -0,0 +1,2165 @@
> >> + //  Copyright (c) Google LLC, 2018
> >> + //  SPDX-License-Identifier: GPL-2.0-or-later
> > 
> >> + //
> >> + //{
> > Why these lines?
> 
> To navigate better within the source code within various areas in it.
> You go to the line and press ???%??? in vi or whatever you use to go
> to the matching curly-brace in your source code editor.

Please don't do that.

> >> +#define _GNU_SOURCE
> >> +#include <stdio.h>
> >> +#include <stdlib.h>
> >> +#include <stdbool.h>
> >> +#include <unistd.h>
> >> +#include <string.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <pthread.h>
> >> +#include <assert.h>
> >> +#include <sys/types.h>
> >> +#include <sys/time.h>
> >> +#include <sys/signal.h>
> >> +#include <sys/uio.h>
> >> +#include <sys/file.h>
> >> +#include <sys/socket.h>
> >> +#include <sys/un.h>
> >> +#include <netinet/in.h>
> > Some of the includes will not be needed if you use API functions (SAFE_*, [5], [6]).
> 
> I???d rather base the test cases on standard UNIX system calls (Linux is mostly UNIX compliant), there is no value in using non standard APIs which I don???t want to have to bother learning about.

These are not non-standard APIs, these are just tiny wrappers around
standard UNIX apis that handle failures automatically, which greatly
simplifies the test code.

> >> +// #define RECVMMSG_USE_SCTP
> >> +#ifdef RECVMMSG_USE_SCTP
> >> +#include <netinet/sctp.h>
> >> +#endif
> > Code related to RECVMMSG_USE_SCTP should be checked with autotools. There is our header
> > include/lapi/sctp.h, you can include it and add (in separate commit) definitions, which are needed.
> > If you really need netinet/sctp.h header, you can add exit clause with TST_TEST_TCONF
> 
> I???ll address this later with a later patch. For now it causes no harm. Right?

Sure.

> >> +
> >> +#define TST_NO_DEFAULT_MAIN
> > You're not supposed to use this
> > 
> 
> Its there for a reason. I have my own main() program, main() is
> standard and part of C, don???t want to learn about some other stuff
> unrelated to what I am testing. In UNIX programs start in main()
> right?

If you are writing LTP test you are not supposed to define main().

Seriously you just need to write the function that does the test and
that's it. Plese do not fight the infrastructure that is there to help
you and to make your life easier.

> >> +int con_receive_iovec_boundary_checks(con_t *conp, int tn, size_t niov);
> >> +int con_receive_iovec_boundary_checks_peeking(con_t *conp, int tn, size_t niov);
> >> +int con_receive_file_descriptor(con_t *conp, int tn, int cloexec_flag,
> >> +				bool some_data, ssize_t controllen_delta);
> >> +int con_message_too_long_to_fit_might_discard_bytes(con_t *conp, int tn,
> >> +						    int type);
> >> +int con_receive_waits_for_message(con_t *conp, int tn);
> >> +int con_receiver_doesnt_wait_for_messages(con_t *conp, int tn);
> >> +int con_receive_returns_what_is_available(con_t *conp, int tn);
> >> +int con_empty_datagram_received_as_empty_datagram(con_t *conp, int tn);
> > Function signatures aren't needed when used just in one file.
> > Actually, in this case we declare functions as static.
> 
> The ARE required unless you reorganize you code to be all in the order of called functions preceding called functions, which is silly. Furthermore if there were mutually recursive functions you couldn???t do that either.
> 
> Having ???static??? for internal functions only matters if the test program is more than one source file. This is just one file. Its easier to debug when the symbols are visible to the debugger, with some compilers ???static??? functions can not be debugged because the symbols end up not being in the symbol table.

Actually neither of that is true.

Having static defined tells the compiler that the function is used only
in the local file, which can for example tell you that some of the
functions are unused.

> >> + //  ensure() tests something that shouldn't fail, doesn't abort like assert()
> >> +
> >> +#define ensure(test_number, expr)					    \
> >> +	((expr) ? (test_verbose < 2 ||			    		    \
> >> +		   (print_prefix(test_number),				    \
> >> +		    printf("%s(): true: " #expr " \n", __FUNCTION__)))	    \
> >> +		: (++ensure_failures,					    \
> >> +		   printf("test_number = %d: %s(): false: "		    \
> >> +			  #expr " : failed\n",				    \
> >> +			  test_number, __FUNCTION__)))
> > We use tst_res(TINFO, ...) instead of printf.
> > We try to avoid macros.
> 
> Because printf() is documented. You use macros when there is no other choice. For example when you need to stringify something for example with the #expr above, when you want to use __FUNCTION__, __FILE__, and __LINE__, etc.

Plase do not use macros like that also the __FILE__ and __LINE__ is
printed by the tst_res() itself. Please do not reinvent the wheel and
use the standard LTP reporting API.

-- 
Cyril Hrubis
chrubis@suse.cz
