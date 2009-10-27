Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N2v7X-0002ff-5C
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 23:06:31 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N2v7E-0006mq-Of
	for ltp-list@lists.sourceforge.net; Tue, 27 Oct 2009 23:06:21 +0000
Received: by pwj6 with SMTP id 6so459987pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Oct 2009 16:06:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <op.u2dtmvt9u2flwt@debian>
References: <op.u00vt9vju2flwt@debian>
	<1255436013.8438.34.camel@subratamodak.linux.ibm.com>
	<1255890120.5359.18.camel@subratamodak.linux.ibm.com>
	<op.u2dtmvt9u2flwt@debian>
Date: Tue, 27 Oct 2009 16:06:06 -0700
Message-ID: <364299f40910271606v243bfa53l30f2c8c33616d8ae@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] New test?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

2009/10/25 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> On Sun, 18 Oct 2009 20:22:00 +0200, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>
>> Jiri,
>>
>> Any further thoughts on this ?
>
> Yes, see the attachment.
>
> I created the directories for the different tests (rt_sigtimedwait,
> sigwaitinfo etc.), but to avoid copy-pasting the code, they share the same
> source. Please, tell me if that is OK.

I'm a bit confused by let me help analyze the Makefile and provide critique=
s:

The basic template for any Makefile now, is as follows:

# LICENSING TORT, e.g. GPLv2 License, etc.

# <TOP-SRCDIR DEFINITION>

# <PRE-INCLUDE>

# <ADDITIONAL MAKE LOGIC GOES HERE>

# <POST-INCLUDE>

The description of these components is as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
TOP-SRCDIR DEFINITION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
top_srcdir ?=3D <relative path from current Makefile to the top of the
source tree>

Example 1 (say, from testcases/realtime):

top_srcdir ?=3D ../..

Example 2 (say, from lib):

top_srcdir ?=3D ..

The ?=3D is important, because this value can be redefined at ANY time
-- I've been considering making this assignment operator :=3D though,
because it should be set just once per Makefile, and isn't being
exported anymore (it was a design mistake I made in the beginning that
Mike F. corrected me because I wasn't adhering to correct autotools
variable conventions).

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
PRE-INCLUDE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is important, and may lead to potential confusion.

env_pre.mk is used for most includes outside of the testcases portion
of the tree. This has a minimal set of assumptions and dependent
targets, because it's designed to work with doc, lib, tools, and
utils. This can also be used in `trunk' situations (discussed below)
where no C-files need to be compiled, and/or linked in with libltp.a.
This also adds $(abs_top_srcdir)/include to the CPPFLAGS so you don't
need to add this to 300+ Makefiles (like it was before :)...].

testcases.mk is used for rest of the cases under testcases. It does
the following for you:
1. Everything in env_pre.mk.
2. Adds dependencies for libltp.a.
3. Adds -lltp to LDLIBS.
4. Adds dependencies for testcases/kernel/include/syscall_numbers.h
5. Adds an optional hook for the tst_res apps in tools/apicmds so you
can run your tests out of the local directory before install [assuming
they're coded properly :)...].

All of the additional steps are done for developer convenience, so
that running make install from testcases/kernel/syscalls/open doesn't
require that I manually go into lib/ and testcases/kernel/include
beforehand and run a make all, and have to duplicate a lot of
unnecessary logic in the Makefiles.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
ADDITIONAL MAKE LOGIC GOES HERE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Whatever you want to put in here that isn't provided with the defaults
in env_post.mk, generic_leaf_target.inc, or generic_trunk_target.inc,
so feel free to `use your imagination' as to whatever you may put in
here, but the only cases that you should have to deal with are:

1. Multiple C files / objects -> one or more executables.
2. Items without implicit rule mappings, e.g. .c -> .o.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
POST-INCLUDE:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

- For all directory traversing Makefiles you include the `trunk
target' Makefile:

include $(top_srcdir)/include/mk/generic_trunk_target.mk

- For all non-directory traversing Makefiles, you include the `leaf
target' Makefile.

include $(top_srcdir)/include/mk/generic_leaf_target.mk

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Now, to critique your proposed Makefiles...

testcases/kernel/syscalls/rt_sigtimedwait/Makefile:

+CFLAGS +=3D -I../../../../include -Wall -O2 -DTEST_RT_SIGTIMEDWAIT
+LDLIBS +=3D -L../../../../lib -lltp
+
+SRCS    =3D $(wildcard *.c)
+TARGETS =3D $(patsubst %.c,%,$(SRCS)) rt_sigtimedwait01
+
+all: $(TARGETS)
+
+rt_sigtimedwait01.o: ../sigwaitinfo/sigwaitinfo01.c
+	$(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $^
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
+
+clean:
+	rm -f $(TARGETS)

Given the above explanation, I would write this like the following
(minus the licensing tort, and with improper indented vars -- bloody
GMail :(...):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
top_srcdir ?=3D ../../../..

include $(top_srcdir)/include/mk/testcases.mk

# NOTE: Placement doesn't matter, but for readability and consistency
it should go here.
CPPFLAGS +=3D -DTEST_RT_SIGTIMEDWAIT

# NOTE: Placement for this Make target doesn't matter... just so long
as it's defined in the Makefile.
rt_sigtimedwait01: $(abs_srcdir)/../sigwaitinfo/sigwaitinfo01.c
	$(COMPILE.o) $(OUTPUT_OPTION) $^

# NOTE: Don't modify MAKE_TARGETS here because it isn't set yet, and
the default is to pick up all existing C files in the
# current directory and make them into single-source executables, e.g.
# sigwaitinfo01.c -> sigwaitinfo01.o -> sigwaitinfo01 ;)...

include $(top_srcdir)/include/mk/generic_leaf_target.mk

MAKE_TARGETS +=3D rt_sigtimedwait01
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Similar logic would be applied to your other Makefile, minus the
CPPFLAGS assignment.

Please note that your binary is no longer linked into
$(abs_top_builddir)/testcases/bin -- it's instead install(1)'ed
directly into $(DESTDIR)/$(prefix)/testcases/bin . This was done to
facilitate proper installation by using the correct mode, and also to
avoid broken/hacky symlinking operations.

Hope that helps describe things a bit better... let me know if I
should add this to a README or something...

Cheers!
-Garrett

>> On Tue, 2009-10-13 at 17:43 +0530, Subrata Modak wrote:
>>>
>>> Hey Jiri,
>>>
>>> On Tue, 2009-09-29 at 16:28 +0200, Ji=F8=ED Pale=E8ek wrote:
>>> > Hello,
>>> >
>>> > I've decided to create a test for the rt_sigwaitinfo syscall. There a=
re
>>> > other functions with similar interface (defined by POSIX) in libc -
>>> > particularly sigwait, sigtimedwait and sigwaitinfo. The rt_sigwaitinfo
>>>
>>> The sigwait, sigtimedwait and sigwaitinfo testcases are not in LTP.
>>>
>>> > test could easily tests these too, so I wonder whether we want to test
>>> > these too, and if yes, whether these tests can be located in the same
>>> > executable.
>>>
>>> If you already have the logic to write the above tests, then please
>>> create separate tests for sigwait, sigtimedwait and sigwaitinfo
>>> (separate directories as well), and separate for rt_sigwaitinfo syscall.

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
