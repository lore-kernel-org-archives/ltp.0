Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYIoU-0001D9-Ft
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:18 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYIoO-0004jS-UE
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:08:18 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A77BF38.7050201@schaufler-ca.com>
References: <364299f40907302318o440851ewfde0b34ca561b8a2@mail.gmail.com>
	<1249298382.7460.23.camel@subratamodak.linux.ibm.com>
	<20090803141637.GA29108@us.ibm.com> <4A77BF38.7050201@schaufler-ca.com>
Date: Tue, 04 Aug 2009 17:37:42 +0530
Message-Id: <1249387670.15587.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Quiet down smack test and check for /smack
	before	continuing
Reply-To: subrata@linux.vnet.ibm.com
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
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

Hi,

On Mon, 2009-08-03 at 21:55 -0700, Casey Schaufler wrote: 
> Serge E. Hallyn wrote:
> > I think you wanted to send this to Casey instead?

True. Sorry for that.

> >
> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> >   
> >> Over to Mimi for review.
> >>
> >> Regards--
> >> Subrata
> >>
> >> On Thu, 2009-07-30 at 23:18 -0700, Garrett Cooper wrote: 
> >>     
> >>> I started work on this because there's a fair amount of noise that
> >>> currently gets generated with the smack test unnecessarily and doesn't
> >>> check for /smack. There were some other items that I found that could
> >>> be improved along the way...
> >>>       
> 
> Wow. Thank you. I will have a look over the changes in case the
> original intent wasn't clear enough to follow.

Thanks.

Regards--
Subrata

> 
> 
> >>> This change in its entirety does the following:
> >>>
> >>> 1. Adds a prerequisite check for /smack.
> >>> 2. Checks /smack/onlycap once per test in the smack_common.sh file
> >>> (new file) in an effort to reduce unnecessary shell code.
> >>> 3. Properly quote variables and echo calls so vim doesn't print things
> >>> out as syntax errors.
> >>> 4. Convert all double echo calls to cat <<EOM .. EOM.
> >>> 5. Toss unnecessary exit 0 at the bottom of a number of test scripts.
> >>> 6. Make /smack into $smackfsdir, so folks can parameterize the
> >>> mountpoint better (or maybe I could add code to grep through
> >>> /proc/mounts to find a /smack mount point ;)...).
> >>> 7. Get rid of bash's `==' in favor of the POSIX compliant `='.
> >>>
> >>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >>>
> >>> Index: smack_common.sh
> >>> ===================================================================
> >>> RCS file: smack_common.sh
> >>> diff -N smack_common.sh
> >>> --- /dev/null	1 Jan 1970 00:00:00 -0000
> >>> +++ smack_common.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -0,0 +1,48 @@
> >>> +#!/bin/sh
> >>> +#
> >>> +#    testcases/security/smack/smack_common.sh
> >>> +#
> >>> +#    Copyright (C) 2009, Cisco Systems Inc.
> >>> +#
> >>> +#    This program is free software; you can redistribute it and/or modify
> >>> +#    it under the terms of the GNU General Public License as published by
> >>> +#    the Free Software Foundation; either version 2 of the License, or
> >>> +#    (at your option) any later version.
> >>> +#
> >>> +#    This program is distributed in the hope that it will be useful,
> >>> +#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> +#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> +#    GNU General Public License for more details.
> >>> +#
> >>> +#    You should have received a copy of the GNU General Public License along
> >>> +#    with this program; if not, write to the Free Software Foundation, Inc.,
> >>> +#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> >>> +#
> >>> +# Garrett Cooper, July 2009
> >>> +#
> >>> +# This file serves the sole purpose of executing every common piece of
> >>> +# prerequisite code for all of the smack tests, s.t. a lot of duplicate shell
> >>> +# code isn't laying around all over the place.
> >>> +#
> >>> +
> >>> +smackfsdir=${smackfsdir:=/smack}
> >>> +
> >>> +check_mounted() {
> >>> +	if [ ! -d "$smackfsdir" ]; then
> >>> +		echo "smackfs not mounted at $smackfsdir"
> >>> +		exit 1
> >>> +	fi
> >>> +}
> >>> +
> >>> +check_onlycap() {
> >>> +	onlycap=`cat "$smackfsdir/onlycap" 2>/dev/null`
> >>> +	if [ -z "$onlycap" ]; then
> >>> +		cat <<EOM
> >>> +The smack label reported for $smackfsdir/onlycap is "$onlycap", not
> >>> the expected "".
> >>> +EOM
> >>> +		exit 1
> >>> +	fi
> >>> +}
> >>> +
> >>> +check_mounted
> >>> +check_onlycap
> >>> Index: smack_file_access.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_file_access.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_file_access.sh
> >>> --- smack_file_access.sh	19 Mar 2009 07:27:05 -0000	1.1
> >>> +++ smack_file_access.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -13,43 +13,38 @@
> >>>  #
> >>>  #               1         2         3         4         5         6
> >>>  #      123456789012345678901234567890123456789012345678901234567890123456789
> >>> +
> >>> +source smack_common.sh
> >>> +
> >>>  RuleA="TheOne                  TheOther                r---"
> >>>  RuleB="TheOne                  TheOther                rw--"
> >>>
> >>>  Where="./testdir"
> >>>  What="testfile"
> >>> -TestFile="$Where"/"$What"
> >>> +TestFile="$Where/$What"
> >>>  CAT=/bin/cat
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> -
> >>>  if [ ! -d "$Where" ]; then
> >>>  	if [ -e "$Where" ]; then
> >>> -		echo Test directory \"$Where\" exists but is not a directory.
> >>> +		echo "Test directory \"$Where\" exists but is not a directory."
> >>>  		exit 1
> >>>  	fi
> >>> -	mkdir "$Where"
> >>> +	mkdir -m 777 "$Where"
> >>>  	if [ ! -d "$Where" ]; then
> >>> -		echo Test directory \"$Where\" can not be created.
> >>> +		echo "Test directory \"$Where\" can not be created."
> >>>  		exit 1
> >>>  	fi
> >>> -	chmod 777 "$Where"
> >>>  fi
> >>>
> >>>  if [ ! -f "$TestFile" ]; then
> >>>  	if [ -e "$TestFile" ]; then
> >>> -		echo Test file \"$TestFile\" exists but is not a file.
> >>> +		echo "Test file \"$TestFile\" exists but is not a file."
> >>>  		rm -rf "$Where"
> >>>  		exit 1
> >>>  	fi
> >>> -	./notroot /bin/sh -c "echo InitialData > $TestFile"
> >>> +	./notroot /bin/sh -c "echo InitialData 2>/dev/null > $TestFile"
> >>>  	if [ ! -d "$TestFile" ]; then
> >>> -		echo Test file \"$TestFile\" can not be created.
> >>> +		echo "Test file \"$TestFile\" can not be created."
> >>>  		rm -rf "$Where"
> >>>  		exit 1
> >>>  	fi
> >>> @@ -60,65 +55,65 @@
> >>>  SetTo=`echo $SetTo`
> >>>
> >>>  if [ "TheOther" != "$SetTo" ]; then
> >>> -	echo Test file \"$TestFile\" labeled \"$SetTo\" incorrectly.
> >>> +	echo "Test file \"$TestFile\" labeled \"$SetTo\" incorrectly."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -OldRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> +OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> >>>
> >>> -echo -n "$RuleA" > /smack/load
> >>> -NewRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleA" > "$smackfsdir/load"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>  Mode=`echo $NewRule | sed -e 's/.* //'`
> >>>  if [ "$Mode" != "r" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -OldProc=`cat /proc/self/attr/current`
> >>> +OldProc=`cat /proc/self/attr/current 2>/dev/null`
> >>>
> >>> -echo TheOne > /proc/self/attr/current
> >>> +echo TheOne 2>/dev/null > /proc/self/attr/current
> >>>  GotRead=`./notroot $CAT "$TestFile"`
> >>>
> >>>  if [ "$GotRead" != "InitialData" ]; then
> >>> -	echo Read failed for \"$TestFile\" labeled \"TheOther\".
> >>> +	echo "Read failed for \"$TestFile\" labeled \"TheOther\"."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo NotTheOne > /proc/self/attr/current
> >>> +echo NotTheOne 2>/dev/null > /proc/self/attr/current
> >>>  GotRead=`./notroot $CAT "$TestFile"`
> >>>
> >>> -if [ "$GotRead" == "InitialData" ]; then
> >>> -	echo Read should have failed for \"$TestFile\" labeled \"TheOther\".
> >>> +if [ "$GotRead" = "InitialData" ]; then
> >>> +	echo "Read should have failed for \"$TestFile\" labeled \"TheOther\"."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo -n "$RuleB" > /smack/load
> >>> -NewRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
> >>> +NewRule=`grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' TheOther '`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>  Mode=`echo $NewRule | sed -e 's/.* //'`
> >>>  if [ "$Mode" != "rw" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	rm -rf "$Where"
> >>>  	exit 1
> >>>  fi
> >>>
> >>>  if [ "$OldRule" != "$NewRule" ]; then
> >>> -	echo Notice: Test access rule changed from
> >>> -	echo \"$OldRule\" to \"$NewRule\".
> >>> +	cat <<EOM
> >>> +Notice: Test access rule changed from "$OldRule" to "$NewRule".
> >>> +EOM
> >>>  fi
> >>>
> >>>  rm -rf "$Where"
> >>> -exit 0
> >>> Index: smack_set_ambient.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_ambient.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_ambient.sh
> >>> --- smack_set_ambient.sh	19 Mar 2009 07:27:05 -0000	1.1
> >>> +++ smack_set_ambient.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -9,32 +9,29 @@
> >>>  # Environment:
> >>>  #	CAP_MAC_ADMIN
> >>>  #
> >>> -NotTheFloorLabel="XYZZY"
> >>> -StartLabel=`cat /smack/ambient`
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +source smack_common.sh
> >>>
> >>> -echo $NotTheFloorLabel > /smack/ambient
> >>> +NotTheFloorLabel="XYZZY"
> >>> +StartLabel=`cat "$smackfsdir/ambient" 2>/dev/null`
> >>> +
> >>> +echo "$NotTheFloorLabel" 2>/dev/null > "$smackfsdir/ambient"
> >>>
> >>> -label=`cat /smack/ambient`
> >>> +label=`cat "$smackfsdir/ambient" 2>/dev/null`
> >>>  if [ "$label" != "$NotTheFloorLabel" ]; then
> >>> -	echo The smack label reported for the current process is \"$label\",
> >>> -	echo not the expected \"$NotTheFloorLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for the current process is "$label", not the expected
> >>> +"$NotTheFloorLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo "$StartLabel" > /smack/ambient
> >>> +echo "$StartLabel" 2>/dev/null > "$smackfsdir/ambient"
> >>>
> >>> -label=`cat /smack/ambient`
> >>> +label=`cat "$smackfsdir/ambient" 2>/dev/null`
> >>>  if [ "$label" != "$StartLabel" ]; then
> >>> -	echo The smack label reported for the current process is \"$label\",
> >>> -	echo not the expected \"$StartLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for the current process is "$label",  not
> >>> the expected "$StartLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_cipso.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_cipso.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_cipso.sh
> >>> --- smack_set_cipso.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_cipso.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -13,58 +13,53 @@
> >>>  #
> >>>  #               1         2    llllCCCCccccCCCCcccc     5         6
> >>>  #      123456789012345678901234567890123456789012345678901234567890123456789
> >>> +
> >>> +source smack_common.sh
> >>> +
> >>>  RuleA="TheOne                  2   0   "
> >>>  RuleB="TheOne                  3   1   55  "
> >>>  RuleC="TheOne                  4   2   17  33  "
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +OldRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> >>>
> >>> -OldRule=`grep "^TheOne" /smack/cipso`
> >>> -
> >>> -echo -n "$RuleA" > /smack/cipso
> >>> -NewRule=`grep "^TheOne" /smack/cipso`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/cipso"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	exit 1
> >>>  fi
> >>> -Right=`echo $NewRule | grep ' 2'`
> >>> -if [ "$Right" == "" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +Right=`echo "$NewRule" | grep ' 2'`
> >>> +if [ "$Right" = "" ]; then
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo -n "$RuleB" > /smack/cipso
> >>> -NewRule=`grep "^TheOne" /smack/cipso`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/cipso"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	exit 1
> >>>  fi
> >>>  Right=`echo $NewRule | grep '/55'`
> >>> -if [ "$Right" == "" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +if [ "$Right" = "" ]; then
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo -n "$RuleC" > /smack/cipso
> >>> -NewRule=`grep "^TheOne" /smack/cipso`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleC" 2>/dev/null > "$smackfsdir/cipso"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	exit 1
> >>>  fi
> >>> -Right=`echo $NewRule | grep '/17,33'`
> >>> -if [ "$Right" == "" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +Right=`echo "$NewRule" | grep '/17,33'`
> >>> +if [ "$Right" = "" ]; then
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -
> >>>  if [ "$OldRule" != "$NewRule" ]; then
> >>> -	echo Notice: Test access rule changed from \"$OldRule\" to \"$NewRule\".
> >>> +	cat <<EOM
> >>> +Notice: Test access rule changed from "$OldRule" to "$NewRule".
> >>> +EOM
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_current.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_current.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_current.sh
> >>> --- smack_set_current.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_current.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -10,32 +10,30 @@
> >>>  #	CAP_MAC_ADMIN
> >>>  #	/smack/onlycap unset
> >>>  #
> >>> -NotTheFloorLabel="XYZZY"
> >>> -StartLabel=`cat /proc/self/attr/current`
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +source smack_common.sh
> >>>
> >>> -echo $NotTheFloorLabel > /proc/self/attr/current
> >>> +NotTheFloorLabel="XYZZY"
> >>> +StartLabel=`cat /proc/self/attr/current 2>/dev/null`
> >>> +
> >>> +echo "$NotTheFloorLabel" 2>/dev/null > /proc/self/attr/current
> >>>
> >>> -label=`cat /proc/self/attr/current`
> >>> +label=`cat /proc/self/attr/current 2>/dev/null`
> >>>  if [ "$label" != "$NotTheFloorLabel" ]; then
> >>> -	echo The smack label reported for the current process is \"$label\",
> >>> -	echo not the expected \"$NotTheFloorLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for the current process is "$label",
> >>> +not the expected "$NotTheFloorLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo "$StartLabel" > /proc/self/attr/current
> >>> +echo "$StartLabel" 2>/dev/null > /proc/self/attr/current
> >>>
> >>> -label=`cat /proc/self/attr/current`
> >>> +label=`cat /proc/self/attr/current > /dev/null`
> >>>  if [ "$label" != "$StartLabel" ]; then
> >>> -	echo The smack label reported for the current process is \"$label\",
> >>> -	echo not the expected \"$StartLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for the current process is "$label",
> >>> +not the expected "$StartLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_direct.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_direct.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_direct.sh
> >>> --- smack_set_direct.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_direct.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -9,32 +9,30 @@
> >>>  # Environment:
> >>>  #	CAP_MAC_ADMIN
> >>>  #
> >>> -NotTheStartValue="17"
> >>> -StartValue=`cat /smack/direct`
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$onlycap\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +source smack_common.sh
> >>>
> >>> -echo $NotTheStartValue > /smack/direct
> >>> +NotTheStartValue="17"
> >>> +StartValue=`cat "$smackfsdir/direct" 2>/dev/null`
> >>> +
> >>> +echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/direct"
> >>>
> >>> -DirectValue=`cat /smack/direct`
> >>> +DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
> >>>  if [ "$DirectValue" != "$NotTheStartValue" ]; then
> >>> -	echo The CIPSO direct level reported is \"$DirectValue\",
> >>> -	echo not the expected \"$NotTheStartValue\".
> >>> +	cat <<EOM
> >>> +The CIPSO direct level reported is "$DirectValue",
> >>> +not the expected "$NotTheStartValue".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo "$StartValue" > /smack/direct
> >>> +echo "$StartValue" 2>/dev/null> "$smackfsdir/direct"
> >>>
> >>> -DirectValue=`cat /smack/direct`
> >>> +DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
> >>>  if [ "$DirectValue" != "$StartValue" ]; then
> >>> -	echo The CIPSO direct level reported is \"$DirectValue\",
> >>> -	echo not the expected \"$StartValue\".
> >>> +	cat <<EOM
> >>> +The CIPSO direct level reported is "$DirectValue",
> >>> +not the expected "$StartValue".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_doi.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_doi.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_doi.sh
> >>> --- smack_set_doi.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_doi.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -9,31 +9,31 @@
> >>>  # Environment:
> >>>  #	CAP_MAC_ADMIN
> >>>  #
> >>> -NotTheStartValue="17"
> >>> -StartValue=`cat /smack/doi`
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$onlycap\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +source smack_common.sh
> >>> +
> >>> +NotTheStartValue="17"
> >>> +StartValue=`cat "$smackfsdir/doi" 2>/dev/null`
> >>>
> >>> -echo $NotTheStartValue > /smack/doi
> >>> +echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/doi"
> >>>
> >>> -DirectValue=`cat /smack/doi`
> >>> +DirectValue=`cat "$smackfsdir/doi" 2>/dev/null`
> >>>  if [ "$DirectValue" != "$NotTheStartValue" ]; then
> >>> -	echo The CIPSO doi reported is \"$DirectValue\",
> >>> -	echo not the expected \"$NotTheStartValue\".
> >>> +	cat <<EOM
> >>> +The CIPSO doi reported is "$DirectValue",
> >>> +not the expected "$NotTheStartValue".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo "$StartValue" > /smack/doi
> >>> +echo "$StartValue" 2>/dev/null > "$smackfsdir/doi"
> >>>
> >>> -DirectValue=`cat /smack/doi`
> >>> +DirectValue=`cat "$smackfsdir/doi" 2>/dev/null`
> >>>  if [ "$DirectValue" != "$StartValue" ]; then
> >>> -	echo The CIPSO doi reported is \"$DirectValue\",
> >>> -	echo not the expected \"$StartValue\".
> >>> +	cat <<EOM
> >>> +The CIPSO doi reported is "$DirectValue",
> >>> +not the expected "$StartValue".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> Index: smack_set_load.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_load.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_load.sh
> >>> --- smack_set_load.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_load.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -13,45 +13,41 @@
> >>>  #
> >>>  #               1         2         3         4         5         6
> >>>  #      123456789012345678901234567890123456789012345678901234567890123456789
> >>> +
> >>> +source smack_common.sh
> >>> +
> >>>  RuleA="TheOne                  TheOther                rwxa"
> >>>  RuleB="TheOne                  TheOther                r---"
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> -
> >>> -OldRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> +OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> >>>
> >>> -echo -n "$RuleA" > /smack/load
> >>> -NewRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/load"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	exit 1
> >>>  fi
> >>> -Mode=`echo $NewRule | sed -e 's/.* //'`
> >>> +Mode=`echo "$NewRule" | sed -e 's/.* //'`
> >>>  if [ "$Mode" != "rwxa" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo -n "$RuleB" > /smack/load
> >>> -NewRule=`grep "^TheOne" /smack/load | grep ' TheOther '`
> >>> -if [ "$NewRule" == "" ]; then
> >>> -	echo Rule did not get set.
> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
> >>> +NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> >>> +if [ "$NewRule" = "" ]; then
> >>> +	echo "Rule did not get set."
> >>>  	exit 1
> >>>  fi
> >>> -Mode=`echo $NewRule | sed -e 's/.* //'`
> >>> +Mode=`echo "$NewRule" | sed -e 's/.* //'`
> >>>  if [ "$Mode" != "r" ]; then
> >>> -	echo Rule \"$NewRule\" is not set correctly.
> >>> +	echo "Rule \"$NewRule\" is not set correctly."
> >>>  	exit 1
> >>>  fi
> >>>
> >>>  if [ "$OldRule" != "$NewRule" ]; then
> >>> -	echo Notice: Test access rule changed from
> >>> -	echo \"$OldRule\" to \"$NewRule\".
> >>> +	cat <<EOM
> >>> +Notice: Test access rule changed from
> >>> +"$OldRule" to "$NewRule".
> >>> +EOM
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_netlabel.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_netlabel.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_netlabel.sh
> >>> --- smack_set_netlabel.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_netlabel.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -9,41 +9,40 @@
> >>>  # Environment:
> >>>  #	CAP_MAC_ADMIN
> >>>  #
> >>> +
> >>> +source smack_common.sh
> >>> +
> >>>  RuleA="191.191.191.191 TheOne"
> >>>  RuleA1="191.191.191.191/32 TheOne"
> >>>  RuleB="191.190.190.0/24 TheOne"
> >>>
> >>> -onlycap=`cat /smack/onlycap`
> >>> -if [ "$onlycap" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +Old32=`grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/null`
> >>> +Old24=`grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/null`
> >>>
> >>> -Old32=`grep "^191.191.191.191/32" /smack/netlabel`
> >>> -Old24=`grep "^191.190.190.0/24" /smack/netlabel`
> >>> -
> >>> -echo -n "$RuleA" > /smack/netlabel
> >>> -New32=`grep "$RuleA1" /smack/netlabel`
> >>> +echo -n "$RuleA" 2>/dev/null > "$smackfsdir/netlabel"
> >>> +New32=`grep "$RuleA1" $smackfsdir/netlabel 2>/dev/null`
> >>>  if [ "$New32" != "$RuleA1" ]; then
> >>> -	echo Rule \"$RuleA\" did not get set.
> >>> +	echo "Rule \"$RuleA\" did not get set."
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo -n "$RuleB" > /smack/netlabel
> >>> -New24=`grep "$RuleB" /smack/netlabel`
> >>> +echo -n "$RuleB" 2>/dev/null > "$smackfsdir/netlabel"
> >>> +New24=`grep "$RuleB" "$smackfsdir/netlabel" 2>/dev/null`
> >>>  if [ "$New24" != "$RuleB" ]; then
> >>> -	echo Rule \"$RuleB\" did not get set.
> >>> +	echo "Rule \"$RuleB\" did not get set."
> >>>  	exit 1
> >>>  fi
> >>>
> >>>  if [ "$Old24" != "$New24" ]; then
> >>> -	echo Notice: Test access rule changed from
> >>> -	echo \"$Old24\" to \"$New24\".
> >>> +	cat <<EOM
> >>> +Notice: Test access rule changed from
> >>> +"$Old24" to "$New24".
> >>> +EOM
> >>>  fi
> >>> +
> >>>  if [ "$Old32" != "$New32" ]; then
> >>> -	echo Notice: Test access rule changed from
> >>> -	echo \"$Old32\" to \"$New32\".
> >>> +	cat <<EOM
> >>> +Notice: Test access rule changed from
> >>> +"$Old32" to "$New32".
> >>> +EOM
> >>>  fi
> >>> -
> >>> -exit 0
> >>> Index: smack_set_onlycap.sh
> >>> ===================================================================
> >>> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/smack/smack_set_onlycap.sh,v
> >>> retrieving revision 1.1
> >>> diff -u -r1.1 smack_set_onlycap.sh
> >>> --- smack_set_onlycap.sh	19 Mar 2009 07:27:06 -0000	1.1
> >>> +++ smack_set_onlycap.sh	31 Jul 2009 06:17:05 -0000
> >>> @@ -9,31 +9,30 @@
> >>>  # Environment:
> >>>  #	CAP_MAC_ADMIN
> >>>  #
> >>> -MyLabel=`cat /proc/self/attr/current`
> >>> -StartLabel=`cat /smack/onlycap`
> >>>
> >>> -if [ "$StartLabel" != "" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$StartLabel\",
> >>> -	echo not the expected \"\".
> >>> -	exit 1
> >>> -fi
> >>> +source smack_common.sh
> >>>
> >>> -echo $MyLabel > /smack/onlycap
> >>> +MyLabel=`cat /proc/self/attr/current 2>/dev/null`
> >>> +StartLabel=`cat "$smackfsdir/onlycap" 2>/dev/null`
> >>>
> >>> -label=`cat /smack/onlycap`
> >>> +echo "$MyLabel" 2>/dev/null > "$smackfsdir/onlycap"
> >>> +
> >>> +label=`cat "$smackfsdir/onlycap" 2>/dev/null`
> >>>  if [ "$label" != "$MyLabel" ]; then
> >>> -	echo The smack label reported for /smack/onlycap is \"$label\",
> >>> -	echo not the expected \"$MyLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for $smackfsdir/onlycap is "$label",
> >>> +not the expected "$MyLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>>
> >>> -echo "$StartLabel" > /smack/onlycap
> >>> +echo "$StartLabel" 2>/dev/null > "$smackfsdir/onlycap"
> >>>
> >>> -label=`cat /smack/onlycap`
> >>> +label=`cat "$smackfsdir/onlycap" 2>/dev/null`
> >>>  if [ "$label" != "$StartLabel" ]; then
> >>> -	echo The smack label reported for the current process is \"$label\",
> >>> -	echo not the expected \"$StartLabel\".
> >>> +	cat <<EOM
> >>> +The smack label reported for the current process is "$label",
> >>> +not the expected "$StartLabel".
> >>> +EOM
> >>>  	exit 1
> >>>  fi
> >>> -
> >>> -exit 0
> >>>
> >>> ------------------------------------------------------------------------------
> >>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> >>> trial. Simplify your report design, integration and deployment - and focus on 
> >>> what you do best, core application coding. Discover what's new with 
> >>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> >>> _______________________________________________
> >>> Ltp-list mailing list
> >>> Ltp-list@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >>>       
> >> ------------------------------------------------------------------------------
> >> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> >> trial. Simplify your report design, integration and deployment - and focus on 
> >> what you do best, core application coding. Discover what's new with 
> >> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> >> _______________________________________________
> >> Ltp-list mailing list
> >> Ltp-list@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> >>     
> >
> >
> >   
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
