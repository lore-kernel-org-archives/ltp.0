Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1PAeW6-0000oI-92
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 08:04:22 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PAeW4-0007ph-It
	for ltp-list@lists.sourceforge.net; Tue, 26 Oct 2010 08:04:22 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9Q84EEK009195
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Oct 2010 04:04:14 -0400
Date: Tue, 26 Oct 2010 04:04:14 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <2034750582.1493141288080254753.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1870824414.1492961288080127619.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix keyctl01 testcase on s390x systems
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

Hi all,

on s390x systems, a string like "MyKey" is not a valid argument
for keyctl syscall function, I substitute the string by number 
to make keyctl testcase work on s390x systems.

use "MyKey":

keyctl01    1  TPASS  :  KEYCTL_GET_KEYRING_ID succeeded
keyctl01    2  TFAIL  :  KEYCTL_REVOKE got unexpected errno: errno=EINVAL(22): Invalid argument

use a number:

keyctl01    1  TPASS  :  KEYCTL_GET_KEYRING_ID succeeded
keyctl01    2  TPASS  :  KEYCTL_REVOKE got expected errno: errno=???(126): Required key not available

Signed-off-by: Caspar Zhang <czhang@redhat.com>

---
 testcases/kernel/syscalls/keyctl/keyctl01.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/kernel/syscalls/keyctl/keyctl01.c
index 292e573..179fcb7 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
@@ -46,6 +46,9 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+/* define a non-exist key */
+#define NONEXIST_KEY 65535
+
 /* Extern Global Variables */
 extern int Tst_count;	/* counter for tst_xxx routines.	 */
 extern char *TESTDIR;	/* temporary dir created by tst_tmpdir() */
@@ -126,7 +129,7 @@ int main(int ac, char **av) {
 		Tst_count = 0;
 
 		for (testno = 1; testno < TST_TOTAL; ++testno) {
-	
+
 			/* Call keyctl() and ask for a keyring's ID. */
 			ret = syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
 					KEY_SPEC_USER_SESSION_KEYRING);
@@ -137,7 +140,7 @@ int main(int ac, char **av) {
 			}
 
 			/* Call keyctl. */
-			ret = syscall(__NR_keyctl, KEYCTL_REVOKE, "MyKey");
+			ret = syscall(__NR_keyctl, KEYCTL_REVOKE, NONEXIST_KEY);
 			if (ret != -1) {
 				tst_resm(TFAIL | TERRNO, "KEYCTL_REVOKE succeeded unexpectly");
 			} else {
-- 
1.7.3.1



-- 
/---------------------------------------\
| Name: Caspar Zhang                    |
| Team: Kernel-QE                       |
| Timezone: GMT+0800 (Asia/Shanghai)    |
| IRC: caspar @ #kernel-qe, #eng-china  |
| Phone: +86-10-6260-8150               |
| Cellphone: +86-1381-073-0090          |
\---------------------------------------/

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
