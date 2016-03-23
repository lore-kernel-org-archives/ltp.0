From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 23 Mar 2016 09:44:01 -0400 (EDT)
Subject: [LTP] ld failed to link numa while compiling migrate_pages01
In-Reply-To: <CANKSX+E0VGqKd1LmRtGo5m3_zTbLfiNtsr8HCSSZUARhiZsL=A@mail.gmail.com>
References: <CANKSX+GSJ2c+1wyrEELkYvWDhYrxCthwJujAV=M-NwqsA+0wrw@mail.gmail.com>
 <288636028.13490388.1458736526587.JavaMail.zimbra@redhat.com>
 <CANKSX+E0VGqKd1LmRtGo5m3_zTbLfiNtsr8HCSSZUARhiZsL=A@mail.gmail.com>
Message-ID: <1424581221.13514495.1458740641256.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "$rik@nth" <srikanth007m@gmail.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
> Sent: Wednesday, 23 March, 2016 2:22:12 PM
> Subject: Re: [LTP] ld failed to link numa while compiling migrate_pages01
> 
> On Wed, Mar 23, 2016 at 6:05 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> >
> >
> >
> > ----- Original Message -----
> > > From: "$rik@nth" <srikanth007m@gmail.com>
> > > To: "Cyril Hrubis" <chrubis@suse.cz>
> > > Cc: ltp@lists.linux.it
> > > Sent: Wednesday, 23 March, 2016 12:45:23 PM
> > > Subject: [LTP]  ld failed to link numa while compiling migrate_pages01
> > >
> > > Hi Cyril/LTP Devs,
> > >
> > > Today i pulled few fixes from master branch [1] on top of last LTP
> > > release. While compiling i am getting below exception at
> > > migrate_pages01. Can you help in look into the issue once?
> >
> > I don't see anything suspicious in git log. If you go back to few commits
> > does the problem go away? Any chance you could bisect?
> >
> > Other than that, I'd try following:
> >
> > diff --git a/testcases/kernel/include/lib.mk b/testcases/kernel/include/
> > lib.mk
> > index f79a1c0197e3..5c97ae2c9edf 100644
> > --- a/testcases/kernel/include/lib.mk
> > +++ b/testcases/kernel/include/lib.mk
> > @@ -23,7 +23,7 @@ KERNEL_DIR            :=
> > $(abs_top_builddir)/testcases/kernel
> >  LIBKERNTEST_DIR                := $(KERNEL_DIR)/lib
> >  LIBKERNTEST            := $(LIBKERNTEST_DIR)/libkerntest.a
> >  CPPFLAGS               += $(NUMA_CPPFLAGS) -I$(KERNEL_SRCDIR)/include
> > -LDLIBS                 += $(NUMA_LIBS) -lkerntest -lltp
> > +LDLIBS                 += -lkerntest -lltp $(NUMA_LIBS)
> >  LDFLAGS                        += -L$(LIBKERNTEST_DIR)
> >
> > Thanks Jan, This revert change helped to continue the compilation.
> Haven't you faced any issue without this patch?

No, I haven't. That LDLIBS variable hasn't changed since 2012, so
I'm curious why it started failing for you only recently.

> Just want to bisect my problem.

Let us know what you find.

> 
> >  $(LIBKERNTEST_DIR):
> >
> > Regards,
> > Jan
> >
> >
> > >
> > > make[4]: Entering directory
> > > '/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages'
> > > gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
> > > -Wold-style-definition -static
> > > -I/home/linaro/ltp-master/testcases/kernel/include
> > >
> > -I/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/../utils/
> > > -DNUMA_VERSION1_COMPATIBILITY
> > > -I/home/linaro/ltp-master/testcases/kernel/include
> > > -I../../../../include -I../../../../include  -c -o migrate_pages01.o
> > > migrate_pages01.c
> > > gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
> > > -Wold-style-definition -static
> > > -I/home/linaro/ltp-master/testcases/kernel/include
> > >
> > -I/home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/../utils/
> > > -DNUMA_VERSION1_COMPATIBILITY
> > > -I/home/linaro/ltp-master/testcases/kernel/include
> > > -I../../../../include -I../../../../include  -c -o
> > > migrate_pages_common.o migrate_pages_common.c
> > > make -C "/home/linaro/Srikanth/ltp-master/testcases/kernel/include" -f
> > > "/home/linaro/ltp-master/testcases/kernel/include/Makefile" all
> > > make[5]: Entering directory
> > > '/home/linaro/ltp-master/testcases/kernel/include'
> > > make[5]: Nothing to be done for 'all'.
> > > make[5]: Leaving directory
> > '/home/linaro/ltp-master/testcases/kernel/include'
> > > gcc -static -pthread  -L/home/linaro/ltp-master/testcases/kernel/lib
> > > -L../../../../lib  migrate_pages01.o migrate_pages_common.o   -lltp
> > > -lnuma -lkerntest -lltp -o migrate_pages01
> > > migrate_pages01.o: In function `test_invalid_perm':
> > >
> > /home/linaro/ltp-master/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c:183:
> > > warning: Using 'getpwnam' in statically linked applications requires
> > > at runtime the shared libraries from the glibc version used for
> > > linking
> > >
> > /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
> > > In function `get_max_node':
> > > /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
> > > undefined reference to `numa_max_possible_node'
> > >
> > /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
> > > In function `get_allowed_nodes_arr':
> > > /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:177:
> > > undefined reference to `numa_available'
> > >
> > /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
> > > In function `get_max_node':
> > > /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
> > > undefined reference to `numa_max_possible_node'
> > >
> > /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
> > > In function `get_allowed_nodes_arr':
> > > /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:177:
> > > undefined reference to `numa_available'
> > >
> > /home/linaro/ltp-master/testcases/kernel/lib/libkerntest.a(numa_helper.o):
> > > In function `get_max_node':
> > > /home/linaro/ltp-master/testcases/kernel/lib/numa_helper.c:53:
> > > undefined reference to `numa_max_possible_node'
> > > collect2: error: ld returned 1 exit status
> > > <builtin>: recipe for target 'migrate_pages01' failed
> > > make[4]: *** [migrate_pages01] Error 1
> > >
> > >
> > > [1] https://github.com/linux-test-project/ltp.git
> > >
> > > --
> > > Thanks & Regards,
> > > M.Srikanth Kumar.
> > >
> > > --
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> > >
> >
> 
> 
> 
> --
> Thanks & Regards,
> M.Srikanth Kumar.
> 
