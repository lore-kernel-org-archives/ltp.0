Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My9at-0006ah-Lo
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:33:07 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My9ap-0005q5-6d
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:33:07 +0000
Received: by pwj1 with SMTP id 1so106189pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 12:32:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910141231x6fb16559obe7470e34209b080@mail.gmail.com>
References: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
	<200910130130.30228.vapier@gentoo.org>
	<364299f40910122240p586a60aarc796112b68c519e2@mail.gmail.com>
	<200910130143.53176.vapier@gentoo.org>
	<364299f40910141231x6fb16559obe7470e34209b080@mail.gmail.com>
Date: Wed, 14 Oct 2009 12:32:56 -0700
Message-ID: <364299f40910141232h2ea46499r637654312897aa3b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] convert linktest.pl to linktest.sh
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

On Wed, Oct 14, 2009 at 12:31 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> This proposed change makes linktest.pl into linktest.sh, to avoid
> missing coverage with symlinks and hardlinks due to a lacking perl
> dependency on the target host.
>
> This change has been outstanding for some time in our private copy of
> LTP and needed to get checked into CVS.
>
> //edit[1]: Incorporate comments made by Mike F.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> diff --exclude '*CVS*' -NaurP ./runtest/fs ../ltp.bk/runtest/fs
> --- ./runtest/fs =A0 =A0 =A0 =A02009-10-12 22:06:10.000000000 -0700
> +++ ../ltp.bk/runtest/fs =A0 =A0 =A0 =A02009-10-12 22:09:12.000000000 -07=
00
> @@ -40,7 +40,7 @@
> =A0iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
> -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>
> =A0fs_inod01 fs_inod $TMP 10 10 10
> -linker01 linktest.sh 1000 1000
> +linker01 linktest.pl 1000 1000
> =A0openfile01 openfile -f10 -t10
> =A0inode01 inode01
> =A0inode02 inode02
> diff --exclude '*CVS*' -NaurP ./runtest/stress.part1
> ../ltp.bk/runtest/stress.part1
> --- ./runtest/stress.part1 =A0 =A0 =A02009-10-12 22:06:15.000000000 -0700
> +++ ../ltp.bk/runtest/stress.part1 =A0 =A0 =A02009-10-12 22:09:12.0000000=
00 -0700
> @@ -156,7 +156,7 @@
> =A0iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
> -Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
>
> =A0fs_inod01 fs_inod $TMP 10 10 1
> -linker01 linktest.sh
> +linker01 linktest.pl
> =A0openfile01 openfile -f10 -t10
> =A0inode01 inode01
> =A0inode02 inode02
> diff --exclude '*CVS*' -NaurP
> ./testcases/kernel/fs/linktest/linktest.pl
> ../ltp.bk/testcases/kernel/fs/linktest/linktest.pl
> --- ./testcases/kernel/fs/linktest/linktest.pl =A01969-12-31
> 16:00:00.000000000 -0800
> +++ ../ltp.bk/testcases/kernel/fs/linktest/linktest.pl =A02009-10-12
> 22:18:49.000000000 -0700
> @@ -0,0 +1,89 @@
> +#!/usr/bin/perl
> +
> +# =A0 Copyright (c) International Business Machines =A0Corp., 2000
> +#
> +# =A0 This program is free software; =A0you can redistribute it and/or m=
odify
> +# =A0 it under the terms of the GNU General Public License as published =
by
> +# =A0 the Free Software Foundation; either version 2 of the License, or
> +# =A0 (at your option) any later version.
> +#
> +# =A0 This program is distributed in the hope that it will be useful,
> +# =A0 but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
> +# =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
> +# =A0 the GNU General Public License for more details.
> +#
> +# =A0 You should have received a copy of the GNU General Public License
> +# =A0 along with this program; =A0if not, write to the Free Software
> +# =A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-130=
7 USA
> +
> +
> +#
> +# =A0FILE(s) =A0 =A0 : linktest.pl README
> +# =A0DESCRIPTION : Regression test for max links per file
> +# =A0USE =A0 =A0 =A0 =A0 : linktest.pl <number of symlinks> <number of h=
ardlinks>
> +# =A0AUTHOR =A0 =A0 =A0: Jeff Martin (martinjn@us.ibm.com)
> +# =A0HISTORY =A0 =A0 :
> +# =A0 =A0 (05/07/01)v.99 =A0Needed a quick script to test a hardlink
> limitation that was found.
> +# =A0 =A0 (28/07/08) Veerendra C <vechandr@in.ibm.com>
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Modified to return proper retu=
rn code on
> failure/success.
> +# =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Also modified to return errors=
 if unable to
> create dir/files
> +
> +$ret =3D 0;
> +if ( system("mkdir hlink") ) {
> + =A0 =A0 $ret =3D -1 ;
> +}
> +
> +if ( system("mkdir slink") ) {
> + =A0 =A0 $ret =3D -1 ;
> +}
> +
> +if ( system("touch hlink/hfile") ) {
> + =A0 =A0 $ret =3D -1 ;
> +}
> +
> +if ( system("touch slink/sfile") ) {
> + =A0 =A0 $ret =3D -1 ;
> +}
> +
> +if ( $ret =3D=3D -1 ) {
> + =A0 =A0printf ("Error %d: Not able to create dir/file's\n " , $ret);
> + =A0 =A0exit -1;
> +}
> +
> +$scount=3Dshift @ARGV;
> +chdir "slink";
> +for($x=3D0;$x<$scount;$x++) {
> + =A0 $result=3Dsymlink("sfile","sfile$x");
> + =A0 if(!$result) {
> + =A0 =A0 =A0$serrors++;
> + =A0 =A0 =A0}
> + =A0 }
> +chdir "..";
> +$hcount=3Dshift @ARGV;
> +for($x=3D0;$x<$hcount;$x++) {
> + =A0 $result=3Dlink("hlink/hfile","hlink/hfile$x");
> + =A0 if(!$result) {
> + =A0 =A0 =A0$herrors++;
> + =A0 =A0 =A0}
> + =A0 }
> +
> +if($herrors) {
> + =A0 =A0printf ("linker01 : FAIL Hard Link Errors =3D %d\n", $herrors);
> + =A0 =A0$ret =3D -1
> +}
> +else {
> + =A0 =A0printf ("linker01 : HardLink Test PASS\n" )
> +}
> +if($serrors) {
> + =A0 =A0printf ("linker01 : FAIL Soft Link Errors =3D %d\n", $serrors);
> + =A0 =A0$ret =3D -1
> +}
> +else {
> + =A0 =A0printf ("linker01 : SoftLink Test PASS\n" );
> +}
> +
> +unlink <hlink/hfile*>;
> +unlink <slink/sfile*>;
> +rmdir hlink;
> +rmdir slink;
> +exit $ret;
> diff --exclude '*CVS*' -NaurP
> ./testcases/kernel/fs/linktest/linktest.sh
> ../ltp.bk/testcases/kernel/fs/linktest/linktest.sh
> --- ./testcases/kernel/fs/linktest/linktest.sh =A02009-10-14
> 12:27:10.000000000 -0700
> +++ ../ltp.bk/testcases/kernel/fs/linktest/linktest.sh =A01969-12-31
> 16:00:00.000000000 -0800
> @@ -1,76 +0,0 @@
> -#!/bin/sh
> -
> -# =A0 Copyright (c) International Business Machines =A0Corp., 2000
> -#
> -# =A0 This program is free software; =A0you can redistribute it and/or m=
odify
> -# =A0 it under the terms of the GNU General Public License as published =
by
> -# =A0 the Free Software Foundation; either version 2 of the License, or
> -# =A0 (at your option) any later version.
> -#
> -# =A0 This program is distributed in the hope that it will be useful,
> -# =A0 but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
> -# =A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
> -# =A0 the GNU General Public License for more details.
> -#
> -# =A0 You should have received a copy of the GNU General Public License
> -# =A0 along with this program; =A0if not, write to the Free Software
> -# =A0 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-130=
7 USA
> -
> -
> -#
> -# =A0FILE(s) =A0 =A0 : linktest.sh README
> -# =A0DESCRIPTION : Regression test for max links per file
> -# =A0USE =A0 =A0 =A0 =A0 : linktest.sh <number of symlinks> <number of h=
ardlinks>
> -# =A0AUTHOR =A0 =A0 =A0: Garrett Cooper (yanegomi@gmail.com)
> -# =A0HISTORY =A0 =A0 :
> -# =A0 =A0 =A0A rewrite of testcases/kernel/fs/linktest.pl
> -
> -# XXX: Change to a temp dir via mktemp -d.
> -cd "${0%/*}"
> -
> -export TCID=3Dlinker01
> -export TST_TOTAL=3D2
> -export TST_COUNT=3D1
> -
> -if [ $# -ne 2 ]; then
> - =A0 =A0 =A0 tst_res TBROK "" "Usage: $0 {softlink count} {hardlink coun=
t}"
> - =A0 =A0 =A0 exit -1
> -fi
> -
> -mkdir hlink slink && touch hlink/hfile slink/sfile
> -
> -do_link() {
> - =A0 =A0 =A0 pfix=3D$1
> - =A0 =A0 =A0 ln_opts=3D$2
> - =A0 =A0 =A0 limit=3D$3
> - =A0 =A0 =A0 prefix_msg=3D$4
> -
> - =A0 =A0 =A0 lerrors=3D0
> -
> - =A0 =A0 =A0 i=3D0
> -
> - =A0 =A0 =A0 cd ${pfix}link
> - =A0 =A0 =A0 while [ $i -lt $limit ]; do
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ! ln ${ln_opts} "$PWD/${pfix}file" ${pfi=
x}file${i}; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : $(( lerrors +=3D 1 ))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : $(( i+=3D 1 ))
> - =A0 =A0 =A0 done
> - =A0 =A0 =A0 cd ..
> -
> - =A0 =A0 =A0 if [ $lerrors -eq 0 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 RTYPE=3DTPASS
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 RTYPE=3DTFAIL
> - =A0 =A0 =A0 fi
> -
> - =A0 =A0 =A0 tst_res $RTYPE "" "$prefix_msg Link Errors: $lerrors"
> -
> - =A0 =A0 =A0 : $(( TST_COUNT +=3D 1 ))
> -
> -}
> -
> -do_link s "-s" ${1} "Symbolic"
> -do_link h =A0 "" ${2} "Hard"
> -
> -rm -Rf hlink slink
> diff --exclude '*CVS*' -NaurP ./testcases/kernel/fs/linktest/Makefile
> ../ltp.bk/testcases/kernel/fs/linktest/Makefile
> --- ./testcases/kernel/fs/linktest/Makefile =A0 =A0 2009-10-12 22:05:06.0=
00000000 -0700
> +++ ../ltp.bk/testcases/kernel/fs/linktest/Makefile =A0 =A0 2009-10-12
> 22:09:13.000000000 -0700
> @@ -24,6 +24,6 @@
>
> =A0include $(top_srcdir)/include/mk/env_pre.mk
>
> -INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D link=
test.sh
> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D link=
test.pl
>
> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk

Sorry -- the patch was reversed... the version checked into CVS just
now is correct of course :)...
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
