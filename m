Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1ZRvr1-0000bq-MA
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 05:24:03 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZRvqv-0007fG-O4
	for ltp-list@lists.sourceforge.net; Wed, 19 Aug 2015 05:24:03 +0000
From: Yuan Sun <sunyuan3@huawei.com>
Date: Wed, 19 Aug 2015 13:24:07 +0800
Message-ID: <1439961847-20181-1-git-send-email-sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Use parentgid to fix wrong parentuid parameters.
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
To: jstancek@redhat.com
Cc: ltp-list@lists.sourceforge.net

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/userns03.c | 4 ++--
 testcases/kernel/containers/userns/userns06.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index 6e3cedd..26a710d 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -205,8 +205,8 @@ int main(int argc, char *argv[])
 		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid, cleanup);
 		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid, cleanup);
 
-		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid, cleanup);
-		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid, cleanup);
+		updatemap(cpid1, GID_MAP, CHILD1GID, parentgid, cleanup);
+		updatemap(cpid2, GID_MAP, CHILD2GID, parentgid, cleanup);
 
 		TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup, 1);
 
diff --git a/testcases/kernel/containers/userns/userns06.c b/testcases/kernel/containers/userns/userns06.c
index 4e2daf3..23f6da4 100644
--- a/testcases/kernel/containers/userns/userns06.c
+++ b/testcases/kernel/containers/userns/userns06.c
@@ -149,8 +149,8 @@ int main(int argc, char *argv[])
 		updatemap(cpid1, UID_MAP, CHILD1UID, parentuid, cleanup);
 		updatemap(cpid2, UID_MAP, CHILD2UID, parentuid, cleanup);
 
-		updatemap(cpid1, GID_MAP, CHILD1GID, parentuid, cleanup);
-		updatemap(cpid2, GID_MAP, CHILD2GID, parentuid, cleanup);
+		updatemap(cpid1, GID_MAP, CHILD1GID, parentgid, cleanup);
+		updatemap(cpid2, GID_MAP, CHILD2GID, parentgid, cleanup);
 
 		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
 		TST_SAFE_CHECKPOINT_WAKE(cleanup, 1);
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
