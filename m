From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 6 Aug 2019 17:07:25 -0700
Subject: [LTP] 
 =?utf-8?q?=5BMM_Bug=3F=5D_mmap=28=29_triggers_SIGBUS_while?=
 =?utf-8?b?IGRvaW5nIHRoZeKAiyDigItudW1hX21vdmVfcGFnZXMoKSBmb3Igb2ZmbGlu?=
 =?utf-8?q?ed_hugepage_in_background?=
In-Reply-To: <7d78f6b9-afb8-79d1-003e-56de58fded00@oracle.com>
References: <CAEemH2dMW6oh6Bbm=yqUADF+mDhuQgFTTGYftB+xAhqqdYV3Ng@mail.gmail.com>
 <47999e20-ccbe-deda-c960-473db5b56ea0@oracle.com>
 <CAEemH2d=vEfppCbCgVoGdHed2kuY3GWnZGhymYT1rnxjoWNdcQ@mail.gmail.com>
 <a65e748b-7297-8547-c18d-9fb07202d5a0@oracle.com>
 <27a48931-aff6-d001-de78-4f7bef584c32@oracle.com>
 <20190802041557.GA16274@hori.linux.bs1.fc.nec.co.jp>
 <54a5c9f5-eade-0d8f-24f9-bff6f19d4905@oracle.com>
 <20190805085740.GC7597@dhcp22.suse.cz>
 <7d78f6b9-afb8-79d1-003e-56de58fded00@oracle.com>
Message-ID: <3c104b29-ffe2-07cb-440e-cb88d8e11acb@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/5/19 10:36 AM, Mike Kravetz wrote:
>>>>> Can you try this patch in your environment?  I am not sure if it will
>>>>> be the final fix, but just wanted to see if it addresses issue for you.
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index ede7e7f5d1ab..f3156c5432e3 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -3856,6 +3856,20 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>>>>  
>>>>>  		page = alloc_huge_page(vma, haddr, 0);
>>>>>  		if (IS_ERR(page)) {
>>>>> +			/*
>>>>> +			 * We could race with page migration (try_to_unmap_one)
>>>>> +			 * which is modifying page table with lock.  However,
>>>>> +			 * we are not holding lock here.  Before returning
>>>>> +			 * error that will SIGBUS caller, get ptl and make
>>>>> +			 * sure there really is no entry.
>>>>> +			 */
>>>>> +			ptl = huge_pte_lock(h, mm, ptep);
>>>>> +			if (!huge_pte_none(huge_ptep_get(ptep))) {
>>>>> +				ret = 0;
>>>>> +				spin_unlock(ptl);
>>>>> +				goto out;
>>>>> +			}
>>>>> +			spin_unlock(ptl);
>>>>
>>>> Thanks you for investigation, Mike.
>>>> I tried this change and found no SIGBUS, so it works well.

Here is another way to address the issue.  Take the hugetlb fault mutex in
the migration code when modifying the page tables.  IIUC, the fault mutex
was introduced to prevent this same issue when there were two page faults
on the same page (and we were unable to allocate an 'extra' page).  The
downside to such an approach is that we add more hugetlbfs specific code
to try_to_unmap_one.

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index edf476c8cfb9..df0e74f9962e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -485,6 +485,17 @@ static inline int hstate_index(struct hstate *h)
 	return h - hstates;
 }
 
+/*
+ * Convert the address within this vma to the page offset within
+ * the mapping, in pagecache page units; huge pages here.
+ */
+static inline pgoff_t vma_hugecache_offset(struct hstate *h,
+			struct vm_area_struct *vma, unsigned long address)
+{
+	return ((address - vma->vm_start) >> huge_page_shift(h)) +
+		(vma->vm_pgoff >> huge_page_order(h));
+}
+
 pgoff_t __basepage_index(struct page *page);
 
 /* Return page->index in PAGE_SIZE units */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ede7e7f5d1ab..959aed5b7969 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -615,17 +615,6 @@ static long region_count(struct resv_map *resv, long f, long t)
 	return chg;
 }
 
-/*
- * Convert the address within this vma to the page offset within
- * the mapping, in pagecache page units; huge pages here.
- */
-static pgoff_t vma_hugecache_offset(struct hstate *h,
-			struct vm_area_struct *vma, unsigned long address)
-{
-	return ((address - vma->vm_start) >> huge_page_shift(h)) +
-			(vma->vm_pgoff >> huge_page_order(h));
-}
-
 pgoff_t linear_hugepage_index(struct vm_area_struct *vma,
 				     unsigned long address)
 {
diff --git a/mm/rmap.c b/mm/rmap.c
index e5dfe2ae6b0d..f8c95482c23e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1350,6 +1350,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	bool ret = true;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)arg;
+	u32 hugetlb_hash = 0;
 
 	/* munlock has nothing to gain from examining un-locked vmas */
 	if ((flags & TTU_MUNLOCK) && !(vma->vm_flags & VM_LOCKED))
@@ -1377,6 +1378,19 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 				min(vma->vm_end, address +
 				    (PAGE_SIZE << compound_order(page))));
 	if (PageHuge(page)) {
+		struct hstate *h = hstate_vma(vma);
+
+		/*
+		 * Take the hugetlb fault mutex so that we do not race with
+		 * page faults while modifying page table.  Mutex must be
+		 * acquired before ptl below.
+		 */
+		hugetlb_hash = hugetlb_fault_mutex_hash(h,
+					vma->vm_file->f_mapping,
+					vma_hugecache_offset(h, vma, address),
+					address);
+		mutex_lock(&hugetlb_fault_mutex_table[hugetlb_hash]);
+
 		/*
 		 * If sharing is possible, start and end will be adjusted
 		 * accordingly.
@@ -1659,6 +1673,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
+	if (PageHuge(page))
+		mutex_unlock(&hugetlb_fault_mutex_table[hugetlb_hash]);
 
 	return ret;
 }


Michal, Naoya any preferences on how this should be fixed?  I'll send a
proper patch if we agree on an approach.
-- 
Mike Kravetz
