Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7Z9F-0001I2-A0
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 18:39:29 +0000
Received: from mail-px0-f177.google.com ([209.85.216.177])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7Z98-00053f-UZ
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 18:39:29 +0000
MIME-Version: 1.0
In-Reply-To: <1257788381.7677.73.camel@subratamodak.linux.ibm.com>
References: <1257788381.7677.73.camel@subratamodak.linux.ibm.com>
Date: Mon, 9 Nov 2009 10:39:17 -0800
Message-ID: <364299f40911091039q11529ec1m4583ac18d0ee4bf4@mail.gmail.com>
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

On Mon, Nov 9, 2009 at 9:39 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> Can you please look into these errors occurring on my below system
> configuration:
>
> # uname -a
> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
> GNU/Linux
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_=
RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I../../../../in=
clude -I../../../../include =A0 -L../../../../lib =A0get_mempolicy01.c =A0 =
-lltp -o get_mempolicy01
> get_mempolicy01.c:59:25: error: include_j_h.h: No such file or directory
> get_mempolicy01.c:60:24: error: common_j_h.c: No such file or directory
> get_mempolicy01.c: In function =91do_test=92:
> get_mempolicy01.c:274: error: =91RESULT_OK=92 undeclared (first use in th=
is
> function)
> get_mempolicy01.c:274: error: (Each undeclared identifier is reported
> only once
> get_mempolicy01.c:274: error: for each function it appears in.)
> get_mempolicy01.c:276: error: =91nodemask_t=92 undeclared (first use in t=
his
> function)
> get_mempolicy01.c:276: error: expected =91;=92 before =91nodemask=92
> get_mempolicy01.c:277: error: =91NUMA_NUM_NODES=92 undeclared (first use =
in
> this function)
> get_mempolicy01.c:282: warning: implicit declaration of function
> =91nodemask_zero=92
> get_mempolicy01.c:282: error: =91nodemask=92 undeclared (first use in this
> function)
> get_mempolicy01.c:283: warning: implicit declaration of function
> =91nodemask_set=92
> get_mempolicy01.c:284: error: =91getnodemask=92 undeclared (first use in
> this function)
> get_mempolicy01.c:338: warning: implicit declaration of function
> =91nodemask_equal=92
> get_mempolicy01.c:340: warning: implicit declaration of function
> =91nodemask_dump=92
> get_mempolicy01.c:349: warning: implicit declaration of function
> =91PRINT_RESULT_CMP=92
> make[4]: *** [get_mempolicy01] Error 1

Eh... not sure how that one happened. When did you pull from CVS?

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_=
RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I/home/subratam=
odak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RELEASE/ltp-interm=
ediate-20091109/testcases/kernel/syscalls/mbind/../utils/ -I../../../../inc=
lude -I../../../../include =A0 -L../../../../lib =A0mbind01.c =A0 -lltp -o =
mbind01
> In file included from mbind01.c:62:
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../utils/nu=
maif.h:40: error: conflicting types for =91nodemask_t=92
> /usr/include/numa.h:39: note: previous declaration of =91nodemask_t=92 was
> here
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../utils/nu=
maif.h:42: error: conflicting types for =91nodemask_zero=92
> /usr/include/numa.h:61: note: previous definition of =91nodemask_zero=92 =
was
> here
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/mbind/../utils/nu=
maif.h:69: error: conflicting types for =91nodemask_equal=92
> /usr/include/numa.h:66: note: previous definition of =91nodemask_equal=92
> was here
> mbind01.c: In function =91main=92:
> mbind01.c:368: warning: unused variable =91result=92
> make[4]: *** [mbind01] Error 1

Should be resolved now.

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_=
RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I/home/subratam=
odak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RELEASE/ltp-interm=
ediate-20091109/testcases/kernel/syscalls/move_pages/../utils -I../../../..=
/include -I../../../../include =A0-c -o move_pages01.o move_pages01.c
> In file included from move_pages_support.h:22,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from move_pages01.c:63:
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/../uti=
ls/numaif.h:40: error: conflicting types for =91nodemask_t=92
> /usr/include/numa.h:39: note: previous declaration of =91nodemask_t=92 was
> here
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/../uti=
ls/numaif.h:42: error: conflicting types for =91nodemask_zero=92
> /usr/include/numa.h:61: note: previous definition of =91nodemask_zero=92 =
was
> here
> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_RE=
LEASE/ltp-intermediate-20091109/testcases/kernel/syscalls/move_pages/../uti=
ls/numaif.h:69: error: conflicting types for =91nodemask_equal=92
> /usr/include/numa.h:66: note: previous definition of =91nodemask_equal=92
> was here
> make[4]: *** [move_pages01.o] Error 1

Should be resolved now.

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_TARS/OCTOBER_2009_=
RELEASE/ltp-intermediate-20091109/testcases/kernel/include -I../../../../in=
clude -I../../../../include =A0 -L../../../../lib =A0ptrace04.c =A0 -lltp -=
o ptrace04
> ptrace04.c: In function =91compare_registers=92:
> ptrace04.c:51: error: storage size of =91pt_regs=92 isn=92t known
> ptrace04.c:51: warning: unused variable =91pt_regs=92
> make[4]: *** [ptrace04] Error 1

Fixed (I think). Please repull and retry.

Thanks,
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
