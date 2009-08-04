Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MYJCW-0004sA-1a
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:33:08 +0000
Received: from mail-qy0-f201.google.com ([209.85.221.201])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYJCR-00010s-Kh
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:33:08 +0000
MIME-Version: 1.0
In-Reply-To: <1249387670.15587.30.camel@subratamodak.linux.ibm.com>
References: <364299f40907302318o440851ewfde0b34ca561b8a2@mail.gmail.com>
	<1249298382.7460.23.camel@subratamodak.linux.ibm.com>
	<20090803141637.GA29108@us.ibm.com>
	<4A77BF38.7050201@schaufler-ca.com>
	<1249387670.15587.30.camel@subratamodak.linux.ibm.com>
Date: Tue, 4 Aug 2009 05:32:57 -0700
Message-ID: <364299f40908040532p5ce58060i22edacbf4f26416c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Quiet down smack test and check for /smack before
	continuing
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
To: subrata@linux.vnet.ibm.com
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

On Tue, Aug 4, 2009 at 5:07 AM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> Hi,
>
> On Mon, 2009-08-03 at 21:55 -0700, Casey Schaufler wrote:
>> Serge E. Hallyn wrote:
>> > I think you wanted to send this to Casey instead?
>
> True. Sorry for that.
>
>> >
>> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
>> >
>> >> Over to Mimi for review.
>> >>
>> >> Regards--
>> >> Subrata
>> >>
>> >> On Thu, 2009-07-30 at 23:18 -0700, Garrett Cooper wrote:
>> >>
>> >>> I started work on this because there's a fair amount of noise that
>> >>> currently gets generated with the smack test unnecessarily and doesn=
't
>> >>> check for /smack. There were some other items that I found that could
>> >>> be improved along the way...
>> >>>
>>
>> Wow. Thank you. I will have a look over the changes in case the
>> original intent wasn't clear enough to follow.

[...]

Well, AFAICT given the documentation smackfs can be mounted to any
mountpoint, correct?

Also, I realize now that I accidentally used a bashism -- `source
scriptname' -- I should be using the POSIX standard `. scriptname'. I
can correct that before commit after you review the changes to make
sure that they functionally make sense.

Thanks!
-Garrett

>> >>> This change in its entirety does the following:
>> >>>
>> >>> 1. Adds a prerequisite check for /smack.
>> >>> 2. Checks /smack/onlycap once per test in the smack_common.sh file
>> >>> (new file) in an effort to reduce unnecessary shell code.
>> >>> 3. Properly quote variables and echo calls so vim doesn't print thin=
gs
>> >>> out as syntax errors.
>> >>> 4. Convert all double echo calls to cat <<EOM .. EOM.
>> >>> 5. Toss unnecessary exit 0 at the bottom of a number of test scripts.
>> >>> 6. Make /smack into $smackfsdir, so folks can parameterize the
>> >>> mountpoint better (or maybe I could add code to grep through
>> >>> /proc/mounts to find a /smack mount point ;)...).
>> >>> 7. Get rid of bash's `=3D=3D' in favor of the POSIX compliant `=3D'.
>> >>>
>> >>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>> >>>
>> >>> Index: smack_common.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: smack_common.sh
>> >>> diff -N smack_common.sh
>> >>> --- /dev/null =A0 =A0 1 Jan 1970 00:00:00 -0000
>> >>> +++ smack_common.sh =A0 =A0 =A0 31 Jul 2009 06:17:05 -0000
>> >>> @@ -0,0 +1,48 @@
>> >>> +#!/bin/sh
>> >>> +#
>> >>> +# =A0 =A0testcases/security/smack/smack_common.sh
>> >>> +#
>> >>> +# =A0 =A0Copyright (C) 2009, Cisco Systems Inc.
>> >>> +#
>> >>> +# =A0 =A0This program is free software; you can redistribute it and=
/or modify
>> >>> +# =A0 =A0it under the terms of the GNU General Public License as pu=
blished by
>> >>> +# =A0 =A0the Free Software Foundation; either version 2 of the Lice=
nse, or
>> >>> +# =A0 =A0(at your option) any later version.
>> >>> +#
>> >>> +# =A0 =A0This program is distributed in the hope that it will be us=
eful,
>> >>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
>> >>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0Se=
e the
>> >>> +# =A0 =A0GNU General Public License for more details.
>> >>> +#
>> >>> +# =A0 =A0You should have received a copy of the GNU General Public =
License along
>> >>> +# =A0 =A0with this program; if not, write to the Free Software Foun=
dation, Inc.,
>> >>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> >>> +#
>> >>> +# Garrett Cooper, July 2009
>> >>> +#
>> >>> +# This file serves the sole purpose of executing every common piece=
 of
>> >>> +# prerequisite code for all of the smack tests, s.t. a lot of dupli=
cate shell
>> >>> +# code isn't laying around all over the place.
>> >>> +#
>> >>> +
>> >>> +smackfsdir=3D${smackfsdir:=3D/smack}
>> >>> +
>> >>> +check_mounted() {
>> >>> + if [ ! -d "$smackfsdir" ]; then
>> >>> + =A0 =A0 =A0 =A0 echo "smackfs not mounted at $smackfsdir"
>> >>> + =A0 =A0 =A0 =A0 exit 1
>> >>> + fi
>> >>> +}
>> >>> +
>> >>> +check_onlycap() {
>> >>> + onlycap=3D`cat "$smackfsdir/onlycap" 2>/dev/null`
>> >>> + if [ -z "$onlycap" ]; then
>> >>> + =A0 =A0 =A0 =A0 cat <<EOM
>> >>> +The smack label reported for $smackfsdir/onlycap is "$onlycap", not
>> >>> the expected "".
>> >>> +EOM
>> >>> + =A0 =A0 =A0 =A0 exit 1
>> >>> + fi
>> >>> +}
>> >>> +
>> >>> +check_mounted
>> >>> +check_onlycap
>> >>> Index: smack_file_access.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_fil=
e_access.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_file_access.sh
>> >>> --- smack_file_access.sh =A019 Mar 2009 07:27:05 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_file_access.sh =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -13,43 +13,38 @@
>> >>> =A0#
>> >>> =A0# =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 =A0=
 3 =A0 =A0 =A0 =A0 4 =A0 =A0 =A0 =A0 5 =A0 =A0 =A0 =A0 6
>> >>> =A0# =A0 =A0 =A01234567890123456789012345678901234567890123456789012=
34567890123456789
>> >>> +
>> >>> +source smack_common.sh
>> >>> +
>> >>> =A0RuleA=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TheOther =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0r---"
>> >>> =A0RuleB=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TheOther =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0rw--"
>> >>>
>> >>> =A0Where=3D"./testdir"
>> >>> =A0What=3D"testfile"
>> >>> -TestFile=3D"$Where"/"$What"
>> >>> +TestFile=3D"$Where/$What"
>> >>> =A0CAT=3D/bin/cat
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> -
>> >>> =A0if [ ! -d "$Where" ]; then
>> >>> =A0 if [ -e "$Where" ]; then
>> >>> - =A0 =A0 =A0 =A0 echo Test directory \"$Where\" exists but is not a=
 directory.
>> >>> + =A0 =A0 =A0 =A0 echo "Test directory \"$Where\" exists but is not =
a directory."
>> >>> =A0 =A0 =A0 =A0 =A0 exit 1
>> >>> =A0 fi
>> >>> - mkdir "$Where"
>> >>> + mkdir -m 777 "$Where"
>> >>> =A0 if [ ! -d "$Where" ]; then
>> >>> - =A0 =A0 =A0 =A0 echo Test directory \"$Where\" can not be created.
>> >>> + =A0 =A0 =A0 =A0 echo "Test directory \"$Where\" can not be created=
."
>> >>> =A0 =A0 =A0 =A0 =A0 exit 1
>> >>> =A0 fi
>> >>> - chmod 777 "$Where"
>> >>> =A0fi
>> >>>
>> >>> =A0if [ ! -f "$TestFile" ]; then
>> >>> =A0 if [ -e "$TestFile" ]; then
>> >>> - =A0 =A0 =A0 =A0 echo Test file \"$TestFile\" exists but is not a f=
ile.
>> >>> + =A0 =A0 =A0 =A0 echo "Test file \"$TestFile\" exists but is not a =
file."
>> >>> =A0 =A0 =A0 =A0 =A0 rm -rf "$Where"
>> >>> =A0 =A0 =A0 =A0 =A0 exit 1
>> >>> =A0 fi
>> >>> - ./notroot /bin/sh -c "echo InitialData > $TestFile"
>> >>> + ./notroot /bin/sh -c "echo InitialData 2>/dev/null > $TestFile"
>> >>> =A0 if [ ! -d "$TestFile" ]; then
>> >>> - =A0 =A0 =A0 =A0 echo Test file \"$TestFile\" can not be created.
>> >>> + =A0 =A0 =A0 =A0 echo "Test file \"$TestFile\" can not be created."
>> >>> =A0 =A0 =A0 =A0 =A0 rm -rf "$Where"
>> >>> =A0 =A0 =A0 =A0 =A0 exit 1
>> >>> =A0 fi
>> >>> @@ -60,65 +55,65 @@
>> >>> =A0SetTo=3D`echo $SetTo`
>> >>>
>> >>> =A0if [ "TheOther" !=3D "$SetTo" ]; then
>> >>> - echo Test file \"$TestFile\" labeled \"$SetTo\" incorrectly.
>> >>> + echo "Test file \"$TestFile\" labeled \"$SetTo\" incorrectly."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -OldRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> +OldRule=3D`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' T=
heOther '`
>> >>>
>> >>> -echo -n "$RuleA" > /smack/load
>> >>> -NewRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleA" > "$smackfsdir/load"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' T=
heOther '`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> =A0Mode=3D`echo $NewRule | sed -e 's/.* //'`
>> >>> =A0if [ "$Mode" !=3D "r" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -OldProc=3D`cat /proc/self/attr/current`
>> >>> +OldProc=3D`cat /proc/self/attr/current 2>/dev/null`
>> >>>
>> >>> -echo TheOne > /proc/self/attr/current
>> >>> +echo TheOne 2>/dev/null > /proc/self/attr/current
>> >>> =A0GotRead=3D`./notroot $CAT "$TestFile"`
>> >>>
>> >>> =A0if [ "$GotRead" !=3D "InitialData" ]; then
>> >>> - echo Read failed for \"$TestFile\" labeled \"TheOther\".
>> >>> + echo "Read failed for \"$TestFile\" labeled \"TheOther\"."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo NotTheOne > /proc/self/attr/current
>> >>> +echo NotTheOne 2>/dev/null > /proc/self/attr/current
>> >>> =A0GotRead=3D`./notroot $CAT "$TestFile"`
>> >>>
>> >>> -if [ "$GotRead" =3D=3D "InitialData" ]; then
>> >>> - echo Read should have failed for \"$TestFile\" labeled \"TheOther\=
".
>> >>> +if [ "$GotRead" =3D "InitialData" ]; then
>> >>> + echo "Read should have failed for \"$TestFile\" labeled \"TheOther=
\"."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo -n "$RuleB" > /smack/load
>> >>> -NewRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
>> >>> +NewRule=3D`grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' The=
Other '`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> =A0Mode=3D`echo $NewRule | sed -e 's/.* //'`
>> >>> =A0if [ "$Mode" !=3D "rw" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 rm -rf "$Where"
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> =A0if [ "$OldRule" !=3D "$NewRule" ]; then
>> >>> - echo Notice: Test access rule changed from
>> >>> - echo \"$OldRule\" to \"$NewRule\".
>> >>> + cat <<EOM
>> >>> +Notice: Test access rule changed from "$OldRule" to "$NewRule".
>> >>> +EOM
>> >>> =A0fi
>> >>>
>> >>> =A0rm -rf "$Where"
>> >>> -exit 0
>> >>> Index: smack_set_ambient.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_ambient.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_ambient.sh
>> >>> --- smack_set_ambient.sh =A019 Mar 2009 07:27:05 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_set_ambient.sh =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -9,32 +9,29 @@
>> >>> =A0# Environment:
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0#
>> >>> -NotTheFloorLabel=3D"XYZZY"
>> >>> -StartLabel=3D`cat /smack/ambient`
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +source smack_common.sh
>> >>>
>> >>> -echo $NotTheFloorLabel > /smack/ambient
>> >>> +NotTheFloorLabel=3D"XYZZY"
>> >>> +StartLabel=3D`cat "$smackfsdir/ambient" 2>/dev/null`
>> >>> +
>> >>> +echo "$NotTheFloorLabel" 2>/dev/null > "$smackfsdir/ambient"
>> >>>
>> >>> -label=3D`cat /smack/ambient`
>> >>> +label=3D`cat "$smackfsdir/ambient" 2>/dev/null`
>> >>> =A0if [ "$label" !=3D "$NotTheFloorLabel" ]; then
>> >>> - echo The smack label reported for the current process is \"$label\=
",
>> >>> - echo not the expected \"$NotTheFloorLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for the current process is "$label", not t=
he expected
>> >>> +"$NotTheFloorLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo "$StartLabel" > /smack/ambient
>> >>> +echo "$StartLabel" 2>/dev/null > "$smackfsdir/ambient"
>> >>>
>> >>> -label=3D`cat /smack/ambient`
>> >>> +label=3D`cat "$smackfsdir/ambient" 2>/dev/null`
>> >>> =A0if [ "$label" !=3D "$StartLabel" ]; then
>> >>> - echo The smack label reported for the current process is \"$label\=
",
>> >>> - echo not the expected \"$StartLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for the current process is "$label", =A0not
>> >>> the expected "$StartLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_cipso.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_cipso.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_cipso.sh
>> >>> --- smack_set_cipso.sh =A0 =A019 Mar 2009 07:27:06 -0000 =A0 =A0 =A0=
1.1
>> >>> +++ smack_set_cipso.sh =A0 =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -13,58 +13,53 @@
>> >>> =A0#
>> >>> =A0# =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 =A0 2 =A0 =A0llllCCCC=
ccccCCCCcccc =A0 =A0 5 =A0 =A0 =A0 =A0 6
>> >>> =A0# =A0 =A0 =A01234567890123456789012345678901234567890123456789012=
34567890123456789
>> >>> +
>> >>> +source smack_common.sh
>> >>> +
>> >>> =A0RuleA=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02 =A0 0 =A0 "
>> >>> =A0RuleB=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03 =A0 1 =A0 55=
 =A0"
>> >>> =A0RuleC=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04 =A0 2 =A0 17=
 =A033 =A0"
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +OldRule=3D`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
>> >>>
>> >>> -OldRule=3D`grep "^TheOne" /smack/cipso`
>> >>> -
>> >>> -echo -n "$RuleA" > /smack/cipso
>> >>> -NewRule=3D`grep "^TheOne" /smack/cipso`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/cipso"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -Right=3D`echo $NewRule | grep ' 2'`
>> >>> -if [ "$Right" =3D=3D "" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> +Right=3D`echo "$NewRule" | grep ' 2'`
>> >>> +if [ "$Right" =3D "" ]; then
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo -n "$RuleB" > /smack/cipso
>> >>> -NewRule=3D`grep "^TheOne" /smack/cipso`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/cipso"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> =A0Right=3D`echo $NewRule | grep '/55'`
>> >>> -if [ "$Right" =3D=3D "" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> +if [ "$Right" =3D "" ]; then
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo -n "$RuleC" > /smack/cipso
>> >>> -NewRule=3D`grep "^TheOne" /smack/cipso`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleC" 2>/dev/null > "$smackfsdir/cipso"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -Right=3D`echo $NewRule | grep '/17,33'`
>> >>> -if [ "$Right" =3D=3D "" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> +Right=3D`echo "$NewRule" | grep '/17,33'`
>> >>> +if [ "$Right" =3D "" ]; then
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -
>> >>> =A0if [ "$OldRule" !=3D "$NewRule" ]; then
>> >>> - echo Notice: Test access rule changed from \"$OldRule\" to \"$NewR=
ule\".
>> >>> + cat <<EOM
>> >>> +Notice: Test access rule changed from "$OldRule" to "$NewRule".
>> >>> +EOM
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_current.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_current.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_current.sh
>> >>> --- smack_set_current.sh =A019 Mar 2009 07:27:06 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_set_current.sh =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -10,32 +10,30 @@
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0# =A0 =A0 =A0 =A0/smack/onlycap unset
>> >>> =A0#
>> >>> -NotTheFloorLabel=3D"XYZZY"
>> >>> -StartLabel=3D`cat /proc/self/attr/current`
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +source smack_common.sh
>> >>>
>> >>> -echo $NotTheFloorLabel > /proc/self/attr/current
>> >>> +NotTheFloorLabel=3D"XYZZY"
>> >>> +StartLabel=3D`cat /proc/self/attr/current 2>/dev/null`
>> >>> +
>> >>> +echo "$NotTheFloorLabel" 2>/dev/null > /proc/self/attr/current
>> >>>
>> >>> -label=3D`cat /proc/self/attr/current`
>> >>> +label=3D`cat /proc/self/attr/current 2>/dev/null`
>> >>> =A0if [ "$label" !=3D "$NotTheFloorLabel" ]; then
>> >>> - echo The smack label reported for the current process is \"$label\=
",
>> >>> - echo not the expected \"$NotTheFloorLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for the current process is "$label",
>> >>> +not the expected "$NotTheFloorLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo "$StartLabel" > /proc/self/attr/current
>> >>> +echo "$StartLabel" 2>/dev/null > /proc/self/attr/current
>> >>>
>> >>> -label=3D`cat /proc/self/attr/current`
>> >>> +label=3D`cat /proc/self/attr/current > /dev/null`
>> >>> =A0if [ "$label" !=3D "$StartLabel" ]; then
>> >>> - echo The smack label reported for the current process is \"$label\=
",
>> >>> - echo not the expected \"$StartLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for the current process is "$label",
>> >>> +not the expected "$StartLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_direct.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_direct.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_direct.sh
>> >>> --- smack_set_direct.sh =A0 19 Mar 2009 07:27:06 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_set_direct.sh =A0 31 Jul 2009 06:17:05 -0000
>> >>> @@ -9,32 +9,30 @@
>> >>> =A0# Environment:
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0#
>> >>> -NotTheStartValue=3D"17"
>> >>> -StartValue=3D`cat /smack/direct`
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$onlycap\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +source smack_common.sh
>> >>>
>> >>> -echo $NotTheStartValue > /smack/direct
>> >>> +NotTheStartValue=3D"17"
>> >>> +StartValue=3D`cat "$smackfsdir/direct" 2>/dev/null`
>> >>> +
>> >>> +echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/direct"
>> >>>
>> >>> -DirectValue=3D`cat /smack/direct`
>> >>> +DirectValue=3D`cat "$smackfsdir/direct" 2>/dev/null`
>> >>> =A0if [ "$DirectValue" !=3D "$NotTheStartValue" ]; then
>> >>> - echo The CIPSO direct level reported is \"$DirectValue\",
>> >>> - echo not the expected \"$NotTheStartValue\".
>> >>> + cat <<EOM
>> >>> +The CIPSO direct level reported is "$DirectValue",
>> >>> +not the expected "$NotTheStartValue".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo "$StartValue" > /smack/direct
>> >>> +echo "$StartValue" 2>/dev/null> "$smackfsdir/direct"
>> >>>
>> >>> -DirectValue=3D`cat /smack/direct`
>> >>> +DirectValue=3D`cat "$smackfsdir/direct" 2>/dev/null`
>> >>> =A0if [ "$DirectValue" !=3D "$StartValue" ]; then
>> >>> - echo The CIPSO direct level reported is \"$DirectValue\",
>> >>> - echo not the expected \"$StartValue\".
>> >>> + cat <<EOM
>> >>> +The CIPSO direct level reported is "$DirectValue",
>> >>> +not the expected "$StartValue".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_doi.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_doi.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_doi.sh
>> >>> --- smack_set_doi.sh =A0 =A0 =A019 Mar 2009 07:27:06 -0000 =A0 =A0 =
=A01.1
>> >>> +++ smack_set_doi.sh =A0 =A0 =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -9,31 +9,31 @@
>> >>> =A0# Environment:
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0#
>> >>> -NotTheStartValue=3D"17"
>> >>> -StartValue=3D`cat /smack/doi`
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$onlycap\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +source smack_common.sh
>> >>> +
>> >>> +NotTheStartValue=3D"17"
>> >>> +StartValue=3D`cat "$smackfsdir/doi" 2>/dev/null`
>> >>>
>> >>> -echo $NotTheStartValue > /smack/doi
>> >>> +echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/doi"
>> >>>
>> >>> -DirectValue=3D`cat /smack/doi`
>> >>> +DirectValue=3D`cat "$smackfsdir/doi" 2>/dev/null`
>> >>> =A0if [ "$DirectValue" !=3D "$NotTheStartValue" ]; then
>> >>> - echo The CIPSO doi reported is \"$DirectValue\",
>> >>> - echo not the expected \"$NotTheStartValue\".
>> >>> + cat <<EOM
>> >>> +The CIPSO doi reported is "$DirectValue",
>> >>> +not the expected "$NotTheStartValue".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo "$StartValue" > /smack/doi
>> >>> +echo "$StartValue" 2>/dev/null > "$smackfsdir/doi"
>> >>>
>> >>> -DirectValue=3D`cat /smack/doi`
>> >>> +DirectValue=3D`cat "$smackfsdir/doi" 2>/dev/null`
>> >>> =A0if [ "$DirectValue" !=3D "$StartValue" ]; then
>> >>> - echo The CIPSO doi reported is \"$DirectValue\",
>> >>> - echo not the expected \"$StartValue\".
>> >>> + cat <<EOM
>> >>> +The CIPSO doi reported is "$DirectValue",
>> >>> +not the expected "$StartValue".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> Index: smack_set_load.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_load.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_load.sh
>> >>> --- smack_set_load.sh =A0 =A0 19 Mar 2009 07:27:06 -0000 =A0 =A0 =A0=
1.1
>> >>> +++ smack_set_load.sh =A0 =A0 31 Jul 2009 06:17:05 -0000
>> >>> @@ -13,45 +13,41 @@
>> >>> =A0#
>> >>> =A0# =A0 =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0 =A0 =A0 2 =A0 =A0 =A0 =A0=
 3 =A0 =A0 =A0 =A0 4 =A0 =A0 =A0 =A0 5 =A0 =A0 =A0 =A0 6
>> >>> =A0# =A0 =A0 =A01234567890123456789012345678901234567890123456789012=
34567890123456789
>> >>> +
>> >>> +source smack_common.sh
>> >>> +
>> >>> =A0RuleA=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TheOther =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0rwxa"
>> >>> =A0RuleB=3D"TheOne =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TheOther =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0r---"
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> -
>> >>> -OldRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> +OldRule=3D`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' T=
heOther '`
>> >>>
>> >>> -echo -n "$RuleA" > /smack/load
>> >>> -NewRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/load"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' T=
heOther '`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -Mode=3D`echo $NewRule | sed -e 's/.* //'`
>> >>> +Mode=3D`echo "$NewRule" | sed -e 's/.* //'`
>> >>> =A0if [ "$Mode" !=3D "rwxa" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo -n "$RuleB" > /smack/load
>> >>> -NewRule=3D`grep "^TheOne" /smack/load | grep ' TheOther '`
>> >>> -if [ "$NewRule" =3D=3D "" ]; then
>> >>> - echo Rule did not get set.
>> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
>> >>> +NewRule=3D`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' T=
heOther '`
>> >>> +if [ "$NewRule" =3D "" ]; then
>> >>> + echo "Rule did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -Mode=3D`echo $NewRule | sed -e 's/.* //'`
>> >>> +Mode=3D`echo "$NewRule" | sed -e 's/.* //'`
>> >>> =A0if [ "$Mode" !=3D "r" ]; then
>> >>> - echo Rule \"$NewRule\" is not set correctly.
>> >>> + echo "Rule \"$NewRule\" is not set correctly."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> =A0if [ "$OldRule" !=3D "$NewRule" ]; then
>> >>> - echo Notice: Test access rule changed from
>> >>> - echo \"$OldRule\" to \"$NewRule\".
>> >>> + cat <<EOM
>> >>> +Notice: Test access rule changed from
>> >>> +"$OldRule" to "$NewRule".
>> >>> +EOM
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_netlabel.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_netlabel.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_netlabel.sh
>> >>> --- smack_set_netlabel.sh 19 Mar 2009 07:27:06 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_set_netlabel.sh 31 Jul 2009 06:17:05 -0000
>> >>> @@ -9,41 +9,40 @@
>> >>> =A0# Environment:
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0#
>> >>> +
>> >>> +source smack_common.sh
>> >>> +
>> >>> =A0RuleA=3D"191.191.191.191 TheOne"
>> >>> =A0RuleA1=3D"191.191.191.191/32 TheOne"
>> >>> =A0RuleB=3D"191.190.190.0/24 TheOne"
>> >>>
>> >>> -onlycap=3D`cat /smack/onlycap`
>> >>> -if [ "$onlycap" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +Old32=3D`grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/n=
ull`
>> >>> +Old24=3D`grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/nul=
l`
>> >>>
>> >>> -Old32=3D`grep "^191.191.191.191/32" /smack/netlabel`
>> >>> -Old24=3D`grep "^191.190.190.0/24" /smack/netlabel`
>> >>> -
>> >>> -echo -n "$RuleA" > /smack/netlabel
>> >>> -New32=3D`grep "$RuleA1" /smack/netlabel`
>> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/netlabel"
>> >>> +New32=3D`grep "$RuleA1" $smackfsdir/netlabel 2>/dev/null`
>> >>> =A0if [ "$New32" !=3D "$RuleA1" ]; then
>> >>> - echo Rule \"$RuleA\" did not get set.
>> >>> + echo "Rule \"$RuleA\" did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo -n "$RuleB" > /smack/netlabel
>> >>> -New24=3D`grep "$RuleB" /smack/netlabel`
>> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/netlabel"
>> >>> +New24=3D`grep "$RuleB" "$smackfsdir/netlabel" 2>/dev/null`
>> >>> =A0if [ "$New24" !=3D "$RuleB" ]; then
>> >>> - echo Rule \"$RuleB\" did not get set.
>> >>> + echo "Rule \"$RuleB\" did not get set."
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> =A0if [ "$Old24" !=3D "$New24" ]; then
>> >>> - echo Notice: Test access rule changed from
>> >>> - echo \"$Old24\" to \"$New24\".
>> >>> + cat <<EOM
>> >>> +Notice: Test access rule changed from
>> >>> +"$Old24" to "$New24".
>> >>> +EOM
>> >>> =A0fi
>> >>> +
>> >>> =A0if [ "$Old32" !=3D "$New32" ]; then
>> >>> - echo Notice: Test access rule changed from
>> >>> - echo \"$Old32\" to \"$New32\".
>> >>> + cat <<EOM
>> >>> +Notice: Test access rule changed from
>> >>> +"$Old32" to "$New32".
>> >>> +EOM
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>> Index: smack_set_onlycap.sh
>> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set=
_onlycap.sh,v
>> >>> retrieving revision 1.1
>> >>> diff -u -r1.1 smack_set_onlycap.sh
>> >>> --- smack_set_onlycap.sh =A019 Mar 2009 07:27:06 -0000 =A0 =A0 =A01.1
>> >>> +++ smack_set_onlycap.sh =A031 Jul 2009 06:17:05 -0000
>> >>> @@ -9,31 +9,30 @@
>> >>> =A0# Environment:
>> >>> =A0# =A0 =A0 =A0 =A0CAP_MAC_ADMIN
>> >>> =A0#
>> >>> -MyLabel=3D`cat /proc/self/attr/current`
>> >>> -StartLabel=3D`cat /smack/onlycap`
>> >>>
>> >>> -if [ "$StartLabel" !=3D "" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$StartLabel\=
",
>> >>> - echo not the expected \"\".
>> >>> - exit 1
>> >>> -fi
>> >>> +source smack_common.sh
>> >>>
>> >>> -echo $MyLabel > /smack/onlycap
>> >>> +MyLabel=3D`cat /proc/self/attr/current 2>/dev/null`
>> >>> +StartLabel=3D`cat "$smackfsdir/onlycap" 2>/dev/null`
>> >>>
>> >>> -label=3D`cat /smack/onlycap`
>> >>> +echo "$MyLabel" 2>/dev/null > "$smackfsdir/onlycap"
>> >>> +
>> >>> +label=3D`cat "$smackfsdir/onlycap" 2>/dev/null`
>> >>> =A0if [ "$label" !=3D "$MyLabel" ]; then
>> >>> - echo The smack label reported for /smack/onlycap is \"$label\",
>> >>> - echo not the expected \"$MyLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for $smackfsdir/onlycap is "$label",
>> >>> +not the expected "$MyLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>>
>> >>> -echo "$StartLabel" > /smack/onlycap
>> >>> +echo "$StartLabel" 2>/dev/null > "$smackfsdir/onlycap"
>> >>>
>> >>> -label=3D`cat /smack/onlycap`
>> >>> +label=3D`cat "$smackfsdir/onlycap" 2>/dev/null`
>> >>> =A0if [ "$label" !=3D "$StartLabel" ]; then
>> >>> - echo The smack label reported for the current process is \"$label\=
",
>> >>> - echo not the expected \"$StartLabel\".
>> >>> + cat <<EOM
>> >>> +The smack label reported for the current process is "$label",
>> >>> +not the expected "$StartLabel".
>> >>> +EOM
>> >>> =A0 exit 1
>> >>> =A0fi
>> >>> -
>> >>> -exit 0
>> >>>
>> >>> --------------------------------------------------------------------=
----------
>> >>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008=
 30-Day
>> >>> trial. Simplify your report design, integration and deployment - and=
 focus on
>> >>> what you do best, core application coding. Discover what's new with
>> >>> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
>> >>> _______________________________________________
>> >>> Ltp-list mailing list
>> >>> Ltp-list@lists.sourceforge.net
>> >>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>> >>>
>> >> ---------------------------------------------------------------------=
---------
>> >> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 =
30-Day
>> >> trial. Simplify your report design, integration and deployment - and =
focus on
>> >> what you do best, core application coding. Discover what's new with
>> >> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
>> >> _______________________________________________
>> >> Ltp-list mailing list
>> >> Ltp-list@lists.sourceforge.net
>> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
>> >>
>> >
>> >
>> >
>>
>
>
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay
> trial. Simplify your report design, integration and deployment - and focu=
s on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
