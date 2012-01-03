Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri28o-0002lH-Mw
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:02:50 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri28o-0001Xw-09
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 11:02:50 +0000
Message-ID: <4F02E053.3060600@imgtec.com>
Date: Tue, 3 Jan 2012 11:02:43 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050704080904020500080101"
Subject: [LTP] [PATCH 07/21] cgroup/getdelays: Squish uninitialized variable
 warning for old GCC compilers
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

--------------050704080904020500080101
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch. It is a trivial fix for slightly 
old GCC versions.

-- 
markos

--------------050704080904020500080101
Content-Type: text/plain;
	name="0007-cgroup-getdelays-Squish-uninitialized-variable-warni.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0007-cgroup-getdelays-Squish-uninitialized-variable-warni.pa";
	filename*1="tch"

From 9a47290369456d5406845b0d5c37b1577e55ef11 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 12:07:30 +0000
Subject: [PATCH 07/21] cgroup/getdelays: Squish uninitialized variable warning for old GCC compilers

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/controllers/cgroup/getdelays.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
index da735b2..5c79423 100644
--- a/testcases/kernel/controllers/cgroup/getdelays.c
+++ b/testcases/kernel/controllers/cgroup/getdelays.c
@@ -263,7 +263,7 @@ void print_ioacct(struct taskstats *t)
 
 int main(int argc, char *argv[])
 {
-	int c, rc, rep_len, aggr_len, len2, cmd_type;
+	int c, rc, rep_len, aggr_len, len2, cmd_type = 0;
 	__u16 id;
 	__u32 mypid;
 
-- 
1.7.1


--------------050704080904020500080101
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
--------------050704080904020500080101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050704080904020500080101--


