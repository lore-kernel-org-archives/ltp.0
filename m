Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XYcOg-0002w2-Cf
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 14:57:54 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XYcOe-0003U1-0J
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 14:57:54 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8TEvipi019377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 29 Sep 2014 10:57:45 -0400
From: Zorro Lang <zlang@redhat.com>
Date: Mon, 29 Sep 2014 22:57:41 +0800
Message-Id: <1412002661-14537-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] ext4-new-features: modify ext4-delalloc-mballoc can
	not find ffsb-config file
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

run ext4-delalloc-mballoc always hit "ffsb-config0: No such file or directory",
so add $LTPROOT/testcases/bin/ for ffsb-config.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

`ffsb ffsb-config$2` always hit "ffsb-config, No such file", I have to use
absolute pathname for ffsb-config. Is it OK?

Thank you,
Zorro Lang

 .../fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
index 1ffba13..47d9174 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-delalloc-mballoc/ext4-alloc-test.sh
@@ -40,7 +40,7 @@ ext4_test_remount()
 		return
 	fi
 
-	ffsb ffsb-config0 > /dev/null
+	ffsb $LTPROOT/testcases/bin/ffsb-config0 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
@@ -92,7 +92,7 @@ ext4_test_delalloc_mballoc()
 		return
 	fi
 
-	ffsb ffsb-config$2 > /dev/null
+	ffsb $LTPROOT/testcases/bin/ffsb-config$2 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
-- 
1.9.3


------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
