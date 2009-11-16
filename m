Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N9xA1-0007tI-Ev
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:42:09 +0000
Received: from mail-pw0-f48.google.com ([209.85.160.48])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9x9v-0008Bf-2v
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:42:09 +0000
MIME-Version: 1.0
In-Reply-To: <1258357633.5677.24.camel@subratamodak.linux.ibm.com>
References: <1258357633.5677.24.camel@subratamodak.linux.ibm.com>
Date: Mon, 16 Nov 2009 00:41:56 -0800
Message-ID: <364299f40911160041n1f4578a3t8ca143f89fd86207@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] One 1 remaining Build Error with LTP CVS 2009-11-16
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

On Sun, Nov 15, 2009 at 11:47 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Mike/Garret,
>
> There remains only 1 build error now with the LTP CVS. This happens to be=
 the issue with ltp/testcases/kernel/containers/libclone/Makefile.
> It is not able to to include <test.h>, <usctest.h> and linux_syscall_numb=
ers.h. However, i just made temporary changes in my local repo to fix this:
>
> # head -34 testcases/kernel/containers/libclone/libclone.h | tail -5
> #include <signal.h>
> #include "../../include/linux_syscall_numbers.h"
> #include "test.h"
> #include "usctest.h"
>
> Can you please fix this up in CVS ? Following error is generated on compi=
lation:
>
> make[4]: Entering directory `/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_=
CODE/LTP_TARS/OCTOBER_2009_RELEASE/ltp-intermediate-20091116/testcases/kern=
el/containers/libclone'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I../../../../inclu=
de -I../../../../include =A0-c -o libclone.o libclone.c
> In file included from libclone.c:17:
> libclone.h:31:35: error: linux_syscall_numbers.h: No such file or directo=
ry
> libclone.c: In function =91do_clone_tests=92:
> libclone.c:25: warning: implicit declaration of function =91ltp_clone_qui=
ck=92
> make[4]: *** [libclone.o] Error 1

Done. Sorry for the accidental local items that I forgot to checkin...
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
