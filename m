Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFIop-0006SP-Cl
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:31:43 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFIoo-0005YV-5G
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:31:43 +0000
Received: by pbcum15 with SMTP id um15so650195pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:31:36 -0700 (PDT)
Date: Tue, 3 Apr 2012 22:27:42 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204032225500.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="967339439-553314594-1333517264=:25027"
Subject: [LTP] [PATCH 4/4]
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--967339439-553314594-1333517264=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Replace create_kernel_faults_in_loops_and_probability.pl with an awk equivalent

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  runltp                                             |   24 +++--
  ...eate_kernel_faults_in_loops_and_probability.awk |   40 ++++++++
  ...reate_kernel_faults_in_loops_and_probability.pl |  100 --------------------
  3 files changed, 58 insertions(+), 106 deletions(-)
  create mode 100644 tools/create_kernel_faults_in_loops_and_probability.awk
  delete mode 100755 tools/create_kernel_faults_in_loops_and_probability.pl


--------------1.7.9.4
Content-Type: text/x-patch; name="0004-Replace-create_kernel_faults_in_loops_and_probabilit.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0004-Replace-create_kernel_faults_in_loops_and_probabilit.patch"

diff --git a/runltp b/runltp
index 8e7075d..3bd5252 100755
--- a/runltp
+++ b/runltp
@@ -771,16 +771,28 @@ main()
  	if [ $INJECT_KERNEL_FAULT ] ; then
  		#See if Debugfs is mounted, and
  		#Fault Injection Framework available through Debugfs
-		if [ -d "/sys/kernel/debug/fail_io_timeout" -o \
-			-d "/sys/kernel/debug/fail_make_request" -o \
-			-d "/sys/kernel/debug/fail_page_alloc" -o \
-			-d "/sys/kernel/debug/failslab" ]; then
+		use_faultinjection=true
+		for debug_subdir in \
+			fail_io_timeout \
+			fail_make_request \
+			fail_page_alloc \
+			failslab \
+		; do
+			if [ -d "/sys/kernel/debug/$debug_subdir" ]
+			then
+				use_faultinjection=true
+				break
+			fi
+		done
+		if $use_faultinjection; then
  			#If atleast one of the Framework is available
  			#Go ahead to Inject Fault & Create required
  			#Command Files for LTP run
  			echo Running tests with Fault Injection Enabled in the Kernel...
-			${LTPROOT}/bin/create_kernel_faults_in_loops_and_probability.pl\
-				${TMP}/alltests $INJECT_FAULT_LOOPS_PER_TEST $INJECT_KERNEL_FAULT_PERCENTAGE > ${TMP}/alltests.tmp
+			awk -v LOOPS=$INJECT_FAULT_LOOPS_PER_TEST \
+				-v PERCENTAGE=$INJECT_KERNEL_FAULT_PERCENTAGE \
+				-f ${LTPROOT}/bin/create_kernel_faults_in_loops_and_probability.awk \
+				${TMP}/alltests > ${TMP}/alltests.tmp
  			cp ${TMP}/alltests.tmp ${TMP}/alltests
  			rm -rf ${TMP}/alltests.tmp
  		else
diff --git a/tools/create_kernel_faults_in_loops_and_probability.awk b/tools/create_kernel_faults_in_loops_and_probability.awk
new file mode 100644
index 0000000..97b3861
--- /dev/null
+++ b/tools/create_kernel_faults_in_loops_and_probability.awk
@@ -0,0 +1,40 @@
+#!/usr/bin/awk -f
+#
+#    Script for adding necessary dmesg clear/capture calls before executing
+#    commands.
+#
+#    Copyright (C) 2012, Linux Test Project.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, April 2012
+#
+
+NF && ! /^#/ {
+	print
+	for (i = 1; i <= LOOPS; i++) {
+		s = $1 "_loop_" i "_under_fault_kernel "
+		if (i == 1) {
+			s = s "$LTPROOT/bin/insert_kernel_faults.sh " PERCENTAGE "; "
+		}
+		for (j = 2; j <= NF; j++) {
+			s = s " " $j
+		}
+		if (i == LOOPS) {
+			s = s "; while ! $LTPROOT/bin/restore_kernel_faults_default.sh; do :; done"
+		}
+		print s
+	}
+}
diff --git a/tools/create_kernel_faults_in_loops_and_probability.pl b/tools/create_kernel_faults_in_loops_and_probability.pl
deleted file mode 100755
index d1abc7b..0000000
--- a/tools/create_kernel_faults_in_loops_and_probability.pl
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/usr/bin/perl
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and/or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
-##                                                                            ##
-################################################################################
-#                                                                             ##
-# File :        create_kernel_faults_in_loops_and_probability.pl	      ##
-#                                                                             ##
-# Usage:        create_kernel_faults_in_loops_and_probability.pl\	      ##
-#		<LTP_COMMAND_FILE> <NO_OF_LOOPS_EACH_TEST_WILL_RUN>\	      ##
-#		<PROBABILITY_OF_FAULT_INJECTION>			      ##
-#                                                                             ##
-# Description:  This is a simple perl script which will take ltp command file ##
-#		as input and then create a final command file while will have ##
-#		the following entries for each test tag:		      ##
-#		1) <tag_name_loop1> <test_binary_name>			      ##
-#		2) <tag_name_loop2> <insert_kernel_faults.sh test_binary_name>##
-#		3) tag entried from loop3 to loop(n-1)			      ##
-#		4) <tag_name_loopn_under_kernel_fault> <restore_kernel_faults_default.sh test_binary_name>##
-#                                                                             ##
-# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
-#                                                                             ##
-# History:      Aug 11 2009 - Created - Subrata Modak.                        ##
-#		Aug 17 2009 - Made some changes as specified by Paul Larson   ##
-#		1) tag the results to say when a fault was or was not in the  ##
-#		process of being generated - Subrata Modak.		      ##
-################################################################################
-
-my $command_file	= shift (@ARGV) || syntax();
-my $loops		= shift (@ARGV) || syntax();
-my $failure_probability	= shift (@ARGV) || syntax();
-
-sub syntax() {
-	print "syntax: create_fault_in_loops_and_probability.pl\
-	<LTP_COMMAND_FILE> <NO_OF_LOOPS_EACH_TEST_WILL_RUN>\
-	<PROBABILITY_OF_FAULT_INJECTION>\n";
-	exit (1);
-}
-#$ENV{TEST_START_TIME})
-
-
-open (FILE, $command_file) || die "Cannot open file: $command_file\n";
-while ($line = <FILE>) {
-	if ($line =~ /^#/) {
-		print "$line";
-		next;
-	}
-	if ($line =~ /^\n$/) {
-		next;
-	}
-	chomp $line;
-	print "$line\n"; #Print one instance for stable execution
-	@tag_and_actual_command = split(/\ /, $line);
-
-	#The remaining loops should be running under fault injection
-	for ($counter=1; $counter<=$loops; $counter++) {
-		my $token_counter = 0;
-		foreach my $token (@tag_and_actual_command) {
-			if ($token_counter == 0 ) {
-				#Time to append the actual command tag with the loop no.
-				print $token . "_loop_" . $counter . "_under_fault_kernel ";
-				$token_counter++;
-				next;
-			}
-			if ($token_counter == 1 && $counter == 1) {
-				#Time to include the fault injection script in the first loop
-				print "\$LTPROOT/bin/insert_kernel_faults.sh " . $failure_probability . "; " . $token;
-				$token_counter++;
-				next;
-			}
-			print " " . $token . " ";
-		}
-		if ($counter == $loops) {
-			#Time to withdraw the faults once the last loop has been executed
-			#Until all faults has been successfully restored to default values...
-			#Keep restoring them
-			print "; " . "\$LTPROOT/bin/restore_kernel_faults_default.sh; RC=\$?; while [ \$RC -ne 0 ]; do \$LTPROOT/bin/restore_kernel_faults_default.sh; RC=\$?; done\n"
-		} else {
-			print "\n"
-		}
-	}
-
-}
-close (FILE);
-
--967339439-553314594-1333517264=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0004-Replace-create_kernel_faults_in_loops_and_probabilit.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204032227420.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0004-Replace-create_kernel_faults_in_loops_and_probabilit.patch

RnJvbSA5NjhkOTIwYzZjMTljNmZlYjUzZjQzNjVkY2MwMTU0YzFkNWNjZmFh
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFR1ZSwgMyBBcHIgMjAx
MiAyMjowOTo0MiAtMDcwMA0KU3ViamVjdDogW1BBVENIIDQvNF0gUmVwbGFj
ZSBjcmVhdGVfa2VybmVsX2ZhdWx0c19pbl9sb29wc19hbmRfcHJvYmFiaWxp
dHkucGwNCiB3aXRoIGFuIGF3ayBlcXVpdmFsZW50DQpNSU1FLVZlcnNpb246
IDEuMA0KQ29udGVudC1UeXBlOiBtdWx0aXBhcnQvbWl4ZWQ7IGJvdW5kYXJ5
PSItLS0tLS0tLS0tLS0xLjcuOS40Ig0KDQpUaGlzIGlzIGEgbXVsdGktcGFy
dCBtZXNzYWdlIGluIE1JTUUgZm9ybWF0Lg0KLS0tLS0tLS0tLS0tLS0xLjcu
OS40DQpDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTg7
IGZvcm1hdD1maXhlZA0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dA0KDQoNClNpZ25lZC1vZmYtYnk6IEdhcnJldHQgQ29vcGVyIDx5YW5lZ29t
aUBnbWFpbC5jb20+DQotLS0NCiBydW5sdHAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjQgKysrLS0NCiAuLi5l
YXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9vcHNfYW5kX3Byb2JhYmlsaXR5LmF3
ayB8ICAgNDAgKysrKysrKysNCiAuLi5yZWF0ZV9rZXJuZWxfZmF1bHRzX2lu
X2xvb3BzX2FuZF9wcm9iYWJpbGl0eS5wbCB8ICAxMDAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyks
IDEwNiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMv
Y3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9vcHNfYW5kX3Byb2JhYmlsaXR5
LmF3aw0KIGRlbGV0ZSBtb2RlIDEwMDc1NSB0b29scy9jcmVhdGVfa2VybmVs
X2ZhdWx0c19pbl9sb29wc19hbmRfcHJvYmFiaWxpdHkucGwNCg0KDQotLS0t
LS0tLS0tLS0tLTEuNy45LjQNCkNvbnRlbnQtVHlwZTogdGV4dC94LXBhdGNo
OyBuYW1lPSIwMDA0LVJlcGxhY2UtY3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5f
bG9vcHNfYW5kX3Byb2JhYmlsaXQucGF0Y2giDQpDb250ZW50LVRyYW5zZmVy
LUVuY29kaW5nOiA4Yml0DQpDb250ZW50LURpc3Bvc2l0aW9uOiBhdHRhY2ht
ZW50OyBmaWxlbmFtZT0iMDAwNC1SZXBsYWNlLWNyZWF0ZV9rZXJuZWxfZmF1
bHRzX2luX2xvb3BzX2FuZF9wcm9iYWJpbGl0LnBhdGNoIg0KDQpkaWZmIC0t
Z2l0IGEvcnVubHRwIGIvcnVubHRwDQppbmRleCA4ZTcwNzVkLi4zYmQ1MjUy
IDEwMDc1NQ0KLS0tIGEvcnVubHRwDQorKysgYi9ydW5sdHANCkBAIC03NzEs
MTYgKzc3MSwyOCBAQCBtYWluKCkNCiAJaWYgWyAkSU5KRUNUX0tFUk5FTF9G
QVVMVCBdIDsgdGhlbg0KIAkJI1NlZSBpZiBEZWJ1Z2ZzIGlzIG1vdW50ZWQs
IGFuZA0KIAkJI0ZhdWx0IEluamVjdGlvbiBGcmFtZXdvcmsgYXZhaWxhYmxl
IHRocm91Z2ggRGVidWdmcw0KLQkJaWYgWyAtZCAiL3N5cy9rZXJuZWwvZGVi
dWcvZmFpbF9pb190aW1lb3V0IiAtbyBcDQotCQkJLWQgIi9zeXMva2VybmVs
L2RlYnVnL2ZhaWxfbWFrZV9yZXF1ZXN0IiAtbyBcDQotCQkJLWQgIi9zeXMv
a2VybmVsL2RlYnVnL2ZhaWxfcGFnZV9hbGxvYyIgLW8gXA0KLQkJCS1kICIv
c3lzL2tlcm5lbC9kZWJ1Zy9mYWlsc2xhYiIgXTsgdGhlbg0KKwkJdXNlX2Zh
dWx0aW5qZWN0aW9uPXRydWUNCisJCWZvciBkZWJ1Z19zdWJkaXIgaW4gXA0K
KwkJCWZhaWxfaW9fdGltZW91dCBcDQorCQkJZmFpbF9tYWtlX3JlcXVlc3Qg
XA0KKwkJCWZhaWxfcGFnZV9hbGxvYyBcDQorCQkJZmFpbHNsYWIgXA0KKwkJ
OyBkbw0KKwkJCWlmIFsgLWQgIi9zeXMva2VybmVsL2RlYnVnLyRkZWJ1Z19z
dWJkaXIiIF0NCisJCQl0aGVuDQorCQkJCXVzZV9mYXVsdGluamVjdGlvbj10
cnVlDQorCQkJCWJyZWFrDQorCQkJZmkNCisJCWRvbmUNCisJCWlmICR1c2Vf
ZmF1bHRpbmplY3Rpb247IHRoZW4NCiAJCQkjSWYgYXRsZWFzdCBvbmUgb2Yg
dGhlIEZyYW1ld29yayBpcyBhdmFpbGFibGUNCiAJCQkjR28gYWhlYWQgdG8g
SW5qZWN0IEZhdWx0ICYgQ3JlYXRlIHJlcXVpcmVkDQogCQkJI0NvbW1hbmQg
RmlsZXMgZm9yIExUUCBydW4NCiAJCQllY2hvIFJ1bm5pbmcgdGVzdHMgd2l0
aCBGYXVsdCBJbmplY3Rpb24gRW5hYmxlZCBpbiB0aGUgS2VybmVsLi4uDQot
CQkJJHtMVFBST09UfS9iaW4vY3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9v
cHNfYW5kX3Byb2JhYmlsaXR5LnBsXA0KLQkJCQkke1RNUH0vYWxsdGVzdHMg
JElOSkVDVF9GQVVMVF9MT09QU19QRVJfVEVTVCAkSU5KRUNUX0tFUk5FTF9G
QVVMVF9QRVJDRU5UQUdFID4gJHtUTVB9L2FsbHRlc3RzLnRtcA0KKwkJCWF3
ayAtdiBMT09QUz0kSU5KRUNUX0ZBVUxUX0xPT1BTX1BFUl9URVNUIFwNCisJ
CQkJLXYgUEVSQ0VOVEFHRT0kSU5KRUNUX0tFUk5FTF9GQVVMVF9QRVJDRU5U
QUdFIFwNCisJCQkJLWYgJHtMVFBST09UfS9iaW4vY3JlYXRlX2tlcm5lbF9m
YXVsdHNfaW5fbG9vcHNfYW5kX3Byb2JhYmlsaXR5LmF3ayBcDQorCQkJCSR7
VE1QfS9hbGx0ZXN0cyA+ICR7VE1QfS9hbGx0ZXN0cy50bXANCiAJCQljcCAk
e1RNUH0vYWxsdGVzdHMudG1wICR7VE1QfS9hbGx0ZXN0cw0KIAkJCXJtIC1y
ZiAke1RNUH0vYWxsdGVzdHMudG1wDQogCQllbHNlDQpkaWZmIC0tZ2l0IGEv
dG9vbHMvY3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9vcHNfYW5kX3Byb2Jh
YmlsaXR5LmF3ayBiL3Rvb2xzL2NyZWF0ZV9rZXJuZWxfZmF1bHRzX2luX2xv
b3BzX2FuZF9wcm9iYWJpbGl0eS5hd2sNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQppbmRleCAwMDAwMDAwLi45N2IzODYxDQotLS0gL2Rldi9udWxsDQorKysg
Yi90b29scy9jcmVhdGVfa2VybmVsX2ZhdWx0c19pbl9sb29wc19hbmRfcHJv
YmFiaWxpdHkuYXdrDQpAQCAtMCwwICsxLDQwIEBADQorIyEvdXNyL2Jpbi9h
d2sgLWYNCisjDQorIyAgICBTY3JpcHQgZm9yIGFkZGluZyBuZWNlc3Nhcnkg
ZG1lc2cgY2xlYXIvY2FwdHVyZSBjYWxscyBiZWZvcmUgZXhlY3V0aW5nDQor
IyAgICBjb21tYW5kcy4NCisjDQorIyAgICBDb3B5cmlnaHQgKEMpIDIwMTIs
IExpbnV4IFRlc3QgUHJvamVjdC4NCisjDQorIyAgICBUaGlzIHByb2dyYW0g
aXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQ0KKyMgICAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkNCisj
ICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJz
aW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yDQorIyAgICAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLg0KKyMNCisjICAgIFRoaXMgcHJvZ3Jh
bSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLA0KKyMgICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCisjICAgIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUNCisjICAgIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGZvciBtb3JlIGRldGFpbHMuDQorIw0KKyMgICAgWW91IHNob3VsZCBoYXZl
IHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgYWxvbmcNCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3Qs
IHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4s
DQorIyAgICA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0
b24sIE1BIDAyMTEwLTEzMDEgVVNBLg0KKyMNCisjIEdhcnJldHQgQ29vcGVy
LCBBcHJpbCAyMDEyDQorIw0KKw0KK05GICYmICEgL14jLyB7DQorCXByaW50
DQorCWZvciAoaSA9IDE7IGkgPD0gTE9PUFM7IGkrKykgew0KKwkJcyA9ICQx
ICJfbG9vcF8iIGkgIl91bmRlcl9mYXVsdF9rZXJuZWwgIg0KKwkJaWYgKGkg
PT0gMSkgew0KKwkJCXMgPSBzICIkTFRQUk9PVC9iaW4vaW5zZXJ0X2tlcm5l
bF9mYXVsdHMuc2ggIiBQRVJDRU5UQUdFICI7ICINCisJCX0NCisJCWZvciAo
aiA9IDI7IGogPD0gTkY7IGorKykgew0KKwkJCXMgPSBzICIgIiAkag0KKwkJ
fQ0KKwkJaWYgKGkgPT0gTE9PUFMpIHsNCisJCQlzID0gcyAiOyB3aGlsZSAh
ICRMVFBST09UL2Jpbi9yZXN0b3JlX2tlcm5lbF9mYXVsdHNfZGVmYXVsdC5z
aDsgZG8gOjsgZG9uZSINCisJCX0NCisJCXByaW50IHMNCisJfQ0KK30NCmRp
ZmYgLS1naXQgYS90b29scy9jcmVhdGVfa2VybmVsX2ZhdWx0c19pbl9sb29w
c19hbmRfcHJvYmFiaWxpdHkucGwgYi90b29scy9jcmVhdGVfa2VybmVsX2Zh
dWx0c19pbl9sb29wc19hbmRfcHJvYmFiaWxpdHkucGwNCmRlbGV0ZWQgZmls
ZSBtb2RlIDEwMDc1NQ0KaW5kZXggZDFhYmM3Yi4uMDAwMDAwMA0KLS0tIGEv
dG9vbHMvY3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9vcHNfYW5kX3Byb2Jh
YmlsaXR5LnBsDQorKysgL2Rldi9udWxsDQpAQCAtMSwxMDAgKzAsMCBAQA0K
LSMhL3Vzci9iaW4vcGVybA0KLSMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjDQotIyMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IyMNCi0jIyBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3Mg
TWFjaGluZXMgIENvcnAuLCAyMDA5ICAgICAgICAgICAgICAgICAjIw0KLSMj
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyMgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5ICAgICAgIyMNCi0jIyBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1
Ymxpc2hlZCBieSAgICAgICAjIw0KLSMjIHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9y
ICAgICAgICAgICMjDQotIyMgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIg
dmVyc2lvbi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIyMNCi0jIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIw0K
LSMjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQgICAgICAgICMjDQotIyMgV0lU
SE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJVFkgIyMNCi0jIyBvciBGSVRORVNT
IEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgICAjIw0KLSMjIGZvciBtb3JlIGRldGFpbHMu
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICMjDQotIyMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIyMNCi0jIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAgICAgICAgICAj
Iw0KLSMjIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0
ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSAgICAgICAgICAgICAgICMjDQotIyMg
Rm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAs
IEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EgICAgIyMNCi0jIyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIw0KLSMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjDQotIyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIyMNCi0jIEZpbGUgOiAgICAgICAgY3JlYXRlX2tlcm5lbF9m
YXVsdHNfaW5fbG9vcHNfYW5kX3Byb2JhYmlsaXR5LnBsCSAgICAgICMjDQot
IyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMNCi0jIFVzYWdl
OiAgICAgICAgY3JlYXRlX2tlcm5lbF9mYXVsdHNfaW5fbG9vcHNfYW5kX3By
b2JhYmlsaXR5LnBsXAkgICAgICAjIw0KLSMJCTxMVFBfQ09NTUFORF9GSUxF
PiA8Tk9fT0ZfTE9PUFNfRUFDSF9URVNUX1dJTExfUlVOPlwJICAgICAgIyMN
Ci0jCQk8UFJPQkFCSUxJVFlfT0ZfRkFVTFRfSU5KRUNUSU9OPgkJCSAgICAg
ICMjDQotIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMNCi0j
IERlc2NyaXB0aW9uOiAgVGhpcyBpcyBhIHNpbXBsZSBwZXJsIHNjcmlwdCB3
aGljaCB3aWxsIHRha2UgbHRwIGNvbW1hbmQgZmlsZSAjIw0KLSMJCWFzIGlu
cHV0IGFuZCB0aGVuIGNyZWF0ZSBhIGZpbmFsIGNvbW1hbmQgZmlsZSB3aGls
ZSB3aWxsIGhhdmUgIyMNCi0jCQl0aGUgZm9sbG93aW5nIGVudHJpZXMgZm9y
IGVhY2ggdGVzdCB0YWc6CQkgICAgICAjIw0KLSMJCTEpIDx0YWdfbmFtZV9s
b29wMT4gPHRlc3RfYmluYXJ5X25hbWU+CQkJICAgICAgIyMNCi0jCQkyKSA8
dGFnX25hbWVfbG9vcDI+IDxpbnNlcnRfa2VybmVsX2ZhdWx0cy5zaCB0ZXN0
X2JpbmFyeV9uYW1lPiMjDQotIwkJMykgdGFnIGVudHJpZWQgZnJvbSBsb29w
MyB0byBsb29wKG4tMSkJCQkgICAgICAjIw0KLSMJCTQpIDx0YWdfbmFtZV9s
b29wbl91bmRlcl9rZXJuZWxfZmF1bHQ+IDxyZXN0b3JlX2tlcm5lbF9mYXVs
dHNfZGVmYXVsdC5zaCB0ZXN0X2JpbmFyeV9uYW1lPiMjDQotIyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIyMNCi0jIEF1dGhvcjogICAgICAg
U3VicmF0YSBNb2RhayA8c3VicmF0YUBsaW51eC52bmV0LmlibS5jb20+ICAg
ICAgICAgICAgICAgICAgICAjIw0KLSMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMjDQotIyBIaXN0b3J5OiAgICAgIEF1ZyAxMSAyMDA5IC0g
Q3JlYXRlZCAtIFN1YnJhdGEgTW9kYWsuICAgICAgICAgICAgICAgICAgICAg
ICAgIyMNCi0jCQlBdWcgMTcgMjAwOSAtIE1hZGUgc29tZSBjaGFuZ2VzIGFz
IHNwZWNpZmllZCBieSBQYXVsIExhcnNvbiAgICMjDQotIwkJMSkgdGFnIHRo
ZSByZXN1bHRzIHRvIHNheSB3aGVuIGEgZmF1bHQgd2FzIG9yIHdhcyBub3Qg
aW4gdGhlICAjIw0KLSMJCXByb2Nlc3Mgb2YgYmVpbmcgZ2VuZXJhdGVkIC0g
U3VicmF0YSBNb2Rhay4JCSAgICAgICMjDQotIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMNCi0NCi1teSAkY29tbWFuZF9maWxlCT0gc2hp
ZnQgKEBBUkdWKSB8fCBzeW50YXgoKTsNCi1teSAkbG9vcHMJCT0gc2hpZnQg
KEBBUkdWKSB8fCBzeW50YXgoKTsNCi1teSAkZmFpbHVyZV9wcm9iYWJpbGl0
eQk9IHNoaWZ0IChAQVJHVikgfHwgc3ludGF4KCk7DQotDQotc3ViIHN5bnRh
eCgpIHsNCi0JcHJpbnQgInN5bnRheDogY3JlYXRlX2ZhdWx0X2luX2xvb3Bz
X2FuZF9wcm9iYWJpbGl0eS5wbFwNCi0JPExUUF9DT01NQU5EX0ZJTEU+IDxO
T19PRl9MT09QU19FQUNIX1RFU1RfV0lMTF9SVU4+XA0KLQk8UFJPQkFCSUxJ
VFlfT0ZfRkFVTFRfSU5KRUNUSU9OPlxuIjsNCi0JZXhpdCAoMSk7DQotfQ0K
LSMkRU5We1RFU1RfU1RBUlRfVElNRX0pDQotDQotDQotb3BlbiAoRklMRSwg
JGNvbW1hbmRfZmlsZSkgfHwgZGllICJDYW5ub3Qgb3BlbiBmaWxlOiAkY29t
bWFuZF9maWxlXG4iOw0KLXdoaWxlICgkbGluZSA9IDxGSUxFPikgew0KLQlp
ZiAoJGxpbmUgPX4gL14jLykgew0KLQkJcHJpbnQgIiRsaW5lIjsNCi0JCW5l
eHQ7DQotCX0NCi0JaWYgKCRsaW5lID1+IC9eXG4kLykgew0KLQkJbmV4dDsN
Ci0JfQ0KLQljaG9tcCAkbGluZTsNCi0JcHJpbnQgIiRsaW5lXG4iOyAjUHJp
bnQgb25lIGluc3RhbmNlIGZvciBzdGFibGUgZXhlY3V0aW9uDQotCUB0YWdf
YW5kX2FjdHVhbF9jb21tYW5kID0gc3BsaXQoL1wgLywgJGxpbmUpOw0KLQ0K
LQkjVGhlIHJlbWFpbmluZyBsb29wcyBzaG91bGQgYmUgcnVubmluZyB1bmRl
ciBmYXVsdCBpbmplY3Rpb24NCi0JZm9yICgkY291bnRlcj0xOyAkY291bnRl
cjw9JGxvb3BzOyAkY291bnRlcisrKSB7DQotCQlteSAkdG9rZW5fY291bnRl
ciA9IDA7DQotCQlmb3JlYWNoIG15ICR0b2tlbiAoQHRhZ19hbmRfYWN0dWFs
X2NvbW1hbmQpIHsNCi0JCQlpZiAoJHRva2VuX2NvdW50ZXIgPT0gMCApIHsN
Ci0JCQkJI1RpbWUgdG8gYXBwZW5kIHRoZSBhY3R1YWwgY29tbWFuZCB0YWcg
d2l0aCB0aGUgbG9vcCBuby4NCi0JCQkJcHJpbnQgJHRva2VuIC4gIl9sb29w
XyIgLiAkY291bnRlciAuICJfdW5kZXJfZmF1bHRfa2VybmVsICI7DQotCQkJ
CSR0b2tlbl9jb3VudGVyKys7DQotCQkJCW5leHQ7DQotCQkJfQ0KLQkJCWlm
ICgkdG9rZW5fY291bnRlciA9PSAxICYmICRjb3VudGVyID09IDEpIHsNCi0J
CQkJI1RpbWUgdG8gaW5jbHVkZSB0aGUgZmF1bHQgaW5qZWN0aW9uIHNjcmlw
dCBpbiB0aGUgZmlyc3QgbG9vcA0KLQkJCQlwcmludCAiXCRMVFBST09UL2Jp
bi9pbnNlcnRfa2VybmVsX2ZhdWx0cy5zaCAiIC4gJGZhaWx1cmVfcHJvYmFi
aWxpdHkgLiAiOyAiIC4gJHRva2VuOw0KLQkJCQkkdG9rZW5fY291bnRlcisr
Ow0KLQkJCQluZXh0Ow0KLQkJCX0NCi0JCQlwcmludCAiICIgLiAkdG9rZW4g
LiAiICI7DQotCQl9DQotCQlpZiAoJGNvdW50ZXIgPT0gJGxvb3BzKSB7DQot
CQkJI1RpbWUgdG8gd2l0aGRyYXcgdGhlIGZhdWx0cyBvbmNlIHRoZSBsYXN0
IGxvb3AgaGFzIGJlZW4gZXhlY3V0ZWQNCi0JCQkjVW50aWwgYWxsIGZhdWx0
cyBoYXMgYmVlbiBzdWNjZXNzZnVsbHkgcmVzdG9yZWQgdG8gZGVmYXVsdCB2
YWx1ZXMuLi4NCi0JCQkjS2VlcCByZXN0b3JpbmcgdGhlbQ0KLQkJCXByaW50
ICI7ICIgLiAiXCRMVFBST09UL2Jpbi9yZXN0b3JlX2tlcm5lbF9mYXVsdHNf
ZGVmYXVsdC5zaDsgUkM9XCQ/OyB3aGlsZSBbIFwkUkMgLW5lIDAgXTsgZG8g
XCRMVFBST09UL2Jpbi9yZXN0b3JlX2tlcm5lbF9mYXVsdHNfZGVmYXVsdC5z
aDsgUkM9XCQ/OyBkb25lXG4iDQotCQl9IGVsc2Ugew0KLQkJCXByaW50ICJc
biINCi0JCX0NCi0JfQ0KLQ0KLX0NCi1jbG9zZSAoRklMRSk7DQotDQoNCi0t
LS0tLS0tLS0tLS0tMS43LjkuNC0tDQoNCg0K

--967339439-553314594-1333517264=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-553314594-1333517264=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-553314594-1333517264=:25027--

