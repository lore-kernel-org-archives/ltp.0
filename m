Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MgzLR-0003kl-44
	for ltp-list@lists.sourceforge.net; Fri, 28 Aug 2009 11:10:13 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id 4D34674862
	for <ltp-list@lists.sourceforge.net>;
	Fri, 28 Aug 2009 13:09:56 +0200 (CEST)
Date: Fri, 28 Aug 2009 13:09:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090828110955.GA21300@schrodinger.suse.cz>
References: <20090601193622.GA690@schrodinger.suse.cz>
	<20090602.074642.226786039.caiqian@cclom.cn>
	<20090602001451.GA19251@schrodinger.suse.cz>
	<20090602.105034.226785759.caiqian@cclom.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20090602.105034.226785759.caiqian@cclom.cn>
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
To: ltp-list@lists.sourceforge.net


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
this problem has been forgotten for some time
but it still makes trouble with too strict buildsystems.

See attached patch that also fixes minor style problems.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--vtzGhvizbBRQ85DL
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="aio01-return.patch"

Index: ltp-full-20090731/testcases/kernel/io/aio/aio01/aio01.c
===================================================================
--- ltp-full-20090731.orig/testcases/kernel/io/aio/aio01/aio01.c
+++ ltp-full-20090731/testcases/kernel/io/aio/aio01/aio01.c
@@ -68,9 +68,9 @@ int TST_TOTAL=6;
 #include <sys/time.h>
 #include <sys/resource.h>
 
-void help();
-void setup();
-void cleanup();
+static void help(void);
+static void setup(void);
+static void cleanup(void);
 
 #define mapsize (1 << 14)
 
@@ -96,7 +96,8 @@ struct test_case_t {
 	{0, "ftruncate mmaped file to 0 size"},
 };
 
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 	int i, j, sec, usec;
 	int failflag=0;
 	int bflag=0, nflag=0, Fflag=0;
@@ -364,13 +365,15 @@ int main(int argc, char **argv) {
 	return 0;
 }
 
-void help() {
+static void help(void)
+{
 	printf("  -b n    Buffersize\n");
 	printf("  -n n    Number of requests\n");
 	printf("  -F s    Filename to run the tests against\n");
 }
 
-void setup() {
+static void setup(void)
+{
 	int ret;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -411,7 +414,7 @@ void setup() {
 				strerror(ret));
 }
 
-void cleanup() {
+static void cleanup(void) {
 	TEST_CLEANUP;
 	free(dstbuf);
 	free(srcbuf);
@@ -427,7 +430,8 @@ void cleanup() {
 
 int main(void)
 {
-  tst_brkm(TCONF, tst_exit, "libaio missing");
+  tst_resm(TCONF, "libaio missing");
+  tst_exit();
 }
 
 #endif

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--vtzGhvizbBRQ85DL--

