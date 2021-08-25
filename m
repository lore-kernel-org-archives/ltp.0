From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Aug 2021 16:54:37 +0200
Subject: [LTP] [PATCH 1/1] doc: TST_MNTPOINT should be full path
In-Reply-To: <20210825071420.5751-1-pvorel@suse.cz>
References: <20210825071420.5751-1-pvorel@suse.cz>
Message-ID: <YSZZrdiYVCUa2zeI@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Document changed behavior in 205a43dfb ("Make argument to tst_umount an
> absolute path").
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/shell-test-api.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index ecdbe9e6a..afc01dd01 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -515,8 +515,8 @@ The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
>  '$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
>  exist prior to the function call.
>  
> -If the path passed (optional, defaults to '$TST_MNTPOINT') to the 'tst_umount' is
> -not mounted (present in '/proc/mounts') it's noop.
> +If the path passed (optional, should be full path, defaults to '$TST_MNTPOINT')
                                  ^          ^
				  must     absolute


-- 
Cyril Hrubis
chrubis@suse.cz
