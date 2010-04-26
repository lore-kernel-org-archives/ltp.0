Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6TzH-0005Lv-R6
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 19:28:59 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3FFB88D893
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 21:28:52 +0200 (CEST)
Date: Mon, 26 Apr 2010 21:36:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426193633.GA19120@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
Subject: [LTP] [PATCH] add missing return into pidns17.c
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


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch adds return 0; at the end of main() in the pidns17.c (and also
removes some spurious code comments). This patch fixes compiler warning which
some builds systems treats as error and thuss breaks package building.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--uAKRQypu60I7Lcqm
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="missing_return_pidns17.patch"

Index: ltp-full-20100228/testcases/kernel/containers/pidns/pidns17.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/containers/pidns/pidns17.c
+++ ltp-full-20100228/testcases/kernel/containers/pidns/pidns17.c
@@ -141,7 +141,9 @@ int main(int argc, char *argv[])
 
 	/* cleanup and exit */
 	CLEANUP();
-}	/* End main */
+
+	return 0;
+}
 
 /*
  * cleanup() - performs all ONE TIME cleanup for this test at
@@ -149,8 +151,6 @@ int main(int argc, char *argv[])
  */
 void cleanup()
 {
-	/* Clean the test testcase as LTP wants*/
 	TEST_CLEANUP;
 	tst_exit();
-	/* NOTREACHED */
 }

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--uAKRQypu60I7Lcqm--

