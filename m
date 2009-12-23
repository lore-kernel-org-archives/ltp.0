Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NNFPU-0006XD-5s
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 00:49:04 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NNFPM-0001Ty-A5
	for ltp-list@lists.sourceforge.net; Wed, 23 Dec 2009 00:49:04 +0000
Received: by pzk31 with SMTP id 31so4500761pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Dec 2009 16:48:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40912221618m46d9976ekcb2f902549aeb79d@mail.gmail.com>
References: <1261387627.4928.1.camel@subratamodak.linux.ibm.com>
	<1261388501.4928.3.camel@subratamodak.linux.ibm.com>
	<1261396599.4928.7.camel@subratamodak.linux.ibm.com>
	<364299f40912211847n5e4977an641f48a1ef4976ef@mail.gmail.com>
	<364299f40912221618m46d9976ekcb2f902549aeb79d@mail.gmail.com>
Date: Tue, 22 Dec 2009 16:18:51 -0800
Message-ID: <364299f40912221618m1f582566kd5fcb2d3042bc861@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Fwd: get_mempolicy01 build failure in CVS
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
To: LTP list <ltp-list@lists.sourceforge.net>

FYI...

---------- Forwarded message ----------
From: Garrett Cooper <yanegomi@gmail.com>
Date: Tue, Dec 22, 2009 at 4:18 PM
Subject: Re: get_mempolicy01 build failure in CVS
To: subrata@linux.vnet.ibm.com


On Mon, Dec 21, 2009 at 6:47 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Mon, Dec 21, 2009 at 3:56 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>> However, apart from this, the other issues of build error when trying to
>> compile LTP from 2 different locations in the same machine seems fixed
>> w.r.t the libcontrollers and linsctp.
>>
>> Can you just look into the below 2 build errors ?
>>
>> Regards--
>> Subrata
>>
>> On Mon, 2009-12-21 at 15:11 +0530, Subrata Modak wrote:
>>> This as well:
>>>
>>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>>> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSHOT=
S/21_DECEMBER_2009/ltp-intermediate-20091221/testcases/kernel/include -I/ho=
me/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSHOTS/21_DECE=
MBER_2009/ltp-intermediate-20091221/testcases/kernel/syscalls/mbind/../util=
s/ -I../../../../include -I../../../../include =A0 -L../../../../lib =A0mbi=
nd01.c =A0 -lltp -lnuma -o mbind01
>>> mbind01.c: In function =91do_test=92:
>>> mbind01.c:271: warning: passing argument 1 of =91nodemask_zero=92 from
>>> incompatible pointer type
>>> /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argum=
ent
>>> is of type =91struct nodemask_t *=92
>>> mbind01.c:272: warning: implicit declaration of function =91nodemask_se=
t=92
>>> mbind01.c:273: warning: passing argument 1 of =91nodemask_zero=92 from
>>> incompatible pointer type
>>> /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argum=
ent
>>> is of type =91struct nodemask_t *=92
>>> mbind01.c:315: warning: passing argument 1 of =91nodemask_zero=92 from
>>> incompatible pointer type
>>> /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but argum=
ent
>>> is of type =91struct nodemask_t *=92
>>> mbind01.c:319: warning: passing argument 1 of =91nodemask_equal=92 from
>>> incompatible pointer type
>>> /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argum=
ent
>>> is of type =91struct nodemask_t *=92
>>> mbind01.c:319: warning: passing argument 2 of =91nodemask_equal=92 from
>>> incompatible pointer type
>>> /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but argum=
ent
>>> is of type =91struct nodemask_t *=92
>>> /tmp/ccIMfEh8.o: In function `do_test':
>>> /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSHOTS/=
21_DECEMBER_2009/ltp-intermediate-20091221/testcases/kernel/syscalls/mbind/=
mbind01.c:272: undefined reference to `nodemask_set'
>>> collect2: ld returned 1 exit status
>>> make[4]: *** [mbind01] Error 1
>>>
>>> Regards--
>>> Subrata
>>>
>>> On Mon, 2009-12-21 at 14:57 +0530, Subrata Modak wrote:
>>> > Garret,
>>> >
>>> > This still exists:
>>> >
>>> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>>> > -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSH=
OTS/21_DECEMBER_2009/ltp-intermediate-20091221/testcases/kernel/include -I/=
home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSHOTS/21_DE=
CEMBER_2009/ltp-intermediate-20091221/testcases/kernel/syscalls/get_mempoli=
cy/../utils -I../../../../include -I../../../../include =A0 -L../../../../l=
ib =A0get_mempolicy01.c =A0 -lltp -lnuma -o get_mempolicy01
>>> > get_mempolicy01.c: In function =91do_test=92:
>>> > get_mempolicy01.c:282: warning: passing argument 1 of =91nodemask_zer=
o=92
>>> > from incompatible pointer type
>>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but arg=
ument
>>> > is of type =91struct nodemask_t *=92
>>> > get_mempolicy01.c:283: warning: implicit declaration of function
>>> > =91nodemask_set=92
>>> > get_mempolicy01.c:284: warning: passing argument 1 of =91nodemask_zer=
o=92
>>> > from incompatible pointer type
>>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but arg=
ument
>>> > is of type =91struct nodemask_t *=92
>>> > get_mempolicy01.c:337: warning: passing argument 1 of =91nodemask_zer=
o=92
>>> > from incompatible pointer type
>>> > /usr/include/numa.h:61: note: expected =91struct bitmask *=92 but arg=
ument
>>> > is of type =91struct nodemask_t *=92
>>> > get_mempolicy01.c:338: warning: passing argument 1 of =91nodemask_equ=
al=92
>>> > from incompatible pointer type
>>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but arg=
ument
>>> > is of type =91struct nodemask_t *=92
>>> > get_mempolicy01.c:338: warning: passing argument 2 of =91nodemask_equ=
al=92
>>> > from incompatible pointer type
>>> > /usr/include/numa.h:66: note: expected =91struct bitmask *=92 but arg=
ument
>>> > is of type =91struct nodemask_t *=92
>>> > /tmp/ccGgUpUU.o: In function `do_test':
>>> > /home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_NIGHTLY_SNAPSHOT=
S/21_DECEMBER_2009/ltp-intermediate-20091221/testcases/kernel/syscalls/get_=
mempolicy/get_mempolicy01.c:283: undefined reference to `nodemask_set'
>>> > collect2: ld returned 1 exit status
>>> > make[4]: *** [get_mempolicy01] Error 1
>>> >
>>> > # uname -a
>>> > Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
>>> > GNU/Linux
>>> > # cat /etc/issue
>>> > Red Hat Enterprise Linux Client release 5.2 (Tikanga)
>>> > Kernel \r on an \m
>
> =A0 =A0I'll do that tonight because I grabbed the source for the package.
> Whoever created / ported the test basically took numa.h and numaif.h
> and jammed them into a separate header file instead of using the
> system ones, so that's where the issue you're seeing is coming from
> now.

=A0 =A0The compile issues should now be resolved as it's pulling from the
appropriate installed headers instead of the ad hoc ones, but the
problem is that the tests need to be rewritten for libnuma v2, as the
current ones are geared towards libnuma 0.9x (which I assume means
that it covers libnuma 1.x).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
