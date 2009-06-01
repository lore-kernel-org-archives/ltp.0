Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MBDJ9-0006rR-P0
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 19:36:31 +0000
Date: Mon, 1 Jun 2009 21:36:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090601193622.GA690@schrodinger.suse.cz>
References: <20090528094621.GA6470@schrodinger.suse.cz>
	<1243601695.5188.36.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <1243601695.5188.36.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [chrubis@suse.cz: Re: [PATCH] fix missing return
	in	several files.]
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
today I was digging a bit deeper into this source and find out following:
tst_exit() is defined as __attribute__ ((noreturn)). That's hint for gcc
compiler that this function never exits, so far it's good.

Problem in these two tests is that they pass tst_exit as cleanup function to
tst_brkm(). But function tst_brkm() is not defined as __attribute__
((noreturn)). So we have function that never retuns and we have the same
problem again. The fix is trivial, instead of passing tst_exit() as cleanup
function just call it directly.

Patch attached.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--17pEHd4RhPHOinZp
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix-tst_return.patch"

Index: ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/io/aio/aio01/aio01.c
+++ ltp-full-20090430/testcases/kernel/io/aio/aio01/aio01.c
@@ -426,7 +426,8 @@ void cleanup() {
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+	tst_brkm(TCONF, NULL, "libaio missing");
+	tst_exit();
 }
 
 #endif
Index: ltp-full-20090430/testcases/kernel/io/aio/aio02/main.c
===================================================================
--- ltp-full-20090430.orig/testcases/kernel/io/aio/aio02/main.c
+++ ltp-full-20090430/testcases/kernel/io/aio/aio02/main.c
@@ -23,18 +23,20 @@ int main(void)
 
 	res = test_main();
 	printf("test %s completed %s.\n", test_name,
-		res ? "FAILED" : "PASSED"
-		);
+		res ? "FAILED" : "PASSED");
 	fflush(stdout);
 	return res ? 1 : 0;
 }
+
 #else
+
 char *TCID = "aio02/" TEST_NAME;
 int TST_TOTAL=0;
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+	tst_brkm(TCONF, NULL, "libaio missing");
+	tst_exit();
 }
 
 #endif

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--17pEHd4RhPHOinZp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--17pEHd4RhPHOinZp--

