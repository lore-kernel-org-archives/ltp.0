Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czyzak2@linux.vnet.ibm.com>) id 1QtooZ-0008WI-2B
	for ltp-list@lists.sourceforge.net; Wed, 17 Aug 2011 22:42:23 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QtooX-0005an-Qs
	for ltp-list@lists.sourceforge.net; Wed, 17 Aug 2011 22:42:23 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7HMJD21022407
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 18:19:13 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7HMgGTa203512
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 18:42:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7HIg3d0027471
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Aug 2011 15:42:03 -0300
Message-ID: <4E4C43C9.2040303@linux.vnet.ibm.com>
Date: Wed, 17 Aug 2011 17:42:17 -0500
From: James Czyzak <czyzak2@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH 1/1] Two added files for common criteria evaluation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6926460297703608666=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Shubham <shubham@linux.vnet.ibm.com>, ltp-list@lists.sourceforge.net
Cc: debora@linux.vnet.ibm.com

This is a multi-part message in MIME format.
--===============6926460297703608666==
Content-Type: multipart/alternative;
	boundary="------------070706000501030306040808"

This is a multi-part message in MIME format.
--------------070706000501030306040808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Two files I would like to add for the purpose of running some tests that 
are required for a common criteria evaluation against the ospp 
protection policy that are not currently included in other test suites. 
These become specific to the security target they are run against so 
possibly if these cannot be included in the LTP git tree maybe there is 
somewhere on the LTP site they could be made available? Also please let 
me know if this patch has trouble with extra unseen characters. I have 
had reports from some other groups that that has occurred. It's possible 
that the mozilla Thunderbird mail client I'm running on a windows 
machine is the culprit. In the past when this has occurred I have been 
able to submit the patches as an attachment which seems to eliminate the 
problem at least for those that have reported this problem to me.

Signed-off-by James Czyzak <czyzak2@linux.vnet.ibm.com> 
<mailto:czyzak2@linux.vnet.ibm.com>


diff --git a/testscripts/cc_ospp.sh b/testscripts/cc_ospp.sh
new file mode 100755
index 0000000..69feb80
--- /dev/null
+++ b/testscripts/cc_ospp.sh
@@ -0,0 +1,168 @@
+#!/bin/sh
+
+
+#
+#  08/17/11 - Jim Czyzak   - This script is based upon runEALtests.sh 
script.
+#                            It has been modified to use the command file
+#                            cc_commands and only include arguments 
that might
+#                            be useful for the common criteria testing 
against
+#                            the ospp in conjunction with the 
audit-test suite.
+#                            Also includes code to turn off screen in
+#                            /etc/profile for the test run as screen 
interferes
+#                            with the su tests (screen is turned on in the
+#                            in some evaluated configurations for 
purposes of
+#                            securing display devices)
+
+cd `dirname $0`
+export LTPROOT=${PWD}
+export TMPBASE="/tmp"
+export TMP="${TMPBASE}/runalltests-$$"
+export PATH="${PATH}:${LTPROOT}/../testcases/bin"
+cmdfile="${LTPROOT}/../runtest/cc_commands"
+pretty_prt=" "
+alt_dir=0
+quiet_mode=" "
+
+usage()
+{
+       cat <<-END >&2
+    usage: ./${0##*/} -c [-d tmpdir] [-f cmdfile ] [ -l logfile ]
+                  -q [ -r ltproot ] [ -t duration ] [ -x instances ]
+
+    -c              Run LTP under additional background CPU load.
+    -d tmpdir       Directory where temporary files will be created.
+    -f cmdfile      Execute user defined list of testcases.
+    -h              Help. Prints all available options.
+    -l logfile      Log results of test in a logfile.
+    -p              Human readable format logfiles.
+    -q              Print less verbose output to screen.
+    -r ltproot      Fully qualified path where testsuite is installed.
+    -t duration     Execute the testsuite for given duration in hours.
+    -x instances    Run multiple instances of this testsuite.
+
+    example: ./${0##*/} -i 1024 -m 128 -p -q  -l /tmp/resultlog.$$ -d 
${PWD}
+       END
+exit
+}
+
+mkdir -p ${TMP}
+
+cd ${TMP}
+if [ $? -ne 0 ]; then
+  echo "could not cd ${TMP} ... exiting"
+  exit
+fi
+
+while getopts cd:f:h:l:pqr:t:x arg
+do  case $arg in
+    c)
+            $LTPROOT/../testcases/bin/genload --cpu 1 2>&1 1>/dev/null &
+            GenLoad=1 ;;
+
+    d)      # append $$ to TMP, as it is recursively
+            # removed at end of script.
+            TMPBASE=$OPTARG;;
+    f)        # Execute user defined set of testcases.
+            cmdfile=$OPTARG;;
+
+    h)      usage;;
+
+    l)
+            if [ ${OPTARG:0:1} != "/" ]
+                        then
+                                if [ -d $LTPROOT/results ]
+                                then
+                                        logfile="-l 
$LTPROOT/results/$OPTARG"
+                                else
+                                        mkdir -p $LTPROOT/results
+                                        if [ $? -ne 0 ]
+                                        then
+                                                echo "ERROR: failed to 
create $
+                                                exit 1
+                                        fi
+                                        logfile="-l 
$LTPROOT/results/$OPTARG"
+                                fi
+                                alt_dir=1
+            else
+                                logfile="-l $OPTARG"
+                        fi ;;
+
+    p)      pretty_prt=" -p ";;
+
+    q)      quiet_mode=" -q ";;
+
+    r)      LTPROOT=$OPTARG;;
+
+    t)      # In case you want to specify the time
+            # to run from the command line
+            # (2m = two minutes, 2h = two hours, etc)
+            duration="-t $OPTARG" ;;
+
+    x)      # number of ltp's to run
+            instances="-x $OPTARG";;
+
+    \?)     usage;;
+    esac
+done
+
+if [ -z $PASSWD ]
+then
+        echo " "
+        echo "ERROR:"
+        echo "Please export enviroment variable PASSWD"
+        echo "INFO: export PASSWD = 'root's password'"
+    exit 1
+fi
+
+if [ -n "$instances" ]; then
+  instances="$instances -O ${TMP}"
+fi
+
+
+# If user does not provide a command file select a default set of testcases
+# to execute.
+if [ -z $cmdfile ]
+then
+        cat ${LTPROOT}/../runtest/admin_tools > ${TMP}/alltests
+else
+    cat $cmdfile > ${TMP}/alltests
+fi
+
+# The fsx-linux tests use the SCRATCHDEV environment variable as a location
+# that can be reformatted and run on.  Set SCRATCHDEV if you want to run
+# these tests.  As a safeguard, this is disabled.
+unset SCRATCHDEV
+if [ -n "$SCRATCHDEV" ]; then
+  cat ${LTPROOT}/../runtest/fsx >> ${TMP}/alltests
+fi
+
+# turn off screen in /etc/profile
+tmpbkup=$(mktemp "/etc/profile.XXXXXX") || exit 1
+cp -a /etc/profile $tmpbkup || exit 1
+sed -i 's/\[ -w $(tty) \]/false/' /etc/profile
+
+# display versions of installed software
+${LTPROOT}/../ver_linux
+
+${LTPROOT}/../bin/ltp-pan $quiet_mode -e -S $instances $duration -a $$ 
-n $$ $pretty_
+
+if [ $? -eq 0 ]; then
+  echo ltp-pan reported PASS
+else
+  echo ltp-pan reported FAIL
+fi
+
+if [ $alt_dir -eq 1 ]
+then
+        echo " "
+        echo 
"###############################################################"
+        echo " "
+        echo " result log is in the $LTPROOT/results directory"
+        echo " "
+        echo 
"###############################################################"
+        echo " "
+fi
+# restore /etc/profile
+mv -f $tmpbkup /etc/profile
+
+rm -rf ${TMP}
diff --git a/runtest/cc_commands b/runtest/cc_commands
new file mode 100644
index 0000000..2ba85c7
--- /dev/null
+++ b/runtest/cc_commands
@@ -0,0 +1,5 @@
+ping export LTPROOT; ping01
+ssh01 ssh01
+ssh02 ssh02
+ssh03 ssh03
+su01 export TCbin=$LTPROOT/../testcases/bin;su01


--------------070706000501030306040808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    Two files I would like to add for the purpose of running some tests
    that are required for a common criteria evaluation against the ospp
    protection policy that are not currently included in other test
    suites. These become specific to the security target they are run
    against so possibly if these cannot be included in the LTP git tree
    maybe there is somewhere on the LTP site they could be made
    available? Also please let me know if this patch has trouble with
    extra unseen characters. I have had reports from some other groups
    that that has occurred. It's possible that the mozilla Thunderbird
    mail client I'm running on a windows machine is the culprit. In the
    past when this has occurred I have been able to submit the patches
    as an attachment which seems to eliminate the problem at least for
    those that have reported this problem to me.<br>
    <br>
    Signed-off-by James Czyzak <font color="#000000"> </font><font
      color="#3366ff"><font color="#000000"><a
          href="mailto:czyzak2@linux.vnet.ibm.com">&lt;czyzak2@linux.vnet.ibm.com&gt;</a></font></font><br>
    <br>
    <br>
    diff --git a/testscripts/cc_ospp.sh b/testscripts/cc_ospp.sh<br>
    new file mode 100755<br>
    index 0000000..69feb80<br>
    --- /dev/null<br>
    +++ b/testscripts/cc_ospp.sh<br>
    @@ -0,0 +1,168 @@<br>
    +#!/bin/sh<br>
    +<br>
    +<br>
    +#<br>
    +#&nbsp; 08/17/11 - Jim Czyzak&nbsp;&nbsp; - This script is based upon
    runEALtests.sh script.<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; It has been modified to use the
    command file<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cc_commands and only include arguments
    that might<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; be useful for the common criteria
    testing against<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the ospp in conjunction with the
    audit-test suite.<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Also includes code to turn off screen
    in<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /etc/profile for the test run as
    screen interferes<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; with the su tests (screen is turned on
    in the<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in some evaluated configurations for
    purposes of<br>
    +#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securing display devices)<br>
    +<br>
    +cd `dirname $0`<br>
    +export LTPROOT=${PWD}<br>
    +export TMPBASE="/tmp"<br>
    +export TMP="${TMPBASE}/runalltests-$$"<br>
    +export PATH="${PATH}:${LTPROOT}/../testcases/bin"<br>
    +cmdfile="${LTPROOT}/../runtest/cc_commands"<br>
    +pretty_prt=" "<br>
    +alt_dir=0<br>
    +quiet_mode=" "<br>
    +<br>
    +usage()<br>
    +{<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat &lt;&lt;-END &gt;&amp;2<br>
    +&nbsp;&nbsp;&nbsp; usage: ./${0##*/} -c [-d tmpdir] [-f cmdfile ] [ -l logfile ]<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -q [ -r ltproot ] [ -t duration ] [ -x instances
    ]<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; -c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Run LTP under additional background CPU load.<br>
    +&nbsp;&nbsp;&nbsp; -d tmpdir&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Directory where temporary files will be
    created.<br>
    +&nbsp;&nbsp;&nbsp; -f cmdfile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Execute user defined list of testcases.<br>
    +&nbsp;&nbsp;&nbsp; -h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Help. Prints all available options.<br>
    +&nbsp;&nbsp;&nbsp; -l logfile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Log results of test in a logfile.<br>
    +&nbsp;&nbsp;&nbsp; -p&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Human readable format logfiles.<br>
    +&nbsp;&nbsp;&nbsp; -q&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print less verbose output to screen.<br>
    +&nbsp;&nbsp;&nbsp; -r ltproot&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fully qualified path where testsuite is
    installed.<br>
    +&nbsp;&nbsp;&nbsp; -t duration&nbsp;&nbsp;&nbsp;&nbsp; Execute the testsuite for given duration in
    hours.<br>
    +&nbsp;&nbsp;&nbsp; -x instances&nbsp;&nbsp;&nbsp; Run multiple instances of this testsuite.<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; example: ./${0##*/} -i 1024 -m 128 -p -q&nbsp; -l /tmp/resultlog.$$
    -d ${PWD}<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END<br>
    +exit<br>
    +}<br>
    +<br>
    +mkdir -p ${TMP}<br>
    +<br>
    +cd ${TMP}<br>
    +if [ $? -ne 0 ]; then<br>
    +&nbsp; echo "could not cd ${TMP} ... exiting"<br>
    +&nbsp; exit<br>
    +fi<br>
    +<br>
    +while getopts cd:f:h:l:pqr:t:x arg<br>
    +do&nbsp; case $arg in<br>
    +&nbsp;&nbsp;&nbsp; c)<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $LTPROOT/../testcases/bin/genload --cpu 1 2&gt;&amp;1
    1&gt;/dev/null &amp;<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GenLoad=1 ;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; d)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # append $$ to TMP, as it is recursively<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # removed at end of script.<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TMPBASE=$OPTARG;;<br>
    +&nbsp;&nbsp;&nbsp; f)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Execute user defined set of testcases.<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmdfile=$OPTARG;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; h)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usage;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; l)<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ ${OPTARG:0:1} != "/" ]<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -d $LTPROOT/results ]<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logfile="-l
    $LTPROOT/results/$OPTARG"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $LTPROOT/results<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ $? -ne 0 ]<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "ERROR: failed
    to create $<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit 1<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logfile="-l
    $LTPROOT/results/$OPTARG"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alt_dir=1<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; logfile="-l $OPTARG"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi ;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; p)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pretty_prt=" -p ";;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; q)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; quiet_mode=" -q ";;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; r)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LTPROOT=$OPTARG;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; t)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # In case you want to specify the time<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # to run from the command line<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # (2m = two minutes, 2h = two hours, etc)<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; duration="-t $OPTARG" ;;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # number of ltp's to run<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; instances="-x $OPTARG";;<br>
    +<br>
    +&nbsp;&nbsp;&nbsp; \?)&nbsp;&nbsp;&nbsp;&nbsp; usage;;<br>
    +&nbsp;&nbsp;&nbsp; esac<br>
    +done<br>
    +<br>
    +if [ -z $PASSWD ]<br>
    +then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " "<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "ERROR:"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "Please export enviroment variable PASSWD"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo "INFO: export PASSWD = 'root's password'"<br>
    +&nbsp;&nbsp;&nbsp; exit 1<br>
    +fi<br>
    +<br>
    +if [ -n "$instances" ]; then<br>
    +&nbsp; instances="$instances -O ${TMP}"<br>
    +fi<br>
    +<br>
    +<br>
    +# If user does not provide a command file select a default set of
    testcases<br>
    +# to execute.<br>
    +if [ -z $cmdfile ]<br>
    +then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat ${LTPROOT}/../runtest/admin_tools &gt; ${TMP}/alltests<br>
    +else<br>
    +&nbsp;&nbsp;&nbsp; cat $cmdfile &gt; ${TMP}/alltests<br>
    +fi<br>
    +<br>
    +# The fsx-linux tests use the SCRATCHDEV environment variable as a
    location<br>
    +# that can be reformatted and run on.&nbsp; Set SCRATCHDEV if you want
    to run<br>
    +# these tests.&nbsp; As a safeguard, this is disabled.<br>
    +unset SCRATCHDEV<br>
    +if [ -n "$SCRATCHDEV" ]; then<br>
    +&nbsp; cat ${LTPROOT}/../runtest/fsx &gt;&gt; ${TMP}/alltests<br>
    +fi<br>
    +<br>
    +# turn off screen in /etc/profile<br>
    +tmpbkup=$(mktemp "/etc/profile.XXXXXX") || exit 1<br>
    +cp -a /etc/profile $tmpbkup || exit 1<br>
    +sed -i 's/\[ -w $(tty) \]/false/' /etc/profile<br>
    +<br>
    +# display versions of installed software<br>
    +${LTPROOT}/../ver_linux<br>
    +<br>
    +${LTPROOT}/../bin/ltp-pan $quiet_mode -e -S $instances $duration -a
    $$ -n $$ $pretty_<br>
    +<br>
    +if [ $? -eq 0 ]; then<br>
    +&nbsp; echo ltp-pan reported PASS<br>
    +else<br>
    +&nbsp; echo ltp-pan reported FAIL<br>
    +fi<br>
    +<br>
    +if [ $alt_dir -eq 1 ]<br>
    +then<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " "<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo
    "###############################################################"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " "<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " result log is in the $LTPROOT/results directory"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " "<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo
    "###############################################################"<br>
    +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; echo " "<br>
    +fi<br>
    +# restore /etc/profile<br>
    +mv -f $tmpbkup /etc/profile<br>
    +<br>
    +rm -rf ${TMP}<br>
    diff --git a/runtest/cc_commands b/runtest/cc_commands<br>
    new file mode 100644<br>
    index 0000000..2ba85c7<br>
    --- /dev/null<br>
    +++ b/runtest/cc_commands<br>
    @@ -0,0 +1,5 @@<br>
    +ping export LTPROOT; ping01<br>
    +ssh01 ssh01<br>
    +ssh02 ssh02<br>
    +ssh03 ssh03<br>
    +su01 export TCbin=$LTPROOT/../testcases/bin;su01<br>
    <br>
  </body>
</html>

--------------070706000501030306040808--



--===============6926460297703608666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
--===============6926460297703608666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6926460297703608666==--


