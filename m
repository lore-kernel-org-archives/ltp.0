Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NMadQ-0001dE-IQ
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 05:16:44 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMadP-0004Cc-KY
	for ltp-list@lists.sourceforge.net; Mon, 21 Dec 2009 05:16:44 +0000
Received: by pwj11 with SMTP id 11so3254802pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 20 Dec 2009 21:16:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca81f5$53bbaee0$fb330ca0$@co.jp>
References: <000001ca81f5$53bbaee0$fb330ca0$@co.jp>
Date: Sun, 20 Dec 2009 21:16:37 -0800
Message-ID: <364299f40912202116m4505241cg90a33cac08556652@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "unzip01" testcase failed.
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
Cc: ltp-list@lists.sourceforge.net

On Sun, Dec 20, 2009 at 8:23 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I found that "unzip01" testcase failed as follows.
> ----------
> unzip01 =A0 =A0 1 =A0TFAIL =A0: =A0Test #1: unzip output differs from exp=
ected output.
> Details
> ----------
>
> The above error's "expected output" and "output" are :
> =A0- "tst_unzip.out.exp" file ("expected output") :
> =A0 =A0 =A0In "${LTPROOT}/testcases/bin/unzip_tests.sh", the contents of =
the
> =A0 =A0 =A0"tst_unzip.dir" directory are expected to output into this fil=
e.
> =A0- "tst_unzip.out" file (actual "output") :
> =A0 =A0 =A0A all contents of the "/opt/LTP/testcases/bin" directory are
> =A0 =A0 =A0logged to this file.
>
> This problem occurs because "tst_unzip.dir" directory is not created.
>
> Why does "DIR" become "/opt/ltp/testcases/bin" set
> though "DIR :=3D tst_unzip.dir" is defined
> in "${LTPROOT}/testcases/commands/unzip/Makefile"?
>
> To solve this problem, it is necessary to apply the following patche
> to "${LTPROOT}/testcases/commands/unzip/Makefile" for creating
> "tst_unzip.dir" directory, I think.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- Makefile =A0 =A02009-12-18 17:48:40.000000000 +0900
> +++ Makefile.new =A0 =A0 =A0 =A02009-12-18 17:38:00.000000000 +0900
> @@ -27,8 +27,6 @@
> =A0# Only build and install if we have the zip command.
> =A0HAVE_ZIPTOOLS =A0 =A0 =A0 =A0 =A0:=3D $(shell if which zip >/dev/null;=
 then echo yes;
> else echo no; fi)
>
> -DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D tst_unzip.dir
> -
> =A0RM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -r
>
> =A0TESTCASES_DATA_DIR =A0 =A0 :=3D $(DESTDIR)/$(prefix)/testcases/data
> @@ -36,7 +34,7 @@
> =A0ZIPFILE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TESTCASE=
S_DATA_DIR)/tst_unzip_file.zip
>
> =A0ifeq ($(HAVE_ZIPTOOLS),yes)
> -CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0:=3D $(DIR) $(ZIPFILE)
> +CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0:=3D tst_unzip.dir $(ZIPFILE)
> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D unzip_tests.sh
> =A0endif
>
> @@ -45,13 +43,14 @@
> =A0$(TESTCASES_DATA_DIR):
> =A0 =A0 =A0 =A0mkdir -p "$@"
>
> -$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(DIR)
> - =A0 =A0 =A0 zip -r "$@" $(DIR)
> +$(ZIPFILE): | $(TESTCASES_DATA_DIR) tst_unzip.dir
> + =A0 =A0 =A0 zip -r "$@" tst_unzip.dir
> =A0 =A0 =A0 =A0chmod 00666 "$@"
>
> =A0# This target should be auto-removed by Make
> -$(DIR): $(abs_srcdir)/unzip_genfile.sh
> - =A0 =A0 =A0 $(SHELL) "$^" $(DIR)
> +.INTERMEDIATE: tst_unzip.dir
> +tst_unzip.dir: $(abs_srcdir)/unzip_genfile.sh
> + =A0 =A0 =A0 $(SHELL) "$^" tst_unzip.dir
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

I'm not convinced that this is the right solution because most of
what's done here just replaced $(DIR)'s value with the bareword value.
.INTERMEDIATE may be the only piece of value here, but I was avoiding
it because it's a 3.81-ism I thought...

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
