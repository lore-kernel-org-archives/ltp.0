Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1OUiqx-0005Pt-C8
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 16:12:35 +0000
Received: from msux-gh1-uea02.nsa.gov ([63.239.65.40])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OUiqw-0007Hc-Eh
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 16:12:35 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 02 Jul 2010 12:12:28 -0400
Message-ID: <1278087148.6654.80.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Subject: [LTP] [PATCH] ima:  Fix ima_measure
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: Mimi Zohar <zohar@us.ibm.com>

ima_measure doesn't build correctly.  It needs config.h to determine
whether openssl headers are present, and verbose needs to be global.
Broken by commit ef77253961f909f87e82e6d2b620e87af33e9665.

Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

---

diff --git a/testcases/kernel/security/integrity/ima/src/ima_measure.c b/testcases/kernel/security/integrity/ima/src/ima_measure.c
index dd6b1d0..0484c04 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_measure.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_measure.c
@@ -22,7 +22,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <unistd.h>
-//#include "config.h"
+#include "config.h"
 #include "test.h"
 #if HAVE_OPENSSL_SHA_H
 #include <openssl/sha.h>
@@ -33,6 +33,8 @@
 char *TCID = "ima_measure";
 int TST_TOTAL = 1;
 
+static int verbose;
+
 #define print_info(format, arg...) \
 	if (verbose) \
 		printf(format, ##arg)
@@ -135,9 +137,8 @@ main(int argc, char *argv[])
 	FILE *fp;
 	struct event template;
 	u_int8_t pcr[SHA_DIGEST_LENGTH];
-	int i, count = 0, len;
+	int i, count = 0;
 
-	int verbose = 0;
 	int validate = 0;
 	int verify = 0;
 


-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
