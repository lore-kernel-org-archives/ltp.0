Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T1adD-0000vc-4t
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 10:15:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T1adC-0007yN-Hf
	for ltp-list@lists.sourceforge.net; Wed, 15 Aug 2012 10:15:19 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7FAFCuL010843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Aug 2012 06:15:12 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id q7FAFB4B002420
	for <ltp-list@lists.sourceforge.net>; Wed, 15 Aug 2012 06:15:11 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Aug 2012 12:14:34 +0200
Message-Id: <4505db854dcfba3131523a89e158cae4f9c27d01.1345025497.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] ioctl: check if tty device nodes are usable
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

ioctl testcases fail on s390x because it doesn't
support virtual consoles.

Trying to use such device node fails:
ioctl01_02    0  TINFO  :  Testing ioctl01 with /dev/tty0
ioctl01     1  TBROK  :  Couldn't open /dev/tty0: errno=ENXIO(6): No
such device or address

This patch tries to get terminal line settings for each tty,
that would be used in test. If that fails, tty is skipped.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/test_ioctl |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/test_ioctl b/testcases/kernel/syscalls/ioctl/test_ioctl
index e824ff7..062212b 100755
--- a/testcases/kernel/syscalls/ioctl/test_ioctl
+++ b/testcases/kernel/syscalls/ioctl/test_ioctl
@@ -23,11 +23,27 @@ export TCID=ioctl01_02
 export TST_TOTAL=2
 export TST_COUNT=0
 
+has_tty()
+{
+    if command -v stty >/dev/null 2>&1; then
+        stty --file=$1 > /dev/null
+        if [ $? -ne 0 ]; then
+            return 0;
+        fi
+    fi
+    return 1;
+}
+
 for tttype in `ls /dev/tty*`
 do
 device_no=${tttype#/dev/tty}
 case "$device_no" in
 [0-9]|[0-9][0-9])
+    has_tty $tttype
+    if [ $? -eq 0 ]; then
+        tst_resm TINFO "Skipping ioctl01 with $tttype"
+        continue;
+    fi
     tst_resm TINFO "Testing ioctl01 with $tttype"
     ioctl01 -D $tttype
     RC=$?
@@ -46,6 +62,11 @@ do
 device_no=${tttype#/dev/tty}
 case "$device_no" in
 [0-9]|[0-9][0-9])
+    has_tty $tttype
+    if [ $? -eq 0 ]; then
+        tst_resm TINFO "Skipping ioctl02 with $tttype"
+        continue;
+    fi
     tst_resm TINFO "Testing ioctl02 with $tttype"
     ioctl02 -D $tttype
     RC=$?
-- 
1.7.1


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
