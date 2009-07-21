Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MT6tn-0001if-Qs
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 04:24:19 +0000
Received: from mail-pz0-f201.google.com ([209.85.222.201])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MT6ta-0003vF-W1
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 04:24:14 +0000
Received: by pzk39 with SMTP id 39so460863pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jul 2009 21:24:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A652E3C.20402@cn.fujitsu.com>
References: <4A652E3C.20402@cn.fujitsu.com>
Date: Mon, 20 Jul 2009 21:24:06 -0700
Message-ID: <364299f40907202124u8cd7a14n6e331fc53648ca66@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix failure of the utimes01 test
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
To: Wang Yong <wangyong2009@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Mon, Jul 20, 2009 at 7:55 PM, Wang Yong<wangyong2009@cn.fujitsu.com> wro=
te:
> This patch also fixed the path which we pass to setup_file(). If
> progdir is not a absolute pathname of the working directory, the file
> open will fail.
>
> This patch fixed the problem.
>
> Signed-off-by: WangYong <wangyong2009@cn.fujitsu.com>
>
> diff -Nurp a/testcases/kernel/syscalls/utimes/utimes01.c b/testcases/kern=
el/syscalls/utimes/utimes01.c
> --- a/testcases/kernel/syscalls/utimes/utimes01.c =A0 =A0 =A0 2009-07-21 =
08:51:05.000000000 +0800
> +++ b/testcases/kernel/syscalls/utimes/utimes01.c =A0 =A0 =A0 2009-07-21 =
08:55:01.000000000 +0800
> @@ -138,7 +138,6 @@ void setup() {
> =A0*/
> =A0static int opt_debug;
> =A0static char *progname;
> -static char *progdir;
>
> =A0enum test_type {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NORMAL,
> @@ -232,7 +231,7 @@ static int do_test(struct test_case *tc)
> =A0 =A0 =A0 =A0 struct stat st;
> =A0 =A0 =A0 =A0 uid_t old_uid;
>
> - =A0 =A0 =A0 =A0TEST(rc =3D setup_file(progdir, "test.file", fpath));
> + =A0 =A0 =A0 =A0TEST(rc =3D setup_file(TESTDIR, "test.file", fpath));
> =A0 =A0 =A0 =A0 if (rc < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>
> @@ -339,8 +338,6 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0progname =3D strchr(av[0], '/');
> =A0 =A0 =A0 =A0 progname =3D progname ? progname + 1 : av[0];
>
> - =A0 =A0 =A0 progdir =3D strdup(av[0]);
> - =A0 =A0 =A0 =A0progdir =3D dirname(progdir);
>
> =A0 =A0 =A0 =A0 /* parse standard options */
> =A0 =A0 =A0 =A0 if ((msg =3D parse_opts(ac, av, (option_t *)NULL, NULL)) =
!=3D (char *)NULL){

Wang,
    Would you please verify this diff in your environment too? It does
what your diff did, in addition to fixes a harmless warning with
-Wnonnull:

1. Fix the utimes testcase so that it passes with the appropriate
non-hardcoded directory, as provided by Wang Yong
<wangyong2009@cn.fujitsu.com>
2. Fix a compiler warning by using an intermediary const char*
variable, as casting alone was still causing compiler warnings in gcc
4.3.2.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/syscalls/utimes/utimes01.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/utimes/utimes01.c,v
retrieving revision 1.2
diff -u -r1.2 utimes01.c
--- testcases/kernel/syscalls/utimes/utimes01.c 10 Jul 2009 10:14:59 -0000 =
    1
.2
+++ testcases/kernel/syscalls/utimes/utimes01.c 21 Jul 2009 04:20:44 -0000
@@ -138,7 +138,6 @@
  */
 static int opt_debug;
 static char *progname;
-static char *progdir;

 enum test_type {
                NORMAL,
@@ -232,7 +231,7 @@
         struct stat st;
         uid_t old_uid;

-        TEST(rc =3D setup_file(progdir, "test.file", fpath));
+        TEST(rc =3D setup_file(TESTDIR, "test.file", fpath));
         if (rc < 0)
                 return 1;

@@ -257,9 +256,19 @@
                 fpath[len - 1] =3D '\0';
         }
         errno =3D 0;
-        if (tc->ttype =3D=3D NO_FNAME)
-                TEST(sys_ret =3D utimes(NULL, tv));
-        else
+        if (tc->ttype =3D=3D NO_FNAME) {
+                /**
+                 * Note (garrcoop):
+                 *
+                 * If you do NULL directly, then gcc [4.3] will complain w=
hen
+                 * one specifies -Wnonnull in CPPFLAGS. This is a negative
+                 * test, but let's not allow the compiler to complain about
+                 * something trivial like this.
+                 **/
+                const char *dummy =3D NULL;
+                TEST(sys_ret =3D utimes(dummy, tv));
+        }
+       else
                 TEST(sys_ret =3D utimes(fpath, tv));
         sys_errno =3D errno;
         if (tc->ttype =3D=3D FILE_NOT_EXIST)
@@ -339,9 +348,6 @@
        progname =3D strchr(av[0], '/');
         progname =3D progname ? progname + 1 : av[0];

-       progdir =3D strdup(av[0]);
-        progdir =3D dirname(progdir);
-
         /* parse standard options */
         if ((msg =3D parse_opts(ac, av, (option_t *)NULL, NULL)) !=3D (cha=
r *)NULL)
{
              tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);

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
