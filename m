Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UVdVe-0001cv-Pe
	for ltp-list@lists.sourceforge.net; Fri, 26 Apr 2013 07:55:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UVdVd-0007ck-L5
	for ltp-list@lists.sourceforge.net; Fri, 26 Apr 2013 07:55:58 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r3Q7tpqA002343
	for <ltp-list@lists.sourceforge.net>; Fri, 26 Apr 2013 15:55:51 +0800
Message-ID: <517A3282.2050809@cn.fujitsu.com>
Date: Fri, 26 Apr 2013 15:53:38 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <517A31DE.2050003@cn.fujitsu.com>
In-Reply-To: <517A31DE.2050003@cn.fujitsu.com>
Subject: [LTP] [PATCH 2/2] syscalls/mount/mount02.c: modify array "exp_enos"
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

Expected errno setted in array "exp_enos" do not match
echo test item rightly, leading to two problems:

* Not every test item in mount02 is executed.
     There are 13 test items in mount02 currently to test error:
     ENODEV, ENOTBLK, EBUSY, EBUSY, EINVAL, EINVAL, EINVAL, EFAULT,
     EFAULT, ENAMETOOLONG, ENOENT, ENOENT, ENOTDIR

     But, only 8 of them are tested as specified in array "exp_enos":
     ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,
     ENOENT, ENOTDIR

* For test item which is executed, its errno returned is maybe not
the one expected.

This patch modifies array "exp_enos" to make it one-to-one correspondent
with echo test item, to fix above problems.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount02.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount02.c b/testcases/kernel/syscalls/mount/mount02.c
index 8dcf8de..95796f2 100644
--- a/testcases/kernel/syscalls/mount/mount02.c
+++ b/testcases/kernel/syscalls/mount/mount02.c
@@ -81,8 +81,10 @@ static char *device;
 static int Tflag;
 static int Dflag;

-static int exp_enos[] = { ENODEV, ENOTBLK, EBUSY, EINVAL, EFAULT, ENAMETOOLONG,
-	ENOENT, ENOTDIR, 0
+static int exp_enos[] = {
+	ENODEV, ENOTBLK, EBUSY, EBUSY, EINVAL,
+	EINVAL, EINVAL, EFAULT, EFAULT, ENAMETOOLONG,
+	ENOENT, ENOENT, ENOTDIR, 0
 };

 int TST_TOTAL = (sizeof(exp_enos) / sizeof(exp_enos[0])) - 1;
-- 
1.8.1

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
