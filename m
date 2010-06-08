Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@localhost.localdomain>) id 1OLy1J-0002gP-8F
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 12:35:05 +0000
Received: from gw.wifiinternet.cz ([89.31.42.6] helo=localhost.localdomain)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OLy1H-0004en-7L
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 12:35:05 +0000
From: monstr@monstr.eu
Date: Tue,  8 Jun 2010 14:32:51 +0200
Message-Id: <1276000371-32401-1-git-send-email-monstr@monstr.eu>
Subject: [LTP] [PATCH] syscalls: getdtablesize01 fix for missing /etc/hosts
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
Cc: Michal Simek <monstr@monstr.eu>, michal.simek@petalinux.com.monstr.eu

From: Michal Simek <monstr@monstr.eu>

Embedded systems doesn't need to contain /etc/hosts that's why
will be good to create it if doesn't exist. If file doesn't exist
then syscall test failed.

Error:
getdtablesize01    0  TINFO  :  Maximum number of files a process can have opened is 1024
getdtablesize01    0  TINFO  :  Checking with the value returned by getrlimit...RLIMIT_NOFILE
getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
getdtablesize01    0  TINFO  :  Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1
Opened file num -1
getdtablesize01    2  TFAIL  :  0 != 1023

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 .../syscalls/getdtablesize/getdtablesize01.c       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
index a495501..568e1ad 100644
--- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
+++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
@@ -83,7 +83,7 @@ int main()
 	tst_resm(TINFO,
 		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
 	for (loop = 1; loop <= max_val_opfiles; loop++) {
-		fd = open("/etc/hosts", O_RDONLY);
+		fd = open("/etc/hosts", O_RDONLY | O_CREAT);
 #ifdef DEBUG
 		printf("Opened file num %d\n", fd);
 #endif
-- 
1.5.5.6


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
