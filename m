Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MXxnh-0005nu-La
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:42:05 +0000
Received: from [89.31.47.178] (helo=monstr.eu)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXxnZ-00040P-6j
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:42:05 +0000
From: michal.simek@petalogix.com
Date: Mon,  3 Aug 2009 15:24:19 +0200
Message-Id: <78ed21a4b2e88c1cc0802bc384f9bd2228ff4e40.1249304223.git.monstr@monstr.eu>
In-Reply-To: <d80b0b476cd86f178e44984647a040bb7d458d75.1249304223.git.monstr@monstr.eu>
References: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
	<0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
	<b27f5b6149545ef2a1f3483d14d51d29f83aa7c6.1249304223.git.monstr@monstr.eu>
	<d80b0b476cd86f178e44984647a040bb7d458d75.1249304223.git.monstr@monstr.eu>
In-Reply-To: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
References: <0f2557dbada823cdbdf1080b36ca0cf41d29c58f.1249304223.git.monstr@monstr.eu>
Subject: [LTP] [PATCH 4/4] Add unaligned tests which tests get/put_user
	macros
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

From: Michal Simek <monstr@monstr.eu>

getpeername01 and getsockname01 tests get_user macro
socketpair01 tests put_user macro

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 .../kernel/syscalls/getpeername/getpeername01.c    |    5 ++++-
 .../kernel/syscalls/getsockname/getsockname01.c    |    7 ++++++-
 .../kernel/syscalls/socketpair/socketpair01.c      |    4 ++--
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/getpeername/getpeername01.c b/testcases/kernel/syscalls/getpeername/getpeername01.c
index 55d349a..17e76f9 100644
--- a/testcases/kernel/syscalls/getpeername/getpeername01.c
+++ b/testcases/kernel/syscalls/getpeername/getpeername01.c
@@ -93,8 +93,11 @@ struct test_case_t {		/* test case structure */
 		    &sinlen, -1, EFAULT, setup2, cleanup1,
 		    "invalid socket buffer"}, {
 	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
+		    (socklen_t *) 0, -1, EFAULT, setup2, cleanup1,
+		    "invalid aligned salen"}, {
+	PF_UNIX, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
 		    (socklen_t *) 1, -1, EFAULT, setup2, cleanup1,
-		    "invalid salen"},
+		    "invalid unaligned salen"},
 #endif
 };
 
diff --git a/testcases/kernel/syscalls/getsockname/getsockname01.c b/testcases/kernel/syscalls/getsockname/getsockname01.c
index 6159847..638d95a 100644
--- a/testcases/kernel/syscalls/getsockname/getsockname01.c
+++ b/testcases/kernel/syscalls/getsockname/getsockname01.c
@@ -89,9 +89,14 @@ struct test_case_t {		/* test case structure */
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)0,
 		    &sinlen, -1, EFAULT, setup1, cleanup1,
 		    "invalid socket buffer"}, {
+	/* invalid salen test for aligned input */
+	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
+		    (socklen_t *) 0, -1, EFAULT, setup1, cleanup1,
+		    "invalid aligned salen"}, {
+	/* invalid salen test for unaligned input */
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&fsin1,
 		    (socklen_t *) 1, -1, EFAULT, setup1, cleanup1,
-		    "invalid salen"},
+		    "invalid unaligned salen"},
 #endif
 };
 
diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index fc90529..d943299 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -80,8 +80,8 @@ struct test_case_t {		/* test case structure */
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	{
-	PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad pointer"}, {
-	PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT, "bad pointer"},
+	PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad aligned pointer"}, {
+	PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT, "bad unaligned pointer"},
 #endif
 	{
 	PF_INET, SOCK_DGRAM, 17, sv, -1, EOPNOTSUPP, "UDP socket"}, {
-- 
1.5.5.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
