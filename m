From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 26 Apr 2018 14:45:36 +0800
Subject: [LTP] [PATCH 1/2] *.py: Replace '#!/usr/bin/python3' with
	'#!/usr/bin/env python3'
Message-ID: <1524725137-32739-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we install python3 in specific path(/usr/local/bin) rather than the
default(/usr/bin), the standard shebang(#!/usr/bin/python3) cannot
interpreter python code due to wrong path.  We should use env to
search the correct path of python3 dynamically.

Test it by running datafiles/in.py:
-----------------------------------
/usr/local/bin/python3
-bash: ./in.py: /usr/bin/python3: bad interpreter: No such file or directory
-----------------------------------

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 execltp.in                                                | 2 +-
 testcases/commands/file/datafiles/in.py                   | 2 +-
 testcases/kernel/power_management/lib/pm_sched_mc.py      | 2 +-
 testcases/kernel/power_management/pm_cpu_consolidation.py | 2 +-
 testcases/kernel/power_management/pm_ilb_test.py          | 2 +-
 testcases/kernel/power_management/pm_sched_domain.py      | 2 +-
 testcases/network/nfsv4/acl/cleangroups.py                | 2 +-
 testcases/network/nfsv4/acl/cleanusers.py                 | 2 +-
 testcases/network/nfsv4/acl/create_users.py               | 2 +-
 testcases/network/nfsv4/acl/random_gen.py                 | 2 +-
 testcases/network/nfsv4/acl/setacl_stress.py              | 2 +-
 testcases/network/nfsv4/acl/test_acl.py                   | 2 +-
 testcases/network/nfsv4/acl/test_long_acl.py              | 2 +-
 testcases/network/nfsv4/locks/locktests.py                | 2 +-
 testcases/realtime/func/pi-tests/parse-testpi1.py         | 2 +-
 testcases/realtime/func/pi-tests/parse-testpi2.py         | 2 +-
 testcases/realtime/scripts/parser.py                      | 2 +-
 testcases/realtime/tools/ftqviz.py                        | 2 +-
 testscripts/build/ltp-missing-install-files.py            | 2 +-
 tools/pounder21/src/time_tests/drift-test.py              | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/execltp.in b/execltp.in
index 57e9c45..4b647cd 100755
--- a/execltp.in
+++ b/execltp.in
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 """
     An LTP [execution and] parsing wrapper.
 
diff --git a/testcases/commands/file/datafiles/in.py b/testcases/commands/file/datafiles/in.py
index 802e7bf..5fd48ce 100755
--- a/testcases/commands/file/datafiles/in.py
+++ b/testcases/commands/file/datafiles/in.py
@@ -1,3 +1,3 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 
 print("This is a test.")
diff --git a/testcases/kernel/power_management/lib/pm_sched_mc.py b/testcases/kernel/power_management/lib/pm_sched_mc.py
index 3574330..743b6de 100755
--- a/testcases/kernel/power_management/lib/pm_sched_mc.py
+++ b/testcases/kernel/power_management/lib/pm_sched_mc.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 ''' Reusable functions related to sched mc FVT are put together
 '''
 
diff --git a/testcases/kernel/power_management/pm_cpu_consolidation.py b/testcases/kernel/power_management/pm_cpu_consolidation.py
index ecd2e4f..a01db00 100755
--- a/testcases/kernel/power_management/pm_cpu_consolidation.py
+++ b/testcases/kernel/power_management/pm_cpu_consolidation.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 ''' This Python script interprets various sched stats values.
     Validates cpu consolidation for given sched_mc_power_saving value
 '''
diff --git a/testcases/kernel/power_management/pm_ilb_test.py b/testcases/kernel/power_management/pm_ilb_test.py
index 920c4e3..f207170 100755
--- a/testcases/kernel/power_management/pm_ilb_test.py
+++ b/testcases/kernel/power_management/pm_ilb_test.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 ''' This Python script interprets interrupt values.
     Validates Ideal load balancer runs in same package where workload is running
 '''
diff --git a/testcases/kernel/power_management/pm_sched_domain.py b/testcases/kernel/power_management/pm_sched_domain.py
index d5cd327..dddc481 100755
--- a/testcases/kernel/power_management/pm_sched_domain.py
+++ b/testcases/kernel/power_management/pm_sched_domain.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 ''' This Python script validates sched domain information in dmesg
     with information in sysfs topology
 '''
diff --git a/testcases/network/nfsv4/acl/cleangroups.py b/testcases/network/nfsv4/acl/cleangroups.py
index 11f8045..3c06478 100755
--- a/testcases/network/nfsv4/acl/cleangroups.py
+++ b/testcases/network/nfsv4/acl/cleangroups.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 from random_gen import *
 from optparse import OptionParser
 import subprocess
diff --git a/testcases/network/nfsv4/acl/cleanusers.py b/testcases/network/nfsv4/acl/cleanusers.py
index f2597d2..3e652c5 100755
--- a/testcases/network/nfsv4/acl/cleanusers.py
+++ b/testcases/network/nfsv4/acl/cleanusers.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 from random_gen import *
 from optparse import OptionParser
 import subprocess
diff --git a/testcases/network/nfsv4/acl/create_users.py b/testcases/network/nfsv4/acl/create_users.py
index 0dcaecb..3203aff 100755
--- a/testcases/network/nfsv4/acl/create_users.py
+++ b/testcases/network/nfsv4/acl/create_users.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 '''
 	Access Control Lists testing based on newpynfs framework
 	Aurelien Charbon - Bull SA
diff --git a/testcases/network/nfsv4/acl/random_gen.py b/testcases/network/nfsv4/acl/random_gen.py
index 37cb179..4b6ba96 100755
--- a/testcases/network/nfsv4/acl/random_gen.py
+++ b/testcases/network/nfsv4/acl/random_gen.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 import subprocess
 import random
 import re
diff --git a/testcases/network/nfsv4/acl/setacl_stress.py b/testcases/network/nfsv4/acl/setacl_stress.py
index 68a4932..c93ac8b 100755
--- a/testcases/network/nfsv4/acl/setacl_stress.py
+++ b/testcases/network/nfsv4/acl/setacl_stress.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 '''
 	Access Control Lists stressing script
 	To lauch on the first client
diff --git a/testcases/network/nfsv4/acl/test_acl.py b/testcases/network/nfsv4/acl/test_acl.py
index 612b9e4..8699b02 100755
--- a/testcases/network/nfsv4/acl/test_acl.py
+++ b/testcases/network/nfsv4/acl/test_acl.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 '''
 	Access Control Lists testing based on newpynfs framework
 	Aurelien Charbon - Bull SA
diff --git a/testcases/network/nfsv4/acl/test_long_acl.py b/testcases/network/nfsv4/acl/test_long_acl.py
index 79e3a96..893855b 100755
--- a/testcases/network/nfsv4/acl/test_long_acl.py
+++ b/testcases/network/nfsv4/acl/test_long_acl.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 '''
 	Access Control Lists testing based on newpynfs framework
 	Aurelien Charbon - Bull SA
diff --git a/testcases/network/nfsv4/locks/locktests.py b/testcases/network/nfsv4/locks/locktests.py
index 80d8c20..9876a86 100755
--- a/testcases/network/nfsv4/locks/locktests.py
+++ b/testcases/network/nfsv4/locks/locktests.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # This script aims to help to run locktests with several clients.
 #
 # Report bugs to Vincent ROQUETA : vincent.roqueta@ext.bull.net
diff --git a/testcases/realtime/func/pi-tests/parse-testpi1.py b/testcases/realtime/func/pi-tests/parse-testpi1.py
index 0631cce..740e7d1 100644
--- a/testcases/realtime/func/pi-tests/parse-testpi1.py
+++ b/testcases/realtime/func/pi-tests/parse-testpi1.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
 ################################################################################
diff --git a/testcases/realtime/func/pi-tests/parse-testpi2.py b/testcases/realtime/func/pi-tests/parse-testpi2.py
index f11ff8a..69b2748 100644
--- a/testcases/realtime/func/pi-tests/parse-testpi2.py
+++ b/testcases/realtime/func/pi-tests/parse-testpi2.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
 ################################################################################
diff --git a/testcases/realtime/scripts/parser.py b/testcases/realtime/scripts/parser.py
index bc4512f..85226de 100644
--- a/testcases/realtime/scripts/parser.py
+++ b/testcases/realtime/scripts/parser.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
 ################################################################################
diff --git a/testcases/realtime/tools/ftqviz.py b/testcases/realtime/tools/ftqviz.py
index f331d33..5ac094c 100644
--- a/testcases/realtime/tools/ftqviz.py
+++ b/testcases/realtime/tools/ftqviz.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 
 #      Filename: ftqviz.py
 #        Author: Darren Hart <dvhltc@us.ibm.com>
diff --git a/testscripts/build/ltp-missing-install-files.py b/testscripts/build/ltp-missing-install-files.py
index 232028b..0f9d81c 100755
--- a/testscripts/build/ltp-missing-install-files.py
+++ b/testscripts/build/ltp-missing-install-files.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 #
 #    Script for determining items missing from LTP install based on the output
 #    log provided by runltp[lite.sh].
diff --git a/tools/pounder21/src/time_tests/drift-test.py b/tools/pounder21/src/time_tests/drift-test.py
index 0c25756..3fe8ba5 100755
--- a/tools/pounder21/src/time_tests/drift-test.py
+++ b/tools/pounder21/src/time_tests/drift-test.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python3
+#!/usr/bin/env python3
 
 # Time Drift Script
 #		Periodically checks and displays time drift
-- 
1.8.3.1



