Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N8WDo-000745-1A
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 09:44:08 +0000
Received: from mail-px0-f184.google.com ([209.85.216.184])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8WDc-0005Dt-Jc
	for ltp-list@lists.sourceforge.net; Thu, 12 Nov 2009 09:44:02 +0000
MIME-Version: 1.0
In-Reply-To: <1257959864.27679.17.camel@subratamodak.linux.ibm.com>
References: <1257788381.7677.73.camel@subratamodak.linux.ibm.com>
	<364299f40911091039q11529ec1m4583ac18d0ee4bf4@mail.gmail.com>
	<1257926367.27679.0.camel@subratamodak.linux.ibm.com>
	<364299f40911110911p6abfb290nddbfeb7be00f2de@mail.gmail.com>
	<1257959864.27679.17.camel@subratamodak.linux.ibm.com>
Date: Thu, 12 Nov 2009 01:43:50 -0800
Message-ID: <364299f40911120143g1a98de3fxa1284ed456d81b30@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] get_mempolicy01, mbind01,
	move_pages01 & ptrace04 compile 	failures with latest CVS
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Mike Frysinger <vapier@gentoo.org>

On Wed, Nov 11, 2009 at 9:17 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-11-11 at 09:11 -0800, Garrett Cooper wrote:
>> On Tue, Nov 10, 2009 at 11:59 PM, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>> > On Mon, 2009-11-09 at 10:39 -0800, Garrett Cooper wrote:
>> >> On Mon, Nov 9, 2009 at 9:39 AM, Subrata Modak
>> >> <subrata@linux.vnet.ibm.com> wrote:
>> >> > Garret,
>> >> >
>> >> > Can you please look into these errors occurring on my below system
>> >> > configuration:
>> >> >
>> >> > # uname -a
>> >> > Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i=
386
>> >> > GNU/Linux
>> >> >
>> >> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> >> > -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER=
_2009_RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I../../..=
/../include -I../../../../include =A0 -L../../../../lib =A0get_mempolicy01.=
c =A0 -lltp -o get_mempolicy01
>> >> > get_mempolicy01.c:59:25: error: include_j_h.h: No such file or dire=
ctory
>> >> > get_mempolicy01.c:60:24: error: common_j_h.c: No such file or direc=
tory
>> >> > get_mempolicy01.c: In function =91do_test=92:
>> >> > get_mempolicy01.c:274: error: =91RESULT_OK=92 undeclared (first use=
 in this
>> >> > function)
>> >> > get_mempolicy01.c:274: error: (Each undeclared identifier is report=
ed
>> >> > only once
>> >> > get_mempolicy01.c:274: error: for each function it appears in.)
>> >> > get_mempolicy01.c:276: error: =91nodemask_t=92 undeclared (first us=
e in this
>> >> > function)
>> >> > get_mempolicy01.c:276: error: expected =91;=92 before =91nodemask=
=92
>> >> > get_mempolicy01.c:277: error: =91NUMA_NUM_NODES=92 undeclared (firs=
t use in
>> >> > this function)
>> >> > get_mempolicy01.c:282: warning: implicit declaration of function
>> >> > =91nodemask_zero=92
>> >> > get_mempolicy01.c:282: error: =91nodemask=92 undeclared (first use =
in this
>> >> > function)
>> >> > get_mempolicy01.c:283: warning: implicit declaration of function
>> >> > =91nodemask_set=92
>> >> > get_mempolicy01.c:284: error: =91getnodemask=92 undeclared (first u=
se in
>> >> > this function)
>> >> > get_mempolicy01.c:338: warning: implicit declaration of function
>> >> > =91nodemask_equal=92
>> >> > get_mempolicy01.c:340: warning: implicit declaration of function
>> >> > =91nodemask_dump=92
>> >> > get_mempolicy01.c:349: warning: implicit declaration of function
>> >> > =91PRINT_RESULT_CMP=92
>> >> > make[4]: *** [get_mempolicy01] Error 1
>> >>
>> >> Eh... not sure how that one happened. When did you pull from CVS?
>> >>
>> >> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> >> > -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER=
_2009_RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I/home/su=
bratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RELEASE/ltp-=
intermediate-20091109/testcases/kernel/syscalls/mbind/../utils/ -I../../../=
../include -I../../../../include =A0 -L../../../../lib =A0mbind01.c =A0 -ll=
tp -o mbind01
>> >> > In file included from mbind01.c:62:
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../ut=
ils/numaif.h:40: error: conflicting types for =91nodemask_t=92
>> >> > /usr/include/numa.h:39: note: previous declaration of =91nodemask_t=
=92 was
>> >> > here
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../ut=
ils/numaif.h:42: error: conflicting types for =91nodemask_zero=92
>> >> > /usr/include/numa.h:61: note: previous definition of =91nodemask_ze=
ro=92 was
>> >> > here
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../ut=
ils/numaif.h:69: error: conflicting types for =91nodemask_equal=92
>> >> > /usr/include/numa.h:66: note: previous definition of =91nodemask_eq=
ual=92
>> >> > was here
>> >> > mbind01.c: In function =91main=92:
>> >> > mbind01.c:368: warning: unused variable =91result=92
>> >> > make[4]: *** [mbind01] Error 1
>> >>
>> >> Should be resolved now.
>> >>
>> >> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> >> > -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER=
_2009_RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I/home/su=
bratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RELEASE/ltp-=
intermediate-20091109/testcases/kernel/syscalls/move_pages/../utils -I../..=
/../../include -I../../../../include =A0-c -o move_pages01.o move_pages01.c
>> >> > In file included from move_pages_support.h:22,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from move_pages01.c:63:
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/=
../utils/numaif.h:40: error: conflicting types for =91nodemask_t=92
>> >> > /usr/include/numa.h:39: note: previous declaration of =91nodemask_t=
=92 was
>> >> > here
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/=
../utils/numaif.h:42: error: conflicting types for =91nodemask_zero=92
>> >> > /usr/include/numa.h:61: note: previous definition of =91nodemask_ze=
ro=92 was
>> >> > here
>> >> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2=
009_RELEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/=
../utils/numaif.h:69: error: conflicting types for =91nodemask_equal=92
>> >> > /usr/include/numa.h:66: note: previous definition of =91nodemask_eq=
ual=92
>> >> > was here
>> >> > make[4]: *** [move_pages01.o] Error 1
>> >>
>> >> Should be resolved now.
>> >>
>> >> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> >> > -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER=
_2009_RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I../../..=
/../include -I../../../../include =A0 -L../../../../lib =A0ptrace04.c =A0 -=
lltp -o ptrace04
>> >> > ptrace04.c: In function =91compare_registers=92:
>> >> > ptrace04.c:51: error: storage size of =91pt_regs=92 isn=92t known
>> >> > ptrace04.c:51: warning: unused variable =91pt_regs=92
>> >> > make[4]: *** [ptrace04] Error 1
>> >>
>> >> Fixed (I think). Please repull and retry.
>> >
>> > get_mempolicy01 and mbind01 is still failing:
>> >
>> > get_mempolicy01.c: In function =91do_test=92:
>> > get_mempolicy01.c:282: warning: passing argument 1 of =91nodemask_zero=
=92
>> > from incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > get_mempolicy01.c:283: warning: implicit declaration of function
>> > =91nodemask_set=92
>> > get_mempolicy01.c:284: warning: passing argument 1 of =91nodemask_zero=
=92
>> > from incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > get_mempolicy01.c:337: warning: passing argument 1 of =91nodemask_zero=
=92
>> > from incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > get_mempolicy01.c:338: warning: passing argument 1 of =91nodemask_equa=
l=92
>> > from incompatible pointer type
>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > get_mempolicy01.c:338: warning: passing argument 2 of =91nodemask_equa=
l=92
>> > from incompatible pointer type
>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > /tmp/ccd0Utpg.o: In function `nodemask_zero':
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > /tmp/ccd0Utpg.o: In function `do_test':
>> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009=
_RELEASE/ltp-intermediate-20091110/testcases/kernel/syscalls/get_mempolicy/=
get_mempolicy01.c:283: undefined reference to `nodemask_set'
>> > /tmp/ccd0Utpg.o: In function `nodemask_zero':
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > /tmp/ccd0Utpg.o: In function `nodemask_equal':
>> > /usr/include/numa.h:68: undefined reference to `numa_bitmask_equal'
>> > collect2: ld returned 1 exit status
>> > make[4]: *** [get_mempolicy01] Error 1
>> >
>> >
>> > mbind01.c: In function =91do_test=92:
>> > mbind01.c:271: warning: passing argument 1 of =91nodemask_zero=92 from
>> > incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > mbind01.c:272: warning: implicit declaration of function =91nodemask_s=
et=92
>> > mbind01.c:273: warning: passing argument 1 of =91nodemask_zero=92 from
>> > incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > mbind01.c:315: warning: passing argument 1 of =91nodemask_zero=92 from
>> > incompatible pointer type
>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > mbind01.c:319: warning: passing argument 1 of =91nodemask_equal=92 from
>> > incompatible pointer type
>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > mbind01.c:319: warning: passing argument 2 of =91nodemask_equal=92 from
>> > incompatible pointer type
>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argu=
ment
>> > is of type =91struct nodemask_t *=92
>> > /tmp/ccCibXJV.o: In function `nodemask_zero':
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > /tmp/ccCibXJV.o: In function `do_test':
>> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009=
_RELEASE/ltp-intermediate-20091110/testcases/kernel/syscalls/mbind/mbind01.=
c:272: undefined reference to `nodemask_set'
>> > /tmp/ccCibXJV.o: In function `nodemask_zero':
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > /tmp/ccCibXJV.o: In function `nodemask_equal':
>> > /usr/include/numa.h:68: undefined reference to `numa_bitmask_equal'
>> > /tmp/ccCibXJV.o: In function `nodemask_zero':
>> > /usr/include/numa.h:63: undefined reference to `numa_bitmask_clearall'
>> > collect2: ld returned 1 exit status
>> > make[4]: *** [mbind01] Error 1
>>
>> More numa.h vs numa_if.h fun... what version of Linux are you running Su=
brata?
>
> # uname -a
> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
>
> RHEL 5.2

Ok. Installing RHEL now and will have a solution by 6am PST I hope..
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
