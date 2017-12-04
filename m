From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Dec 2017 17:24:28 +0100
Subject: [LTP] [PATCH v2 4/4] lib: mkfs: use 'mke2fs' for formatting
 extN filesystems
In-Reply-To: <20171114021118.103786-5-sspatil@google.com>
References: <20171114021118.103786-1-sspatil@google.com>
 <20171114021118.103786-5-sspatil@google.com>
Message-ID: <20171204162428.GB21055@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> @@ -43,7 +45,18 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
>  		return;
>  	}
>  
> -	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
> +	if (tst_get_mkfs(fs_type, mkfs, NAME_MAX))
> +		tst_brkm(TCONF, cleanup_fn,
> +			 "mkfs.%s not found for %s", fs_type, fs_type);
> +
> +	if (!strcmp(mkfs, "mke2fs")) {
> +		/* insert '-t <fs_type> in arguments here */
> +		argv[pos++] = "-t";
> +		strcat(fs_opts_str, "-t ");
> +		argv[pos++] = fs_type;
> +		strcat(fs_opts_str, fs_type);
> +		strcat(fs_opts_str, " ");
> +	}

Hmm, this is kind of ugly, why do we have tst_get_mkfs() function and
then this if that fills it's arguments.

Well what about we rather exported the tst_fs_is_supported() function
and used it here before we even try to assemble the command to format
the filesystem.

I would have done it as following:

Change the is_supported() to tst_fs_is_supported() what would check for
mke2fs as a fallback command for ext*. Then the whole logic related to
mkfs would go into the tst_mkfs() function, including again the fallback
to mke2fs command for ext*.

Or we can move the ttst_supported_fs_types.c code to tst_mkfs.c (in a
separate patch) in order to get rid of the artificial boundary between
the two modules. That should free us to draft better code without a need
to draft publicly exposed interface between these two modules.

>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index a23b1ed52..a62dda0da 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -29,31 +29,43 @@ static const char *const fs_type_whitelist[] = {
>  	"ext2",
>  	"ext3",
>  	"ext4",
> +#ifndef __ANDROID__
>  	"xfs",
>  	"btrfs",
>  	"vfat",
>  	"exfat",
>  	"ntfs",
> +#endif
>  	NULL
>  };

What is the exact reason for this ifdef? Shouldn't the code handle the
missing support gracefully even without it?

-- 
Cyril Hrubis
chrubis@suse.cz
