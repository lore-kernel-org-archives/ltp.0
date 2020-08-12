From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Wed, 12 Aug 2020 15:35:28 +0800
Subject: [LTP] [PATCH 1/2] device-discovery: auto detect UART_DEV devices
 for uart case
Message-ID: <20200812073529.25715-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

update device-discovery scripts for uart device, it will auto detect
the test machine uart devices, and filtered out of the on using dev.
This is an updated version which comes from patch [1] written by Cyril

[1] https://patchwork.ozlabs.org/project/ltp/patch/20200623112827.10744-2-chrubis@suse.cz/

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 device-discovery.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/device-discovery.sh b/device-discovery.sh
index 08460c41f..09993be36 100755
--- a/device-discovery.sh
+++ b/device-discovery.sh
@@ -1,5 +1,20 @@
 #!/bin/sh
 
-if [ "$1" = "UART_RX-UART_TX" ]; then
-	echo "UART_RX=/dev/ttyUSB0 UART_TX=/dev/ttyUSB0"
+find_uart_devices()
+{
+	UART_DEVICE=""
+	for i in /dev/tty*; do
+		TTY_DEVICES=`echo $i |grep "tty[[:alpha:]]\{1,\}[0-9]\{1,\}"`
+		if [ -n "${TTY_DEVICES}" ];then
+			if ( stty -a -F ${TTY_DEVICES} > /dev/null 2>&1 ) ;then
+				lsof | grep "${TTY_DEVICES}" 1>/dev/null 2>&1 || \
+				UART_DEVICE="${TTY_DEVICES} ${UART_DEVICE}"
+			fi
+		fi
+	done
+	echo "UART_DEV=${UART_DEVICE}"
+}
+
+if [ "$1" = "UART_DEV" ]; then
+	find_uart_devices
 fi
-- 
2.17.1

