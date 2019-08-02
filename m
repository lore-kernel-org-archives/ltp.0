From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 13:50:46 +0200
Subject: [LTP] [PATCH] syscalls/statx04: use stx_attributes_mask before
 test
In-Reply-To: <1564742081-2234-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1564742081-2234-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190802115046.GB27727@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	/* Mask to show which attributes are supported on filesystem. */
> +	if ((buf.stx_attributes_mask & FS_COMPR_FL) == 0)
> +		tst_brk(TCONF, "filesystem doesn't support FS_COMPR_FL");
> +	if ((buf.stx_attributes_mask & FS_APPEND_FL) == 0)
> +		tst_brk(TCONF, "filesystem doesn't support FS_APPEND_FL");
> +	if ((buf.stx_attributes_mask & FS_IMMUTABLE_FL) == 0)
> +		tst_brk(TCONF, "filesystem doesn't support FS_IMMUTABLE_FL");
> +	if ((buf.stx_attributes_mask & FS_NODUMP_FL) == 0)
> +		tst_brk(TCONF, "filesystem doesn't support FS_NODUMP_FL");

I doubt that all these flags are either set or unset for a given
fileystem, can we rather than this set flags such as supp_compr etc and
disable only tests for a subset of unsupported flags rather than the
whole test?

-- 
Cyril Hrubis
chrubis@suse.cz
