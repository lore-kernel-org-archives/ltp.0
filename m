From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 1 Aug 2018 15:34:53 +0800
Subject: [LTP] [PATCH] syscalls/shmctl05.c: Fix ENOSPC error
Message-ID: <1533108893-13078-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running shmctl05 got the following error on some distros(e.g. RHEL7.5):
------------------------------------------------------
tst_safe_sysv_ipc.c:111: BROK: shmctl05.c:51: shmget(61455, 4096, 3c0) failed: ENOSPC
shmctl05.c:104: WARN: pthread_join(..., (nil)) failed: EDEADLK
tst_safe_sysv_ipc.c:111: BROK: shmctl05.c:81: shmget(61455, 4096, 3c0) failed: ENOSPC
-------------------------------------------------------

From shmctl(2) manpage, shmctl(IPC_RMID) just marks a shm segment to
be destroyed, and the segment will only actually be destroyed after
the last process detaches it (i.e., when the shm_nattch member of the
associated structure shmid_ds is zero).  So it is possible for the
number of created shm segments to exceed the system-wide maximum number
(e.g. shmmni is 4096) if only shmctl(IPC_RMID) has been called.

From shmdt(2) manpage, a successful shmdt(2) call will decrement
the shm_nattch by one.  So we should call shmdt(2) to decrement
the shm_nattch to zero before calling shmctl(IPC_RMID).

Add shmdt(2) to ensure that all shm segments are actually destroyed.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index a960cc9..0eb0776 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -92,6 +92,8 @@ static void do_test(void)
 				"Unexpected remap_file_pages() error");
 		}
 		tst_fzsync_wait_a(&fzsync_pair);
+		/* ensure that a shm segment will actually be destroyed */
+		SAFE_SHMDT(addr);
 	}
 
 	tst_res(TPASS, "didn't crash");
-- 
1.8.3.1



