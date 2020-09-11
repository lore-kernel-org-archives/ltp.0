From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 09:05:40 +0200
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200911035533.30538-1-liwang@redhat.com>
References: <20200911035533.30538-1-liwang@redhat.com>
Message-ID: <20200911070540.GA22970@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> From: pravin <pravinraghul@zilogic.com>

> We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> kernel only grows the memory region when the stack pointer, is within
> guard page, when the guard page is touched.

>   1. Map an anyonymous memory region of size X, and unmap it.
>   2. Split the unmapped memory region into two.
>   3. The lower memory region is left unmapped.
>   4. The higher memory region is mapped for use as stack, using MAP_FIXED | MAP_GROWSDOWN.
>   5. The higher memory region is provided as stack to a thread, where
>      a recursive function is invoked.
>   6. The stack grows beyond the allocated region, into the lower memory area.
>   7. If this results in the memory region being extended, into the
>      unmapped region, the test is considered to have passed.

> Also, to verify that(Test2) the stack grows to within a page of the high
> end of the next lower map?ping will result in a SIGSEGV signal.

> Resolves #300
> Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

Just please fix using spaces instead of tabs in check_stackgrow_up() and
run_test() (I suppose your modifications to pravis's code):

mmap18.c:55: WARNING: please, no spaces at the start of a line
mmap18.c:55: WARNING: suspect code indent for conditional statements (7, 15)
mmap18.c:56: ERROR: code indent should use tabs where possible
mmap18.c:56: WARNING: please, no spaces at the start of a line
mmap18.c:57: ERROR: code indent should use tabs where possible
mmap18.c:57: WARNING: please, no spaces at the start of a line
mmap18.c:58: WARNING: please, no spaces at the start of a line
mmap18.c:60: WARNING: please, no spaces at the start of a line
mmap18.c:167: ERROR: code indent should use tabs where possible
mmap18.c:167: WARNING: please, no spaces at the start of a line
mmap18.c:169: ERROR: code indent should use tabs where possible
mmap18.c:169: WARNING: please, no spaces at the start of a line
mmap18.c:170: ERROR: code indent should use tabs where possible
mmap18.c:170: WARNING: please, no spaces at the start of a line


Kind regards,
Petr
