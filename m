Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1UrMtA-0008D2-VX
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 06:38:05 +0000
Received: from mail-pa0-f47.google.com ([209.85.220.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UrMt8-000766-Ke
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 06:38:04 +0000
Received: by mail-pa0-f47.google.com with SMTP id kl14so12085417pab.6
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Jun 2013 23:37:56 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 25 Jun 2013 14:37:42 +0800
Message-Id: <1372142262-4654-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] testscripts/networkstress.sh: update for two
	interfaces support
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
To: LTP list <ltp-list@lists.sourceforge.net>

As some networking tests need two interfaces at the same time. Use grep -P to
get two interfaces' mac addresses.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testscripts/networkstress.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
index b40af72..499b40c 100755
--- a/testscripts/networkstress.sh
+++ b/testscripts/networkstress.sh
@@ -15,6 +15,8 @@ fi
 export TMPDIR=/tmp/netst-$$
 mkdir $TMPDIR
 VERBOSE="no"
+# Default interface is "eth0".
+# For some test cases that need two interfaces, give parameter like "eth0|eth1"
 INTERFACE="eth0"
 
 #===========================================================================
@@ -71,6 +73,7 @@ usage () {
     echo " -W|w: Run whole network stress tests"
     echo " -D|d: Test duration (default ${NS_DURATION} sec)"
     echo " -N|n: Select the network interface (default: $INTERFACE)"
+    echo "       Two interfaces' format: \"eth0|eth1\""
     echo " -V|v: Enable verbose"
     echo " -H|h: This Usage"
     echo ""
@@ -102,7 +105,7 @@ if [ -z ${TEST_CASE} ]; then
 	usage
 fi
 
-export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk '{print $5}'`
+export LHOST_HWADDRS=`ifconfig | grep -P ${INTERFACE} | grep HWaddr |awk '{print $5}'`
 
 if [ -z ${RHOST} ]; then
 	## Just a silly check
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
