From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Jan 2021 20:57:07 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <20210115143246.369676-1-egorenar@linux.ibm.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
Message-ID: <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexander,

Alexander Egorenkov <egorenar@linux.ibm.com> wrote:

> ...
> swapping01.c:106: TINFO: available physical memory:* 7348 MB*
> swapping01.c:109: TINFO: try to allocate: 9552 MB
> swapping01.c:112: TINFO: memory allocated: 9552 MB
> swapping01.c:140: TINFO: swap free init: 25019 MB
> swapping01.c:141: TINFO: swap free now: 20484 MB
> swapping01.c:149: TPASS: no heavy swapping detected, *4534 MB swapped.*
> ...
> swapping01.c:106: TINFO: available physical memory:* 7318 MB*
> swapping01.c:109: TINFO: try to allocate: 9514 MB
> swapping01.c:112: TINFO: memory allocated: 9514 MB
> swapping01.c:140: TINFO: swap free init: 25019 MB
> swapping01.c:141: TINFO: swap free now: 17697 MB
> swapping01.c:145: TFAIL: heavy swapping detected:* 7322 MB swapped.*
>

Looking at the memory status from the output, it only detects available
memory 7318MB in the fourth time (< 7348MB, second/third time).
But memory heavy swapped in the third and fourth time(7323MB, 7322MB
swapped).

Obviously, the last two tests influenced by the first-three running.

How reproducible of this FAIL? And, Could you help verify whether the
following cleanup works?
(Also, provide /proc/meminfo or kernel version will help to locate the
issues).

--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -81,6 +81,7 @@ static void test_swapping(void)

 static void init_meminfo(void)
 {
+       SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
        swap_free_init = SAFE_READ_MEMINFO("SwapFree:");
        if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
                &mem_available_init)) {

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210118/62910997/attachment.htm>
