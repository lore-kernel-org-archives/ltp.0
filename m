From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Nov 2018 01:03:27 +0100
Subject: [LTP] [PATCH] zram/zram03.c: Fix obsolete zram status files
In-Reply-To: <1531385810-22036-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1531385810-22036-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20181106000327.GA4619@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> Since kernel commit c87d1655c295, separate zram status files("compr_data_size",
> "num_reads" etc.) which can be accessed via one of zram<id>/stat or
> zram<id>/io_stat or zram<id>/mm_stat were removed.

> This commit broke zram03, as below:
> ----------------------------------------------------------------------
> safe_file_ops.c:144: Failed to open FILE '/sys/block/zram0/compr_data_size'
> for reading at zram03.c:181: errno=ENOENT(2): No such file or directory
> ----------------------------------------------------------------------

> Also, zero pages in zram<id>/mm_stat was extended to same element pages
> since kernel commit 8e19d540d107.

> We try to get requested zram status by zram<id>/stat and zram<id>/mm_stat
> if separate zram status files don't exist.

> URL for detailed zram status:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/blockdev/zram.txt
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/block/stat.txt

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---

Thanks for your patch, merged!
I'm sorry to keep you waiting for review so long.


Kind regards,
Petr
