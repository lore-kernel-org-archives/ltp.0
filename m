Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVu32-0007wA-J7
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 21:49:40 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVu30-0002kj-4f
	for ltp-list@lists.sourceforge.net; Fri, 15 Jan 2010 21:49:40 +0000
Received: by pzk31 with SMTP id 31so879906pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 Jan 2010 13:49:32 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 15 Jan 2010 13:49:32 -0800
Message-ID: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath ) emulation
	scripts
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>, Jiri Palecek <jirka@debian.org>, Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

Hi,
    Two issues preventing LTP from being backwards compatible with
make 3.80 is the fact that the $(abspath ) and $(realpath ) functions
are missing from 3.80, and that's the primary means that the new make
infrastructure uses to map its way around the source base.
    This was written in shell, as opposed to C, so that a) it could be
used in other shell code, or b) moved to a more generic library if it
was considered valuable enough to do so. It also saved me time to
write it in shell as opposed to writing all of the C rules from
scratch in another Makefile and forcing people to run a prerequisite
step in order to produce the needed binaries. There's a performance
tradeoff, but I don't think that most people would complain in a minor
loss in performance when they can run LTP builds native on systems
without make 3.80 [by default].
    I'm not happy with the perl hack as the end of _abspath, but
awk(1) doesn't take the commented version and squish the \/{2,}
properly, and it appears to be either user error on my part (best case
scenario), or an awk bug (worst case scenario), which affects multiple
platforms and awk variants [RHEL 4.6 (gawk), Gentoo Linux (gawk),
FreeBSD 9-CURRENT (nawk)]. If you have a proper solution in sed(1) for
the squish operation, I'll apply the change.

gcooper@optimus /scratch/ltp/scripts $ tests/test_abspath.sh
test_abspath    1  TPASS  :  Test string matches expected string
_abspath(foo/bar) => foo/bar == foo/bar)
test_abspath    2  TPASS  :  Test string matches expected string
_abspath(/foo/bar) => /foo/bar == /foo/bar)
test_abspath    3  TPASS  :  Test string matches expected string
_abspath(/foo/../bar) => /bar == /bar)
test_abspath    4  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) => /foo/baz == /foo/baz)
test_abspath    5  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz/) => /foo/baz == /foo/baz)
test_abspath    6  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/) => /bar == /bar)
test_abspath    7  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/..) => / == /)
test_abspath    8  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/../) => / == /)
test_abspath    9  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) => /foo/baz == /foo/baz)
test_abspath   10  TPASS  :  Test string matches expected string
_abspath(/foo/./bar) => /foo/bar == /foo/bar)
test_abspath   11  TPASS  :  Test string matches expected string
_abspath(/./foo/./bar) => /foo/bar == /foo/bar)
test_abspath   12  TPASS  :  Test string matches expected string
_abspath(/foo//bar) => /foo/bar == /foo/bar)
test_abspath   13  TPASS  :  Test string matches expected string
_abspath(//foo/bar) => /foo/bar == /foo/bar)
test_abspath   14  TPASS  :  Test string matches expected string
_abspath(//////foo/bar) => /foo/bar == /foo/bar)
test_abspath   15  TPASS  :  Test string matches expected string
_abspath(/foo/////bar) => /foo/bar == /foo/bar)

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: abspath.sh
===================================================================
RCS file: abspath.sh
diff -N abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ abspath.sh	15 Jan 2010 21:47:45 -0000
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
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
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
===================================================================
RCS file: realpath.sh
diff -N realpath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ realpath.sh	15 Jan 2010 21:47:45 -0000
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
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
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
===================================================================
RCS file: lib/file_functions.sh
diff -N lib/file_functions.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ lib/file_functions.sh	15 Jan 2010 21:47:45 -0000
@@ -0,0 +1,39 @@
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
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+# POSIX compliant bourne shell functions for performing make 3.81
+# compliancy in 3.80 with a minimal set of external commands
+# [awk(1) and perl(1) only required].
+#
+# XXX (garrcoop): perl(1) is being used to work around a possible awk(1) bug
+# with replacing \/\/ with \/ . sed(1) doesn't work as expected either, which
+# is curious, but I'm not a sed(1) wizard, so I'm not surprised.
+#
+
+_abspath() {
+	#echo "$@" | awk '{ v=$0; sub(/\/$/, "", v); t=v; while (1) {
gsub(/\/{2,}/, "/", v); if (t == v) { break; } t=v; } while
(gsub(/\/[^\/]+\/\.\.\/?/, "/", v)) { }; while (gsub(/\/\.\//, "/",
v)) { } print v }'
+	echo "$@" | awk '{ v=$0; sub(/\/$/, "", v); t=v; while
(gsub(/\/[^\/]+\/\.\.\/?/, "/", v)) { }; while (gsub(/\/\.\//, "/",
v)) { } print v }' | perl -ple 's#/{2,}#/#'
+}
+
+_realpath() {
+	readlink -f "$@"
+}
Index: tests/test_abspath.sh
===================================================================
RCS file: tests/test_abspath.sh
diff -N tests/test_abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ tests/test_abspath.sh	15 Jan 2010 21:47:45 -0000
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
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, January 2010
+#
+
+# NOTE (garrcoop): I usually don't use bashisms, but it was just easier to
+# express these values as an array of values instead of one whacky long
+# string.
+test_strings=(     foo/bar /foo/bar /foo/../bar /foo/bar/../baz
/foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
/foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
//////foo/bar /foo/////bar )
+expected_strings=( foo/bar /foo/bar /bar        /foo/baz
/foo/baz         /bar         /              /               /foo/baz
      /foo/bar   /foo/bar     /foo/bar  /foo/bar  /foo/bar
/foo/bar )
+
+export TCID=test_abspath
+export TST_TOTAL=${#test_strings[@]}
+export TST_COUNT=1
+
+. "${0%/*}/../lib/file_functions.sh"
+
+i=0
+
+while [ $i -lt ${#test_strings[@]} ]; do
+
+	test_string=${test_strings[$i]}
+	expected_string=${expected_strings[$i]}
+
+	result=$(_abspath "$test_string")
+
+	if [ "$result" = "$expected_string" ]; then
+		result_s="matches expected string _abspath(${test_string}) =>
$result == $expected_string)"
+		result_v=TPASS
+	else
+		result_s="doesn't match expected string _abspath(${test_string}) =>
$result != $expected_string)"
+		result_v=TFAIL
+		FAILED=1
+	fi
+
+	tst_resm $result_v "Test string $result_s"
+
+	: $(( TST_COUNT += 1 ))
+	: $(( i += 1 ))
+
+done
+
+exit ${FAILED:=0}

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
