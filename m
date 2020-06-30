From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Jun 2020 18:56:57 +0800
Subject: [LTP] [PATCH v1] Add a test case for mmap() MAP_GROWSDOWN flag
In-Reply-To: <20200630054405.6115-1-pravinraghul@zilogic.com>
References: <20200630054405.6115-1-pravinraghul@zilogic.com>
Message-ID: <CAEemH2egVWiSB+uzMMFb4oBFxRoP9bVLXa2B0Y39BBpZEH4yLg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 30, 2020 at 1:45 PM pravin <pravinraghul@zilogic.com> wrote:

>
> We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> kernel only grows the memory region when the stack pointer, is within
> guard page, when the guard page is touched.
>
>   1. Map an anyonymous memory region of size X, and unmap it.
>   2. Split the unmapped memory region into two.
>   3. The lower memory region is left unmapped.
>   4. The higher memory region is mapped for use as stack, using MAP_FIXED
> | MAP_GROWSDOWN.
>   5. The higher memory region is provided as stack to a thread, where
>      a recursive function is invoked.
>   6. The stack grows beyond the allocated region, into the lower memory
> area.
>   7. If this results in the memory region being extended, into the
>      unmapped region, the test is considered to have passed.
>
> ...
> +
> +void split_unmapped_plus_stack(void *start, size_t size, void **stack)
> +{
> +       /*
> +         * +---------------------+----------------------+
> +         * + unmapped            | stack                |
> +         * +---------------------+----------------------+
> +         */
> +       *stack = SAFE_MMAP(start, size, PROT_READ | PROT_WRITE,
>

This does not match what you describe in the code comments, here we still
map the total size of the memory area, and stack can not grow into an
unmapped region.

Looking at the address which printed from your code, the mem == stack and
&limit grows down in mapped address.

# ./mmap18
tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
mmap18.c:132: INFO: mem = 0x7ffff7fa5000, stack = 0x7ffff7fa5000
mmap18.c:96: INFO: &limit = 0x7ffff7fa8fe8, limit = 0x7ffff7fa9000
mmap18.c:141: PASS: stack grows in unmapped region


Maybe this below could achieve your method, or you can take the way which
Cyril suggests using multiple page_size.

--- a/testcases/kernel/syscalls/mmap/mmap18.c
+++ b/testcases/kernel/syscalls/mmap/mmap18.c
@@ -84,15 +84,17 @@ void split_unmapped_plus_stack(void *start, size_t
size, void **stack)
          * + unmapped            | stack                |
          * +---------------------+----------------------+
          */
-       *stack = SAFE_MMAP(start, size, PROT_READ | PROT_WRITE,
+       *stack = SAFE_MMAP(start + size/2, size/2, PROT_READ | PROT_WRITE,
                           MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS |
MAP_GROWSDOWN,
                           -1, 0);
 }

 static void *check_depth_recursive(void *limit)
 {
-       if ((off_t) &limit < (off_t) limit)
+       if ((off_t) &limit < (off_t) limit) {
+               tst_res(TINFO, "&limit = %p, limit = %p", &limit, limit);
                return NULL;
+       }

        return check_depth_recursive(limit);
 }
@@ -125,10 +127,11 @@ static void run_test(void)

        mem = find_free_range(UNITS(16));
        split_unmapped_plus_stack(mem, UNITS(16), &stack);
+       tst_res(TINFO, "mem = %p, stack = %p", mem, stack);

        child_pid = SAFE_FORK();
        if (child_pid == 0) {
-               grow_stack(stack, UNITS(8), mem + UNITS(1));
+               grow_stack(stack, UNITS(8), stack - UNITS(1));
        } else {
                SAFE_WAIT(&wstatus);
                if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200630/5cc35b18/attachment.htm>
