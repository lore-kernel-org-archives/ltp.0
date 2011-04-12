Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q9XgR-0002RS-O9
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 07:06:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q9XgQ-0001iu-Ur
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 07:06:43 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3C76br5024130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Apr 2011 03:06:37 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 12 Apr 2011 15:06:26 +0800
Message-Id: <72f115800eea097339b13553b46bede9886ae31f.1302591968.git.czhang@redhat.com>
In-Reply-To: <9c4ca5a38da5486b9aceae69e9fc8a01b3e5ad4f.1302499207.git.czhang@redhat.com>
References: <9c4ca5a38da5486b9aceae69e9fc8a01b3e5ad4f.1302499207.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v2] [hugetlb] hugemmap always return 1
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


Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |    5 ++---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-hugetlb-hugemmap-always-return-1.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugemmap-always-return-1.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index a9b8a36..4b2cd30 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -176,8 +176,7 @@ main(int ac, char **av)
 	}
 
 	cleanup();
-
-	return 1;
+	tst_exit();
 }
 
 /*
@@ -276,4 +275,4 @@ cleanup()
 
 	unlink(TEMPFILE);
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index ab8c590..b6c6988 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -192,8 +192,7 @@ main(int ac, char **av)
 	}
 
 	cleanup();
-
-	return 1;
+	tst_exit();
 }
 
 /*
@@ -292,4 +291,4 @@ cleanup()
 
 	unlink(TEMPFILE);
 
-}
\ No newline at end of file
+}

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



