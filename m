From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 16:19:34 +0800
Subject: [LTP] [PATCH v2 1/3] lapi: Move struct file_handle into
 lapi/fcntl.h
In-Reply-To: <20210113075110.31628-2-pvorel@suse.cz>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-2-pvorel@suse.cz>
Message-ID: <5FFEAD16.7050704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> that way it can be used in fanotify tests
> (some of use the struct, but not name_to_handle_at() syscall)
> and the struct is defined in<fcntl.h>  anyway.
> 
> Although detection with HAVE_NAME_TO_HANDLE_AT works (at least on glibc,
> musl and uclibc-ng) add proper autotools check for the struct presence.
> 
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   configure.ac                     |  6 ++++++
>   include/lapi/fcntl.h             | 10 ++++++++++
>   include/lapi/name_to_handle_at.h |  9 +--------
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 06be1c094..e44e25cc6 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -148,6 +148,12 @@ AC_CHECK_TYPES([struct acct_v3],,,[#include<sys/acct.h>])
>   AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include<linux/if_alg.h>])
>   AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include<sys/fanotify.h>])
>   AC_CHECK_TYPES([struct file_dedupe_range],,,[#include<linux/fs.h>])
> +
> +AC_CHECK_TYPES([struct file_handle],,,[
> +#define _GNU_SOURCE
I think file_handle struct doesn't need _GNU_SOURCE macro or I miss
something?

Other than this, this patchset LGTM.
Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> +#include<fcntl.h>
> +])
> +
>   AC_CHECK_TYPES([struct fs_quota_statv],,,[#include<xfs/xqm.h>])
>   AC_CHECK_TYPES([struct if_nextdqblk],,,[#include<linux/quota.h>])
>   AC_CHECK_TYPES([struct iovec],,,[#include<sys/uio.h>])
> diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
> index d6665915f..e08970c4f 100644
> --- a/include/lapi/fcntl.h
> +++ b/include/lapi/fcntl.h
> @@ -6,6 +6,7 @@
>   #ifndef __LAPI_FCNTL_H__
>   #define __LAPI_FCNTL_H__
> 
> +#include "config.h"
>   #include<fcntl.h>
>   #include<sys/socket.h>
> 
> @@ -140,4 +141,13 @@
>   # define MAX_HANDLE_SZ	128
>   #endif
> 
> +#ifndef HAVE_STRUCT_FILE_HANDLE
> +struct file_handle {
> +	unsigned int handle_bytes;
> +	int handle_type;
> +	/* File identifier.  */
> +	unsigned char f_handle[0];
> +};
> +#endif /* HAVE_STRUCT_FILE_HANDLE */
> +
>   #endif /* __LAPI_FCNTL_H__ */
> diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
> index 3484133d1..275db4ae0 100644
> --- a/include/lapi/name_to_handle_at.h
> +++ b/include/lapi/name_to_handle_at.h
> @@ -15,13 +15,6 @@
>   #include "tst_test.h"
> 
>   #ifndef HAVE_NAME_TO_HANDLE_AT
> -struct file_handle {
> -	unsigned int handle_bytes;
> -	int handle_type;
> -	/* File identifier.  */
> -	unsigned char f_handle[0];
> -};
> -
>   static inline int name_to_handle_at(int dfd, const char *pathname,
>                                       struct file_handle *handle,
>                                       int *mount_id, int flags)
> @@ -35,7 +28,7 @@ static inline int open_by_handle_at(int mount_fd, struct file_handle *handle,
>   {
>   	return tst_syscall(__NR_open_by_handle_at, mount_fd, handle, flags);
>   }
> -#endif
> +#endif /* HAVE_NAME_TO_HANDLE_AT */
> 
>   /* Returns a valid pointer on success, NULL on errors */
>   static inline struct file_handle *



