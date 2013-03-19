Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UHxeQ-00070i-75
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 14:36:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHxeO-0003HQ-25
	for ltp-list@lists.sourceforge.net; Tue, 19 Mar 2013 14:36:29 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2JEaL3I006761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Mar 2013 10:36:22 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Mar 2013 15:35:24 +0100
Message-Id: <df80cf17650d9280457b66e44fb09b55c1cdbce4.1363703473.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] inode02: fix "slash" array overrun
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

testcases/kernel/fs/inode/inode02.c:254 is initializing it as:
    slash[0] = '/';
    slash[1] = '\0';

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/inode/inode02.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/fs/inode/inode02.c b/testcases/kernel/fs/inode/inode02.c
index 783edf8..f70c5d8 100644
--- a/testcases/kernel/fs/inode/inode02.c
+++ b/testcases/kernel/fs/inode/inode02.c
@@ -80,7 +80,7 @@ int nchild;
 FILE *list_stream = NULL;
 int list_id;
 int file_id;
-char slash[1];
+char slash[2];
 
 int increment_name(), get_next_name(), mode(), escrivez(), massmurder();
 int max_depth, max_breadth, file_length;
-- 
1.7.1


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
