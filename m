Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XXRwp-0000Cj-Mx
	for ltp-list@lists.sourceforge.net; Fri, 26 Sep 2014 09:36:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XXRwo-0004ci-Gx
	for ltp-list@lists.sourceforge.net; Fri, 26 Sep 2014 09:36:19 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8Q9aAw2008536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Sep 2014 05:36:11 -0400
From: Zorro Lang <zlang@redhat.com>
Date: Fri, 26 Sep 2014 17:36:04 +0800
Message-Id: <1411724164-18326-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] fs/ext4-inode-version: remove "./" before
	"ext4_get_inode_version.sh" in ext4_test_inode_version.c
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

when I test with ext4-inode-version, I always get "sh ./ext4_get_inode_version.sh: No such file".
Then I removed "./" of "ext4_get_inode_version.sh" in ext4_test_inode_version.c, everything
goes well.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

As I said above. I don't know why the case want to use "./ext4_get_inode_version.sh", I just tried to
remove "./", and run pass. Please review it.

Thank you,
Zorro Lang

 .../fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
index 168f5ce..533f694 100644
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_test_inode_version.c
@@ -41,7 +41,7 @@ int get_inode_version(void)
 {
 	char buf[1024];
 
-	sprintf(buf, "./ext4_get_inode_version.sh %s 1", filename);
+	sprintf(buf, "ext4_get_inode_version.sh %s 1", filename);
 
 	/* sync before run debugfs to get inode version */
 	sync();
-- 
1.9.3


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
