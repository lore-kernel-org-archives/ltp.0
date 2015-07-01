Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1ZAAfj-0005D8-7r
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:34:59 +0000
Received: from mail-pa0-f44.google.com ([209.85.220.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZAAfi-0004ej-Ig
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 05:34:59 +0000
Received: by paceq1 with SMTP id eq1so17123205pac.3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2015 22:34:53 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed,  1 Jul 2015 13:34:42 +0800
Message-Id: <1435728882-9272-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCHv2] containers: Use raw setns syscall for versions of
	glibc that don't include it
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
To: LTP List <ltp-list@lists.sourceforge.net>

The setns() system call was added to glibc in version 2.14. On systems with
lower version glic, like RHEL6.6 glibc 2.12, ltp will build failed with
error "userns04.c:58: undefined reference to `setns'". Use ltp_syscall to make
build pass.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/userns/userns_helper.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
index da03bae..21e5cb8 100644
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ b/testcases/kernel/containers/userns/userns_helper.h
@@ -15,6 +15,16 @@
 #include "test.h"
 #include "safe_macros.h"
 
+/*
+ * Use raw setns syscall for versions of glibc that don't include it
+ */
+#if __GLIBC__ <= 2 && __GLIBC_MINOR__ < 14
+int setns(int fd, int nstype)
+{
+	return ltp_syscall(__NR_setns, fd, nstype);
+}
+#endif
+
 static int dummy_child(void *v)
 {
 	(void) v;
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
