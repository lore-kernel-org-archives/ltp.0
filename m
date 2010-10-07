Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eramoto.masaya@jp.fujitsu.com>) id 1P3mxo-0003U3-2U
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 09:40:36 +0000
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P3mxl-0005Pa-Pp
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 09:40:36 +0000
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o979eR8v022939 for <ltp-list@lists.sourceforge.net> (envelope-from
	eramoto.masaya@jp.fujitsu.com); Thu, 7 Oct 2010 18:40:27 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id C56FE45DE4F
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:26 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 924A045DE4C
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:26 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 756BB1DB8015
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:26 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 1602F1DB8013
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:23 +0900 (JST)
Received: from m108.css.fujitsu.com (m108 [127.0.0.1])
	by m108.s.css.fujitsu.com (Postfix) with ESMTP id DE0C4B68002
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:22 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.124.101.142])
	by m108.s.css.fujitsu.com (Postfix) with ESMTP id 7E028428052
	for <ltp-list@lists.sourceforge.net>;
	Thu,  7 Oct 2010 18:40:22 +0900 (JST)
Message-ID: <4CAD957D.4060900@jp.fujitsu.com>
Date: Thu, 07 Oct 2010 18:40:13 +0900
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060507060408030401060708"
Subject: [LTP] [PATCH] fix typo of $PROG_SCRIPT in
	run-all-posix-option-group-tests.sh
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
To: ltp-list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060507060408030401060708
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi,

I found a tiny typo of $PROG_SCRIPT in run-all-posix-option-group-tests.sh.

Because of this typo, this shell script doesn't run the test of open_posix_testsuite at all.
It output the following message:
===============
# ./bin/run-all-posix-option-group-tests.sh
./bin/run-all-posix-option-group-tests.sh: line 14: AIO: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: MEM: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: MSG: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: SEM: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: SIG: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: THR: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: TMR: command not found
./bin/run-all-posix-option-group-tests.sh: line 14: TPS: command not found
===============

The attached patch will fix it.


Signed-off-by: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
===============
diff --git a/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh b/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
index a9b2c05..39ff989 100755
--- a/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
+++ b/testcases/open_posix_testsuite/bin/run-all-posix-option-group-tests.sh
@@ -8,7 +8,7 @@
 #

 FAILED=0
-RPOG_SCRIPT="$(dirname "$0")/run-posix-option-group-test.sh"
+PROG_SCRIPT="$(dirname "$0")/run-posix-option-group-test.sh"

 for option_group in AIO MEM MSG SEM SIG THR TMR TPS; do
        if ! $PROG_SCRIPT $option_group; then
===============

Thanks,
ERAMOTO

--------------060507060408030401060708
Content-Type: text/plain;
	name="posix-fix-typo-of-PROG_SCRIPT-in-run-all-posix-option-group-tests.sh.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="posix-fix-typo-of-PROG_SCRIPT-in-run-all-posix-option-group-";
	filename*1="tests.sh.patch"

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9iaW4vcnVuLWFs
bC1wb3NpeC1vcHRpb24tZ3JvdXAtdGVzdHMuc2ggYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUvYmluL3J1bi1hbGwtcG9zaXgtb3B0aW9uLWdyb3VwLXRlc3RzLnNoCmluZGV4
IGE5YjJjMDUuLjM5ZmY5ODkgMTAwNzU1Ci0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rl
c3RzdWl0ZS9iaW4vcnVuLWFsbC1wb3NpeC1vcHRpb24tZ3JvdXAtdGVzdHMuc2gKKysrIGIv
dGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2Jpbi9ydW4tYWxsLXBvc2l4LW9wdGlv
bi1ncm91cC10ZXN0cy5zaApAQCAtOCw3ICs4LDcgQEAKICMKIAogRkFJTEVEPTAKLVJQT0df
U0NSSVBUPSIkKGRpcm5hbWUgIiQwIikvcnVuLXBvc2l4LW9wdGlvbi1ncm91cC10ZXN0LnNo
IgorUFJPR19TQ1JJUFQ9IiQoZGlybmFtZSAiJDAiKS9ydW4tcG9zaXgtb3B0aW9uLWdyb3Vw
LXRlc3Quc2giCiAKIGZvciBvcHRpb25fZ3JvdXAgaW4gQUlPIE1FTSBNU0cgU0VNIFNJRyBU
SFIgVE1SIFRQUzsgZG8KIAlpZiAhICRQUk9HX1NDUklQVCAkb3B0aW9uX2dyb3VwOyB0aGVu
Cg==
--------------060507060408030401060708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--------------060507060408030401060708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060507060408030401060708--


