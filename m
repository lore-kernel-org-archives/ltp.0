Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q99YJ-0006CG-IB
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 05:20:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q99YI-000628-Lg
	for ltp-list@lists.sourceforge.net; Mon, 11 Apr 2011 05:20:43 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3B5KaJM024507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Apr 2011 01:20:36 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 11 Apr 2011 13:20:27 +0800
Message-Id: <9c4ca5a38da5486b9aceae69e9fc8a01b3e5ad4f.1302499207.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [hugetlb] hugemmap: some tiny fixes
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


some tiny fixes including:
- change 'return 1' to 'tst_exit()'
- remove 'tst_rmdir()' from cleanup()

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c |    4 ++--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c |    3 +--
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-hugetlb-hugemmap-some-tiny-fixes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugemmap-some-tiny-fixes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index a9b8a36..5736759 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -177,7 +177,7 @@ main(int ac, char **av)
 
 	cleanup();
 
-	return 1;
+	tst_exit();
 }
 
 /*
@@ -276,4 +276,4 @@ cleanup()
 
 	unlink(TEMPFILE);
 
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index ce4cdac..de945c2 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -230,5 +230,4 @@ cleanup()
 
 	unlink(TEMPFILE);
 
-	tst_rmdir();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index ab8c590..29792a1 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -193,7 +193,7 @@ main(int ac, char **av)
 
 	cleanup();
 
-	return 1;
+	tst_exit();
 }
 
 /*
@@ -292,4 +292,4 @@ cleanup()
 
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
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
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



