Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NWpcB-0000O2-QQ
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 11:17:47 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NWpc9-0003i1-Nz
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 11:17:47 +0000
Received: by pzk28 with SMTP id 28so1532167pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 03:17:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001171741w3625baa0xe3dd6041cb1d3f31@mail.gmail.com>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<364299f41001151407s3e486c68rc8bd90db9898e20d@mail.gmail.com>
	<201001151727.40629.vapier@gentoo.org>
	<364299f41001162234k3ff212e9wb130a9b2b7a99e5b@mail.gmail.com>
	<364299f41001171716k21411e25mc49f57c906d240d8@mail.gmail.com>
	<364299f41001171741w3625baa0xe3dd6041cb1d3f31@mail.gmail.com>
Date: Mon, 18 Jan 2010 03:17:33 -0800
Message-ID: <364299f41001180317n840e769g4d073853e8e0c135@mail.gmail.com>
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Andi Kleen <andi@firstfloor.org>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>

2010/1/17 Garrett Cooper <yanegomi@gmail.com>:
> 2010/1/17 Garrett Cooper <yanegomi@gmail.com>:
>> 2010/1/16 Garrett Cooper <yanegomi@gmail.com>:
>>> 2010/1/15 Mike Frysinger <vapier@gentoo.org>:
>>>> On Friday 15 January 2010 17:07:48 Garrett Cooper wrote:
>>>>> Shortly after I sent out this email, I received some helpful replies
>>>>> as to why my code wasn't working. It turns out that the curly bracket
>>>>> regexp quantifier operators available in many other popular
>>>>> implementations of regexps (perl, python, tcl) isn't supported in awk.
>>>>> Here's the new patch with less bloat.
>>>>
>>>> the patch itself is word wrapped in the e-mail though :(
>>>>
>>>>> +_abspath() {
>>>>> + =A0 =A0 echo "$@" | awk '{ sub(/\/$/, ""); while (gsub(/\/\//, "/")=
) { };
>>>>> while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { }; while (gsub(/\/\.\//,
>>>>> "/")) { } print }'
>>>>> +}
>>>>
>>>> it's easy to line wrap awk scripts, and this sucker really needs it
>>>>
>>>> btw, this doesnt quite handle:
>>>> /a/b/c/.././
>>>>
>>>> how about this (largely untested) sed:
>>>> sed -r -e 's:/+[.]/+:/:g' -e 's:(^|/+[^/]*)/+[.][.]/+:/:g' -e 's:/+$::'
>>>>
>>>>> --- /dev/null 1 Jan 1970 00:00:00 -0000
>>>>> +++ tests/test_abspath.sh =A0 =A0 15 Jan 2010 22:04:59 -0000
>>>>> +# NOTE (garrcoop): I usually don't use bashisms, but it was just eas=
ier to
>>>>> +# express these values as an array of values instead of one whacky l=
ong
>>>>> +# string.
>>>>> +test_strings=3D( =A0 =A0 foo/bar /foo/bar /foo/../bar /foo/bar/../baz
>>>>> /foo/bar/../baz/ /foo/../bar/ /foo/../bar/.. /foo/../bar/../
>>>>> /foo/bar/../baz /foo/./bar /./foo/./bar /foo//bar //foo/bar
>>>>> //////foo/bar /foo/////bar )
>>>>> +expected_strings=3D( foo/bar /foo/bar /bar =A0 =A0 =A0 =A0/foo/baz
>>>>> /foo/baz =A0 =A0 =A0 =A0 /bar =A0 =A0 =A0 =A0 / =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /foo/baz
>>>>> =A0 =A0 =A0 /foo/bar =A0 /foo/bar =A0 =A0 /foo/bar =A0/foo/bar =A0/fo=
o/bar
>>>>> /foo/bar )
>>>>
>>>> probably be good if the source were better wrapped
>>>>
>>>> however, two parallel arrays makes it hard to correlate the input/expe=
cted
>>>> values. =A0how about something like:
>>>> set -- \
>>>> =A0 =A0 =A0 =A0foo/bar:foo/bar \
>>>> =A0 =A0 =A0 =A0/foo/bar:/foo/bar \
>>>> =A0 =A0 =A0 =A0/foo/../bar:/bar \
>>>> =A0 =A0 =A0 =A0...........
>>>>
>>>> then you can easily do:
>>>> for test in "$@" ; do
>>>> =A0 =A0 =A0 =A0input=3D${test%:*}
>>>> =A0 =A0 =A0 =A0expect=3D${test#*:}
>>>> =A0 =A0 =A0 =A0...
>>>> done
>>>>
>>>> this should be POSIX and avoid /bin/bash
>>>
>>> Version 2:
>>>
>>> 1. Incorporate comments from Mike F.
>>> 2. Resolve a negative testcase failure.
>>>
>>> gcooper@orangebox /scratch/ltp $ scripts/tests/test_abspath.sh
>>> test_abspath =A0 =A01 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(foo/bar) =3D> foo/bar =3D=3D foo/bar)
>>> test_abspath =A0 =A02 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 =A03 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
>>> test_abspath =A0 =A04 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>>> test_abspath =A0 =A05 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
>>> test_abspath =A0 =A06 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
>>> test_abspath =A0 =A07 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
>>> test_abspath =A0 =A08 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
>>> test_abspath =A0 =A09 =A0TPASS =A0: =A0Test string matches expected str=
ing
>>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>>> test_abspath =A0 10 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 11 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 12 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 13 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 14 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 15 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>>> test_abspath =A0 16 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
>>> test_abspath =A0 17 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
>>> test_abspath =A0 18 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
>>> test_abspath =A0 19 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>>> test_abspath =A0 20 =A0TPASS =A0: =A0Test string matches expected string
>>> _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>>>
>>> Index: scripts/lib/file_functions.sh
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> RCS file: scripts/lib/file_functions.sh
>>> diff -N scripts/lib/file_functions.sh
>>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>>> +++ scripts/lib/file_functions.sh =A0 =A0 =A0 17 Jan 2010 06:18:33 -0000
>>> @@ -0,0 +1,50 @@
>>> +#!/bin/sh
>>> +#
>>> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
>>> +#
>>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>>> +#
>>> +# =A0 =A0This program is free software; you can redistribute it and/or=
 modify
>>> +# =A0 =A0it under the terms of the GNU General Public License as publi=
shed by
>>> +# =A0 =A0the Free Software Foundation; either version 2 of the License=
, or
>>> +# =A0 =A0(at your option) any later version.
>>> +#
>>> +# =A0 =A0This program is distributed in the hope that it will be usefu=
l,
>>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>>> +# =A0 =A0GNU General Public License for more details.
>>> +#
>>> +# =A0 =A0You should have received a copy of the GNU General Public Lic=
ense along
>>> +# =A0 =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> +#
>>> +# Garrett Cooper, January 2010
>>> +#
>>> +# POSIX compliant bourne shell functions for performing make 3.81
>>> +# compliancy in 3.80 with a minimal set of external commands
>>> +# [awk(1) // readlink(1) only required].
>>> +#
>>> +
>>> +# 1. Replace /+ with /.
>>> +# 2. Replace a/b/../c with a/c
>>> +# 3. Replace /./ with /
>>> +# 4. Replace trailing /. with /
>>> +# 5. Replace heading ./ with /
>>> +_abspath() {
>>> + =A0 =A0 =A0 echo "$@" | awk '{
>>> + =A0 =A0 =A0 while (gsub(/\/\//, "/")) { };
>>> + =A0 =A0 =A0 while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
>>> + =A0 =A0 =A0 while (gsub(/\/\.\//, "/")) { };
>>> + =A0 =A0 =A0 sub(/(\/\.)?\/$/, "");
>>> + =A0 =A0 =A0 sub(/^\.\//, "/") ;
>>> + =A0 =A0 =A0 if ($0 =3D=3D "") {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "/";
>>> + =A0 =A0 =A0 } else {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print;
>>> + =A0 =A0 =A0 }
>>> +}'
>>> +}
>>> +
>>> +_realpath() {
>>> + =A0 =A0 =A0 readlink -f "$@"
>>> +}
>>> Index: scripts/tests/test_abspath.sh
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> RCS file: scripts/tests/test_abspath.sh
>>> diff -N scripts/tests/test_abspath.sh
>>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>>> +++ scripts/tests/test_abspath.sh =A0 =A0 =A0 17 Jan 2010 06:18:33 -0000
>>> @@ -0,0 +1,73 @@
>>> +#!/bin/sh
>>> +#
>>> +# Test the _abspath function, utilized as part of abspath.sh
>>> +#
>>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>>> +#
>>> +# =A0 =A0This program is free software; you can redistribute it and/or=
 modify
>>> +# =A0 =A0it under the terms of the GNU General Public License as publi=
shed by
>>> +# =A0 =A0the Free Software Foundation; either version 2 of the License=
, or
>>> +# =A0 =A0(at your option) any later version.
>>> +#
>>> +# =A0 =A0This program is distributed in the hope that it will be usefu=
l,
>>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>>> +# =A0 =A0GNU General Public License for more details.
>>> +#
>>> +# =A0 =A0You should have received a copy of the GNU General Public Lic=
ense along
>>> +# =A0 =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> +#
>>> +# Garrett Cooper, January 2010
>>> +#
>>> +
>>> +set -- foo/bar:foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo/../bar:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /foo/bar/../baz/:/foo/baz =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo/../bar/:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo/../bar/..:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /foo/../bar/../:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /./foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /foo//bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 //foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 //////foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /foo/////bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /a/b/c/.././:/a/b =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 /.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 ./.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> + =A0 =A0 =A0 /.foo/.bar:/.foo/.bar =A0 =A0 =A0 =A0 =A0 \
>>> + =A0 =A0 =A0 ./.foo/.bar:/.foo/.bar
>>> +
>>> +export TCID=3Dtest_abspath
>>> +export TST_TOTAL=3D$#
>>> +export TST_COUNT=3D1
>>> +
>>> +. "${0%/*}/../lib/file_functions.sh"
>>> +
>>> +for i in "$@"; do
>>> +
>>> + =A0 =A0 =A0 test_string=3D${i%:*}
>>> + =A0 =A0 =A0 expected_string=3D${i#*:}
>>> +
>>> + =A0 =A0 =A0 result=3D$(_abspath "$test_string")
>>> +
>>> + =A0 =A0 =A0 if [ "$result" =3D "$expected_string" ]; then
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"matches expected string _absp=
ath(${test_string}) =3D>
>>> $result =3D=3D $expected_string)"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTPASS
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"doesn't match expected string=
 _abspath(${test_string}) =3D>
>>> $result !=3D $expected_string)"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTFAIL
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAILED=3D1
>>> + =A0 =A0 =A0 fi
>>> +
>>> + =A0 =A0 =A0 tst_resm $result_v "Test string $result_s"
>>> +
>>> + =A0 =A0 =A0 : $(( TST_COUNT +=3D 1 ))
>>> +
>>> +done
>>> +
>>> +exit ${FAILED:=3D0}
>>> Index: scripts/abspath.sh
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> RCS file: scripts/abspath.sh
>>> diff -N scripts/abspath.sh
>>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>>> +++ scripts/abspath.sh =A017 Jan 2010 06:18:33 -0000
>>> @@ -0,0 +1,29 @@
>>> +#!/bin/sh
>>> +#
>>> +# =A0 =A0make 3.81 $(abspath .. ) emulation layer
>>> +#
>>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>>> +#
>>> +# =A0 =A0This program is free software; you can redistribute it and/or=
 modify
>>> +# =A0 =A0it under the terms of the GNU General Public License as publi=
shed by
>>> +# =A0 =A0the Free Software Foundation; either version 2 of the License=
, or
>>> +# =A0 =A0(at your option) any later version.
>>> +#
>>> +# =A0 =A0This program is distributed in the hope that it will be usefu=
l,
>>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>>> +# =A0 =A0GNU General Public License for more details.
>>> +#
>>> +# =A0 =A0You should have received a copy of the GNU General Public Lic=
ense along
>>> +# =A0 =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> +#
>>> +# Garrett Cooper, January 2010
>>> +#
>>> +
>>> +. "${0%/*}/lib/file_functions.sh"
>>> +
>>> +while [ $# -gt 0 ] ; do
>>> + =A0 =A0 =A0 _abspath "$1"
>>> + =A0 =A0 =A0 shift
>>> +done
>>> Index: scripts/realpath.sh
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> RCS file: scripts/realpath.sh
>>> diff -N scripts/realpath.sh
>>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>>> +++ scripts/realpath.sh 17 Jan 2010 06:18:33 -0000
>>> @@ -0,0 +1,29 @@
>>> +#!/bin/sh
>>> +#
>>> +# =A0 =A0make 3.81 $(realpath .. ) emulation layer
>>> +#
>>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>>> +#
>>> +# =A0 =A0This program is free software; you can redistribute it and/or=
 modify
>>> +# =A0 =A0it under the terms of the GNU General Public License as publi=
shed by
>>> +# =A0 =A0the Free Software Foundation; either version 2 of the License=
, or
>>> +# =A0 =A0(at your option) any later version.
>>> +#
>>> +# =A0 =A0This program is distributed in the hope that it will be usefu=
l,
>>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See t=
he
>>> +# =A0 =A0GNU General Public License for more details.
>>> +#
>>> +# =A0 =A0You should have received a copy of the GNU General Public Lic=
ense along
>>> +# =A0 =A0with this program; if not, write to the Free Software Foundat=
ion, Inc.,
>>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>>> +#
>>> +# Garrett Cooper, January 2010
>>> +#
>>> +
>>> +. "${0%/*}/lib/file_functions.sh"
>>> +
>>> +while [ $# -gt 0 ] ; do
>>> + =A0 =A0 =A0 _realpath "$1"
>>> + =A0 =A0 =A0 shift
>>> +done
>>>
>>
>> It appears that GNU make 3.81 makes some interesting assumptions about
>> some corner cases (`', `.', relative paths), where it does the
>> following:
>>
>> 1. relative paths automatically are prefixed with $PWD.
>> 2. `' and '.' automatically translate to $PWD.
>>
>> This diff takes that behavior into account and adds appropriate
>> testcases to match the behavior:
>>
>> gcooper@optimus /scratch/ltp $ scripts/tests/test_abspath.sh
>> test_abspath =A0 =A01 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
>> test_abspath =A0 =A02 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(.) =3D> /scratch/ltp =3D=3D /scratch/ltp)
>> test_abspath =A0 =A03 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(foo/bar) =3D> /scratch/ltp/foo/bar =3D=3D /scratch/ltp/foo/bar)
>> test_abspath =A0 =A04 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 =A05 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
>> test_abspath =A0 =A06 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>> test_abspath =A0 =A07 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
>> test_abspath =A0 =A08 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
>> test_abspath =A0 =A09 =A0TPASS =A0: =A0Test string matches expected stri=
ng
>> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
>> test_abspath =A0 10 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
>> test_abspath =A0 11 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
>> test_abspath =A0 12 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 13 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 14 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 15 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 16 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 17 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
>> test_abspath =A0 18 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
>> test_abspath =A0 19 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
>> test_abspath =A0 20 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
>> test_abspath =A0 21 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>> test_abspath =A0 22 =A0TPASS =A0: =A0Test string matches expected string
>> _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
>>
>> Unless there are some style or implementation issues with the code
>> here, I'd say it's ready for commit.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>>
>> Index: scripts/lib/file_functions.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: scripts/lib/file_functions.sh
>> diff -N scripts/lib/file_functions.sh
>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>> +++ scripts/lib/file_functions.sh =A0 =A0 =A0 18 Jan 2010 01:15:32 -0000
>> @@ -0,0 +1,64 @@
>> +#!/bin/sh
>> +#
>> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
>> +#
>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>> +#
>> +# =A0 =A0This program is free software; you can redistribute it and/or =
modify
>> +# =A0 =A0it under the terms of the GNU General Public License as publis=
hed by
>> +# =A0 =A0the Free Software Foundation; either version 2 of the License,=
 or
>> +# =A0 =A0(at your option) any later version.
>> +#
>> +# =A0 =A0This program is distributed in the hope that it will be useful,
>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> +# =A0 =A0GNU General Public License for more details.
>> +#
>> +# =A0 =A0You should have received a copy of the GNU General Public Lice=
nse along
>> +# =A0 =A0with this program; if not, write to the Free Software Foundati=
on, Inc.,
>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# Garrett Cooper, January 2010
>> +#
>> +# POSIX compliant bourne shell functions for performing make 3.81
>> +# compliancy in 3.80 with a minimal set of external commands
>> +# [awk(1) // readlink(1) only required].
>> +#
>> +
>> +# 1. Strip all heading and leading space.
>> +# 1. Replace /+ with /.
>> +# 2. Replace a/b/../c with a/c
>> +# 3. Replace /./ with /
>> +# 4. Replace trailing /. with /
>> +# 5. Replace heading ./ with /
>> +_abspath() {
>> + =A0 =A0 =A0 echo "$@" | awk -v PWD=3D$(pwd) '{
>> + =A0 =A0 =A0 sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, "")
>> + =A0 =A0 =A0 if ($0 =3D=3D "") {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print PWD
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/\//, "/")) { };
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/\.\//, "/")) { };
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub(/(\/\.)?\/$/, "");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub(/^\.\//, "/") ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($0 =3D=3D "") {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "/"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($0 =3D=3D ".") {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print PWD
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!($0 ~=
 /^\//)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 print PWD "/" $0
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 print
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +}'
>> +}
>> +
>> +_realpath() {
>> + =A0 =A0 =A0 readlink -f "$@"
>> +}
>> Index: scripts/tests/test_abspath.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: scripts/tests/test_abspath.sh
>> diff -N scripts/tests/test_abspath.sh
>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>> +++ scripts/tests/test_abspath.sh =A0 =A0 =A0 18 Jan 2010 01:15:32 -0000
>> @@ -0,0 +1,76 @@
>> +#!/bin/sh
>> +#
>> +# Test the _abspath function, utilized as part of abspath.sh
>> +#
>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>> +#
>> +# =A0 =A0This program is free software; you can redistribute it and/or =
modify
>> +# =A0 =A0it under the terms of the GNU General Public License as publis=
hed by
>> +# =A0 =A0the Free Software Foundation; either version 2 of the License,=
 or
>> +# =A0 =A0(at your option) any later version.
>> +#
>> +# =A0 =A0This program is distributed in the hope that it will be useful,
>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> +# =A0 =A0GNU General Public License for more details.
>> +#
>> +# =A0 =A0You should have received a copy of the GNU General Public Lice=
nse along
>> +# =A0 =A0with this program; if not, write to the Free Software Foundati=
on, Inc.,
>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# Garrett Cooper, January 2010
>> +#
>> +
>> +set -- \
>> + =A0 =A0 =A0 :$PWD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 .:$PWD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 foo/bar:$PWD/foo/bar =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /foo/../bar:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/bar/../baz/:/foo/baz =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /foo/../bar/:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /foo/../bar/..:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/../bar/../:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /./foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /foo//bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 //foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 //////foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /foo/////bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /a/b/c/.././:/a/b =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 /.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 ./.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>> + =A0 =A0 =A0 /.foo/.bar:/.foo/.bar =A0 =A0 =A0 =A0 =A0 \
>> + =A0 =A0 =A0 ./.foo/.bar:/.foo/.bar
>> +
>> +export TCID=3Dtest_abspath
>> +export TST_TOTAL=3D$#
>> +export TST_COUNT=3D1
>> +
>> +. "${0%/*}/../lib/file_functions.sh"
>> +
>> +for i in "$@"; do
>> +
>> + =A0 =A0 =A0 test_string=3D${i%:*}
>> + =A0 =A0 =A0 expected_string=3D${i#*:}
>> +
>> + =A0 =A0 =A0 result=3D$(_abspath "$test_string")
>> +
>> + =A0 =A0 =A0 if [ "$result" =3D "$expected_string" ]; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"matches expected string _abspa=
th(${test_string}) =3D>
>> $result =3D=3D $expected_string)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTPASS
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"doesn't match expected string =
_abspath(${test_string}) =3D>
>> $result !=3D $expected_string)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTFAIL
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAILED=3D1
>> + =A0 =A0 =A0 fi
>> +
>> + =A0 =A0 =A0 tst_resm $result_v "Test string $result_s"
>> +
>> + =A0 =A0 =A0 : $(( TST_COUNT +=3D 1 ))
>> +
>> +done
>> +
>> +exit ${FAILED:=3D0}
>> Index: scripts/abspath.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: scripts/abspath.sh
>> diff -N scripts/abspath.sh
>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>> +++ scripts/abspath.sh =A018 Jan 2010 01:15:32 -0000
>> @@ -0,0 +1,29 @@
>> +#!/bin/sh
>> +#
>> +# =A0 =A0make 3.81 $(abspath .. ) emulation layer
>> +#
>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>> +#
>> +# =A0 =A0This program is free software; you can redistribute it and/or =
modify
>> +# =A0 =A0it under the terms of the GNU General Public License as publis=
hed by
>> +# =A0 =A0the Free Software Foundation; either version 2 of the License,=
 or
>> +# =A0 =A0(at your option) any later version.
>> +#
>> +# =A0 =A0This program is distributed in the hope that it will be useful,
>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> +# =A0 =A0GNU General Public License for more details.
>> +#
>> +# =A0 =A0You should have received a copy of the GNU General Public Lice=
nse along
>> +# =A0 =A0with this program; if not, write to the Free Software Foundati=
on, Inc.,
>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# Garrett Cooper, January 2010
>> +#
>> +
>> +. "${0%/*}/lib/file_functions.sh"
>> +
>> +while [ $# -gt 0 ] ; do
>> + =A0 =A0 =A0 _abspath "$1"
>> + =A0 =A0 =A0 shift
>> +done
>> Index: scripts/realpath.sh
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: scripts/realpath.sh
>> diff -N scripts/realpath.sh
>> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
>> +++ scripts/realpath.sh 18 Jan 2010 01:15:32 -0000
>> @@ -0,0 +1,29 @@
>> +#!/bin/sh
>> +#
>> +# =A0 =A0make 3.81 $(realpath .. ) emulation layer
>> +#
>> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
>> +#
>> +# =A0 =A0This program is free software; you can redistribute it and/or =
modify
>> +# =A0 =A0it under the terms of the GNU General Public License as publis=
hed by
>> +# =A0 =A0the Free Software Foundation; either version 2 of the License,=
 or
>> +# =A0 =A0(at your option) any later version.
>> +#
>> +# =A0 =A0This program is distributed in the hope that it will be useful,
>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> +# =A0 =A0GNU General Public License for more details.
>> +#
>> +# =A0 =A0You should have received a copy of the GNU General Public Lice=
nse along
>> +# =A0 =A0with this program; if not, write to the Free Software Foundati=
on, Inc.,
>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# Garrett Cooper, January 2010
>> +#
>> +
>> +. "${0%/*}/lib/file_functions.sh"
>> +
>> +while [ $# -gt 0 ] ; do
>> + =A0 =A0 =A0 _realpath "$1"
>> + =A0 =A0 =A0 shift
>> +done
>>
>
> Of course me being conservative and curious, I discovered a coverage
> gap (the .sh files themselves). This fixes that behavior because the
> output from abspath.sh // realpath.sh had newlines in it before. make
> 3.81 calls to $(abspath ) // $(realpath ) don't have newlines in them
> and while make does a pretty good job at mashing newlines in
> variables, I'd rather take the conservative route and ensure that the
> end-behavior in the emulation scripts matches the behavior in make
> verbatim:
>
> gcooper@optimus /scratch/ltp $ scripts/tests/test_abspath.sh
> test_abspath =A0 =A01 =A0TPASS =A0: =A0Test string matches expected string
> _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
> test_abspath =A0 =A02 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(.) =3D> /scratch/ltp =3D=3D /scratch/ltp)
> test_abspath =A0 =A03 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(foo/bar) =3D> /scratch/ltp/foo/bar =3D=3D /scratch/ltp/foo/bar)
> test_abspath =A0 =A04 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 =A05 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
> test_abspath =A0 =A06 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 =A07 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 =A08 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
> test_abspath =A0 =A09 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/..) =3D> / =3D=3D /)
> test_abspath =A0 10 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/../bar/../) =3D> / =3D=3D /)
> test_abspath =A0 11 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
> test_abspath =A0 12 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 13 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 14 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 15 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 16 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 17 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
> test_abspath =A0 18 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
> test_abspath =A0 19 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/.foo) =3D> /.foo =3D=3D /.foo)
> test_abspath =A0 20 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(./.foo) =3D> /.foo =3D=3D /.foo)
> test_abspath =A0 21 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
> test_abspath =A0 22 =A0TPASS =A0: =A0Test string matches expected string
> _abspath(./.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
> test_abspath =A0 23 =A0TPASS =A0: =A0Test string matches expected string
> _abspath() =3D> /scratch/ltp =3D=3D /scratch/ltp)
> test_abspath =A0 24 =A0TPASS =A0: =A0Test string matches expected string
> _abspath("" .) =3D> /scratch/ltp /scratch/ltp =3D=3D /scratch/ltp
> /scratch/ltp)
>
> Index: scripts/lib/file_functions.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/lib/file_functions.sh
> diff -N scripts/lib/file_functions.sh
> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
> +++ scripts/lib/file_functions.sh =A0 =A0 =A0 18 Jan 2010 01:40:35 -0000
> @@ -0,0 +1,64 @@
> +#!/bin/sh
> +#
> +# File functions utilized as part of abspath.sh, realpath.sh, etc.
> +#
> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
> +#
> +# =A0 =A0This program is free software; you can redistribute it and/or m=
odify
> +# =A0 =A0it under the terms of the GNU General Public License as publish=
ed by
> +# =A0 =A0the Free Software Foundation; either version 2 of the License, =
or
> +# =A0 =A0(at your option) any later version.
> +#
> +# =A0 =A0This program is distributed in the hope that it will be useful,
> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> +# =A0 =A0GNU General Public License for more details.
> +#
> +# =A0 =A0You should have received a copy of the GNU General Public Licen=
se along
> +# =A0 =A0with this program; if not, write to the Free Software Foundatio=
n, Inc.,
> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +# POSIX compliant bourne shell functions for performing make 3.81
> +# compliancy in 3.80 with a minimal set of external commands
> +# [awk(1) // readlink(1) only required].
> +#
> +
> +# 1. Strip all heading and leading space.
> +# 1. Replace /+ with /.
> +# 2. Replace a/b/../c with a/c
> +# 3. Replace /./ with /
> +# 4. Replace trailing /. with /
> +# 5. Replace heading ./ with /
> +_abspath() {
> + =A0 =A0 =A0 echo "$@" | awk -v PWD=3D$(pwd) '{
> + =A0 =A0 =A0 sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, "")
> + =A0 =A0 =A0 if ($0 =3D=3D "") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 print PWD
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/\//, "/")) { };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/[^\/]+\/\.\.\/?/, "/")) { };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (gsub(/\/\.\//, "/")) { };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub(/(\/\.)?\/$/, "");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sub(/^\.\//, "/") ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($0 =3D=3D "") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "/"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ($0 =3D=3D ".") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 print PWD
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!($0 ~ =
/^\//)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 print PWD "/" $0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 print
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +}'
> +}
> +
> +_realpath() {
> + =A0 =A0 =A0 readlink -f "$@"
> +}
> Index: scripts/tests/test_abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/tests/test_abspath.sh
> diff -N scripts/tests/test_abspath.sh
> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
> +++ scripts/tests/test_abspath.sh =A0 =A0 =A0 18 Jan 2010 01:40:35 -0000
> @@ -0,0 +1,110 @@
> +#!/bin/sh
> +#
> +# Test the _abspath function, utilized as part of abspath.sh
> +#
> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
> +#
> +# =A0 =A0This program is free software; you can redistribute it and/or m=
odify
> +# =A0 =A0it under the terms of the GNU General Public License as publish=
ed by
> +# =A0 =A0the Free Software Foundation; either version 2 of the License, =
or
> +# =A0 =A0(at your option) any later version.
> +#
> +# =A0 =A0This program is distributed in the hope that it will be useful,
> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> +# =A0 =A0GNU General Public License for more details.
> +#
> +# =A0 =A0You should have received a copy of the GNU General Public Licen=
se along
> +# =A0 =A0with this program; if not, write to the Free Software Foundatio=
n, Inc.,
> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +set -- \
> + =A0 =A0 =A0 :$PWD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .:$PWD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 foo/bar:$PWD/foo/bar =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /foo/../bar:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/bar/../baz/:/foo/baz =A0 =A0 =A0 \
> + =A0 =A0 =A0 /foo/../bar/:/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /foo/../bar/..:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/../bar/../:/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /foo/bar/../baz:/foo/baz =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /./foo/./bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /foo//bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 //foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 //////foo/bar:/foo/bar =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /foo/////bar:/foo/bar =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /a/b/c/.././:/a/b =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 /.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 ./.foo:/.foo =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 /.foo/.bar:/.foo/.bar =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 ./.foo/.bar:/.foo/.bar
> +
> +export TCID=3Dtest_abspath
> +export TST_TOTAL=3D$#
> +export TST_COUNT=3D1
> +
> +SCRIPTS_DIR=3D"${0%/*}/.."
> +
> +. "$SCRIPTS_DIR/lib/file_functions.sh"
> +
> +for i in "$@"; do
> +
> + =A0 =A0 =A0 test_string=3D${i%:*}
> + =A0 =A0 =A0 expected_string=3D${i#*:}
> +
> + =A0 =A0 =A0 result=3D$(_abspath "$test_string")
> +
> + =A0 =A0 =A0 if [ "$result" =3D "$expected_string" ] ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"matches expected string _abspat=
h(${test_string}) =3D>
> $result =3D=3D $expected_string)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTPASS
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_s=3D"doesn't match expected string _=
abspath(${test_string}) =3D>
> $result !=3D $expected_string)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 result_v=3DTFAIL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FAILED=3D1
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 tst_resm $result_v "Test string $result_s"
> +
> + =A0 =A0 =A0 : $(( TST_COUNT +=3D 1 ))
> +
> +done
> +
> +expected_string=3D"$PWD"
> +test_string=3D''
> +result=3D$("$SCRIPTS_DIR/abspath.sh" "$test_string")
> +
> +if [ "$result" =3D "$expected_string" ] ; then
> + =A0 =A0 =A0 result_s=3D"matches expected string _abspath(${test_string}=
) =3D>
> $result =3D=3D $expected_string)"
> +else
> + =A0 =A0 =A0 result_s=3D"doesn't match expected string _abspath(${test_s=
tring}) =3D>
> $result !=3D $expected_string)"
> + =A0 =A0 =A0 result_v=3DTFAIL
> + =A0 =A0 =A0 FAILED=3D1
> +fi
> +
> +tst_resm $result_v "Test string $result_s"
> +
> +: $(( TST_COUNT +=3D 1 ))
> +
> +expected_string=3D"$PWD $PWD"
> +test_string=3D"\"\" ."
> +result=3D$("$SCRIPTS_DIR/abspath.sh" "" .)
> +
> +if [ "$result" =3D "$expected_string" ] ; then
> + =A0 =A0 =A0 result_s=3D"matches expected string _abspath(${test_string}=
) =3D>
> $result =3D=3D $expected_string)"
> +else
> + =A0 =A0 =A0 result_s=3D"doesn't match expected string _abspath(${test_s=
tring}) =3D>
> $result !=3D $expected_string)"
> + =A0 =A0 =A0 result_v=3DTFAIL
> + =A0 =A0 =A0 FAILED=3D1
> +fi
> +
> +tst_resm $result_v "Test string $result_s"
> +
> +: $(( TST_COUNT +=3D 1 ))
> +
> +exit ${FAILED:=3D0}
> Index: scripts/abspath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/abspath.sh
> diff -N scripts/abspath.sh
> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
> +++ scripts/abspath.sh =A018 Jan 2010 01:40:35 -0000
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +# =A0 =A0make 3.81 $(abspath .. ) emulation layer
> +#
> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
> +#
> +# =A0 =A0This program is free software; you can redistribute it and/or m=
odify
> +# =A0 =A0it under the terms of the GNU General Public License as publish=
ed by
> +# =A0 =A0the Free Software Foundation; either version 2 of the License, =
or
> +# =A0 =A0(at your option) any later version.
> +#
> +# =A0 =A0This program is distributed in the hope that it will be useful,
> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> +# =A0 =A0GNU General Public License for more details.
> +#
> +# =A0 =A0You should have received a copy of the GNU General Public Licen=
se along
> +# =A0 =A0with this program; if not, write to the Free Software Foundatio=
n, Inc.,
> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> + =A0 =A0 =A0 echo -n $(_abspath "$1")
> + =A0 =A0 =A0 [ $# -gt 1 ] && echo -n " "
> + =A0 =A0 =A0 shift
> +done
> Index: scripts/realpath.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: scripts/realpath.sh
> diff -N scripts/realpath.sh
> --- /dev/null =A0 1 Jan 1970 00:00:00 -0000
> +++ scripts/realpath.sh 18 Jan 2010 01:40:35 -0000
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +# =A0 =A0make 3.81 $(realpath .. ) emulation layer
> +#
> +# =A0 =A0Copyright (C) 2010, Cisco Systems Inc.
> +#
> +# =A0 =A0This program is free software; you can redistribute it and/or m=
odify
> +# =A0 =A0it under the terms of the GNU General Public License as publish=
ed by
> +# =A0 =A0the Free Software Foundation; either version 2 of the License, =
or
> +# =A0 =A0(at your option) any later version.
> +#
> +# =A0 =A0This program is distributed in the hope that it will be useful,
> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> +# =A0 =A0GNU General Public License for more details.
> +#
> +# =A0 =A0You should have received a copy of the GNU General Public Licen=
se along
> +# =A0 =A0with this program; if not, write to the Free Software Foundatio=
n, Inc.,
> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#
> +# Garrett Cooper, January 2010
> +#
> +
> +. "${0%/*}/lib/file_functions.sh"
> +
> +while [ $# -gt 0 ] ; do
> + =A0 =A0 =A0 echo -n $(_realpath "$1")
> + =A0 =A0 =A0 [ $# -gt 1 ] && echo -n " "
> + =A0 =A0 =A0 shift
> +done

Summary:
Resolve one final corner case required for make 3.80 compatibility to
be complete (../.. -> $PWD/../..):
1. Add two additional testcases for the above corner case.
2. Fix expected output for ./.foo:/.foo and ./.foo/.bar:/.foo/.bar
testcases; each of the expected results should have been correct from
$PWD, as the input path was relative from $PWD.
2. Revise the library to use sub instead of gsub because it's being
called from a loop already.
3. Reorder steps to correct for corner case. and document

I'm confident that this is 100% ok for commit now after my subsequent
testing and careful inspection. Committing this will enable 3.80
compilation in mainline after I uncomment the $(error ) in env_pre.mk.

gcooper@optimus /scratch/ltp $ ./scripts/tests/test_abspath.sh
test_abspath    1  TPASS  :  Test string matches expected string
_abspath() =3D> /scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
test_abspath    2  TPASS  :  Test string matches expected string
_abspath(.) =3D> /scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
test_abspath    3  TPASS  :  Test string matches expected string
_abspath(foo/bar) =3D> /scratch/ltp/scripts/lib/foo/bar =3D=3D
/scratch/ltp/scripts/lib/foo/bar)
test_abspath    4  TPASS  :  Test string matches expected string
_abspath(/foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath    5  TPASS  :  Test string matches expected string
_abspath(/foo/../bar) =3D> /bar =3D=3D /bar)
test_abspath    6  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath    7  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz/) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath    8  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/) =3D> /bar =3D=3D /bar)
test_abspath    9  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/..) =3D> / =3D=3D /)
test_abspath   10  TPASS  :  Test string matches expected string
_abspath(/foo/../bar/../) =3D> / =3D=3D /)
test_abspath   11  TPASS  :  Test string matches expected string
_abspath(/foo/bar/../baz) =3D> /foo/baz =3D=3D /foo/baz)
test_abspath   12  TPASS  :  Test string matches expected string
_abspath(/foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   13  TPASS  :  Test string matches expected string
_abspath(/./foo/./bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   14  TPASS  :  Test string matches expected string
_abspath(/foo//bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   15  TPASS  :  Test string matches expected string
_abspath(//foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   16  TPASS  :  Test string matches expected string
_abspath(//////foo/bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   17  TPASS  :  Test string matches expected string
_abspath(/foo/////bar) =3D> /foo/bar =3D=3D /foo/bar)
test_abspath   18  TPASS  :  Test string matches expected string
_abspath(/a/b/c/.././) =3D> /a/b =3D=3D /a/b)
test_abspath   19  TPASS  :  Test string matches expected string
_abspath(/.foo) =3D> /.foo =3D=3D /.foo)
test_abspath   20  TPASS  :  Test string matches expected string
_abspath(./.foo) =3D> /scratch/ltp/scripts/lib/.foo =3D=3D
/scratch/ltp/scripts/lib/.foo)
test_abspath   21  TPASS  :  Test string matches expected string
_abspath(/.foo/.bar) =3D> /.foo/.bar =3D=3D /.foo/.bar)
test_abspath   22  TPASS  :  Test string matches expected string
_abspath(./.foo/.bar) =3D> /scratch/ltp/scripts/lib/.foo/.bar =3D=3D
/scratch/ltp/scripts/lib/.foo/.bar)
test_abspath   23  TPASS  :  Test string matches expected string
_abspath(/scratch/ltp/testcases/realtime/../..) =3D> /scratch/ltp =3D=3D
/scratch/ltp)
test_abspath   24  TPASS  :  Test string matches expected string
_abspath(..) =3D> /scratch/ltp/scripts =3D=3D /scratch/ltp/scripts)
test_abspath   25  TPASS  :  Test string matches expected string
_abspath(../..) =3D> /scratch/ltp =3D=3D /scratch/ltp)
test_abspath   26  TPASS  :  Test string matches expected string
_abspath(testcases/kernel/controllers/libcontrollers/../../../..) =3D>
/scratch/ltp/scripts/lib =3D=3D /scratch/ltp/scripts/lib)
test_abspath   27  TPASS  :  Test string matches expected string
abspath.sh "" =3D> /scratch/ltp =3D=3D /scratch/ltp)
test_abspath   28  TPASS  :  Test string matches expected string
abspath.sh "" . =3D> /scratch/ltp /scratch/ltp =3D=3D /scratch/ltp
/scratch/ltp)

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: scripts/abspath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/abspath.sh
diff -N scripts/abspath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/abspath.sh	18 Jan 2010 11:13:32 -0000
@@ -0,0 +1,30 @@
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
+	echo -n $(_abspath "$1")
+	[ $# -gt 1 ] && echo -n " "
+	shift
+done
Index: scripts/realpath.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/realpath.sh
diff -N scripts/realpath.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/realpath.sh	18 Jan 2010 11:13:32 -0000
@@ -0,0 +1,30 @@
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
+	echo -n $(_realpath "$1")
+	[ $# -gt 1 ] && echo -n " "
+	shift
+done
Index: scripts/lib/file_functions.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: scripts/lib/file_functions.sh
diff -N scripts/lib/file_functions.sh
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ scripts/lib/file_functions.sh	18 Jan 2010 11:13:32 -0000
@@ -0,0 +1,71 @@
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
+# 0. Strip all heading and leading space.
+# Paths:
+# 1. Empty string - print out $PWD.
+# 2. Not empty string...
+#    i. Prefix all relative paths with $PWD.
+#    ii. Replace /+ with /.
+#    iii. Replace a/b/../c with a/c
+#    iv. Replace /./ with /
+#    v. Replace trailing /. with /
+#    vi. Replace heading ./ with /
+#    vii. Replace /. with "".
+
+# testcases/kernel/controllers/libcontrollers/../../../..
+_abspath() {
+	echo "$@" | awk -v PWD=3D$(pwd) '{
+	sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, ""); # 1.
+	if ($0 =3D=3D "") {
+		print PWD
+	} else {
+		if (!($0 ~ /^\//)) { # i.
+			$0 =3D PWD "/" $0
+		}
+		while (gsub(/\/\//, "/")) { }; # ii.
+		while (sub(/\/[^\/]+\/\.\.\/?/, "/")) { }; # iii.
+		while (sub(/\/\.\//, "/")) { }; # iv.
+		sub(/(\/\.)?\/$/, "");
+		sub(/^\.\//, "/");
+		sub(/\/\.$/, "");
+		if ($0 =3D=3D "") {
+			print "/"
+		} else {
+			if ($0 =3D=3D ".") {
+				print PWD
+			} else {
+				print
+			}
+		}
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
+++ scripts/tests/test_abspath.sh	18 Jan 2010 11:13:32 -0000
@@ -0,0 +1,121 @@
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
+SCRIPTS_DIR=3D"$(readlink -f ${0%/*}/..)"
+TEST_PATH=3D$("$SCRIPTS_DIR/realpath.sh" "$SCRIPTS_DIR/lib")
+
+pushd "$TEST_PATH" >/dev/null
+
+set --	\
+	:$PWD								\
+	.:$PWD								\
+	foo/bar:$PWD/foo/bar						\
+	/foo/bar:/foo/bar						\
+	/foo/../bar:/bar				 		\
+	/foo/bar/../baz:/foo/baz				 	\
+	/foo/bar/../baz/:/foo/baz				 	\
+	/foo/../bar/:/bar 						\
+	/foo/../bar/..:/ 						\
+	/foo/../bar/../:/ 						\
+	/foo/bar/../baz:/foo/baz				 	\
+	/foo/./bar:/foo/bar				 		\
+	/./foo/./bar:/foo/bar						\
+	/foo//bar:/foo/bar						\
+	//foo/bar:/foo/bar						\
+	//////foo/bar:/foo/bar						\
+	/foo/////bar:/foo/bar						\
+	/a/b/c/.././:/a/b						\
+	/.foo:/.foo							\
+	./.foo:$PWD/.foo						\
+	/.foo/.bar:/.foo/.bar						\
+	./.foo/.bar:$PWD/.foo/.bar					\
+	/scratch/ltp/testcases/realtime/../..:/scratch/ltp		\
+	..:$(dirname "$TEST_PATH")					\
+	../..:$(dirname "$(dirname "$TEST_PATH")")			\
+	testcases/kernel/controllers/libcontrollers/../../../..:$PWD
+
+export TCID=3Dtest_abspath
+export TST_TOTAL=3D$#
+export TST_COUNT=3D1
+
+. "$SCRIPTS_DIR/lib/file_functions.sh"
+
+for i in "$@"; do
+
+	test_string=3D${i%:*}
+	expected_string=3D${i#*:}
+
+	result=3D$(_abspath "$test_string")
+
+	if [ "$result" =3D "$expected_string" ] ; then
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
+popd >/dev/null
+
+expected_string=3D"$PWD"
+test_string=3D'""'
+result=3D$("$SCRIPTS_DIR/abspath.sh" "")
+
+if [ "$result" =3D "$expected_string" ] ; then
+	result_s=3D"matches expected string abspath.sh ${test_string} =3D>
$result =3D=3D $expected_string)"
+	result_v=3DTPASS
+else
+	result_s=3D"doesn't match expected string abspath.sh ${test_string} =3D>
$result !=3D $expected_string)"
+	result_v=3DTFAIL
+	FAILED=3D1
+fi
+
+tst_resm $result_v "Test string $result_s"
+
+: $(( TST_COUNT +=3D 1 ))
+
+expected_string=3D"$PWD $PWD"
+test_string=3D"\"\" ."
+result=3D$("$SCRIPTS_DIR/abspath.sh" "" .)
+
+if [ "$result" =3D "$expected_string" ] ; then
+	result_s=3D"matches expected string abspath.sh ${test_string} =3D>
$result =3D=3D $expected_string)"
+	result_v=3DTPASS
+else
+	result_s=3D"doesn't match expected string abspath.sh ${test_string} =3D>
$result !=3D $expected_string)"
+	result_v=3DTFAIL
+	FAILED=3D1
+fi
+
+tst_resm $result_v "Test string $result_s"
+
+: $(( TST_COUNT +=3D 1 ))
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
