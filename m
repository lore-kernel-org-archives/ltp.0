Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YIz8b-0006oL-JM
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 12:32:57 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIz8a-0004kn-CU
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 12:32:57 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t14CWnGE026320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Feb 2015 07:32:50 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t14CWmwT023652
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Feb 2015 07:32:49 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed,  4 Feb 2015 13:32:42 +0100
Message-Id: <1423053163-13483-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 1/2] lib: support VIRT_KVM for tst_is_virt()
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

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 include/test.h |  1 +
 lib/tst_virt.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/test.h b/include/test.h
index 137e6f4..53d6254 100644
--- a/include/test.h
+++ b/include/test.h
@@ -51,6 +51,7 @@
 
 /* virt types for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
+#define VIRT_KVM	2	/* only default virtual CPU */
 
 /*
  * Ensure that NUMSIGS is defined.
diff --git a/lib/tst_virt.c b/lib/tst_virt.c
index d1f1e74..87f73dc 100644
--- a/lib/tst_virt.c
+++ b/lib/tst_virt.c
@@ -24,6 +24,28 @@
 
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
+
+static int is_kvm(void)
+{
+	FILE *cpuinfo;
+	char line[64];
+	int found;
+
+	/* this doesn't work with custom -cpu values, since there's
+	 * no easy, reasonable or reliable way to work around those */
+	cpuinfo = SAFE_FOPEN(NULL, "/proc/cpuinfo", "r");
+	found = 0;
+	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
+		if (strstr(line, "QEMU Virtual CPU")) {
+			found = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(NULL, cpuinfo);
+	return found;
+}
 
 static int is_xen(void)
 {
@@ -47,6 +69,8 @@ int tst_is_virt(int virt_type)
 	switch (virt_type) {
 	case VIRT_XEN:
 		return is_xen();
+	case VIRT_KVM:
+		return is_kvm();
 	}
 	tst_brkm(TBROK, NULL, "invalid virt_type flag: %d", virt_type);
 }
-- 
2.1.0


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
