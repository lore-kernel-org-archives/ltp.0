Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UjhPX-0001H5-N4
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 02:55:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UjhPW-0008TI-Ce
	for ltp-list@lists.sourceforge.net; Tue, 04 Jun 2013 02:55:47 +0000
Message-ID: <51AD568E.7090402@cn.fujitsu.com>
Date: Tue, 04 Jun 2013 10:53:02 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51AD55F0.8030402@cn.fujitsu.com>
In-Reply-To: <51AD55F0.8030402@cn.fujitsu.com>
Subject: [LTP] [PATCH v2] shmget/shmget01.c: attach SHM_NORESERVE to shmflg
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
To: LTP list <ltp-list@lists.sourceforge.net>


Add SHM_NORESERVE to shmflg to test

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmget/shmget01.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget01.c b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
index aa2c78b..a4ac172 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget01.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget01.c
@@ -62,7 +62,8 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;

-		TEST(shmget(shmkey, SHM_SIZE, IPC_CREAT | IPC_EXCL | SHM_RW));
+		TEST(shmget(shmkey, SHM_SIZE,
+			    IPC_CREAT | IPC_EXCL | SHM_RW | SHM_NORESERVE));

 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-- 
1.7.1

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
