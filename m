Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XNK9a-0006JV-Gz
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 11:15:38 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XNK9Y-0004z4-72
	for ltp-list@lists.sourceforge.net; Fri, 29 Aug 2014 11:15:38 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7TBFSmO014312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 07:15:29 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7TBFR9L028206
	for <ltp-list@lists.sourceforge.net>; Fri, 29 Aug 2014 07:15:28 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Aug 2014 13:15:26 +0200
Message-Id: <fa6666c6075baadeaaa53f7cf8536ab65daf8b51.1409310860.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] ustat: check for ENOSYS
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

ustat(2) says:
  ustat() is deprecated and has only been provided for compatibility.
  All new programs should use statfs(2) instead.

Detect if ustat() is deprecated by checking that errno is ENOSYS,
and end with TCONF in that case.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ustat/ustat01.c |    4 ++++
 testcases/kernel/syscalls/ustat/ustat02.c |    5 +++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 7d9c636..f8d8734 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -55,6 +55,10 @@ int main(int argc, char *argv[])
 			TEST(ustat(dev_num, &ubuf));
 
 			if (TEST_RETURN == -1) {
+				if (TEST_ERRNO == ENOSYS)
+					tst_brkm(TCONF, cleanup,
+						"ustat() not supported");
+
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL, "ustat(2) failed and set"
 					 "the errno to %d : %s",
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 90dad14..ad51860 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -97,6 +97,7 @@ int main(int ac, char **av)
 static void setup(void)
 {
 	struct stat buf;
+	static dev_t dev_num;
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -107,6 +108,10 @@ static void setup(void)
 	/* Find a valid device number */
 	SAFE_STAT(cleanup, "/", &buf);
 
+	TEST(ustat(dev_num, &ubuf));
+	if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
+		tst_brkm(TCONF, cleanup, "ustat() not supported");
+
 	root_dev = buf.st_dev;
 }
 
-- 
1.7.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
