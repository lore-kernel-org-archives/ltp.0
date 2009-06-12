Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MF6hG-0007eO-Qk
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:21:30 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MF6hD-00062f-VR
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 13:21:29 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2009 18:51:12 +0530
Message-Id: <20090612132112.32049.92495.sendpatchset@subratamodak.linux.ibm.com>
Subject: [LTP] [PATCH] Add preadv01 test for preadv() and pwritev() syscall
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ltp-list <ltp-list@lists.sf.net>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Al Viro <viro@zeniv.linux.org.uk>

>On Fri, 2009-06-12 at 08:37 +0200, Gerd Hoffmann wrote:
>On 06/12/09 04:53, Subrata Modak wrote:
> > Hi Gerd,
> >
> > Thanks for writing preadv/pwritev syscalls for linux-2.6.30. We would
> > like to include your test code (hosted at:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dac1213842f5caf081804a11d87d2a39a21d6f55) to be included in our Linux Test Project (http://ltp.sf.net) under GPLv2.
> 
> Fine with me.
> 
> Note that there was an ABI change 
> (http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=601cc11d054ae4b5e9b5babec3d8e4667a2cb9b5), 
> so the test program needs adaptions to the final ABI present in 2.6.30.

Ok. Great. Here is the patch which will integrate your test to LTP.

Signed-off-by: Subrata Modak <subrata@linux.vnet.ibm.com>
Original-author-and-copyright-holder: Gerd Hoffmann <kraxel@redhat.com>

To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: ltp-list <ltp-list@lists.sf.net>
---

--- ltp-full-20090531.orig/testcases/kernel/syscalls/preadv/Makefile	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090531/testcases/kernel/syscalls/preadv/Makefile	2009-06-12 18:31:37.000000000 +0530
@@ -0,0 +1,31 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2009
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+
+CFLAGS += -I../../../../include -Wall -O2
+LDLIBS += -L../../../../lib -lltp
+
+SRCS    = $(wildcard *.c)
+TARGETS += $(patsubst %.c,%,$(SRCS))
+
+all: $(TARGETS)
+
+install:
+	@set -e; for i in $(TARGETS); do ln -f $$i ../../../bin/$$i ; done
+
+clean:
+	rm -f $(TARGETS)
--- ltp-full-20090531.orig/testcases/kernel/syscalls/preadv/preadv01.c	1970-01-01 05:30:00.000000000 +0530
+++ ltp-full-20090531/testcases/kernel/syscalls/preadv/preadv01.c	2009-06-12 18:40:26.000000000 +0530
@@ -0,0 +1,113 @@
+/*
+ * Simple test for preadv() and pwritev() syscall introduced in linux-2.6.30
+ *
+ * (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
+ *
+ * Reference: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dac1213842f5caf081804a11d87d2a39a21d6f55
+ * Reference: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=601cc11d054ae4b5e9b5babec3d8e4667a2cb9b5
+ * Reference: http://kernelnewbies.org/LinuxChanges#head-0bf8c8dcb325b9a214be39679c3e2bcca995d05b
+ * Reference: http://marc.info/?t=124477542000004&r=1&w=2&n=2
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <sys/uio.h>
+
+/* ----------------------------------------------------------------- */
+/* syscall windup                                                    */
+
+#include <sys/syscall.h>
+
+#ifndef __NR_preadv
+	#ifdef __i386__
+		#define __NR_preadv  333
+		#define __NR_pwritev 334
+	#endif
+	#ifdef __x86_64__
+		#define __NR_preadv  295
+		#define __NR_pwritev 296
+	#endif
+#endif
+
+char *TCID = "preadv01";     /* test program identifier*/
+
+static ssize_t preadv(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+{
+    uint32_t pos_high = (offset >> 32) & 0xffffffff;
+    uint32_t pos_low  =  offset        & 0xffffffff;
+
+    return syscall(__NR_preadv, fd, iov, iovcnt, pos_high, pos_low);
+}
+
+static ssize_t pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset)
+{
+    uint32_t pos_high = (offset >> 32) & 0xffffffff;
+    uint32_t pos_low  =  offset        & 0xffffffff;
+
+    return syscall(__NR_pwritev, fd, iov, iovcnt, pos_high, pos_low);
+}
+
+/* ----------------------------------------------------------------- */
+/* demo/test app                                                     */
+
+static char filename[] = "/tmp/preadv-XXXXXX";
+static char outbuf[11] = "0123456789";
+static char inbuf[11]  = "----------";
+
+static struct iovec ovec[2] = {{
+        .iov_base = outbuf + 5,
+        .iov_len  = 5,
+    },{
+        .iov_base = outbuf + 0,
+        .iov_len  = 5,
+    }};
+
+static struct iovec ivec[3] = {{
+        .iov_base = inbuf + 6,
+        .iov_len  = 2,
+    },{
+        .iov_base = inbuf + 4,
+        .iov_len  = 2,
+    },{
+        .iov_base = inbuf + 2,
+        .iov_len  = 2,
+    }};
+
+void cleanup(void)
+{
+    unlink(filename);
+}
+
+int main(int argc, char **argv)
+{
+    int fd, rc;
+
+    fd = mkstemp(filename);
+    if (-1 == fd) {
+        perror("mkstemp");
+        exit(1);
+    }
+    atexit(cleanup);
+
+    /* write to file: "56789-01234" */
+    rc = pwritev(fd, ovec, 2, 0);
+    if (rc < 0) {
+        perror("pwritev");
+        exit(1);
+    }
+
+    /* read from file: "78-90-12" */
+    rc = preadv(fd, ivec, 3, 2);
+    if (rc < 0) {
+        perror("preadv");
+        exit(1);
+    }
+
+    printf("result  : %s\n", inbuf);
+    printf("expected: %s\n", "--129078--");
+    exit(0);
+}
+
--- ltp-full-20090531.orig/runtest/syscalls	2009-06-12 18:30:08.000000000 +0530
+++ ltp-full-20090531/runtest/syscalls	2009-06-12 18:41:36.000000000 +0530
@@ -724,6 +724,8 @@ pread02_64 pread02_64
 pread03 pread03
 pread03_64 pread03_64
 
+preadv01 preadv01
+
 profil01 profil01
 
 pselect01 pselect01

---
Regards--
Subrata

> 
> cheers,
>    Gerd
> 

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
