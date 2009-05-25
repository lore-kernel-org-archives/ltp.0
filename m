Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1M8aok-00021z-6i
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 14:06:18 +0000
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4086379727
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 May 2009 15:52:24 +0200 (CEST)
Date: Mon, 25 May 2009 15:52:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090525135223.GA2546@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
Subject: [LTP] [PATCH] postponing close() after aio_write() has finished
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


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
in aio_return/1-1.c close() is called after asynchronous I/O write was
queued. This according to POSIX may end up in one of two ends and it's
implementation specified. One end is writing the file correctly while the other
one is behave like aio_cancel() was called.
(http://www.opengroup.org/onlinepubs/9699919799/functions/close.html)
Test mentoined above rely on finishing asynchronous I/O correctly in this case.
To fix that you must postpone close() after asynchronous I/O has finished.

Signed-of-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--azLHFNyN32YCQGCU
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="aio_write_race.patch"

Index: ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
===================================================================
--- ltp-full-20090430.orig/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
+++ ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfaces/aio_return/1-1.c
@@ -75,12 +75,11 @@ int main()
 		exit(PTS_FAIL);
 	}
 
-	close(fd);
-
 	do {
 		retval = aio_error( &aiocb);
 		if (retval == -1)
 		{
+			close(fd);
 			printf(TNAME " Error at aio_error(): %s\n",
 				strerror(errno));
 			exit(PTS_FAIL);
@@ -90,11 +89,13 @@ int main()
 	retval = aio_return(&aiocb);
 	if (retval != BUF_SIZE)
 	{
+		close(fd);
 		printf(TNAME " Error at aio_return(): %s\n",
 		       strerror(errno));
 		exit(PTS_FAIL);
 	}
 	
+	close(fd);
 	printf ("Test PASSED\n");
 	return PTS_PASS;
 }

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
--azLHFNyN32YCQGCU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--azLHFNyN32YCQGCU--

