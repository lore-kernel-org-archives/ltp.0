Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shhuiw@gmail.com>) id 1SBUnE-0006K9-TV
	for ltp-list@lists.sourceforge.net; Sat, 24 Mar 2012 17:30:20 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SBUnE-0006Jj-BO
	for ltp-list@lists.sourceforge.net; Sat, 24 Mar 2012 17:30:20 +0000
Received: by mail-iy0-f175.google.com with SMTP id g37so7647805iaa.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 24 Mar 2012 10:30:20 -0700 (PDT)
Message-ID: <4F6E04A0.10305@gmail.com>
Date: Sun, 25 Mar 2012 01:30:08 +0800
From: Wang Sheng-Hui <shhuiw@gmail.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] testcases/kernel/mem/vma/vma01.c: fix the right
 start/end memory address
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
To: ltp-list@lists.sourceforge.net, shubham@linux.vnet.ibm.com

For a VMA with memory range 6*ps, regardless of it's two 3*ps or
one single 6*ps, t is the start addr of the vma, u = t + 3*ps, and
the end addr is t + 6*ps.

For the check process, x should start from t, not u, and later check
for the second 3*ps should resume from u.

Signed-off-by: Wang Sheng-Hui <shhuiw@gmail.com>
---
 testcases/kernel/mem/vma/vma01.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma01.c b/testcases/kernel/mem/vma/vma01.c
index 398d7a1..4b66121 100644
--- a/testcases/kernel/mem/vma/vma01.c
+++ b/testcases/kernel/mem/vma/vma01.c
@@ -112,12 +112,12 @@ static void check_vma(void)
 		printf("child : u = %p\n", u);
 		memset(u, 2, ps);
 
-		x = get_end_addr(u, MAPS_FILE);
-		if (x == u + 6*ps)
+		x = get_end_addr(t, MAPS_FILE);
+		if (x == t + 6*ps)
 			exit(1);
-		if (x == u + 3*ps) {
-			y = get_end_addr(x, MAPS_FILE);
-			if (y == x + 3*ps)
+		if (x == u) {
+			y = get_end_addr(u, MAPS_FILE);
+			if (y == u + 3*ps)
 				exit(0);
 		}
 		exit(255);
-- 
1.7.1

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
