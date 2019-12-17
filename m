From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 Dec 2019 16:02:38 -0500 (EST)
Subject: [LTP] [PATCH v2] Use real FS block size in fallocate05
In-Reply-To: <20191217131703.16935-1-mdoucha@suse.cz>
References: <20191213134002.GE20795@rei.lan>
 <20191217131703.16935-1-mdoucha@suse.cz>
Message-ID: <1253407522.17207718.1576616558113.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> fallocate() behavior depends on whether the file range is aligned to full
> blocks. Make sure that the test always uses aligned file range so that
> the test is consistent across platforms.
> 
> Also use the TEST() macro to prevent errno pollution and increase test device
> size to avoid weird edge cases that don't happen in the real world.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Using fixed-size buffer in fallocate05 caused some failures in the past
> due to allocation requests being misaligned with actual file system blocks.
> Btrfs in particular will treat misaligned allocation as regular write()
> and apply copy-on-write to partially allocated blocks even on the first real
> write().
> 
> While that behavior is somewhat surprising, it does make sense. Fix the error
> by using multiples of real block size in fallocate() and write().
> 
> I'll also write another fallocate() test later for checking FS behavior
> on intentionally misaligned allocation. But this fix can be committed before
> that.
> 
> Changes since v1:
> - XFS keeps some free blocks even when write() failed with ENOSPC. Repeat
>   fallocate() until it gets ENOSPC, too.
> - Deallocate only part of the file. Btrfs will fail this check because it has
>   a bug.
> - Add description of test scenario in the header comment.
> - Increase test device size to 1GB to avoid unrealistic Btrfs edge cases.
> 

Looks good to me.

Is there an upstream thread link for that btrfs bug?

