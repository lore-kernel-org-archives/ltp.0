From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Dec 2017 08:11:21 -0500 (EST)
Subject: [LTP] [PATCH] [RFC] brk01: Rewrite from scratch.
In-Reply-To: <20171212112148.17424-1-chrubis@suse.cz>
References: <20171212112148.17424-1-chrubis@suse.cz>
Message-ID: <767241426.54027806.1513084281907.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This commit rewrites the brk01 test from scratch since the original code
> wasn't making much sense.

git format-patch has parameter "-B", that can make big rewrites
more readable.

> 
> Now we actually run the brk() in a loop increasing and shrinking the
> break repeatedly a few times, which the original code was supposed to do
> but never actually did since we do not pass the -i parameter in the
> runtest files.
> 
> The increment is also choosen to be much much more reasonable instead of
> using the multiple of the absolute address of the page break we choose
> much more modest 2 * pagesize - 1. Note that the increment is not page
> aligned since that way we also check that kernel page-aligns it just
> fine.
> 
> The sequence has been choosen to grow the heap first then shrink it to
> the original size, which should be safe since the heap never shrinks
> below its original size.
> 
> We also write to the newly allocated heap in a case that that the heap
> has grown, which should be safe enough since that way we will not
> rewrite anything that was previously stored there.

Shrinking and writing to heap seems little dangerous. It doesn't take
much to make it crash if someone else uses heap too:

diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
index 2467ef6732a0..d77c000df105 100644
--- a/testcases/kernel/syscalls/brk/brk01.c
+++ b/testcases/kernel/syscalls/brk/brk01.c
@@ -22,6 +22,7 @@
 
 #include "tst_test.h"
 
+void *ptr;
 void verify_brk(void)
 {
        uintptr_t cur_brk, new_brk;
@@ -65,6 +66,9 @@ void verify_brk(void)
                /* Try to write to the newly allocated heap */
                if (i % 3 == 0)
                        *((char *)cur_brk) = 0;
+               ptr = malloc(2*4096);
+               printf("%p\n", ptr);
+
        }
 
        tst_res(TPASS, "brk() works fine");

$ ./brk01
...
tst_test.c:1022: BROK: Test killed by SIGSEGV!

My concern is that glibc allocates something as result
of tst_* calls (e.g. buffered I/O write) and then we
either write over it or de-allocate it. I think we should
drop/postpone first tst_res().

Regards,
Jan

