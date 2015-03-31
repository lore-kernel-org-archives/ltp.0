Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cuibixuan@huawei.com>) id 1Ycmfa-0004uz-65
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 03:16:50 +0000
Received: from [119.145.14.66] (helo=szxga03-in.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YcmfV-000796-AZ
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 03:16:50 +0000
From: cuibixuan <cuibixuan@huawei.com>
Date: Tue, 31 Mar 2015 03:16:04 +0000
Message-ID: <1427771764-22918-1-git-send-email-cuibixuan@huawei.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] syscalls/utimensat01: "chattr" command error
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
To: ltp-list@lists.sourceforge.net

Run testcase "utimensat01":

Pathname test
chattr: Inappropriate ioctl for device while reading flags on /tmp/ltp-FAAVCPyWnz/utimensat_tests/utimensat.test_file
./utimensat01 -q /tmp/ltp-FAAVCPyWnz/utimensat_tests/utimensat.test_file 0 n 0 o
EXPECTED: EPERM
RESULT:   SUCCESS 1421205831 0
FAILED test 46

Readable file descriptor (futimens(3)) test
chattr: Inappropriate ioctl for device while reading flags on /tmp/ltp-FAAVCPyWnz/utimensat_tests/utimensat.test_file
./utimensat01 -q -d /tmp/ltp-FAAVCPyWnz/utimensat_tests/utimensat.test_file NULL 0 n 0 o
EXPECTED: EPERM
RESULT:   SUCCESS 1421205834 0
FAILED test 47
...
Failed tests:  46 47 48 49 50 51 52 53 54 55 56 57 58 61 62 63 64 65 66 67 68 69 70 73 74 75 76 77 78 

The "chattr" command in case failed in some file system (such as memory fs):
chattr: Inappropriate ioctl for device while reading flags on 
I learn that chattr command only can be used in ext2 or ext3 (ext4 is ok now).

So we check it before running and test log on no-ext2 file system:

incrementing stop
test sudo for -n option, non-interactive
sudo supports -n
chattr: Inappropriate ioctl for device while reading flags on /tmp/ltp-IiAnqhwQST/utimensat_tests/tmp_file
utimensat01    1  TBROK  :  ltpapicmd.c:190: the chattr command is not supported in test dir

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 .../testcases/kernel/syscalls/utimensat/utimensat_tests.sh       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index b8eba51..972c81f 100755
--- a/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/ltp-master/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -300,6 +300,15 @@ nuke_sudoers()
 }
 
 sudo $s_arg -u $test_user mkdir -p $TEST_DIR
+
+# Make sure chattr command is supported in test dir
+touch $TEST_DIR/tmp_file
+chattr +a $TEST_DIR/tmp_file
+if [ $? -ne 0 ] ; then
+        tst_resm TBROK "the chattr command is not supported in test dir"
+        exit 1
+fi
+
 cd $TEST_DIR
 chown root $LTPROOT/testcases/bin/$TEST_PROG
 chmod ugo+x,u+s $LTPROOT/testcases/bin/$TEST_PROG
-- 
1.8.2.2


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
