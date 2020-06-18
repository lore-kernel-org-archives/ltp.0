From: Helge Deller <deller@gmx.de>
Date: Thu, 18 Jun 2020 14:24:05 +0200
Subject: [LTP] Testcase approach for MAP_GROWSDOWN
In-Reply-To: <c6792053-287d-7a53-477d-5f5ad95ffa6f@zilogic.com>
References: <c6792053-287d-7a53-477d-5f5ad95ffa6f@zilogic.com>
Message-ID: <35bbf85f-e689-2aab-5b0d-0f045ad04b3a@gmx.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18.06.20 08:15, Pravin Raghul wrote:
> We are planning to add the following testcases for MAP_GROWSDOWN, please let us know your thoughts on this.
>
> We assign the memory region allocated using MAP_GROWSDOWN to a thread, as a stack, to test the effect of MAP_GROWSDOWN. This is because the kernel only grows the memory region when the stack pointer, is within guard page, when the guard page is touched.
>
>
>       Test Case 1: Grow into an unmapped region
>
>  1. Map an anyonymous memory region of size X, and unmap it.
>  2. Split the unmapped memory region into two.
>  3. The lower memory region is left unmapped.
>  4. The higher memory region is mapped for use as stack, using MAP_FIXED | MAP_GROWSDOWN.
>  5. The higher memory region is provided as stack to a thread, where a recursive function is invoked.
>  6. The stack grows beyond the allocated region, into the lower memory area.

For architectures where the stack grows up (e.g. parisc), you need to start from lower memory region
and grow up into the higher one. I can test on parisc hardware or give you access if needed.

Helge
