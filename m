Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1XqPOt-0001uh-25
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:43:39 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XqPOq-0006Pz-Du
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:43:39 +0000
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <poornima.nayak@in.ibm.com>; 
	Mon, 17 Nov 2014 22:13:28 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 292E41258044
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Nov 2014 22:13:32 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAHGhxSs2556370
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 22:14:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAHGhOBh008760
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 22:13:24 +0530
In-Reply-To: <1416227940.10929.2.camel@G08JYZSD130126.localdomain>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
	<1416227940.10929.2.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Message-ID: <OFBF4427CD.765E36E1-ON65257D93.005B53D8-65257D93.005BDCA8@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Mon, 17 Nov 2014 22:09:26 +0530
Subject: Re: [LTP] [PATCH 2/5] ima_measurements.sh: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2679136292085748116=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multipart message in MIME format.
--===============2679136292085748116==
Content-Type: multipart/alternative;
	boundary="=_alternative 005BDCA465257D93_="

This is a multipart message in MIME format.
--=_alternative 005BDCA465257D93_=
Content-Type: text/plain; charset="US-ASCII"

If you delete this TST_COUNT how will the PAN engine keep track of test 
count ? I feel its required. Wait for comments from others in mailing 
list.
Rest of the patch looks fine.

Zeng Linggang <zenglg.jy@cn.fujitsu.com> wrote on 11/17/2014 06:09:00 PM:

> Zeng Linggang <zenglg.jy@cn.fujitsu.com> 
> 11/17/2014 06:09 PM
> 
> To
> 
> ltp-list <ltp-list@lists.sourceforge.net>
> 
> cc
> 
> Subject
> 
> [LTP] [PATCH 2/5] ima_measurements.sh: Some cleanup
> 
> * Use 'tst_check_cmds' instead of 'exists'.
> 
> * Use 'test_resm' instead of 'tst_res'.
> 
> * Use '$()' instead of '``'.
> 
> * Delete 'cat' and '<(file input)' while use 'sha1sum'.
> 
> * Delete some unuseful comments.
> 
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  .../integrity/ima/tests/ima_measurements.sh        | 142 ++++++
> +--------------
>  1 file changed, 49 insertions(+), 93 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/
> ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/
> ima_measurements.sh
> index e6b2b4f..6dde432 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -15,8 +15,8 @@
>  ## for more details.   ##
>  ##   ##
>  ## You should have received a copy of the GNU General Public 
> License          ##
> -## along with this program;  if not, write to the Free Software   ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 
> 02110-1301 USA    ##
> +## along with this program;  if not, write to the Free Software 
> Foundation,   ##
> +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  ##
>  ##   ##
> 
> 
################################################################################
>  #
> @@ -26,25 +26,19 @@
>  #       list based on policy.
>  #
>  # Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> -#
> -# Return        - zero on success
> -#               - non zero on failure. return value from commands ($RC)
> 
> 
################################################################################
> +export TST_TOTAL=3
> +export TCID="ima_measurements"
> +export TST_COUNT=0
> +
>  init()
>  {
> -   export TST_TOTAL=3
> -   export TCID="init"
> -        export TST_COUNT=0
> -   RC=0
> -
> -   exists sha1sum
> +   tst_check_cmds sha1sum
> 
>     # verify using default policy
>     if [ ! -f "$IMA_DIR/policy" ]; then
> -      tst_res TINFO $LTPTMP/imalog.$$ \
> -       "$TCID: not using default policy"
> +      tst_resm TINFO "not using default policy"
>     fi
> -   return $RC
>  }
> 
>  # Function:     test01
> @@ -52,40 +46,29 @@ init()
>  #        be added to the IMA measurement list.
>  test01()
>  {
> -   TCID="test01"
> -   TST_COUNT=1
> -   RC=0
> -
>     # Create file test.txt
> -   cat > $LTPIMA/test.txt <<-EOF || RC=$?
> -   `date` - this is a test file
> +   cat > test.txt <<-EOF
> +   $(date) - this is a test file
>     EOF
> -   if [ $RC -ne 0 ]; then
> -      tst_res TBROK $LTPTMP/imalog.$$ "" \
> -       "$TCID: Unable to create test file"
> -      return $RC
> +   if [ $? -ne 0 ]; then
> +      tst_brkm TBROK "Unable to create test file"
>     fi
> 
> -   # Calculating the sha1sum of $LTPTMP/test.txt should add
> +   # Calculating the sha1sum of test.txt should add
>     # the measurement to the measurement list.
>     # (Assumes SHA1 IMA measurements.)
> -   hash=$(sha1sum < "$LTPIMA/test.txt" | sed 's/  -//')
> +   hash=$(sha1sum "test.txt" | sed 's/  -//')
> 
>     # Check if the file is measured
>     # (i.e. contained in the ascii measurement list.)
> -   cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -       $LTPIMA/measurements
> +   cat /sys/kernel/security/ima/ascii_runtime_measurements > 
measurements
>     sleep 1
> -   `grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
> -   if [ $RC -ne 0 ]; then
> -      tst_res TFAIL $LTPTMP/imalog.$$ \
> -       "$TCID: TPM ascii measurement list does not contain sha1sum"
> -      return $RC
> +   $(grep $hash measurements > /dev/null)
> +   if [ $? -ne 0 ]; then
> +      tst_resm TFAIL "TPM ascii measurement list does not contain 
sha1sum"
>     else
> -      tst_res TPASS $LTPTMP/imalog.$$ \
> -       "$TCID: TPM ascii measurement list contains sha1sum"
> +      tst_resm TPASS "TPM ascii measurement list contains sha1sum"
>     fi
> -   return $RC
>  }
> 
>  # Function:     test02
> @@ -93,33 +76,23 @@ test01()
>  #         measurement to be added to the IMA measurement list.
>  test02()
>  {
> -   TCID="test02"
> -   TST_COUNT=2
> -   RC=0
> -
>     # Modify test.txt
> -   echo `$date` - file modified >> $LTPIMA/test.txt || RC=$?
> +   echo $($date) - file modified >> test.txt
> 
> -   # Calculating the sha1sum of $LTPTMP/test.txt should add
> +   # Calculating the sha1sum of test.txt should add
>     # the new measurement to the measurement list
> -   hash=`cat $LTPIMA/test.txt | sha1sum | sed 's/  -//'`
> +   hash=$(sha1sum test.txt | sed 's/  -//')
> 
>     # Check if the new measurement exists
> -   cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -      $LTPIMA/measurements
> -   `grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
> -
> -   if [ $RC -ne 0 ]; then
> -      tst_res TFAIL $LTPTMP/imalog.$$ \
> -       "$TCID: Modified file not measured"
> -      tst_res TINFO $LTPTMP/imalog.$$ \
> -       "$TCID: iversion not supported; or not mounted with iversion"
> -      return $RC
> +   cat /sys/kernel/security/ima/ascii_runtime_measurements > 
measurements
> +   $(grep $hash measurements > /dev/null)
> +
> +   if [ $? -ne 0 ]; then
> +      tst_resm TFAIL "Modified file not measured"
> +      tst_resm TINFO "iversion not supported; or not mounted with 
iversion"
>     else
> -      tst_res TPASS $LTPTMP/imalog.$$ \
> -       "$TCID: Modified file measured"
> +      tst_resm TPASS "Modified file measured"
>     fi
> -   return $RC
>  }
> 
>  # Function:     test03
> @@ -127,57 +100,40 @@ test02()
>  #      (Default policy does not measure user files.)
>  test03()
>  {
> -   TCID="test03"
> -   TST_COUNT=3
> -   RC=0
> -
>     # create file user-test.txt
> -   mkdir -m 0700 $LTPIMA/user
> -   chown nobody.nobody $LTPIMA/user
> -   cd $LTPIMA/user
> +   mkdir -m 0700 user
> +   chown nobody.nobody user
> +   cd user
>     hash=0
> 
>     # As user nobody, create and cat the new file
>     # (The LTP tests assumes existence of 'nobody'.)
> -   sudo -n -u nobody sh -c "echo `date` - create test.txt > ./test.txt;
> +   sudo -n -u nobody sh -c "echo $(date) - create test.txt > 
./test.txt;
>               cat ./test.txt > /dev/null"
> 
>     # Calculating the hash will add the measurement to the measurement
>     # list, so only calc the hash value after getting the measurement
>     # list.
> -   cat /sys/kernel/security/ima/ascii_runtime_measurements > \
> -       $LTPIMA/measurements
> -   hash=`cat ./test.txt | sha1sum | sed 's/  -//'`
> +   cat /sys/kernel/security/ima/ascii_runtime_measurements > 
measurements
> +   hash=$(sha1sum test.txt | sed 's/  -//')
>     cd - >/dev/null
> 
>     # Check if the file is measured
> -   grep $hash $LTPIMA/measurements > /dev/null || RC=$?
> -   if [ $RC -ne 0 ]; then
> -      RC=0
> -      tst_res TPASS $LTPTMP/imalog.$$ \
> -       "$TCID: user file test.txt not measured"
> +   grep $hash measurements > /dev/null
> +   if [ $? -ne 0 ]; then
> +      tst_resm TPASS "user file test.txt not measured"
>     else
> -      RC=1
> -      tst_res TFAIL $LTPTMP/imalog.$$ \
> -       "$TCID: user file test.txt measured"
> +      tst_resm TFAIL "user file test.txt measured"
>     fi
> -   return $RC
>  }
> 
> -# Function:     main
> -#
> -# Description:  - Execute all tests, exit with test status.
> -#
> -# Exit:         - zero on success
> -#               - non-zero on failure.
> -#
> -RC=0
> -EXIT_VAL=0
> -
> -. $(dirname "$0")/ima_setup.sh
> -setup || exit $?
> -init || exit $?
> -test01 || EXIT_VAL=$RC
> -test02 || EXIT_VAL=$RC
> -test03 || EXIT_VAL=$RC
> -exit $EXIT_VAL
> +. ima_setup.sh
> +TST_CLEANUP=cleanup
> +
> +setup
> +init
> +test01
> +test02
> +test03
> +
> +tst_exit
> -- 
> 1.8.3.1
> 
> 
> 
> 
> 
------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & 
more
> Get technology previously reserved for billion-dollar corporations, FREE
> 
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

--=_alternative 005BDCA465257D93_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">If you delete this TST_COUNT how will the
PAN engine keep track of test count ? I feel its required. Wait for comments
from others in mailing list.</font>
<br><font size=2 face="sans-serif">Rest of the patch looks fine.</font>
<br>
<br><tt><font size=2>Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt; wrote
on 11/17/2014 06:09:00 PM:<br>
<br>
&gt; Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt; </font></tt>
<br><tt><font size=2>&gt; 11/17/2014 06:09 PM</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; To</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; ltp-list &lt;ltp-list@lists.sourceforge.net&gt;</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; cc</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Subject</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; [LTP] [PATCH 2/5] ima_measurements.sh: Some cleanup</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; * Use 'tst_check_cmds' instead of 'exists'.<br>
&gt; <br>
&gt; * Use 'test_resm' instead of 'tst_res'.<br>
&gt; <br>
&gt; * Use '$()' instead of '``'.<br>
&gt; <br>
&gt; * Delete 'cat' and '&lt;(file input)' while use 'sha1sum'.<br>
&gt; <br>
&gt; * Delete some unuseful comments.<br>
&gt; <br>
&gt; * Some cleanup.<br>
&gt; <br>
&gt; Signed-off-by: Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;.../integrity/ima/tests/ima_measurements.sh &nbsp; &nbsp; &nbsp;
&nbsp;| 142 ++++++<br>
&gt; +--------------<br>
&gt; &nbsp;1 file changed, 49 insertions(+), 93 deletions(-)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/security/integrity/ima/tests/<br>
&gt; ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/<br>
&gt; ima_measurements.sh<br>
&gt; index e6b2b4f..6dde432 100755<br>
&gt; --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh<br>
&gt; +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh<br>
&gt; @@ -15,8 +15,8 @@<br>
&gt; &nbsp;## for more details. &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##<br>
&gt; &nbsp;## &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##<br>
&gt; &nbsp;## You should have received a copy of the GNU General Public
<br>
&gt; License &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##<br>
&gt; -## along with this program; &nbsp;if not, write to the Free Software
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ##<br>
&gt; -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
<br>
&gt; 02110-1301 USA &nbsp; &nbsp;##<br>
&gt; +## along with this program; &nbsp;if not, write to the Free Software
<br>
&gt; Foundation, &nbsp; ##<br>
&gt; +## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
&nbsp; &nbsp; &nbsp; ##<br>
&gt; &nbsp;## &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;##<br>
&gt; &nbsp;<br>
&gt; ################################################################################<br>
&gt; &nbsp;#<br>
&gt; @@ -26,25 +26,19 @@<br>
&gt; &nbsp;# &nbsp; &nbsp; &nbsp; list based on policy.<br>
&gt; &nbsp;#<br>
&gt; &nbsp;# Author: &nbsp; &nbsp; &nbsp; Mimi Zohar, zohar@ibm.vnet.ibm.com<br>
&gt; -#<br>
&gt; -# Return &nbsp; &nbsp; &nbsp; &nbsp;- zero on success<br>
&gt; -# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non zero on
failure. return value from commands ($RC)<br>
&gt; &nbsp;<br>
&gt; ################################################################################<br>
&gt; +export TST_TOTAL=3<br>
&gt; +export TCID=&quot;ima_measurements&quot;<br>
&gt; +export TST_COUNT=0<br>
&gt; +<br>
&gt; &nbsp;init()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; export TST_TOTAL=3<br>
&gt; - &nbsp; export TCID=&quot;init&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;export TST_COUNT=0<br>
&gt; - &nbsp; RC=0<br>
&gt; -<br>
&gt; - &nbsp; exists sha1sum<br>
&gt; + &nbsp; tst_check_cmds sha1sum<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # verify using default policy<br>
&gt; &nbsp; &nbsp; if [ ! -f &quot;$IMA_DIR/policy&quot; ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TINFO $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: not using default policy&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TINFO &quot;not using default policy&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; - &nbsp; return $RC<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;# Function: &nbsp; &nbsp; test01<br>
&gt; @@ -52,40 +46,29 @@ init()<br>
&gt; &nbsp;# &nbsp; &nbsp; &nbsp; &nbsp;be added to the IMA measurement
list.<br>
&gt; &nbsp;test01()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; TCID=&quot;test01&quot;<br>
&gt; - &nbsp; TST_COUNT=1<br>
&gt; - &nbsp; RC=0<br>
&gt; -<br>
&gt; &nbsp; &nbsp; # Create file test.txt<br>
&gt; - &nbsp; cat &gt; $LTPIMA/test.txt &lt;&lt;-EOF || RC=$?<br>
&gt; - &nbsp; `date` - this is a test file<br>
&gt; + &nbsp; cat &gt; test.txt &lt;&lt;-EOF<br>
&gt; + &nbsp; $(date) - this is a test file<br>
&gt; &nbsp; &nbsp; EOF<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TBROK $LTPTMP/imalog.$$ &quot;&quot;
\<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: Unable to create test file&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; + &nbsp; if [ $? -ne 0 ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_brkm TBROK &quot;Unable to create test file&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; &nbsp;<br>
&gt; - &nbsp; # Calculating the sha1sum of $LTPTMP/test.txt should add<br>
&gt; + &nbsp; # Calculating the sha1sum of test.txt should add<br>
&gt; &nbsp; &nbsp; # the measurement to the measurement list.<br>
&gt; &nbsp; &nbsp; # (Assumes SHA1 IMA measurements.)<br>
&gt; - &nbsp; hash=$(sha1sum &lt; &quot;$LTPIMA/test.txt&quot; | sed 's/
&nbsp;-//')<br>
&gt; + &nbsp; hash=$(sha1sum &quot;test.txt&quot; | sed 's/ &nbsp;-//')<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # Check if the file is measured<br>
&gt; &nbsp; &nbsp; # (i.e. contained in the ascii measurement list.)<br>
&gt; - &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
\<br>
&gt; - &nbsp; &nbsp; &nbsp; $LTPIMA/measurements<br>
&gt; + &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
measurements<br>
&gt; &nbsp; &nbsp; sleep 1<br>
&gt; - &nbsp; `grep $hash $LTPIMA/measurements &gt; /dev/null` || RC=$?<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TFAIL $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: TPM ascii measurement list does
not contain sha1sum&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; + &nbsp; $(grep $hash measurements &gt; /dev/null)<br>
&gt; + &nbsp; if [ $? -ne 0 ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;TPM ascii measurement list
does not contain sha1sum&quot;<br>
&gt; &nbsp; &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TPASS $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: TPM ascii measurement list contains
sha1sum&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TPASS &quot;TPM ascii measurement list
contains sha1sum&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; - &nbsp; return $RC<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;# Function: &nbsp; &nbsp; test02<br>
&gt; @@ -93,33 +76,23 @@ test01()<br>
&gt; &nbsp;# &nbsp; &nbsp; &nbsp; &nbsp; measurement to be added to the
IMA measurement list.<br>
&gt; &nbsp;test02()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; TCID=&quot;test02&quot;<br>
&gt; - &nbsp; TST_COUNT=2<br>
&gt; - &nbsp; RC=0<br>
&gt; -<br>
&gt; &nbsp; &nbsp; # Modify test.txt<br>
&gt; - &nbsp; echo `$date` - file modified &gt;&gt; $LTPIMA/test.txt ||
RC=$?<br>
&gt; + &nbsp; echo $($date) - file modified &gt;&gt; test.txt<br>
&gt; &nbsp;<br>
&gt; - &nbsp; # Calculating the sha1sum of $LTPTMP/test.txt should add<br>
&gt; + &nbsp; # Calculating the sha1sum of test.txt should add<br>
&gt; &nbsp; &nbsp; # the new measurement to the measurement list<br>
&gt; - &nbsp; hash=`cat $LTPIMA/test.txt | sha1sum | sed 's/ &nbsp;-//'`<br>
&gt; + &nbsp; hash=$(sha1sum test.txt | sed 's/ &nbsp;-//')<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # Check if the new measurement exists<br>
&gt; - &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
\<br>
&gt; - &nbsp; &nbsp; &nbsp;$LTPIMA/measurements<br>
&gt; - &nbsp; `grep $hash $LTPIMA/measurements &gt; /dev/null` || RC=$?<br>
&gt; -<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TFAIL $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: Modified file not measured&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TINFO $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: iversion not supported; or not
mounted with iversion&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; + &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
measurements<br>
&gt; + &nbsp; $(grep $hash measurements &gt; /dev/null)<br>
&gt; +<br>
&gt; + &nbsp; if [ $? -ne 0 ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;Modified file not measured&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TINFO &quot;iversion not supported;
or not mounted with iversion&quot;<br>
&gt; &nbsp; &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TPASS $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: Modified file measured&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TPASS &quot;Modified file measured&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; - &nbsp; return $RC<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;# Function: &nbsp; &nbsp; test03<br>
&gt; @@ -127,57 +100,40 @@ test02()<br>
&gt; &nbsp;# &nbsp; &nbsp; &nbsp;(Default policy does not measure user
files.)<br>
&gt; &nbsp;test03()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; TCID=&quot;test03&quot;<br>
&gt; - &nbsp; TST_COUNT=3<br>
&gt; - &nbsp; RC=0<br>
&gt; -<br>
&gt; &nbsp; &nbsp; # create file user-test.txt<br>
&gt; - &nbsp; mkdir -m 0700 $LTPIMA/user<br>
&gt; - &nbsp; chown nobody.nobody $LTPIMA/user<br>
&gt; - &nbsp; cd $LTPIMA/user<br>
&gt; + &nbsp; mkdir -m 0700 user<br>
&gt; + &nbsp; chown nobody.nobody user<br>
&gt; + &nbsp; cd user<br>
&gt; &nbsp; &nbsp; hash=0<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # As user nobody, create and cat the new file<br>
&gt; &nbsp; &nbsp; # (The LTP tests assumes existence of 'nobody'.)<br>
&gt; - &nbsp; sudo -n -u nobody sh -c &quot;echo `date` - create test.txt
&gt; ./test.txt;<br>
&gt; + &nbsp; sudo -n -u nobody sh -c &quot;echo $(date) - create test.txt
&gt; ./test.txt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cat ./test.txt &gt;
/dev/null&quot;<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # Calculating the hash will add the measurement to the
measurement<br>
&gt; &nbsp; &nbsp; # list, so only calc the hash value after getting the
measurement<br>
&gt; &nbsp; &nbsp; # list.<br>
&gt; - &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
\<br>
&gt; - &nbsp; &nbsp; &nbsp; $LTPIMA/measurements<br>
&gt; - &nbsp; hash=`cat ./test.txt | sha1sum | sed 's/ &nbsp;-//'`<br>
&gt; + &nbsp; cat /sys/kernel/security/ima/ascii_runtime_measurements &gt;
measurements<br>
&gt; + &nbsp; hash=$(sha1sum test.txt | sed 's/ &nbsp;-//')<br>
&gt; &nbsp; &nbsp; cd - &gt;/dev/null<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # Check if the file is measured<br>
&gt; - &nbsp; grep $hash $LTPIMA/measurements &gt; /dev/null || RC=$?<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;RC=0<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TPASS $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: user file test.txt not measured&quot;<br>
&gt; + &nbsp; grep $hash measurements &gt; /dev/null<br>
&gt; + &nbsp; if [ $? -ne 0 ]; then<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TPASS &quot;user file test.txt not
measured&quot;<br>
&gt; &nbsp; &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp;RC=1<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_res TFAIL $LTPTMP/imalog.$$ \<br>
&gt; - &nbsp; &nbsp; &nbsp; &quot;$TCID: user file test.txt measured&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_resm TFAIL &quot;user file test.txt measured&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; - &nbsp; return $RC<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; -# Function: &nbsp; &nbsp; main<br>
&gt; -#<br>
&gt; -# Description: &nbsp;- Execute all tests, exit with test status.<br>
&gt; -#<br>
&gt; -# Exit: &nbsp; &nbsp; &nbsp; &nbsp; - zero on success<br>
&gt; -# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non-zero on
failure.<br>
&gt; -#<br>
&gt; -RC=0<br>
&gt; -EXIT_VAL=0<br>
&gt; -<br>
&gt; -. $(dirname &quot;$0&quot;)/ima_setup.sh<br>
&gt; -setup || exit $?<br>
&gt; -init || exit $?<br>
&gt; -test01 || EXIT_VAL=$RC<br>
&gt; -test02 || EXIT_VAL=$RC<br>
&gt; -test03 || EXIT_VAL=$RC<br>
&gt; -exit $EXIT_VAL<br>
&gt; +. ima_setup.sh<br>
&gt; +TST_CLEANUP=cleanup<br>
&gt; +<br>
&gt; +setup<br>
&gt; +init<br>
&gt; +test01<br>
&gt; +test02<br>
&gt; +test03<br>
&gt; +<br>
&gt; +tst_exit<br>
&gt; -- <br>
&gt; 1.8.3.1<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ------------------------------------------------------------------------------<br>
&gt; Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server<br>
&gt; from Actuate! Instantly Supercharge Your Business Reports and Dashboards<br>
&gt; with Interactivity, Sharing, Native Excel Exports, App Integration
&amp; more<br>
&gt; Get technology previously reserved for billion-dollar corporations,
FREE<br>
&gt; </font></tt><a href="http://pubads.g.doubleclick.net/gampad/clk?id=157005751&amp;iu=/4140/ostg.clktrk"><tt><font size=2>http://pubads.g.doubleclick.net/gampad/clk?id=157005751&amp;iu=/4140/ostg.clktrk</font></tt></a><tt><font size=2><br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; Ltp-list@lists.sourceforge.net<br>
&gt; </font></tt><a href="https://lists.sourceforge.net/lists/listinfo/ltp-list"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/ltp-list</font></tt></a><tt><font size=2><br>
&gt; <br>
</font></tt>
--=_alternative 005BDCA465257D93_=--



--===============2679136292085748116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
--===============2679136292085748116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2679136292085748116==--


