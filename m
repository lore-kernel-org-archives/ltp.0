Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWOiR-00048A-6B
	for ltp-list@lists.sourceforge.net; Sun, 17 Jan 2010 06:34:27 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWOiO-0002dj-Rm
	for ltp-list@lists.sourceforge.net; Sun, 17 Jan 2010 06:34:27 +0000
Received: by pwj11 with SMTP id 11so1256288pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Sat, 16 Jan 2010 22:34:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201001151727.40629.vapier@gentoo.org>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
	<201001151727.40629.vapier@gentoo.org>
Date: Sat, 16 Jan 2010 22:34:18 -0800
Message-ID: <364299f41001162234k3ff212e9wb130a9b2b7a99e5b@mail.gmail.com>
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

2010/1/15 Mike Frysinger <vapier@gentoo.org>:
> On Friday 15 January 2010 17:07:48 Garrett Cooper wrote:
>> Shortly after I sent out this email, I received some helpful replies
>> as to why my code wasn't working. It turns out that the curly bracket
>> regexp quantifier operators available in many other popular
>> implementations of regexps (perl, python, tcl) isn't supported in awk.
>> Here's the new patch with less bloat.
>
> the patch itself is word wrapped in the e-mail though :(
>
>> +_abspath() {
>> + =A0 =A0 echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")) {=
 };
>> while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
>> "/")) { } print }'
>> +}
>
> it's easy to line wrap awk scripts, and this sucker really needs it
>
> btw, this doesnt quite handle:
> /a/b/c/.././
>
> how about this (largely untested) sed:
> sed -r -e 's:/+[.]/+:/:g' -e 's:(^|/+[^/]*)/+[.][.]/+:/:g' -e 's:/+$::'
>
>> --- /dev/null 1 Jan 1970 00:00:00 -0000
>> +++ tests/test_abspath.sh =A0 =A0 15 Jan 2010 22:04:59 -0000
>> +# NOTE (garrcoop): I usually don't use bashisms, but it was just easier=
 to
>> +# express these values as an array of values instead of one whacky long
>> +# string.
>> +test_strings=3D( =A0 =A0 foo/bar /foo/bar /foo/../bar /foo/bar/../baz
>> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
>> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
>> //////foo/bar /foo/////bar )
>> +expected_strings=3D( foo/bar /foo/bar /bar =A0 =A0 =A0 =A0/foo/baz
>> /foo/baz =A0 =A0 =A0 =A0 /bar =A0 =A0 =A0 =A0 / =A0 =A0 =A0 =A0 =A0 =A0 =
=A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /foo/baz
>> =A0 =A0 =A0 /foo/bar =A0 /foo/bar =A0 =A0 /foo/bar =A0/foo/bar =A0/foo/b=
ar
>> /foo/bar )
>
> probably be good if the source were better wrapped
>
> however, two parallel arrays makes it hard to correlate the input/expected
> values. =A0how about something like:
> set -- \
> =A0 =A0 =A0 =A0foo/bar:foo/bar \
> =A0 =A0 =A0 =A0/foo/bar:/foo/bar \
> =A0 =A0 =A0 =A0/foo/../bar:/bar \
> =A0 =A0 =A0 =A0...........
>
> then you can easily do:
> for test in "$@" ; do
> =A0 =A0 =A0 =A0input=3D${test%:*}
> =A0 =A0 =A0 =A0expect=3D${test#*:}
> =A0 =A0 =A0 =A0...
> done
>
> this should be POSIX and avoid /bin/bash

Version 2:

1. Incorporate comments from Mike F.
2. Resolve a negative testcase failure.

gcooper@orangebox /scratch/ltp $ scripts/tests/test_abspath.sh
test_abspath    1  TPASS  :  Test string matches expected string
_abspath(foo/bar) =3D> foo/bar =3D=3D foo/bar)
test_abspath    2  TPASS  :  Test string matches expected string
_abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath    3  TPASS  :  Test string matches expected string
_abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
test_abspath    4  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath    5  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath    6  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
test_abspath    7  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/..) =3D> / =3D=3D /)
test_abspath    8  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/../) =3D> / =3D=3D /)
test_abspath    9  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath   10  TPASS  :  Test string matches expected string
_abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   11  TPASS  :  Test string matches expected string
_abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   12  TPASS  :  Test string matches expected string
_abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   13  TPASS  :  Test string matches expected string
_abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   14  TPASS  :  Test string matches expected string
_abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   15  TPASS  :  Test string matches expected string
_abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   16  TPASS  :  Test string matches expected string
_abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
test_abspath   17  TPASS  :  Test string matches expected string
_abspath(/.foo) =3D> /.foo =3D=3D /.foo)
test_abspath   18  TPASS  :  Test string matches expected string
_abspath(./.foo) =3D> /.foo =3D=3D /.foo)
test_abspath   19  TPASS  :  Test string matches expected string
_abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
test_abspath   20  TPASS  :  Test string matches expected string
_abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)

Index: scripts/lib/file_functions.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/lib/file_functions.sh
diff -N scripts/lib/file_functions.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/lib/file_functions.sh	17 Jan 2010 06:18:33 -0000
@@ -0,0 +1,50 @@
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
+# 1. Replace /+ with /.
+# 2. Replace a/b/../c with a/c
+# 3. Replace /./ with /
+# 4. Replace trailing /. with /
+# 5. Replace heading ./ with /
+_abspath() {
+	echo "$@" | awk '{
+	while (gsub(/\/\//, "/")) { };
+	while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
+	while (gsub(/\/\.\//, "/")) { };
+	sub(/(\/\.)?\/$/, "");
+	sub(/^\.\//, "/") ;
+	if ($0 =3D=3D "") {
+		print "/";
+	} else {
+		print;
+	}
+}'
+}
+
+_realpath() {
+	readlink -f "$@"
+}
Index: scripts/tests/test_abspath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/tests/test_abspath.sh
diff -N scripts/tests/test_abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/tests/test_abspath.sh	17 Jan 2010 06:18:33 -0000
@@ -0,0 +1,73 @@
+#!/bin/sh
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
+set --	foo/bar:foo/bar			\
+	/foo/bar:/foo/bar		\
+	/foo/../bar:/bar 		\
+	/foo/bar/../baz:/foo/baz 	\
+	/foo/bar/../baz/:/foo/baz 	\
+	/foo/../bar/:/bar 		\
+	/foo/../bar/..:/ 		\
+	/foo/../bar/../:/ 		\
+	/foo/bar/../baz:/foo/baz 	\
+	/foo/./bar:/foo/bar 		\
+	/./foo/./bar:/foo/bar		\
+	/foo//bar:/foo/bar		\
+	//foo/bar:/foo/bar		\
+	//////foo/bar:/foo/bar		\
+	/foo/////bar:/foo/bar		\
+	/a/b/c/.././:/a/b		\
+	/.foo:/.foo			\
+	./.foo:/.foo			\
+	/.foo/.bar:/.foo/.bar		\
+	./.foo/.bar:/.foo/.bar
+
+export TCID=3Dtest_abspath
+export TST_TOTAL=3D$#
+export TST_COUNT=3D1
+
+. "${0%/*}/../lib/file_functions.sh"
+
+for i in "$@"; do
+
+	test_string=3D${i%:*}
+	expected_string=3D${i#*:}
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
+
+done
+
+exit ${FAILED:=3D0}
Index: scripts/abspath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/abspath.sh
diff -N scripts/abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/abspath.sh	17 Jan 2010 06:18:33 -0000
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
Index: scripts/realpath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/realpath.sh
diff -N scripts/realpath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/realpath.sh	17 Jan 2010 06:18:33 -0000
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
