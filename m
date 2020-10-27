From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 27 Oct 2020 21:12:27 +0800
Subject: [LTP] [PATCH 11/19] Unify error handling in lib/tst_fs_setup.c
In-Reply-To: <20201026164756.30556-12-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
 <20201026164756.30556-12-mdoucha@suse.cz>
Message-ID: <5F981CBB.4040704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Martin
> - Properly format caller file:line location
>
> Signed-off-by: Martin Doucha<mdoucha@suse.cz>
> ---
>   lib/tst_fs_setup.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
> index 54ea37077..a2dacd2ad 100644
> --- a/lib/tst_fs_setup.c
> +++ b/lib/tst_fs_setup.c
> @@ -36,11 +36,11 @@ int mount_overlay(const char *file, const int lineno, int skip)
>
>   	if (errno == ENODEV) {
>   		if (skip) {
> -			tst_brk(TCONF, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
> -				file, lineno);
> +			tst_brk_(file, lineno, TCONF,
> +				TST_FS_SETUP_OVERLAYFS_MSG);
>   		} else {
> -			tst_res(TINFO, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
> -				file, lineno);
> +			tst_res_(file, lineno, TINFO,
> +				TST_FS_SETUP_OVERLAYFS_MSG);
>   		}
>   	} else {
>   		tst_brk(TBROK | TERRNO, "overlayfs mount failed");

We should  also use tst_brk_ to replace this.


