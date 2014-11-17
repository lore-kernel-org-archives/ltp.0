Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <poornima.nayak@in.ibm.com>) id 1XqPIr-0006He-1v
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:37:25 +0000
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XqPIo-0000M6-Eq
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:37:25 +0000
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <poornima.nayak@in.ibm.com>; 
	Mon, 17 Nov 2014 22:07:14 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0A9A11258044
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Nov 2014 22:07:18 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAHGbirE54919188
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 22:07:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAHGbAPv026549
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 22:07:10 +0530
In-Reply-To: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Message-ID: <OF0609F637.69F59023-ON65257D93.005AC8D2-65257D93.005B4A77@in.ibm.com>
From: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Date: Mon, 17 Nov 2014 22:03:11 +0530
Subject: Re: [LTP] [PATCH 1/5] ima_setup.sh: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3563270405159243711=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

This is a multipart message in MIME format.
--===============3563270405159243711==
Content-Type: multipart/alternative;
	boundary="=_alternative 005B4A7365257D93_="

This is a multipart message in MIME format.
--=_alternative 005B4A7365257D93_=
Content-Type: text/plain; charset="US-ASCII"

Zeng Linggang <zenglg.jy@cn.fujitsu.com> wrote on 11/17/2014 06:08:12 PM:

> Zeng Linggang <zenglg.jy@cn.fujitsu.com> 
> 11/17/2014 06:08 PM
> 
> To
> 
> ltp-list <ltp-list@lists.sourceforge.net>
> 
> cc
> 
> Subject
> 
> [LTP] [PATCH 1/5] ima_setup.sh: Some cleanup
> 
> * Use 'test.sh'.
> 
> * Use 'test_brkm' instead of 'tst_resm TBROK'.
> 
> * Use 'tst_tmpdir' and 'tst_rmdir'.
> 
> * Delete some unuseful comments.
> 
> * Some cleanup.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  .../security/integrity/ima/tests/ima_setup.sh      | 85 ++
> +-------------------
>  1 file changed, 12 insertions(+), 73 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/
> ima_setup.sh 
b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 4013e1f..0ff38d2 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -14,8 +14,8 @@
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
> @@ -24,13 +24,10 @@
>  # Description:  setup/cleanup routines for the integrity tests.
>  #
>  # Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> -#
> -# Return        - zero on success
> -#               - non zero on failure. return value from commands ($RC)
> 
> 
################################################################################
> +. test.sh
>  mount_sysfs()
>  {
> -
>     SYSFS=$(mount 2>/dev/null | awk '$5 == "sysfs" { print $3 }')
>     if [ "x$SYSFS" = x ] ; then
> 
> @@ -38,22 +35,17 @@ mount_sysfs()
> 
>        test -d $SYSFS || mkdir -p $SYSFS 2>/dev/null
>        if [ $? -ne 0 ] ; then
> -         tst_resm TBROK "Failed to mkdir $SYSFS"
> -         return 1
> +         tst_brkm TBROK "Failed to mkdir $SYSFS"
>        fi
>        if ! mount -t sysfs sysfs $SYSFS 2>/dev/null ; then
> -         tst_resm TBROK "Failed to mount $SYSFS"
> -         return 1
> +         tst_brkm TBROK "Failed to mount $SYSFS"
>        fi
> 
>     fi
> -
> -   return 0
>  }
> 
>  mount_securityfs()
>  {
> -
>     SECURITYFS=$(mount 2>/dev/null | awk '$5 == "securityfs" { print $3 
}')
>     if [ "x$SECURITYFS" = x ] ; then
> 
> @@ -61,87 +53,34 @@ mount_securityfs()
> 
>        test -d $SECURITYFS || mkdir -p $SECURITYFS 2>/dev/null
>        if [ $? -ne 0 ] ; then
> -         tst_resm TBROK "Failed to mkdir $SECURITYFS"
> -         return 1
> +         tst_brkm TBROK "Failed to mkdir $SECURITYFS"
>        fi
>        if ! mount -t securityfs securityfs $SECURITYFS 2>/dev/null ; 
then
> -         tst_resm TBROK "Failed to mount $SECURITYFS"
> -         return 1
> +         tst_brkm TBROK "Failed to mount $SECURITYFS"
>        fi
> 
>     fi
> -
> -   return 0
> -
>  }
> 
>  setup()
>  {
> -   export TST_TOTAL=1
> -   export TCID="setup"
> -        export TST_COUNT=0
> -
> -   LTPBIN=
> -   LTPIMA=
> -
> -   trap "cleanup" 0
> -   if [ -z "$TMPDIR" ]; then
> -      LTPTMP=/tmp
> -   else
> -      LTPTMP=${TMPDIR}
> -   fi
> -   if [ -z "$LTPBIN" ]; then
> -      LTPBIN=../../../../../bin
> -      PATH=$PATH:$LTPBIN
> -   fi
> -
>     tst_require_root
> 
> -   # create the temporary directory used by this testcase
> -   LTPIMA=$LTPTMP/ima
> -   umask 077
> -   mkdir $LTPIMA > /dev/null 2>&1 || RC=$?
> -   if [ $RC -ne 0 ]; then
> -      tst_resm TBROK "Unable to create temporary directory"
> -      return $RC
> -   fi
> +   tst_tmpdir
> 
> -   # mount sysfs if it is not already mounted
> -   mount_sysfs || RC=$?
> -   if [ $RC -ne 0 ]; then
> -      tst_resm TBROK "Cannot mount sysfs"
> -      return $RC
> -   fi
> +   mount_sysfs
> 
>     # mount securityfs if it is not already mounted
> -   mount_securityfs || RC=$?
> -   if [ $RC -ne 0 ]; then
> -      tst_resm TBROK "Cannot mount securityfs"
> -      return $RC
> -   fi
> -
> -   mount
> +   mount_securityfs
> 
>     # IMA must be configured in the kernel
>     IMA_DIR=$SECURITYFS/ima
>     if [ ! -d "$IMA_DIR" ]; then
> -      tst_resm TCONF "IMA not enabled in kernel"
> -      RC=1
> +      tst_brkm TCONF "IMA not enabled in kernel"
>     fi
> -   return $RC
>  }
> 
> -# Function:     cleanup
> -#
> -# Description   - remove temporary files and directories.
> -#
> -# Return        - zero on success
> -#               - non zero on failure. return value from commands ($RC)
>  cleanup()
>  {
> -   tst_resm TINFO "CLEAN: removing $LTPIMA"
> -   rm -rf "$LTPIMA" || RC=$?
> -   return $RC
> +   tst_rmdir
>  }
> -
> -. cmdlib.sh
> -- 
> 1.8.3.1
> 
> 
> 
This patch looks fine
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

--=_alternative 005B4A7365257D93_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt; wrote
on 11/17/2014 06:08:12 PM:<br>
<br>
&gt; Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt; </font></tt>
<br><tt><font size=2>&gt; 11/17/2014 06:08 PM</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; To</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; ltp-list &lt;ltp-list@lists.sourceforge.net&gt;</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; cc</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; Subject</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; [LTP] [PATCH 1/5] ima_setup.sh: Some cleanup</font></tt>
<br><tt><font size=2>&gt; <br>
&gt; * Use 'test.sh'.<br>
&gt; <br>
&gt; * Use 'test_brkm' instead of 'tst_resm TBROK'.<br>
&gt; <br>
&gt; * Use 'tst_tmpdir' and 'tst_rmdir'.<br>
&gt; <br>
&gt; * Delete some unuseful comments.<br>
&gt; <br>
&gt; * Some cleanup.<br>
&gt; <br>
&gt; Signed-off-by: Zeng Linggang &lt;zenglg.jy@cn.fujitsu.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;.../security/integrity/ima/tests/ima_setup.sh &nbsp; &nbsp;
&nbsp;| 85 ++<br>
&gt; +-------------------<br>
&gt; &nbsp;1 file changed, 12 insertions(+), 73 deletions(-)<br>
&gt; <br>
&gt; diff --git a/testcases/kernel/security/integrity/ima/tests/<br>
&gt; ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh<br>
&gt; index 4013e1f..0ff38d2 100755<br>
&gt; --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh<br>
&gt; +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh<br>
&gt; @@ -14,8 +14,8 @@<br>
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
&gt; @@ -24,13 +24,10 @@<br>
&gt; &nbsp;# Description: &nbsp;setup/cleanup routines for the integrity
tests.<br>
&gt; &nbsp;#<br>
&gt; &nbsp;# Author: &nbsp; &nbsp; &nbsp; Mimi Zohar, zohar@ibm.vnet.ibm.com<br>
&gt; -#<br>
&gt; -# Return &nbsp; &nbsp; &nbsp; &nbsp;- zero on success<br>
&gt; -# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non zero on
failure. return value from commands ($RC)<br>
&gt; &nbsp;<br>
&gt; ################################################################################<br>
&gt; +. test.sh<br>
&gt; &nbsp;mount_sysfs()<br>
&gt; &nbsp;{<br>
&gt; -<br>
&gt; &nbsp; &nbsp; SYSFS=$(mount 2&gt;/dev/null | awk '$5 == &quot;sysfs&quot;
{ print $3 }')<br>
&gt; &nbsp; &nbsp; if [ &quot;x$SYSFS&quot; = x ] ; then<br>
&gt; &nbsp;<br>
&gt; @@ -38,22 +35,17 @@ mount_sysfs()<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;test -d $SYSFS || mkdir -p $SYSFS 2&gt;/dev/null<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if [ $? -ne 0 ] ; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TBROK &quot;Failed to mkdir
$SYSFS&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; return 1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tst_brkm TBROK &quot;Failed to mkdir
$SYSFS&quot;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if ! mount -t sysfs sysfs $SYSFS 2&gt;/dev/null
; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TBROK &quot;Failed to mount
$SYSFS&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; return 1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tst_brkm TBROK &quot;Failed to mount
$SYSFS&quot;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; -<br>
&gt; - &nbsp; return 0<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;mount_securityfs()<br>
&gt; &nbsp;{<br>
&gt; -<br>
&gt; &nbsp; &nbsp; SECURITYFS=$(mount 2&gt;/dev/null | awk '$5 == &quot;securityfs&quot;
{ print $3 }')<br>
&gt; &nbsp; &nbsp; if [ &quot;x$SECURITYFS&quot; = x ] ; then<br>
&gt; &nbsp;<br>
&gt; @@ -61,87 +53,34 @@ mount_securityfs()<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;test -d $SECURITYFS || mkdir -p $SECURITYFS
2&gt;/dev/null<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if [ $? -ne 0 ] ; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TBROK &quot;Failed to mkdir
$SECURITYFS&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; return 1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tst_brkm TBROK &quot;Failed to mkdir
$SECURITYFS&quot;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;if ! mount -t securityfs securityfs $SECURITYFS
2&gt;/dev/null ; then<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; tst_resm TBROK &quot;Failed to mount
$SECURITYFS&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp; return 1<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tst_brkm TBROK &quot;Failed to mount
$SECURITYFS&quot;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;fi<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; -<br>
&gt; - &nbsp; return 0<br>
&gt; -<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; &nbsp;setup()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; export TST_TOTAL=1<br>
&gt; - &nbsp; export TCID=&quot;setup&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp; &nbsp;export TST_COUNT=0<br>
&gt; -<br>
&gt; - &nbsp; LTPBIN=<br>
&gt; - &nbsp; LTPIMA=<br>
&gt; -<br>
&gt; - &nbsp; trap &quot;cleanup&quot; 0<br>
&gt; - &nbsp; if [ -z &quot;$TMPDIR&quot; ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;LTPTMP=/tmp<br>
&gt; - &nbsp; else<br>
&gt; - &nbsp; &nbsp; &nbsp;LTPTMP=${TMPDIR}<br>
&gt; - &nbsp; fi<br>
&gt; - &nbsp; if [ -z &quot;$LTPBIN&quot; ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;LTPBIN=../../../../../bin<br>
&gt; - &nbsp; &nbsp; &nbsp;PATH=$PATH:$LTPBIN<br>
&gt; - &nbsp; fi<br>
&gt; -<br>
&gt; &nbsp; &nbsp; tst_require_root<br>
&gt; &nbsp;<br>
&gt; - &nbsp; # create the temporary directory used by this testcase<br>
&gt; - &nbsp; LTPIMA=$LTPTMP/ima<br>
&gt; - &nbsp; umask 077<br>
&gt; - &nbsp; mkdir $LTPIMA &gt; /dev/null 2&gt;&amp;1 || RC=$?<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_resm TBROK &quot;Unable to create temporary
directory&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; - &nbsp; fi<br>
&gt; + &nbsp; tst_tmpdir<br>
&gt; &nbsp;<br>
&gt; - &nbsp; # mount sysfs if it is not already mounted<br>
&gt; - &nbsp; mount_sysfs || RC=$?<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_resm TBROK &quot;Cannot mount sysfs&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; - &nbsp; fi<br>
&gt; + &nbsp; mount_sysfs<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # mount securityfs if it is not already mounted<br>
&gt; - &nbsp; mount_securityfs || RC=$?<br>
&gt; - &nbsp; if [ $RC -ne 0 ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_resm TBROK &quot;Cannot mount securityfs&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;return $RC<br>
&gt; - &nbsp; fi<br>
&gt; -<br>
&gt; - &nbsp; mount<br>
&gt; + &nbsp; mount_securityfs<br>
&gt; &nbsp;<br>
&gt; &nbsp; &nbsp; # IMA must be configured in the kernel<br>
&gt; &nbsp; &nbsp; IMA_DIR=$SECURITYFS/ima<br>
&gt; &nbsp; &nbsp; if [ ! -d &quot;$IMA_DIR&quot; ]; then<br>
&gt; - &nbsp; &nbsp; &nbsp;tst_resm TCONF &quot;IMA not enabled in kernel&quot;<br>
&gt; - &nbsp; &nbsp; &nbsp;RC=1<br>
&gt; + &nbsp; &nbsp; &nbsp;tst_brkm TCONF &quot;IMA not enabled in kernel&quot;<br>
&gt; &nbsp; &nbsp; fi<br>
&gt; - &nbsp; return $RC<br>
&gt; &nbsp;}<br>
&gt; &nbsp;<br>
&gt; -# Function: &nbsp; &nbsp; cleanup<br>
&gt; -#<br>
&gt; -# Description &nbsp; - remove temporary files and directories.<br>
&gt; -#<br>
&gt; -# Return &nbsp; &nbsp; &nbsp; &nbsp;- zero on success<br>
&gt; -# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; - non zero on
failure. return value from commands ($RC)<br>
&gt; &nbsp;cleanup()<br>
&gt; &nbsp;{<br>
&gt; - &nbsp; tst_resm TINFO &quot;CLEAN: removing $LTPIMA&quot;<br>
&gt; - &nbsp; rm -rf &quot;$LTPIMA&quot; || RC=$?<br>
&gt; - &nbsp; return $RC<br>
&gt; + &nbsp; tst_rmdir<br>
&gt; &nbsp;}<br>
&gt; -<br>
&gt; -. cmdlib.sh<br>
&gt; -- <br>
&gt; 1.8.3.1<br>
&gt; <br>
&gt; <br>
&gt; </font></tt>
<br><tt><font size=2>This patch looks fine<br>
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
--=_alternative 005B4A7365257D93_=--



--===============3563270405159243711==
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
--===============3563270405159243711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3563270405159243711==--


