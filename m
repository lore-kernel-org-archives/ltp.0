From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Aug 2019 11:25:20 +0200
Subject: [LTP] [PATCH v2] syscalls/statx04: use stx_attributes_mask
 before test
In-Reply-To: <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20190802115046.GB27727@rei>
 <1566282838-2980-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20190827092520.GA28859@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> stx_attributes_mask shows what's supported in stx_attributes.
> we should check four attrbutes whether supports on tested filesystem
typo attrbutes
> and only test supported flags on tested filesystem.

I'd change it to
Set supp_{append,compr,immutable,nodump} attributes only on filesystems which
actually support them.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/statx/statx04.c | 124 ++++++++++++++++------
...

> -	attr |= FS_COMPR_FL | FS_APPEND_FL | FS_IMMUTABLE_FL | FS_NODUMP_FL;
> +	if (supp_compr)
> +		attr |= FS_COMPR_FL;
> +	if (supp_append)
> +		attr |= FS_APPEND_FL;
> +	if (supp_immutable)
> +		attr |= FS_IMMUTABLE_FL;
> +	if (supp_nodump)
> +		attr |= FS_NODUMP_FL;

>  	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
>  	if (ret < 0) {
> @@ -149,12 +176,43 @@ static void caid_flags_setup(void)

Current code...
	if (supp_append)
		attr |= FS_APPEND_FL;
	if (supp_compr)
		attr |= FS_COMPR_FL;
	if (supp_immutable)
		attr |= FS_IMMUTABLE_FL;
	if (supp_nodump)
		attr |= FS_NODUMP_FL;

	ret = ioctl(fd, FS_IOC_SETFLAGS, &attr);
	if (ret < 0) {
I wonder, if this check is still needed. Probably it's still useful to have
sanity check, but "Flags not supported" has been caught
by supp_{append,compr,immutable,nodump} variables.

		if (errno == EOPNOTSUPP)
			tst_brk(TCONF, "Flags not supported");
		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_SETFLAGS, %i)", fd, attr);
	}
...

Kind regards,
Petr
