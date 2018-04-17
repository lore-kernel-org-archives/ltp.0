From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Apr 2018 19:06:15 +0800
Subject: [LTP] [RFC PATCH] mm: correct status code which move_pages()
	returns for zero page
Message-ID: <20180417110615.16043-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

move_pages(2) declears that status code for zero page is supposed to
be -EFAULT. But now it (LTP/move_pages04 test) gets -EPERM, the root
cause is that not goto out_flush after store_status() saves the err
which add_page_for_migration() returns for zero page.

LTP move_pages04:
   TFAIL  :  move_pages04.c:143: status[1] is EPERM, expected EFAULT

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index f65dd69..2b315fc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1608,7 +1608,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			continue;
 
 		err = store_status(status, i, err, 1);
-		if (err)
+		if (!err)
 			goto out_flush;
 
 		err = do_move_pages_to_node(mm, &pagelist, current_node);
-- 
2.9.5

