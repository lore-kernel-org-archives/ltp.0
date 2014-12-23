Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Y3M5u-0004qd-Br
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:49:34 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y3M5q-00082o-CB
	for ltp-list@lists.sourceforge.net; Tue, 23 Dec 2014 09:49:34 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sBN9muJs027821
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Dec 2014 17:48:56 +0800
Message-ID: <1419328153.25145.3.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 23 Dec 2014 17:49:13 +0800
In-Reply-To: <1414755631.17402.7.camel@G08JYZSD130126.localdomain>
References: <1414755631.17402.7.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] smack: Cleanup
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hello, everyone

Merry Christmas and Happy New Year. :)

I have resend version 2 and please ignore these.

Best regards,
Zeng

On Fri, 2014-10-31 at 19:40 +0800, Zeng Linggang wrote:
> * On some systems 'smackfs' mounts aren't listed in the output from 'df',
>   so we switch to the '/proc/mounts' instead.
> 
> * Add 'TCID', 'TST_TOTAL' and 'TST_COUNT' global variables.
> 
> * Use 'test.sh' script and use 'tst_*'.
> 
> * Use '$()' instead of '``'.
> 
> * Use '.' instead of 'source'.
> 
> * Use 'tst_tmpdir' and 'tst_rmdir' in 'smack_file_access.sh'.
> 
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/security/smack/smack_common.sh    |  22 ++--
>  .../kernel/security/smack/smack_file_access.sh     | 129 +++++++++------------
>  .../kernel/security/smack/smack_set_ambient.sh     |  40 ++++---
>  testcases/kernel/security/smack/smack_set_cipso.sh |  74 ++++++------
>  .../kernel/security/smack/smack_set_current.sh     |  41 ++++---
>  .../kernel/security/smack/smack_set_direct.sh      |  41 ++++---
>  testcases/kernel/security/smack/smack_set_doi.sh   |  41 +++----
>  testcases/kernel/security/smack/smack_set_load.sh  |  56 ++++-----
>  .../kernel/security/smack/smack_set_netlabel.sh    |  55 ++++-----
>  .../kernel/security/smack/smack_set_onlycap.sh     |  41 ++++---
>  10 files changed, 270 insertions(+), 270 deletions(-)
> 
> diff --git a/testcases/kernel/security/smack/smack_common.sh b/testcases/kernel/security/smack/smack_common.sh
> index 5d7f112..dc33e66 100755
> --- a/testcases/kernel/security/smack/smack_common.sh
> +++ b/testcases/kernel/security/smack/smack_common.sh
> @@ -27,20 +27,20 @@
>  
>  smackfsdir=${smackfsdir:=/smack}
>  
> -check_mounted() {
> -	if ! expr "$smackfsdir" : "$(df -P | awk "\$NF == \"$smackfsdir\""'{ print $NF }')"; then
> -		echo "smackfs not mounted at $smackfsdir"
> -		exit 1
> +check_mounted()
> +{
> +	grep -q $smackfsdir /proc/mounts
> +	if [ $? -ne 0 ]; then
> +		tst_brkm TCONF "smackfs not mounted at \"$smackfsdir\""
>  	fi
>  }
>  
> -check_onlycap() {
> -	onlycap=`cat "$smackfsdir/onlycap" 2>/dev/null`
> -	if [ "$onlycap" != "" ]; then
> -		cat <<EOM
> -The smack label reported for $smackfsdir/onlycap is "$onlycap", not the expected "".
> -EOM
> -		exit 1
> +check_onlycap()
> +{
> +	onlycap=$(cat "$smackfsdir/onlycap" 2>/dev/null)
> +	if [ -n "$onlycap" ]; then
> +		tst_brkm TCONF "\"$smackfsdir/onlycap\" is \"$onlycap\", not \
> +the expected \"\"."
>  	fi
>  }
>  
> diff --git a/testcases/kernel/security/smack/smack_file_access.sh b/testcases/kernel/security/smack/smack_file_access.sh
> index 61db065..57e50fb 100755
> --- a/testcases/kernel/security/smack/smack_file_access.sh
> +++ b/testcases/kernel/security/smack/smack_file_access.sh
> @@ -14,106 +14,83 @@
>  #               1         2         3         4         5         6
>  #      123456789012345678901234567890123456789012345678901234567890123456789
>  
> -source smack_common.sh
> +export TCID=smack_file_access
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -RuleA="TheOne                  TheOther                r---"
> -RuleB="TheOne                  TheOther                rw--"
> +. test.sh
> +
> +. smack_common.sh
> +
> +cleanup()
> +{
> +	tst_rmdir
> +}
> +
> +rule_a="TheOne                  TheOther                r---"
> +rule_b="TheOne                  TheOther                rw--"
>  
> -Where="./testdir"
> -What="testfile"
> -TestFile="$Where/$What"
>  CAT=/bin/cat
> +testfile="testfile"
>  
> -if [ ! -d "$Where" ]; then
> -	if [ -e "$Where" ]; then
> -		echo "Test directory \"$Where\" exists but is not a directory."
> -		exit 1
> -	fi
> -	mkdir -m 777 "$Where"
> -	if [ ! -d "$Where" ]; then
> -		echo "Test directory \"$Where\" can not be created."
> -		exit 1
> -	fi
> -fi
> +tst_tmpdir
> +TST_CLEANUP=cleanup
> +
> +chmod 777 $(pwd)
>  
> -if [ ! -f "$TestFile" ]; then
> -	if [ -e "$TestFile" ]; then
> -		echo "Test file \"$TestFile\" exists but is not a file."
> -		rm -rf "$Where"
> -		exit 1
> -	fi
> -	./notroot /bin/sh -c "echo InitialData 2>/dev/null > $TestFile"
> -	if [ ! -d "$TestFile" ]; then
> -		echo "Test file \"$TestFile\" can not be created."
> -		rm -rf "$Where"
> -		exit 1
> -	fi
> +notroot /bin/sh -c "echo InitialData 2>/tmp/smack_fail.log > $testfile"
> +if [ ! -f "$testfile" ]; then
> +	tst_brkm TFAIL "Test file \"$testfile\" can not be created."
>  fi
>  
> -setfattr --name=security.SMACK64 --value=TheOther "$TestFile"
> -SetTo=`getfattr --only-values -n security.SMACK64 -e text $TestFile`
> -SetTo=`echo $SetTo`
> +setfattr --name=security.SMACK64 --value=TheOther "$testfile"
> +setto=$(getfattr --only-values -n security.SMACK64 -e text $testfile)
>  
> -if [ "TheOther" != "$SetTo" ]; then
> -	echo "Test file \"$TestFile\" labeled \"$SetTo\" incorrectly."
> -	rm -rf "$Where"
> -	exit 1
> +if [ "TheOther" != "$setto" ]; then
> +	tst_brkm TFAIL "Test file \"$testfile\" labeled \"$setto\" incorrectly."
>  fi
>  
> -OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> +old_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
>  
> -echo -n "$RuleA" > "$smackfsdir/load"
> -NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	rm -rf "$Where"
> -	exit 1
> +echo -n "$rule_a" > "$smackfsdir/load"
> +new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Mode=`echo $NewRule | sed -e 's/.* //'`
> -if [ "$Mode" != "r" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	rm -rf "$Where"
> -	exit 1
> +mode=$(echo $new_rule | sed -e 's/.* //')
> +if [ "$mode" != "r" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -OldProc=`cat /proc/self/attr/current 2>/dev/null`
> -
>  echo TheOne 2>/dev/null > /proc/self/attr/current
> -GotRead=`./notroot $CAT "$TestFile"`
> +got_read=$(notroot $CAT "$testfile")
>  
> -if [ "$GotRead" != "InitialData" ]; then
> -	echo "Read failed for \"$TestFile\" labeled \"TheOther\"."
> -	rm -rf "$Where"
> -	exit 1
> +if [ "$got_read" != "InitialData" ]; then
> +	tst_brkm TFAIL "Read failed for \"$testfile\" labeled \"TheOther\"."
>  fi
>  
>  echo NotTheOne 2>/dev/null > /proc/self/attr/current
> -GotRead=`./notroot $CAT "$TestFile"`
> +got_read=$(notroot $CAT "$testfile" 2> /dev/null)
>  
> -if [ "$GotRead" = "InitialData" ]; then
> -	echo "Read should have failed for \"$TestFile\" labeled \"TheOther\"."
> -	rm -rf "$Where"
> -	exit 1
> +if [ "$got_read" = "InitialData" ]; then
> +	tst_brkm TFAIL "Read should have failed for \"$testfile\" labeled \
> +\"TheOther\"."
>  fi
>  
> -echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
> -NewRule=`grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' TheOther '`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	rm -rf "$Where"
> -	exit 1
> +echo -n "$rule_b" 2>/dev/null > "$smackfsdir/load"
> +new_rule=$(grep "^TheOne" $smackfsdir/load 2>/dev/null | grep ' TheOther ')
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Mode=`echo $NewRule | sed -e 's/.* //'`
> -if [ "$Mode" != "rw" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	rm -rf "$Where"
> -	exit 1
> +mode=$(echo $new_rule | sed -e 's/.* //')
> +if [ "$mode" != "rw" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -if [ "$OldRule" != "$NewRule" ]; then
> -	cat <<EOM
> -Notice: Test access rule changed from "$OldRule" to "$NewRule".
> -EOM
> +if [ "$old_rule" != "$new_rule" ]; then
> +	tst_resm TINFO "Notice: Test access rule changed from \"$old_rule\" \
> +to \"$new_rule\"."
>  fi
>  
> -rm -rf "$Where"
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_ambient.sh b/testcases/kernel/security/smack/smack_set_ambient.sh
> index fcfdbc5..c0b0b8a 100755
> --- a/testcases/kernel/security/smack/smack_set_ambient.sh
> +++ b/testcases/kernel/security/smack/smack_set_ambient.sh
> @@ -10,28 +10,32 @@
>  #	CAP_MAC_ADMIN
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_ambient
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -NotTheFloorLabel="XYZZY"
> -StartLabel=`cat "$smackfsdir/ambient" 2>/dev/null`
> +. test.sh
>  
> -echo "$NotTheFloorLabel" 2>/dev/null > "$smackfsdir/ambient"
> +. smack_common.sh
>  
> -label=`cat "$smackfsdir/ambient" 2>/dev/null`
> -if [ "$label" != "$NotTheFloorLabel" ]; then
> -	cat <<EOM
> -The smack label reported for the current process is "$label", not the expected
> -"$NotTheFloorLabel".
> -EOM
> -	exit 1
> +not_floor_label="XYZZY"
> +start_label=$(cat "$smackfsdir/ambient" 2>/dev/null)
> +
> +echo "$not_floor_label" 2>/dev/null > "$smackfsdir/ambient"
> +
> +label=$(cat "$smackfsdir/ambient" 2>/dev/null)
> +if [ "$label" != "$not_floor_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for the current process is \
> +\"$label\", not the expected \"$not_floor_label\"."
>  fi
>  
> -echo "$StartLabel" 2>/dev/null > "$smackfsdir/ambient"
> +echo "$start_label" 2>/dev/null > "$smackfsdir/ambient"
>  
> -label=`cat "$smackfsdir/ambient" 2>/dev/null`
> -if [ "$label" != "$StartLabel" ]; then
> -	cat <<EOM
> -The smack label reported for the current process is "$label",  not the expected "$StartLabel".
> -EOM
> -	exit 1
> +label=$(cat "$smackfsdir/ambient" 2>/dev/null)
> +if [ "$label" != "$start_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for the current process is \
> +\"$label\",  not the expected \"$start_label\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_cipso.sh b/testcases/kernel/security/smack/smack_set_cipso.sh
> index 1c7321f..2de6ec7 100755
> --- a/testcases/kernel/security/smack/smack_set_cipso.sh
> +++ b/testcases/kernel/security/smack/smack_set_cipso.sh
> @@ -14,52 +14,54 @@
>  #               1         2    llllCCCCccccCCCCcccc     5         6
>  #      123456789012345678901234567890123456789012345678901234567890123456789
>  
> -source smack_common.sh
> +export TCID=smack_set_cipso
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -RuleA="TheOne                  2   0   "
> -RuleB="TheOne                  3   1   55  "
> -RuleC="TheOne                  4   2   17  33  "
> +. test.sh
>  
> -OldRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> +. smack_common.sh
>  
> -echo -n "$RuleA" 2>/dev/null > "$smackfsdir/cipso"
> -NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	exit 1
> +rule_a="TheOne                  2   0   "
> +rule_b="TheOne                  3   1   55  "
> +rule_c="TheOne                  4   2   17  33  "
> +
> +old_rule=$(grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null)
> +
> +echo -n "$rule_a" 2>/dev/null > "$smackfsdir/cipso"
> +new_rule=$(grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null)
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Right=`echo "$NewRule" | grep ' 2'`
> -if [ "$Right" = "" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	exit 1
> +right=$(echo "$new_rule" | grep ' 2')
> +if [ "$right" = "" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -echo -n "$RuleB" 2>/dev/null > "$smackfsdir/cipso"
> -NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	exit 1
> +echo -n "$rule_b" 2>/dev/null > "$smackfsdir/cipso"
> +new_rule=$(grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null)
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Right=`echo $NewRule | grep '/55'`
> -if [ "$Right" = "" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	exit 1
> +right=$(echo $new_rule | grep '/55')
> +if [ "$right" = "" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -echo -n "$RuleC" 2>/dev/null > "$smackfsdir/cipso"
> -NewRule=`grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	exit 1
> +echo -n "$rule_c" 2>/dev/null > "$smackfsdir/cipso"
> +new_rule=$(grep "^TheOne" "$smackfsdir/cipso" 2>/dev/null)
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Right=`echo "$NewRule" | grep '/17,33'`
> -if [ "$Right" = "" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	exit 1
> +right=$(echo "$new_rule" | grep '/17,33')
> +if [ "$right" = "" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -if [ "$OldRule" != "$NewRule" ]; then
> -	cat <<EOM
> -Notice: Test access rule changed from "$OldRule" to "$NewRule".
> -EOM
> +if [ "$old_rule" != "$new_rule" ]; then
> +	tst_resm TINFO "Notice: Test access rule changed from \"$old_rule\" \
> +to \"$new_rule\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_current.sh b/testcases/kernel/security/smack/smack_set_current.sh
> index 28a1b1b..d6449d4 100755
> --- a/testcases/kernel/security/smack/smack_set_current.sh
> +++ b/testcases/kernel/security/smack/smack_set_current.sh
> @@ -11,29 +11,32 @@
>  #	/smack/onlycap unset
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_current
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -NotTheFloorLabel="XYZZY"
> -StartLabel=`cat /proc/self/attr/current 2>/dev/null`
> +. test.sh
>  
> -echo "$NotTheFloorLabel" 2>/dev/null > /proc/self/attr/current
> +. smack_common.sh
>  
> -label=`cat /proc/self/attr/current 2>/dev/null`
> -if [ "$label" != "$NotTheFloorLabel" ]; then
> -	cat <<EOM
> -The smack label reported for the current process is "$label",
> -not the expected "$NotTheFloorLabel".
> -EOM
> -	exit 1
> +not_floor_label="XYZZY"
> +start_label=$(cat /proc/self/attr/current 2>/dev/null)
> +
> +echo "$not_floor_label" 2>/dev/null > /proc/self/attr/current
> +
> +label=$(cat /proc/self/attr/current 2>/dev/null)
> +if [ "$label" != "$not_floor_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for the current process is \
> +\"$label\", not the expected \"$not_floor_label\"."
>  fi
>  
> -echo "$StartLabel" 2>/dev/null > /proc/self/attr/current
> +echo "$start_label" 2>/dev/null > /proc/self/attr/current
>  
> -label=`cat /proc/self/attr/current > /dev/null`
> -if [ "$label" != "$StartLabel" ]; then
> -	cat <<EOM
> -The smack label reported for the current process is "$label",
> -not the expected "$StartLabel".
> -EOM
> -	exit 1
> +label=$(cat /proc/self/attr/current 2> /dev/null)
> +if [ "$label" != "$start_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for the current process is \
> +\"$label\", not the expected \"$start_label\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_direct.sh b/testcases/kernel/security/smack/smack_set_direct.sh
> index 84135f5..8fde40c 100755
> --- a/testcases/kernel/security/smack/smack_set_direct.sh
> +++ b/testcases/kernel/security/smack/smack_set_direct.sh
> @@ -10,29 +10,32 @@
>  #	CAP_MAC_ADMIN
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_direct
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -NotTheStartValue="17"
> -StartValue=`cat "$smackfsdir/direct" 2>/dev/null`
> +. test.sh
>  
> -echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/direct"
> +. smack_common.sh
>  
> -DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
> -if [ "$DirectValue" != "$NotTheStartValue" ]; then
> -	cat <<EOM
> -The CIPSO direct level reported is "$DirectValue",
> -not the expected "$NotTheStartValue".
> -EOM
> -	exit 1
> +not_start_value="17"
> +start_value=$(cat "$smackfsdir/direct" 2>/dev/null)
> +
> +echo "$not_start_value" 2>/dev/null > "$smackfsdir/direct"
> +
> +direct_value=$(cat "$smackfsdir/direct" 2>/dev/null)
> +if [ "$direct_value" != "$not_start_value" ]; then
> +	tst_brkm TFAIL "The CIPSO direct level reported is \"$direct_value\", \
> +not the expected \"$not_start_value\"."
>  fi
>  
> -echo "$StartValue" 2>/dev/null> "$smackfsdir/direct"
> +echo "$start_value" 2>/dev/null> "$smackfsdir/direct"
>  
> -DirectValue=`cat "$smackfsdir/direct" 2>/dev/null`
> -if [ "$DirectValue" != "$StartValue" ]; then
> -	cat <<EOM
> -The CIPSO direct level reported is "$DirectValue",
> -not the expected "$StartValue".
> -EOM
> -	exit 1
> +direct_value=$(cat "$smackfsdir/direct" 2>/dev/null)
> +if [ "$direct_value" != "$start_value" ]; then
> +	tst_brkm TFAIL "The CIPSO direct level reported is \"$direct_value\", \
> +not the expected \"$start_value\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_doi.sh b/testcases/kernel/security/smack/smack_set_doi.sh
> index 8aca7d0..dde1a58 100755
> --- a/testcases/kernel/security/smack/smack_set_doi.sh
> +++ b/testcases/kernel/security/smack/smack_set_doi.sh
> @@ -10,31 +10,32 @@
>  #	CAP_MAC_ADMIN
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_doi
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -NotTheStartValue="17"
> -StartValue=`cat "$smackfsdir/doi" 2>/dev/null`
> +. test.sh
>  
> -echo "$NotTheStartValue" 2>/dev/null > "$smackfsdir/doi"
> +. smack_common.sh
>  
> -DirectValue=`cat "$smackfsdir/doi" 2>/dev/null`
> -if [ "$DirectValue" != "$NotTheStartValue" ]; then
> -	cat <<EOM
> -The CIPSO doi reported is "$DirectValue",
> -not the expected "$NotTheStartValue".
> -EOM
> -	exit 1
> +not_start_value="17"
> +start_value=$(cat "$smackfsdir/doi" 2>/dev/null)
> +
> +echo "$not_start_value" 2>/dev/null > "$smackfsdir/doi"
> +
> +direct_value=$(cat "$smackfsdir/doi" 2>/dev/null)
> +if [ "$direct_value" != "$not_start_value" ]; then
> +	tst_brkm TFAIL "The CIPSO doi reported is \"$direct_value\", not the \
> +expected \"$not_start_value\"."
>  fi
>  
> -echo "$StartValue" 2>/dev/null > "$smackfsdir/doi"
> +echo "$start_value" 2>/dev/null > "$smackfsdir/doi"
>  
> -DirectValue=`cat "$smackfsdir/doi" 2>/dev/null`
> -if [ "$DirectValue" != "$StartValue" ]; then
> -	cat <<EOM
> -The CIPSO doi reported is "$DirectValue",
> -not the expected "$StartValue".
> -EOM
> -	exit 1
> +direct_value=$(cat "$smackfsdir/doi" 2>/dev/null)
> +if [ "$direct_value" != "$start_value" ]; then
> +	tst_brkm TFAIL "The CIPSO doi reported is \"$direct_value\", not the \
> +expected \"$start_value\"."
>  fi
>  
> -exit 0
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_load.sh b/testcases/kernel/security/smack/smack_set_load.sh
> index 2dd4fbb..dae9d9d 100755
> --- a/testcases/kernel/security/smack/smack_set_load.sh
> +++ b/testcases/kernel/security/smack/smack_set_load.sh
> @@ -14,40 +14,44 @@
>  #               1         2         3         4         5         6
>  #      123456789012345678901234567890123456789012345678901234567890123456789
>  
> -source smack_common.sh
> +export TCID=smack_set_load
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -RuleA="TheOne                  TheOther                rwxa"
> -RuleB="TheOne                  TheOther                r---"
> +. test.sh
>  
> -OldRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> +. smack_common.sh
>  
> -echo -n "$RuleA" 2>/dev/null > "$smackfsdir/load"
> -NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	exit 1
> +rule_a="TheOne                  TheOther                rwxa"
> +rule_b="TheOne                  TheOther                r---"
> +
> +old_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
> +
> +echo -n "$rule_a" 2>/dev/null > "$smackfsdir/load"
> +new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Mode=`echo "$NewRule" | sed -e 's/.* //'`
> -if [ "$Mode" != "rwxa" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> +mode=$(echo "$new_rule" | sed -e 's/.* //')
> +if [ "$mode" != "rwxa" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  	exit 1
>  fi
>  
> -echo -n "$RuleB" 2>/dev/null > "$smackfsdir/load"
> -NewRule=`grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther '`
> -if [ "$NewRule" = "" ]; then
> -	echo "Rule did not get set."
> -	exit 1
> +echo -n "$rule_b" 2>/dev/null > "$smackfsdir/load"
> +new_rule=$(grep "^TheOne" "$smackfsdir/load" 2>/dev/null | grep ' TheOther ')
> +if [ "$new_rule" = "" ]; then
> +	tst_brkm TFAIL "Rule did not get set."
>  fi
> -Mode=`echo "$NewRule" | sed -e 's/.* //'`
> -if [ "$Mode" != "r" ]; then
> -	echo "Rule \"$NewRule\" is not set correctly."
> -	exit 1
> +mode=$(echo "$new_rule" | sed -e 's/.* //')
> +if [ "$mode" != "r" ]; then
> +	tst_brkm TFAIL "Rule \"$new_rule\" is not set correctly."
>  fi
>  
> -if [ "$OldRule" != "$NewRule" ]; then
> -	cat <<EOM
> -Notice: Test access rule changed from
> -"$OldRule" to "$NewRule".
> -EOM
> +if [ "$old_rule" != "$new_rule" ]; then
> +	tst_resm TINFO "Notice: Test access rule changed from \"$old_rule\" \
> +to \"$new_rule\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_netlabel.sh b/testcases/kernel/security/smack/smack_set_netlabel.sh
> index 4c4a384..c2b2f8a 100755
> --- a/testcases/kernel/security/smack/smack_set_netlabel.sh
> +++ b/testcases/kernel/security/smack/smack_set_netlabel.sh
> @@ -10,39 +10,42 @@
>  #	CAP_MAC_ADMIN
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_netlabel
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -RuleA="191.191.191.191 TheOne"
> -RuleA1="191.191.191.191/32 TheOne"
> -RuleB="191.190.190.0/24 TheOne"
> +. test.sh
>  
> -Old32=`grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/null`
> -Old24=`grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/null`
> +. smack_common.sh
>  
> -echo -n "$RuleA" 2>/dev/null > "$smackfsdir/netlabel"
> -New32=`grep "$RuleA1" $smackfsdir/netlabel 2>/dev/null`
> -if [ "$New32" != "$RuleA1" ]; then
> -	echo "Rule \"$RuleA\" did not get set."
> -	exit 1
> +rule_a="191.191.191.191 TheOne"
> +rule_a1="191.191.191.191/32 TheOne"
> +rule_b="191.190.190.0/24 TheOne"
> +
> +old32=$(grep "^191.191.191.191/32" "$smackfsdir/netlabel" 2>/dev/null)
> +old24=$(grep "^191.190.190.0/24" "$smackfsdir/netlabel" 2>/dev/null)
> +
> +echo -n "$rule_a" 2>/dev/null > "$smackfsdir/netlabel"
> +new32=$(grep "$rule_a1" $smackfsdir/netlabel 2>/dev/null)
> +if [ "$new32" != "$rule_a1" ]; then
> +	tst_brkm TFAIL "Rule \"$rule_a\" did not get set."
>  fi
>  
> -echo -n "$RuleB" 2>/dev/null > "$smackfsdir/netlabel"
> -New24=`grep "$RuleB" "$smackfsdir/netlabel" 2>/dev/null`
> -if [ "$New24" != "$RuleB" ]; then
> -	echo "Rule \"$RuleB\" did not get set."
> -	exit 1
> +echo -n "$rule_b" 2>/dev/null > "$smackfsdir/netlabel"
> +new24=$(grep "$rule_b" "$smackfsdir/netlabel" 2>/dev/null)
> +if [ "$new24" != "$rule_b" ]; then
> +	tst_brkm TFAIL "Rule \"$rule_b\" did not get set."
>  fi
>  
> -if [ "$Old24" != "$New24" ]; then
> -	cat <<EOM
> -Notice: Test access rule changed from
> -"$Old24" to "$New24".
> -EOM
> +if [ "$old24" != "$new24" ]; then
> +	tst_resm TINFO "Notice: Test access rule changed from \"$old24\" to \
> +\"$new24\"."
>  fi
>  
> -if [ "$Old32" != "$New32" ]; then
> -	cat <<EOM
> -Notice: Test access rule changed from
> -"$Old32" to "$New32".
> -EOM
> +if [ "$old32" != "$new32" ]; then
> +	tst_resm TINFO "Notice: Test access rule changed from \"$old32\" to \
> +\"$new32\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit
> diff --git a/testcases/kernel/security/smack/smack_set_onlycap.sh b/testcases/kernel/security/smack/smack_set_onlycap.sh
> index 4b7b53a..0136c04 100755
> --- a/testcases/kernel/security/smack/smack_set_onlycap.sh
> +++ b/testcases/kernel/security/smack/smack_set_onlycap.sh
> @@ -10,29 +10,32 @@
>  #	CAP_MAC_ADMIN
>  #
>  
> -source smack_common.sh
> +export TCID=smack_set_onlycap
> +export TST_TOTAL=1
> +export TST_COUNT=1
>  
> -MyLabel=`cat /proc/self/attr/current 2>/dev/null`
> -StartLabel=`cat "$smackfsdir/onlycap" 2>/dev/null`
> +. test.sh
>  
> -echo "$MyLabel" 2>/dev/null > "$smackfsdir/onlycap"
> +. smack_common.sh
>  
> -label=`cat "$smackfsdir/onlycap" 2>/dev/null`
> -if [ "$label" != "$MyLabel" ]; then
> -	cat <<EOM
> -The smack label reported for $smackfsdir/onlycap is "$label",
> -not the expected "$MyLabel".
> -EOM
> -	exit 1
> +my_label=$(cat /proc/self/attr/current 2>/dev/null)
> +start_label=$(cat "$smackfsdir/onlycap" 2>/dev/null)
> +
> +echo "$my_label" 2>/dev/null > "$smackfsdir/onlycap"
> +
> +label=$(cat "$smackfsdir/onlycap" 2>/dev/null)
> +if [ "$label" != "$my_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for \"$smackfsdir/onlycap\" \
> +is \"$label\", not the expected \"$my_label\"."
>  fi
>  
> -echo "$StartLabel" 2>/dev/null > "$smackfsdir/onlycap"
> +echo "$start_label" 2>/dev/null > "$smackfsdir/onlycap"
>  
> -label=`cat "$smackfsdir/onlycap" 2>/dev/null`
> -if [ "$label" != "$StartLabel" ]; then
> -	cat <<EOM
> -The smack label reported for the current process is "$label",
> -not the expected "$StartLabel".
> -EOM
> -	exit 1
> +label=$(cat "$smackfsdir/onlycap" 2>/dev/null)
> +if [ "$label" != "$start_label" ]; then
> +	tst_brkm TFAIL "The smack label reported for the current process is \
> +\"$label\", not the expected \"$start_label\"."
>  fi
> +
> +tst_resm TPASS "Test \"$TCID\" success."
> +tst_exit



------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
