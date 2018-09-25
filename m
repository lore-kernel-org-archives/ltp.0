From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 25 Sep 2018 14:00:03 +0200
Subject: [LTP] [PATCH] ipc/shm: properly return EIDRM in shm_lock()
In-Reply-To: <20180824030920.GD3677@linux-r8p5>
References: <20180823024051.GC13343@shao2-debian>
 <20180823041434.GC3677@linux-r8p5>
 <20180824030920.GD3677@linux-r8p5>
Message-ID: <CAK8P3a3TMUbqLtde-wJyvF+H31VTPQwCKCqPjf41dwGMK-vbQg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 24, 2018 at 5:09 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> When getting rid of the general ipc_lock(), this was missed
> furthermore, making the comment around the ipc object validity
> check bogus. Under EIDRM conditions, callers will in turn not
> see the error and continue with the operation.
>
> Fixes: 82061c57ce9 (ipc: drop ipc_lock())
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---

Oddly, this change introduces a gcc warning in some configurations
(i.e. with randstruct enabled):

ipc/shm.c: In function 'shm_lock':
ipc/shm.c:209:9: note: randstruct: casting between randomized
structure pointer types (ssa): 'struct shmid_kernel' and 'struct
kern_ipc_perm'
  return (void *)ipcp;
         ^~~~~~~~~~~~

Not sure why we didn't see that warning before, probably
it ended up making its own thing when the return code
was uninitialized.

The change below gets rid of the warning, but is a bit ugly.

       Arnd

diff --git a/ipc/shm.c b/ipc/shm.c
index fe3c42e66a48..922012a745e5 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -180,10 +180,12 @@ static inline struct shmid_kernel
*shm_obtain_object_check(struct ipc_namespace
 static inline struct shmid_kernel *shm_lock(struct ipc_namespace *ns, int id)
 {
        struct kern_ipc_perm *ipcp;
+       int ret;

        rcu_read_lock();
        ipcp = ipc_obtain_object_idr(&shm_ids(ns), id);
-       if (IS_ERR(ipcp))
+       ret = PTR_ERR_OR_ZERO(ipcp);
+       if (ret)
                goto err;

        ipc_lock_object(ipcp);
@@ -199,14 +201,14 @@ static inline struct shmid_kernel
*shm_lock(struct ipc_namespace *ns, int id)
        }

        ipc_unlock_object(ipcp);
-       ipcp = ERR_PTR(-EIDRM);
+       ret = -EIDRM;
 err:
        rcu_read_unlock();
        /*
         * Callers of shm_lock() must validate the status of the returned ipc
         * object pointer and error out as appropriate.
         */
-       return (void *)ipcp;
+       return ERR_PTR(ret);
 }

 static inline void shm_lock_by_ptr(struct shmid_kernel *ipcp)
