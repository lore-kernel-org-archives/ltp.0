From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 25 Nov 2020 00:46:32 +0000
Subject: [LTP] kernel BUG at mm/highmem.c:417! invalid opcode: 0000 EIP:
 zero_user_segments
In-Reply-To: <20201124171628.dk6tle5lh3sx2jxg@linutronix.de>
References: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
 <20201124171628.dk6tle5lh3sx2jxg@linutronix.de>
Message-ID: <20201125004632.GG4327@casper.infradead.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 24, 2020 at 06:16:28PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-11-24 18:52:44 [+0530], Naresh Kamboju wrote:
> > While running LTP test case access01 the following kernel BUG
> > noticed on linux next 20201124 tag kernel on i386.
> > 
> > git short log:
> > ----------------
> > git log --oneline next-20201120..next-20201124 -- mm/highmem.c
> > d9927d46febf Merge branch 'akpm-current/current'
> > 72d22a0d0e86 mm: support THPs in zero_user_segments
> > 2a656cad337e mm/highmem: Take kmap_high_get() properly into account
> > 
> > Please find these easy steps to reproduce the kernel build and boot.
> 
> This BUG_ON() is in zero_user_segments() which ash been added in commit
>    72d22a0d0e86 mm: support THPs in zero_user_segments
> 
> > [   50.852189] kernel BUG at mm/highmem.c:417!
> 
> I managed to capture one invocation with:
> zero_user_segments(0xd4367a90,
> 		   0x1000, 0x1000,
> 		   0x0, 0x50)
> page_compound() -> 1
> page_size() -> 4096

Thanks for debugging this!  I didn't realise start1 was allowed to be
less than start2.  Try this ... (systemd is sabotaging my efforts to
test an i386 kernel)

diff --git a/mm/highmem.c b/mm/highmem.c
index 3e1087f2b735..6306a535dd9c 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -369,46 +369,39 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
 
 	for (i = 0; i < compound_nr(page); i++) {
-		void *kaddr;
-		unsigned this_end;
+		void *kaddr = NULL;
 
-		if (end1 == 0 && start2 >= PAGE_SIZE) {
-			start2 -= PAGE_SIZE;
-			end2 -= PAGE_SIZE;
-			continue;
-		}
+		if (start1 < PAGE_SIZE || start2 < PAGE_SIZE)
+			kaddr = kmap_atomic(page + i);
 
 		if (start1 >= PAGE_SIZE) {
 			start1 -= PAGE_SIZE;
 			end1 -= PAGE_SIZE;
-			if (start2) {
-				start2 -= PAGE_SIZE;
-				end2 -= PAGE_SIZE;
-			}
-			continue;
-		}
-
-		kaddr = kmap_atomic(page + i);
+		} else {
+			unsigned this_end = min_t(unsigned, end1, PAGE_SIZE);
 
-		this_end = min_t(unsigned, end1, PAGE_SIZE);
-		if (end1 > start1)
-			memset(kaddr + start1, 0, this_end - start1);
-		end1 -= this_end;
-		start1 = 0;
+			if (end1 > start1)
+				memset(kaddr + start1, 0, this_end - start1);
+			end1 -= this_end;
+			start1 = 0;
+		}
 
 		if (start2 >= PAGE_SIZE) {
 			start2 -= PAGE_SIZE;
 			end2 -= PAGE_SIZE;
 		} else {
-			this_end = min_t(unsigned, end2, PAGE_SIZE);
+			unsigned this_end = min_t(unsigned, end2, PAGE_SIZE);
+
 			if (end2 > start2)
 				memset(kaddr + start2, 0, this_end - start2);
 			end2 -= this_end;
 			start2 = 0;
 		}
 
-		kunmap_atomic(kaddr);
-		flush_dcache_page(page + i);
+		if (kaddr) {
+			kunmap_atomic(kaddr);
+			flush_dcache_page(page + i);
+		}
 
 		if (!end1 && !end2)
 			break;
