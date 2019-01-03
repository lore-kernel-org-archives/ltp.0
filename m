From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Jan 2019 12:06:09 -0500 (EST)
Subject: [LTP] [bug] problems with migration of huge pages with
 v4.20-10214-ge1ef035d272e
In-Reply-To: <1808265696.93134171.1546519652798.JavaMail.zimbra@redhat.com>
References: <1323128903.93005102.1546461004635.JavaMail.zimbra@redhat.com>
 <6e608107-e071-90c0-bd73-4215325433c1@oracle.com>
 <dc056866-0e60-6ffa-54d5-5cafa1a4a53f@oracle.com>
 <1808265696.93134171.1546519652798.JavaMail.zimbra@redhat.com>
Message-ID: <495081357.93179893.1546535169172.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
<snip>

> > That commit does cause BUGs for migration and page poisoning of anon huge
> > pages.  The patch was trying to take care of i_mmap_rwsem locking outside
> > try_to_unmap infrastructure.  This is because try_to_unmap will take the
> > semaphore in read mode (for file mappings) and we really need it to be
> > taken in write mode.
> > 
> > The patch below continues to take the semaphore outside try_to_unmap for
> > the file mapping case.  For anon mappings, the locking is done as a special
> > case in try_to_unmap_one.  This is something I was trying to avoid as it
> > it harder to follow/understand.  Any suggestions on how to restructure this
> > or make it more clear are welcome.
> > 
> > Adding Andrew on Cc as he already sent the commit causing the BUGs
> > upstream.
> > 
> > From: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > hugetlbfs: fix migration and poisoning of anon huge pages
> > 
> > Expanded use of i_mmap_rwsem for pmd sharing synchronization incorrectly
> > used page_mapping() of anon huge pages to get to address_space
> > i_mmap_rwsem.  Since page_mapping() is NULL for pages of anon mappings,
> > an "unable to handle kernel NULL pointer" BUG would occur with stack
> > similar to:
> > 
> > RIP: 0010:down_write+0x1b/0x40
> > Call Trace:
> >  migrate_pages+0x81f/0xb90
> >  __ia32_compat_sys_migrate_pages+0x190/0x190
> >  do_move_pages_to_node.isra.53.part.54+0x2a/0x50
> >  kernel_move_pages+0x566/0x7b0
> >  __x64_sys_move_pages+0x24/0x30
> >  do_syscall_64+0x5b/0x180
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > To fix, only use page_mapping() for non-anon or file pages.  For anon
> > pages wait until we find a vma in which the page is mapped and get the
> > address_space from vm_file.
> > 
> > Fixes: b43a99900559 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
> > synchronization")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Mike,
> 
> 1) with LTP move_pages12 (MAP_PRIVATE version of reproducer)
> Patch below fixes the panic for me.
> It didn't apply cleanly to latest master, but conflicts were easy to resolve.
> 
> 2) with MAP_SHARED version of reproducer
> It still hangs in user-space.
> v4.19 kernel appears to work fine so I've started a bisect.

My bisect with MAP_SHARED version arrived at same 2 commits:
  c86aa7bbfd55 hugetlbfs: Use i_mmap_rwsem to fix page fault/truncate race
  b43a99900559 hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization

Maybe a deadlock between page lock and mapping->i_mmap_rwsem?

thread1:
  hugetlbfs_evict_inode
    i_mmap_lock_write(mapping);
    remove_inode_hugepages
      lock_page(page);

thread2:
  __unmap_and_move
    trylock_page(page) / lock_page(page)
      remove_migration_ptes
        rmap_walk_file
          i_mmap_lock_read(mapping);

Here's strace output:
<snip>
1196  11:27:16 mmap(NULL, 4194304, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS|MAP_HUGETLB, -1, 0) = 0x7f646c400000
1197  11:27:16 set_robust_list(0x7f646d5b0e60, 24) = 0
1197  11:27:16 getppid()                = 1196
1197  11:27:16 move_pages(1196, 1024, [0x7f646c400000, 0x7f646c401000, 0x7f646c402000, 0x7f646c403000, 0x7f646c404000, 0x7f646c405000, 0x7f646c406000, 0x7f646c407000, 0x7f646c408000, 0x7f646c409000, 0x7f646c40a000, 0x7f646c40b000, 0x7f646c40c000, 0x7f646c40d000, 0x7f646c40e000, 0x7f646c40f000, 0x7f646c410000, 0x7f646c411000, 0x7f646c412000, 0x7f646c413000, 0x7f646c414000, 0x7f646c415000, 0x7f646c416000, 0x7f646c417000, 0x7f646c418000, 0x7f646c419000, 0x7f646c41a000, 0x7f646c41b000, 0x7f646c41c000, 0x7f646c41d000, 0x7f646c41e000, 0x7f646c41f000, ...], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...], [-ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, -ENOENT, ...], MPOL_MF_MOVE_ALL) = 0
1197  11:27:16 move_pages(1196, 1024, [0x7f646c400000, 0x7f646c401000, 0x7f646c402000, 0x7f646c403000, 0x7f646c404000, 0x7f646c405000, 0x7f646c406000, 0x7f646c407000, 0x7f646c408000, 0x7f646c409000, 0x7f646c40a000, 0x7f646c40b000, 0x7f646c40c000, 0x7f646c40d000, 0x7f646c40e000, 0x7f646c40f000, 0x7f646c410000, 0x7f646c411000, 0x7f646c412000, 0x7f646c413000, 0x7f646c414000, 0x7f646c415000, 0x7f646c416000, 0x7f646c417000, 0x7f646c418000, 0x7f646c419000, 0x7f646c41a000, 0x7f646c41b000, 0x7f646c41c000, 0x7f646c41d000, 0x7f646c41e000, 0x7f646c41f000, ...], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...], [1, -EACCES, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...], MPOL_MF_MOVE_ALL) = 0
1197  11:27:16 move_pages(1196, 1024, [0x7f646c400000, 0x7f646c401000, 0x7f646c402000, 0x7f646c403000, 0x7f646c404000, 0x7f646c405000, 0x7f646c406000, 0x7f646c407000, 0x7f646c408000, 0x7f646c409000, 0x7f646c40a000, 0x7f646c40b000, 0x7f646c40c000, 0x7f646c40d000, 0x7f646c40e000, 0x7f646c40f000, 0x7f646c410000, 0x7f646c411000, 0x7f646c412000, 0x7f646c413000, 0x7f646c414000, 0x7f646c415000, 0x7f646c416000, 0x7f646c417000, 0x7f646c418000, 0x7f646c419000, 0x7f646c41a000, 0x7f646c41b000, 0x7f646c41c000, 0x7f646c41d000, 0x7f646c41e000, 0x7f646c41f000, ...], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, ...],  <unfinished ...>
1196  11:27:16 munmap(0x7f646c400000, 4194304 <unfinished ...>
<hangs>

Regards,
Jan
