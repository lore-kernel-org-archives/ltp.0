From: Li Wang <liwang@redhat.com>
Date: Fri,  4 Mar 2016 16:24:56 +0800
Subject: [LTP] [PATCH RFC 7/9] ftrace_stress: keep the name of testscipt in
	sync with tracing file
In-Reply-To: <1457079898-9449-7-git-send-email-liwang@redhat.com>
References: <1457079898-9449-1-git-send-email-liwang@redhat.com>
 <1457079898-9449-2-git-send-email-liwang@redhat.com>
 <1457079898-9449-3-git-send-email-liwang@redhat.com>
 <1457079898-9449-4-git-send-email-liwang@redhat.com>
 <1457079898-9449-5-git-send-email-liwang@redhat.com>
 <1457079898-9449-6-git-send-email-liwang@redhat.com>
 <1457079898-9449-7-git-send-email-liwang@redhat.com>
Message-ID: <1457079898-9449-8-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Chunyu Hu <chuhu@redhat.com>

The test scripts under ftrace_stress/ are all named after the tracing
file with a 'ftrace_' prefix, except the ftrace_buffer_size.sh and
ftrace_profile_enabled.sh. Here just rename them.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 .../ftrace_stress/ftrace_buffer_size.sh            | 45 -------------------
 .../ftrace_stress/ftrace_buffer_size_kb.sh         | 45 +++++++++++++++++++
 .../ftrace_function_profile_enabled.sh             | 50 ++++++++++++++++++++++
 .../ftrace_stress/ftrace_profile_enabled.sh        | 50 ----------------------
 4 files changed, 95 insertions(+), 95 deletions(-)
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
 create mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
 delete mode 100755 testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh

diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
deleted file mode 100755
index bd7dcc4..0000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size.sh
+++ /dev/null
@@ -1,45 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-LOOP=200
-
-# Use up to 10% of free memory
-free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
-cpus=`tst_ncpus`
-
-step=$(( $free_mem / 10 / $LOOP / $cpus ))
-
-if [ $step -eq 0 ]; then
-	step=1
-	LOOP=50
-fi
-
-for ((; ;))
-{
-	new_size=1
-	for ((i = 0; i < $LOOP; i++))
-	{
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-		new_size=$(( $new_size + $step ))
-	}
-
-	for ((i = 0; i < $LOOP; i++))
-	{
-		new_size=$(( $new_size - $step ))
-		echo $new_size > "$TRACING_PATH"/buffer_size_kb
-	}
-
-	sleep 1
-}
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
new file mode 100755
index 0000000..bd7dcc4
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_buffer_size_kb.sh
@@ -0,0 +1,45 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+LOOP=200
+
+# Use up to 10% of free memory
+free_mem=`cat /proc/meminfo | grep '^MemFree' | awk '{ print $2 }'`
+cpus=`tst_ncpus`
+
+step=$(( $free_mem / 10 / $LOOP / $cpus ))
+
+if [ $step -eq 0 ]; then
+	step=1
+	LOOP=50
+fi
+
+for ((; ;))
+{
+	new_size=1
+	for ((i = 0; i < $LOOP; i++))
+	{
+		echo $new_size > "$TRACING_PATH"/buffer_size_kb
+		new_size=$(( $new_size + $step ))
+	}
+
+	for ((i = 0; i < $LOOP; i++))
+	{
+		new_size=$(( $new_size - $step ))
+		echo $new_size > "$TRACING_PATH"/buffer_size_kb
+	}
+
+	sleep 1
+}
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
new file mode 100755
index 0000000..9c6162a
--- /dev/null
+++ b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_function_profile_enabled.sh
@@ -0,0 +1,50 @@
+#! /bin/sh
+
+###############################################################################
+#                                                                             #
+# Copyright (c) 2010 FUJITSU LIMITED                                          #
+#                                                                             #
+# This program is free software; you can redistribute it and/or modify it     #
+# under the terms of the GNU General Public License as published by the Free  #
+# Software Foundation; either version 2 of the License, or (at your option)   #
+# any later version.                                                          #
+#                                                                             #
+# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
+#                                                                             #
+###############################################################################
+
+MAX_LOOP=1500
+count=0
+
+if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
+	should_skip=1
+else
+	should_skip=0
+fi
+
+for ((; ;))
+{
+	if [ $should_skip -eq 1 ]; then
+		sleep 2
+		continue
+	fi
+
+	count=$(( $count + 1 ))
+
+	for ((i = 0; i < $MAX_LOOP; i++))
+	{
+		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	}
+
+	enable=$(( $count % 3 ))
+
+	if [ $enable -eq 0 ]; then
+		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	else
+		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
+	fi
+
+	sleep 1
+}
+
diff --git a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh
deleted file mode 100755
index 9c6162a..0000000
--- a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_profile_enabled.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#! /bin/sh
-
-###############################################################################
-#                                                                             #
-# Copyright (c) 2010 FUJITSU LIMITED                                          #
-#                                                                             #
-# This program is free software; you can redistribute it and/or modify it     #
-# under the terms of the GNU General Public License as published by the Free  #
-# Software Foundation; either version 2 of the License, or (at your option)   #
-# any later version.                                                          #
-#                                                                             #
-# Author: Li Zefan <lizf@cn.fujitsu.com>                                      #
-#                                                                             #
-###############################################################################
-
-MAX_LOOP=1500
-count=0
-
-if [ ! -e "$TRACING_PATH"/function_profile_enabled ]; then
-	should_skip=1
-else
-	should_skip=0
-fi
-
-for ((; ;))
-{
-	if [ $should_skip -eq 1 ]; then
-		sleep 2
-		continue
-	fi
-
-	count=$(( $count + 1 ))
-
-	for ((i = 0; i < $MAX_LOOP; i++))
-	{
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	}
-
-	enable=$(( $count % 3 ))
-
-	if [ $enable -eq 0 ]; then
-		echo 1 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	else
-		echo 0 > "$TRACING_PATH"/function_profile_enabled 2> /dev/null
-	fi
-
-	sleep 1
-}
-
-- 
1.8.3.1

