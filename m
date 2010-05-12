Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1OCCA2-00038Z-5v
	for ltp-list@lists.sourceforge.net; Wed, 12 May 2010 13:39:42 +0000
Received: from maroilles.sis.pasteur.fr ([157.99.64.223]
	helo=mail-interne3.pasteur.fr)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OCCA0-0005na-Lb
	for ltp-list@lists.sourceforge.net; Wed, 12 May 2010 13:39:42 +0000
Date: Wed, 12 May 2010 15:14:26 +0200
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20100512131426.GA190127@medusa.sis.pasteur.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
Subject: [LTP] ftruncate04.c: cleanup mandatory locking check
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi,

The attached patch tries to cleanup the `mandatory locking' check in
the ftruncate04.c testcase.

The currently test is made with system(2) and involve calling some
external tools ... to determine if the underlying filesystem has
`mand' option set. The same result can be easily retrieved with a
simple statvfs(2) call and examining the mount flags value.

This has been successfully tested on a RHEL5 x86_64 machine.

Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

Regards.

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ltp-ftruncate04.diff"

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index 324a654..fa1daea 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -66,6 +66,8 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mount.h>
+#include <sys/statvfs.h>
 #include "test.h"
 #include "usctest.h"
 #include "libtestsuite.h"
@@ -285,6 +287,7 @@ int main(int ac, char **av)
 	struct sigaction act;
 	int lc;			/* loop counter */
 	char *msg;		/* message returned from parse_opts */
+	struct statvfs fs;
 
 	/*
 	 * parse standard options
@@ -300,9 +303,12 @@ int main(int ac, char **av)
 
 	local_flag = PASSED;
 	tst_tmpdir();
-	if (system
-	    ("mount | grep `df . | grep ^/ | awk {'print $1'}` | grep mand >/dev/null")
-	    != 0) {
+	if (statvfs(".", &fs) == -1) {
+		tst_resm(TFAIL|TERRNO, "statvfs failed");
+		tst_rmdir();
+		tst_exit();
+	}
+	if ((fs.f_flag & MS_MANDLOCK) == 0) {
 		tst_resm(TCONF,
 			 "The filesystem where /tmp is mounted does"
 			 " not support mandatory locks. Cannot run this test.");

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--u3/rZRmxL6MmkK24--

