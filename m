Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MTGE3-0006d1-LM
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 14:21:51 +0000
Received: from mail-px0-f174.google.com ([209.85.216.174])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTGDy-0002qf-OS
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 14:21:51 +0000
MIME-Version: 1.0
In-Reply-To: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
References: <20090721.182542.1000278277145531816.caiqian@cclom.cn>
Date: Tue, 21 Jul 2009 07:21:44 -0700
Message-ID: <364299f40907210721q365aa8fdu21a1b2ff254bc60a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP Intermediate Release for JULY 2009 Build Failures
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
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sf.net

On Tue, Jul 21, 2009 at 3:25 AM, CAI Qian<caiqian@cclom.cn> wrote:
> Hi,
>
> I have seen those failures,
>
> # uname -a
> Linux foo.bar.redhat.com 2.6.18-158.el5 #1 SMP Mon Jul 13 16:23:20 EDT
> 2009 s390x s390x s390x GNU/Linux
>
> make[5]: Entering directory `/root/20090721/ltp-intermediate-20090721/tes=
tcases/kernel/syscalls/eventfd2'
> gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall =A0 =A0ev=
entfd2_01.c =A0-L../../../../lib -lltp -o eventfd2_01
> gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall =A0 =A0ev=
entfd2_02.c =A0-L../../../../lib -lltp -o eventfd2_02
> gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall =A0 =A0ev=
entfd2_03.c =A0-L../../../../lib -lltp -o eventfd2_03
> eventfd2_03.c: In function =91xsem_wait=92:
> eventfd2_03.c:60: warning: format =91%llu=92 expects type =91long long un=
signed int=92, but argument 5 has type =91u_int64_t=92
> eventfd2_03.c: In function =91main=92:
> eventfd2_03.c:129: warning: implicit declaration of function =91waitpid=
=92
> eventfd2_03.c: At top level:
> ../../include/linux_syscall_numbers.h:19: warning: =91cleanup=92 used but=
 never defined
> /tmp/ccODR9Wd.o: In function `eventfd2':
> /root/20090721/ltp-intermediate-20090721/testcases/kernel/syscalls/eventf=
d2/eventfd2_03.c:49: undefined reference to `cleanup'
> collect2: ld returned 1 exit status
> make[5]: *** [eventfd2_03] Error 1
> make[5]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel/syscalls/eventfd2'
> make[4]: *** [all] Error 2
> make[4]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel/syscalls'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/20090721/ltp-intermediate-20090721'
> make: *** [build] Error 2

The patch provided below fixes the majority of the compile
errors/warnings. I'm unable to get it to run though by itself, so I
must be missing some critical piece of info.

I was tempted to fix the format string error, but I don't know what
the potential implications are of switching the data type from
u_int64_t to unsigned long long...

> # uname -a
> Linux foo.bar.redhat.com 2.6.18-158.el5 #1 SMP Mon Jul 13
> 16:27:25 EDT 2009 ppc64 ppc64 ppc64 GNU/Linux
>
> make[5]: Entering directory `/root/20090721/ltp-intermediate-20090721/tes=
tcases/kernel/syscalls/fstatat'
> gcc -g -O2 -I../../include -g -Wall -I../../../../include -Wall -DTST_USE=
_NEWER64_SYSCALL=3D1 -D_FILE_OFFSET_BITS=3D64 =A0 -c -o fstatat01_64.o fsta=
tat01.c
> fstatat01.c: In function =91main=92:
> fstatat01.c:126: error: expected =91)=92 before numeric constant
> make[5]: *** [fstatat01_64.o] Error 1
> make[5]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel/syscalls/fstatat'
> make[4]: *** [all] Error 2
> make[4]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel/syscalls'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases/kernel'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/20090721/ltp-intermediate-20090721/test=
cases'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/20090721/ltp-intermediate-20090721'
> make: *** [build] Error 2

Missing syscall number. Not sure why it fails for you and passes for
me though... the syscall may need to be added to a .in file.

Thanks,
-Garrett

Fix compiler error noted by CAI Qian w.r.t. the intermediate July release, =
as...
1. The necessary headers weren't being pulled in for waitpid.
2. gcc was complaining about -Wunused with cleanup.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/syscalls/eventfd2/eventfd2_03.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/eventfd2/eventfd2_03.c=
,v
retrieving revision 1.2
diff -u -r1.2 eventfd2_03.c
--- testcases/kernel/syscalls/eventfd2/eventfd2_03.c    6 Jul 2009
14:49:18 -0000       1.2
+++ testcases/kernel/syscalls/eventfd2/eventfd2_03.c    21 Jul 2009
14:15:59 -0000
@@ -26,6 +26,7 @@
 #include <sys/types.h>
 #include <sys/syscall.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -44,6 +45,8 @@
 #define EFD_SEMLIKE (1 << 0)
 #endif

+/* Dummy function reference to avoid compiler warning from
linux_syscall_numbers.h. */
+extern void cleanup() { }

 static int eventfd2(int count, int flags) {
        return syscall(__NR_eventfd2, count, flags);

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
