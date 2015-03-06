Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YTvIp-0002tG-2Q
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:40:43 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YTvIo-0002P6-5z
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:40:43 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t26GeYlZ029188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:40:35 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t26GeXrR013505
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:40:34 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Fri,  6 Mar 2015 17:40:17 +0100
Message-Id: <1425660017-24409-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH] syscalls/profil01: support 31-bit s390
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

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/profil/profil01.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
index ec752cb..37106fc 100644
--- a/testcases/kernel/syscalls/profil/profil01.c
+++ b/testcases/kernel/syscalls/profil/profil01.c
@@ -49,7 +49,16 @@ static void alrm_handler(int sig)
 
 static void __attribute__ ((noinline)) *get_pc(void)
 {
+#if defined(__s390__) && __WORDSIZE == 32
+	/* taken from glibc,
+	 *   sysdeps/unix/sysv/linux/s390/s390-32/profil-counter.h
+	 * 31-bit s390 pointers don't use the 32th bit, however integers do,
+	 * so wrap the value around at 31 bits */
+	return (void *)
+		((unsigned long) __builtin_return_address(0) & 0x7fffffffUL);
+#else
 	return __builtin_return_address(0);
+#endif
 }
 
 static void test_profil(void)
-- 
2.1.0


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
