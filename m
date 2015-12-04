From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Dec 2015 08:19:55 -0500 (EST)
Subject: [LTP] {get|set}_thread_area issue on ARM
In-Reply-To: <20151204130241.GA21840@yury-N73SV>
References: <20151204034711.GA27222@yury-N73SV>
 <1947123407.23593898.1449220837874.JavaMail.zimbra@redhat.com>
 <20151204130241.GA21840@yury-N73SV>
Message-ID: <1049557228.23712541.1449235195348.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Yury Norov" <ynorov@caviumnetworks.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "David Howells" <dhowells@redhat.com>
> Sent: Friday, 4 December, 2015 2:02:41 PM
> Subject: Re: [LTP] {get|set}_thread_area issue on ARM
> 
> On Fri, Dec 04, 2015 at 04:20:37AM -0500, Jan Stancek wrote:
> > 
> > 
> > 
> > 
> > ----- Original Message -----
> > > From: "Yury Norov" <ynorov@caviumnetworks.com>
> > > To: ltp@lists.linux.it
> > > Cc: "David Howells" <dhowells@redhat.com>
> > > Sent: Friday, 4 December, 2015 4:47:11 AM
> > > Subject: [LTP] {get|set}_thread_area issue on ARM
> > > 
> > > Hi all,
> > > 
> > > I just tried build ltp for arm, and one (maybe, first of) test failed
> > > build. Namely, set_thread_area01.c
> > > 
> > > The reason is that __NR_set_thread_area and __NR_get_thread_area are
> > > not declared. They should come from
> > > /usr/arm-linux-gnueabi/include/asm/unistd.h
> > > But there's only:
> > > [...]
> > > #define __NR_remap_file_pages           (__NR_SYSCALL_BASE+253)
> > >                                          /* for set_thread_area */
> > >                                          /* for get_thread_area */
> > > #define __NR_set_tid_address            (__NR_SYSCALL_BASE+256)
> > > [...]
> > > 
> > > In kernel, there are stubs for corresponding syscall numbers. So it
> > > looks like this pair is deprecated and unsupported. I can build ltp
> > > for aarch64 and x84_64 just fine.
> > 
> > Looking at history, it appears it was never supported.
> > 
> > > 
> > > Could someone explain me what am I doing wrong?
> > 
> > Can you try to add:
> >   #include "linux_syscall_numbers.h"
> > to testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
> > and see if it compiles. And when you run it, it should end with TCONF.
> > 
> > Regards,
> > Jan
> 
> Hi Jan,
> 
> It doesn't help much. The problem is not in that ltp doesn't know
> symbols, but because they are identical - both are -1.
>   (__LTP__NR_INVALID_SYSCALL)

Hi,

That was expected.

> 
> And gcc treats is as an error:
> arm-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -W -g -O2 -Wold-style-definition
> -I/home/yury/work/ltp/testcases/kernel/include -I../../../../include
> -I../../../../include -Wl,--rpath=/root/lib32
> -Wl,--dynamic-linker=/root/lib32/ld-2.21.so  -L../../../../lib
> set_thread_area01.c   -lltp -o set_thread_area01
> set_thread_area01.c: In function ?get_name?:
> set_thread_area01.c:70:2: error: duplicate case value
>   case __NR_get_thread_area:
>   ^
> set_thread_area01.c:67:2: error: previously used here
>   case __NR_set_thread_area:
>   ^
> set_thread_area01.c: In function ?main?:
> set_thread_area01.c:87:17: warning: comparison between signed
> and unsigned integer expressions [-Wsign-compare]
>    for (i = 0; i < sizeof(tests) / sizeof(struct test); i++) {
>                  ^
> <builtin>: recipe for target 'set_thread_area01' failed

This wasn't - I didn't realize they are used in switch.

I suggest to remove the get_name() function and store names
in struct test (with some macro to stringify those syscall __NR_#).

Would you care to send a patch?

> 
> BTW, I forgot to mention, if I "uncomment" that definitions in system
> headers, everything becomes fine.

I assume you still get TCONF when you run it, because kernel should
return ENOSYS for both.

Regards,
Jan

> 
> Preprocessed sources for arm and x86_64 are attached.
> 
> BR,
> Yury.
> 
> 
> 
