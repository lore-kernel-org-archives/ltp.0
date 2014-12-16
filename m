Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1Y0tDn-0004Nt-Er
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 14:35:31 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Y0tDm-0000CK-CV
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 14:35:31 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Tue, 16 Dec 2014 15:34:57 +0100
Message-ID: <1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] ltp: Fix cross-compile issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Compilation included the flag "-I/usr/include/tirpc" which ignores sysroot.
This makes a cross-compile to suddenly use host files rather than the files
installed in the compiler sysroot.

By prepending path with "=", the "=" will be replaced with the sysroot path.

Example of error in a Yocto build of ltp:

arm-enea-linux-gnueabi-gcc  -march=armv7-a -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed --sysroot=/media/data/fb/mlil/yocto-builds/build-keystone-evm-nohzfull/tmp/sysroots/keystone-evm -O2 -pipe -g -feliminate-unused-debug-types -g -O2 -fno-strict-aliasing -pipe -Wall -W  -O2 -pipe -g -feliminate-unused-debug-types -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/usr/include/tirpc -I/media/data/fb/mlil/yocto-builds/build-keystone-evm-nohzfull/tmp/work/armv7a-vfp-neon-enea-linux-gnueabi/ltp/20140508-r32/git/testcases/network/rpc/rpc-tirpc/tests_pack/lib -pthread -I../../../../../../../../include -I../../../../../../../../include -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed  -L/media/data/fb/mlil/yocto-builds/build-keystone-evm-nohzfull/tmp/work/armv7a-vfp-neon-enea-linux-gnueabi/ltp/20140508-r32/git/testcases/network/rpc/rpc-tirpc/tests_pack/lib -L../../../../../../../../lib  rpc_get_myaddress.c   -ltirpc -lrpc-tirpc -o rpc_get_myaddress
cc1: warning: include location "/usr/include/tirpc" is unsafe for cross-compilation [-Wpoison-system-directories]
make

Signed-off-by: Mats Liljegren <mats.liljegren@enea.com>
---
 include/mk/config.mk.default | 2 +-
 m4/ltp-tirpc.m4              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index c20f901..462ddcf 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -42,7 +42,7 @@ YACC			:= bison -y
 #NUMA_CPPFLAGS		:= -DNUMA_VERSION1_COMPATIBILITY
 #NUMA_LIBS		:= -lnuma
 #SELINUX_LIBS		:= -lselinux
-#TIRPC_CPPFLAGS		:= -I/usr/include/tirpc
+#TIRPC_CPPFLAGS		:= -I=/usr/include/tirpc
 #TIRPC_LIBS		:= -ltirpc
 
 prefix			:= /opt/ltp
diff --git a/m4/ltp-tirpc.m4 b/m4/ltp-tirpc.m4
index 73fde51..f4df239 100644
--- a/m4/ltp-tirpc.m4
+++ b/m4/ltp-tirpc.m4
@@ -25,7 +25,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
 	TIRPC_LIBS=""
 
 	AC_CHECK_HEADER(tirpc/netconfig.h,[
-		TIRPC_CPPFLAGS="-I/usr/include/tirpc"
+		TIRPC_CPPFLAGS="-I=/usr/include/tirpc"
 		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers installed])
 		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS="-ltirpc"])])
 
-- 
1.9.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
