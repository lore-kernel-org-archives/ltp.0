Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri0oE-0000F5-0b
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:37:30 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri0oC-0005wi-T6
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 09:37:29 +0000
Message-ID: <4F02CC46.9000106@imgtec.com>
Date: Tue, 3 Jan 2012 09:37:10 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040906040507050100000709"
Subject: [LTP] [PATCH 03/21] test.h/tst_brkm: Drop __attribute__((noreturn))
 since tst_brk can return to caller
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

--------------040906040507050100000709
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------040906040507050100000709
Content-Type: text/plain;
	name="0003-test.h-tst_brkm-Drop-__attribute__-noreturn-since-ts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0003-test.h-tst_brkm-Drop-__attribute__-noreturn-since-ts.pa";
	filename*1="tch"

From ab2d6650577acb973f68ddfd8884fab0116e5470 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 11:42:10 +0000
Subject: [PATCH 03/21] test.h/tst_brkm: Drop __attribute__((noreturn)) since tst_brk can return to caller

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 include/test.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/test.h b/include/test.h
index 033fdbc..39bad72 100644
--- a/include/test.h
+++ b/include/test.h
@@ -189,7 +189,7 @@ void tst_resm(int ttype, char *arg_fmt, ...)
 void tst_brk(int ttype, char *fname, void (*func)(void), char *arg_fmt, ...)
 	__attribute__ ((format (printf, 4, 5)));
 void tst_brkm(int ttype, void (*func)(void), char *arg_fmt, ...)
-	__attribute__ ((format (printf, 3, 4))) LTP_ATTRIBUTE_NORETURN;
+	__attribute__ ((format (printf, 3, 4)));
 void tst_require_root(void (*func)(void));
 int  tst_environ(void);
 void tst_exit(void) LTP_ATTRIBUTE_NORETURN;
-- 
1.7.1


--------------040906040507050100000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------040906040507050100000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040906040507050100000709--


