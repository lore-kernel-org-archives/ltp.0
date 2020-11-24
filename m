From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 24 Nov 2020 18:16:28 +0100
Subject: [LTP] kernel BUG at mm/highmem.c:417! invalid opcode: 0000 EIP:
 zero_user_segments
In-Reply-To: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
References: <CA+G9fYuKZGaHVvAv=ZwOL_p6UM3YhOHy0DcJRRM_DOLGYXg1Dw@mail.gmail.com>
Message-ID: <20201124171628.dk6tle5lh3sx2jxg@linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020-11-24 18:52:44 [+0530], Naresh Kamboju wrote:
> While running LTP test case access01 the following kernel BUG
> noticed on linux next 20201124 tag kernel on i386.
> 
> git short log:
> ----------------
> git log --oneline next-20201120..next-20201124 -- mm/highmem.c
> d9927d46febf Merge branch 'akpm-current/current'
> 72d22a0d0e86 mm: support THPs in zero_user_segments
> 2a656cad337e mm/highmem: Take kmap_high_get() properly into account
> 
> Please find these easy steps to reproduce the kernel build and boot.

This BUG_ON() is in zero_user_segments() which ash been added in commit
   72d22a0d0e86 mm: support THPs in zero_user_segments

> [   50.852189] kernel BUG at mm/highmem.c:417!

I managed to capture one invocation with:
zero_user_segments(0xd4367a90,
		   0x1000, 0x1000,
		   0x0, 0x50)
page_compound() -> 1
page_size() -> 4096

And at the end it BUGs because end2 is still 0x50.

because:
|         for (i = 0; i < compound_nr(page); i++) {
|                 void *kaddr;
|                 unsigned this_end;
| 
|                 if (end1 == 0 && start2 >= PAGE_SIZE) {
|                         start2 -= PAGE_SIZE;
|                         end2 -= PAGE_SIZE;
|                         continue;
|                 }
| 
|                 if (start1 >= PAGE_SIZE) {
start1 0x1000 is >= PAGE_SIZE.
|                         start1 -= PAGE_SIZE;
|                         end1 -= PAGE_SIZE;
|                         if (start2) {
start2 is 0.
|                                 start2 -= PAGE_SIZE;
|                                 end2 -= PAGE_SIZE;
|                         }
|                         continue;
|                 }

I don't know why the logic for start1/end1 and start2/end2 is coupled
here.  Based on how __block_write_begin_int() invokes it seems to zero
two independent blocks (or it is a bug in caller).
The generic implementation would do nothing for start1/end1 and for
second part if would memset(page + 0, 0, 0x50 - 0).

Sebastian
