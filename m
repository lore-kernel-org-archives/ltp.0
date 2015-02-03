Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YIfuK-0001r5-7l
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 16:00:56 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIfuJ-0002lm-5z
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 16:00:56 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t13G0m59015188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 16:00:49 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13G0l6u016170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 16:00:48 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t13G0lKn016148
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 16:00:47 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue,  3 Feb 2015 19:00:40 +0300
Message-Id: <1422979240-17376-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <54D0E4C2.6030004@oracle.com>
References: <54D0E4C2.6030004@oracle.com>
Subject: [LTP] [PATCH V2] doc: document tst_run_cmd
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
Cc: vasily.isaenko@oracle.com

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Applied all comments from V1
 * Added one more const to cmd[] in Example


 doc/test-writing-guidelines.txt |   40 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 4d70a1b..22eb318 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -994,6 +994,46 @@ exactly as 'umount(2)' but retries several times on a failure.
 IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
            umount filesystems.
 
+2.2.20 Running executables
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+int tst_run_cmd(void (cleanup_fn)(void),
+               const char *const argv[],
+	       const char *stdout_path,
+	       const char *stderr_path,
+	       int pass_exit_val);
+-------------------------------------------------------------------------------
+
+'tst_run_cmd' is a wrapper for 'vfork() + execvp()' which provides a way
+to execute an external program.
+
+'argv[]' is a NULL-terminated array of strings starting with the program name
+which is followed by optional arguments.
+
+A non-zero 'pass_exit_val' makes 'tst_run_cmd' return the program exit code to
+the caller. A zero for 'pass_exit_val' makes 'tst_run_cmd' exit the tests
+on failure and call 'cleanup_fn' (if not NULL) beforehand.
+
+'stdout_path' and 'stderr_path' determine where to redirect the program
+stdout and stderr I/O streams.
+
+.Example
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+const char *const cmd[] = { "ls", "-l", NULL };
+
+...
+	/* Store output of 'ls -l' into log.txt */
+	tst_run_cmd(cleanup, cmd, "log.txt", NULL, 0);
+...
+-------------------------------------------------------------------------------
+
 2.3 Writing a testcase in shell
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
