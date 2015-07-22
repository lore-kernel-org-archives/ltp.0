Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1ZHk9u-00007W-Fn
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 02:53:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZHk9t-0007iQ-Ew
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 02:53:26 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6M2oBCJ006487
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Jul 2015 10:50:11 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Wed, 22 Jul 2015 10:40:23 +0800
Message-ID: <1437532823-19315-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <371268015.770228.1437399185640.JavaMail.zimbra@redhat.com>
References: <371268015.770228.1437399185640.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] syscalls/getrandom: add configure check for
	linux/random.h
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
To: ltp-list@lists.sourceforge.net

For simplicity, I think we should just verify whether 'linux/random.h'
is valid, here if it's valid, that means such codes will be compiled correctly.

  #include <linux/random.h>
  int main(void)
  {
  	getrandom(NULL, 100, 0);
  	return 0;
  }
Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 m4/ltp-linuxrandom.m4 | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/m4/ltp-linuxrandom.m4 b/m4/ltp-linuxrandom.m4
index 30c099e..4b7e585 100644
--- a/m4/ltp-linuxrandom.m4
+++ b/m4/ltp-linuxrandom.m4
@@ -16,6 +16,20 @@ dnl
 dnl LTP_CHECK_LINUXRANDOM
 dnl ----------------------------
 dnl
-AC_DEFUN([LTP_CHECK_LINUXRANDOM],[
-AC_CHECK_HEADERS(linux/random.h, [], [], [])]
-)
+
+AC_DEFUN([LTP_CHECK_LINUXRANDOM],[dnl
+	AC_MSG_CHECKING([for linux/random.h])
+	AC_COMPILE_IFELSE([AC_LANG_SOURCE([
+
+#include <linux/random.h>
+int main(void) {
+	return 0;
+}])],[has_linux_random_h="yes"])
+
+if test "x$has_linux_random_h" = xyes; then
+	AC_DEFINE(HAVE_LINUX_RANDOM_H,1,[Define to 1 if having a valid linux/random.h])
+	AC_MSG_RESULT(yes)
+else
+	AC_MSG_RESULT(no)
+fi
+])
-- 
1.8.2.1


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
