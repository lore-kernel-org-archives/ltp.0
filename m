From: Kirill A. Shutemov <kirill@shutemov.name>
Date: Thu, 2 Apr 2020 16:38:49 +0300
Subject: [LTP] mm/mremap.c : WARNING: at mm/mremap.c:211
 move_page_tables+0x5b0/0x5d0
In-Reply-To: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
References: <CA+G9fYs1xStrrsvGbW7bc4h1a0Kjfz0_zn4c7LL7-bGZb0GH6g@mail.gmail.com>
Message-ID: <20200402133849.mmkvekzx37kw4nsj@box>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 02, 2020 at 04:49:02PM +0530, Naresh Kamboju wrote:
> While running LTP mm thp01 test case on i386 kernel running on x86_64 device
> the following kernel warning was noticed multiple times.
> 
> This issue is not new,
> we have noticed on stable-rc 5.4, stable-rc 5.5 and stable-rc 5.6 branches.
> FYI, CONFIG_HAVE_MOVE_PMD=y is set on
> and total memory 2.2G as per free output.
> 
> steps to reproduce:
> --------------------
> boot i386 kernel on x86_64 device,
> cd /opt/ltp
> ./runltp -f mm
> thp01.c:98: PASS: system didn't crash.
> thp01.c:98: PASS: system didn't crash.
> thp01.c:98: PASS: system didn't crash.
> 
> [  207.317499] ------------[ cut here ]------------
> [  207.322153] WARNING: CPU: 0 PID: 18963 at mm/mremap.c:211
> move_page_tables+0x5b0/0x5d0


> Kernel config:
> https://builds.tuxbuild.com/RJ9BGpsgfPfj3Sfje8oLSw/kernel.config

Interesting. I suspect it's related to 2-level page tables in this
configuration. But I cannot immediately see how.

Could you test if enabling HIGHMEM64 fixes the issue?

Below is patch that prints some additional info:

diff --git a/mm/mremap.c b/mm/mremap.c
index d28f08a36b96..065d5ec3614a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -208,8 +208,14 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * The destination pmd shouldn't be established, free_pgtables()
 	 * should have release it.
 	 */
-	if (WARN_ON(!pmd_none(*new_pmd)))
+	if (WARN_ON(!pmd_none(*new_pmd))) {
+		dump_vma(vma);
+		printk("old_addr: %#lx, new_addr: %#lx, old_end: %#lx\n",
+				old_addr, new_addr, old_end);
+		printk("old_pmd: %#lx", pmd_val(*old_pmd));
+		printk("new_pmd: %#lx", pmd_val(*new_pmd));
 		return false;
+	}
 
 	/*
 	 * We don't have to worry about the ordering of src and dst
-- 
 Kirill A. Shutemov
