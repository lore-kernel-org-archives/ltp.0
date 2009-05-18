Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M63NQ-0005mc-CA
	for ltp-list@lists.sourceforge.net; Mon, 18 May 2009 13:59:36 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 7F6CD8E8CC
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 May 2009 15:58:48 +0200 (CEST)
Date: Mon, 18 May 2009 15:58:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090518135848.GA1060@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Subject: [LTP]  [PATCH] fix missing return in several files.
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


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
these three patches fixes missing return 0; statements.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--mYCpIKhGyMATD0i+
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

--mYCpIKhGyMATD0i+
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

--mYCpIKhGyMATD0i+
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix-ima_mmap-return-value.patch"

Index: ltp-full-20090430/testcases/kernel/security/integrity/ima/src/ima_mmap.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ ltp-full-20090430/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -48,4 +48,6 @@ int main(int argc, char *argv[])
 		perror("unmap");
 		return(-1);
 	}
+
+	return 0;
 }

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--mYCpIKhGyMATD0i+--

