From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Thu, 3 Jan 2019 13:44:20 -0800
Subject: [LTP] [bug] problems with migration of huge pages with
 v4.20-10214-ge1ef035d272e
In-Reply-To: <495081357.93179893.1546535169172.JavaMail.zimbra@redhat.com>
References: <1323128903.93005102.1546461004635.JavaMail.zimbra@redhat.com>
 <6e608107-e071-90c0-bd73-4215325433c1@oracle.com>
 <dc056866-0e60-6ffa-54d5-5cafa1a4a53f@oracle.com>
 <1808265696.93134171.1546519652798.JavaMail.zimbra@redhat.com>
 <495081357.93179893.1546535169172.JavaMail.zimbra@redhat.com>
Message-ID: <6e341052-fe38-b71c-ebb2-47e2e34f5963@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/3/19 9:06 AM, Jan Stancek wrote:
<snip>
>> 1) with LTP move_pages12 (MAP_PRIVATE version of reproducer)
>> Patch below fixes the panic for me.
>> It didn't apply cleanly to latest master, but conflicts were easy to resolve.
>>
>> 2) with MAP_SHARED version of reproducer
>> It still hangs in user-space.
>> v4.19 kernel appears to work fine so I've started a bisect.
> 
> My bisect with MAP_SHARED version arrived at same 2 commits:
>   c86aa7bbfd55 hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race
>   b43a99900559 hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
> 
> Maybe a deadlock between page lock and mapping->i_mmap_rwsem?
> 
> thread1:
>   hugetlbfs_evict_inode
>     i_mmap_lock_write(mapping);
>     remove_inode_hugepages
>       lock_page(page);
> 
> thread2:
>   __unmap_and_move
>     trylock_page(page) / lock_page(page)
>       remove_migration_ptes
>         rmap_walk_file
>           i_mmap_lock_read(mapping);

Thanks Jan!  That is an ABBA deadlock. :(

Commit c86aa7bbfd55 ("Use i_mmap_rwsem to fix page fault/truncate race") is
the patch which causes remove_inode_hugepages to be called with i_mmap_rwsem
held in write mode.  Clearly, i_mmap_rwsem should not be held when calling
remove_inode_hugepages.  If you back out that patch, then the deadlock will
go away.

But, the whole point of that patch is to expand the locking so that
remove_inode_hugepages can not race with a page fault.  If they do race, then
hugetlbfs specific metadata becomes inconsistent.  With some tweaks to
c86aa7bbfd55, I think we could make truncate/page fault races safe.  However,
the issue would still exist for hole punch/page fault races.  We need some
way to prevent page faults while in remove_inode_hugepages.

Andrew, it might be best to revert these patches.  I am not sure if all the
issues with this approach to synchronization can be fixed.  To do so would
likely require more 'special case' conditions to code paths.  The code is
already difficult to understand.  I'd like to step back and take another look
at the best way to fix these problems.  As mentioned before, the issues these
patches address have existed for at least 10 years.  AFAIK, they have not been
seen in real world use cases.  They were discovered via code inspection and
can only be reproduced with highly targeted test programs.  So, waiting for
another release cycle to get a better solution might be the best approach.
I will continue to work this, but if you agree that backing out is the best
approach for now please let me know the process.  Do I simply send a 'revert'
patch to you and the list?

-- 
Mike Kravetz
