Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XS5Z9-0000LU-V3
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:41:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XS5Z8-0006tX-8M
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 14:41:43 +0000
Message-ID: <5411B499.8020309@redhat.com>
Date: Thu, 11 Sep 2014 16:41:29 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <20140911022709.GA16027@localhost.localdomain>
In-Reply-To: <20140911022709.GA16027@localhost.localdomain>
Content-Type: multipart/mixed; boundary="------------090609060402060000090703"
Subject: Re: [LTP] [PATCH] ldd01: using 'ppc' to check powerpc arch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, Han Pingtian <hanpt@linux.vnet.ibm.com>

This is a multi-part message in MIME format.
--------------090609060402060000090703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 09/11/2014 04:27 AM, Han Pingtian wrote:
> Hello,
> The ldd01 always failed on some powerpc systems of ours. I have figured
> out a patch. Please take a look. Thanks in advance.
> 
> 
> On some powerpc system, the 'uname -a' doesn't show 'powerpc' but will
> show 'ppc'. So we need using it to check the powerpc arch.
> 
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>  testcases/commands/ade/ldd/ldd01 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
> index c60d3ac..569902e 100755
> --- a/testcases/commands/ade/ldd/ldd01
> +++ b/testcases/commands/ade/ldd/ldd01
> @@ -47,7 +47,7 @@ do_setup()
>  	mkdir $TCtmp
>  
>  	# Check for ppc64 architecture or x86_64 architecture
> -	if uname -a | grep -iq powerpc; then
> +	if uname -a | grep -iq 'ppc\|powerpc'; then
>  		file lddfile1.obj | grep 64-bit >/dev/null 2>&1
>  		if [ $? -eq 0 ]; then
>  			CFLAGS="-m64"


Hi,

what is the purpose of those -m32/-m64 flags in this test?
Can't we just compile it with LTP makefiles using whatever CFLAGS
were passed to configure?

Would you be willing to try attached patch, which moves the build
of .so and a.out into Makefile? I have tested it on x86 with and
without -m32 and it worked fine. Or alternatively, can you describe
the ppc system where this is failing, so I could try to reproduce
it myself?

Regards,
Jan





--------------090609060402060000090703
Content-Type: text/x-patch;
 name="0001-v1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-v1.patch"

From 1ea966268e7a55f21d9254b62462d4adb40c7a0a Mon Sep 17 00:00:00 2001
Message-Id: <1ea966268e7a55f21d9254b62462d4adb40c7a0a.1410445852.git.jstancek@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 Sep 2014 14:57:37 +0200
Subject: [PATCH] v1

---
 testcases/commands/ade/ldd/Makefile   |   13 +++++++++++--
 testcases/commands/ade/ldd/ldd01      |   28 ++++------------------------
 testcases/commands/ade/ldd/lddfile1.c |    2 +-
 testcases/commands/ade/ldd/lddfile2.c |    2 +-
 testcases/commands/ade/ldd/lddfile3.c |    2 +-
 testcases/commands/ade/ldd/lddfile4.c |    2 +-
 testcases/commands/ade/ldd/lddfile5.c |    2 +-
 7 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/testcases/commands/ade/ldd/Makefile b/testcases/commands/ade/ldd/Makefile
index eae06cd..7119290 100644
--- a/testcases/commands/ade/ldd/Makefile
+++ b/testcases/commands/ade/ldd/Makefile
@@ -28,9 +28,18 @@ CPPFLAGS		+= -fpic
 
 INSTALL_TARGETS		:= ldd01
 
-MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
+LDD_C_FILES		:= $(wildcard $(abs_srcdir)/lddfile*.c)
+LDD_SO_FILES		:= $(patsubst $(abs_srcdir)/%.c,%.obj.so,$(LDD_C_FILES))
+MAKE_TARGETS		:= $(LDD_SO_FILES) lddfile.out
+CLEAN_TARGETS		+= *.obj
 
-$(MAKE_TARGETS): %.obj: %.o
+%.obj: %.o
 	mv $^ $@
 
+%.obj.so: %.obj
+	$(CC) $(CFLAGS) -shared -o $@ $^
+
+lddfile.out: main.obj $(LDD_SO_FILES)
+	$(CC) $(CFLAGS) -O -o $@ $(LDD_SO_FILES) main.obj
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
index c60d3ac..54188f7 100755
--- a/testcases/commands/ade/ldd/ldd01
+++ b/testcases/commands/ade/ldd/ldd01
@@ -35,42 +35,22 @@ $trace_logic
 CC=${CC:=gcc}
 LDD=${LDD:=ldd}
 TCdat=${TCdat:-`pwd`}
-TCtmp=${TCtmp:-/tmp/ldd01-$$}
 
 do_cleanup()
 {
-	rm -rf $TCtmp
+	:
 }
 
 do_setup()
 {
-	mkdir $TCtmp
-
-	# Check for ppc64 architecture or x86_64 architecture
-	if uname -a | grep -iq powerpc; then
-		file lddfile1.obj | grep 64-bit >/dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			CFLAGS="-m64"
-		fi
-	elif uname -a | grep -iq x86_64; then
-		file lddfile1.obj | grep 32-bit >/dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			CFLAGS="-m32"
-		fi
-	fi
-	$CC $CFLAGS -shared -o $TCtmp/lddfile1.obj.so $TCdat/lddfile1.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile2.obj.so $TCdat/lddfile2.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile3.obj.so $TCdat/lddfile3.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile4.obj.so $TCdat/lddfile4.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile5.obj.so $TCdat/lddfile5.obj
-	$CC $CFLAGS -O -o $TCtmp/a.out $TCtmp/lddfile*.obj.so $TCdat/main.obj
+	:
 }
 
 do_test()
 {
 	echo "  ASSERTION 1  "
 
-	$LDD $TCtmp/a.out | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
+	$LDD lddfile.out | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
 	if [ $? -eq 0 ]; then
 		echo "ASSERTION #1 PASS"
 	else
@@ -81,7 +61,7 @@ do_test()
 
 	echo " ASSERTION 2  "
 
-	$LDD -v $TCtmp/a.out | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
+	$LDD -v lddfile.out | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
 	if [ $? -eq 0 ]; then
 		echo "ASSERTION #2 PASS"
 	else
diff --git a/testcases/commands/ade/ldd/lddfile1.c b/testcases/commands/ade/ldd/lddfile1.c
index 377f7a3..ccb5786 100644
--- a/testcases/commands/ade/ldd/lddfile1.c
+++ b/testcases/commands/ade/ldd/lddfile1.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
-void file1()
+void file1(void)
 {
 	printf("Control in function %s\n", __func__);
 }
diff --git a/testcases/commands/ade/ldd/lddfile2.c b/testcases/commands/ade/ldd/lddfile2.c
index 5fd2b4b..20aede3 100644
--- a/testcases/commands/ade/ldd/lddfile2.c
+++ b/testcases/commands/ade/ldd/lddfile2.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
-void file2()
+void file2(void)
 {
 	printf("Control in function %s\n", __func__);
 }
diff --git a/testcases/commands/ade/ldd/lddfile3.c b/testcases/commands/ade/ldd/lddfile3.c
index d6b4cc9..a4529f7 100644
--- a/testcases/commands/ade/ldd/lddfile3.c
+++ b/testcases/commands/ade/ldd/lddfile3.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
-void file3()
+void file3(void)
 {
 	printf("Control in function %s\n", __func__);
 }
diff --git a/testcases/commands/ade/ldd/lddfile4.c b/testcases/commands/ade/ldd/lddfile4.c
index 1db89bb..9dc339d 100644
--- a/testcases/commands/ade/ldd/lddfile4.c
+++ b/testcases/commands/ade/ldd/lddfile4.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
-void file4()
+void file4(void)
 {
 	printf("Control in function %s\n", __func__);
 }
diff --git a/testcases/commands/ade/ldd/lddfile5.c b/testcases/commands/ade/ldd/lddfile5.c
index 2f46cdb..3fbb7f6 100644
--- a/testcases/commands/ade/ldd/lddfile5.c
+++ b/testcases/commands/ade/ldd/lddfile5.c
@@ -1,5 +1,5 @@
 #include <stdio.h>
-void file5()
+void file5(void)
 {
 	printf("Control in function %s\n", __func__);
 }
-- 
1.7.1


--------------090609060402060000090703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
--------------090609060402060000090703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090609060402060000090703--

