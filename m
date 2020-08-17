From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Aug 2020 15:09:14 +0200
Subject: [LTP] [PATCH v3 2/4] IMA: Refactor datafiles directory
In-Reply-To: <20200817130916.27634-1-pvorel@suse.cz>
References: <20200817130916.27634-1-pvorel@suse.cz>
Message-ID: <20200817130916.27634-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The IMA datafiles directory is structured so that it cannot be directly
expanded to include datafiles for tests other than `ima_policy.sh`
as it's installed into /opt/ltp/testcases/data/ima_policy.

Also not all policies are meant to be for ima_policy.sh, thus
move policies into their own directories based on the test which they
belong to. Rename policy directory to ima_policy to follow the
pattern that directory in sources match the installed directory.

Reported-by: Lachlan Sneff <t-josne@linux.microsoft.com>
Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
[ pvorel: based on Lachlan's patch, rewritten ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as v2.

 .../kernel/security/integrity/ima/datafiles/Makefile  | 10 +++++-----
 .../integrity/ima/datafiles/ima_kexec/Makefile        | 11 +++++++++++
 .../ima/datafiles/{ => ima_kexec}/kexec.policy        |  0
 .../integrity/ima/datafiles/ima_keys/Makefile         | 11 +++++++++++
 .../ima/datafiles/{ => ima_keys}/keycheck.policy      |  0
 .../integrity/ima/datafiles/ima_policy/Makefile       | 11 +++++++++++
 .../ima/datafiles/{ => ima_policy}/measure.policy     |  0
 .../datafiles/{ => ima_policy}/measure.policy-invalid |  0
 8 files changed, 38 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_kexec}/kexec.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_keys}/keycheck.policy (100%)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy (100%)
 rename testcases/kernel/security/integrity/ima/datafiles/{ => ima_policy}/measure.policy-invalid (100%)

diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 369407112..6857ccfee 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -1,6 +1,8 @@
 #
 #    testcases/kernel/security/integrity/ima/policy testcases Makefile.
 #
+#    Copyright (c) Linux Test Project, 2019-2020
+#    Copyright (c) 2020 Microsoft Corporation
 #    Copyright (C) 2009, Cisco Systems Inc.
 #
 #    This program is free software; you can redistribute it and/or modify
@@ -20,12 +22,10 @@
 # Ngie Cooper, July 2009
 #
 
-top_srcdir		?= ../../../../../..
+top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR		:= testcases/data/ima_policy
+SUBDIRS	:= ima_*
 
-INSTALL_TARGETS		:= measure.policy-invalid *.policy
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
new file mode 100644
index 000000000..5e0d632a7
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_kexec
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/kexec.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_kexec/kexec.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/kexec.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_kexec/kexec.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
new file mode 100644
index 000000000..452321843
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_keys
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keycheck.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/keycheck.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
new file mode 100644
index 000000000..953e21556
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2020
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_policy
+INSTALL_TARGETS	:= *.policy-invalid *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy
rename to testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy-invalid
similarity index 100%
rename from testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
rename to testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.policy-invalid
-- 
2.28.0

