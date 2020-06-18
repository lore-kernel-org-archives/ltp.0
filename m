From: Pravin Raghul <pravinraghul@zilogic.com>
Date: Thu, 18 Jun 2020 06:15:03 -0000
Subject: [LTP] Testcase approach for MAP_GROWSDOWN
Message-ID: <c6792053-287d-7a53-477d-5f5ad95ffa6f@zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We are planning to add the following testcases for MAP_GROWSDOWN, please 
let us know your thoughts on this.

We assign the memory region allocated using MAP_GROWSDOWN to a thread, 
as a stack, to test the effect of MAP_GROWSDOWN. This is because the 
kernel only grows the memory region when the stack pointer, is within 
guard page, when the guard page is touched.


      Test Case 1: Grow into an unmapped region

 1. Map an anyonymous memory region of size X, and unmap it.
 2. Split the unmapped memory region into two.
 3. The lower memory region is left unmapped.
 4. The higher memory region is mapped for use as stack, using MAP_FIXED
    | MAP_GROWSDOWN.
 5. The higher memory region is provided as stack to a thread, where a
    recursive function is invoked.
 6. The stack grows beyond the allocated region, into the lower memory area.
 7. If this results in the memory region being extended, into the
    unmapped region, the test is considered to have passed.


      Test Case 2: Grow into a mapped region

 1. Map an anonymous memory area.
 2. Split the memory area into two by mapping them into two areas.
 3. The lower memory area is mapped using MAP_FIXED.
 4. The higher memory area is mapped for use as stack, using MAP_FIXED |
    MAP_GROWSDOWN.
 5. The higher memory area is provided as stack to a thread, where a
    recursive function is invoked.
 6. The stack grows beyond the allocated area, into the lower memory area.
 7. If this results in a segmentation fault, the test is considered to
    have passed.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200618/702244fe/attachment.htm>
