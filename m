Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P8YfM-0005if-JG
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 13:25:16 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8YfI-00056K-Pr
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 13:25:16 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P8YfD-000807-CV
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Oct 2010 14:25:07 +0100
Received: from cpe-66-68-83-102.austin.res.rr.com ([66.68.83.102]
	helo=sergelap) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <serge.hallyn@canonical.com>) id 1P8YfD-00085t-6V
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 14:25:07 +0100
Date: Wed, 20 Oct 2010 08:25:05 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20101020132505.GA5985@hallyn.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH 1/1] securebits: fix running of testcases
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

Exit as soon as one breaks.  Heck, clean it up by letting
set -e do it for me.

Signed-off-by: Serge Hallyn <serge.hallyn@canonical.com>
---
 .../kernel/security/securebits/run_securebits.sh   |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/security/securebits/run_securebits.sh b/testcases/kernel/security/securebits/run_securebits.sh
index 4d9e272..19df70c 100644
--- a/testcases/kernel/security/securebits/run_securebits.sh
+++ b/testcases/kernel/security/securebits/run_securebits.sh
@@ -1,20 +1,12 @@
 #!/bin/sh
 
+set -e
+
 echo "testing keepcaps"
 check_keepcaps 1
-tmp=$?
-if [ $tmp -ne 0 ]; then
-	exit_code=$tmp
-fi
+
 check_keepcaps 2
-tmp=$?
-if [ $tmp -ne 0 ]; then
-	exit_code=$tmp
-fi
+
 check_keepcaps 3
-tmp=$?
-if [ $tmp -ne 0 ]; then
-	exit_code=$tmp
-fi
 
-exit $exit_code
+exit 0
-- 
1.7.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
