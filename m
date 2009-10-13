Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MxZpu-0001AA-5l
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:22:14 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxZpp-0003wZ-07
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 05:22:14 +0000
Received: by pxi39 with SMTP id 39so9585102pxi.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Oct 2009 22:22:03 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 12 Oct 2009 22:22:02 -0700
Message-ID: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd2e302f3f4590475ca399d
Subject: [LTP] [PATCH] convert linktest.pl to linktest.sh
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
To: LTP list <ltp-list@lists.sourceforge.net>

--000e0cd2e302f3f4590475ca399d
Content-Type: text/plain; charset=ISO-8859-1

This proposed change makes linktest.pl into linktest.sh, to avoid
missing coverage with symlinks and hardlinks due to a lacking perl
dependency on the target host.

This change has been outstanding for some time in our private copy of
LTP and needed to get checked into CVS.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

diff -Naur --exclude '*CVS*' ../ltp.bk/runtest/fs ./runtest/fs
--- ../ltp.bk/runtest/fs        2009-10-12 22:09:12.000000000 -0700
+++ ./runtest/fs        2009-10-12 22:06:10.000000000 -0700
@@ -40,7 +40,7 @@
 iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
-Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$

 fs_inod01 fs_inod $TMP 10 10 10
-linker01 linktest.pl 1000 1000
+linker01 linktest.sh 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
diff -Naur --exclude '*CVS*' ../ltp.bk/runtest/stress.part1
./runtest/stress.part1
--- ../ltp.bk/runtest/stress.part1      2009-10-12 22:09:12.000000000 -0700
+++ ./runtest/stress.part1      2009-10-12 22:06:15.000000000 -0700
@@ -156,7 +156,7 @@
 iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
-Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$

 fs_inod01 fs_inod $TMP 10 10 1
-linker01 linktest.pl
+linker01 linktest.sh
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
diff -Naur --exclude '*CVS*'
../ltp.bk/testcases/kernel/fs/linktest/linktest.pl
./testcases/kernel/fs/linktest/linktest.pl
--- ../ltp.bk/testcases/kernel/fs/linktest/linktest.pl  2009-10-12
22:18:49.000000000 -0700
+++ ./testcases/kernel/fs/linktest/linktest.pl  1969-12-31
16:00:00.000000000 -0800
@@ -1,89 +0,0 @@
-#!/usr/bin/perl
-
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
-
-#
-#  FILE(s)     : linktest.pl README
-#  DESCRIPTION : Regression test for max links per file
-#  USE         : linktest.pl <number of symlinks> <number of hardlinks>
-#  AUTHOR      : Jeff Martin (martinjn@us.ibm.com)
-#  HISTORY     :
-#     (05/07/01)v.99  Needed a quick script to test a hardlink
limitation that was found.
-#     (28/07/08) Veerendra C <vechandr@in.ibm.com>
-#                     Modified to return proper return code on
failure/success.
-#                     Also modified to return errors if unable to
create dir/files
-
-$ret = 0;
-if ( system("mkdir hlink") ) {
-     $ret = -1 ;
-}
-
-if ( system("mkdir slink") ) {
-     $ret = -1 ;
-}
-
-if ( system("touch hlink/hfile") ) {
-     $ret = -1 ;
-}
-
-if ( system("touch slink/sfile") ) {
-     $ret = -1 ;
-}
-
-if ( $ret == -1 ) {
-    printf ("Error %d: Not able to create dir/file's\n " , $ret);
-    exit -1;
-}
-
-$scount=shift @ARGV;
-chdir "slink";
-for($x=0;$x<$scount;$x++) {
-   $result=symlink("sfile","sfile$x");
-   if(!$result) {
-      $serrors++;
-      }
-   }
-chdir "..";
-$hcount=shift @ARGV;
-for($x=0;$x<$hcount;$x++) {
-   $result=link("hlink/hfile","hlink/hfile$x");
-   if(!$result) {
-      $herrors++;
-      }
-   }
-
-if($herrors) {
-    printf ("linker01 : FAIL Hard Link Errors = %d\n", $herrors);
-    $ret = -1
-}
-else {
-    printf ("linker01 : HardLink Test PASS\n" )
-}
-if($serrors) {
-    printf ("linker01 : FAIL Soft Link Errors = %d\n", $serrors);
-    $ret = -1
-}
-else {
-    printf ("linker01 : SoftLink Test PASS\n" );
-}
-
-unlink <hlink/hfile*>;
-unlink <slink/sfile*>;
-rmdir hlink;
-rmdir slink;
-exit $ret;
--- ../ltp.bk/testcases/kernel/fs/linktest/linktest.sh  1969-12-31
16:00:00.000000000 -0800
+++ ./testcases/kernel/fs/linktest/linktest.sh  2009-10-12
22:15:26.000000000 -0700
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+#   Copyright (c) International Business Machines  Corp., 2000
+#
+#   This program is free software;  you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#   the GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program;  if not, write to the Free Software
+#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+
+#
+#  FILE(s)     : linktest.sh README
+#  DESCRIPTION : Regression test for max links per file
+#  USE         : linktest.sh <number of symlinks> <number of hardlinks>
+#  AUTHOR      : Garrett Cooper (yanegomi@gmail.com)
+#  HISTORY     :
+#      A rewrite of testcases/kernel/fs/linktest.pl
+
+# XXX: Change to a temp dir via mktemp -d.
+cd "${0%/*}"
+
+export TCID=linker01
+export TST_TOTAL=2
+export TST_COUNT=1
+
+if [ $# -ne 2 ]; then
+       tst_res TBROK "" "Usage: $0 {softlink count} {hardlink count}"
+       exit -1
+fi
+
+mkdir hlink slink && touch hlink/hfile slink/sfile
+
+do_link() {
+       pfix=$1; shift
+       ln_opts=$1; shift
+       limit=$1; shift
+
+       lerrors=0
+
+       i=0
+
+       cd ${pfix}link; \
+       while [ $i -lt $limit ]; do \
+               if ! ln ${ln_opts} "$PWD/${pfix}file" ${pfix}file${i}; then
+                       (( lerrors++ ))
+               fi
+               (( i++ ))
+       done
+       cd ..
+
+       if [ $lerrors -eq 0 ]; then
+               RTYPE=TPASS
+       else
+               RTYPE=TFAIL
+       fi
+
+       tst_res $RTYPE "" "$prefix_msg Link Errors: $lerrors"
+
+       (( TST_COUNT++ ))
+
+}
+
+do_link s "-s" ${1} "Symbolic"
+do_link h   "" ${2} "Hard"
+
+rm -Rf hlink slink
diff -Naur --exclude '*CVS*'
../ltp.bk/testcases/kernel/fs/linktest/Makefile
./testcases/kernel/fs/linktest/Makefile
--- ../ltp.bk/testcases/kernel/fs/linktest/Makefile     2009-10-12
22:09:13.000000000 -0700
+++ ./testcases/kernel/fs/linktest/Makefile     2009-10-12
22:05:06.000000000 -0700
@@ -24,6 +24,6 @@

 include $(top_srcdir)/include/mk/env_pre.mk

-INSTALL_TARGETS                        := linktest.pl
+INSTALL_TARGETS                        := linktest.sh

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

--000e0cd2e302f3f4590475ca399d
Content-Type: text/x-patch; charset=US-ASCII;
	name="linker-pl.to-linker-sh.diff"
Content-Disposition: attachment; filename="linker-pl.to-linker-sh.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g0q7e0rs1

ZGlmZiAtTmF1ciAtLWV4Y2x1ZGUgJypDVlMqJyAuLi9sdHAuYmsvcnVudGVzdC9mcyAuL3J1bnRl
c3QvZnMKLS0tIC4uL2x0cC5iay9ydW50ZXN0L2ZzCTIwMDktMTAtMTIgMjI6MDk6MTIuMDAwMDAw
MDAwIC0wNzAwCisrKyAuL3J1bnRlc3QvZnMJMjAwOS0xMC0xMiAyMjowNjoxMC4wMDAwMDAwMDAg
LTA3MDAKQEAgLTQwLDcgKzQwLDcgQEAKIGlvZ2VuMDEgZXhwb3J0IExUUFJPT1Q7IHJ3dGVzdC5z
aCAtTiBpb2dlbjAxIC1pIDEyMHMgLXMgcmVhZCx3cml0ZSAtRGEgLUR2IC1uIDIgNTAwYjpkb2lv
LmYxLiQkIDEwMDBiOmRvaW8uZjIuJCQKIAogZnNfaW5vZDAxIGZzX2lub2QgJFRNUCAxMCAxMCAx
MAotbGlua2VyMDEgbGlua3Rlc3QucGwgMTAwMCAxMDAwCitsaW5rZXIwMSBsaW5rdGVzdC5zaCAx
MDAwIDEwMDAKIG9wZW5maWxlMDEgb3BlbmZpbGUgLWYxMCAtdDEwCiBpbm9kZTAxIGlub2RlMDEK
IGlub2RlMDIgaW5vZGUwMgpkaWZmIC1OYXVyIC0tZXhjbHVkZSAnKkNWUyonIC4uL2x0cC5iay9y
dW50ZXN0L3N0cmVzcy5wYXJ0MSAuL3J1bnRlc3Qvc3RyZXNzLnBhcnQxCi0tLSAuLi9sdHAuYmsv
cnVudGVzdC9zdHJlc3MucGFydDEJMjAwOS0xMC0xMiAyMjowOToxMi4wMDAwMDAwMDAgLTA3MDAK
KysrIC4vcnVudGVzdC9zdHJlc3MucGFydDEJMjAwOS0xMC0xMiAyMjowNjoxNS4wMDAwMDAwMDAg
LTA3MDAKQEAgLTE1Niw3ICsxNTYsNyBAQAogaW9nZW4wMSBleHBvcnQgTFRQUk9PVDsgcnd0ZXN0
LnNoIC1OIGlvZ2VuMDEgLWkgMTIwcyAtcyByZWFkLHdyaXRlIC1EYSAtRHYgLW4gMiA1MDBiOmRv
aW8uZjEuJCQgMTAwMGI6ZG9pby5mMi4kJAogCiBmc19pbm9kMDEgZnNfaW5vZCAkVE1QIDEwIDEw
IDEKLWxpbmtlcjAxIGxpbmt0ZXN0LnBsCitsaW5rZXIwMSBsaW5rdGVzdC5zaAogb3BlbmZpbGUw
MSBvcGVuZmlsZSAtZjEwIC10MTAKIGlub2RlMDEgaW5vZGUwMQogaW5vZGUwMiBpbm9kZTAyCmRp
ZmYgLU5hdXIgLS1leGNsdWRlICcqQ1ZTKicgLi4vbHRwLmJrL3Rlc3RjYXNlcy9rZXJuZWwvZnMv
bGlua3Rlc3QvbGlua3Rlc3QucGwgLi90ZXN0Y2FzZXMva2VybmVsL2ZzL2xpbmt0ZXN0L2xpbmt0
ZXN0LnBsCi0tLSAuLi9sdHAuYmsvdGVzdGNhc2VzL2tlcm5lbC9mcy9saW5rdGVzdC9saW5rdGVz
dC5wbAkyMDA5LTEwLTEyIDIyOjE4OjQ5LjAwMDAwMDAwMCAtMDcwMAorKysgLi90ZXN0Y2FzZXMv
a2VybmVsL2ZzL2xpbmt0ZXN0L2xpbmt0ZXN0LnBsCTE5NjktMTItMzEgMTY6MDA6MDAuMDAwMDAw
MDAwIC0wODAwCkBAIC0xLDg5ICswLDAgQEAKLSMhL3Vzci9iaW4vcGVybAotCi0jICAgQ29weXJp
Z2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMAotIwot
IyAgIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQotIyAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0jICAgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKLSMgICAoYXQg
eW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgotIwotIyAgIFRoaXMgcHJvZ3JhbSBpcyBk
aXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAotIyAgIGJ1dCBX
SVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
ZgotIyAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZQotIyAgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLgotIwotIyAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0jICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBu
b3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlCi0jICAgRm91bmRhdGlvbiwgSW5jLiwgNTkg
VGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKLQotCi0j
Ci0jICBGSUxFKHMpICAgICA6IGxpbmt0ZXN0LnBsIFJFQURNRQotIyAgREVTQ1JJUFRJT04gOiBS
ZWdyZXNzaW9uIHRlc3QgZm9yIG1heCBsaW5rcyBwZXIgZmlsZQotIyAgVVNFICAgICAgICAgOiBs
aW5rdGVzdC5wbCA8bnVtYmVyIG9mIHN5bWxpbmtzPiA8bnVtYmVyIG9mIGhhcmRsaW5rcz4KLSMg
IEFVVEhPUiAgICAgIDogSmVmZiBNYXJ0aW4gKG1hcnRpbmpuQHVzLmlibS5jb20pCi0jICBISVNU
T1JZICAgICA6IAotIyAgICAgKDA1LzA3LzAxKXYuOTkgIE5lZWRlZCBhIHF1aWNrIHNjcmlwdCB0
byB0ZXN0IGEgaGFyZGxpbmsgbGltaXRhdGlvbiB0aGF0IHdhcyBmb3VuZC4gCi0jICAgICAoMjgv
MDcvMDgpIFZlZXJlbmRyYSBDIDx2ZWNoYW5kckBpbi5pYm0uY29tPiAgIAotIyAgICAgICAgICAg
ICAgICAgICAgIE1vZGlmaWVkIHRvIHJldHVybiBwcm9wZXIgcmV0dXJuIGNvZGUgb24gZmFpbHVy
ZS9zdWNjZXNzLiAKLSMgICAgICAgICAgICAgICAgICAgICBBbHNvIG1vZGlmaWVkIHRvIHJldHVy
biBlcnJvcnMgaWYgdW5hYmxlIHRvIGNyZWF0ZSBkaXIvZmlsZXMKLQotJHJldCA9IDA7Ci1pZiAo
IHN5c3RlbSgibWtkaXIgaGxpbmsiKSApIHsKLSAgICAgJHJldCA9IC0xIDsKLX0KLQotaWYgKCBz
eXN0ZW0oIm1rZGlyIHNsaW5rIikgKSB7Ci0gICAgICRyZXQgPSAtMSA7Ci19Ci0KLWlmICggc3lz
dGVtKCJ0b3VjaCBobGluay9oZmlsZSIpICkgewotICAgICAkcmV0ID0gLTEgOwotfQotCi1pZiAo
IHN5c3RlbSgidG91Y2ggc2xpbmsvc2ZpbGUiKSApIHsKLSAgICAgJHJldCA9IC0xIDsKLX0KLQot
aWYgKCAkcmV0ID09IC0xICkgewotICAgIHByaW50ZiAoIkVycm9yICVkOiBOb3QgYWJsZSB0byBj
cmVhdGUgZGlyL2ZpbGUnc1xuICIgLCAkcmV0KTsKLSAgICBleGl0IC0xOwotfQotCi0kc2NvdW50
PXNoaWZ0IEBBUkdWOwotY2hkaXIgInNsaW5rIjsKLWZvcigkeD0wOyR4PCRzY291bnQ7JHgrKykg
ewotICAgJHJlc3VsdD1zeW1saW5rKCJzZmlsZSIsInNmaWxlJHgiKTsKLSAgIGlmKCEkcmVzdWx0
KSB7Ci0gICAgICAkc2Vycm9ycysrOwotICAgICAgfQotICAgfQotY2hkaXIgIi4uIjsKLSRoY291
bnQ9c2hpZnQgQEFSR1Y7Ci1mb3IoJHg9MDskeDwkaGNvdW50OyR4KyspIHsKLSAgICRyZXN1bHQ9
bGluaygiaGxpbmsvaGZpbGUiLCJobGluay9oZmlsZSR4Iik7Ci0gICBpZighJHJlc3VsdCkgewot
ICAgICAgJGhlcnJvcnMrKzsKLSAgICAgIH0KLSAgIH0KLQotaWYoJGhlcnJvcnMpIHsKLSAgICBw
cmludGYgKCJsaW5rZXIwMSA6IEZBSUwgSGFyZCBMaW5rIEVycm9ycyA9ICVkXG4iLCAkaGVycm9y
cyk7Ci0gICAgJHJldCA9IC0xCi19Ci1lbHNlIHsKLSAgICBwcmludGYgKCJsaW5rZXIwMSA6IEhh
cmRMaW5rIFRlc3QgUEFTU1xuIiApCi19Ci1pZigkc2Vycm9ycykgewotICAgIHByaW50ZiAoImxp
bmtlcjAxIDogRkFJTCBTb2Z0IExpbmsgRXJyb3JzID0gJWRcbiIsICRzZXJyb3JzKTsKLSAgICAk
cmV0ID0gLTEKLX0KLWVsc2UgewotICAgIHByaW50ZiAoImxpbmtlcjAxIDogU29mdExpbmsgVGVz
dCBQQVNTXG4iICk7Ci19Ci0KLXVubGluayA8aGxpbmsvaGZpbGUqPjsKLXVubGluayA8c2xpbmsv
c2ZpbGUqPjsKLXJtZGlyIGhsaW5rOwotcm1kaXIgc2xpbms7Ci1leGl0ICRyZXQ7CmRpZmYgLU5h
dXIgLS1leGNsdWRlICcqQ1ZTKicgLi4vbHRwLmJrL3Rlc3RjYXNlcy9rZXJuZWwvZnMvbGlua3Rl
c3QvbGlua3Rlc3Quc2ggLi90ZXN0Y2FzZXMva2VybmVsL2ZzL2xpbmt0ZXN0L2xpbmt0ZXN0LnNo
Ci0tLSAuLi9sdHAuYmsvdGVzdGNhc2VzL2tlcm5lbC9mcy9saW5rdGVzdC9saW5rdGVzdC5zaAkx
OTY5LTEyLTMxIDE2OjAwOjAwLjAwMDAwMDAwMCAtMDgwMAorKysgLi90ZXN0Y2FzZXMva2VybmVs
L2ZzL2xpbmt0ZXN0L2xpbmt0ZXN0LnNoCTIwMDktMTAtMTIgMjI6MTU6MjYuMDAwMDAwMDAwIC0w
NzAwCkBAIC0wLDAgKzEsNzUgQEAKKyMhL2Jpbi9zaAorCisjICAgQ29weXJpZ2h0IChjKSBJbnRl
cm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMAorIworIyAgIFRoaXMgcHJv
Z3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeQorIyAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisjICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsg
ZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgICAoYXQgeW91ciBvcHRpb24p
IGFueSBsYXRlciB2ZXJzaW9uLgorIworIyAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBp
biB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorIyAgIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZQorIyAg
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAg
IFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlCisjICAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRv
IHRoZSBGcmVlIFNvZnR3YXJlCisjICAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNl
LCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKworCisjCisjICBGSUxFKHMp
ICAgICA6IGxpbmt0ZXN0LnNoIFJFQURNRQorIyAgREVTQ1JJUFRJT04gOiBSZWdyZXNzaW9uIHRl
c3QgZm9yIG1heCBsaW5rcyBwZXIgZmlsZQorIyAgVVNFICAgICAgICAgOiBsaW5rdGVzdC5zaCA8
bnVtYmVyIG9mIHN5bWxpbmtzPiA8bnVtYmVyIG9mIGhhcmRsaW5rcz4KKyMgIEFVVEhPUiAgICAg
IDogR2FycmV0dCBDb29wZXIgKHlhbmVnb21pQGdtYWlsLmNvbSkKKyMgIEhJU1RPUlkgICAgIDog
CisjCUEgcmV3cml0ZSBvZiB0ZXN0Y2FzZXMva2VybmVsL2ZzL2xpbmt0ZXN0LnBsCisKKyMgWFhY
OiBDaGFuZ2UgdG8gYSB0ZW1wIGRpciB2aWEgbWt0ZW1wIC1kLgorY2QgIiR7MCUvKn0iCisKK2V4
cG9ydCBUQ0lEPWxpbmtlcjAxCitleHBvcnQgVFNUX1RPVEFMPTIKK2V4cG9ydCBUU1RfQ09VTlQ9
MQorCitpZiBbICQjIC1uZSAyIF07IHRoZW4KKwl0c3RfcmVzIFRCUk9LICIiICJVc2FnZTogJDAg
e3NvZnRsaW5rIGNvdW50fSB7aGFyZGxpbmsgY291bnR9IgorCWV4aXQgLTEKK2ZpCisKK21rZGly
IGhsaW5rIHNsaW5rICYmIHRvdWNoIGhsaW5rL2hmaWxlIHNsaW5rL3NmaWxlCisKK2RvX2xpbmso
KSB7CisJcGZpeD0kMTsgc2hpZnQKKwlsbl9vcHRzPSQxOyBzaGlmdAorCWxpbWl0PSQxOyBzaGlm
dAorCisJbGVycm9ycz0wCisKKwlpPTAKKworCWNkICR7cGZpeH1saW5rOyBcCisJd2hpbGUgWyAk
aSAtbHQgJGxpbWl0IF07IGRvIFwKKwkJaWYgISBsbiAke2xuX29wdHN9ICIkUFdELyR7cGZpeH1m
aWxlIiAke3BmaXh9ZmlsZSR7aX07IHRoZW4KKwkJCSgoIGxlcnJvcnMrKyApKQorCQlmaQorCQko
KCBpKysgKSkKKwlkb25lCisJY2QgLi4KKworCWlmIFsgJGxlcnJvcnMgLWVxIDAgXTsgdGhlbgor
CQlSVFlQRT1UUEFTUworCWVsc2UKKwkJUlRZUEU9VEZBSUwKKwlmaQorCisJdHN0X3JlcyAkUlRZ
UEUgIiIgIiRwcmVmaXhfbXNnIExpbmsgRXJyb3JzOiAkbGVycm9ycyIKKworCSgoIFRTVF9DT1VO
VCsrICkpCisKK30KKworZG9fbGluayBzICItcyIgJHsxfSAiU3ltYm9saWMiCitkb19saW5rIGgg
ICAiIiAkezJ9ICJIYXJkIgorCitybSAtUmYgaGxpbmsgc2xpbmsKZGlmZiAtTmF1ciAtLWV4Y2x1
ZGUgJypDVlMqJyAuLi9sdHAuYmsvdGVzdGNhc2VzL2tlcm5lbC9mcy9saW5rdGVzdC9NYWtlZmls
ZSAuL3Rlc3RjYXNlcy9rZXJuZWwvZnMvbGlua3Rlc3QvTWFrZWZpbGUKLS0tIC4uL2x0cC5iay90
ZXN0Y2FzZXMva2VybmVsL2ZzL2xpbmt0ZXN0L01ha2VmaWxlCTIwMDktMTAtMTIgMjI6MDk6MTMu
MDAwMDAwMDAwIC0wNzAwCisrKyAuL3Rlc3RjYXNlcy9rZXJuZWwvZnMvbGlua3Rlc3QvTWFrZWZp
bGUJMjAwOS0xMC0xMiAyMjowNTowNi4wMDAwMDAwMDAgLTA3MDAKQEAgLTI0LDYgKzI0LDYgQEAK
IAogaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZW52X3ByZS5tawogCi1JTlNUQUxM
X1RBUkdFVFMJCQk6PSBsaW5rdGVzdC5wbAorSU5TVEFMTF9UQVJHRVRTCQkJOj0gbGlua3Rlc3Qu
c2gKIAogaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3Rhcmdl
dC5tawo=
--000e0cd2e302f3f4590475ca399d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--000e0cd2e302f3f4590475ca399d
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd2e302f3f4590475ca399d--

