Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1YIHZA-0000vX-RN
	for ltp-list@lists.sourceforge.net; Mon, 02 Feb 2015 14:01:28 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIHZ6-0006tt-Nt
	for ltp-list@lists.sourceforge.net; Mon, 02 Feb 2015 14:01:28 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t12E1IBb019183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 14:01:19 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	t12E1Hk5018513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 14:01:17 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t12E1GUp022911
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Feb 2015 14:01:16 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon,  2 Feb 2015 17:01:12 +0300
Message-Id: <1422885672-6254-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20150126130448.GA25601@rei.suse.de>
References: <20150126130448.GA25601@rei.suse.de>
Subject: [LTP] [PATCH] doc: document tst_run_cmd
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

Sorry for late response.

 doc/test-writing-guidelines.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 4d70a1b..a0004d8 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -994,6 +994,33 @@ exactly as 'umount(2)' but retries several times on a failure.
 IMPORTANT: All testcases should use 'tst_umount()' instead of 'umount(2)' to
            umount filesystems.
 
+2.2.20 Executing a file
+^^^^^^^^^^^^^^^^^^^^^^^
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
+'tst_run_cmd' is a wrapper for 'vfork() + execvp()' which provides a way to execute
+an external program.
+
+'argv[]' is a NULL-terminated list of pointers to the program name and its optional
+arguments.
+
+A non-zero 'pass_exit_val' makes 'tst_run_cmd' return the program exit code to
+the caller. A zero for 'pass_exit_val' makes 'tst_run_cmd' call 'cleanup_fn'
+in case the program exits with a non-zero code.
+
+'stdout_path' and 'stderr_path' detirmine where to redirect the program
+stdout and stderr I/O streams.
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
