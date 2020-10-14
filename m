From: Roman Gushchin <guro@fb.com>
Date: Wed, 14 Oct 2020 13:08:33 -0700
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201014190749.24607-1-rpalethorpe@suse.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
Message-ID: <20201014200833.GA19363@carbon.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard!

> SLAB objects which outlive their memcg are moved to their parent
> memcg where they may be uncharged. However if they are moved to the
> root memcg, uncharging will result in negative page counter values as
> root has no page counters.
> 
> To prevent this, we check whether we are about to uncharge the root
> memcg and skip it if we are. Possibly instead; the obj_cgroups should
> be removed from their slabs and any per cpu stocks instead of
> reparenting them to root?

It would be really complex. I think your fix is totally fine.
We have similar checks in cancel_charge(), uncharge_batch(),
mem_cgroup_swapout(), mem_cgroup_uncharge_swap() etc.

> 
> The warning can be, unreliably, reproduced with the LTP test
> madvise06 if the entire patch series
> https://lore.kernel.org/linux-mm/20200623174037.3951353-1-guro@fb.com/
> is present. Although the listed commit in 'fixes' appears to introduce
> the bug, I can not reproduce it with just that commit and bisecting
> runs into other bugs.
> 
> [   12.029417] WARNING: CPU: 2 PID: 21 at mm/page_counter.c:57 page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [   12.029539] Modules linked in:
> [   12.029611] CPU: 2 PID: 21 Comm: ksoftirqd/2 Not tainted 5.9.0-rc7-22-default #76
> [   12.029729] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> [   12.029908] RIP: 0010:page_counter_uncharge (mm/page_counter.c:57 mm/page_counter.c:50 mm/page_counter.c:156)
> [ 12.029991] Code: 0f c1 45 00 4c 29 e0 48 89 ef 48 89 c3 48 89 c6 e8 2a fe ff ff 48 85 db 78 10 48 8b 6d 28 48 85 ed 75 d8 5b 5d 41 5c 41 5d c3 <0f> 0b eb ec 90 e8 db 47 36 27 48 8b 17 48 39 d6 72 41 41 54 49 89
> [   12.030258] RSP: 0018:ffffa5d8000efd08 EFLAGS: 00010086
> [   12.030344] RAX: ffffffffffffffff RBX: ffffffffffffffff RCX: 0000000000000009
> [   12.030455] RDX: 000000000000000b RSI: ffffffffffffffff RDI: ffff8ef8c7d2b248
> [   12.030561] RBP: ffff8ef8c7d2b248 R08: ffff8ef8c78b19c8 R09: 0000000000000001
> [   12.030672] R10: 0000000000000000 R11: ffff8ef8c780e0d0 R12: 0000000000000001
> [   12.030784] R13: ffffffffffffffff R14: ffff8ef9478b19c8 R15: 0000000000000000
> [   12.030895] FS:  0000000000000000(0000) GS:ffff8ef8fbc80000(0000) knlGS:0000000000000000
> [   12.031017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   12.031104] CR2: 00007f72c0af93ec CR3: 000000005c40a000 CR4: 00000000000006e0
> [   12.031209] Call Trace:
> [   12.031267] __memcg_kmem_uncharge (mm/memcontrol.c:3022)
> [   12.031470] drain_obj_stock (./include/linux/rcupdate.h:689 mm/memcontrol.c:3114)
> [   12.031594] refill_obj_stock (mm/memcontrol.c:3166)
> [   12.031733] ? rcu_do_batch (kernel/rcu/tree.c:2438)
> [   12.032075] memcg_slab_free_hook (./include/linux/mm.h:1294 ./include/linux/mm.h:1441 mm/slab.h:368 mm/slab.h:348)
> [   12.032339] kmem_cache_free (mm/slub.c:3107 mm/slub.c:3143 mm/slub.c:3158)
> [   12.032464] rcu_do_batch (kernel/rcu/tree.c:2438)
> [   12.032567] rcu_core (kernel/rcu/tree_plugin.h:2122 kernel/rcu/tree_plugin.h:2157 kernel/rcu/tree.c:2661)
> ...
> Reported-By: ltp@lists.linux.it
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
