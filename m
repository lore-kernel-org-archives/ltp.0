Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sw2b5-0003pt-DX
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 02:54:11 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sw2b4-0007PH-Cp
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 02:54:11 +0000
Received: by yhjj56 with SMTP id j56so5599200yhj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jul 2012 19:54:04 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 31 Jul 2012 10:53:45 +0800
Message-Id: <6e0436fef24c3f2fc48066a4a08594704e657950.1343703178.git.caspar@casparzhang.com>
In-Reply-To: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
References: <134772967.3599142.1343297650967.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.6"
Subject: [LTP] [PATCH] syscalls/numa: check syscall availability
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


some NUMA related syscalls: mbind, get_mempolicy are not supported on
some arches (e.g. i386), I use TEST macro to test the syscall in setup()
function, if the syscall is not implemented on the system, a TCONF
message will given like this:

get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not supported on your arch

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../syscalls/get_mempolicy/get_mempolicy01.c       |    3 +++
 testcases/kernel/syscalls/mbind/mbind01.c          |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)


--------------1.7.8.6
Content-Type: text/x-patch;
	name="0001-syscalls-numa-check-syscall-availability.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-numa-check-syscall-availability.patch"

diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index d0e372c..9179c60 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -339,6 +339,9 @@ static void cleanup(void)
 
 static void setup(void)
 {
+	/* check syscall availability */
+	TEST(syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0));
+
 	TEST_PAUSE;
 	tst_tmpdir();
 }
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 2fc6f5a..3f31970 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -300,6 +300,9 @@ TEST_END:
 
 static void setup(void)
 {
+	/* check syscall availability */
+	TEST(syscall(__NR_mbind, NULL, 0, 0, NULL, 0, 0));
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



