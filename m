From: Yixin Zhang <yixin.zhang@intel.com>
Date: Mon,  4 Jun 2018 14:33:06 +0800
Subject: [LTP] [PATCH ltp] m4/ltp-kernel_devel.m4: get LINUX_VERSION from
	LINUX_DIR during configure
Message-ID: <20180604063306.24325-1-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If LINUX_DIR is given, get LINUX_VERSION for kernel source code instead
of `uname -r`. So when we need to build .ko with a kernel differernt
than the one on current host PC, we only need to provide
"--with-linux-dir", and LINUX_VERSION will be generated automatically.

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 m4/ltp-kernel_devel.m4 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
index 1c4e71f73..477a34aa9 100644
--- a/m4/ltp-kernel_devel.m4
+++ b/m4/ltp-kernel_devel.m4
@@ -47,6 +47,7 @@ AC_ARG_WITH([linux-dir],
 AC_SUBST(LINUX_DIR)
 
 if test -f "$LINUX_DIR/Makefile"; then
+	LINUX_VERSION=`make -C ${LINUX_DIR} -s kernelversion`
 	LINUX_VERSION_MAJOR=`make -C ${LINUX_DIR} -s kernelversion | cut -d. -f1`
 	LINUX_VERSION_PATCH=`make -C ${LINUX_DIR} -s kernelversion | cut -d. -f2`
 fi
-- 
2.14.1

