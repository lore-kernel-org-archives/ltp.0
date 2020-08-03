From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Mon,  3 Aug 2020 13:59:03 -0400
Subject: [LTP] [PATCH 2/3] IMA: Refactor datafiles directory
In-Reply-To: <20200803175904.40269-1-t-josne@linux.microsoft.com>
References: <20200803175904.40269-1-t-josne@linux.microsoft.com>
Message-ID: <20200803175904.40269-3-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The IMA datafiles directory is structured so that it cannot be directly
expanded to include datafiles for tests other than `ima_policy.sh`.

Move the contents of the IMA datafiles directory into an IMA
datafiles/policy directory.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../security/integrity/ima/datafiles/Makefile     |  6 ++----
 .../integrity/ima/datafiles/policy/Makefile       | 15 +++++++++++++++
 .../ima/datafiles/{ => policy}/kexec.policy       |  0
 .../ima/datafiles/{ => policy}/keycheck.policy    |  0
 .../ima/datafiles/{ => policy}/measure.policy     |  0
 .../datafiles/{ => policy}/measure.policy-invalid |  0
 6 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/kexec.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/keycheck.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => policy}/measure.policy-invalid (100%)

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 369407112..3772e9a03 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -24,8 +24,6 @@ top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR		:= testcases/data/ima_policy
+SUBDIRS			:= policy
 
-INSTALL_TARGETS		:= measure.policy-invalid *.policy
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile b/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
new file mode 100644
index 000000000..84d1424c6
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/policy/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# IMA datafiles/policy Makefile
+
+top_srcdir		?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_policy
+
+INSTALL_TARGETS		:= measure.policy-invalid *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
\ No newline at end of file
diff --git a/testcases/kernel/security/integrity/ima/datafiles/kexec.policy b/testcases/kernel/security/integrity/ima/datafiles/policy/kexec.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/kexec.policy
rename to testcases/kernel/security/integrity/ima/datafiles/policy/kexec.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/policy/keycheck.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
rename to testcases/kernel/security/integrity/ima/datafiles/policy/keycheck.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy
rename to testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy-invalid
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
rename to testcases/kernel/security/integrity/ima/datafiles/policy/measure.policy-invalid
-- 
2.25.1

