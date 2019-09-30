From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Sep 2019 11:24:33 +0200
Subject: [LTP] [PATCH] syscalls/copy_file_range02: skip if cross-fs
 isn't supported
In-Reply-To: <20190927121528.31888-1-pvorel@suse.cz>
References: <20190927121528.31888-1-pvorel@suse.cz>
Message-ID: <20190930092432.GA17643@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +static inline int verify_cross_fs_copy_support(void)
> +{
> +	int i, fd, fd_test;
> +
> +	if (!test.mount_device)
> +		tst_brk(TBROK, "using %s() requires setting .mount_device = 1", __func__);
> +
> +	if (strcmp(test.mntpoint, MNTPOINT))
> +		tst_brk(TBROK, "using %s() requires setting .mntpoint = MNTPOINT ('%s')",
> +				__func__, test.mntpoint);

Can we please pass the source and destination as parameters to this
function instead of depending on very speical setup like this?

Also this is a last patch I do consider for the release, I will tag the
git once this is sorted out.

-- 
Cyril Hrubis
chrubis@suse.cz
