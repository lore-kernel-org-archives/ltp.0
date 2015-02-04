Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YIz8k-00059j-DH
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 12:33:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIz8b-0004kq-4A
	for ltp-list@lists.sourceforge.net; Wed, 04 Feb 2015 12:33:06 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t14CWpe6015890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Feb 2015 07:32:51 -0500
Received: from robin.brq.redhat.com (robin.brq.redhat.com [10.34.24.36])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t14CWmwU023652
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Feb 2015 07:32:50 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Wed,  4 Feb 2015 13:32:43 +0100
Message-Id: <1423053163-13483-2-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1423053163-13483-1-git-send-email-jjaburek@redhat.com>
References: <1423053163-13483-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 2/2] getrusage04: skip on QEMU/kvm in addition to Xen
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

This test is unstable under QEMU as well, given the extra scheduling
on top of the virtual CPUs.

getrusage04    0  TINFO  :  utime:           0us; stime:         622us
getrusage04    0  TINFO  :  utime:           0us; stime:        1548us
getrusage04    0  TINFO  :  utime:           0us; stime:        2547us
getrusage04    0  TINFO  :  utime:           0us; stime:        3543us
getrusage04    0  TINFO  :  utime:           0us; stime:        4541us
getrusage04    0  TINFO  :  utime:        2770us; stime:        4541us
getrusage04    1  TFAIL  :  getrusage04.c:130: utime increased > 2000us:

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/getrusage/getrusage04.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
index 3640295..9d4cccd 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage04.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -201,8 +201,9 @@ static void setup(void)
 {
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
-	if (tst_is_virt(VIRT_XEN))
-		tst_brkm(TCONF, NULL, "This testcase is not supported on Xen.");
+	if (tst_is_virt(VIRT_XEN) || tst_is_virt(VIRT_KVM))
+		tst_brkm(TCONF, NULL, "This testcase is not supported on this"
+		        " virtual machine.");
 
 	BIAS_MAX = guess_timer_resolution();
 
-- 
2.1.0


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
