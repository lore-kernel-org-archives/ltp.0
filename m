Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <penght@cn.fujitsu.com>) id 1PfTGN-00036Z-6t
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:19:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfTGL-0004fo-HN
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:19:31 +0000
Message-ID: <4D369E98.4060602@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 16:19:36 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] fsync02: fix error of overflow from MUL
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

If the third argument is SEEK_SET of function fsync(), offset can not be
negative. But when overflow from MUL, the offset is negative.

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/fsync/fsync02.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel/syscalls/fsync/fsync02.c
index 213eac3..64bb012 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -102,7 +102,7 @@ int main(int ac, char **av)
 		}
 
 		for (i = 1; i <= data_blocks; i++) {
-			offset = (i * BLOCKSIZE * max_block) / data_blocks - BUFSIZ;
+			offset = (BLOCKSIZE * max_block) / data_blocks * i - BUFSIZ;
 			if ((offsetret = lseek(fd, offset, SEEK_SET)) != offset)
 				tst_brkm(TBROK|TERRNO, cleanup, "lseek failed: %ld, %ld", offsetret, offset);
 			if ((ret = write(fd, pbuf, BUFSIZ)) != BUFSIZ)
@@ -197,4 +197,4 @@ void cleanup()
 
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
