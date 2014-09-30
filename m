Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XZ03R-0006nf-C8
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 16:13:33 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZ03Q-0007Td-4O
	for ltp-list@lists.sourceforge.net; Tue, 30 Sep 2014 16:13:33 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8UGDPAS015442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Sep 2014 12:13:25 -0400
From: Zorro Lang <zlang@redhat.com>
Date: Wed,  1 Oct 2014 00:13:22 +0800
Message-Id: <1412093602-12597-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] ext4-new-features: modify ext4_get_inode_version.sh
	not know $EXT4_DEV definition
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

ext4_get_inode_version.sh use $EXT4_DEV, but it really don't known what is $EXT4_DEV.
That cause other cases which use ext4_get_inode_version.sh will failed.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

When I run ext4-inode-version, I always hit TFAIL. But I can't reproduce the fail manually.
Then I find ext4_inode_version_test.sh use ext4_get_inode_version.sh, ext4_get_inode_version.sh
$EXT4_DEV which ext4_get_inode_version.sh don't know what it is.

About this patch, I export $EXT4_DEV  in ext4_inode_version_test.sh, before it use ext4_get_inode_version.sh.
But I think add the "export" in front of "EXT4_DEV=$LTP_BIG_DEV" in ext4_funcs.sh will be another method.

Please review, and tell me which one do you think is better for LTP? Or you have a better one;)

Thank you,
Zorro Lang

 .../fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh  | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
index ac8f021..2549088 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-inode-version/ext4_inode_version_test.sh
@@ -138,6 +138,8 @@ test_inode_version()
 
 # main
 ext4_setup
+# export EXT4_DEV for ext4_get_inode_version.sh can know it
+export EXT4_DEV=$EXT4_DEV
 
 ext4_test_128_inode_version
 
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
