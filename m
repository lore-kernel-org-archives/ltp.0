Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1PyLjT-0006Ar-QK
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 10:07:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PyLjR-0005oN-S0
	for ltp-list@lists.sourceforge.net; Sat, 12 Mar 2011 10:07:35 +0000
Message-ID: <4D7B45F3.90703@cn.fujitsu.com>
Date: Sat, 12 Mar 2011 18:07:47 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] ftest06.c: fix a bug of using option -i
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


When using option -i, the case will print the following error message:
# ./ftest06 -i 2
ftest06     1  TPASS  :  Test passed.
ftest06     2  TFAIL  :         Can't chdir(/tmp/fteBX4U5O/ftest06.7461/tmp/fteBX4U5O/ftest06.7461): errno=ENOENT(2): No such file or directory

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/fs/ftest/ftest06.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index 18eae5d..d59a18f 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -140,10 +140,10 @@ int main(int ac, char *av[])
 			}
 		}
 		cwd = startdir;
-		strcat(dirname, cwd);
+		strcpy(dirname, cwd);
 		sprintf(tmpname, "/ftest06.%d", getpid());
 		strcat(dirname, tmpname);
-		strcat(homedir, cwd);
+		strcpy(homedir, cwd);
 		sprintf(tmpname, "/ftest06h.%d", getpid());
 		strcat(homedir, tmpname);
 
-- 
1.7.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
