Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NKsBs-0000m0-GL
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:12 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKsBn-0001T7-FY
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:12 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 4EA3217013E
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:36:58 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id nBGBau7U026789
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Dec 2009 19:36:56 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 3B9CFD45B6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:37:18 +0800 (CST)
Message-ID: <4B28C68C.1080304@cn.fujitsu.com>
Date: Wed, 16 Dec 2009 19:37:48 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/3] ade: fix the bug of ar01
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

Command "ar -tv" 's output doesn't match with "ls -ln" 's output on item
"permission".

s/-$permissions/-$permissions./

This patch fixed the bug.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 testcases/commands/ade/ar/ar01 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/ade/ar/ar01 b/testcases/commands/ade/ar/ar01
index c8f85eb..c393959 100755
--- a/testcases/commands/ade/ar/ar01
+++ b/testcases/commands/ade/ar/ar01
@@ -584,7 +584,7 @@ ar -tv $TCtmp/lib.a |
 while
 read permissions uid size month day time year file_name
 do
-echo "-$permissions;$uid;$size;$month;$day;$time;$file_name"
+echo "-$permissions.;$uid;$size;$month;$day;$time;$file_name"
 done >> $TCtmp/lib.a.stdout
 ttest
 
-- 
1.6.2.2






------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
