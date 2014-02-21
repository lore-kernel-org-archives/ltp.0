Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sweekar.pinto@oracle.com>) id 1WGogm-0008S3-9U
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:44 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WGogl-00024X-Gc
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 11:54:44 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1LBsbjZ022569
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:38 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsaDN014700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1LBsagJ014691
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Feb 2014 11:54:36 GMT
From: Sweekar Pinto <sweekar.pinto@oracle.com>
Date: Thu, 20 Feb 2014 19:05:52 -0500
Message-Id: <1392941153-8643-2-git-send-email-sweekar.pinto@oracle.com>
In-Reply-To: <1392941153-8643-1-git-send-email-sweekar.pinto@oracle.com>
References: <1392941153-8643-1-git-send-email-sweekar.pinto@oracle.com>
Subject: [LTP] [PATCH v2 2/3] Fix passwordless ssh for network(ssh) dump test
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

-Force ssh to use kdump's rsa key to run commands remotely
-Some versions of kexec-tools append the date to the vmcore
 file name. So add vmcore* wildcard to the file name.

Signed-off-by: Sweekar Pinto <sweekar.pinto@oracle.com>
---
 testcases/kdump/runkdump.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kdump/runkdump.sh b/testcases/kdump/runkdump.sh
index e2e681c..cd6ee1c 100755
--- a/testcases/kdump/runkdump.sh
+++ b/testcases/kdump/runkdump.sh
@@ -95,7 +95,7 @@ PrepareVerify ()
             exit 1
         fi
 
-        file=$(ssh "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore \
+        file=$(ssh -i ~/.ssh/kdump_id_rsa "${SCP_PATH}" "ls -t ${COREDIR}/*/vmcore* \
          2>/dev/null | head -1")
 
         mkdir -p "${COREDIR}/${last}"
@@ -103,7 +103,7 @@ PrepareVerify ()
         if [ "${file}" ]; then
             # Not fatal error.
             set +e
-            scp "${SCP_PATH}:${file}" "${COREDIR}/${last}"
+            scp  -i ~/.ssh/kdump_id_rsa "${SCP_PATH}:${file}" "${COREDIR}/${last}"
             set -e
         fi
 
@@ -116,7 +116,7 @@ PrepareVerify ()
         COREDIR=/mnt"${COREDIR}"
     fi
 
-    vmcore=$(ls -t "${COREDIR}"/*/vmcore 2>/dev/null | head -1)
+    vmcore=$(ls -t "${COREDIR}"/*/vmcore* 2>/dev/null | head -1)
 }
 
 VerifyTest ()
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
