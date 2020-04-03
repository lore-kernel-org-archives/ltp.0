From: Kirill A. Shutemov <kirill@shutemov.name>
Date: Fri, 3 Apr 2020 16:32:52 +0300
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
In-Reply-To: <CA+G9fYv0xNtnD=eBmxVqYqEoYTbMk6mdn04WmgSUasDw2L7uFg@mail.gmail.com>
References: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
 <20200402133849.mmkvekzx37kw4nsj@box>
 <CA+G9fYv0xNtnD=eBmxVqYqEoYTbMk6mdn04WmgSUasDw2L7uFg@mail.gmail.com>
Message-ID: <20200403133252.ivdqoppxhc6w5b47@box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Apr 03, 2020 at 12:56:57AM +0530, Naresh Kamboju wrote:
> [  734.876355] old_addr: 0xbfe00000, new_addr: 0xbfc00000, old_end: 0xc0000000

The ranges are overlapping. We don't expect it. mremap(2) never does this.

shift_arg_pages() only moves range downwards. It should be safe.

Could you try this:

diff --git a/mm/mremap.c b/mm/mremap.c
index af363063ea23..ddd5337de395 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -205,10 +205,14 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 		return false;
 
 	/*
-	 * The destination pmd shouldn't be established, free_pgtables()
-	 * should have release it.
+	 * mremap(2) clears the new place, so the new_pmd is expected to be
+	 * clear.
+	 *
+	 * But move_page_tables() is also called from shift_arg_pages() that
+	 * allows for overlapping address ranges. The shift_arg_pages() case
+	 * is also safe as we only move page tables downwards.
 	 */
-	if (WARN_ON(!pmd_none(*new_pmd)))
+	if (WARN_ON(!pmd_none(*new_pmd) && old_addr > new_addr))
 		return false;
 
 	/*
-- 
 Kirill A. Shutemov
