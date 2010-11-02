Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PD5pz-0006Fj-Nw
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 01:38:59 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD5pv-0005Pi-Ly
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 01:38:59 +0000
Message-ID: <4CCF6B53.5050109@cn.fujitsu.com>
Date: Tue, 02 Nov 2010 09:37:23 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [POSIX][PATCH]Cleanup the test shm_open/2-1 to make a good
	format
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
To: yanegomi@gmail.com
Cc: ltp-list@lists.sourceforge.net

Although it's not important, but it makes a noise in the log.

----------------------------------------------------------------
Cleanup the test shm_open/2-1 to make a good format.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../conformance/interfaces/shm_open/2-1.c          |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c
index f4bab48..b0adce6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_open/2-1.c
@@ -17,7 +17,9 @@
 
 int main()
 {
-        printf("Will not test that the shm_open() function create an open file description\nthat refers to the shared memory object and a file descriptor that refers to\nthat open file description.");
+        printf("Will not test that the shm_open() function create an open file"
+	       "description that refers to the shared memory object and a file"
+	       "descriptor that refers to that open file description.\n");
         return PTS_UNTESTED;
 }
 
-- 
1.7.0.4



-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
