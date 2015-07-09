Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZD29I-0005W2-J0
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 03:05:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZD29H-0006La-Oy
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 03:05:20 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 9 Jul 2015 11:05:19 +0800
Message-ID: <1436411125-8012-5-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55842886.4090202@oracle.com>
	<1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 05/11] asapi_03: Use 'tst_tmpdir' and more cleanup
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
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

* Use 'tst_tmpdir' and 'tst_rmdir'.
* Add 'static' for the cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_03.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
index f458d7d..61be294 100644
--- a/testcases/network/lib6/asapi_03.c
+++ b/testcases/network/lib6/asapi_03.c
@@ -181,6 +181,7 @@ static struct ftent {
 };
 
 static void setup(void);
+static void cleanup(void);
 static void do_test(const struct ftent *);
 
 char *TCID = "asapi_03";
@@ -201,15 +202,23 @@ int main(int argc, char *argv[])
 			do_test(&ftab[i]);
 	}
 
+	cleanup();
 	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
 	TEST_PAUSE;
+
+	tst_tmpdir();
+}
+
+static void cleanup(void)
+{
+	tst_rmdir();
 }
 
-void do_test(const struct ftent *ftptr)
+static void do_test(const struct ftent *ftptr)
 {
 	switch (ftptr->ft_type) {
 	case EXISTS:
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
