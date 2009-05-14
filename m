Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M4htT-0000rr-0T
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 20:51:07 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 8D5EA8640B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 May 2009 22:50:45 +0200 (CEST)
Date: Thu, 14 May 2009 22:50:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090514205045.GB8023@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix missing return in several files.
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


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
these three patches fixes missing return 0; statements.

-- 
Cyril Hrubis
chrubis@suse.cz

--kORqDWCi7qDJ0mEj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix-main-return-value.patch"

Index: ltp-full-20090430/testcases/kernel/io/aio/aio02/main.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/io/aio/aio02/main.c
+++ ltp-full-20090430/testcases/kernel/io/aio/aio02/main.c
@@ -34,7 +34,9 @@ int TST_TOTAL=0;
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+	tst_brkm(TCONF, tst_exit, "libaio missing");
+
+	return 0;
 }
 
 #endif

--kORqDWCi7qDJ0mEj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix-aio01-return-value.patch"

Index: ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/io/aio/aio01/aio01.c
+++ ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
@@ -426,7 +426,9 @@ void cleanup() {
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+	tst_brkm(TCONF, tst_exit, "libaio missing");
+
+	return 0;
 }
 
 #endif

--kORqDWCi7qDJ0mEj
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix-aio01-return-value.patch"

Index: ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/io/aio/aio01/aio01.c
+++ ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
@@ -426,7 +426,9 @@ void cleanup() {
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+	tst_brkm(TCONF, tst_exit, "libaio missing");
+
+	return 0;
 }
 
 #endif

--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The NEW KODAK i700 Series Scanners deliver under ANY circumstances! Your
production scanning environment may not be a perfect world - but thanks to
Kodak, there's a perfect scanner to get the job done! With the NEW KODAK i700
Series Scanner you'll get full speed at 300 dpi even with all image 
processing features enabled. http://p.sf.net/sfu/kodak-com
--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--kORqDWCi7qDJ0mEj--

