Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo-fnst@cn.fujitsu.com>) id 1Mn6Oi-0004rl-UW
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 07:54:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mn6Oc-0007ZT-Ea
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 07:54:52 +0000
Message-ID: <4AADF6FD.3020802@cn.fujitsu.com>
Date: Mon, 14 Sep 2009 15:55:41 +0800
From: liubo <liubo-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]:fix the bug of macro in getdelays.c
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
Cc: ltp-list@lists.sf.net

When running cgroup test, I found a bug of macro in 
getdelays.c, which refers to the spelling mistake. 
And this leads to testcase_eight's abnormal delay. 

Relative macro:
	HAVE_LINUX_CGROUPSTATS_H

Change macro HAVE_LINUX_CGROUPSTAT_H to HAVE_LINUX_CGROUPSTATS_H
to fix the bug.


signed-off-by:Liu Bo <liubo-fnst@cn.fujitsu.com>
---
diff --git a/testcases/kernel/controllers/cgroup/getdelays.c b/testcases/kernel/controllers/cgroup/getdelays.c
index 478b325..c9f532d 100644
--- a/testcases/kernel/controllers/cgroup/getdelays.c
+++ b/testcases/kernel/controllers/cgroup/getdelays.c
@@ -397,7 +397,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (containerset) {
-		#ifdef HAVE_LINUX_CGROUPSTAT_H
+		#ifdef HAVE_LINUX_CGROUPSTATS_H
 		cfd = open(containerpath, O_RDONLY);
 		if (cfd < 0) {
 			perror("error opening container file");




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
