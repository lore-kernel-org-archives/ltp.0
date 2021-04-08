From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Apr 2021 16:18:14 +0800
Subject: [LTP] [PATCH v3 1/4] lib: Add proper filesystem skiplist
In-Reply-To: <20210317105318.32017-2-chrubis@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
 <20210317105318.32017-2-chrubis@suse.cz>
Message-ID: <CAEemH2frh1iyW9SrVJkwXT9nrHt1C+WUmQUcNb=mCota9_xKAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 17, 2021 at 6:51 PM Cyril Hrubis <chrubis@suse.cz> wrote:

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
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  include/tst_fs.h                              | 25 +++++--
>  include/tst_test.h                            |  9 ++-
>  lib/tst_supported_fs_types.c                  | 66 +++++++++++++++----
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
>  testcases/lib/tst_supported_fs.c              |  4 +-
>  16 files changed, 93 insertions(+), 35 deletions(-)
>
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index cc5cc2c0c..6b1d800a1 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -167,18 +167,33 @@ int tst_fill_file(const char *path, char pattern,
> size_t bs, size_t bcount);
>   */
>  int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
>
> -#define TST_FS_SKIP_FUSE 0x01
> +enum tst_fs_type {
> +       TST_FS_UNSUPPORTED = 0,
> +       TST_FS_KERNEL = 1,
> +       TST_FS_FUSE = 2,
> +};
>

Do you think it necessary to rename 'enum tst_fs_type' to distinguish with
'fs_type'?

As it is quite similar to the 'fs_type*' series function and structure,
that might mess up
the code (we even have the same name function: tst_fs_type). So, I'd like
to suggest
use 'enum tst_fs_status' or 'enum tst_fs_item', or anything else.

Anyway, the remaining part of the patchset looks good.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210408/fb8243b3/attachment.htm>
