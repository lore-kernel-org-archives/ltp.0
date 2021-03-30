From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 30 Mar 2021 11:00:12 +0100
Subject: [LTP] [PATCH 1/1] tst_mkfs: Add -I option to mkfs.vfat
In-Reply-To: <20210329145738.986-1-pvorel@suse.cz>
References: <20210329145738.986-1-pvorel@suse.cz>
Message-ID: <87czvhneqb.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> to workaround occasional error on tests with .all_filesystems flag:
>
> tst_test.c:888: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0',
>  not making filesystem (use -I to override)
> tst_test.c:888: TBROK: mkfs.vfat failed with exit code 1
>
> Tested also on BusyBox v1.33.0, which accept but ignores -I since
> beginning (1.14.0).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Richard also suggested to wipe the device, but not sure how to do it
> quickly and don't bring any more dependency.

I guess that you only need to wipe the headers by writing zeros to the
device. That is unless this is actually refering to a mapping in
/dev/mapper?

>
> Kind regards,
> Petr
>
>  lib/tst_mkfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 736324f04..2d335a3ad 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -52,6 +52,16 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
>  
>  	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
>  
> +	/*
> +	 * Workaround a problem:
> +	 * mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> +	 * making filesystem (use -I to override)
> +	 */
> +	if (!strcmp(fs_type, "vfat")) {
> +		argv[pos] = "-I";
> +		strcat(fs_opts_str, argv[pos++]);

Doesn't it need a space after -I? Might be better to put this after
fs_opts and then you can check i > 0.

> +	}
> +
>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
>  			argv[pos++] = fs_opts[i];


-- 
Thank you,
Richard.
