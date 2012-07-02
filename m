Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1SleG7-00010P-Tp
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 10:53:35 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SleG7-00031N-3S
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 10:53:35 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q62ArUVf024974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 2 Jul 2012 06:53:30 -0400
From: Eryu Guan <eguan@redhat.com>
Date: Mon,  2 Jul 2012 18:53:10 +0800
Message-Id: <1341226390-16789-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.10.2"
Subject: [LTP] [PATCH] syscalls/setxattr03: turn off immutable and append
	bit only if already set
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
--------------1.7.10.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Turn off immutable and append-only attribute in cleanup() only if they
are already turned on. Otherwise bogus WARNING would fail test case when
no xattr support in fs or mount without user_xattr option.

setxattr03    1  TCONF  :  No xattr support in fs or fs mounted without user_xattr option
setxattr03    2  TCONF  :  Remaining cases not appropriate for configuration
setxattr03    0  TWARN  :  Unset setxattr03immutable immutable failed: errno=EINVAL(22): Invalid argument
setxattr03    0  TWARN  :  Unset setxattr03appendonly append-only failed: errno=EINVAL(22): Invalid argument

(The check-fd-value way is not perfect, but I think it's much more
easier and could cover the most common case.)

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/syscalls/setxattr/setxattr03.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


--------------1.7.10.2
Content-Type: text/x-patch;
	name="0001-syscalls-setxattr03-turn-off-immutable-and-append-bi.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-setxattr03-turn-off-immutable-and-append-bi.patch"

diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index fa97a6b..47a82b0 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -202,10 +202,10 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (set_immutable_off(immu_fd))
+	if ((immu_fd > 0) && set_immutable_off(immu_fd))
 		tst_resm(TWARN | TERRNO, "Unset %s immutable failed",
 		    IMMU_FILE);
-	if (set_append_off(append_fd))
+	if ((append_fd > 0) && set_append_off(append_fd))
 		tst_resm(TWARN | TERRNO, "Unset %s append-only failed",
 		    APPEND_FILE);
 	close(immu_fd);

--------------1.7.10.2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.10.2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.10.2--



