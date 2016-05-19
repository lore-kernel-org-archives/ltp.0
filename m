From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 May 2016 12:19:08 +0200
Subject: [LTP] [PATCH 3/6] syscalls/madvise03: Convert to new test API
In-Reply-To: <20160519101242.GA20088@gmail.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
 <20160517162054.GC13705@rei.suse.cz>
 <20160519101242.GA20088@gmail.com>
Message-ID: <20160519101908.GA29601@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> There are different ways to support this on different kernels. If
> just mapping mmapped as 'RW' shared memory, it will not work on
> kernel < 3.5. It seems like we have to keep the orignal method which
> based on shmfs.
> 
> From Linux Programmer's Manual:
> "MADV_REMOVE (since Linux 2.6.16)
>        Free up a given range of pages and its associated backing
>        store.  This is equivalent to punching a hole in the
>        corresponding byte range of the backing store (see
>        fallocate(2)).  Subsequent accesses in the specified address
>        range will see bytes containing zero.
> 
>        The specified address range must be mapped shared and
>        writable.  This flag cannot be applied to locked pages, Huge
>        TLB pages, or VM_PFNMAP pages.
> 
>        In the initial implementation, only shmfs/tmpfs supported
>        MADV_REMOVE; but since Linux 3.5, any filesystem which
>        supports the fallocate(2) FALLOC_FL_PUNCH_HOLE mode also
>        supports MADV_REMOVE.  Hugetlbfs will fail with the error
>        EINVAL and other filesystems fail with the error EOPNOTSUPP."
> 
> A simple way is to create the mmaped file under '/dev/shm/' in setup()
> 	sprintf(filename, "/dev/shm/madvise01.%d", getpid());
> and remove it in cleanup(). Or using tmpfs.
> 
> What do you think?

Or we may use the POSIX IPC instead of the System V one. And if we do
shm_open(), ftruncate(), mmap(), shm_unlink(), and close() in setup()
everything will be freed once the mapping is released which will happen
automatically when the test exits. Technically this is the same as
opening file in /dev/shm/ but I would rather use the shm_open() instead.

-- 
Cyril Hrubis
chrubis@suse.cz
