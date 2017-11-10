From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 09:48:18 -0500 (EST)
Subject: [LTP] [PATCH 6/6] lib: mkfs: use 'mke2fs' on android systems
 for formatting filesystems
In-Reply-To: <20171109003438.130802-7-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
 <20171109003438.130802-7-sspatil@google.com>
Message-ID: <1305521830.39040751.1510325298805.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Android does not have mkfs.extN symlinks and only extN filesystems
> images can be created on the device. So, make sure we use 'mke2fs -t
> <fs_type>' when being built for Android and filter out any non-ext
> filesystem type requests from tst_mkfs_() when built for Android.

Hi,

So we probably need something similar for:
  d1f9382ba7c8 "lib: Add interface to list supported filesystems"
that introduced ".all_filesystems" as it also checks for mkfs.XXX.

> 
> syscalls/mmap16, syscalls/rename11 are the tests the tests currently
> known to start working after this change on Android systems
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  lib/tst_mkfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
> index 7385a939f..c46d07044 100644
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -43,7 +43,23 @@ void tst_mkfs_(const char *file, const int lineno, void
> (cleanup_fn)(void),
>  		return;
>  	}
>  
> +#ifdef __ANDROID__
> +	if (strncmp(fs_type, "ext", 3)) {
> +		tst_brkm(TBROK, cleanup_fn,
> +			 "%s:%d: \'%s\' fs_type not supported", file, lineno, fs_type);

This looks like it should TCONF instead. TBROK suggests there's something broken
about the test, but this is more property of the environment where it runs.

We TCONF already if mkfs.XXX can't be found couple lines below.
Maybe we could use it for android too, what do you think?

#ifdef __ANDROID__
if (!strncmp(fs_type, "ext", 3)) {
  // use mke2fs
}
#endif

if (pos == 1)
  // use mkfs.XXX

Regards,
Jan

> +		return;
> +	}
> +	strcpy(mkfs, "mke2fs");
> +
> +	/* insert '-t <fs_type> in arguments here */
> +	argv[pos++] = "-t";
> +	strcat(fs_opts_str, "-t ");
> +	argv[pos++] = fs_type;
> +	strcat(fs_opts_str, fs_type);
> +	strcat(fs_opts_str, " ");
> +#else
>  	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
> +#endif
>  
>  	if (fs_opts) {
>  		for (i = 0; fs_opts[i]; i++) {
> --
> 2.15.0.448.gf294e3d99a-goog
> 
> 
