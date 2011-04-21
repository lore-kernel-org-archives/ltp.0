Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1QCo52-0003Jy-A3
	for ltp-list@lists.sourceforge.net; Thu, 21 Apr 2011 07:13:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCo51-0008EE-Ka
	for ltp-list@lists.sourceforge.net; Thu, 21 Apr 2011 07:13:36 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3L7DTW9013940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Apr 2011 03:13:29 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu, 21 Apr 2011 15:13:15 +0800
Message-Id: <3b1be0379ad68fd9c06480b7b5cf2f9c1e9b2529.1303369524.git.czhang@redhat.com>
In-Reply-To: <1303369996-4812-1-git-send-email-czhang@redhat.com>
References: <czhang@redhat.com>
	<1303369996-4812-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH 1/2] add get_no_of_free_hugepages function
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


I want to enable using hugepage releated functions in
$(topdir)/lib/system_specific_hugepages_info.c and I added a function to
get No. of free_hugepages.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 include/system_specific_hugepages_info.h |    4 ++-
 lib/system_specific_hugepages_info.c     |   44 ++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 15 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-add-get_no_of_free_hugepages-function.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-add-get_no_of_free_hugepages-function.patch"

diff --git a/include/system_specific_hugepages_info.h b/include/system_specific_hugepages_info.h
index 43c5ddc..f5e3c46 100644
--- a/include/system_specific_hugepages_info.h
+++ b/include/system_specific_hugepages_info.h
@@ -22,7 +22,9 @@
 
 /*Returns Total No. of available Hugepages in the system from /proc/meminfo*/
 int get_no_of_hugepages(void);
+/*Returns No. of Hugepages_Free  from /proc/meminfo*/
+int get_no_of_free_hugepages(void);
 /*Returns Hugepages Size from /proc/meminfo*/
 int hugepages_size(void);
-#endif
 
+#endif
diff --git a/lib/system_specific_hugepages_info.c b/lib/system_specific_hugepages_info.c
index 7e9be3b..2344add 100644
--- a/lib/system_specific_hugepages_info.c
+++ b/lib/system_specific_hugepages_info.c
@@ -29,22 +29,19 @@
 #include <sys/types.h>
 #include <test.h>
 
-#define BUFSIZE 512
-
 int get_no_of_hugepages() {
  #ifdef __linux__
        FILE *f;
        char buf[BUFSIZ];
 
        f = popen("grep 'HugePages_Total' /proc/meminfo | cut -d ':' -f2 | tr -d ' \n'", "r");
-       if (!f) {
-               tst_resm(TBROK, "Could not get info about Total_Hugepages from /proc/meminfo");
-               tst_exit();
-       }
+       if (!f)
+              tst_brkm(TBROK, NULL,
+                     "Could not get info about Total_Hugepages from /proc/meminfo");
        if (!fgets(buf, 10, f)) {
                fclose(f);
-               tst_resm(TBROK, "Could not read Total_Hugepages from /proc/meminfo");
-               tst_exit();
+               tst_brkm(TBROK, NULL,
+                     "Could not read Total_Hugepages from /proc/meminfo");
        }
        pclose(f);
        return(atoi(buf));
@@ -53,6 +50,26 @@ int get_no_of_hugepages() {
  #endif
 }
 
+int get_no_of_free_hugepages() {
+ #ifdef __linux__
+       FILE *f;
+       char buf[BUFSIZ];
+
+       f = popen("grep 'HugePages_Free' /proc/meminfo | cut -d ':' -f2 | tr -d ' \n'", "r");
+       if (!f)
+               tst_brkm(TBROK, NULL,
+                     "Could not get info about HugePages_Free from /proc/meminfo");
+       if (!fgets(buf, 10, f)) {
+               fclose(f);
+               tst_brkm(TBROK, NULL,
+                     "Could not read HugePages_Free from /proc/meminfo");
+       }
+       pclose(f);
+       return(atoi(buf));
+ #else
+        return -1;
+ #endif
+}
 
 int hugepages_size() {
  #ifdef __linux__
@@ -60,14 +77,13 @@ int hugepages_size() {
        char buf[BUFSIZ];
 
        f = popen("grep 'Hugepagesize' /proc/meminfo | cut -d ':' -f2 | tr -d 'kB \n'", "r");
-       if (!f) {
-               tst_resm(TBROK, "Could not get info about HugePages_Size from /proc/meminfo");
-               tst_exit();
-       }
+       if (!f)
+               tst_brkm(TBROK, NULL,
+                     "Could not get info about HugePages_Size from /proc/meminfo");
        if (!fgets(buf, 10, f)) {
                fclose(f);
-               tst_resm(TBROK, "Could not read HugePages_Size from /proc/meminfo");
-               tst_exit();
+               tst_brkm(TBROK, NULL,
+                     "Could not read HugePages_Size from /proc/meminfo");
        }
        pclose(f);
        return(atoi(buf));

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



