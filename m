From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 17:18:27 +0200
Subject: [LTP] [PATCH 2/2] [COMMITTED] syscalls/shmat: Print expected and
	actual address on failure
In-Reply-To: <20170912151827.20551-1-chrubis@suse.cz>
References: <20170912151827.20551-1-chrubis@suse.cz>
Message-ID: <20170912151827.20551-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 4c6ce58d3..b46ba6831 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -129,7 +129,9 @@ static void verify_shmat(unsigned int n)
 	}
 
 	if (expected_addr(*tc->shmaddr, addr) != addr) {
-		tst_res(TFAIL, "shared memory address was not correct");
+		tst_res(TFAIL,
+			"shared memory address %p is not correct, expected %p",
+			addr, expected_addr(*tc->shmaddr, addr));
 		goto end;
 	}
 
-- 
2.13.0

