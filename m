Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YR3wE-0001Pz-VN
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 19:17:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YR3wD-0003nB-3c
	for ltp-list@lists.sourceforge.net; Thu, 26 Feb 2015 19:17:34 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1QJHQDJ025277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Feb 2015 14:17:26 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t1QJHPIT012343
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Feb 2015 14:17:25 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Thu, 26 Feb 2015 20:17:14 +0100
Message-Id: <1424978234-21530-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH] syscalls/fadvise03: add alternative expected
	s390-only values
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

Since this test tries 0-32 values as 'advice', it needs to expect the
little-known ABI hack used for fadvise64 on s390 in the kernel,
see Linux kernel commit 068e1b94bbd268f375349f68531829c8b7c210bc.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/fadvise/posix_fadvise03.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index db88765..1e77740 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -65,9 +65,25 @@ int defined_advise[] = {
 	POSIX_FADV_NORMAL,
 	POSIX_FADV_SEQUENTIAL,
 	POSIX_FADV_RANDOM,
-	POSIX_FADV_NOREUSE,
 	POSIX_FADV_WILLNEED,
+#if defined(__s390__) && __WORDSIZE == 32
+	/* POSIX_FADV_DONTNEED and POSIX_FADV_NOREUSE are 6,7 on 31bit s390,
+	 * but the kernel accepts 4,5 as well and rewrites them internally,
+	 * see Linux kernel commit 068e1b94bbd268f375349f68531829c8b7c210bc
+	 *
+	 * since header definitions are incomplete - posix fcntl.h doesn't care
+	 * and defines them as 4,5 while linux/fadvise.h (which uses 6,7)
+	 * matches only 64bit - we need to hardcode the values here for
+	 * all 4 cases, unfortunately
+	 */
+	4, /* POSIX_FADV_DONTNEED */
+	5, /* POSIX_FADV_NOREUSE */
+	6, /* POSIX_FADV_DONTNEED */
+	7, /* POSIX_FADV_NOREUSE */
+#else
 	POSIX_FADV_DONTNEED,
+	POSIX_FADV_NOREUSE,
+#endif
 };
 
 #define defined_advise_total (sizeof(defined_advise) / sizeof(defined_advise[0]))
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
