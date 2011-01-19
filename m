Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfRv5-0006KN-Pa
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 06:53:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfRv3-00045f-Qv
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 06:53:27 +0000
Message-ID: <4D368A67.8000105@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 14:53:27 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] dup203: fix error of not using O_ACCMODE
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

Hi Garrett,

The file access mode is extracted from the return value of function fcntl() using the mask O_ACCMODE.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/dup2/dup203.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup203.c b/testcases/kernel/syscalls/dup2/dup203.c
index 51a3579..0df92b4 100644
--- a/testcases/kernel/syscalls/dup2/dup203.c
+++ b/testcases/kernel/syscalls/dup2/dup203.c
@@ -170,7 +170,7 @@ int main(int ac, char **av)
 				    "return value of 0x0, got %#x", rval);
 				break;
 			}
-			if (((rval = fcntl(fd0, F_GETFL, 0)) != O_WRONLY)) {
+			if ((rval = (fcntl(fd0, F_GETFL, 0) & O_ACCMODE)) != O_WRONLY) {
 				tst_resm(TFAIL, "fctnl F_GETFL bad rval on fd0 "
 					"Expected %#x got %#x", O_WRONLY, rval);
 			}
@@ -212,4 +212,4 @@ void cleanup()
 	TEST_CLEANUP;
 
 	tst_rmdir();
-}
\ No newline at end of file
+}
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
