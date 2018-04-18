From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 18 Apr 2018 14:12:55 +0200
Subject: [LTP] [PATCH] mm: Fix do_pages_move status handling
Message-ID: <20180418121255.334-1-mhocko@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Michal Hocko <mhocko@suse.com>

Li Wang has reported that LTP move_pages04 test fails with the current
tree:
LTP move_pages04:
   TFAIL  :  move_pages04.c:143: status[1] is EPERM, expected EFAULT

The test allocates an array of two pages, one is present while the other
is not (resp. backed by zero page) and it expects EFAULT for the second
page as the man page suggests. We are reporting EPERM which doesn't make
any sense and this is a result of a bug from cf5f16b23ec9 ("mm:
unclutter THP migration").

do_pages_move tries to handle as many pages in one batch as possible so
we queue all pages with the same node target together and that
corresponds to [start, i] range which is then used to update status
array. add_page_for_migration will correctly notice the zero (resp.
!present) page and returns with EFAULT which gets written to the status.
But if this is the last page in the array we do not update start and so
the last store_status after the loop will overwrite the range of the
last batch with NUMA_NO_NODE (which corresponds to EPERM).

Fix this by simply bailing out from the last flush if the pagelist
is empty as there is clearly nothing more to do.

Fixes: cf5f16b23ec9 ("mm: unclutter THP migration")
Reported-and-Tested-by: Li Wang <liwang@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi Andrew,
this is a new regression in 4.17-rc1 so it would be great to merge
sooner rather than later. It is a user visible change. The original
bug report is http://lkml.kernel.org/r/20180417110615.16043-1-liwang@redhat.com
Thanks to Li Wang for his testing!

 mm/migrate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 507cf9ba21bf..c7e5f6447417 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1634,6 +1634,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		current_node = NUMA_NO_NODE;
 	}
 out_flush:
+	if (list_empty(&pagelist))
+		return err;
+
 	/* Make sure we do not overwrite the existing error */
 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
 	if (!err1)
-- 
2.16.3

