Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Pop8t-0005AJ-0v
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 03:30:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pop8r-0003mz-0n
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 03:30:26 +0000
Message-ID: <4D58A1DA.5020005@cn.fujitsu.com>
Date: Mon, 14 Feb 2011 11:30:34 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fallocate03.c: the case should exit when fallocate
 system call is not implemented
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate03.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index 78bc412..924b189 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -267,9 +267,8 @@ int main(int ac, char **av)
 			/* check return code */
 			if (TEST_RETURN != test_data[test_index].error) {
 				if (TEST_ERRNO == EOPNOTSUPP || TEST_ERRNO == ENOSYS) {
-					tst_resm(TCONF,
+					tst_brkm(TCONF, cleanup,
 						 "fallocate system call is not implemented");
-					cleanup();	/* calls tst_exit */
 				}
 				TEST_ERROR_LOG(TEST_ERRNO);
 				tst_resm(TFAIL|TTERRNO,
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
