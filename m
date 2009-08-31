Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1Mi5ad-0004ET-Jo
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 12:02:27 +0000
Received: from mail-gx0-f212.google.com ([209.85.217.212])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mi5aV-00087U-RJ
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 12:02:27 +0000
Received: by gxk8 with SMTP id 8so4960110gxk.9
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Aug 2009 05:02:14 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 31 Aug 2009 17:32:14 +0530
Message-ID: <f5a7b3810908310502h61d97cafv770e664d4becb4a1@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd76054f7735704726ecd34
Subject: [LTP] LTP-LDFLAGS-enable
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
Cc: Mike Frysinger <vapier@gentoo.org>, Brandon Philips <bphilips@suse.de>, Geert.Uytterhoeven@sonycom.com

--000e0cd76054f7735704726ecd34
Content-Type: text/plain; charset=ISO-8859-1

Hi,

To make use of full testsuite of open_posix_testsuite we need to
enable LDFLAGS. It is file used by the Makefile to link to what you
specify in it. e.g. if you want to link with lpthread. By using these
Flags can build up to 1888 test case with out the flags can build up
to 486.

However, the Best practice is to use posix test suite with the LDFLAGS.

I have attached patch and below, please review the same

Best regards,
Naresh Kamboju

/************************************************************/
Before patch:
With out LDFLAGS:

		***************************
		 CONFORMANCE TEST RESULTS
		***************************
		* TOTAL:   486
		* PASSED:  449
		* FAILED:  12
		* UNRESOLVED:  7
		* UNSUPPORTED:  10
		* UNTESTED:  4
		* INTERRUPTED:  0
		* HUNG:  0
		* SEGV:  0
		* OTHERS:  4
		***************************

After patch:
With LDFLAGS:
                ***************************
                 CONFORMANCE TEST RESULTS
                ***************************
                * TOTAL:   1888
                * PASSED:  1731
                * FAILED:  26
                * UNRESOLVED:  14
                * UNSUPPORTED:  22
                * UNTESTED:  94
                * INTERRUPTED:  0
                * HUNG:  1
                * SEGV:  0
                * OTHERS:  0
                ***************************

/************************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/open_posix_testsuite/LDFLAGS
b/testcases/open_posix_testsuite/LDFLAGS
--- a/testcases/open_posix_testsuite/LDFLAGS	2005-06-03 21:59:49.000000000 +0530
+++ b/testcases/open_posix_testsuite/LDFLAGS	2009-08-31 16:22:57.000000000 +0530
@@ -8,7 +8,7 @@
 #-lpthread -D_GNU_SOURCE
 #
 #Recommended flags:
-#-D_XOPEN_SOURCE=600 -lpthread -lrt -lm
+-D_XOPEN_SOURCE=600 -lpthread -lrt -lm
 #
 # For use with Linux, you may try the following flags to
 # allow for the NPTL-specific compilation (used in some test cases)

--000e0cd76054f7735704726ecd34
Content-Type: message/rfc822; name="ltp-fix-posix-LDFLAGS.patch"
Content-Disposition: attachment; filename="ltp-fix-posix-LDFLAGS.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fz15n9ur0


ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvTERGTEFHUyBiL3Rl
c3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9MREZMQUdTCi0tLSBhL3Rlc3RjYXNlcy9vcGVu
X3Bvc2l4X3Rlc3RzdWl0ZS9MREZMQUdTCTIwMDUtMDYtMDMgMjE6NTk6NDkuMDAwMDAwMDAwICsw
NTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9MREZMQUdTCTIwMDktMDgt
MzEgMTY6MjI6NTcuMDAwMDAwMDAwICswNTMwCkBAIC04LDcgKzgsNyBAQAogIy1scHRocmVhZCAt
RF9HTlVfU09VUkNFCiAjCiAjUmVjb21tZW5kZWQgZmxhZ3M6Ci0jLURfWE9QRU5fU09VUkNFPTYw
MCAtbHB0aHJlYWQgLWxydCAtbG0KKy1EX1hPUEVOX1NPVVJDRT02MDAgLWxwdGhyZWFkIC1scnQg
LWxtCiAjCiAjIEZvciB1c2Ugd2l0aCBMaW51eCwgeW91IG1heSB0cnkgdGhlIGZvbGxvd2luZyBm
bGFncyB0bwogIyBhbGxvdyBmb3IgdGhlIE5QVEwtc3BlY2lmaWMgY29tcGlsYXRpb24gKHVzZWQg
aW4gc29tZSB0ZXN0IGNhc2VzKQo=
--000e0cd76054f7735704726ecd34
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd76054f7735704726ecd34
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd76054f7735704726ecd34--

