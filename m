From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 7 Aug 2019 19:44:47 -0700
Subject: [LTP] [PATCH] hugetlbfs: fix hugetlb page migration/fault race
 causing SIGBUS
In-Reply-To: <f7a64f0a-1ae0-4582-a293-b608bc8fed36.xishi.qiuxishi@alibaba-inc.com>
References: <f7a64f0a-1ae0-4582-a293-b608bc8fed36.xishi.qiuxishi@alibaba-inc.com>
Message-ID: <5f072c20-2396-48ee-700a-ea7eafc20328@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/7/19 7:24 PM, ???(??) wrote:
> Hi Mike,
> 
> Do you mean the similar race is like the following?
> 
> migration clearing the pte
>   page fault(before we return error, and now we return 0, then try page fault again, right?)
>     migration writing a migration entry

Yes, something like the that.  The change is to takes the page table lock
to examine the pte before returning.  If the pte is clear when examined
while holding the lock, an error will be returned as before.  If not clear,
then we return zero and try again.

This change adds code which is very much like this check further in
the routine hugetlb_no_page():

	ptl = huge_pte_lock(h, mm, ptep);
	size = i_size_read(mapping->host) >> huge_page_shift(h);
	if (idx >= size)
		goto backout;

	ret = 0;
	if (!huge_pte_none(huge_ptep_get(ptep)))
		goto backout;

-- 
Mike Kravetz
