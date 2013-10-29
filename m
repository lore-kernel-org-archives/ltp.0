Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vincent.hsu@linaro.org>) id 1VbHei-0005n6-Ck
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:56 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1VbHeh-0006t0-NC
	for ltp-list@lists.sourceforge.net; Tue, 29 Oct 2013 22:20:56 +0000
Received: by mail-ob0-f175.google.com with SMTP id wm4so627242obc.6
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Oct 2013 15:20:50 -0700 (PDT)
From: Vincent Hsu <vincent.hsu@linaro.org>
Date: Tue, 29 Oct 2013 15:20:35 -0700
Message-Id: <1383085243-5833-2-git-send-email-vincent.hsu@linaro.org>
In-Reply-To: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
Subject: [LTP] [LNG][PATCH 1/9] ltp-networking/nfs: Setting the NFS to
	version 3 by default. NFSv3 is more compatibled with recent
	linux distributions.
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

---
 testcases/network/nfs/fsx-linux/fsx.sh    |    2 +-
 testcases/network/nfs/nfs01/nfs01         |    2 +-
 testcases/network/nfs/nfs02/nfs02         |    2 +-
 testcases/network/nfs/nfs03/nfs03         |    2 +-
 testcases/network/nfs/nfs04/nfs04         |    2 +-
 testcases/network/nfs/nfsstat01/nfsstat01 |    2 +-
 testcases/network/nfs/nfsstress/nfsstress |    4 ++--
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 9d94166..a3c4801 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -75,7 +75,7 @@ $trace_logic

     PID=$$

-    VERSION=${VERSION:=2}
+    VERSION=${VERSION:=3}
     RHOST=${RHOST:=`hostname`}
     ITERATIONS=${ITERATIONS:=50000}
     SOCKET_TYPE=${SOCKET_TYPE:=udp}
diff --git a/testcases/network/nfs/nfs01/nfs01 b/testcases/network/nfs/nfs01/nfs01
index 924f2c2..e52915c 100755
--- a/testcases/network/nfs/nfs01/nfs01
+++ b/testcases/network/nfs/nfs01/nfs01
@@ -72,7 +72,7 @@ $trace_logic

     PID=$$

-    VERSION=${VERSION:=2}
+    VERSION=${VERSION:=3}
     RHOST=${RHOST:=`hostname`}
     NFILES=${NFILES:=1000}
     SOCKET_TYPE=${SOCKET_TYPE:=udp}
diff --git a/testcases/network/nfs/nfs02/nfs02 b/testcases/network/nfs/nfs02/nfs02
index c655678..5ff4651 100755
--- a/testcases/network/nfs/nfs02/nfs02
+++ b/testcases/network/nfs/nfs02/nfs02
@@ -50,7 +50,7 @@ TCtmp=${TCtmp:=$TCbin/$TC$$}
 PID=$$

 RHOST=${RHOST:=`hostname`}
-VERSION=${VERSION:=2}
+VERSION=${VERSION:=3}
 SOCKET_TYPE=${SOCKET_TYPE:=udp}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
 CLEANUP=${CLEANUP:="ON"}
diff --git a/testcases/network/nfs/nfs03/nfs03 b/testcases/network/nfs/nfs03/nfs03
index 80a4cbd..f1f4bb4 100755
--- a/testcases/network/nfs/nfs03/nfs03
+++ b/testcases/network/nfs/nfs03/nfs03
@@ -53,7 +53,7 @@ RHOST=${RHOST:=`hostname | awk {'print $1'}`}
 PID=$$

 # Setting the NFS to version 2 by default
-VERSION=${VERSION:=2}
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
index 9d52a45..8b54815 100755
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

diff --git a/testcases/network/nfs/nfsstress/nfsstress b/testcases/network/nfs/nfsstress/nfsstress
index 7f0006b..914c308 100755
--- a/testcases/network/nfs/nfsstress/nfsstress
+++ b/testcases/network/nfs/nfsstress/nfsstress
@@ -50,9 +50,9 @@ TCtmp=${TCtmp:=$TCbin/$TC$$}
 TCdump=${TCdump:=$TCbin}
 RHOST=${RHOST:=`hostname|awk {'print $1'}`}

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
Android is increasing in popularity, but the open development platform that
developers love is also attractive to malware creators. Download this white
paper to learn more about secure code signing practices that can help keep
Android apps secure.
http://pubads.g.doubleclick.net/gampad/clk?id=65839951&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
