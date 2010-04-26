Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6Uxo-0003je-28
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 20:31:32 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0963D9417A
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Apr 2010 22:31:21 +0200 (CEST)
Date: Mon, 26 Apr 2010 22:39:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426203902.GA26880@saboteur.suse.cz>
References: <20100426193633.GA19120@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20100426193633.GA19120@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH] add missing return into pidns17.c
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


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Following patch adds return 0; at the end of main() in the pidns17.c (and also
> removes some spurious code comments). This patch fixes compiler warning which
> some builds systems treats as error and thuss breaks package building.

Uff, there is one more missing return in child_fn(), please apply this patch.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--YiEDa0DAkWCtVeE4
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="missing_return_pidns17_II.patch"

Index: ltp-full-20100228/testcases/kernel/containers/pidns/pidns17.c
===================================================================
--- ltp-full-20100228.orig/testcases/kernel/containers/pidns/pidns17.c
+++ ltp-full-20100228/testcases/kernel/containers/pidns/pidns17.c
@@ -111,6 +111,8 @@ int child_fn(void *arg)
 
 	/* cleanup and exit */
 	CLEANUP();
+
+	return 0;
 }
 
 /***********************************************************************
@@ -141,7 +143,9 @@ int main(int argc, char *argv[])
 
 	/* cleanup and exit */
 	CLEANUP();
-}	/* End main */
+
+	return 0;
+}
 
 /*
  * cleanup() - performs all ONE TIME cleanup for this test at
@@ -149,8 +153,6 @@ int main(int argc, char *argv[])
  */
 void cleanup()
 {
-	/* Clean the test testcase as LTP wants*/
 	TEST_CLEANUP;
 	tst_exit();
-	/* NOTREACHED */
 }

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--YiEDa0DAkWCtVeE4--

