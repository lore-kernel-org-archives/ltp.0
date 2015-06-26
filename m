Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z8STi-0002lT-Cu
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:11:30 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z8STh-0004LB-Fs
	for ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 12:11:30 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NQJ01HVDWIY30D0@mailout4.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 26 Jun 2015 21:11:22 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
Date: Fri, 26 Jun 2015 17:34:53 +0530
Message-id: <1435320294-45783-13-git-send-email-maninder1.s@samsung.com>
In-reply-to: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
References: <1435320294-45783-1-git-send-email-maninder1.s@samsung.com>
Subject: [LTP] [PATCH 12/13] kernel/rt_sigaction: use ARRAY_SIZE
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
Cc: pankaj.m@samsung.com


Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Reviewed-by: Akhilesh Kumar <akhilesh.k@samsung.com>
---
 .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |    3 +--
 .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |    2 +-
 .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
index 9ca914f..5cf89cc 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
@@ -99,8 +99,7 @@ int main(int ac, char **av)
 			for (signal = SIGRTMIN; signal <= SIGRTMAX; signal++) {
 				for (flag = 0;
 				     flag <
-				     (sizeof(test_flags) /
-				      sizeof(test_flags[0])); flag++) {
+				      ARRAY_SIZE(test_flags); flag++) {
 
 					TEST(set_handler
 					     (signal, 0, test_flags[flag]));
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
index 7c0f0d0..a1da743 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
@@ -84,7 +84,7 @@ int main(int ac, char **av)
 			for (signal = SIGRTMIN; signal <= SIGRTMAX; signal++) {
 				tst_resm(TINFO, "Signal %d", signal);
 
-				for (flag = 0; flag < (sizeof(test_flags) / sizeof(test_flags[0])); flag++) {
+				for (flag = 0; flag < ARRAY_SIZE(test_flags); flag++) {
 
 					/*                                                              *
 					 * long sys_rt_sigaction (int sig, const struct sigaction *act, *
diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
index 5206c16..175d220 100644
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 			for (signal = SIGRTMIN; signal <= (SIGRTMAX); signal++) {
 				tst_resm(TINFO, "Signal %d", signal);
 
-				for (flag = 0; flag < (sizeof(test_flags) / sizeof(test_flags[0])); flag++) {
+				for (flag = 0; flag < ARRAY_SIZE(test_flags); flag++) {
 					TEST(set_handler
 					     (signal, 0, test_flags[flag]));
 					if ((TEST_RETURN == -1)
-- 
1.7.9.5


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
