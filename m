Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MvPZe-0001ba-Ml
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 06:00:30 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MvPZW-0007n8-Cq
	for ltp-list@lists.sourceforge.net; Wed, 07 Oct 2009 06:00:30 +0000
Received: by pzk31 with SMTP id 31so1411545pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Oct 2009 23:00:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200910060643.35041.vapier@gentoo.org>
References: <364299f40910060307g33fcf21chcfcdb4cefe4e9bc@mail.gmail.com>
	<200910060643.35041.vapier@gentoo.org>
Date: Tue, 6 Oct 2009 23:00:16 -0700
Message-ID: <364299f40910062300s65c43c93w9cccdfe8835c2334@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Issue 3 - ptrace06 hung for 7 hours
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Tue, Oct 6, 2009 at 3:43 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tuesday 06 October 2009 06:07:40 Garrett Cooper wrote:
>> =A0 =A0 Ran into another issue. When I was running ptrace06 in the
>> syscalls test I noticed that it had been hung for over 7 hours -- is
>> this a known issue?
>> =A0 =A0 strace'ing the child proc didn't help (got ENOPERM), and
>> strace'ing the parent proc returned nada. I'm going to attach gdb and
>> figure out what the issue is, but I was wondering whether or not
>> anyone else knew.
>
> you wont be able to strace the child because it's already attached with p=
trace
> from the parent. =A0most likely the parent is sleeping and awaiting a sig=
nal
> from the child as there was some race that caused a mismatch.
>
> the test probably could do with a alarm() to prevent such hangs -- in the
> normal case, it should execute in a few seconds if that.

    Looks like it wasn't a well documented known issue:

Index: testcases/kernel/syscalls/ptrace/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/ptrace/Makefile,v
retrieving revision 1.6
diff -u -r1.6 Makefile
--- testcases/kernel/syscalls/ptrace/Makefile   15 Oct 2008 17:07:36
-0000      1.6
+++ testcases/kernel/syscalls/ptrace/Makefile   7 Oct 2009 05:57:23 -0000
@@ -16,16 +16,8 @@
 #  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  =
USA
 #

-SRCS    =3D $(wildcard *[^6].c)
-TARGETS =3D $(patsubst ptrace%.c,ptrace%,$(SRCS))

    I'm going to yank it from the runtest file (comment it out) and
leave a pointer back to the Makefile / this thread.
Thanks,
-Garrett

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
