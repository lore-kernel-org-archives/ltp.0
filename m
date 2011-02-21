Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PrR7U-00019E-Gd
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 08:27:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrR7S-0007nz-3R
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 08:27:48 +0000
Date: Mon, 21 Feb 2011 16:31:35 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110221083135.GA9779@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH v2] check two possible pathes for cpuset
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

From

http://lxr.linux.no/#linux+v2.6.37/Documentation/cgroups/cpusets.txt

"Note that for legacy reasons, the "cpuset" filesystem exists as a
wrapper around the cgroup filesystem.

The command

mount -t cpuset X /dev/cpuset

is equivalent to

mount -t cgroup -ocpuset,noprefix X /dev/cpuset"

However, I found this is not always case. In addition, there is an
direct implementation without cgroup, and I can't find any doc about
the behaviours of the prefix.

So, It can be difficult to predict if cpuset files have prefix or not,
so only to fail after checked both.

Signed-off-by: CAI Qian <caiqian@redhat.com>
Signed-off-by: Han Pingtian <phan@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 1a53359..7bc26cd 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -89,16 +89,32 @@ void write_cpusets(void)
 	gather_cpus(cpus);
 	tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
 
+	/* try either '/dev/cpuset/mems' or '/dev/cpuset/cpuset.mems' 
+	 * please see Documentation/cgroups/cpusets.txt of kernel src for detail */
 	fd = open(CPATH_NEW "/mems", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, "1", 1) != 1)
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
 
+	/* try either '/dev/cpuset/cpus' or '/dev/cpuset/cpuset.cpus' 
+	 * please see Documentation/cgroups/cpusets.txt of kernel src for detail */
 	fd = open(CPATH_NEW "/cpus", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
-- 
1.7.1

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
