Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1P7fDg-0005I3-Hz
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 02:13:00 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P7fDd-0000iV-2I
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 02:13:00 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o9I2CoX4022064
	for <ltp-list@lists.sourceforge.net>;
	Sun, 17 Oct 2010 19:12:50 -0700 (PDT)
Message-ID: <4CBBAD30.6070403@windriver.com>
Date: Mon, 18 Oct 2010 10:13:04 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040400090702020100050502"
Subject: [LTP] [patch] sync_file_range01 change for arm
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040400090702020100050502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

arm use __NR_sync_file_range2 not __NR_sync_file_range for system call.
the test casecheck __NR_sync_file_range for arm,
So test react "System doesn't support" for arm.
but actually arm use __NR_sync_file_range2 to support the system call.

powerpc is big endian, arm is small endian, so the parameter dealing is 
different.

Thanks,
Lina

--------------040400090702020100050502
Content-Type: text/x-diff;
 name="sync_file_range.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sync_file_range.patch"

From c4c30c43eba9c7af025496f23bb5936f0e9f0b76 Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Thu, 14 Oct 2010 16:21:12 +0800
Subject: [PATCH] arm use __NR_sync_file_range2 not __NR_sync_file_range for system call.

So test react "System doesn't support" for arm.
but actually arm use __NR_sync_file_range2 to support the system call.

signed-off-by: Lina Zhao <lina.zhao@windriver.com>
---
 .../syscalls/sync_file_range/sync_file_range01.c   |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
index 53619b5..be82de8 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range01.c
@@ -96,7 +96,7 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
-#if defined(__powerpc__) || defined(__powerpc64__)
+#if defined(__powerpc__) || defined(__powerpc64__) || defined(__arm__)
 #ifndef __NR_sync_file_range2
 #define __NR_sync_file_range2 -1	//DUMMY VALUE
 int arch_support = 0;		//Architecure is not supported
@@ -246,6 +246,12 @@ static inline long syncfilerange(int fd, off64_t offset, off64_t nbytes,
 #elif (defined(__powerpc64__) || defined(__powerpc__)) && (__WORDSIZE==64)
 
 	return syscall(__NR_sync_file_range2, fd, flags, offset, nbytes);
+
+#elif (defined(__arm__))
+
+	return syscall(__NR_sync_file_range2, fd, flags,(int)offset,
+			(int)(offset >> 32),(int)nbytes,(int)(nbytes >> 32));
+
 #else
 
 	return syscall(__NR_sync_file_range, fd, offset, nbytes, flags);
-- 
1.6.3.1


--------------040400090702020100050502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
--------------040400090702020100050502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040400090702020100050502--

