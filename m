Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PzhiJ-0000sA-WD
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 03:47:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PzhiI-0002dC-8o
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 03:47:59 +0000
Message-ID: <4D8032E9.2040800@cn.fujitsu.com>
Date: Wed, 16 Mar 2011 11:47:53 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] syslog02: "tst_count_incr" should be replaced with
 "incr_tst_count"
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/syslog/syslog02 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog02 b/testcases/kernel/syscalls/syslog/syslog02
index 30be60d..d0501ba 100755
--- a/testcases/kernel/syscalls/syslog/syslog02
+++ b/testcases/kernel/syscalls/syslog/syslog02
@@ -104,7 +104,7 @@ syslog_case2()
 		# Increment the level_no for next level...
 		: $(( level_no += 1 ))
 
-		tst_count_incr
+		incr_tst_count
 	done
 }
 
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
