Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDBKj-00049Z-5b
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 06:26:33 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDBKc-0001j8-Qt
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 06:26:33 +0000
Received: by pxi33 with SMTP id 33so5091701pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Nov 2009 22:26:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911250033.23404.vapier@gentoo.org>
References: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
	<364299f40911242117g6baf6281r1e7191a201d4203c@mail.gmail.com>
	<200911250033.23404.vapier@gentoo.org>
Date: Tue, 24 Nov 2009 22:26:20 -0800
Message-ID: <364299f40911242226g68c37f59r1fcfd23ad87dd1e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] mbind01 test failed with after ltp-2009-11-12.tar.gz
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
Cc: ltp-list@lists.sourceforge.net, Nate Straz <nate@refried.org>, Mitani <mitani@ryobi.co.jp>

On Tue, Nov 24, 2009 at 9:33 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 25 November 2009 00:17:16 Garrett Cooper wrote:
>> --- regen.sh =A019 Nov 2009 19:35:15 -0000 =A0 =A0 =A01.12
>> +++ regen.sh =A025 Nov 2009 05:12:13 -0000
>> @@ -32,8 +32,13 @@ static void cleanup(void);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR " no=
t supported on your arch");
>> =A0\\ errno =3D ENOSYS; \\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ret =3D -1; \\
>> - =A0 =A0 } else \\
>> + =A0 =A0 } else { \\
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ret =3D syscall(NR, ##__VA_ARGS__); \\
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) { =
\\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "sysc=
all " #NR " not supported on your arch");
>> =A0\\ + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 errno =3D ENOSYS; \\
>> + =A0 =A0 =A0 =A0 =A0 =A0 } \\
>> + =A0 =A0 } \\
>> =A0 =A0 =A0 __ret; \\
>> =A0})
>> =A0EOF
>
> i'd prefer this change
> --- testcases/kernel/include/regen.sh =A0 9 Oct 2009 17:55:48 -0000 =A0 =
=A0 =A0 1.11
> +++ testcases/kernel/include/regen.sh =A0 25 Nov 2009 05:28:27 -0000
> @@ -30,11 +30,12 @@ static void cleanup(void);
> =A0#define syscall(NR, ...) ({ \\
> =A0 =A0 =A0 =A0int __ret; \\
> =A0 =A0 =A0 =A0if (NR =3D=3D 0) { \\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR " n=
ot supported on your arch"); \\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errno =3D ENOSYS; \\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ret =3D -1; \\
> =A0 =A0 =A0 =A0} else \\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__ret =3D syscall(NR, ##__VA_ARGS__); \\
> + =A0 =A0 =A0 if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) \\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TCONF, cleanup, "syscall " #NR " n=
ot supported on your arch"); \\
> =A0 =A0 =A0 =A0__ret; \\
> =A0})
> =A0EOF

    Ok -- that makes more sense.. besides, I think gcc was optimizing
out the first branch with -O2 if it always evaluated to false. Here's
the new patch (I'm keeping the errno =3D ENOSYS part because I want to
make sure that tst_brkm doesn't mess up the errno value if a write(2)
fails or something).
Thanks!
-Garrett

EXAMPLE (Positive):

gcooper@orangebox
/scratch/ltp-dev2/ltp/testcases/kernel/syscalls/mbind $ ./mbind01
mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01     1  TPASS  :  (case00) END
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01     2  TPASS  :  (case01) END
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01     3  TPASS  :  (case02) END
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01     4  TPASS  :  (case03) END
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01     5  TPASS  :  (case04) END
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01     6  TPASS  :  (case05) END
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01     7  TPASS  :  (case06) END
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01     8  TPASS  :  (case07) END
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01     9  TPASS  :  (case08) END
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    10  TPASS  :  (case09) END
mbind01     0  TINFO  :  (case10) START
EXPECT: return value(ret)=3D-1 errno=3D14 (Bad address)
RESULT: return value(ret)=3D-1 errno=3D14 (Bad address)
mbind01    11  TPASS  :  (case10) END
mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01    12  TPASS  :  (case00) END
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    13  TPASS  :  (case01) END
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    14  TPASS  :  (case02) END
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01    15  TPASS  :  (case03) END
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    16  TPASS  :  (case04) END
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01    17  TPASS  :  (case05) END
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01    18  TPASS  :  (case06) END
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D0 errno=3D0 (Success)
mbind01    19  TPASS  :  (case07) END
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    20  TPASS  :  (case08) END
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
mbind01    21  TPASS  :  (case09) END
mbind01     0  TINFO  :  (case10) START
EXPECT: return value(ret)=3D-1 errno=3D14 (Bad address)
RESULT: return value(ret)=3D-1 errno=3D14 (Bad address)
mbind01    22  TPASS  :  (case10) END

EXAMPLE (Negative):

gcooper@orangebox /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/foo $ mak=
e all
make -C "/scratch/ltp-dev2/ltp/lib" -f "/scratch/ltp-dev2/ltp/lib/Makefile"=
 all
make[1]: Entering directory `/scratch/ltp-dev2/ltp/lib'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/scratch/ltp-dev2/ltp/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/scratch/ltp-dev2/ltp/testcases/kernel/include -I../../../../include
-I../../../../include   -L../../../../lib  foo.c   -lltp -o foo
gcooper@orangebox /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/foo $ ./f=
oo
foo         1  TCONF  :  syscall __NR_foo not supported on your arch
gcooper@orangebox /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/foo
$ cat foo.c
#include "test.h"
#include "linux_syscall_numbers.h"

#define __NR_foo 19567

int TST_TOTAL =3D 1;
char *TCID =3D "foo";

void cleanup(void) { }

int
main (void) {
        return syscall(__NR_foo, "bar");
}
gcooper@orangebox /scratch/ltp-dev2/ltp/testcases/kernel/syscalls/foo $ ./f=
oo
foo         1  TCONF  :  syscall __NR_foo not supported on your arch

PATCH:

Index: regen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/include/regen.sh,v
retrieving revision 1.12
diff -u -p -r1.12 regen.sh
--- regen.sh	19 Nov 2009 19:35:15 -0000	1.12
+++ regen.sh	25 Nov 2009 06:22:33 -0000
@@ -29,11 +29,15 @@ static void cleanup(void);
 #define syscall(NR, ...) ({ \\
 	int __ret; \\
 	if (NR =3D=3D 0) { \\
-		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch"); =
\\
 		errno =3D ENOSYS; \\
 		__ret =3D -1; \\
-	} else \\
+	} else { \\
 		__ret =3D syscall(NR, ##__VA_ARGS__); \\
+	} \\
+	if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) { \\
+		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch"); =
\\
+		errno =3D ENOSYS; \\
+	} \\
 	__ret; \\
 })
 EOF

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
