Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1NRoFO-0006xq-PE
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 14:49:30 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRoFN-0007I3-9K
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 14:49:30 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id o04EDQIK015460
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 01:13:26 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o04EBwa41528016
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 01:11:58 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o04EGGK7023104
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 01:16:16 +1100
Received: from [9.124.46.98] ([9.124.46.98])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o04EGFeq022006
	for <ltp-list@lists.sourceforge.net>; Tue, 5 Jan 2010 01:16:16 +1100
Message-ID: <4B41F7FD.9040904@in.ibm.com>
Date: Mon, 04 Jan 2010 19:45:25 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070301000704050308010004"
Subject: [LTP] [PATCH] Fix ld01 test
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070301000704050308010004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please find the patch to fix the "ld" test.  I wonder these tests were 
ever tested before committing to the suite !

On SLES 11 SP1, I get :

plm66:/ltp-full-20091130/testcases/commands/ade/ld # make
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC 
-I../../../../include -I../../../../include  -c -o d1.o d1.c
mv d1.o d1.obj
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC 
-I../../../../include -I../../../../include  -c -o f1.o f1.c
mv f1.o f1.obj
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC 
-I../../../../include -I../../../../include  -c -o ldmain.o ldmain.c
mv ldmain.o ldmain.obj
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC 
-I../../../../include -I../../../../include  -c -o rd1.o rd1.c
mv rd1.o rd1.obj
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC 
-I../../../../include -I../../../../include  -c -o rf1.o rf1.c
mv rf1.o rf1.obj
plm66:/ltp-full-20091130/testcases/commands/ade/ld # ./ld01
Assertion 1 ..................
-)
Assertion 2 ..................
-)
Assertion 3 ..................
-)
Assertion 4 ..................
-)
Assertion 5 ..................
ld: /ltp-full-20091130/testcases/commands/ade/ld/f1.o: No such file: No 
such file or directory
FAIL - ld failed to build a shared object


The names used for the object files are not consistent across the 
Makefile and the script.

Also the method of detecting the ld version is bogus. It will not work 
for *all* distros.

./ld01: line 184: [: Public: integer expression expected
-)


Please find the attached patch which fixes the issue.

Thanks
Suzuki

--------------070301000704050308010004
Content-Type: text/plain;
 name="fix-ld01-script.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-ld01-script.diff"

Signed-Off-by: Suzuki K P <suzuki@in.ibm.com>

Issues fixed:

	1) Consistency with the names used for object files in Makefile vs. script
	2) Better method for finding the version of "ld"

--- ld01	2006-04-10 23:09:50.000000000 +0530
+++ ld01.new	2010-01-05 01:01:03.000000000 +0530
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
@@ -164,23 +164,29 @@ fi
 echo "Assertion 6 .................."
 
 # Check for ppc64 architecture
- file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
+ file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
  if [ $? -eq 0 ]; then
-	ld -m elf64ppc -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola 2>$TCtmp/errmsg.out
-	ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
+	ld -m elf64ppc -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/lola 2>$TCtmp/errmsg.out
+	ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
  else
-	ld -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola 2>$TCtmp/errmsg.out
-	ld -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
+	ld -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/lola 2>$TCtmp/errmsg.out
+
+	ld -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
  fi
 #nm $TCtmp/a.out | grep -q DYNAMIC
 rc_code=$?
 
-	version_num=`ld --version | grep version | \
-	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
-
-	version_num_level2=`ld --version | grep version |\
-	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
-
+#	This method doesn't work on all distro. 
+#	version_num=`ld --version | grep version | \
+#	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
+#
+#	version_num_level2=`ld --version | grep version |\
+#	 awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
+#
+# Better way to get the version of ld
+# Search for a pattern that starts with <SPACE><DIGITS><DOT><DIGITS> 
+version_num=`ld -v | sed "s/.*\ \([0-9]\+\)\.\([0-9]\+\).*/\1/"`
+version_num_level2=`ld -v | sed "s/.*\ \([0-9]\+\)\.\([0-9]\+\).*/\2/"`
 if [ "$version_num" -le "2"  -a "$version_num_level2" -le "15" ]; then
 	if [ $rc_code -eq 0 ]
 	then
@@ -214,8 +220,8 @@ if [ "$version_num" -le "2"  -a "$versio
 
 
 echo "Assertion 7 .................."
-ld -Bdynamic -shared $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o -o $TCtmp/lola -L/usr/lib/ 
-ld -Bstatic -r  $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o $TCtmp/lola -L/usr/lib/ 2> $TCtmp/errmsg.out
+ld -Bdynamic -shared $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj -o $TCtmp/lola -L/usr/lib/ 
+ld -Bstatic -r  $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj $TCtmp/lola -L/usr/lib/ 2> $TCtmp/errmsg.out
 cat <<EOF > $TCtmp/errmsg.exp
 $TCtmp/lola: could not read symbols: Invalid operation
 EOF

--------------070301000704050308010004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--------------070301000704050308010004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070301000704050308010004--

