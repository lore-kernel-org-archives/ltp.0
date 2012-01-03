Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4Ia-0007Cm-7o
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:21:04 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4IZ-0008VN-H8
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:21:04 +0000
Message-ID: <4F0300B8.7050704@imgtec.com>
Date: Tue, 3 Jan 2012 13:20:56 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080102030508070408000004"
Subject: [LTP] [PATCH 15/21] fs/stream: ret variable is has an integer type
 not size_t
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

--------------080102030508070408000004
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------080102030508070408000004
Content-Type: text/plain;
	name="0015-fs-stream-ret-variable-is-has-an-integer-type-not-si.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0015-fs-stream-ret-variable-is-has-an-integer-type-not-si.pa";
	filename*1="tch"

From fd8d55e8194f7e56d35c4a291e5a64aa09f24237 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 14:53:01 +0000
Subject: [PATCH 15/21] fs/stream: ret variable is has an integer type not size_t

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/kernel/fs/stream/stream04.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/stream/stream04.c b/testcases/kernel/fs/stream/stream04.c
index 6ecac08..f88e395 100644
--- a/testcases/kernel/fs/stream/stream04.c
+++ b/testcases/kernel/fs/stream/stream04.c
@@ -88,7 +88,7 @@ int main(int ac, char *av[])
 		}
 
 		if ((size_t)ret != strlen(junk)) {
-			tst_resm(TFAIL,"strlen(junk) = %zi != return value from fwrite = %zi", strlen(junk), ret);
+			tst_resm(TFAIL,"strlen(junk) = %zi != return value from fwrite = %d", strlen(junk), ret);
 			local_flag = FAILED;
 		}
 
@@ -109,7 +109,7 @@ int main(int ac, char *av[])
 			tst_exit();
 		}
 		if ((size_t)ret != strlen(junk)) {
-			tst_resm(TFAIL,"strlen(junk) = %zi != return value from fread = %zi", strlen(junk), ret);
+			tst_resm(TFAIL,"strlen(junk) = %zi != return value from fread = %d", strlen(junk), ret);
 			local_flag = FAILED;
 		}
 		fclose(stream);
@@ -123,4 +123,4 @@ int main(int ac, char *av[])
 	} /* end for */
 	tst_rmdir();
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.1


--------------080102030508070408000004
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
--------------080102030508070408000004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080102030508070408000004--


