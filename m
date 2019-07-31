From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 14:28:34 +0200
Subject: [LTP] [PATCH v7 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <1564569629-2358-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564569629-2358-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190731122834.GF22537@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Since Amir patch[1] for copy_file_range has been merged into upstream
> kernel, we should add swapfile, immutable file, bounds tests in ltp.
> Also, add block,char,pipe dev tests and remove EXDEV test(the cross-device
> constraint has been relaxed since[2]). I follow xfstests code[3].

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=96e6e8f4a
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5dae222a5
> [3]https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/(553,554,564,565}

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
