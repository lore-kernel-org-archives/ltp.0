From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:01 +0200
Subject: [LTP] [COMMITTED] [PATCH 28/40] Make use of SAFE_FCNTL()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-28-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index c778db086..aa29cf9ea 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -76,15 +76,13 @@ void *thread_fn_01(void *arg)
 
 	for (i = 0; i < writes_num; ++i) {
 		lck.l_type = F_WRLCK;
-		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
-			tst_brk(TBROK | TERRNO, "fcntl() failed");
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
 
 		SAFE_LSEEK(fd, 0, SEEK_END);
 		SAFE_WRITE(1, fd, buf, write_size);
 
 		lck.l_type = F_UNLCK;
-		if (fcntl(fd, F_OFD_SETLKW, &lck) == -1)
-			tst_brk(TBROK | TERRNO, "fcntl() failed");
+		SAFE_FCNTL(fd, F_OFD_SETLKW, &lck);
 
 		sched_yield();
 	}
-- 
2.13.5

