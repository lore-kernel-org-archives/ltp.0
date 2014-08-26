Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XMDYr-00050K-Ha
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 10:01:09 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XMDYm-0008VZ-5j
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 10:01:09 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7QA0vSG018048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Aug 2014 06:00:58 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7QA0uSA022138
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Aug 2014 06:00:57 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Aug 2014 12:01:01 +0200
Message-Id: <0be2f82a131d32b119748e91a840cb038bf82960.1409046964.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] tst_ncpus_max: use kernel_max if available
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

sched_getaffinity() and sched_setaffinity() cares about number of possible
CPUs the OS or hardware can support, which can be larger than what
sysconf(_SC_NPROCESSORS_CONF) currently provides (by enumarating
/sys/devices/system/cpu/cpu* entries).

Use /sys/devices/system/cpu/kernel_max, if available. This represents
NR_CPUS-1, a compile time option which specifies "maximum number of CPUs
which this kernel will support". This should give us cpu mask size
large enough for any purposes.

If the kernel_max sysfs file is not available, fall back to
_SC_NPROCESSORS_CONF.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_cpu.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

Tested on system supporting CPU hotplug:
NR_CPUS:4096 nr_cpumask_bits:144 nr_cpu_ids:144 nr_node_ids:1

# cat /sys/devices/system/cpu/online 
0-15
# cat /sys/devices/system/cpu/offline 
16-143
# cat /sys/devices/system/cpu/possible 
0-143
# cat /sys/devices/system/cpu/kernel_max 
4095

diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index e8ab34e..b492dc2 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -33,13 +33,35 @@ long tst_ncpus(void)
 	return ncpus;
 }
 
+#define KERNEL_MAX "/sys/devices/system/cpu/kernel_max"
+
 long tst_ncpus_max(void)
 {
 	long ncpus_max = -1;
+	struct stat buf;
+
+	/* sched_getaffinity() and sched_setaffinity() cares about number of
+	 * possible CPUs the OS or hardware can support, which can be larger
+	 * than what sysconf(_SC_NPROCESSORS_CONF) currently provides
+	 * (by enumarating /sys/devices/system/cpu/cpu* entries).
+	 *
+	 *  Use /sys/devices/system/cpu/kernel_max, if available. This
+	 *  represents NR_CPUS-1, a compile time option which specifies
+	 *  "maximum number of CPUs which this kernel will support".
+	 *  This should provide cpu mask size large enough for any purposes. */
+	if (stat(KERNEL_MAX, &buf) == 0) {
+		SAFE_FILE_SCANF(NULL, KERNEL_MAX, "%ld", &ncpus_max);
+		/* this is maximum CPU index allowed by the kernel
+		 * configuration, so # of cpus allowed by config is +1 */
+		ncpus_max++;
+	} else {
+		/* fall back to _SC_NPROCESSORS_CONF */
 #ifdef _SC_NPROCESSORS_CONF
-	ncpus_max = SAFE_SYSCONF(NULL, _SC_NPROCESSORS_CONF);
+		ncpus_max = SAFE_SYSCONF(NULL, _SC_NPROCESSORS_CONF);
 #else
-	tst_brkm(TBROK, NULL, "could not determine number of CPUs configured");
+		tst_brkm(TBROK, NULL, "could not determine number of CPUs"
+			" configured");
 #endif
+	}
 	return ncpus_max;
 }
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
