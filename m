From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 10 Mar 2021 17:19:25 +0100
Subject: [LTP] [PATCH 1/3] lib: Add proper filesystem skiplist
In-Reply-To: <20210310122625.25425-2-chrubis@suse.cz>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <20210310122625.25425-2-chrubis@suse.cz>
Message-ID: <30fec758-5e18-fceb-ec23-646253ba0e46@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 10. 03. 21 13:26, Cyril Hrubis wrote:
> The approach with flags we added for FUSE does not scale at all, we need
> a proper skiplist so that we can skip individual filesystems.
> 
> The motivation here is the addition of tmpfs to the supported
> filesystems check. One of the problems there is that sync() is no-op on
> tmpfs and hence the syncfs test fails. After this patchset we can simply
> skip syncfs test on tmpfs by setting the right skiplist.
> 
> As a bonus point the list of unsupported filesystem gets nicely
> propagated to the metadata as well.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_fs.h                              | 19 +++++++---
>  include/tst_test.h                            |  9 +++--
>  lib/tst_supported_fs_types.c                  | 35 ++++++++++++++-----
>  lib/tst_test.c                                |  2 +-
>  .../kernel/syscalls/fsconfig/fsconfig01.c     |  2 +-
>  testcases/kernel/syscalls/fsmount/fsmount01.c |  2 +-
>  testcases/kernel/syscalls/fsmount/fsmount02.c |  2 +-
>  testcases/kernel/syscalls/fsopen/fsopen01.c   |  2 +-
>  testcases/kernel/syscalls/fspick/fspick01.c   |  2 +-
>  testcases/kernel/syscalls/fspick/fspick02.c   |  2 +-
>  .../kernel/syscalls/move_mount/move_mount01.c |  2 +-
>  .../kernel/syscalls/move_mount/move_mount02.c |  2 +-
>  .../kernel/syscalls/open_tree/open_tree01.c   |  2 +-
>  .../kernel/syscalls/open_tree/open_tree02.c   |  2 +-
>  .../sync_file_range/sync_file_range02.c       |  2 +-
>  testcases/lib/tst_supported_fs.c              |  4 +--
>  16 files changed, 63 insertions(+), 28 deletions(-)
> 
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 00ede549d..cd505f570 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -45,13 +45,34 @@ static int has_mkfs(const char *fs_type)
>  	return 1;
>  }
>  
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
> +			        "Skipping %s as requested by the test", fs_type);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int has_kernel_support(const char *fs_type, const char *const *skiplist)
>  {
>  	static int fuse_supported = -1;
>  	const char *tmpdir = getenv("TMPDIR");
>  	char buf[128];
>  	int ret;
>  
> +	if (tst_fs_in_skiplist(fs_type, skiplist))
> +		return 0;
> +
>  	if (!tmpdir)
>  		tmpdir = "/tmp";
>  
> @@ -84,26 +105,24 @@ static int has_kernel_support(const char *fs_type, int flags)
>  		return 0;
>  	}
>  
> -	if (flags & TST_FS_SKIP_FUSE) {
> -		tst_res(TINFO, "Skipping FUSE as requested by the test");
> +	if (tst_fs_in_skiplist("fuse", skiplist))
>  		return 0;
> -	}
>  
>  	tst_res(TINFO, "FUSE does support %s", fs_type);
>  	return 1;
>  }

I don't think that has_kernel_support() should look at the skiplist at
all. The entire skiplist logic should be handled in
tst_get_supported_fs_types(). But has_kernel_support() could return
different (non-zero) values for native support and for FUSE support.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
