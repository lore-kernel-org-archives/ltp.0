Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1Xu0id-0001VA-7I
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 15:10:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xu0ib-0001Zz-TT
	for ltp-list@lists.sourceforge.net; Thu, 27 Nov 2014 15:10:55 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sARFAkWs031080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Nov 2014 10:10:47 -0500
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sARFAjKJ013626
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Nov 2014 10:10:45 -0500
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu, 27 Nov 2014 16:10:31 +0100
Message-Id: <1417101031-5272-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH] testcases/lib/test.sh: added tst_timeout()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Function tst_timeout() added into LTP test interface:

	tst_timeout "command arg1 arg2 ..." timeout

Function enables waiting for specified command for timeout
seconds. Example usage:

	cmd_output=$(tst_timeout "ping -c 3 localhost" 5)
	if [ $? -ne 0 ]; then
		tst_brkm TBROK "timeout reached!"
	fi

where $cmd_output contains stdout and stderr of ping command.

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 testcases/lib/test.sh | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index eecbfba..1c5bdf2 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -129,6 +129,60 @@ tst_check_cmds()
 	done
 }
 
+# tst_timeout "command arg1 arg2 ..." timeout
+# Runs command for specified timeout (in seconds).
+# Function returns retcode of command or 1 if arguments are invalid.
+tst_timeout()
+{
+	local command=$1
+	local timeout=$2
+	local usleep_time=100000
+
+	# command must be non-empty string with command to run
+	if [ -z "$command" ]; then
+		echo "first argument must be non-empty string"
+		return 1
+	fi
+
+	# accept only numbers as timeout
+	re='^[0-9]+$'
+	if ! [[ $timeout =~ $re ]]; then
+		echo "only numbers as second argument"
+		return 1
+	fi
+
+	if [ -z "$TMPDIR" ]; then
+		TMPDIR="/tmp"
+	fi
+
+	local output=$(mktemp --tmpdir=$TMPDIR)
+	sh -c "eval $command" >$output 2>&1 &
+	local pid=$!
+	timeout=$((timeout*1000000))
+	while [ $timeout -gt 0 ]; do
+		kill -s 0 $pid 2>/dev/null
+		if [ $? -ne 0 ]; then
+			break
+		fi
+		timeout=$((timeout - usleep_time))
+		usleep $usleep_time
+	done
+
+	local ret=0
+	if [ $timeout -le 0 ]; then
+		ret=128
+		kill -9 $pid
+	fi
+
+	wait $pid
+	ret=$((ret | $?))
+
+	cat $output
+	rm -f $output
+
+	return $ret
+}
+
 # Check that test name is set
 if [ -z "$TCID" ]; then
 	tst_brkm TBROK "TCID is not defined"
-- 
1.8.3.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
