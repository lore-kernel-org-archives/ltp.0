Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PAfQZ-0004SU-8V
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 09:02:43 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAfQY-0000U6-6L
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 09:02:43 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9Q92a98020118
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Oct 2010 05:02:36 -0400
Date: Tue, 26 Oct 2010 05:02:36 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1140423440.1496611288083756370.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] fix keyctl01 revoke argument on s390x
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
To: LTP List <ltp-list@lists.sourceforge.net>

From 1101aa2287f761df5cfab29806baf49fadd80c34 Mon Sep 17 00:00:00 2001
From: Caspar Zhang <casparant@gmail.com>
Date: Tue, 26 Oct 2010 16:54:13 +0800
Subject: [PATCH] fix keyctl revoke argument

add some codes to find an unused id instead of
using #define directly.

Signed-off-by: Caspar Zhang <czhang@redhat.com>

---
 testcases/kernel/syscalls/keyctl/keyctl01.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 292e573..57f334f 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -40,6 +40,7 @@
 
 #include <stdio.h>
 #include <errno.h>
+#include <stdint.h>
 #include <linux/keyctl.h>
 /* Harness Specific Include Files. */
 #include "test.h"
@@ -110,6 +111,7 @@ void setup() {
 int main(int ac, char **av) {
 	int ret;
 	int lc;		/* loop counter */
+	int i, nonexist_key;
 	char *msg;	/* message returned from parse_opts */
 
 	/* parse standard options */
@@ -126,7 +128,7 @@ int main(int ac, char **av) {
 		Tst_count = 0;
 
 		for (testno = 1; testno < TST_TOTAL; ++testno) {
-	
+
 			/* Call keyctl() and ask for a keyring's ID. */
 			ret = syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
 					KEY_SPEC_USER_SESSION_KEYRING);
@@ -136,8 +138,17 @@ int main(int ac, char **av) {
 		 		tst_resm(TFAIL | TERRNO, "KEYCTL_GET_KEYRING_ID");
 			}
 
+			/* find a non-existed key */
+			for (i = INT32_MAX; i > -INT32_MAX; --i)
+			{
+				ret = syscall(__NR_keyctl, KEYCTL_READ, i);
+				if (ret == -1 && errno == ENOKEY)
+					break;
+			}
+			nonexist_key = i;
+
 			/* Call keyctl. */
-			ret = syscall(__NR_keyctl, KEYCTL_REVOKE, "MyKey");
+			ret = syscall(__NR_keyctl, KEYCTL_REVOKE, nonexist_key);
 			if (ret != -1) {
 				tst_resm(TFAIL | TERRNO, "KEYCTL_REVOKE succeeded unexpectly");
 			} else {
-- 
1.7.3.1

-- 
Quality Assurance Associate (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch

TEL: +86-10-62608150
WEB: http://www.redhat.com/

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
