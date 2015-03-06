Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YTvHL-0002nE-O9
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:39:11 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YTvHJ-0001Ly-Pu
	for ltp-list@lists.sourceforge.net; Fri, 06 Mar 2015 16:39:11 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t26Gd2u4021065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:39:03 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t26Gd17K018276
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Mar 2015 11:39:02 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Fri,  6 Mar 2015 17:39:00 +0100
Message-Id: <1425659940-24365-1-git-send-email-jjaburek@redhat.com>
In-Reply-To: <54F9D3FA.6040503@redhat.com>
References: <54F9D3FA.6040503@redhat.com>
Subject: [LTP] [PATCHv2] syscalls/sync_file_range01: support 31-bit s390
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

The ifdef'd part is identical to how arm/ppc handles big endianness,
however the syscall number and argument order are different.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/sync_file_range/sync_file_range01.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index 3d26f8f..33d2e31 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -196,7 +196,7 @@ void setup(void)
 static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 				 unsigned int flags)
 {
-
+/* arm and powerpc */
 #if (defined(__arm__) || defined(__powerpc__) || defined(__powerpc64__))
 #if (__WORDSIZE == 32)
 #if __BYTE_ORDER == __BIG_ENDIAN
@@ -210,10 +210,16 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 #else
 	return ltp_syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
 #endif
+
+/* s390 */
+#elif (defined(__s390__) || defined(__s390x__)) && __WORDSIZE == 32
+	return ltp_syscall(__NR_sync_file_range, fd, (int)(offset >> 32),
+		(int)offset, (int)(nbytes >> 32), (int)nbytes, flags);
+
+/* other */
 #else
 	return ltp_syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
 #endif
-
 }
 
 /******************************************************************************/
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
