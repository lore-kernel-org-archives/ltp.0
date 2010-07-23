Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1OcLsJ-00070G-VO
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 17:17:31 +0000
Received: from mail-interne3.pasteur.fr ([157.99.64.82])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OcLsI-0004DY-FR
	for ltp-list@lists.sourceforge.net; Fri, 23 Jul 2010 17:17:31 +0000
Date: Fri, 23 Jul 2010 19:17:17 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100723171717.GA54890@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Subject: [LTP] abort01 testcase cleanup
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
To: LTP list <ltp-list@lists.sf.net>


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The attached patch do some cleanup in the abort01 testcase ...

1) The attempt to remove the generated core is wrong. The hard-coded
   `core' name is bad and the test temporary directory removal already
   take care of this.

2) Make the test fail gracefully if the running environment does not
   allow generating core files.

njoly@lanfeust [syscalls/abort]> ./abort01
abort01     1  TPASS  :  Test passed
njoly@lanfeust [syscalls/abort]> (ulimit -c 0 && ./abort01)
abort01     1  TCONF  :  core file size limit must be greater than 0.

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-abort01.diff"

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 28ef9d6..c836f3a 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -43,6 +43,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
@@ -157,7 +158,6 @@ int main(int argc, char *argv[])
 /*--------------------------------------------------------------*/
 /* Clean up any files created by test before call to anyfail.	*/
 
-	unlink("core");
 	anyfail();		/* THIS CALL DOES NOT RETURN - EXITS!!  */
 	return 0;
 }
@@ -183,6 +183,18 @@ int anyfail()
 
 void setup()
 {
+	struct rlimit lim;
+
+	/* Ensure that core file size limit is greater than 0. */
+	if (getrlimit(RLIMIT_CORE, &lim) == -1) {
+		tst_resm(TFAIL|TERRNO, "getrlimit RLIMIT_CORE failed");
+		tst_exit();
+	}
+	if (lim.rlim_cur == 0) {
+		tst_resm(TCONF, "core file size limit must be greater than 0.");
+		tst_exit();
+	}
+
 	temp = stderr;
 	tst_tmpdir();
 }

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--cWoXeonUoKmBZSoM--

