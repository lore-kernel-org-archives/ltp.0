Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XK6RH-0003oH-US
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 14:00:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XK6RG-0004Pl-8Q
	for ltp-list@lists.sourceforge.net; Wed, 20 Aug 2014 14:00:35 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7KE0Q8c009094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Aug 2014 10:00:27 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Aug 2014 16:00:21 +0200
Message-Id: <d00e2fbc8b2b96403e841845b3df25104dada721.1408543124.git.jstancek@redhat.com>
Subject: [LTP] [PATCH/RFC] profil01: don't use address of function
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

This testcase is failing on ppc64 BE system, because
address of &test_profil does not reference beginning of code,
but entry in .opd section:
  "This section contains the official procedure descriptors.
   A pointer to a function shall reference a procedure descriptor
   in this section."
which was at address larger than all .text of test_profil.

This patch is replacing address of function approach with gcc's
__builtin_return_address() to get current pc value.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/profil/profil01.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index 5511f68..521ef97 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -31,9 +31,11 @@
 
 #define PROFIL_TIME 5
 
-/* should be large enough to hold data for test_profil() .text
- * on x86_64 this is ~600 bytes, so 16k should enough for all arches */
-#define PROFIL_BUFLEN (16*1024)
+/* Should be large enough to hold data for test_profil() .text,
+ * on x86_64 this is ~600 bytes, so 16k should enough for all arches.
+ * We will monitor 16k on each side around current pc value,
+ * just in case compiler put call to get_pc() below "data shuffling" code */
+#define PROFIL_BUFLEN (32*1024)
 
 char *TCID = "profil01";
 int TST_TOTAL = 1;
@@ -46,11 +48,16 @@ static void alrm_handler(int sig)
 	profil_done = 1;
 }
 
+static void __attribute__ ((noinline)) *get_pc(void)
+{
+	return __builtin_return_address(0);
+}
+
 static void test_profil(void)
 {
 	unsigned short buf[PROFIL_BUFLEN] = { 0 };
 	volatile int data[8] = { 0 };
-	size_t offset = (size_t) &test_profil, count = 0;
+	size_t offset = (size_t) get_pc() - PROFIL_BUFLEN/2, count = 0;
 	int ret, i;
 
 	/* reset for test looping */
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
