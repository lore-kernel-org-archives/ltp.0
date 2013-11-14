Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1Vgnss-0004W7-9L
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:46:22 +0000
Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Vgnsr-0000XE-Dc
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 03:46:22 +0000
Received: by mail-pb0-f49.google.com with SMTP id um1so1417544pbc.22
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Nov 2013 19:46:15 -0800 (PST)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Thu, 14 Nov 2013 11:38:34 +0800
Message-Id: <1384400319-30776-3-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
References: <1384400319-30776-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 3/8] ltp-networking/nfs: use NFSv3 by default
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
Cc: linaro-networking@linaro.org

NFSv3 is more compatible with recent linux distributions.

Signed-off-by: Vincent Hsu <vincent.hsu@linaro.org>
---
 testcases/network/nfs/fsx-linux/fsx.sh    |    2 +-
 testcases/network/nfs/nfs01/nfs01         |    2 +-
 testcases/network/nfs/nfs02/nfs02         |    2 +-
 testcases/network/nfs/nfs03/nfs03         |    4 ++--
 testcases/network/nfs/nfs04/nfs04         |    2 +-
 testcases/network/nfs/nfsstat01/nfsstat01 |    2 +-
 testcases/network/nfs/nfsstress/nfsstress |    4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index fddaf03..facc708 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -78,7 +78,7 @@ $trace_logic

     PID=$$

-    VERSION=${VERSION:=2}
+    VERSION=${VERSION:=3}
     RHOST=${RHOST:=`hostname`}
     ITERATIONS=${ITERATIONS:=50000}
     SOCKET_TYPE=${SOCKET_TYPE:=udp}
diff --git a/testcases/network/nfs/nfs01/nfs01 b/testcases/network/nfs/nfs01/nfs01
index 1a942c4..77d2775 100755
--- a/testcases/network/nfs/nfs01/nfs01
+++ b/testcases/network/nfs/nfs01/nfs01
@@ -75,7 +75,7 @@ $trace_logic

     PID=$$

-    VERSION=${VERSION:=2}
+    VERSION=${VERSION:=3}
     RHOST=${RHOST:=`hostname`}
     NFILES=${NFILES:=1000}
     SOCKET_TYPE=${SOCKET_TYPE:=udp}
diff --git a/testcases/network/nfs/nfs02/nfs02 b/testcases/network/nfs/nfs02/nfs02
index ab0e3c7..89b65cf 100755
--- a/testcases/network/nfs/nfs02/nfs02
+++ b/testcases/network/nfs/nfs02/nfs02
@@ -53,7 +53,7 @@ export TST_COUNT=1
 PID=$$

 RHOST=${RHOST:=`hostname`}
-VERSION=${VERSION:=2}
+VERSION=${VERSION:=3}
 SOCKET_TYPE=${SOCKET_TYPE:=udp}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 CLEANUP=${CLEANUP:="ON"}
diff --git a/testcases/network/nfs/nfs03/nfs03 b/testcases/network/nfs/nfs03/nfs03
index 445c6ae..a6c53ab 100755
--- a/testcases/network/nfs/nfs03/nfs03
+++ b/testcases/network/nfs/nfs03/nfs03
@@ -55,8 +55,8 @@ export TST_COUNT=1

 PID=$$

-# Setting the NFS to version 2 by default
-VERSION=${VERSION:=2}
+# Setting the NFS to version 3 by default
+VERSION=${VERSION:=3}
 SOCKET_TYPE=${SOCKET_TYPE:=udp}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 NFS_TYPE=${NFS_TYPE:=nfs}
diff --git a/testcases/network/nfs/nfs04/nfs04 b/testcases/network/nfs/nfs04/nfs04
index 3289f0e..7518d5b 100755
--- a/testcases/network/nfs/nfs04/nfs04
+++ b/testcases/network/nfs/nfs04/nfs04
@@ -71,7 +71,7 @@ $trace_logic

     PID=$$

-    VERSION=${VERSION:=2}
+    VERSION=${VERSION:=3}
     RHOST=${RHOST:=`hostname`}
     FILESIZE=${FILESIZE:=10}
     SOCKET_TYPE=${SOCKET_TYPE:=udp}
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 0b68f7d..7b1ac43 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -46,7 +46,7 @@ TCbin=${TCbin:=`pwd`}
 EXPORTDIR=${EXPORTDIR:=/tmp/$TC$PID}
 HOST=`hostname`
 CLEANUP=${CLEANUP:="ON"}
-VERSION=${VERSION:=2}
+VERSION=${VERSION:=3}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 NFS_TYPE=${NFS_TYPE:nfs}
 export TCID=$TC
diff --git a/testcases/network/nfs/nfsstress/nfsstress b/testcases/network/nfs/nfsstress/nfsstress
index 0826e57..3e078d9 100755
--- a/testcases/network/nfs/nfsstress/nfsstress
+++ b/testcases/network/nfs/nfsstress/nfsstress
@@ -53,9 +53,9 @@ export TCID=$TC
 export TST_TOTAL=1
 export TST_COUNT=1

-# Setting the NFS to version 2 with UDP by default
+# Setting the NFS to version 3 with UDP by default
 PID=$$
-VERSION=${VERSION:=2}
+VERSION=${VERSION:=3}
 SOCKET_TYPE=${SOCKET_TYPE:=udp}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 NFS_TYPE=${NFS_TYPE:=nfs}
--
1.7.9.5


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
