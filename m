From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Aug 2021 12:04:13 +0300
Subject: [LTP] [PATCH 6/7] syscalls/fanotify20: Test file event with
 broken inode
In-Reply-To: <20210802214645.2633028-7-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-7-krisman@collabora.com>
Message-ID: <CAOQ4uxg3MPfMeMPpzompend0n3rH3b1+fFbzUSHsMGRJX0ruEg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> This test corrupts an inode entry with an invalid mode through debugfs
> and then tries to access it.  This should result in a ext4 error, which
> we monitor through the fanotify group.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index e7ced28eb61d..0c63e90edc3a 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -76,6 +76,36 @@ static void trigger_fs_abort(void)
>                    MS_REMOUNT|MS_RDONLY, "abort");
>  }
>
> +#define TCASE2_BASEDIR "tcase2"
> +#define TCASE2_BAD_DIR TCASE2_BASEDIR"/bad_dir"
> +
> +static unsigned int tcase2_bad_ino;
> +static void tcase2_prepare_fs(void)
> +{
> +       struct stat stat;
> +
> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BASEDIR, 0777);
> +       SAFE_MKDIR(MOUNT_PATH"/"TCASE2_BAD_DIR, 0777);
> +
> +       SAFE_STAT(MOUNT_PATH"/"TCASE2_BAD_DIR, &stat);
> +       tcase2_bad_ino = stat.st_ino;

Better use fanotify_save_fid(MOUNT_PATH"/"TCASE2_BAD_DIR, &tcase2_bad_fid)

Thanks,
Amir.
