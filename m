Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WZjTA-0001QZ-Ij
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 16:10:52 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WZjT8-0000D0-Bz
	for ltp-list@lists.sourceforge.net; Mon, 14 Apr 2014 16:10:52 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 14 Apr 2014 18:09:37 +0200
Message-ID: <1397491777-16376-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <534B5C8E.1070500@cn.fujitsu.com>
References: <534B5C8E.1070500@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] partrt_nohz_full: Get noHz mask from RT partition
	instead of boot parameter
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
To: ltp-list@lists.sourceforge.net

Now that partitioning is done outside of test case, the test case must adapt
to the CPU list that is true for the rt partition. There is no guarantee that
this list is identical to the nohz_full kernel boot parameter.

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 .../partrt/nohz_full/test_partrt_nohz_full.c       |   52 +++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
index 7c3ab09..1120b4b 100644
--- a/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
+++ b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
@@ -22,13 +22,16 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/syscall.h>
+#include <sys/stat.h>
 #include <stdarg.h>
 #include <inttypes.h>
 #include <limits.h>
 #include <time.h>
 #include <sched.h>
+#include <fcntl.h>
 
 #include <test.h>
+#include <safe_macros.h>
 
 /* Name of test case */
 const char *TCID = "nohz_full";
@@ -439,13 +442,60 @@ static void cleanup(void)
 	info("Cleanup: Done");
 }
 
+static unsigned long determine_nohz_mask(void)
+{
+	const char *nohz_cpus_filename = "/sys/fs/cgroup/cpuset/rt/cpuset_cpus";
+	int file = SAFE_OPEN(cleanup, nohz_cpus_filename, O_RDONLY);
+	struct stat stat_buf;
+	char *buf;
+	char *curr;
+	char *curr_next;
+	int range_first;
+	int range_last;
+	unsigned long mask = 0;
+
+	SAFE_FSTAT(cleanup, file, &stat_buf);
+	buf = SAFE_MALLOC(cleanup, stat_buf.st_size + 1);
+	SAFE_READ(cleanup, 0, file, buf, stat_buf.st_size);
+	buf[stat_buf.st_size] = '\0';
+
+	curr = buf;
+	while (curr < (buf + stat_buf.st_size)) {
+		int bit;
+
+		range_first = range_last = strtoull(curr, &curr_next, 10);
+		if (curr == curr_next)
+			err("%s: %s: Cannot parse CPU list",
+				nohz_cpus_filename, buf);
+		curr = curr_next;
+		if (*curr == '-') {
+			curr++;
+			range_last = strtoull(curr, &curr_next, 10);
+			if (curr == curr_next)
+				err("%s: %s: Cannot parse CPU list",
+					nohz_cpus_filename, buf);
+			curr = curr_next;
+		}
+
+		/* Set all bits in range */
+		for (bit = range_first; bit <= range_last; bit++) {
+			mask |= (1 << bit);
+		}
+
+		if (*curr == ',')
+			curr++;
+	}
+
+	return mask;
+}
+
 /*
  * Prepare for test.
  * Perform CPU partitioning and start RT load.
  */
 static int setup(void)
 {
-	const unsigned long nohz_mask = shell_int(16, "list2mask --nohz");
+	const unsigned long nohz_mask = determine_nohz_mask();
 	int bit;
 	int nr_children = 0;
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
