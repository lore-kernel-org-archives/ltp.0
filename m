From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 10 Mar 2021 13:58:37 +0100
Subject: [LTP] [PATCH 1/3] lib: Add proper filesystem skiplist
In-Reply-To: <20210310122625.25425-2-chrubis@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <20210310122625.25425-2-chrubis@suse.cz>
Message-ID: <YEjCfVLhoLPMDEgu@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

3 very minor nits below.

> diff --git a/include/tst_fs.h b/include/tst_fs.h
...
>  /*
>   * Return 1 if a specified fiilsystem is supported
>   * Return 0 if a specified fiilsystem isn't supported
Please, while at it, could you fix "fiilsystem" typo?

...
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 00ede549d..cd505f570 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -45,13 +45,34 @@ static int has_mkfs(const char *fs_type)
>  	return 1;
>  }

> -static int has_kernel_support(const char *fs_type, int flags)
> +int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
> +{
> +	unsigned int i;
> +
> +	if (!skiplist)
> +		return 0;
> +
> +	for (i = 0; skiplist[i]; i++) {
> +		if (!strcmp(fs_type, skiplist[i])) {
> +			tst_res(TINFO,
It'd be nice if skipping message could be TCONF to avoid:
tst_supported_fs_types.c:57: TINFO: Skipping tmpfs as requested by the test
tst_test.c:1056: TCONF: Skipping due to unsupported filesystem

but understand why - it'd make code more complicated (has_kernel_support() which
is used in tst_fs_is_supported() should not emit TCONF).

> +			        "Skipping %s as requested by the test", fs_type);
checkpatch complain here about mixing spaces and tabs.

Kind regards,
Petr
