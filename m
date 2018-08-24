From: Davidlohr Bueso <dave@stgolabs.net>
Date: Thu, 23 Aug 2018 20:09:20 -0700
Subject: [LTP] [PATCH] ipc/shm: properly return EIDRM in shm_lock()
In-Reply-To: <20180823041434.GC3677@linux-r8p5>
References: <20180823024051.GC13343@shao2-debian>
 <20180823041434.GC3677@linux-r8p5>
Message-ID: <20180824030920.GD3677@linux-r8p5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When getting rid of the general ipc_lock(), this was missed
furthermore, making the comment around the ipc object validity
check bogus. Under EIDRM conditions, callers will in turn not
see the error and continue with the operation.

Fixes: 82061c57ce9 (ipc: drop ipc_lock())
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index b0eb3757ab89..4cd402e4cfeb 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -199,6 +199,7 @@ static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 	}
 
 	ipc_unlock_object(ipcp);
+	ipcp = ERR_PTR(-EIDRM);
 err:
 	rcu_read_unlock();
 	/*
-- 
2.16.4

