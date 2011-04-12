Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q9YjV-0004qK-F2
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 08:13:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9YjU-0000iS-PA
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 08:13:57 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3C8Dpmu013105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Apr 2011 04:13:51 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 12 Apr 2011 16:13:40 +0800
Message-Id: <a8c42cda82df15baf9acaf89ed09b41cc8cb5af8.1302595961.git.czhang@redhat.com>
In-Reply-To: <f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302595961.git.czhang@redhat.com>
References: <f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302595961.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] ksm: mempolicy syscalls not implemented
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


since NUMA is only supported on a few i386 systems, mempolicy syscalls
([gs]et_mempolicy, mbind) may not implemented, thus, an ENOSYS errno
should be acceptable.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/ksm/ksm02.c |    9 +++++++--
 testcases/kernel/mem/ksm/ksm04.c |    9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0003-ksm-mempolicy-syscalls-not-implemented.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-ksm-mempolicy-syscalls-not-implemented.patch"

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 33ed887..3ae4c08 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -102,8 +102,13 @@ int main(int argc, char *argv[])
 		Tst_count = 0;
 		check_ksm_options(&size, &num, &unit);
 
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+			if (errno != ENOSYS)
+				tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+			else
+				tst_resm(TCONF, cleanup,
+					"set_mempolicy syscall is not implemented on your system.");
+		}
 		create_same_memory(size, num, unit);
 
 		write_cpusets();
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index 8bb791e..5121111 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -104,8 +104,13 @@ int main(int argc, char *argv[])
 
 		write_memcg();
 
-		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+			if (errno != ENOSYS)
+				tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+			else
+				tst_resm(TCONF, cleanup,
+					"set_mempolicy syscall is not implemented on your system.");
+		}
 		create_same_memory(size, num, unit);
 
 		write_cpusets();

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



