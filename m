From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 15 Feb 2021 08:40:02 -0700
Subject: [LTP] [btrfs] 3d6ef82805:
 WARNING:at_fs/btrfs/extent-tree.c:#btrfs_reserve_extent[btrfs]
In-Reply-To: <20210215132734.GA15834@xsang-OptiPlex-9020>
References: <20210215132734.GA15834@xsang-OptiPlex-9020>
Message-ID: <8fec3d91-fd37-0159-7417-0661659e2e02@kernel.dk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/15/21 6:27 AM, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 3d6ef82805958611e8ffa0a901c014b6f066c3e6 ("btrfs: relax memory alignment restriction for O_DIRECT")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git dio-mem-align

This patch has been dropped, we did identify last week that btrfs
needs more work to support sub bs memory alignment for dio.

-- 
Jens Axboe

