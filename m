Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDAFs-0000iG-Lj
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 05:17:28 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDAFm-0007uf-OP
	for ltp-list@lists.sourceforge.net; Wed, 25 Nov 2009 05:17:28 +0000
Received: by pxi33 with SMTP id 33so5058522pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 24 Nov 2009 21:17:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
References: <000001ca6d7c$63dc8890$2b9599b0$@co.jp>
Date: Tue, 24 Nov 2009 21:17:16 -0800
Message-ID: <364299f40911242117g6baf6281r1e7191a201d4203c@mail.gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Nate Straz <nate@refried.org>

On Tue, Nov 24, 2009 at 7:07 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> Following failure occurred in mbind01 when I execute "runltp" using
> ltp-2009-11-12.tar.gz.
> Similer failure occured with several recent versions from
> ltp-2009-11-17.tar.gz
> to ltp-2009-11-24.tar.gz, too.
>
> <error message>

[...]

> On the other hand, with "ltp-full-20091031", it passed as following messa=
ge
> (My system not supports NUMA).
>
> -----------------------------
> mbind01 =A0 =A0 1 =A0TCONF =A0: =A0NUMA support not provided.
> -----------------------------
>
>
> Therefore, this problem seems to be after 2009/11/04 revision, I think.
>
>
> Following shows revision contribution contents.
>
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/m=
bin
> d/mbind01.c?view=3Dlog
>
> -----------------------------
> Revision 1.7
> Wed Nov 4 06:18:27 2009 UTC (2 weeks, 6 days ago) by yaberauneya
> Branch: MAIN
> Changes since 1.6: +1 -13 lines
> Diff to previous 1.6
> I was confused, and numaif.h is in fact a header under
> testcases/kernel/syscalls/utils. As such:
>
> 1. The autoconf test for the header is removed.
> 2. An appropriate inclusion is added for numa.h in numaif.h
> 3. Remove overengineered code in get_mempolicy01.c because
> linux_syscall_numbers.h handles the unhandled numa syscall numbers.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
>
> Revision 1.6
> Wed Nov 4 04:59:44 2009 UTC (2 weeks, 6 days ago) by yaberauneya
> Branch: MAIN
> Changes since 1.5: +263 -281 lines
> Diff to previous 1.5
> 1. Disable the test whenever the appropriate headers and syscalls don't
> exist so this will compile on systems without numa and without.
> 2. Fix the indentation.
> 3. Use TFAIL | TERRNO instead of all of the ad-hoc (TFAIL ... TERRNO,
> strerror(TERRNO)) logic.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> -----------------------------
>
>
> According to the contribution of these revisions, it is written that
> "Disable the test whenever the appropriate headers and syscalls don't
> exist.".
> However, when I compare these revisions, the judgement sentence
> whether numa is supported or not is deleted, and the error output sentence
> that numa is not supported is deleted.
>
> Following shows the result of compare of "Revision 1.6 and Revision 1.5"
> and "Revision 1.7 and Revision 1.6".
>
> <Revision 1.6 and Revision 1.5>
> -----------------------------
> --- mbind01.c =A0 2009/10/09 17:55:57 =A0 =A0 1.5
> +++ mbind01.c =A0 2009/11/04 04:59:44 =A0 =A0 1.6
> @@ -1,50 +1,51 @@
> .
> @@ -55,10 +56,12 @@
> .
> @@ -66,70 +69,72 @@
> .
> -#if HAS_NUMA_H
> =A0static struct test_case tcase[] =3D {
> .
> -#else
> -static struct test_case tcase[] =3D { };
> -#endif
> .
> @@ -261,82 +262,80 @@
> .
> =A0static int do_test(struct test_case *tc) {
> -#if HAS_NUMA_H
> .
> -#else
> - =A0 =A0 =A0 return -1;
> -#endif
> .
> @@ -346,47 +345,43 @@
> .
> -#if HAS_NUMA_H
> .
> @@ -394,45 +389,32 @@
> .
> =A0#else
> +int main (void) {
> =A0 =A0 =A0 =A0tst_resm(TCONF, "NUMA support not provided.");
> -#endif
> - =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> +#endif
> -----------------------------
>
> <Revision 1.7 and Revision 1.6>
> -----------------------------
> --- mbind01.c =A0 2009/11/04 04:59:44 =A0 =A0 1.6
> +++ mbind01.c =A0 2009/11/04 06:18:27 =A0 =A0 1.7
> @@ -59,14 +59,11 @@
> .
> @@ -77,8 +74,6 @@
> .
> @@ -411,10 +406,3 @@
> =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> -
> -#else
> -int main (void) {
> - =A0 =A0 =A0 tst_resm(TCONF, "NUMA support not provided.");
> - =A0 =A0 =A0 tst_exit();
> -}
> -#endif
> -----------------------------
>
> I think that these revisions may contradict the above contribution.
> (Please forgive me if my opinion was wrong.)
>
>
> To revise this problem (error of "Function not implemented") like above
> contribution, it is necessary to judge numa supporting by using "#if
> HAS_NUMA_H".
> And it is necessary to end with " tst_resm(TCONF, "NUMA support not
> provided.") "
> when not support, I think.
> It is the point same as 2009/10/31 version.
>
>
> Following shows my revise draft.
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- mbind01.c.org =A0 =A0 =A0 2009-11-24 18:17:27.000000000 +0900
> +++ mbind01.c =A0 2009-11-24 16:09:03.000000000 +0900
> @@ -176,6 +176,7 @@
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (only we can do is simulate 1-no=
de NUMA)
> =A0*/
>
> +#if HAS_NUMA_H
> =A0static struct test_case tcase[] =3D {
> =A0 =A0 =A0 =A0{ /* case00 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.policy =A0 =A0 =3D MPOL_DEFAULT,
> @@ -246,6 +247,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.err =A0 =A0 =A0 =A0=3D EFAULT,
> =A0 =A0 =A0 =A0},
> =A0};
> +#endif
>
> =A0#define MEM_LENGTH =A0 =A0 =A0 =A0 =A0 (4 * 1024 * 1024)
> =A0/*
> @@ -365,6 +367,7 @@
>
> =A0 =A0 =A0 =A0setup();
>
> +#if HAS_NUMA_H
> =A0 =A0 =A0 =A0int lc, i, ret; =A0 =A0 =A0 =A0 =A0/* loop counter */
>
> =A0 =A0 =A0 =A0/* Check looping state if -i option given */
> @@ -404,4 +407,9 @@
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0tst_exit();
> +
> +#else
> + =A0 =A0 =A0 tst_resm(TCONF, "NUMA support not provided.");
> +#endif
> +
> =A0}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Can I get opinion that my revision is right or not?

Something I realized after testing yesterday, is that although we're
overriding syscall, it doesn't catch ENOSYS and output tst_brkm(TCONF,
...) like I thought it would.

Would you please do the following?

1. cd $LTPSRC/testcases/kernel/include
2. Apply the following patch:

Index: regen.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/include/regen.sh,v
retrieving revision 1.12
diff -u -p -r1.12 regen.sh
--- regen.sh	19 Nov 2009 19:35:15 -0000	1.12
+++ regen.sh	25 Nov 2009 05:12:13 -0000
@@ -32,8 +32,13 @@ static void cleanup(void);
 		tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch"); =
\\
 		errno =3D ENOSYS; \\
 		__ret =3D -1; \\
-	} else \\
+	} else { \\
 		__ret =3D syscall(NR, ##__VA_ARGS__); \\
+		if (__ret =3D=3D -1 && errno =3D=3D ENOSYS) { \\
+			tst_brkm(TCONF, cleanup, "syscall " #NR " not supported on your arch");=
 \\
+			errno =3D ENOSYS; \\
+		} \\
+	} \\
 	__ret; \\
 })
 EOF

3. make clean all
4. cd ../syscalls/mbind
5. make clean all
6. ./mbind01

Let me know how it goes -- if other folks agree with the solution
(ENOSYS is always TCONF with the syscall(2) wrapper) I'll check it
directly into CVS; otherwise I'll have to engineer a large scale
solution in a number of tests which have syscall numbers defined on
later kernel versions, s.t. they fail happily with TCONF when errno =3D=3D
ENOSYS.

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
