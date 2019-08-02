From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 2 Aug 2019 10:42:33 -0700
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <20190802041557.GA16274@hori.linux.bs1.fc.nec.co.jp>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
 <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
 <a65e748b-7297-8547-c18d-9fb07202d5a0@oracle.com>
 <27a48931-aff6-d001-de78-4f7bef584c32@oracle.com>
 <20190802041557.GA16274@hori.linux.bs1.fc.nec.co.jp>
Message-ID: <54a5c9f5-eade-0d8f-24f9-bff6f19d4905@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/1/19 9:15 PM, Naoya Horiguchi wrote:
> On Thu, Aug 01, 2019 at 05:19:41PM -0700, Mike Kravetz wrote:
>> There appears to be a race with hugetlb_fault and try_to_unmap_one of
>> the migration path.
>>
>> Can you try this patch in your environment?  I am not sure if it will
>> be the final fix, but just wanted to see if it addresses issue for you.
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index ede7e7f5d1ab..f3156c5432e3 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3856,6 +3856,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>  
>>  		page = alloc_huge_page(vma, haddr, 0);
>>  		if (IS_ERR(page)) {
>> +			/*
>> +			 * We could race with page migration (try_to_unmap_one)
>> +			 * which is modifying page table with lock.  However,
>> +			 * we are not holding lock here.  Before returning
>> +			 * error that will SIGBUS caller, get ptl and make
>> +			 * sure there really is no entry.
>> +			 */
>> +			ptl = huge_pte_lock(h, mm, ptep);
>> +			if (!huge_pte_none(huge_ptep_get(ptep))) {
>> +				ret = 0;
>> +				spin_unlock(ptl);
>> +				goto out;
>> +			}
>> +			spin_unlock(ptl);
> 
> Thanks you for investigation, Mike.
> I tried this change and found no SIGBUS, so it works well.
> 
> I'm still not clear about how !huge_pte_none() becomes true here,
> because we enter hugetlb_no_page() only when huge_pte_none() is non-null
> and (racy) try_to_unmap_one() from page migration should convert the
> huge_pte into a migration entry, not null.

Thanks for taking a look Naoya.

In try_to_unmap_one(), there is this code block:

		/* Nuke the page table entry. */
		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
		if (should_defer_flush(mm, flags)) {
			/*
			 * We clear the PTE but do not flush so potentially
			 * a remote CPU could still be writing to the page.
			 * If the entry was previously clean then the
			 * architecture must guarantee that a clear->dirty
			 * transition on a cached TLB entry is written through
			 * and traps if the PTE is unmapped.
			 */
			pteval = ptep_get_and_clear(mm, address, pvmw.pte);

			set_tlb_ubc_flush_pending(mm, pte_dirty(pteval));
		} else {
			pteval = ptep_clear_flush(vma, address, pvmw.pte);
		}

That happens before setting the migration entry.  Therefore, for a period
of time the pte is NULL (huge_pte_none() returns true).

try_to_unmap_one holds the page table lock, but hugetlb_fault does not take
the lock to 'optimistically' check huge_pte_none().  When huge_pte_none
returns true, it calls hugetlb_no_page which is where we try to allocate
a page and fails.

Does that make sense, or am I missing something?

The patch checks for this specific condition: someone changing the pte
from NULL to non-NULL while holding the lock.  I am not sure if this is
the best way to fix.  But, it may be the easiest.
-- 
Mike Kravetz
