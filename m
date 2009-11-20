Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NBMvB-0002f1-7C
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 06:24:41 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NBMv5-0005rg-An
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 06:24:41 +0000
Received: by pwi12 with SMTP id 12so2057147pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 19 Nov 2009 22:24:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca69a6$d6ad7520$84085f60$@co.jp>
References: <000001ca69a6$d6ad7520$84085f60$@co.jp>
Date: Thu, 19 Nov 2009 22:24:29 -0800
Message-ID: <364299f40911192224i127c4b87qf0f7777ae0a8377d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] move_pages test failed in ltp-2009-11-19.tar.gz
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

On Thu, Nov 19, 2009 at 10:00 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> When I ran LTP in RHEL5.4 using ltp-2009-11-19.tar.gz,
> "move_pages03" and "move_pages11" were failed in each of "syscalls" and
> "numa" tests like that:
>
> ------------
> move_pages01 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages02 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> chown: cannot access `move_pages03': No such file or directory
> move_pages04 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages05 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages06 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages07 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages08 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages09 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> move_pages10 =A0 =A01 =A0TCONF =A0: =A0NUMA support not provided
> chown: cannot access `move_pages11': No such file or directory
> ------------
>
>
> These fails didn't occured with ltp-full-20090930.tgz, but they occured
> with ltp-full-20091031.tgz.
> With ltp-full-20090930.tgz, all of move_pagesXX (XX:01-11) were passed
> (NUMA support not provided) in my system.
>
>
> I compared these version and found out following scenarios changed.
> =A0- ${LTPROOT}/runtest/numa
> =A0- ${LTPROOT}/runtest/syscalls
>
>
> These scenarios are as follows, and "move_pages03" and "move_pages01"
> are revised.
>
> ------------
> # cat ./runtest/numa
> Numa-testcases numa01.sh
> move_pages01 move_pages.sh 01
> move_pages02 move_pages.sh 02
> move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> move_pages.sh 03
> move_pages04 move_pages.sh 04
> move_pages05 move_pages.sh 05
> move_pages06 move_pages.sh 06
> move_pages07 move_pages.sh 07
> move_pages08 move_pages.sh 08
> move_pages09 move_pages.sh 09
> move_pages10 move_pages.sh 10
> move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> move_pages.sh 11
> # cat ./runtest/syscalls | grep move_page
> move_pages01 move_pages.sh 01
> move_pages02 move_pages.sh 02
> move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> move_pages.sh 03
> move_pages04 move_pages.sh 04
> move_pages05 move_pages.sh 05
> move_pages06 move_pages.sh 06
> move_pages07 move_pages.sh 07
> move_pages08 move_pages.sh 08
> move_pages09 move_pages.sh 09
> move_pages10 move_pages.sh 10
> move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> move_pages.sh 11
> #------------
>
>
> I think there are two problems in each changes:
>
> =A0- "move_pagesXX" files are in "$LTPROOT/testcases/bin" direcotory,
> =A0 =A0not in "$LTPROOT/bin" directory.
> =A0- "chmod" commands don't have target file.
>
>
> I don't know why these revisions are done. But if these revisions should
> be validated, they will come to work in the change like following, I thin=
k.
> I wish I can get opinion whether my revision is right or not.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --- syscalls =A0 =A02009-11-18 13:24:34.000000000 +0900
> +++ syscalls.new =A0 =A0 =A0 =A02009-11-19 16:15:13.000000000 +0900
> @@ -571,7 +571,7 @@
>
> =A0move_pages01 move_pages.sh 01
> =A0move_pages02 move_pages.sh 02
> -move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> move_pages.sh 03
> +move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chm=
od
> 04755 move_pages.sh && move_pages.sh 03
> =A0move_pages04 move_pages.sh 04
> =A0move_pages05 move_pages.sh 05
> =A0move_pages06 move_pages.sh 06
> @@ -579,7 +579,7 @@
> =A0move_pages08 move_pages.sh 08
> =A0move_pages09 move_pages.sh 09
> =A0move_pages10 move_pages.sh 10
> -move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> move_pages.sh 11
> +move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chm=
od
> 04755 move_pages.sh && move_pages.sh 11
>
> =A0mprotect01 mprotect01
> =A0mprotect02 mprotect02
>
> --- numa =A0 =A0 =A0 =A02009-11-18 13:24:34.000000000 +0900
> +++ numa.new =A0 =A02009-11-19 16:15:33.000000000 +0900
> @@ -1,7 +1,7 @@
> =A0Numa-testcases numa01.sh
> =A0move_pages01 move_pages.sh 01
> =A0move_pages02 move_pages.sh 02
> -move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> move_pages.sh 03
> +move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chm=
od
> 04755 move_pages.sh && move_pages.sh 03
> =A0move_pages04 move_pages.sh 04
> =A0move_pages05 move_pages.sh 05
> =A0move_pages06 move_pages.sh 06
> @@ -9,4 +9,4 @@
> =A0move_pages08 move_pages.sh 08
> =A0move_pages09 move_pages.sh 09
> =A0move_pages10 move_pages.sh 10
> -move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> move_pages.sh 11
> +move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chm=
od
> 04755 move_pages.sh && move_pages.sh 11
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> In addition, please teach why this revision was performed, if all right.
> =A0- Why do only "move_pages03" and "move_pages11" appoint another direct=
ory
> =A0 =A0not a current directory?
> =A0- Why "chmod" is needed?

Mitani-san,
    Good catch ><... I made some really silly clerical errors in my
commits for these runtest files.
    To answer your questions though:
    1. I did the cd to ensure that pan is in a consistent location
when it does the chmod and to avoid having to do
"$LTPROOT/testcases/bin/move_pages{03,11}".
    2. The chmod and chown to fix the ownership and to enable the
sticky bit are being done because the test does seteuid, IIRC. What I
did was moved the logic from a `build time fix' to a `run time fix',
especially because the build user may not be root, and thus couldn't
set the sticky bit for the binary.
HTH,
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
