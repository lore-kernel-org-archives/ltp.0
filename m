Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1OjSvQ-0007AA-Ma
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 08:14:08 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OjSvN-0001aE-9d
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 08:14:08 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7C8DwgL019537
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Aug 2010 01:13:59 -0700 (PDT)
Message-ID: <4C63AD3C.2090909@windriver.com>
Date: Thu, 12 Aug 2010 16:13:48 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080906090809080507050004"
Subject: [LTP] [patch]hugeshmat issue
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
--------------080906090809080507050004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

In hugeshmat01 and hugeshmat02, the attach address for shard memory is 
0x90000eee.
For 32bits mips/Linux system, user space is under 0x7FFFFFFF,
0x90000eee is too big. The new address 0x60000eee has been tested
on mips and other arch systems, it hasn't caused a issue yet.

Regards,

Lina Zhao

--------------080906090809080507050004
Content-Type: text/x-diff;
 name="hugeshmat-attach-address-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hugeshmat-attach-address-change.patch"

From e337a913dbf366f136b31e96d8662f8e111b9d81 Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Thu, 12 Aug 2010 15:27:53 +0800
Subject: [PATCH] For 32bits mips/Linux system, user space is under 0x7FFFFFFF,
 0x90000eee is too big. The new address 0x60000eee has been tested
 on mips and other arch systems, it hasn't caused a issue yet.

Signed-off-by: Lina Zhao <lina.zhao@windriver.com>
---
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |    2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 229b929..7087d26 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -70,7 +70,7 @@ unsigned long huge_pages_shm_to_be_allocated;
 #if __WORDSIZE==64
 #define UNALIGNED      0x10000000eee
 #else
-#define UNALIGNED      0x90000eee
+#define UNALIGNED      0x60000eee
 #endif
 
 int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index 2f56127..428eeab 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -74,7 +74,7 @@ void	*addr;				/* for result of shmat-call */
 #if __WORDSIZE==64
 #define NADDR   0x10000000eef           /* a 64bit non alligned address value */
 #else
-#define NADDR	0x90000eef		/* a non alligned address value */
+#define NADDR	0x60000eef		/* a non alligned address value */
 #endif
 
 struct test_case_t {
-- 
1.6.3.1


--------------080906090809080507050004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------080906090809080507050004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080906090809080507050004--

