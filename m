Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1Zz-0002qk-AT
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:17:55 +0000
Received: from mail-yx0-f192.google.com ([209.85.210.192])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1Zy-0001vp-GP
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:17:55 +0000
Received: by yxe30 with SMTP id 30so752220yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:17:53 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:47:52 +0530
Message-ID: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=00151750d96868e9b3046c90fc47
Subject: [LTP] [FIX HTML PATCH] ltp-genhtml
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
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--00151750d96868e9b3046c90fc47
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed following issue and fixed.
1.   Kernel Version
2.   Machine Architecture.

Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/tools/genhtml.pl b/tools/genhtml.pl
--- a/tools/genhtml.pl	2009-04-02 12:07:28.000000000 +0530
+++ b/tools/genhtml.pl	2009-06-18 00:33:46.000000000 +0530
@@ -246,8 +246,12 @@
 print "<tr><td><strong>Total Test TWARN</strong></td><td><strong>
$warn_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TRETR</strong></td><td><strong>
$retr_test_counter </strong></td></tr>\n";
 print "<tr><td><strong>Total Test TCONF</strong></td><td><strong>
$conf_test_counter </strong></td></tr>\n";
-print "<tr><td><strong>Kernel Version</strong></td><td><strong>
$ENV{KERNEL_VERSION}  </strong></td></tr>\n";
-print "<tr><td><strong>Machine Architecture</strong></td><td><strong>
$ENV{MACHINE_ARCH} </strong></td></tr>\n";
+print "<tr><td><strong>Kernel_Version</strong>  </td> <td><strong>";
+$kernel_version=system("uname -r");             chop($kernel_version);
+print " $kernel_version </strong></td></tr>\n";
+print "<tr><td><strong>Machine_Arch</strong>  </td> <td><strong>";
+$machine_arch=system("uname -m");             chop($machine_arch);
+print " $machine_arch </strong></td></tr>\n";
 print "<tr><td><strong>Hostname</strong>  </td> <td><strong>";
 $hostname=system("uname -n");             chop($hostname);
 print " $hostname </strong></td></tr></tbody></table></div></body></html>\n";

--00151750d96868e9b3046c90fc47
Content-Type: application/octet-stream; name="ltp-fix-genhtml.patch"
Content-Disposition: attachment; filename="ltp-fix-genhtml.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2hcogo0

ZGlmZiAtTmF1cmIgYS90b29scy9nZW5odG1sLnBsIGIvdG9vbHMvZ2VuaHRtbC5wbAotLS0gYS90
b29scy9nZW5odG1sLnBsCTIwMDktMDQtMDIgMTI6MDc6MjguMDAwMDAwMDAwICswNTMwCisrKyBi
L3Rvb2xzL2dlbmh0bWwucGwJMjAwOS0wNi0xOCAwMDozMzo0Ni4wMDAwMDAwMDAgKzA1MzAKQEAg
LTI0Niw4ICsyNDYsMTIgQEAKIHByaW50ICI8dHI+PHRkPjxzdHJvbmc+VG90YWwgVGVzdCBUV0FS
Tjwvc3Ryb25nPjwvdGQ+PHRkPjxzdHJvbmc+ICR3YXJuX3Rlc3RfY291bnRlciA8L3N0cm9uZz48
L3RkPjwvdHI+XG4iOwogcHJpbnQgIjx0cj48dGQ+PHN0cm9uZz5Ub3RhbCBUZXN0IFRSRVRSPC9z
dHJvbmc+PC90ZD48dGQ+PHN0cm9uZz4gJHJldHJfdGVzdF9jb3VudGVyIDwvc3Ryb25nPjwvdGQ+
PC90cj5cbiI7CiBwcmludCAiPHRyPjx0ZD48c3Ryb25nPlRvdGFsIFRlc3QgVENPTkY8L3N0cm9u
Zz48L3RkPjx0ZD48c3Ryb25nPiAkY29uZl90ZXN0X2NvdW50ZXIgPC9zdHJvbmc+PC90ZD48L3Ry
PlxuIjsKLXByaW50ICI8dHI+PHRkPjxzdHJvbmc+S2VybmVsIFZlcnNpb248L3N0cm9uZz48L3Rk
Pjx0ZD48c3Ryb25nPiAkRU5We0tFUk5FTF9WRVJTSU9OfSAgPC9zdHJvbmc+PC90ZD48L3RyPlxu
IjsKLXByaW50ICI8dHI+PHRkPjxzdHJvbmc+TWFjaGluZSBBcmNoaXRlY3R1cmU8L3N0cm9uZz48
L3RkPjx0ZD48c3Ryb25nPiAkRU5We01BQ0hJTkVfQVJDSH0gPC9zdHJvbmc+PC90ZD48L3RyPlxu
IjsKK3ByaW50ICI8dHI+PHRkPjxzdHJvbmc+S2VybmVsX1ZlcnNpb248L3N0cm9uZz4gIDwvdGQ+
IDx0ZD48c3Ryb25nPiI7Ciska2VybmVsX3ZlcnNpb249c3lzdGVtKCJ1bmFtZSAtciIpOyAgICAg
ICAgICAgICBjaG9wKCRrZXJuZWxfdmVyc2lvbik7IAorcHJpbnQgIiAka2VybmVsX3ZlcnNpb24g
PC9zdHJvbmc+PC90ZD48L3RyPlxuIjsKK3ByaW50ICI8dHI+PHRkPjxzdHJvbmc+TWFjaGluZV9B
cmNoPC9zdHJvbmc+ICA8L3RkPiA8dGQ+PHN0cm9uZz4iOworJG1hY2hpbmVfYXJjaD1zeXN0ZW0o
InVuYW1lIC1tIik7ICAgICAgICAgICAgIGNob3AoJG1hY2hpbmVfYXJjaCk7IAorcHJpbnQgIiAk
bWFjaGluZV9hcmNoIDwvc3Ryb25nPjwvdGQ+PC90cj5cbiI7CiBwcmludCAiPHRyPjx0ZD48c3Ry
b25nPkhvc3RuYW1lPC9zdHJvbmc+ICA8L3RkPiA8dGQ+PHN0cm9uZz4iOwogJGhvc3RuYW1lPXN5
c3RlbSgidW5hbWUgLW4iKTsgICAgICAgICAgICAgY2hvcCgkaG9zdG5hbWUpOyAKIHByaW50ICIg
JGhvc3RuYW1lIDwvc3Ryb25nPjwvdGQ+PC90cj48L3Rib2R5PjwvdGFibGU+PC9kaXY+PC9ib2R5
PjwvaHRtbD5cbiI7Cg==
--00151750d96868e9b3046c90fc47
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--00151750d96868e9b3046c90fc47
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00151750d96868e9b3046c90fc47--

