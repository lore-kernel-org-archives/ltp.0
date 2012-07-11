Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vlee@twitter.com>) id 1Sor3D-0005JS-9R
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 07:09:31 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sor37-00080t-T9
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 07:09:31 +0000
Received: by pbbrq2 with SMTP id rq2so1548013pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Jul 2012 00:09:19 -0700 (PDT)
From: Vinson Lee <vlee@twitter.com>
Date: Wed, 11 Jul 2012 00:09:09 -0700
Message-Id: <1341990549-30278-1-git-send-email-vlee@twitter.com>
Subject: [LTP] [PATCH] tools/t0: Use version of setpgrp that takes no
	arguments.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

IEEE Std 1003.1, 2004 Edition and IEEE Std 1003.1-2008 only have the
version of setpgrp that takes no arguments.

http://pubs.opengroup.org/onlinepubs/009695299/functions/setpgrp.html
http://pubs.opengroup.org/onlinepubs/9699919799/functions/setpgrp.html

Also fixes build error on Mac OS X 10.7.

Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 testcases/open_posix_testsuite/tools/t0.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/tools/t0.c b/testcases/open_posix_testsuite/tools/t0.c
index d8ac328..96bae9f 100644
--- a/testcases/open_posix_testsuite/tools/t0.c
+++ b/testcases/open_posix_testsuite/tools/t0.c
@@ -101,7 +101,7 @@ int main (int argc, char * argv[])
 		perror("fork failed");
 		exit(1);
 	case 0:
-		setpgrp(0, 0);
+		setpgrp();
 		execvp(argv[2], &argv[2]);
 		perror("execvp failed");
 		exit(1);
-- 
1.7.7.5 (Apple Git-26)


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
