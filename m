Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WiKIF-0008DY-Op
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:07 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WiKIE-00007c-Qr
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 09:07:07 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4896ukH028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:07:01 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4896tiQ003109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:55 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s4896riP027099
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 09:06:54 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu,  8 May 2014 13:06:41 +0400
Message-Id: <1399540004-14742-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/4] linux syscall numbers: fixed the checkings for
	SPARC
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
Cc: vasily.isaenko@oracle.com

For sparc64 platforms cpp does not define '__sparc64__', but
defines '__sparc__' and '__arch64__'.

For sparc32 platforms cpp just defines '__sparc__'.

This may cause problems because sparc64 and sparc32 have not equal
sets of system calls.

Modified the ckeckings for SPARC in regen.sh and executed it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/include/linux_syscall_numbers.h |    4 ++--
 testcases/kernel/include/regen.sh                |    6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 03664ce..a43f7ca 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -8880,7 +8880,7 @@
 #endif
 
 
-#ifdef __sparc64__
+#if defined(__sparc__) && defined(__arch64__)
 # ifndef __NR_restart_syscall
 #  define __NR_restart_syscall 0
 # endif
@@ -9883,7 +9883,7 @@
 #endif
 
 
-#ifdef __sparc__
+#if defined(__sparc__) && !defined(__arch64__)
 # ifndef __NR_restart_syscall
 #  define __NR_restart_syscall 0
 # endif
diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 3e9f0e7..3f7f4aa 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -59,7 +59,11 @@ for arch in $(cat "${srcdir}/order") ; do
 
 	(
 	echo
-	echo "#ifdef __${arch}__"
+	case ${arch} in
+		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
+		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
+		*) echo "#ifdef __${arch}__"
+	esac
 	while read line ; do
 		set -- ${line}
 		nr="__NR_$1"
-- 
1.7.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
