From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Jul 2021 11:23:14 +0200
Subject: [LTP] [PATCH 2/2] lib: mount tmpfs name as ltp-tmpfs
In-Reply-To: <20210701055208.715395-2-liwang@redhat.com>
References: <20210701055208.715395-1-liwang@redhat.com>
 <20210701055208.715395-2-liwang@redhat.com>
Message-ID: <YN7bAlNkd1xaRj7Z@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Given a specific name as "ltp-tmpfs" instead of the "/dev/loopX"
> string in order to make "tmpfs" filesystem more evident.
> 
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 27766fbfd..ab343e593 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -896,19 +896,23 @@ static void prepare_device(void)
>  	}
>  
>  	if (tst_test->mount_device) {
> +		const char *path_name = tdev.dev;
>  		char *mnt_data = tst_test->mnt_data;
>  
>  		if (!strcmp(tdev.fs_type, "tmpfs")) {
>  			tst_test->mnt_data = limit_tmpfs_mount_size(tst_test->mnt_data,
>  					tst_test->dev_min_size);
> +			tdev.dev = "ltp-tmpfs";
>  		}
>  
>  		SAFE_MOUNT(tdev.dev, tst_test->mntpoint, tdev.fs_type,
>  			   tst_test->mnt_flags, tst_test->mnt_data);
>  		mntpoint_mounted = 1;
>  
> -		if (!strcmp(tdev.fs_type, "tmpfs"))
> +		if (!strcmp(tdev.fs_type, "tmpfs")) {
>  			tst_test->mnt_data = mnt_data;
> +			tdev.dev = path_name;

Here as well, do we need to change the tdev.dev?

Can't we just create a function get_device_name(const char *fs_type)
that would return either tdev.dev pointer or pointer to static
"ltp-tmpfs" string based on the fs_type argument?

-- 
Cyril Hrubis
chrubis@suse.cz
