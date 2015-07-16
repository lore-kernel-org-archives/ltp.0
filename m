Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFbkb-0005NY-4p
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:29 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFbka-0005nb-8Z
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:29 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 13:30:45 +0800
Message-ID: <1437024647-2066-9-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 09/11] asapi_07: Use 'tst_tmpdir' and more cleanup
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
 testcases/network/lib6/asapi_07.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/network/lib6/asapi_07.c b/testcases/network/lib6/asapi_07.c
index 826cea6..97221f7 100644
--- a/testcases/network/lib6/asapi_07.c
+++ b/testcases/network/lib6/asapi_07.c
@@ -86,6 +86,7 @@ static struct etent {
 };
 
 static void setup(void);
+static void cleanup(void);
 static void adatet(const struct etent *etptr);
 
 char *TCID = "asapi_07";
@@ -106,12 +107,20 @@ int main(int argc, char *argv[])
 			adatet(&etab[i]);
 	}
 
+	cleanup();
 	tst_exit();
 }
 
 void setup(void)
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
 
 /*  existence tests */
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
