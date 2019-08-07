From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 7 Aug 2019 08:10:27 -0700
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <20190807073909.GL11812@dhcp22.suse.cz>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
 <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
 <a65e748b-7297-8547-c18d-9fb07202d5a0@oracle.com>
 <27a48931-aff6-d001-de78-4f7bef584c32@oracle.com>
 <20190802041557.GA16274@hori.linux.bs1.fc.nec.co.jp>
 <54a5c9f5-eade-0d8f-24f9-bff6f19d4905@oracle.com>
 <20190805085740.GC7597@dhcp22.suse.cz>
 <7d78f6b9-afb8-79d1-003e-56de58fded00@oracle.com>
 <3c104b29-ffe2-07cb-440e-cb88d8e11acb@oracle.com>
 <20190807073909.GL11812@dhcp22.suse.cz>
Message-ID: <d2bb2c10-a08c-dfde-a51b-827a85b50946@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/7/19 12:39 AM, Michal Hocko wrote:
> On Tue 06-08-19 17:07:25, Mike Kravetz wrote:
>> On 8/5/19 10:36 AM, Mike Kravetz wrote:
>>>>>>> Can you try this patch in your environment?  I am not sure if it will
>>>>>>> be the final fix, but just wanted to see if it addresses issue for you.
>>>>>>>
>>>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>>>> index ede7e7f5d1ab..f3156c5432e3 100644
>>>>>>> --- a/mm/hugetlb.c
>>>>>>> +++ b/mm/hugetlb.c
>>>>>>> @@ -3856,6 +3856,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>>>>>>  
>>>>>>>  		page = alloc_huge_page(vma, haddr, 0);
>>>>>>>  		if (IS_ERR(page)) {
>>>>>>> +			/*
>>>>>>> +			 * We could race with page migration (try_to_unmap_one)
>>>>>>> +			 * which is modifying page table with lock.  However,
>>>>>>> +			 * we are not holding lock here.  Before returning
>>>>>>> +			 * error that will SIGBUS caller, get ptl and make
>>>>>>> +			 * sure there really is no entry.
>>>>>>> +			 */
>>>>>>> +			ptl = huge_pte_lock(h, mm, ptep);
>>>>>>> +			if (!huge_pte_none(huge_ptep_get(ptep))) {
>>>>>>> +				ret = 0;
>>>>>>> +				spin_unlock(ptl);
>>>>>>> +				goto out;
>>>>>>> +			}
>>>>>>> +			spin_unlock(ptl);
>>>>>>
>>>>>> Thanks you for investigation, Mike.
>>>>>> I tried this change and found no SIGBUS, so it works well.
>>
>> Here is another way to address the issue.  Take the hugetlb fault mutex in
>> the migration code when modifying the page tables.  IIUC, the fault mutex
>> was introduced to prevent this same issue when there were two page faults
>> on the same page (and we were unable to allocate an 'extra' page).  The
>> downside to such an approach is that we add more hugetlbfs specific code
>> to try_to_unmap_one.
> 
> I would rather go with the hugetlb_no_page which is better isolated.

Sounds good.

And, after more thought modifying try_to_unmap_one will not work.  Why?
It violates lock ordering.  Current ordering is hugetlb_mutex, page lock
then page table lock.  The page lock is taken before calling try_to_unmap_one.
In addition, try_to_unmap is unmapping from multiple vmas so we can not
know the values for hugetlb hash before taking page lock as the hash values
are vma specific.  So, without many modifications we can not add hugetlb
fault mutex to this code path.
-- 
Mike Kravetz
