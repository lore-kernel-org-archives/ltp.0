Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1NKsBz-0005TF-I1
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:19 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKsBt-0004ln-9x
	for ltp-list@lists.sourceforge.net; Wed, 16 Dec 2009 11:37:19 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 07B5B170145
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:37:06 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id nBGBb5fR026794
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Dec 2009 19:37:05 +0800
Received: from localhost.localdomain (unknown [10.167.141.167])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 4CFD2D45B6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Dec 2009 19:37:27 +0800 (CST)
Message-ID: <4B28C695.5040705@cn.fujitsu.com>
Date: Wed, 16 Dec 2009 19:37:57 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] ade: fix the bug of ld/ldd/nm
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

According to case ld, ldd and nm's Makefile, 
s/*.o/*.obj/

This patch fixed these

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>

---
 testcases/commands/ade/ld/ld01   |   62 +++++++++++++++++++-------------------
 testcases/commands/ade/ldd/ldd01 |   24 +++++++-------
 testcases/commands/ade/nm/nm01   |    7 ++--
 3 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/testcases/commands/ade/ld/ld01 b/testcases/commands/ade/ld/ld01
index 0e6ad36..ef9ca8b 100755
--- a/testcases/commands/ade/ld/ld01
+++ b/testcases/commands/ade/ld/ld01
@@ -49,13 +49,13 @@ mkdir $TCtmp
 #
 #CODE
 	echo "Assertion 1 .................."
-	/usr/bin/ld x.o y.o 2> $TCtmp/errmsg.out
+	/usr/bin/ld x.obj y.obj 2> $TCtmp/errmsg.obj
 #cat <<EOF > $TCtmp/errmsg.exp
-#/usr/bin/ld: cannot open x.o: No such file or directory
+#/usr/bin/ld: cannot open x.obj: No such file or directory
 #EOF
 
-#diff -iw  $TCtmp/errmsg.out $TCtmp/errmsg.exp
-cat $TCtmp/errmsg.out |grep "/usr/bin/ld:" | grep [xy].o | grep -q "No such file or directory"
+#diff -iw  $TCtmp/errmsg.obj $TCtmp/errmsg.exp
+cat $TCtmp/errmsg.obj |grep "/usr/bin/ld:" | grep [xy].obj | grep -q "No such file or directory"
 if [ $? -eq 0 ]
 then
 	echo  "-)"
@@ -72,14 +72,14 @@ fi
 #
 #CODE
 	echo "Assertion 2 .................."
-	/usr/bin/cc x.o  y.o 2> $TCtmp/errmsg.out
+	/usr/bin/cc x.obj  y.obj 2> $TCtmp/errmsg.obj
 cat <<EOF > $TCtmp/errmsg.exp
-cc: x.o: No such file or directory
-cc: y.o: No such file or directory
+cc: x.obj: No such file or directory
+cc: y.obj: No such file or directory
 cc: No input files
 EOF
 
-diff -iw  $TCtmp/errmsg.out $TCtmp/errmsg.exp
+diff -iw  $TCtmp/errmsg.obj $TCtmp/errmsg.exp
 if [ $? -eq 0 ]
 then
 	echo  "-)"
@@ -96,13 +96,13 @@ fi
 #
 #CODE
 	echo "Assertion 3 .................."
-	/usr/bin/ld bad/x.o 2> $TCtmp/errmsg.out
+	/usr/bin/ld bad/x.obj 2> $TCtmp/errmsg.obj
 #cat <<EOF > $TCtmp/errmsg.exp
-#/usr/bin/ld: cannot open bad/x.o: No such file or directory
+#/usr/bin/ld: cannot open bad/x.obj: No such file or directory
 #EOF
-cat $TCtmp/errmsg.out | grep "/usr/bin/ld:" | grep "bad/[xy].o:" | grep -q "No such file or directory"
+cat $TCtmp/errmsg.obj | grep "/usr/bin/ld:" | grep "bad/[xy].obj:" | grep -q "No such file or directory"
 
-#diff -iw  $TCtmp/errmsg.out $TCtmp/errmsg.exp
+#diff -iw  $TCtmp/errmsg.obj $TCtmp/errmsg.exp
 if [ $? -eq 0 ]
 then
 	echo  "-)"
@@ -119,13 +119,13 @@ fi
 #
 #CODE
 	echo "Assertion 4 .................."
-	/usr/bin/cc bad/x.o 2> $TCtmp/errmsg.out
+	/usr/bin/cc bad/x.obj 2> $TCtmp/errmsg.obj
 cat <<EOF > $TCtmp/errmsg.exp
-cc: bad/x.o: No such file or directory
+cc: bad/x.obj: No such file or directory
 cc: No input files
 EOF
 
-diff -iw  $TCtmp/errmsg.out $TCtmp/errmsg.exp
+diff -iw  $TCtmp/errmsg.obj $TCtmp/errmsg.exp
 if [ $? -eq 0 ]
 then
 	echo  "-)"
@@ -140,11 +140,11 @@ fi
 ##
 echo "Assertion 5 .................."
  # Check for ppc64 architecture
- file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
+ file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
  if [ $? -eq 0 ]; then
-	ld -m elf64ppc -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/test.lib
+	ld -m elf64ppc -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/test.lib
  else
-	ld -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/test.lib
+	ld -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/test.lib
  fi
 file $TCtmp/test.lib | grep -q shared
 if [ $? -eq 0 ]
@@ -164,21 +164,21 @@ fi
 echo "Assertion 6 .................."
 
 # Check for ppc64 architecture
- file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
+ file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
  if [ $? -eq 0 ]; then
-	ld -m elf64ppc -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola 2>$TCtmp/errmsg.out
-	ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
+	ld -m elf64ppc -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/lola 2>$TCtmp/errmsg.obj
+	ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/lola -o $TCtmp/a.obj 2> $TCtmp/errmsg.obj
  else
-	ld -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola 2>$TCtmp/errmsg.out
-	ld -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
+	ld -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/lola 2>$TCtmp/errmsg.obj
+	ld -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/lola -o $TCtmp/a.obj 2> $TCtmp/errmsg.obj
  fi
-#nm $TCtmp/a.out | grep -q DYNAMIC
+#nm $TCtmp/a.obj | grep -q DYNAMIC
 rc_code=$?
 
-	version_num=`ld --version | grep version | \
+	version_num=`ld --version | grep version | grep ld |\
 	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
-
-	version_num_level2=`ld --version | grep version |\
+	
+	version_num_level2=`ld --version | grep version | grep ld |\
 	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
 
 if [ "$version_num" -le "2"  -a "$version_num_level2" -le "15" ]; then
@@ -214,15 +214,15 @@ if [ "$version_num" -le "2"  -a "$version_num_level2" -le "15" ]; then
 
 
 echo "Assertion 7 .................."
-ld -Bdynamic -shared $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o -o $TCtmp/lola -L/usr/lib/ 
-ld -Bstatic -r  $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o $TCtmp/lola -L/usr/lib/ 2> $TCtmp/errmsg.out
+ld -Bdynamic -shared $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj -o $TCtmp/lola -L/usr/lib/ 
+ld -Bstatic -r  $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj $TCtmp/lola -L/usr/lib/ 2> $TCtmp/errmsg.obj
 cat <<EOF > $TCtmp/errmsg.exp
 $TCtmp/lola: could not read symbols: Invalid operation
 EOF
 
-grep -q  "could not read symbols: Invalid operation" $TCtmp/errmsg.out
+grep -q  "could not read symbols: Invalid operation" $TCtmp/errmsg.obj
 rc_grep=$?
-grep -q "ld: attempted static link of dynamic object" $TCtmp/errmsg.out
+grep -q "ld: attempted static link of dynamic object" $TCtmp/errmsg.obj
 if [ $rc_grep -eq 0  -o $? -eq 0 ]; then 
 	echo "-)"
 else
diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
index ba7dc41..cdce0a0 100755
--- a/testcases/commands/ade/ldd/ldd01
+++ b/testcases/commands/ade/ldd/ldd01
@@ -47,19 +47,19 @@ mkdir $TCtmp
 # Check for ppc64 architecture
 file lddfile1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
 if [ $? -eq 0 ]; then
-  cc -m64 -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.o
-  cc -m64 -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.o
-  cc -m64 -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.o
-  cc -m64 -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.o
-  cc -m64 -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.o
-  cc -m64 -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.o
+  cc -m64 -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.obj
+  cc -m64 -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.obj
+  cc -m64 -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.obj
+  cc -m64 -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.obj
+  cc -m64 -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.obj
+  cc -m64 -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.obj
 else
-  cc -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.o
-  cc -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.o
-  cc -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.o
-  cc -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.o
-  cc -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.o
-  cc -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.o
+  cc -shared -o $TCtmp/lddfile1.o.so $TCdat/lddfile1.obj
+  cc -shared -o $TCtmp/lddfile2.o.so $TCdat/lddfile2.obj
+  cc -shared -o $TCtmp/lddfile3.o.so $TCdat/lddfile3.obj
+  cc -shared -o $TCtmp/lddfile4.o.so $TCdat/lddfile4.obj
+  cc -shared -o $TCtmp/lddfile5.o.so $TCdat/lddfile5.obj
+  cc -O -o $TCtmp/a.out $TCtmp/lddfile*.o.so $TCdat/main.obj
 fi
 } 
 
diff --git a/testcases/commands/ade/nm/nm01 b/testcases/commands/ade/nm/nm01
index dccc922..1ba3b35 100755
--- a/testcases/commands/ade/nm/nm01
+++ b/testcases/commands/ade/nm/nm01
@@ -58,7 +58,8 @@ while [ $LOOP -gt 0 ]
 do
 echo "-------System test for nm command------"
 cd $TCdat
-ar -cr $TCtmp/lib.a nmfile1.o nmfile1.o nmfile2.o nmfile3.o
+#ar -cr $TCtmp/lib.a nmfile1.o nmfile1.o nmfile2.o nmfile3.o
+ar -cr $TCtmp/lib.a nmfile1.obj nmfile1.obj nmfile2.obj nmfile3.obj
 
 # -A  Displays either the full path name or library name of an object
 # on each line.                   
@@ -69,10 +70,10 @@ RC2=0
 
 mkdir -p $TCtmp/a/b/c/d
 
-nm -f posix -A $TCtmp/lib.a | grep "$TCtmp/lib.a\[nmfile2.o\]\:" 2>&1 1>/dev/null
+nm -f posix -A $TCtmp/lib.a | grep "$TCtmp/lib.a\[nmfile2.obj\]\:" 2>&1 1>/dev/null
 RC1=$? 
 cp $TCtmp/lib.a $TCtmp/a/b/c/d/
-nm -f posix -A $TCtmp/a/b/c/d/lib.a | grep "$TCtmp/a/b/c/d/lib.a\[nmfile2.o\]\:"  2>&1 1>/dev/null
+nm -f posix -A $TCtmp/a/b/c/d/lib.a | grep "$TCtmp/a/b/c/d/lib.a\[nmfile2.obj\]\:"  2>&1 1>/dev/null
 RC2=$? 
 
 
-- 
1.6.2.2





------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
