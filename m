Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1T6Hkq-0007Lu-QN
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 09:06:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6Hkl-0000cN-Ad
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 09:06:36 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q7S96O7S000442
	for <ltp-list@lists.sourceforge.net>; Tue, 28 Aug 2012 17:06:24 +0800
Message-ID: <503C89D7.5030305@cn.fujitsu.com>
Date: Tue, 28 Aug 2012 17:05:27 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <503C8866.9000909@cn.fujitsu.com>
In-Reply-To: <503C8866.9000909@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2]sigpause/3-1.c Fix hung
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
To: LTP list <ltp-list@lists.sourceforge.net>

If sem is set as INTHREAD finally,the loop will be endless.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../open_posix_testsuite/conformance/interfaces/sigpause/3-1.c      |
  3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git
a/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
index 00024ed..6f1f454 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c
@@ -30,7 +30,7 @@
 #define INMAIN 1

 int result = 2;
-int sem = INMAIN;
+int sem = INTHREAD;

 void handler()
 {
@@ -86,7 +86,6 @@ int main()
 		return PTS_UNRESOLVED;
 	}

-	sem = INTHREAD;
 	while (sem == INTHREAD)
 		sleep(1);

-- 
1.7.10.2

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
