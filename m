From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 11:39:27 +0100
Subject: [LTP] [PATCH 2/2] syscalls/quotactl: Skip tests if FS quota is
 not supported
In-Reply-To: <20210309171104.30821-2-mdoucha@suse.cz>
References: <20210309171104.30821-1-mdoucha@suse.cz>
 <20210309171104.30821-2-mdoucha@suse.cz>
Message-ID: <YEtE319q3N4z0qQL@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
...
> +static void do_mount(const char *source, const char *target,
> +	const char *filesystemtype, unsigned long mountflags,
> +	const void *data)
> +{
> +	TEST(mount(source, target, filesystemtype, mountflags, data));
> +
> +	if (TST_RET == -1 && TST_ERR == ESRCH)
> +		tst_brk(TCONF, "Kernel or device does not support FS quotas");
BTW I was also thinking about moving this also into safe_mount(), but
quotactl04.c is the only test which is using "-O quota" option, thus probably
useless.

Kind regards,
Petr

> +
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
> +			source, target, filesystemtype, mountflags, data);
> +	}
> +
> +	if (TST_RET) {
> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
> +			source, target, filesystemtype, mountflags, data);
> +	}
> +
> +	mount_flag = 1;
> +}
