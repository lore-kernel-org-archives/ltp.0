From: Lachlan Sneff <t-josne@linux.microsoft.com>
Date: Thu,  2 Jul 2020 11:35:45 -0400
Subject: [LTP] [PATCH 2/2] IMA: Verify IMA buffer passing through the kexec
 barrier
In-Reply-To: <20200702153545.3126-1-t-josne@linux.microsoft.com>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
Message-ID: <20200702153545.3126-3-t-josne@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a testcase that verifies that kexec correctly passes
the IMA buffer through the soft reboot.

This test must be run standalone, since it runs kexec.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 testcases/kexec/README.md     |  4 ++++
 testcases/kexec/ima_buffer.sh | 42 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100755 testcases/kexec/ima_buffer.sh

diff --git a/testcases/kexec/README.md b/testcases/kexec/README.md
index 42988cd7b..f4018387e 100644
--- a/testcases/kexec/README.md
+++ b/testcases/kexec/README.md
@@ -24,3 +24,7 @@ Running
 - kexec cmdline measurement
     1. `IMAGE=<path to kernel image> testcases/kexec/cmdline.sh start`
     2. Runtime logs will be emitted in `testcases/kexec/kexec_cmdline.log`.
+
+- kexec ima buffer passing
+    1. `IMAGE=<path to kernel image> testcases/kexec/ima_buffer.sh start`
+    2. Runtime logs will be emitted in `testcases/kexec/kexec_ima_buffer.log`.
diff --git a/testcases/kexec/ima_buffer.sh b/testcases/kexec/ima_buffer.sh
new file mode 100755
index 000000000..3ce661236
--- /dev/null
+++ b/testcases/kexec/ima_buffer.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+ASCII_MEASUREMENTS="/sys/kernel/security/integrity/ima/ascii_runtime_measurements"
+SCRIPT_DIR="$(dirname $(realpath $0))"
+IMAGE=$(realpath "${IMAGE:-$SCRIPT_DIR/Image}")
+LOG_FILE="$SCRIPT_DIR/kexec_ima_buffer.log"
+
+. $SCRIPT_DIR/utils.sh
+
+must_be_root
+on_correct_machine
+
+case $1 in
+    start)
+        # Start the state machine
+        cp $ASCII_MEASUREMENTS /etc/saved-ima-buffer
+
+        install 1
+        if ! kexec -s $IMAGE --reuse-cmdline; then
+            echo "kexec failed: $?" >> $LOG_FILE
+        fi
+        ;;
+    1)
+        update-rc.d resume-after-kexec remove
+        rm /etc/init.d/resume-after-kexec
+
+        n_lines=$(wc -l /etc/saved-ima-buffer | cut -d' ' -f1)
+        if cat $ASCII_MEASUREMENTS | \
+            head -n $n_lines | \
+            cmp -s - /etc/saved-ima-buffer
+        then
+            echo "test succeeded" > $LOG_FILE
+        else
+            echo "test failed" > $LOG_FILE
+        fi
+
+        rm /etc/saved-ima-buffer
+        ;;
+    *)
+        echo "You must run '$0 start' to begin the test"
+        ;;
+esac
-- 
2.25.1

