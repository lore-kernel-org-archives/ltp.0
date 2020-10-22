From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 22 Oct 2020 13:28:58 +0100
Subject: [LTP] [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
In-Reply-To: <87sga6vizp.fsf@suse.de>
References: <87sga6vizp.fsf@suse.de>
Message-ID: <20201022122858.8638-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When use_hierarchy=1, SLAB objects which outlive their descendant
memcg are moved to their parent memcg where they may be uncharged
because charges are made recursively from leaf to root nodes.

However when use_hierarchy=0, they are reparented directly to root and
charging is not made recursively. Therefor uncharging will result in a
counter underflow on the root memcg, but no other ancestors.

To prevent this, we check whether we are about to uncharge the root
memcg and whether use_hierarchy=0. If this is the case then we skip
uncharging. The root memcg does not have its own objcg, so any objcg
which is uncharging to it must have been reparented.

Note that on the default hierarchy (CGroupV2 now) root always has
use_hierarchy=1. So this only effects CGroupV1.

The warning can be, unreliably, reproduced with the LTP test
madvise06 if the entire patch series
https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/
is present. Although the listed commit in 'fixes' appears to introduce
the bug, I can not reproduce it with just that commit and bisecting
runs into other bugs.

[   12.029417] WARNING: CPU: 2 PID: 21 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[   12.029539] Modules linked in:
[   12.029611] CPU: 2 PID: 21 Comm: ksoftirqd/2 Not tainted 5.9.0-rc7-22-default #76
[   12.029729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[   12.029908] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[ 12.029991] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 db 47 36 27 48 8b 17 48 39 d6 72 41 41 54 49 89
[   12.030258] RSP: 0018:ffffa5d8000efd08 EFLAGS: 00010086
[   12.030344] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000000009
[   12.030455] RDX: 000000000000000b RSI: ffffffffffffffff RDI: ffff8ef8c7d2b248
[   12.030561] RBP: ffff8ef8c7d2b248 R08: ffff8ef8c78b19c8 R09: 0000000000000001
[   12.030672] R10: 0000000000000000 R11: ffff8ef8c780e0d0 R12: 0000000000000001
[   12.030784] R13: ffffffffffffffff R14: ffff8ef9478b19c8 R15: 0000000000000000
[   12.030895] FS:  0000000000000000(0000) GS:ffff8ef8fbc80000(0000) knlGS:0000000000000000
[   12.031017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.031104] CR2: 00007f72c0af93ec CR3: 000000005c40a000 CR4: 00000000000006e0
[   12.031209] Call Trace:
[   12.031267] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
[   12.031470] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
[   12.031594] refill_obj_stock (mm/memcontrol.c:3166)
[   12.031733] ? rcu_do_batch (kernel/rcu/tree.c:2438)
[   12.032075] memcg_slab_free_hook (./include/linux/mm.h:1294 ./include/linux/mm.h:1441 mm/slab.h:368 mm/slab.h:348)
[   12.032339] kmem_cache_free (mm/slub.c:3107 mm/slub.c:3143 mm/slub.c:3158)
[   12.032464] rcu_do_batch (kernel/rcu/tree.c:2438)
[   12.032567] rcu_core (kernel/rcu/tree_plugin.h:2122 kernel/rcu/tree_plugin.h:2157 kernel/rcu/tree.c:2661)
[   12.032664] __do_softirq (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/irq.h:142 kernel/softirq.c:299)
[   12.032766] run_ksoftirqd (./arch/x86/include/asm/irqflags.h:54 ./arch/x86/include/asm/irqflags.h:94 kernel/softirq.c:653 kernel/softirq.c:644)
[   12.032852] smpboot_thread_fn (kernel/smpboot.c:165)
[   12.032940] ? smpboot_register_percpu_thread (kernel/smpboot.c:108)
[   12.033059] kthread (kernel/kthread.c:292)
[   12.033148] ? __kthread_bind_mask (kernel/kthread.c:245)
[   12.033269] ret_from_fork (arch/x86/entry/entry_64.S:300)
[   12.033357] ---[ end trace 961dbfc01c109d1f ]---

[    9.841552] ------------[ cut here ]------------
[    9.841788] WARNING: CPU: 0 PID: 12 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[    9.841982] Modules linked in:
[    9.842072] CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.9.0-rc7-22-default #77
[    9.842266] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
[    9.842571] Workqueue: events drain_local_stock
[    9.842750] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
[ 9.842894] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 4b f9 88 2a 48 8b 17 48 39 d6 72 41 41 54 49 89
[    9.843438] RSP: 0018:ffffb1c18006be28 EFLAGS: 00010086
[    9.843585] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: ffff94803bc2cae0
[    9.843806] RDX: 0000000000000001 RSI: ffffffffffffffff RDI: ffff948007d2b248
[    9.844026] RBP: ffff948007d2b248 R08: ffff948007c58eb0 R09: ffff948007da05ac
[    9.844248] R10: 0000000000000018 R11: 0000000000000018 R12: 0000000000000001
[    9.844477] R13: ffffffffffffffff R14: 0000000000000000 R15: ffff94803bc2cac0
[    9.844696] FS:  0000000000000000(0000) GS:ffff94803bc00000(0000) knlGS:0000000000000000
[    9.844915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.845096] CR2: 00007f0579ee0384 CR3: 000000002cc0a000 CR4: 00000000000006f0
[    9.845319] Call Trace:
[    9.845429] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
[    9.845582] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
[    9.845684] drain_local_stock (mm/memcontrol.c:2255)
[    9.845789] process_one_work (./arch/x86/include/asm/jump_label.h:25 ./include/linux/jump_label.h:200 ./include/trace/events/workqueue.h:108 kernel/workqueue.c:2274)
[    9.845898] worker_thread (./include/linux/list.h:282 kernel/workqueue.c:2416)
[    9.846034] ? process_one_work (kernel/workqueue.c:2358)
[    9.846162] kthread (kernel/kthread.c:292)
[    9.846271] ? __kthread_bind_mask (kernel/kthread.c:245)
[    9.846420] ret_from_fork (arch/x86/entry/entry_64.S:300)
[    9.846531] ---[ end trace 8b5647c1eba9d18a ]---

Reported-by: ltp@lists.linux.it
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
---

V4: Same as V3, but with hopefully better/correct commit message.

 mm/memcontrol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6877c765b8d0..34b8c4a66853 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	memcg = obj_cgroup_memcg(objcg);
-	if (nr_pages)
+	if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
 		__memcg_kmem_uncharge(memcg, nr_pages);
 	list_del(&objcg->list);
 	mem_cgroup_put(memcg);
@@ -3100,6 +3100,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
+	struct mem_cgroup *memcg;
 
 	if (!old)
 		return;
@@ -3110,7 +3111,9 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 
 		if (nr_pages) {
 			rcu_read_lock();
-			__memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
+			memcg = obj_cgroup_memcg(old);
+			if (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy)
+				__memcg_kmem_uncharge(memcg, nr_pages);
 			rcu_read_unlock();
 		}
 
-- 
2.28.0

