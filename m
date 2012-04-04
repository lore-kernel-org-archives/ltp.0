Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFIhc-00068p-Ng
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:24:16 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFIhb-00059Z-Iw
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:24:16 +0000
Received: by dadz9 with SMTP id z9so549526dad.33
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:24:09 -0700 (PDT)
Date: Tue, 3 Apr 2012 22:20:15 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204032217030.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="967339439-1263491235-1333516817=:25027"
Subject: [LTP] [PATCH 1/4] Replace create_valgrind_check.pl with an awk
 equivalent
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

--967339439-1263491235-1333516817=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Replace create_valgrind_check.pl with an awk equivalent

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  runltp                          |   22 ++++----
  tools/create_valgrind_check.awk |   42 ++++++++++++++++
  tools/create_valgrind_check.pl  |  106 ---------------------------------------
  3 files changed, 52 insertions(+), 118 deletions(-)
  create mode 100644 tools/create_valgrind_check.awk
  delete mode 100755 tools/create_valgrind_check.pl


--------------1.7.9.4
Content-Type: text/x-patch; name="0001-Replace-create_valgrind_check.pl-with-an-awk-equival.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Replace-create_valgrind_check.pl-with-an-awk-equival.patch"

diff --git a/runltp b/runltp
index fc3515b..a7e6635 100755
--- a/runltp
+++ b/runltp
@@ -795,19 +795,17 @@ main()
  		if [ ! $INJECT_KERNEL_FAULT ]; then
  			which valgrind || VALGRIND_CHECK_TYPE=XYZ
  			case $VALGRIND_CHECK_TYPE in
-				1)
-				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 1 > ${TMP}/alltests.tmp
+			[1-3])
+				awk -v CHECK_LEVEL=$VALGRIND_CHECK_TYPE \
+					-f ${LTPROOT}/bin/create_valgrind_check.awk \
+					${TMP}/alltests $VALGRIND_CHECK_TYPE > \
+					${TMP}/alltests.tmp
  				cp ${TMP}/alltests.tmp ${TMP}/alltests
-				rm -rf ${TMP}/alltests.tmp;;
-				2)
-				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 2 > ${TMP}/alltests.tmp
-				cp ${TMP}/alltests.tmp ${TMP}/alltests
-				rm -rf ${TMP}/alltests.tmp;;
-				3)
-				${LTPROOT}/bin/create_valgrind_check.pl ${TMP}/alltests 3 > ${TMP}/alltests.tmp
-				cp ${TMP}/alltests.tmp ${TMP}/alltests
-				rm -rf ${TMP}/alltests.tmp;;
-				*) echo "Invalid Memory Check Type, or, Valgrind is not available";;
+				rm -rf ${TMP}/alltests.tmp
+				;;
+			*)
+				echo "Invalid Memory Check Type, or, Valgrind is not available"
+				;;
  			esac
  		fi
  	fi
diff --git a/tools/create_valgrind_check.awk b/tools/create_valgrind_check.awk
new file mode 100644
index 0000000..21621c5
--- /dev/null
+++ b/tools/create_valgrind_check.awk
@@ -0,0 +1,42 @@
+#!/usr/bin/awk -f
+#
+#    Script for adding necessary valgrind calls before commands.
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
+# XXX: this script doesn't handle items that would be executed via pan with
+# /bin/sh properly.
+NF && ! /^#/ {
+	print
+	if (CHECK_LEVEL == 1 || CHECK_LEVEL == 3) {
+		s=$1 "_valgrind_memory_leak_check  valgrind -q --leak-check=full --trace-children=yes"
+		for (i = 2; i <= NF; i++) {
+			s = s " " $i
+		}
+		print s
+	}
+	if (CHECK_LEVEL == 2 || CHECK_LEVEL == 3) {
+		s=$1 "_valgrind_thread_concurrency_check  valgrind -q --tool=helgrind --trace-children=yes"
+		for (i = 2; i <= NF; i++) {
+			s = s " " $i
+		}
+		print s
+	}
+}
diff --git a/tools/create_valgrind_check.pl b/tools/create_valgrind_check.pl
deleted file mode 100755
index 41ed93e..0000000
--- a/tools/create_valgrind_check.pl
+++ /dev/null
@@ -1,106 +0,0 @@
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
-# File :        create_valgrind_check					      ##
-#                                                                             ##
-# Usage:        create_valgrind_check\					      ##
-#		<LTP_COMMAND_FILE> <VALGRIND_CHECK_TYPE>		      ##
-#                                                                             ##
-# Description:  This is a simple perl script which will take ltp command file ##
-#		as input and then create a final command file while will have ##
-#		the following entries for each test tag:		      ##
-#		1) <tag_name> <test_binary_name>			      ##
-#		2) <tag_name_valgrind_check_type> <valgrind test_binary_name> ##
-#                                                                             ##
-# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
-#                                                                             ##
-# History:      Aug 23 2009 - Created - Subrata Modak.                        ##
-################################################################################
-
-my $command_file	= shift (@ARGV) || syntax();
-my $valgrind_check_type	= shift (@ARGV) || syntax();
-
-sub syntax() {
-	print "syntax: create_valgrind_check\
-	<LTP_COMMAND_FILE> <VALGRIND_CHECK_TYPE>\n";
-	exit (1);
-}
-
-sub print_memory_leak_check {
-	$sub_line = shift;
-	@sub_tag_and_actual_command = split(/\ /, $sub_line);
-	my $sub_token_counter = 0;
-	foreach my $sub_token (@sub_tag_and_actual_command) {
-		if ($sub_token_counter == 0 ) {#print the tagname now
-			print $sub_token . "_valgrind_memory_leak_check " .
-				" valgrind -q --leak-check=full --trace-children=yes ";
-			$sub_token_counter++;
-			next;
-		}
-		print " " . $sub_token . " ";
-	}
-	print "\n";
-}
-
-sub print_thread_concurrency_check {
-	$sub_line = shift;
-	@sub_tag_and_actual_command = split(/\ /, $sub_line);
-	my $sub_token_counter = 0;
-	foreach my $sub_token (@sub_tag_and_actual_command) {
-		if ($sub_token_counter == 0 ) {#print the tagname now
-			print $sub_token . "_valgrind_thread_concurrency_check " .
-				" valgrind -q --tool=helgrind --trace-children=yes ";
-			$sub_token_counter++;
-			next;
-		}
-		print " " . $sub_token . " ";
-	}
-	print "\n";
-}
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
-	print "$line\n"; #Print one instance for normal execution
-
-	if ($valgrind_check_type == 3) {
-		#Print for both Memory Leak and Thread Concurrency Checks
-		print_memory_leak_check($line);
-		print_thread_concurrency_check($line);
-	}
-	if ($valgrind_check_type == 2) {
-		#Print only for Thread concurrency Check
-		print_thread_concurrency_check($line);
-	}
-	if ($valgrind_check_type == 1) {
-		#Print only for Memory leak Check
-		print_memory_leak_check($line);
-	}
-}
-close (FILE);
-

--------------1.7.9.4--


--967339439-1263491235-1333516817=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0001-Replace-create_valgrind_check.pl-with-an-awk-equival.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204032220150.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0001-Replace-create_valgrind_check.pl-with-an-awk-equival.patch

RnJvbSA0ZmM1NDcxZTIzM2EzMThkOGYwYmU5OTlhMWMyM2IyZGE0ZWU0MTI3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFR1ZSwgMyBBcHIgMjAx
MiAxOTo0NzoxNiAtMDcwMA0KU3ViamVjdDogW1BBVENIIDEvNF0gUmVwbGFj
ZSBjcmVhdGVfdmFsZ3JpbmRfY2hlY2sucGwgd2l0aCBhbiBhd2sgZXF1aXZh
bGVudA0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRlbnQtVHlwZTogbXVsdGlw
YXJ0L21peGVkOyBib3VuZGFyeT0iLS0tLS0tLS0tLS0tMS43LjkuNCINCg0K
VGhpcyBpcyBhIG11bHRpLXBhcnQgbWVzc2FnZSBpbiBNSU1FIGZvcm1hdC4N
Ci0tLS0tLS0tLS0tLS0tMS43LjkuNA0KQ29udGVudC1UeXBlOiB0ZXh0L3Bs
YWluOyBjaGFyc2V0PVVURi04OyBmb3JtYXQ9Zml4ZWQNCkNvbnRlbnQtVHJh
bnNmZXItRW5jb2Rpbmc6IDhiaXQNCg0KDQpTaWduZWQtb2ZmLWJ5OiBHYXJy
ZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPg0KLS0tDQogcnVubHRw
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjIgKysrKy0tLS0NCiB0
b29scy9jcmVhdGVfdmFsZ3JpbmRfY2hlY2suYXdrIHwgICA0MiArKysrKysr
KysrKysrKysrDQogdG9vbHMvY3JlYXRlX3ZhbGdyaW5kX2NoZWNrLnBsICB8
ICAxMDYgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQogMyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAxMTggZGVs
ZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL2NyZWF0ZV92
YWxncmluZF9jaGVjay5hd2sNCiBkZWxldGUgbW9kZSAxMDA3NTUgdG9vbHMv
Y3JlYXRlX3ZhbGdyaW5kX2NoZWNrLnBsDQoNCg0KLS0tLS0tLS0tLS0tLS0x
LjcuOS40DQpDb250ZW50LVR5cGU6IHRleHQveC1wYXRjaDsgbmFtZT0iMDAw
MS1SZXBsYWNlLWNyZWF0ZV92YWxncmluZF9jaGVjay5wbC13aXRoLWFuLWF3
ay1lcXVpdmFsLnBhdGNoIg0KQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdA0KQ29udGVudC1EaXNwb3NpdGlvbjogYXR0YWNobWVudDsgZmlsZW5h
bWU9IjAwMDEtUmVwbGFjZS1jcmVhdGVfdmFsZ3JpbmRfY2hlY2sucGwtd2l0
aC1hbi1hd2stZXF1aXZhbC5wYXRjaCINCg0KZGlmZiAtLWdpdCBhL3J1bmx0
cCBiL3J1bmx0cA0KaW5kZXggZmMzNTE1Yi4uYTdlNjYzNSAxMDA3NTUNCi0t
LSBhL3J1bmx0cA0KKysrIGIvcnVubHRwDQpAQCAtNzk1LDE5ICs3OTUsMTcg
QEAgbWFpbigpDQogCQlpZiBbICEgJElOSkVDVF9LRVJORUxfRkFVTFQgXTsg
dGhlbg0KIAkJCXdoaWNoIHZhbGdyaW5kIHx8IFZBTEdSSU5EX0NIRUNLX1RZ
UEU9WFlaDQogCQkJY2FzZSAkVkFMR1JJTkRfQ0hFQ0tfVFlQRSBpbg0KLQkJ
CQkxKQ0KLQkJCQkke0xUUFJPT1R9L2Jpbi9jcmVhdGVfdmFsZ3JpbmRfY2hl
Y2sucGwgJHtUTVB9L2FsbHRlc3RzIDEgPiAke1RNUH0vYWxsdGVzdHMudG1w
DQorCQkJWzEtM10pDQorCQkJCWF3ayAtdiBDSEVDS19MRVZFTD0kVkFMR1JJ
TkRfQ0hFQ0tfVFlQRSBcDQorCQkJCQktZiAke0xUUFJPT1R9L2Jpbi9jcmVh
dGVfdmFsZ3JpbmRfY2hlY2suYXdrIFwNCisJCQkJCSR7VE1QfS9hbGx0ZXN0
cyAkVkFMR1JJTkRfQ0hFQ0tfVFlQRSA+IFwNCisJCQkJCSR7VE1QfS9hbGx0
ZXN0cy50bXANCiAJCQkJY3AgJHtUTVB9L2FsbHRlc3RzLnRtcCAke1RNUH0v
YWxsdGVzdHMNCi0JCQkJcm0gLXJmICR7VE1QfS9hbGx0ZXN0cy50bXA7Ow0K
LQkJCQkyKQ0KLQkJCQkke0xUUFJPT1R9L2Jpbi9jcmVhdGVfdmFsZ3JpbmRf
Y2hlY2sucGwgJHtUTVB9L2FsbHRlc3RzIDIgPiAke1RNUH0vYWxsdGVzdHMu
dG1wDQotCQkJCWNwICR7VE1QfS9hbGx0ZXN0cy50bXAgJHtUTVB9L2FsbHRl
c3RzDQotCQkJCXJtIC1yZiAke1RNUH0vYWxsdGVzdHMudG1wOzsNCi0JCQkJ
MykNCi0JCQkJJHtMVFBST09UfS9iaW4vY3JlYXRlX3ZhbGdyaW5kX2NoZWNr
LnBsICR7VE1QfS9hbGx0ZXN0cyAzID4gJHtUTVB9L2FsbHRlc3RzLnRtcA0K
LQkJCQljcCAke1RNUH0vYWxsdGVzdHMudG1wICR7VE1QfS9hbGx0ZXN0cw0K
LQkJCQlybSAtcmYgJHtUTVB9L2FsbHRlc3RzLnRtcDs7DQotCQkJCSopIGVj
aG8gIkludmFsaWQgTWVtb3J5IENoZWNrIFR5cGUsIG9yLCBWYWxncmluZCBp
cyBub3QgYXZhaWxhYmxlIjs7DQorCQkJCXJtIC1yZiAke1RNUH0vYWxsdGVz
dHMudG1wDQorCQkJCTs7DQorCQkJKikNCisJCQkJZWNobyAiSW52YWxpZCBN
ZW1vcnkgQ2hlY2sgVHlwZSwgb3IsIFZhbGdyaW5kIGlzIG5vdCBhdmFpbGFi
bGUiDQorCQkJCTs7DQogCQkJZXNhYw0KIAkJZmkNCiAJZmkNCmRpZmYgLS1n
aXQgYS90b29scy9jcmVhdGVfdmFsZ3JpbmRfY2hlY2suYXdrIGIvdG9vbHMv
Y3JlYXRlX3ZhbGdyaW5kX2NoZWNrLmF3aw0KbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCmluZGV4IDAwMDAwMDAuLjIxNjIxYzUNCi0tLSAvZGV2L251bGwNCisr
KyBiL3Rvb2xzL2NyZWF0ZV92YWxncmluZF9jaGVjay5hd2sNCkBAIC0wLDAg
KzEsNDIgQEANCisjIS91c3IvYmluL2F3ayAtZg0KKyMNCisjICAgIFNjcmlw
dCBmb3IgYWRkaW5nIG5lY2Vzc2FyeSB2YWxncmluZCBjYWxscyBiZWZvcmUg
Y29tbWFuZHMuDQorIw0KKyMgICAgQ29weXJpZ2h0IChDKSAyMDEyLCBMaW51
eCBUZXN0IFByb2plY3QuDQorIw0KKyMgICAgVGhpcyBwcm9ncmFtIGlzIGZy
ZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBt
b2RpZnkNCisjICAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5DQorIyAgICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAy
IG9mIHRoZSBMaWNlbnNlLCBvcg0KKyMgICAgKGF0IHlvdXIgb3B0aW9uKSBh
bnkgbGF0ZXIgdmVyc2lvbi4NCisjDQorIyAgICBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1
bCwNCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBl
dmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQorIyAgICBNRVJDSEFOVEFC
SUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBT
ZWUgdGhlDQorIyAgICBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3Ig
bW9yZSBkZXRhaWxzLg0KKyMNCisjICAgIFlvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
IGFsb25nDQorIyAgICB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0
ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuLA0KKyMg
ICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QSAwMjExMC0xMzAxIFVTQS4NCisjDQorIyBHYXJyZXR0IENvb3BlciwgQXBy
aWwgMjAxMg0KKyMNCisNCisjIFhYWDogdGhpcyBzY3JpcHQgZG9lc24ndCBo
YW5kbGUgaXRlbXMgdGhhdCB3b3VsZCBiZSBleGVjdXRlZCB2aWEgcGFuIHdp
dGgNCisjIC9iaW4vc2ggcHJvcGVybHkuDQorTkYgJiYgISAvXiMvIHsNCisJ
cHJpbnQNCisJaWYgKENIRUNLX0xFVkVMID09IDEgfHwgQ0hFQ0tfTEVWRUwg
PT0gMykgew0KKwkJcz0kMSAiX3ZhbGdyaW5kX21lbW9yeV9sZWFrX2NoZWNr
ICB2YWxncmluZCAtcSAtLWxlYWstY2hlY2s9ZnVsbCAtLXRyYWNlLWNoaWxk
cmVuPXllcyINCisJCWZvciAoaSA9IDI7IGkgPD0gTkY7IGkrKykgew0KKwkJ
CXMgPSBzICIgIiAkaQ0KKwkJfQ0KKwkJcHJpbnQgcw0KKwl9DQorCWlmIChD
SEVDS19MRVZFTCA9PSAyIHx8IENIRUNLX0xFVkVMID09IDMpIHsNCisJCXM9
JDEgIl92YWxncmluZF90aHJlYWRfY29uY3VycmVuY3lfY2hlY2sgIHZhbGdy
aW5kIC1xIC0tdG9vbD1oZWxncmluZCAtLXRyYWNlLWNoaWxkcmVuPXllcyIN
CisJCWZvciAoaSA9IDI7IGkgPD0gTkY7IGkrKykgew0KKwkJCXMgPSBzICIg
IiAkaQ0KKwkJfQ0KKwkJcHJpbnQgcw0KKwl9DQorfQ0KZGlmZiAtLWdpdCBh
L3Rvb2xzL2NyZWF0ZV92YWxncmluZF9jaGVjay5wbCBiL3Rvb2xzL2NyZWF0
ZV92YWxncmluZF9jaGVjay5wbA0KZGVsZXRlZCBmaWxlIG1vZGUgMTAwNzU1
DQppbmRleCA0MWVkOTNlLi4wMDAwMDAwDQotLS0gYS90b29scy9jcmVhdGVf
dmFsZ3JpbmRfY2hlY2sucGwNCisrKyAvZGV2L251bGwNCkBAIC0xLDEwNiAr
MCwwIEBADQotIyEvdXNyL2Jpbi9wZXJsDQotIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMNCi0jIyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjIw0KLSMjIENvcHlyaWdodCAoYykgSW50ZXJuYXRpb25hbCBC
dXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMDkgICAgICAgICAgICAgICAg
ICMjDQotIyMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMNCi0j
IyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVk
aXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgICAgICAjIw0KLSMjIGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5ICAgICAgICMjDQotIyMgdGhlIEZyZWUgU29m
dHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGlj
ZW5zZSwgb3IgICAgICAgICAgIyMNCi0jIyAoYXQgeW91ciBvcHRpb24pIGFu
eSBsYXRlciB2ZXJzaW9uLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAjIw0KLSMjICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICMjDQotIyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCAgICAgICAgIyMN
Ci0jIyBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSAjIw0KLSMjIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAgICMjDQotIyMgZm9yIG1vcmUg
ZGV0YWlscy4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIyMNCi0jIyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAjIw0KLSMjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlICAg
ICAgICAgICMjDQotIyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBu
b3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlICAgICAgICAgICAgICAg
IyMNCi0jIyBGb3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UsIFN1
aXRlIDMzMCwgQm9zdG9uLCBNQSAwMjExMS0xMzA3IFVTQSAgICAjIw0KLSMj
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCi0jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjIw0KLSMgRmlsZSA6ICAgICAgICBjcmVhdGVf
dmFsZ3JpbmRfY2hlY2sJCQkJCSAgICAgICMjDQotIyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIyMNCi0jIFVzYWdlOiAgICAgICAgY3JlYXRl
X3ZhbGdyaW5kX2NoZWNrXAkJCQkJICAgICAgIyMNCi0jCQk8TFRQX0NPTU1B
TkRfRklMRT4gPFZBTEdSSU5EX0NIRUNLX1RZUEU+CQkgICAgICAjIw0KLSMg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyBEZXNjcmlw
dGlvbjogIFRoaXMgaXMgYSBzaW1wbGUgcGVybCBzY3JpcHQgd2hpY2ggd2ls
bCB0YWtlIGx0cCBjb21tYW5kIGZpbGUgIyMNCi0jCQlhcyBpbnB1dCBhbmQg
dGhlbiBjcmVhdGUgYSBmaW5hbCBjb21tYW5kIGZpbGUgd2hpbGUgd2lsbCBo
YXZlICMjDQotIwkJdGhlIGZvbGxvd2luZyBlbnRyaWVzIGZvciBlYWNoIHRl
c3QgdGFnOgkJICAgICAgIyMNCi0jCQkxKSA8dGFnX25hbWU+IDx0ZXN0X2Jp
bmFyeV9uYW1lPgkJCSAgICAgICMjDQotIwkJMikgPHRhZ19uYW1lX3ZhbGdy
aW5kX2NoZWNrX3R5cGU+IDx2YWxncmluZCB0ZXN0X2JpbmFyeV9uYW1lPiAj
Iw0KLSMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyBB
dXRob3I6ICAgICAgIFN1YnJhdGEgTW9kYWsgPHN1YnJhdGFAbGludXgudm5l
dC5pYm0uY29tPiAgICAgICAgICAgICAgICAgICAgIyMNCi0jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIw0KLSMgSGlzdG9yeTogICAgICBB
dWcgMjMgMjAwOSAtIENyZWF0ZWQgLSBTdWJyYXRhIE1vZGFrLiAgICAgICAg
ICAgICAgICAgICAgICAgICMjDQotIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMNCi0NCi1teSAkY29tbWFuZF9maWxlCT0gc2hpZnQgKEBB
UkdWKSB8fCBzeW50YXgoKTsNCi1teSAkdmFsZ3JpbmRfY2hlY2tfdHlwZQk9
IHNoaWZ0IChAQVJHVikgfHwgc3ludGF4KCk7DQotDQotc3ViIHN5bnRheCgp
IHsNCi0JcHJpbnQgInN5bnRheDogY3JlYXRlX3ZhbGdyaW5kX2NoZWNrXA0K
LQk8TFRQX0NPTU1BTkRfRklMRT4gPFZBTEdSSU5EX0NIRUNLX1RZUEU+XG4i
Ow0KLQlleGl0ICgxKTsNCi19DQotDQotc3ViIHByaW50X21lbW9yeV9sZWFr
X2NoZWNrIHsNCi0JJHN1Yl9saW5lID0gc2hpZnQ7DQotCUBzdWJfdGFnX2Fu
ZF9hY3R1YWxfY29tbWFuZCA9IHNwbGl0KC9cIC8sICRzdWJfbGluZSk7DQot
CW15ICRzdWJfdG9rZW5fY291bnRlciA9IDA7DQotCWZvcmVhY2ggbXkgJHN1
Yl90b2tlbiAoQHN1Yl90YWdfYW5kX2FjdHVhbF9jb21tYW5kKSB7DQotCQlp
ZiAoJHN1Yl90b2tlbl9jb3VudGVyID09IDAgKSB7I3ByaW50IHRoZSB0YWdu
YW1lIG5vdw0KLQkJCXByaW50ICRzdWJfdG9rZW4gLiAiX3ZhbGdyaW5kX21l
bW9yeV9sZWFrX2NoZWNrICIgLg0KLQkJCQkiIHZhbGdyaW5kIC1xIC0tbGVh
ay1jaGVjaz1mdWxsIC0tdHJhY2UtY2hpbGRyZW49eWVzICI7DQotCQkJJHN1
Yl90b2tlbl9jb3VudGVyKys7DQotCQkJbmV4dDsNCi0JCX0NCi0JCXByaW50
ICIgIiAuICRzdWJfdG9rZW4gLiAiICI7DQotCX0NCi0JcHJpbnQgIlxuIjsN
Ci19DQotDQotc3ViIHByaW50X3RocmVhZF9jb25jdXJyZW5jeV9jaGVjayB7
DQotCSRzdWJfbGluZSA9IHNoaWZ0Ow0KLQlAc3ViX3RhZ19hbmRfYWN0dWFs
X2NvbW1hbmQgPSBzcGxpdCgvXCAvLCAkc3ViX2xpbmUpOw0KLQlteSAkc3Vi
X3Rva2VuX2NvdW50ZXIgPSAwOw0KLQlmb3JlYWNoIG15ICRzdWJfdG9rZW4g
KEBzdWJfdGFnX2FuZF9hY3R1YWxfY29tbWFuZCkgew0KLQkJaWYgKCRzdWJf
dG9rZW5fY291bnRlciA9PSAwICkgeyNwcmludCB0aGUgdGFnbmFtZSBub3cN
Ci0JCQlwcmludCAkc3ViX3Rva2VuIC4gIl92YWxncmluZF90aHJlYWRfY29u
Y3VycmVuY3lfY2hlY2sgIiAuDQotCQkJCSIgdmFsZ3JpbmQgLXEgLS10b29s
PWhlbGdyaW5kIC0tdHJhY2UtY2hpbGRyZW49eWVzICI7DQotCQkJJHN1Yl90
b2tlbl9jb3VudGVyKys7DQotCQkJbmV4dDsNCi0JCX0NCi0JCXByaW50ICIg
IiAuICRzdWJfdG9rZW4gLiAiICI7DQotCX0NCi0JcHJpbnQgIlxuIjsNCi19
DQotDQotb3BlbiAoRklMRSwgJGNvbW1hbmRfZmlsZSkgfHwgZGllICJDYW5u
b3Qgb3BlbiBmaWxlOiAkY29tbWFuZF9maWxlXG4iOw0KLXdoaWxlICgkbGlu
ZSA9IDxGSUxFPikgew0KLQlpZiAoJGxpbmUgPX4gL14jLykgew0KLQkJcHJp
bnQgIiRsaW5lIjsNCi0JCW5leHQ7DQotCX0NCi0JaWYgKCRsaW5lID1+IC9e
XG4kLykgew0KLQkJbmV4dDsNCi0JfQ0KLQljaG9tcCAkbGluZTsNCi0JcHJp
bnQgIiRsaW5lXG4iOyAjUHJpbnQgb25lIGluc3RhbmNlIGZvciBub3JtYWwg
ZXhlY3V0aW9uDQotDQotCWlmICgkdmFsZ3JpbmRfY2hlY2tfdHlwZSA9PSAz
KSB7DQotCQkjUHJpbnQgZm9yIGJvdGggTWVtb3J5IExlYWsgYW5kIFRocmVh
ZCBDb25jdXJyZW5jeSBDaGVja3MNCi0JCXByaW50X21lbW9yeV9sZWFrX2No
ZWNrKCRsaW5lKTsNCi0JCXByaW50X3RocmVhZF9jb25jdXJyZW5jeV9jaGVj
aygkbGluZSk7DQotCX0NCi0JaWYgKCR2YWxncmluZF9jaGVja190eXBlID09
IDIpIHsNCi0JCSNQcmludCBvbmx5IGZvciBUaHJlYWQgY29uY3VycmVuY3kg
Q2hlY2sNCi0JCXByaW50X3RocmVhZF9jb25jdXJyZW5jeV9jaGVjaygkbGlu
ZSk7DQotCX0NCi0JaWYgKCR2YWxncmluZF9jaGVja190eXBlID09IDEpIHsN
Ci0JCSNQcmludCBvbmx5IGZvciBNZW1vcnkgbGVhayBDaGVjaw0KLQkJcHJp
bnRfbWVtb3J5X2xlYWtfY2hlY2soJGxpbmUpOw0KLQl9DQotfQ0KLWNsb3Nl
IChGSUxFKTsNCi0NCg0KLS0tLS0tLS0tLS0tLS0xLjcuOS40LS0NCg0KDQo=

--967339439-1263491235-1333516817=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-1263491235-1333516817=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-1263491235-1333516817=:25027--

