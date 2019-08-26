From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 26 Aug 2019 11:21:15 +0200
Subject: [LTP] [PATCH v2] syscalls/copy_file_range02: use .needs_tmpdir
 and MAX_LEN
In-Reply-To: <1566547679-2771-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1566547679-2771-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190826092115.GC9788@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

> Since commit bc514b22, we have removed EXDEV test. all_filesystem
> ,mount_device and mntpoint make no sense. Remove it and use tmpdir.

> As man-page said, when we plan to write at a position past the maximum
> allowed offset, it will return EFBIG. We should USE tst_max_lfs_filesize 
> as dst instead of (tst_max_lfs_fileszie - MIN_OFF). Also, it doesn't affect 
> EOVERFLOW.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
Thanks for the fix. I tempted to split these 2 changes into 2 commits,
but in the end kept it in single commit.

Merged (with adjusted commit message and
Reported-by for Murphy Zhou and Signed-off-by for Li as he did a review for
previous version).

Kind regards,
Petr
