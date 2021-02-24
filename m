From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2021 17:50:44 +0100
Subject: [LTP] [PATCH v2 4/5] Sample hardware discovery and reconfigure
 scripts
In-Reply-To: <20210224165045.17738-1-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
Message-ID: <20210224165045.17738-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is not going to be part of the final patchset.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 hardware-discovery.sh   | 36 ++++++++++++++++++++++++++++++++++++
 hardware-reconfigure.sh |  3 +++
 2 files changed, 39 insertions(+)
 create mode 100755 hardware-discovery.sh
 create mode 100755 hardware-reconfigure.sh

diff --git a/hardware-discovery.sh b/hardware-discovery.sh
new file mode 100755
index 000000000..2d1eeefaa
--- /dev/null
+++ b/hardware-discovery.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+if [ "$1" = "UART-loopback" ]; then
+	echo '{'
+	echo ' "reconfigure": "hardware-reconfigure.sh",'
+	echo ' "hwconfs": ['
+	echo '  {'
+	echo '   "uid": "ttyUSB0-ttyUSB0-01",'
+	echo '   "tx": "/dev/ttyUSB0",'
+	echo '   "rx": "/dev/ttyUSB0",'
+	echo '   "hwflow": 0,'
+	echo '   "baud_rates": ['
+	echo '    4800,'
+	echo '    9600,'
+	echo '    19200'
+	echo '   ]'
+	echo '  },'
+	echo '  {'
+	echo '   "uid": "ttyUSB0-ttyUSB0-02",'
+	echo '   "tx": "/dev/ttyUSB0",'
+	echo '   "rx": "/dev/ttyUSB0",'
+	echo '   "hwflow": 1,'
+	echo '   "baud_rates": ['
+	echo '    4800,'
+	echo '    9600,'
+	echo '    19200'
+	echo '   ]'
+	echo '  }'
+	echo ' ]'
+	echo '}'
+
+	exit 0
+fi
+
+echo '{}'
+exit 0
diff --git a/hardware-reconfigure.sh b/hardware-reconfigure.sh
new file mode 100755
index 000000000..079f6588a
--- /dev/null
+++ b/hardware-reconfigure.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+echo "Reconfigure '$@'"
-- 
2.26.2

