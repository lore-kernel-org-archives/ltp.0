Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <Zhe.He@windriver.com>) id 1fsW5G-0000Lc-Vo
 for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2018 16:34:14 +0000
Received: from mail.windriver.com ([147.11.1.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.1:ECDHE-RSA-AES256-SHA:256) (Exim 4.90_1) id 1fsW5F-00B2f4-IV
 for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2018 16:34:14 +0000
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w7MGY8Sa027132
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <ltp-list@lists.sourceforge.net>; Wed, 22 Aug 2018 09:34:08 -0700 (PDT)
From: <zhe.he@windriver.com>
Date: Thu, 23 Aug 2018 00:34:06 +0800
Message-ID: <1534955646-104428-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fs/ftest/ftest06.c: Fix too small name string and
 related failure
List-Id: Linux Test Project General Discussions
 <ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ltp-list>,
 <mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
 <mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: He Zhe <zhe.he@windriver.com>

The name string is too small to contain normal full path names and causes
the following failure.

"ftest06     2  TFAIL  :  ftest06.c:223: Can't chdir(): errno=ENOENT(2): No such file or directory"

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 testcases/kernel/fs/ftest/ftest06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/ftest/ftest06.c b/testcases/kernel/fs/ftest/ftest06.c
index 2ca7c88..b434067 100644
--- a/testcases/kernel/fs/ftest/ftest06.c
+++ b/testcases/kernel/fs/ftest/ftest06.c
@@ -100,7 +100,7 @@ static char *fstyp;
 int main(int ac, char *av[])
 {
 	int pid, child, status, count, k, j;
-	char name[3];
+	char name[MAXPATHLEN];
 
 	int lc;
 
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
