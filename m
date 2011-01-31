Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pjyfm-0004jC-15
	for ltp-list@lists.sourceforge.net; Mon, 31 Jan 2011 18:40:22 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 53BE79486B
	for <ltp-list@lists.sourceforge.net>;
	Mon, 31 Jan 2011 19:40:13 +0100 (CET)
Date: Mon, 31 Jan 2011 19:58:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110131185830.GA5618@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
Subject: [LTP] [PATCH] the very last patch for timer_create
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
For some reason timer_create/11-1.c is missing call for reading time
into ts_start, which is the reason for the tescase to fail. Patch is
attached.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

--xHFwDpU9dbj6ez1V
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="timer_create_missing.patch"

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
index 447c7ed..321b7bc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_create/11-1.c
@@ -73,6 +73,11 @@ int main(int argc, char *argv[])
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_THREAD_CPUTIME_ID, &ts_start) != 0) {
+		perror("clock_gettime() failed");
+		return PTS_UNRESOLVED;
+	}
+	
 	if (timer_settime(tid, 0, &its, NULL) != 0) {
 		perror("timer_settime did not return success");
 		return PTS_UNRESOLVED;

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--xHFwDpU9dbj6ez1V--

