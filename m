Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzM2X-0005HN-Tf
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:13 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzM2W-00008o-OL
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 06:16:13 +0000
Received: by yenm1 with SMTP id m1so74948yen.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 23:16:07 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Thu,  9 Aug 2012 14:15:39 +0800
Message-Id: <c34d8829b21a0e2cd2d5b1241ea751e61b993348.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
In-Reply-To: <cover.1344492473.git.caspar@casparzhang.com>
References: <cover.1344492473.git.caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall availability
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


some NUMA related syscalls: mbind, get_mempolicy are not supported on
some arches (e.g. i386), this patch checks the syscalls' availability in
setup() function, if the syscall is not implemented on the system, a
TCONF message will be given like this:

get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
 testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0003-syscalls-numa-check-syscall-availability.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-syscalls-numa-check-syscall-availability.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index d0e372c..f321172 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -339,6 +339,16 @@ static void cleanup(void)
 
 static void setup(void)
 {
+	/* check syscall availability */
+	if (syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0) == -1) {
+		if (errno == ENOSYS)
+			tst_brkm(TCONF, NULL, "syscall __NR_get_mempolicy "
+				    "not supported on your arch.");
+		else
+			tst_brkm(TBROK|TERRNO, NULL,
+				    "syscall __NR_get_mempolicy");
+	}
+
 	TEST_PAUSE;
 	tst_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 2fc6f5a..714dbf7 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -300,6 +300,15 @@ TEST_END:
 
 static void setup(void)
 {
+	/* check syscall availability */
+	if (syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0) == -1) {
+		if (errno == ENOSYS)
+			tst_brkm(TCONF, NULL, "syscall __NR_mbind "
+				    "not supported on your arch.");
+		else
+			tst_brkm(TBROK|TERRNO, NULL, "syscall __NR_mbind");
+	}
+
 	TEST_PAUSE;
 	tst_tmpdir();
 }

--------------1.7.8.6
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
--------------1.7.8.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.6--



