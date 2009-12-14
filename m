Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NK2fc-0006Ey-6i
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 04:36:28 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NK2fU-0004Ld-86
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 04:36:28 +0000
Date: Sun, 13 Dec 2009 23:36:12 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <2039563304.268931260765372686.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1117953467.268911260765366627.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10664_687668773.1260765372685"
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
 (ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

------=_Part_10664_687668773.1260765372685
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- "Mike Frysinger" <vapier@gentoo.org> wrote:

> On Friday 11 December 2009 06:30:01 Caspar Zhang wrote:
> >   Here are two patches to fix compiling error in ia64,
> > I tested only in version ltp-full-20091130, please check
> > your own version. They are for work well on my system.
> > See the attachment.
>=20
> the ia64 change is incorrect.  there's ia64 ifdef hacks in there
> already which=20
> are to be used.

the ia64 ifdef hacks in 20091130 are the following lines(in file=20
ptrace.h):

    17=09/* ia64's a real pain.. */
    18=09#if defined(__ia64__)
    19=09#undef FU_ia64_fpreg
    20=09#undef FU_pt_all_user_regs
    21=09#if ! defined(ia64_fpreg)
    22=09# define ia64_fpreg FU_ia64_fpreg
    23=09#endif
    24=09#if ! defined(pt_all_user_regs)
    25=09# define pt_all_user_regs FU_pt_all_user_regs
    26=09#endif
    27=09#endif

I don't think these codes could sovle the compiling problem. Nor the
following codes in latest cvs :

    23=09#if defined(__ia64__)
    24=09#if !defined(ia64_fpreg)
    25=09# define ia64_fpreg FU_ia64_fpreg
    26=09#endif
    27=09#if !defined(pt_all_user_regs)
    28=09# define pt_all_user_regs FU_pt_all_user_regs
    29=09#endif
    30=09#undef FU_ia64_fpreg
    31=09#undef FU_pt_all_user_regs
    32=09#endif /* defined(__ia64__) */

I tried to compile in RHEL5u4(kernel 2.6.18) but failed. I have given
the error mesage in the patch:

In file included from /usr/include/asm/ptrace.h:58,
                 from ../../syscalls/ptrace/ptrace.h:17,
                 from vfork.c:44:
/usr/include/asm/fpu.h:57: error: redefinition of =E2=80=98struct ia64_fpre=
g=E2=80=99
In file included from ../../syscalls/ptrace/ptrace.h:17,
                 from vfork.c:44:
/usr/include/asm/ptrace.h:208: error: redefinition of =E2=80=98struct pt_al=
l_user_regs=E2=80=99
make[5]: *** [vfork] Error 1

System told me there was a definition conflict, but I could only find one=
=20
definition in my system. I have searched the whole system and found the=20
definition was in <asm/fpu.h>, which was included by <asm/ptrace.h>.

I just deleted #include <asm/ptrace.h> from testcases/kernel/syscalls/ptrac=
e/ptrace.h
and the compilation continued till the cleanup-not-found error occured(My=
=20
second patch should fix this problem). I don't know why stop including <asm=
/ptrace.h>
can pass the compilation. I attach the <sys/ptrace.h> <asm/ptrace.h> <linux=
/ptrace.h>
from ia64 system(kernel 2.6.18) to the mail, may this help.

>=20
> the ppc64 issue is not ppc64 or ptrace specific.  garrett has a
> different fix=20
> in the pipeline for that.
> -mike
------=_Part_10664_687668773.1260765372685
Content-Type: application/x-gzip; name=ptrace.h.tar.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ptrace.h.tar.gz

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
loF8e749355vz7/z+X+9qqLoAFAAAA==
------=_Part_10664_687668773.1260765372685
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

------=_Part_10664_687668773.1260765372685
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_10664_687668773.1260765372685--

