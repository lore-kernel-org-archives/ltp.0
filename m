Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liuhangbin@gmail.com>) id 1Z9osp-0003bV-I5
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:19:03 +0000
Received: from mail-pa0-f43.google.com ([209.85.220.43])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z9oso-00087K-QA
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2015 06:19:03 +0000
Received: by pacws9 with SMTP id ws9so192971pac.0
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Jun 2015 23:18:57 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 30 Jun 2015 14:18:45 +0800
Message-Id: <1435645125-5434-1-git-send-email-liuhangbin@gmail.com>
Subject: [LTP] [PATCH] containers: Use raw setns syscall for versions of
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

On RHEL6.6, the kernel support setns syscall, but glibc(2.12) does not support
this syscall. Thus ltp build failed with "userns04.c:58: undefined reference
to `setns'". Use raw setns syscall to make ltp build pass.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 testcases/kernel/containers/userns/userns_helper.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/containers/userns/userns_helper.h b/testcases/kernel/containers/userns/userns_helper.h
index da03bae..9107886 100644
--- a/testcases/kernel/containers/userns/userns_helper.h
+++ b/testcases/kernel/containers/userns/userns_helper.h
@@ -15,6 +15,19 @@
 #include "test.h"
 #include "safe_macros.h"
 
+/*
+ * Use raw setns syscall for versions of glibc that don't include it (namely
+ * glibc-2.12)
+ */
+#if __GLIBC__ == 2 && __GLIBC_MINOR__ < 14
+#ifdef SYS_setns
+int setns(int fd, int nstype)
+{
+	return syscall(SYS_setns, fd, nstype);
+}
+#endif
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
