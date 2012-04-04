Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFImw-0006OH-Bk
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:29:46 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFImv-0006bd-7b
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:29:46 +0000
Received: by pbcum15 with SMTP id um15so649041pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:29:39 -0700 (PDT)
Date: Tue, 3 Apr 2012 22:25:45 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204032223470.25027@toaster.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="967339439-1370441924-1333517147=:25027"
Subject: [LTP] [PATCH 3/4] Replace create_dmesg_entries_for_each_test.pl
 with an awk equivalent
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

--967339439-1370441924-1333517147=:25027
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII

Replace create_dmesg_entries_for_each_test.pl with an awk equivalent

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
---
  runltp                                       |    4 +-
  tools/create_dmesg_entries_for_each_test.awk |   32 +++++++++++
  tools/create_dmesg_entries_for_each_test.pl  |   74 --------------------------
  3 files changed, 35 insertions(+), 75 deletions(-)
  create mode 100644 tools/create_dmesg_entries_for_each_test.awk
  delete mode 100644 tools/create_dmesg_entries_for_each_test.pl


--------------1.7.9.4
Content-Type: text/x-patch; name="0003-Replace-create_dmesg_entries_for_each_test.pl-with-a.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0003-Replace-create_dmesg_entries_for_each_test.pl-with-a.patch"

diff --git a/runltp b/runltp
index a7e6635..8e7075d 100755
--- a/runltp
+++ b/runltp
@@ -813,7 +813,9 @@ main()
  	if [ $ALT_DMESG_OUT -eq 1 ] ; then
  		#We want to print dmesg output for each test,lets do the trick inside the script
  		echo Enabling dmesg output logging for each test...
-		${LTPROOT}/bin/create_dmesg_entries_for_each_test.pl ${TMP}/alltests $DMESG_DIR > ${TMP}/alltests.tmp
+		awk -v DMESG_DIR=$DMESG_DIR \
+			-f ${LTPROOT}/bin/create_dmesg_entries_for_each_test.awk \
+			${TMP}/alltests > ${TMP}/alltests.tmp
  		cp ${TMP}/alltests.tmp ${TMP}/alltests
  		rm -rf ${TMP}/alltests.tmp
  	fi
diff --git a/tools/create_dmesg_entries_for_each_test.awk b/tools/create_dmesg_entries_for_each_test.awk
new file mode 100644
index 0000000..3629f07
--- /dev/null
+++ b/tools/create_dmesg_entries_for_each_test.awk
@@ -0,0 +1,32 @@
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
+	s = $1 "__with_dmesg_entry dmesg -c 1>/dev/null 2>&1;"
+	for (i = 2; i <= NF; i++) {
+		s = s " " $i
+	}
+	s = s "; dmesg > " DMESG_DIR "/" $1 ".dmesg.log"
+	print s
+}
diff --git a/tools/create_dmesg_entries_for_each_test.pl b/tools/create_dmesg_entries_for_each_test.pl
deleted file mode 100644
index afb487f..0000000
--- a/tools/create_dmesg_entries_for_each_test.pl
+++ /dev/null
@@ -1,74 +0,0 @@
-#!/usr/bin/perl
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2010                 ##
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
-# File :        create_dmesg_entries_for_each_test.pl			      ##
-#                                                                             ##
-# Usage:        create_dmesg_entries_for_each_test.pl\			      ##
-#		<LTP_COMMAND_FILE> <DMESG_DIRECTORY>			      ##
-#                                                                             ##
-# Description:  This is a simple perl script which will take ltp command file ##
-#		as input and then create a final command file which will have ##
-#		the following entries for each test tag:		      ##
-#		<tag_name__with_dmesg_entry> <test_binary_name>;\	      ##
-#		<save_dmesg_logs>			      		      ##
-#                                                                             ##
-# Author:       Subrata Modak <subrata@linux.vnet.ibm.com>                    ##
-#                                                                             ##
-# History:      May 09 2010 - Created - Subrata Modak.                        ##
-################################################################################
-
-my $command_file	= shift (@ARGV) || syntax();
-my $dmesg_dir		= shift (@ARGV) || syntax();
-
-sub syntax() {
-	print "syntax: create_dmesg_entries_for_each_test.pl <LTP_COMMAND_FILE> <DMESG_DIRECTORY>\n";
-	exit (1);
-}
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
-	@tag_and_actual_command = split(/\ /, $line);
-
-	my $token_counter = 0;
-	my $tag_name = "";
-	foreach my $token (@tag_and_actual_command) {
-		if ($token_counter == 0 ) {
-			print $token . "__with_dmesg_entry" . " ";
-			print "dmesg -c 1>/dev/null 2>/dev/null;" . " ";
-			$token_counter++;
-			$tag_name = $token;
-			next;
-		}
-		print " " . $token . " ";
-	}
-	print "; dmesg > $dmesg_dir/$tag_name.dmesg.log \n";
-}
-close (FILE);
-

--967339439-1370441924-1333517147=:25027
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name=0003-Replace-create_dmesg_entries_for_each_test.pl-with-a.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.BSF.2.00.1204032225450.25027@toaster.local>
Content-Description: 
Content-Disposition: attachment;
	filename=0003-Replace-create_dmesg_entries_for_each_test.pl-with-a.patch

RnJvbSAwYzNjYjU2OGVmN2I5MTk3OGYwNjFlZjcyMDA5NGE2Njc0Y2YwNTAw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogR2FycmV0dCBDb29w
ZXIgPHlhbmVnb21pQGdtYWlsLmNvbT4NCkRhdGU6IFR1ZSwgMyBBcHIgMjAx
MiAyMDoyMjoxNCAtMDcwMA0KU3ViamVjdDogW1BBVENIIDMvNF0gUmVwbGFj
ZSBjcmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LnBsIHdpdGgg
YW4NCiBhd2sgZXF1aXZhbGVudA0KTUlNRS1WZXJzaW9uOiAxLjANCkNvbnRl
bnQtVHlwZTogbXVsdGlwYXJ0L21peGVkOyBib3VuZGFyeT0iLS0tLS0tLS0t
LS0tMS43LjkuNCINCg0KVGhpcyBpcyBhIG11bHRpLXBhcnQgbWVzc2FnZSBp
biBNSU1FIGZvcm1hdC4NCi0tLS0tLS0tLS0tLS0tMS43LjkuNA0KQ29udGVu
dC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04OyBmb3JtYXQ9Zml4
ZWQNCkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQNCg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBHYXJyZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29t
Pg0KLS0tDQogcnVubHRwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgICA0ICstDQogdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJp
ZXNfZm9yX2VhY2hfdGVzdC5hd2sgfCAgIDMyICsrKysrKysrKysrDQogdG9v
bHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5wbCAgfCAg
IDc0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMyBmaWxlcyBjaGFu
Z2VkLCAzNSBpbnNlcnRpb25zKCspLCA3NSBkZWxldGlvbnMoLSkNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9y
X2VhY2hfdGVzdC5hd2sNCiBkZWxldGUgbW9kZSAxMDA2NDQgdG9vbHMvY3Jl
YXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5wbA0KDQoNCi0tLS0t
LS0tLS0tLS0tMS43LjkuNA0KQ29udGVudC1UeXBlOiB0ZXh0L3gtcGF0Y2g7
IG5hbWU9IjAwMDMtUmVwbGFjZS1jcmVhdGVfZG1lc2dfZW50cmllc19mb3Jf
ZWFjaF90ZXN0LnBsLXdpdGgtYS5wYXRjaCINCkNvbnRlbnQtVHJhbnNmZXIt
RW5jb2Rpbmc6IDhiaXQNCkNvbnRlbnQtRGlzcG9zaXRpb246IGF0dGFjaG1l
bnQ7IGZpbGVuYW1lPSIwMDAzLVJlcGxhY2UtY3JlYXRlX2RtZXNnX2VudHJp
ZXNfZm9yX2VhY2hfdGVzdC5wbC13aXRoLWEucGF0Y2giDQoNCmRpZmYgLS1n
aXQgYS9ydW5sdHAgYi9ydW5sdHANCmluZGV4IGE3ZTY2MzUuLjhlNzA3NWQg
MTAwNzU1DQotLS0gYS9ydW5sdHANCisrKyBiL3J1bmx0cA0KQEAgLTgxMyw3
ICs4MTMsOSBAQCBtYWluKCkNCiAJaWYgWyAkQUxUX0RNRVNHX09VVCAtZXEg
MSBdIDsgdGhlbg0KIAkJI1dlIHdhbnQgdG8gcHJpbnQgZG1lc2cgb3V0cHV0
IGZvciBlYWNoIHRlc3QsbGV0cyBkbyB0aGUgdHJpY2sgaW5zaWRlIHRoZSBz
Y3JpcHQNCiAJCWVjaG8gRW5hYmxpbmcgZG1lc2cgb3V0cHV0IGxvZ2dpbmcg
Zm9yIGVhY2ggdGVzdC4uLg0KLQkJJHtMVFBST09UfS9iaW4vY3JlYXRlX2Rt
ZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5wbCAke1RNUH0vYWxsdGVzdHMg
JERNRVNHX0RJUiA+ICR7VE1QfS9hbGx0ZXN0cy50bXANCisJCWF3ayAtdiBE
TUVTR19ESVI9JERNRVNHX0RJUiBcDQorCQkJLWYgJHtMVFBST09UfS9iaW4v
Y3JlYXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5hd2sgXA0KKwkJ
CSR7VE1QfS9hbGx0ZXN0cyA+ICR7VE1QfS9hbGx0ZXN0cy50bXANCiAJCWNw
ICR7VE1QfS9hbGx0ZXN0cy50bXAgJHtUTVB9L2FsbHRlc3RzDQogCQlybSAt
cmYgJHtUTVB9L2FsbHRlc3RzLnRtcA0KIAlmaQ0KZGlmZiAtLWdpdCBhL3Rv
b2xzL2NyZWF0ZV9kbWVzZ19lbnRyaWVzX2Zvcl9lYWNoX3Rlc3QuYXdrIGIv
dG9vbHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9yX2VhY2hfdGVzdC5hd2sN
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4zNjI5ZjA3
DQotLS0gL2Rldi9udWxsDQorKysgYi90b29scy9jcmVhdGVfZG1lc2dfZW50
cmllc19mb3JfZWFjaF90ZXN0LmF3aw0KQEAgLTAsMCArMSwzMiBAQA0KKyMh
L3Vzci9iaW4vYXdrIC1mDQorIw0KKyMgICAgU2NyaXB0IGZvciBhZGRpbmcg
bmVjZXNzYXJ5IGRtZXNnIGNsZWFyL2NhcHR1cmUgY2FsbHMgYmVmb3JlIGV4
ZWN1dGluZw0KKyMgICAgY29tbWFuZHMuDQorIw0KKyMgICAgQ29weXJpZ2h0
IChDKSAyMDEyLCBMaW51eCBUZXN0IFByb2plY3QuDQorIw0KKyMgICAgVGhp
cyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkNCisjICAgIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlz
aGVkIGJ5DQorIyAgICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBl
aXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KKyMgICAgKGF0
IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4NCisjDQorIyAgICBU
aGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBp
dCB3aWxsIGJlIHVzZWZ1bCwNCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQor
IyAgICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNV
TEFSIFBVUlBPU0UuICBTZWUgdGhlDQorIyAgICBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KKyMNCisjICAgIFlvdSBz
aG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGFsb25nDQorIyAgICB3aXRoIHRoaXMgcHJvZ3Jh
bTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uLCBJbmMuLA0KKyMgICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBG
bG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4NCisjDQorIyBHYXJy
ZXR0IENvb3BlciwgQXByaWwgMjAxMg0KKyMNCisNCitORiAmJiAhIC9eIy8g
ew0KKwlzID0gJDEgIl9fd2l0aF9kbWVzZ19lbnRyeSBkbWVzZyAtYyAxPi9k
ZXYvbnVsbCAyPiYxOyINCisJZm9yIChpID0gMjsgaSA8PSBORjsgaSsrKSB7
DQorCQlzID0gcyAiICIgJGkNCisJfQ0KKwlzID0gcyAiOyBkbWVzZyA+ICIg
RE1FU0dfRElSICIvIiAkMSAiLmRtZXNnLmxvZyINCisJcHJpbnQgcw0KK30N
CmRpZmYgLS1naXQgYS90b29scy9jcmVhdGVfZG1lc2dfZW50cmllc19mb3Jf
ZWFjaF90ZXN0LnBsIGIvdG9vbHMvY3JlYXRlX2RtZXNnX2VudHJpZXNfZm9y
X2VhY2hfdGVzdC5wbA0KZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQppbmRl
eCBhZmI0ODdmLi4wMDAwMDAwDQotLS0gYS90b29scy9jcmVhdGVfZG1lc2df
ZW50cmllc19mb3JfZWFjaF90ZXN0LnBsDQorKysgL2Rldi9udWxsDQpAQCAt
MSw3NCArMCwwIEBADQotIyEvdXNyL2Jpbi9wZXJsDQotIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCi0jIyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAjIw0KLSMjIENvcHlyaWdodCAoYykgSW50ZXJuYXRp
b25hbCBCdXNpbmVzcyBNYWNoaW5lcyAgQ29ycC4sIDIwMTAgICAgICAgICAg
ICAgICAgICMjDQotIyMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IyMNCi0jIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgICAgICAjIw0KLSMj
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5ICAgICAgICMjDQotIyMgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0
aGUgTGljZW5zZSwgb3IgICAgICAgICAgIyMNCi0jIyAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjIw0KLSMjICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMjDQotIyMgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCAgICAg
ICAgIyMNCi0jIyBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVu
IHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSAjIw0K
LSMjIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLiAgU2Vl
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAgICMjDQotIyMgZm9y
IG1vcmUgZGV0YWlscy4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMNCi0jIyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAjIw0KLSMjIFlvdSBzaG91bGQgaGF2ZSBy
ZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlICAgICAgICAgICMjDQotIyMgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07
ICBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlICAgICAgICAg
ICAgICAgIyMNCi0jIyBGb3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxh
Y2UsIFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAwMjExMS0xMzA3IFVTQSAgICAj
Iw0KLSMjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCi0jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAjIw0KLSMgRmlsZSA6ICAgICAgICBj
cmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90ZXN0LnBsCQkJICAgICAg
IyMNCi0jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIw0KLSMg
VXNhZ2U6ICAgICAgICBjcmVhdGVfZG1lc2dfZW50cmllc19mb3JfZWFjaF90
ZXN0LnBsXAkJCSAgICAgICMjDQotIwkJPExUUF9DT01NQU5EX0ZJTEU+IDxE
TUVTR19ESVJFQ1RPUlk+CQkJICAgICAgIyMNCi0jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjIw0KLSMgRGVzY3JpcHRpb246ICBUaGlzIGlz
IGEgc2ltcGxlIHBlcmwgc2NyaXB0IHdoaWNoIHdpbGwgdGFrZSBsdHAgY29t
bWFuZCBmaWxlICMjDQotIwkJYXMgaW5wdXQgYW5kIHRoZW4gY3JlYXRlIGEg
ZmluYWwgY29tbWFuZCBmaWxlIHdoaWNoIHdpbGwgaGF2ZSAjIw0KLSMJCXRo
ZSBmb2xsb3dpbmcgZW50cmllcyBmb3IgZWFjaCB0ZXN0IHRhZzoJCSAgICAg
ICMjDQotIwkJPHRhZ19uYW1lX193aXRoX2RtZXNnX2VudHJ5PiA8dGVzdF9i
aW5hcnlfbmFtZT47XAkgICAgICAjIw0KLSMJCTxzYXZlX2RtZXNnX2xvZ3M+
CQkJICAgICAgCQkgICAgICAjIw0KLSMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICMjDQotIyBBdXRob3I6ICAgICAgIFN1YnJhdGEgTW9kYWsg
PHN1YnJhdGFAbGludXgudm5ldC5pYm0uY29tPiAgICAgICAgICAgICAgICAg
ICAgIyMNCi0jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIw0K
LSMgSGlzdG9yeTogICAgICBNYXkgMDkgMjAxMCAtIENyZWF0ZWQgLSBTdWJy
YXRhIE1vZGFrLiAgICAgICAgICAgICAgICAgICAgICAgICMjDQotIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMNCi0NCi1teSAkY29tbWFu
ZF9maWxlCT0gc2hpZnQgKEBBUkdWKSB8fCBzeW50YXgoKTsNCi1teSAkZG1l
c2dfZGlyCQk9IHNoaWZ0IChAQVJHVikgfHwgc3ludGF4KCk7DQotDQotc3Vi
IHN5bnRheCgpIHsNCi0JcHJpbnQgInN5bnRheDogY3JlYXRlX2RtZXNnX2Vu
dHJpZXNfZm9yX2VhY2hfdGVzdC5wbCA8TFRQX0NPTU1BTkRfRklMRT4gPERN
RVNHX0RJUkVDVE9SWT5cbiI7DQotCWV4aXQgKDEpOw0KLX0NCi0NCi0NCi1v
cGVuIChGSUxFLCAkY29tbWFuZF9maWxlKSB8fCBkaWUgIkNhbm5vdCBvcGVu
IGZpbGU6ICRjb21tYW5kX2ZpbGVcbiI7DQotd2hpbGUgKCRsaW5lID0gPEZJ
TEU+KSB7DQotCWlmICgkbGluZSA9fiAvXiMvKSB7DQotCQlwcmludCAiJGxp
bmUiOw0KLQkJbmV4dDsNCi0JfQ0KLQlpZiAoJGxpbmUgPX4gL15cbiQvKSB7
DQotCQluZXh0Ow0KLQl9DQotCWNob21wICRsaW5lOw0KLQlAdGFnX2FuZF9h
Y3R1YWxfY29tbWFuZCA9IHNwbGl0KC9cIC8sICRsaW5lKTsNCi0NCi0JbXkg
JHRva2VuX2NvdW50ZXIgPSAwOw0KLQlteSAkdGFnX25hbWUgPSAiIjsNCi0J
Zm9yZWFjaCBteSAkdG9rZW4gKEB0YWdfYW5kX2FjdHVhbF9jb21tYW5kKSB7
DQotCQlpZiAoJHRva2VuX2NvdW50ZXIgPT0gMCApIHsNCi0JCQlwcmludCAk
dG9rZW4gLiAiX193aXRoX2RtZXNnX2VudHJ5IiAuICIgIjsNCi0JCQlwcmlu
dCAiZG1lc2cgLWMgMT4vZGV2L251bGwgMj4vZGV2L251bGw7IiAuICIgIjsN
Ci0JCQkkdG9rZW5fY291bnRlcisrOw0KLQkJCSR0YWdfbmFtZSA9ICR0b2tl
bjsNCi0JCQluZXh0Ow0KLQkJfQ0KLQkJcHJpbnQgIiAiIC4gJHRva2VuIC4g
IiAiOw0KLQl9DQotCXByaW50ICI7IGRtZXNnID4gJGRtZXNnX2Rpci8kdGFn
X25hbWUuZG1lc2cubG9nIFxuIjsNCi19DQotY2xvc2UgKEZJTEUpOw0KLQ0K
DQotLS0tLS0tLS0tLS0tLTEuNy45LjQtLQ0KDQoNCg==

--967339439-1370441924-1333517147=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--967339439-1370441924-1333517147=:25027
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--967339439-1370441924-1333517147=:25027--

