Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1NWzco-0006ms-8O
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 21:59:06 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWzcm-0001Q7-EV
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 21:59:06 +0000
Received: by pwj11 with SMTP id 11so2208265pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 13:58:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
Date: Mon, 18 Jan 2010 13:58:58 -0800
Message-ID: <b9d696241001181358g6a9c212by27da3451e4c6d0c3@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
	emulation scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8046573525059068334=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, Mike Frysinger <vapier@gentoo.org>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

--===============8046573525059068334==
Content-Type: multipart/alternative; boundary=000e0cd1388ed796a1047d777576

--000e0cd1388ed796a1047d777576
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Garrett,

Is there a bug when trying to make with version 3.81?

I just tried compiling LTP 2009.1231 today, and I get:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
configure: WARNING: linux/genetlink.h: present but cannot be compiled
configure: WARNING: linux/genetlink.h:     check for missing prerequisite
headers?
configure: WARNING: linux/genetlink.h: see the Autoconf documentation
configure: WARNING: linux/genetlink.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/genetlink.h: proceeding with the compiler's resul=
t
configure: WARNING:     ## ------------------------------------------------
##
configure: WARNING:     ## Report this to ltp-results@lists.sourceforge.net=
##
configure: WARNING:     ## ------------------------------------------------
##
configure: WARNING: linux/netlink.h: present but cannot be compiled
configure: WARNING: linux/netlink.h:     check for missing prerequisite
headers?
configure: WARNING: linux/netlink.h: see the Autoconf documentation
configure: WARNING: linux/netlink.h:     section "Present But Cannot Be
Compiled"
configure: WARNING: linux/netlink.h: proceeding with the compiler's result
configure: WARNING:     ## ------------------------------------------------
##
configure: WARNING:     ## Report this to ltp-results@lists.sourceforge.net=
##
configure: WARNING:     ## ------------------------------------------------
##

ltp-pan.c: In function =91run_child=92:
ltp-pan.c:886: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:887: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:893: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:894: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:901: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:902: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:928: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:929: warning: ignoring return value of =91write=92, declared with
attribute warn_unused_result
ltp-pan.c:952: warning: ignoring return value of =91read=92, declared with
attribute warn_unused_result
ltp-scanner.o: In function `main':
/var/tmp/kdlucas/ltp-full-20091231/pan/ltp-scanner.c:163: undefined
reference to `lex_files'
/var/tmp/kdlucas/ltp-full-20091231/pan/ltp-scanner.c:166: undefined
reference to `scanner'
tag_report.o: In function `cuts_testcase':
/var/tmp/kdlucas/ltp-full-20091231/pan/tag_report.c:431: undefined referenc=
e
to `yytext'
collect2: ld returned 1 exit status
make[1]: *** [ltp-scanner] Error 1
make: *** [pan-all] Error 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Any ideas?

Kelly

2010/1/15 Garrett Cooper <yanegomi@gmail.com>

> Hi,
>    Two issues preventing LTP from being backwards compatible with
> make 3.80 is the fact that the $(abspath ) and $(realpath ) functions
> are missing from 3.80, and that's the primary means that the new make
> infrastructure uses to map its way around the source base.
>    This was written in shell, as opposed to C, so that a) it could be
> used in other shell code, or b) moved to a more generic library if it
> was considered valuable enough to do so. It also saved me time to
> write it in shell as opposed to writing all of the C rules from
> scratch in another Makefile and forcing people to run a prerequisite
> step in order to produce the needed binaries. There's a performance
> tradeoff, but I don't think that most people would complain in a minor
> loss in performance when they can run LTP builds native on systems
> without make 3.80 [by default].
>    I'm not happy with the perl hack as the end of _abspath, but
> awk(1) doesn't take the commented version and squish the \/{2,}
> properly, and it appears to be either user error on my part (best case
> scenario), or an awk bug (worst case scenario), which affects multiple
> platforms and awk variants [RHEL 4.6 (gawk), Gentoo Linux (gawk),
> FreeBSD 9-CURRENT (nawk)]. If you have a proper solution in sed(1) for
> the squish operation, I'll apply the change.
>
> gcooper@optimus /scratch/ltp/scripts $ tests/test_abspath.sh
> test_abspath    1  TPASS  :  Test string matches expected string
> _abspath(foo/bar) =3D> foo/bar =3D=3D foo/bar)
> test_abspath    2  TPASS  :  Test string matches expected string
> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath    3  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
> test_abspath    4  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath    5  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath    6  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
> test_abspath    7  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
> test_abspath    8  TPASS  :  Test string matches expected string
> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
> test_abspath    9  TPASS  :  Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath   10  TPASS  :  Test string matches expected string
> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   11  TPASS  :  Test string matches expected string
> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   12  TPASS  :  Test string matches expected string
> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   13  TPASS  :  Test string matches expected string
> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   14  TPASS  :  Test string matches expected string
> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath   15  TPASS  :  Test string matches expected string
> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: abspath.sh
> diff -N abspath.sh
> --- /dev/null   1 Jan 1970 00:00:00 -0000
> +++ abspath.sh  15 Jan 2010 21:47:45 -0000
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +#
> +#    make 3.81 $(abspath .. ) emulation layer
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modif=
y
> +#    it under the terms of the GNU General Public License as published b=
y
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License
> along
> +#    with this program; if not, write to the Free Software Foundation,
> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> +       _abspath "$1"
> +       shift
> +done
> Index: realpath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: realpath.sh
> diff -N realpath.sh
> --- /dev/null   1 Jan 1970 00:00:00 -0000
> +++ realpath.sh 15 Jan 2010 21:47:45 -0000
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +#
> +#    make 3.81 $(realpath .. ) emulation layer
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modif=
y
> +#    it under the terms of the GNU General Public License as published b=
y
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License
> along
> +#    with this program; if not, write to the Free Software Foundation,
> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> +       _realpath "$1"
> +       shift
> +done
> Index: lib/file_functions.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: lib/file_functions.sh
> diff -N lib/file_functions.sh
> --- /dev/null   1 Jan 1970 00:00:00 -0000
> +++ lib/file_functions.sh       15 Jan 2010 21:47:45 -0000
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +#
> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modif=
y
> +#    it under the terms of the GNU General Public License as published b=
y
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License
> along
> +#    with this program; if not, write to the Free Software Foundation,
> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +# POSIX compliant bourne shell functions for performing make 3.81
> +# compliancy in 3.80 with a minimal set of external commands
> +# [awk(1) and perl(1) only required].
> +#
> +# XXX (garrcoop): perl(1) is being used to work around a possible awk(1)
> bug
> +# with replacing \/\/ with \/ . sed(1) doesn't work as expected either,
> which
> +# is curious, but I'm not a sed(1) wizard, so I'm not surprised.
> +#
> +
> +_abspath() {
> +       #echo "$@" | awk '{ v=3D$0; sub(/\/$/, "", v); t=3Dv; while (1) {
> gsub(/\/{2,}/, "/", v); if (t =3D=3D v) { break; } t=3Dv; } while
> (gsub(/\/[^\/]+\/\.\.\/?/, "/", v)) { }; while (gsub(/\/\.\//, "/",
> v)) { } print v }'
> +       echo "$@" | awk '{ v=3D$0; sub(/\/$/, "", v); t=3Dv; while
> (gsub(/\/[^\/]+\/\.\.\/?/, "/", v)) { }; while (gsub(/\/\.\//, "/",
> v)) { } print v }' | perl -ple 's#/{2,}#/#'
> +}
> +
> +_realpath() {
> +       readlink -f "$@"
> +}
> Index: tests/test_abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: tests/test_abspath.sh
> diff -N tests/test_abspath.sh
> --- /dev/null   1 Jan 1970 00:00:00 -0000
> +++ tests/test_abspath.sh       15 Jan 2010 21:47:45 -0000
> @@ -0,0 +1,61 @@
> +#!/bin/bash
> +#
> +# Test the _abspath function, utilized as part of abspath.sh
> +#
> +#    Copyright (C) 2010, Cisco Systems Inc.
> +#
> +#    This program is free software; you can redistribute it and/or modif=
y
> +#    it under the terms of the GNU General Public License as published b=
y
> +#    the Free Software Foundation; either version 2 of the License, or
> +#    (at your option) any later version.
> +#
> +#    This program is distributed in the hope that it will be useful,
> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +#    GNU General Public License for more details.
> +#
> +#    You should have received a copy of the GNU General Public License
> along
> +#    with this program; if not, write to the Free Software Foundation,
> Inc.,
> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +# NOTE (garrcoop): I usually don't use bashisms, but it was just easier =
to
> +# express these values as an array of values instead of one whacky long
> +# string.
> +test_strings=3D(     foo/bar /foo/bar /foo/../bar /foo/bar/../baz
> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
> //////foo/bar /foo/////bar )
> +expected_strings=3D( foo/bar /foo/bar /bar        /foo/baz
> /foo/baz         /bar         /              /               /foo/baz
>      /foo/bar   /foo/bar     /foo/bar  /foo/bar  /foo/bar
> /foo/bar )
> +
> +export TCID=3Dtest_abspath
> +export TST_TOTAL=3D${#test_strings[@]}
> +export TST_COUNT=3D1
> +
> +. "${0%/*}/../lib/file_functions.sh"
> +
> +i=3D0
> +
> +while [ $i -lt ${#test_strings[@]} ]; do
> +
> +       test_string=3D${test_strings[$i]}
> +       expected_string=3D${expected_strings[$i]}
> +
> +       result=3D$(_abspath "$test_string")
> +
> +       if [ "$result" =3D "$expected_string" ]; then
> +               result_s=3D"matches expected string _abspath(${test_strin=
g})
> =3D>
> $result =3D=3D $expected_string)"
> +               result_v=3DTPASS
> +       else
> +               result_s=3D"doesn't match expected string
> _abspath(${test_string}) =3D>
> $result !=3D $expected_string)"
> +               result_v=3DTFAIL
> +               FAILED=3D1
> +       fi
> +
> +       tst_resm $result_v "Test string $result_s"
> +
> +       : $(( TST_COUNT +=3D 1 ))
> +       : $(( i +=3D 1 ))
> +
> +done
> +
> +exit ${FAILED:=3D0}
>
>
> -------------------------------------------------------------------------=
-----
> Throughout its 18-year history, RSA Conference consistently attracts the
> world's best and brightest in the field, creating opportunities for
> Conference
> attendees to learn about information security's most important issues
> through
> interactions with peers, luminaries and emerging and established companie=
s.
> http://p.sf.net/sfu/rsaconf-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



--=20
K.D. Lucas
kdlucas@gmail.com

--000e0cd1388ed796a1047d777576
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Garrett,<br><br>Is there a bug when trying to make with version 3.81?<br><b=
r>I just tried compiling LTP 2009.1231 today, and I get:<br>=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>configure: WARNING: linux/=
genetlink.h: present but cannot be compiled<br>
configure: WARNING: linux/genetlink.h:=A0=A0=A0=A0 check for missing prereq=
uisite headers?<br>configure: WARNING: linux/genetlink.h: see the Autoconf =
documentation<br>configure: WARNING: linux/genetlink.h:=A0=A0=A0=A0 section=
 &quot;Present But Cannot Be Compiled&quot;<br>
configure: WARNING: linux/genetlink.h: proceeding with the compiler&#39;s r=
esult<br>configure: WARNING:=A0=A0=A0=A0 ## -------------------------------=
----------------- ##<br>configure: WARNING:=A0=A0=A0=A0 ## Report this to <=
a href=3D"mailto:ltp-results@lists.sourceforge.net">ltp-results@lists.sourc=
eforge.net</a> ##<br>
configure: WARNING:=A0=A0=A0=A0 ## ----------------------------------------=
-------- ##<br>configure: WARNING: linux/netlink.h: present but cannot be c=
ompiled<br>configure: WARNING: linux/netlink.h:=A0=A0=A0=A0 check for missi=
ng prerequisite headers?<br>
configure: WARNING: linux/netlink.h: see the Autoconf documentation<br>conf=
igure: WARNING: linux/netlink.h:=A0=A0=A0=A0 section &quot;Present But Cann=
ot Be Compiled&quot;<br>configure: WARNING: linux/netlink.h: proceeding wit=
h the compiler&#39;s result<br>
configure: WARNING:=A0=A0=A0=A0 ## ----------------------------------------=
-------- ##<br>configure: WARNING:=A0=A0=A0=A0 ## Report this to <a href=3D=
"mailto:ltp-results@lists.sourceforge.net">ltp-results@lists.sourceforge.ne=
t</a> ##<br>configure: WARNING:=A0=A0=A0=A0 ## ----------------------------=
-------------------- ##<br>
<br>ltp-pan.c: In function =91run_child=92:<br>ltp-pan.c:886: warning: igno=
ring return value of =91write=92, declared with attribute warn_unused_resul=
t<br>ltp-pan.c:887: warning: ignoring return value of =91write=92, declared=
 with attribute warn_unused_result<br>
ltp-pan.c:893: warning: ignoring return value of =91write=92, declared with=
 attribute warn_unused_result<br>ltp-pan.c:894: warning: ignoring return va=
lue of =91write=92, declared with attribute warn_unused_result<br>ltp-pan.c=
:901: warning: ignoring return value of =91write=92, declared with attribut=
e warn_unused_result<br>
ltp-pan.c:902: warning: ignoring return value of =91write=92, declared with=
 attribute warn_unused_result<br>ltp-pan.c:928: warning: ignoring return va=
lue of =91write=92, declared with attribute warn_unused_result<br>ltp-pan.c=
:929: warning: ignoring return value of =91write=92, declared with attribut=
e warn_unused_result<br>
ltp-pan.c:952: warning: ignoring return value of =91read=92, declared with =
attribute warn_unused_result<br>ltp-scanner.o: In function `main&#39;:<br>/=
var/tmp/kdlucas/ltp-full-20091231/pan/ltp-scanner.c:163: undefined referenc=
e to `lex_files&#39;<br>
/var/tmp/kdlucas/ltp-full-20091231/pan/ltp-scanner.c:166: undefined referen=
ce to `scanner&#39;<br>tag_report.o: In function `cuts_testcase&#39;:<br>/v=
ar/tmp/kdlucas/ltp-full-20091231/pan/tag_report.c:431: undefined reference =
to `yytext&#39;<br>
collect2: ld returned 1 exit status<br>make[1]: *** [ltp-scanner] Error 1<b=
r>make: *** [pan-all] Error 2<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br><br>Any ideas?<br><br>Kelly<br><br><div class=
=3D"gmail_quote">
2010/1/15 Garrett Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@g=
mail.com">yanegomi@gmail.com</a>&gt;</span><br><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi,<br>
 =A0 =A0Two issues preventing LTP from being backwards compatible with<br>
make 3.80 is the fact that the $(abspath ) and $(realpath ) functions<br>
are missing from 3.80, and that&#39;s the primary means that the new make<b=
r>
infrastructure uses to map its way around the source base.<br>
 =A0 =A0This was written in shell, as opposed to C, so that a) it could be<=
br>
used in other shell code, or b) moved to a more generic library if it<br>
was considered valuable enough to do so. It also saved me time to<br>
write it in shell as opposed to writing all of the C rules from<br>
scratch in another Makefile and forcing people to run a prerequisite<br>
step in order to produce the needed binaries. There&#39;s a performance<br>
tradeoff, but I don&#39;t think that most people would complain in a minor<=
br>
loss in performance when they can run LTP builds native on systems<br>
without make 3.80 [by default].<br>
 =A0 =A0I&#39;m not happy with the perl hack as the end of _abspath, but<br=
>
awk(1) doesn&#39;t take the commented version and squish the \/{2,}<br>
properly, and it appears to be either user error on my part (best case<br>
scenario), or an awk bug (worst case scenario), which affects multiple<br>
platforms and awk variants [RHEL 4.6 (gawk), Gentoo Linux (gawk),<br>
FreeBSD 9-CURRENT (nawk)]. If you have a proper solution in sed(1) for<br>
the squish operation, I&#39;ll apply the change.<br>
<br>
gcooper@optimus /scratch/ltp/scripts $ tests/test_abspath.sh<br>
test_abspath =A0 =A01 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(foo/bar) =3D&gt; foo/bar =3D=3D foo/bar)<br>
test_abspath =A0 =A02 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 =A03 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/../bar) =3D&gt; /bar =3D=3D /bar)<br>
test_abspath =A0 =A04 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/bar/../baz) =3D&gt; /foo/baz =3D=3D /foo/baz)<br>
test_abspath =A0 =A05 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/bar/../baz/) =3D&gt; /foo/baz =3D=3D /foo/baz)<br>
test_abspath =A0 =A06 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/../bar/) =3D&gt; /bar =3D=3D /bar)<br>
test_abspath =A0 =A07 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/../bar/..) =3D&gt; / =3D=3D /)<br>
test_abspath =A0 =A08 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/../bar/../) =3D&gt; / =3D=3D /)<br>
test_abspath =A0 =A09 =A0TPASS =A0: =A0Test string matches expected string<=
br>
_abspath(/foo/bar/../baz) =3D&gt; /foo/baz =3D=3D /foo/baz)<br>
test_abspath =A0 10 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(/foo/./bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 11 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(/./foo/./bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 12 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(/foo//bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 13 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(//foo/bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 14 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(//////foo/bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
test_abspath =A0 15 =A0TPASS =A0: =A0Test string matches expected string<br=
>
_abspath(/foo/////bar) =3D&gt; /foo/bar =3D=3D /foo/bar)<br>
<br>
Signed-off-by: Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmail.com">yan=
egomi@gmail.com</a>&gt;<br>
<br>
Index: abspath.sh<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: abspath.sh<br>
diff -N abspath.sh<br>
--- /dev/null =A0 1 Jan 1970 00:00:00 -0000<br>
+++ abspath.sh =A015 Jan 2010 21:47:45 -0000<br>
@@ -0,0 +1,29 @@<br>
+#!/bin/sh<br>
+#<br>
+# =A0 =A0make 3.81 $(abspath .. ) emulation layer<br>
+#<br>
+# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.<br>
+#<br>
+# =A0 =A0This program is free software; you can redistribute it and/or mod=
ify<br>
+# =A0 =A0it under the terms of the GNU General Public License as published=
 by<br>
+# =A0 =A0the Free Software Foundation; either version 2 of the License, or=
<br>
+# =A0 =A0(at your option) any later version.<br>
+#<br>
+# =A0 =A0This program is distributed in the hope that it will be useful,<b=
r>
+# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<b=
r>
+# =A0 =A0GNU General Public License for more details.<br>
+#<br>
+# =A0 =A0You should have received a copy of the GNU General Public License=
 along<br>
+# =A0 =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,<br>
+# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
+# Garrett Cooper, January 2010<br>
+#<br>
+<br>
+. &quot;${0%/*}/lib/file_functions.sh&quot;<br>
+<br>
+while [ $# -gt 0 ] ; do<br>
+ =A0 =A0 =A0 _abspath &quot;$1&quot;<br>
+ =A0 =A0 =A0 shift<br>
+done<br>
Index: realpath.sh<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: realpath.sh<br>
diff -N realpath.sh<br>
--- /dev/null =A0 1 Jan 1970 00:00:00 -0000<br>
+++ realpath.sh 15 Jan 2010 21:47:45 -0000<br>
@@ -0,0 +1,29 @@<br>
+#!/bin/sh<br>
+#<br>
+# =A0 =A0make 3.81 $(realpath .. ) emulation layer<br>
+#<br>
+# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.<br>
+#<br>
+# =A0 =A0This program is free software; you can redistribute it and/or mod=
ify<br>
+# =A0 =A0it under the terms of the GNU General Public License as published=
 by<br>
+# =A0 =A0the Free Software Foundation; either version 2 of the License, or=
<br>
+# =A0 =A0(at your option) any later version.<br>
+#<br>
+# =A0 =A0This program is distributed in the hope that it will be useful,<b=
r>
+# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<b=
r>
+# =A0 =A0GNU General Public License for more details.<br>
+#<br>
+# =A0 =A0You should have received a copy of the GNU General Public License=
 along<br>
+# =A0 =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,<br>
+# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
+# Garrett Cooper, January 2010<br>
+#<br>
+<br>
+. &quot;${0%/*}/lib/file_functions.sh&quot;<br>
+<br>
+while [ $# -gt 0 ] ; do<br>
+ =A0 =A0 =A0 _realpath &quot;$1&quot;<br>
+ =A0 =A0 =A0 shift<br>
+done<br>
Index: lib/file_functions.sh<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: lib/file_functions.sh<br>
diff -N lib/file_functions.sh<br>
--- /dev/null =A0 1 Jan 1970 00:00:00 -0000<br>
+++ lib/file_functions.sh =A0 =A0 =A0 15 Jan 2010 21:47:45 -0000<br>
@@ -0,0 +1,39 @@<br>
+#!/bin/sh<br>
+#<br>
+# File functions utilized as part of abspath.sh, realpath.sh, etc.<br>
+#<br>
+# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.<br>
+#<br>
+# =A0 =A0This program is free software; you can redistribute it and/or mod=
ify<br>
+# =A0 =A0it under the terms of the GNU General Public License as published=
 by<br>
+# =A0 =A0the Free Software Foundation; either version 2 of the License, or=
<br>
+# =A0 =A0(at your option) any later version.<br>
+#<br>
+# =A0 =A0This program is distributed in the hope that it will be useful,<b=
r>
+# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<b=
r>
+# =A0 =A0GNU General Public License for more details.<br>
+#<br>
+# =A0 =A0You should have received a copy of the GNU General Public License=
 along<br>
+# =A0 =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,<br>
+# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
+# Garrett Cooper, January 2010<br>
+#<br>
+# POSIX compliant bourne shell functions for performing make 3.81<br>
+# compliancy in 3.80 with a minimal set of external commands<br>
+# [awk(1) and perl(1) only required].<br>
+#<br>
+# XXX (garrcoop): perl(1) is being used to work around a possible awk(1) b=
ug<br>
+# with replacing \/\/ with \/ . sed(1) doesn&#39;t work as expected either=
, which<br>
+# is curious, but I&#39;m not a sed(1) wizard, so I&#39;m not surprised.<b=
r>
+#<br>
+<br>
+_abspath() {<br>
+ =A0 =A0 =A0 #echo &quot;$@&quot; | awk &#39;{ v=3D$0; sub(/\/$/, &quot;&q=
uot;, v); t=3Dv; while (1) {<br>
gsub(/\/{2,}/, &quot;/&quot;, v); if (t =3D=3D v) { break; } t=3Dv; } while=
<br>
(gsub(/\/[^\/]+\/\.\.\/?/, &quot;/&quot;, v)) { }; while (gsub(/\/\.\//, &q=
uot;/&quot;,<br>
v)) { } print v }&#39;<br>
+ =A0 =A0 =A0 echo &quot;$@&quot; | awk &#39;{ v=3D$0; sub(/\/$/, &quot;&qu=
ot;, v); t=3Dv; while<br>
(gsub(/\/[^\/]+\/\.\.\/?/, &quot;/&quot;, v)) { }; while (gsub(/\/\.\//, &q=
uot;/&quot;,<br>
v)) { } print v }&#39; | perl -ple &#39;s#/{2,}#/#&#39;<br>
+}<br>
+<br>
+_realpath() {<br>
+ =A0 =A0 =A0 readlink -f &quot;$@&quot;<br>
+}<br>
Index: tests/test_abspath.sh<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
RCS file: tests/test_abspath.sh<br>
diff -N tests/test_abspath.sh<br>
--- /dev/null =A0 1 Jan 1970 00:00:00 -0000<br>
+++ tests/test_abspath.sh =A0 =A0 =A0 15 Jan 2010 21:47:45 -0000<br>
@@ -0,0 +1,61 @@<br>
+#!/bin/bash<br>
+#<br>
+# Test the _abspath function, utilized as part of abspath.sh<br>
+#<br>
+# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.<br>
+#<br>
+# =A0 =A0This program is free software; you can redistribute it and/or mod=
ify<br>
+# =A0 =A0it under the terms of the GNU General Public License as published=
 by<br>
+# =A0 =A0the Free Software Foundation; either version 2 of the License, or=
<br>
+# =A0 =A0(at your option) any later version.<br>
+#<br>
+# =A0 =A0This program is distributed in the hope that it will be useful,<b=
r>
+# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of<br=
>
+# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<b=
r>
+# =A0 =A0GNU General Public License for more details.<br>
+#<br>
+# =A0 =A0You should have received a copy of the GNU General Public License=
 along<br>
+# =A0 =A0with this program; if not, write to the Free Software Foundation,=
 Inc.,<br>
+# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.<br>
+#<br>
+# Garrett Cooper, January 2010<br>
+#<br>
+<br>
+# NOTE (garrcoop): I usually don&#39;t use bashisms, but it was just easie=
r to<br>
+# express these values as an array of values instead of one whacky long<br=
>
+# string.<br>
+test_strings=3D( =A0 =A0 foo/bar /foo/bar /foo/../bar /foo/bar/../baz<br>
/foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../<br>
/foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar<br>
//////foo/bar /foo/////bar )<br>
+expected_strings=3D( foo/bar /foo/bar /bar =A0 =A0 =A0 =A0/foo/baz<br>
/foo/baz =A0 =A0 =A0 =A0 /bar =A0 =A0 =A0 =A0 / =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /foo/baz<br>
 =A0 =A0 =A0/foo/bar =A0 /foo/bar =A0 =A0 /foo/bar =A0/foo/bar =A0/foo/bar<=
br>
/foo/bar )<br>
+<br>
+export TCID=3Dtest_abspath<br>
+export TST_TOTAL=3D${#test_strings[@]}<br>
+export TST_COUNT=3D1<br>
+<br>
+. &quot;${0%/*}/../lib/file_functions.sh&quot;<br>
+<br>
+i=3D0<br>
+<br>
+while [ $i -lt ${#test_strings[@]} ]; do<br>
+<br>
+ =A0 =A0 =A0 test_string=3D${test_strings[$i]}<br>
+ =A0 =A0 =A0 expected_string=3D${expected_strings[$i]}<br>
+<br>
+ =A0 =A0 =A0 result=3D$(_abspath &quot;$test_string&quot;)<br>
+<br>
+ =A0 =A0 =A0 if [ &quot;$result&quot; =3D &quot;$expected_string&quot; ]; =
then<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D&quot;matches expected string _abs=
path(${test_string}) =3D&gt;<br>
$result =3D=3D $expected_string)&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTPASS<br>
+ =A0 =A0 =A0 else<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D&quot;doesn&#39;t match expected s=
tring _abspath(${test_string}) =3D&gt;<br>
$result !=3D $expected_string)&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTFAIL<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAILED=3D1<br>
+ =A0 =A0 =A0 fi<br>
+<br>
+ =A0 =A0 =A0 tst_resm $result_v &quot;Test string $result_s&quot;<br>
+<br>
+ =A0 =A0 =A0 : $(( TST_COUNT +=3D 1 ))<br>
+ =A0 =A0 =A0 : $(( i +=3D 1 ))<br>
+<br>
+done<br>
+<br>
+exit ${FAILED:=3D0}<br>
<br>
---------------------------------------------------------------------------=
---<br>
Throughout its 18-year history, RSA Conference consistently attracts the<br=
>
world&#39;s best and brightest in the field, creating opportunities for Con=
ference<br>
attendees to learn about information security&#39;s most important issues t=
hrough<br>
interactions with peers, luminaries and emerging and established companies.=
<br>
<a href=3D"http://p.sf.net/sfu/rsaconf-dev2dev" target=3D"_blank">http://p.=
sf.net/sfu/rsaconf-dev2dev</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a href=
=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--000e0cd1388ed796a1047d777576--


--===============8046573525059068334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============8046573525059068334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8046573525059068334==--

