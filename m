From: Davidlohr Bueso <dave@stgolabs.net>
Date: Wed, 22 Aug 2018 21:14:34 -0700
Subject: [LTP] [lkp-robot] [ipc] 296ba26b66:
 BUG:sleeping_function_called_from_invalid_context_at_mm/memory.c
In-Reply-To: <20180823024051.GC13343@shao2-debian>
References: <20180823024051.GC13343@shao2-debian>
Message-ID: <20180823041434.GC3677@linux-r8p5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 23 Aug 2018, kernel test robot wrote:

>FYI, we noticed the following commit (built with gcc-7):
>
>commit: 296ba26b6681b6e07ed419b3004647167cb17f61 ("ipc: drop ipc_lock()")
>https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

I suspect this is because that commit forgot to set EIDRM for the
!ipc_valid_object() case. So the callers check IS_ERR(shm_lock()),
which won't fail the op as it did before the commit.

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
