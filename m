Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WTAjz-0004u9-RG
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 13:53:07 +0000
Date: Thu, 27 Mar 2014 14:52:39 +0100
From: chrubis@suse.cz
Message-ID: <20140327135239.GD4234@rei>
References: <1395926898-11327-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395926898-11327-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH] doc: test-writing-guidelines
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Add thread-safety paragraph
> Add example of how to use TST_DECLARE_ONCE_FN

Pushed with minor changes:

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index a7250b7..9c3ea2a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -675,12 +675,12 @@ bellow:
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 It is safe to use library 'tst_' functions in multi-threaded tests.
-Synchronization mechanism enabled only if the test is linked with pthread
+Synchronization mechanism is enabled only if the test is linked with pthread
 library, otherwise no-op stubs (defined in libc) are used.
 
-Also, LTP has a help "TST_DECLARE_ONCE_FN" macro to declare a function which
-must be run only once (e.g. init or cleanup function), but might be called
-by multiple threads in the same time. See example below:
+Also, LTP has a helper "TST_DECLARE_ONCE_FN" macro to declare a function which
+must be run only once (e.g. init or cleanup function), but might be called by
+multiple threads at the same time. See example below:


And also updated the online version in GitHub wiki. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
