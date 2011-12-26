Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Rf8me-0001KS-P2
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 11:32:00 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Rf8md-00080e-Pg
	for ltp-list@lists.sourceforge.net; Mon, 26 Dec 2011 11:32:00 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBQBVrGt022057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Dec 2011 06:31:53 -0500
From: Eryu Guan <eguan@redhat.com>
Date: Mon, 26 Dec 2011 19:31:41 +0800
Message-Id: <1324899101-23034-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.7.4"
Subject: [LTP] [PATCH] io/diotest4: Close open fd after testing
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.7.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


The 'silly rename' mechanism of NFS creates temporary file .nfsXXX in
NFS mount. The tst_rmdir() in cleanup() in diotest4.c complains about
"Device or resource busy"

Close open fd after each sub-test.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/io/direct_io/diotest4.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)


--------------1.7.7.4
Content-Type: text/x-patch;
	name="0001-io-diotest4-Close-open-fd-after-testing.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-io-diotest4-Close-open-fd-after-testing.patch"

diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index 1f1b44b..a256104 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -324,6 +324,7 @@ main(int argc, char *argv[])
 		else
 			tst_resm (TPASS, "Out of range file descriptor");
 	}
+	close(newfd);
 	total++;
 
 	/* Test-7: Closed file descriptor */
@@ -360,6 +361,7 @@ main(int argc, char *argv[])
 		else
 			tst_resm (TPASS, "character device read, write");
 	}
+	close(newfd);
 	total++;
 
 	/* Test-10: read, write to a mmaped file */
@@ -400,6 +402,7 @@ main(int argc, char *argv[])
 	}
 	else
 		tst_resm (TPASS, "read, write to an unmapped file");
+	close(fd);
 	total++;
 
 	/* Test-12: read from file not open for reading */
@@ -610,6 +613,7 @@ static void setup(void)
 	if ((fd1 = open(filename, O_DIRECT, 0600)) < 0) {
 		tst_brkm(TCONF, cleanup, "O_DIRECT is not supported by this filesystem. %s", strerror(errno));
 	}
+	close(fd1);
 }
 
 static void cleanup(void)

--------------1.7.7.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------1.7.7.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.7.4--



