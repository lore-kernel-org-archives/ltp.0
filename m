Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1N3ZqB-00045Z-08
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:35:19 +0000
Received: from lo.gmane.org ([80.91.229.12])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3Zq4-0001Bd-Nh
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:35:18 +0000
Received: from list by lo.gmane.org with local (Exim 4.50) id 1N3Zpw-00031D-LO
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 19:35:04 +0100
Received: from 163.36.broadband2.iol.cz ([83.208.36.163])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 19:35:04 +0100
Received: from jpalecek by 163.36.broadband2.iol.cz with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 19:35:04 +0100
From: =?utf-8?b?SmnFmcOt?= =?utf-8?b?UGFsZcSNZWs=?= <jpalecek@web.de>
Date: Thu, 29 Oct 2009 18:12:13 +0000 (UTC)
Message-ID: <loom.20091029T190532-79@post.gmane.org>
References: <200910211528.n9LFST8q028289@e35.co.us.ibm.com>
	<1256576544.4929.54.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix some bashisms
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
To: ltp-list@lists.sourceforge.net

Hello,

Subrata Modak <subrata@...> writes:

> 
> On Wed, 2009-10-21 at 02:19 +0200, Jiri Palecek wrote: 
> > Hello,
> > 
> > this is another patch fixing bashisms in LTP tests (the fixes are more or 
less the same as in the previous
> patches, except for a few exceptions). Note that the patch is not complete, 
in the sense that there may
> remain further bashisms in the source even after applying the patch (like use 
of arrays, which is visible
> even from this patch).
> > 
> > Regards
> >     Jiri Palecek
> > 
> > Signed-off-by: Jiri Palecek <jpalecek@...>
> 
> Hmm,. Some of them failed to apply. Can you please resend only the error
> part(s):
> 

according to my git repository. these are the missing parts:

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/kernel/fs/fs-bench/modaltr.sh      |    2 +-
 testcases/kernel/fs/mongo/test.sh            |    8 +++-----
 testcases/network/tcp_cmds/netstat/netstat01 |    2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/fs/fs-bench/modaltr.sh b/testcases/kernel/fs/fs-
bench/modaltr.sh
index 85d2c30..36e6f0c 100755
--- a/testcases/kernel/fs/fs-bench/modaltr.sh
+++ b/testcases/kernel/fs/fs-bench/modaltr.sh
@@ -43,7 +43,7 @@ LOG_DIR1=/tmp/log1
 HOME_DIR=/home
 BLOCK_DIR=/dev/mtdblock
 export PATH=$PATH:/sbin
-	if [ $UID -ne 0 ]; 
+	if [ $(id -ru) -ne 0 ]; 
 then 
 	echo "must be root to run this"
 	exit
diff --git a/testcases/kernel/fs/mongo/test.sh b/testcases/kernel/fs/mongo/
test.sh
index fe75664..eccb079 100755
--- a/testcases/kernel/fs/mongo/test.sh
+++ b/testcases/kernel/fs/mongo/test.sh
@@ -26,7 +26,7 @@ TEST_DIR=testdir
 
 
    		#should be root  to execute this script .
-	if [ $UID -ne 0 ]; then
+	if [ $(id -ru) -ne 0 ]; then
 		echo "This script must be run as root"
 		exit
 	fi
@@ -52,8 +52,7 @@ modprobe loop
 	fi
 
 	#run the mongo test on reiserfs file system type 
-function reiserfs
-
+reiserfs()
 {
 cat > fs.sh <<EOF
 echo "performing mongo on reiserfs"
@@ -71,8 +70,7 @@ EOF
 	
 
 #To run on jfs file system type 
-function  JFS
-
+JFS()
 {
 cat >> fs.sh <<EOF
 echo "performing mongo on jfs file system"
diff --git a/testcases/network/tcp_cmds/netstat/netstat01 b/testcases/network/
tcp_cmds/netstat/netstat01
index 6a197de..365c142 100755
--- a/testcases/network/tcp_cmds/netstat/netstat01
+++ b/testcases/network/tcp_cmds/netstat/netstat01
@@ -58,7 +58,7 @@ do_test() {
     while [ $TST_COUNT -le $NUMLOOPS ]; do
 
         for flag in "-s" "-rn" "-i" "-gn" "-apn"; do
-            if ! netstat $flag 2>&1 1>/dev/null; then
+            if ! netstat $flag 1>/dev/null 2>&1; then
                 end_testcase "$COMMAND failed"
             fi
         done
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
