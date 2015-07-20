Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <VDavydov@odin.com>) id 1ZHu8Q-00058l-0A
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 13:32:34 +0000
Received: from mx2.parallels.com ([199.115.105.18])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZHu8O-0004zE-US
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 13:32:33 +0000
Received: from mail.parallels.com ([199.115.105.252])
	by mx2.parallels.com with esmtps (TLSv1:AES128-SHA:128) (Exim 4.85)
	(envelope-from <VDavydov@odin.com>) id 1ZHCLc-0003qK-8S
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2015 07:47:16 -0700
From: Vladimir Davydov <vdavydov@parallels.com>
Date: Mon, 20 Jul 2015 17:47:11 +0300
Message-ID: <1437403631-11091-1-git-send-email-vdavydov@parallels.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] memcg_control: fix mem_process not moved to cgroup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

$! is not set after ( cmd & )

This bug was introduced by commit 49010e502a74c ("Replace pushd // popd
with cd calls.").

Since we create a sub-shell in test_proc_kill only to preserve PWD,
let's change this to cd $OLDPWD. In contrast to pushd/popd this will
work in busybox.

Signed-off-by: Vladimir Davydov <vdavydov@parallels.com>
---
 testcases/kernel/controllers/memcg/control/memcg_control_test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
index fa50516ba71b..168efe3ee35c 100644
--- a/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
+++ b/testcases/kernel/controllers/memcg/control/memcg_control_test.sh
@@ -54,7 +54,9 @@ FAIL=1
 # Check if the test process is killed on crossing boundary
 test_proc_kill()
 {
-	( cd $TMP && mem_process -m $PROC_MEM & )
+	cd $TMP
+	mem_process -m $PROC_MEM &
+	cd $OLDPWD
 	sleep 1
 	echo $! > tasks
 
-- 
2.1.4


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
