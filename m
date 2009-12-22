Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NN8fm-0001LN-Qh
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 17:37:26 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NN8fk-0001os-Jk
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 17:37:26 +0000
Received: by pwj11 with SMTP id 11so4253898pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Dec 2009 09:37:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca82bb$44f78d90$cee6a8b0$@co.jp>
References: <000001ca82bb$44f78d90$cee6a8b0$@co.jp>
Date: Tue, 22 Dec 2009 09:37:18 -0800
Message-ID: <364299f40912220937h7ddfddfaq43ebfdfec10363ac@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "nm" testcase failed
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

On Mon, Dec 21, 2009 at 8:00 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I found that "nm" testcase failed as follows:
> ------------
> gcc: /opt/ltp/testcases/bin/nmfile1.c: No such file or directory
> gcc: no input files
> gcc: /opt/ltp/testcases/bin/nmfile2.c: No such file or directory
> gcc: no input files
> gcc: /opt/ltp/testcases/bin/nmfile3.c: No such file or directory
> gcc: no input files
> ------------
>
> This problem occurs because "nmfile1.c", "nmfile2.c" and "nmfile3.c"
> are not installed to execute directory (/opt/ltp/testcases/bin).
>
> To solve this problem, I suggest to apply this patch to Makefile
> ("${LTPROOT}/testcases/commands/ade/nm/Makefile).
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- Makefile =A0 =A02009-10-10 02:55:44.000000000 +0900
> +++ Makefile.new =A0 =A0 =A0 =A02009-12-22 10:22:31.000000000 +0900
> @@ -24,7 +24,7 @@
>
> =A0include $(top_srcdir)/include/mk/env_pre.mk
>
> -INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D nm01 nmfile.c
> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D nm01 nmfile.c nmfile=
1.c nmfile2.c
> nmfile3.c
>
> =A0MAKE_TARGETS =A0 =A0 =A0 =A0 =A0 :=3D $(patsubst $(abs_srcdir)/%.c,%.o=
bj,$(wildcard
> $(abs_srcdir)/*.c))

Good catch! Committed.
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
