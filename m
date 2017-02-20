From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Date: Mon, 20 Feb 2017 05:00:17 +0000
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
Message-ID: <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 14, 2017 at 04:41:29PM +0100, Jan Stancek wrote:
> Hi,
>
> code below (and LTP madvise07 [1]) doesn't produce SIGBUS,
> unless I touch/prefault page before call to madvise().
>
> Is this expected behavior?

Thank you for reporting.

madvise(MADV_HWPOISON) triggers page fault when called on the address
over which no page is faulted-in, so I think that SIGBUS should be
called in such case.

But it seems that memory error handler considers such a page as "reserved
kernel page" and recovery action fails (see below.)

  [  383.371372] Injecting memory failure for page 0x1f10 at 0x7efcdc569000
  [  383.375678] Memory failure: 0x1f10: reserved kernel page still referenced by 1 users
  [  383.377570] Memory failure: 0x1f10: recovery action for reserved kernel page: Failed

I'm not sure how/when this behavior was introduced, so I try to understand.
IMO, the test code below looks valid to me, so no need to change.

Thanks,
Naoya Horiguchi

>
> Thanks,
> Jan
>
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise07.c
>
> -------------------- 8< --------------------
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <unistd.h>
>
> int main(void)
> {
> 	void *mem = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
> 			MAP_ANONYMOUS | MAP_PRIVATE /*| MAP_POPULATE*/,
> 			-1, 0);
>
> 	if (mem == MAP_FAILED)
> 		exit(1);
>
> 	if (madvise(mem, getpagesize(), MADV_HWPOISON) == -1)
> 		exit(1);
>
> 	*((char *)mem) = 'd';
>
> 	return 0;
> }
> -------------------- 8< --------------------
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
