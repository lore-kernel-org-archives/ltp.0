Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVuKh-0000Xy-5t
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 22:07:55 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVuKg-00078l-09
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 22:07:55 +0000
Received: by pwj11 with SMTP id 11so622213pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 Jan 2010 14:07:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
Date: Fri, 15 Jan 2010 14:07:48 -0800
Message-ID: <364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>, Jiri Palecek <jirka@debian.org>, Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

2010/1/15 Garrett Cooper <yanegomi@gmail.com>:
> Hi,
> =A0 =A0Two issues preventing LTP from being backwards compatible with
> make 3.80 is the fact that the $(abspath ) and $(realpath ) functions
> are missing from 3.80, and that's the primary means that the new make
> infrastructure uses to map its way around the source base.
> =A0 =A0This was written in shell, as opposed to C, so that a) it could be
> used in other shell code, or b) moved to a more generic library if it
> was considered valuable enough to do so. It also saved me time to
> write it in shell as opposed to writing all of the C rules from
> scratch in another Makefile and forcing people to run a prerequisite
> step in order to produce the needed binaries. There's a performance
> tradeoff, but I don't think that most people would complain in a minor
> loss in performance when they can run LTP builds native on systems
> without make 3.80 [by default].
> =A0 =A0I'm not happy with the perl hack as the end of _abspath, but
> awk(1) doesn't take the commented version and squish the \/{2,}
> properly, and it appears to be either user error on my part (best case
> scenario), or an awk bug (worst case scenario), which affects multiple
> platforms and awk variants [RHEL 4.6 (gawk), Gentoo Linux (gawk),
> FreeBSD 9-CURRENT (nawk)]. If you have a proper solution in sed(1) for
> the squish operation, I'll apply the change.
>
> gcooper@optimus /scratch/ltp/scripts $ tests/test_abspath.sh
> test_abspath =A0 =A01 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(foo/bar) =3D> foo/bar =3D=3D foo/bar)
> test_abspath =A0 =A02 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 =A03 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
> test_abspath =A0 =A04 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 =A05 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 =A06 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
> test_abspath =A0 =A07 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
> test_abspath =A0 =A08 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
> test_abspath =A0 =A09 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 10 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 11 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 12 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 13 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 14 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 15 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)

Shortly after I sent out this email, I received some helpful replies
as to why my code wasn't working. It turns out that the curly bracket
regexp quantifier operators available in many other popular
implementations of regexps (perl, python, tcl) isn't supported in awk.
Here's the new patch with less bloat.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: abspath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: abspath.sh
diff -N abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ abspath.sh	15 Jan 2010 22:04:59 -0000
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+#    make 3.81 $(abspath .. ) emulation layer
+#
+#    Copyright (C) 2010, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+
+. "${0%/*}/lib/file_functions.sh"
+
+while [ $# -gt 0 ] ; do
+	_abspath "$1"
+	shift
+done
Index: realpath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: realpath.sh
diff -N realpath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ realpath.sh	15 Jan 2010 22:04:59 -0000
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+#    make 3.81 $(realpath .. ) emulation layer
+#
+#    Copyright (C) 2010, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+
+. "${0%/*}/lib/file_functions.sh"
+
+while [ $# -gt 0 ] ; do
+	_realpath "$1"
+	shift
+done
Index: lib/file_functions.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: lib/file_functions.sh
diff -N lib/file_functions.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ lib/file_functions.sh	15 Jan 2010 22:04:59 -0000
@@ -0,0 +1,34 @@
+#!/bin/sh
+#
+# File functions utilized as part of abspath.sh, realpath.sh, etc.
+#
+#    Copyright (C) 2010, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+# POSIX compliant bourne shell functions for performing make 3.81
+# compliancy in 3.80 with a minimal set of external commands
+# [awk(1) // readlink(1) only required].
+#
+
+_abspath() {
+	echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")) { };
while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
"/")) { } print }'
+}
+
+_realpath() {
+	readlink -f "$@"
+}
Index: tests/test_abspath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: tests/test_abspath.sh
diff -N tests/test_abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ tests/test_abspath.sh	15 Jan 2010 22:04:59 -0000
@@ -0,0 +1,61 @@
+#!/bin/bash
+#
+# Test the _abspath function, utilized as part of abspath.sh
+#
+#    Copyright (C) 2010, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License alo=
ng
+#    with this program; if not, write to the Free Software Foundation, Inc=
.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+
+# NOTE (garrcoop): I usually don't use bashisms, but it was just easier to
+# express these values as an array of values instead of one whacky long
+# string.
+test_strings=3D(     foo/bar /foo/bar /foo/../bar /foo/bar/../baz
/foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
/foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
//////foo/bar /foo/////bar )
+expected_strings=3D( foo/bar /foo/bar /bar        /foo/baz
/foo/baz         /bar         /              /               /foo/baz
      /foo/bar   /foo/bar     /foo/bar  /foo/bar  /foo/bar
/foo/bar )
+
+export TCID=3Dtest_abspath
+export TST_TOTAL=3D${#test_strings[@]}
+export TST_COUNT=3D1
+
+. "${0%/*}/../lib/file_functions.sh"
+
+i=3D0
+
+while [ $i -lt ${#test_strings[@]} ]; do
+
+	test_string=3D${test_strings[$i]}
+	expected_string=3D${expected_strings[$i]}
+
+	result=3D$(_abspath "$test_string")
+
+	if [ "$result" =3D "$expected_string" ]; then
+		result_s=3D"matches expected string _abspath(${test_string}) =3D>
$result =3D=3D $expected_string)"
+		result_v=3DTPASS
+	else
+		result_s=3D"doesn't match expected string _abspath(${test_string}) =3D>
$result !=3D $expected_string)"
+		result_v=3DTFAIL
+		FAILED=3D1
+	fi
+
+	tst_resm $result_v "Test string $result_s"
+
+	: $(( TST_COUNT +=3D 1 ))
+	: $(( i +=3D 1 ))
+
+done
+
+exit ${FAILED:=3D0}

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
