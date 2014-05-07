Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Wi1iD-0007ec-83
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 13:16:41 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wi1iB-0008GT-G9
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 13:16:41 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s47DGWXJ016087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 7 May 2014 13:16:33 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s47DGVXd008477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 7 May 2014 13:16:32 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s47DGUCq028481
	for <ltp-list@lists.sourceforge.net>; Wed, 7 May 2014 13:16:30 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed,  7 May 2014 17:16:59 +0400
Message-Id: <1399468619-27317-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] device-drivers/acpi/ltp_acpi_cpufreq: fix checking
	for write permission
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

If access(some_file, W_OK) is executed by root it will return success even
if the file has read-only permission. Use 'open' to test sysfs file for write
permission.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 .../kernel/device-drivers/acpi/ltp_acpi_cpufreq.c  |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
index 175bf4c..f1d3d5a 100644
--- a/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
+++ b/testcases/kernel/device-drivers/acpi/ltp_acpi_cpufreq.c
@@ -31,6 +31,9 @@
 #include <sched.h>
 #include <sys/time.h>
 #include <pthread.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "test.h"
 #include "usctest.h"
@@ -69,12 +72,15 @@ static void cleanup(void)
 
 static void setup(void)
 {
+	int fd;
 	tst_require_root(NULL);
 
-	if (access(boost, R_OK | W_OK)) {
+	fd = open(boost, O_RDWR);
+	if (fd == -1) {
 		tst_brkm(TCONF, NULL,
 			"acpi-cpufreq not loaded or overclock not supported");
 	}
+	close(fd);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-- 
1.7.1


------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
