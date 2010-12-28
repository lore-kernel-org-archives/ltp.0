Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PXQaW-0004k0-Fn
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 03:51:04 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXQaV-0001ul-8Z
	for ltp-list@lists.sourceforge.net; Tue, 28 Dec 2010 03:51:04 +0000
Message-ID: <4D195DE8.4070209@cn.fujitsu.com>
Date: Tue, 28 Dec 2010 11:47:52 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH]Fix bug of add_key01
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

Never pass TPASS to tst_brkm, tst_brkm will set TBROK to T_exitval,
then cause test fail.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 testcases/kernel/syscalls/add_key/add_key01.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/add_key/add_key01.c b/testcases/kernel/syscalls/add_key/add_key01.c
index ffa2f68..3786c9a 100644
--- a/testcases/kernel/syscalls/add_key/add_key01.c
+++ b/testcases/kernel/syscalls/add_key/add_key01.c
@@ -127,8 +127,7 @@ int main(int ac, char **av) {
 					NULL, 0,
 					KEY_SPEC_THREAD_KEYRING));
 			if (TEST_RETURN != -1) {
-				tst_brkm(TPASS, cleanup,
-				    "add_key call succeeded");
+				tst_resm(TPASS, "add_key call succeeded");
 			} else {
 				tst_resm(TFAIL|TTERRNO, "%s failed", TCID);
 			}
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
