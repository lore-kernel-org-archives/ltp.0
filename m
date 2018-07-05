From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 5 Jul 2018 12:11:53 -0300
Subject: [LTP] FAILED: patch "[PATCH] ovl: hash non-dir by lower inode
 for fsnotify" failed to apply to 4.14-stable tree
In-Reply-To: <152086697777252@kroah.com>
References: <152086697777252@kroah.com>
Message-ID: <CABdQkv8E4Ofv5MSX=U0wk1MZ5=szUSr54vshhn6X_wsB+tEz2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* INFORMATIONAL ONLY - NO ACTION/READING NEEDED

BUG: https://bugs.linaro.org/show_bug.cgi?id=3881

Because the lack of the following commit:

commit 764baba80168ad3adafb521d2ab483ccbc49e344
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sun Feb 4 15:35:09 2018 +0200

    ovl: hash non-dir by lower inode for fsnotify

INFO: inotify issue with non-dir non-upper files in overlayfs exists
in LTS <= v4.14.
INFO: LTP inotify08 test fails on * v4.14 and bellow * and should be skipped.

Trying to cherry-pick to v4.14 has proven not to be feasible without
bringing many new features/code into LTS tree (up to any Linux
distribution to decide to backport or not).

For clean cherry picks, commits:

 ovl: hash non-dir by lower inode for fsnotify
 ovl: hash non-indexed dir by upper inode for NFS export
 ovl: do not pass overlay dentry to ovl_get_inode()
 ovl: hash directory inodes for fsnotify
 ovl: no direct iteration for dir with origin xattr
 Revert "ovl: hash directory inodes for fsnotify"

are needed AND all the logic for setting up "origin" variable in
ovl_lookup, passed to ovl_lookup_index() after it got its prototype
changed, would still be missing. Unfortunately the "origin" also
depends on commit 051224438 ("ovl: generalize ovl_verify_origin() and
helpers") and some others ones that refactor many functions.

-Rafael

On Mon, Mar 12, 2018@12:02 PM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 4.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 764baba80168ad3adafb521d2ab483ccbc49e344 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Sun, 4 Feb 2018 15:35:09 +0200
> Subject: [PATCH] ovl: hash non-dir by lower inode for fsnotify
>
> Commit 31747eda41ef ("ovl: hash directory inodes for fsnotify")
> fixed an issue of inotify watch on directory that stops getting
> events after dropping dentry caches.
>
> A similar issue exists for non-dir non-upper files, for example:
>
> $ mkdir -p lower upper work merged
> $ touch lower/foo
> $ mount -t overlay -o
> lowerdir=lower,workdir=work,upperdir=upper none merged
> $ inotifywait merged/foo &
> $ echo 2 > /proc/sys/vm/drop_caches
> $ cat merged/foo
>
> inotifywait doesn't get the OPEN event, because ovl_lookup() called
> from 'cat' allocates a new overlay inode and does not reuse the
> watched inode.
>
> Fix this by hashing non-dir overlay inodes by lower real inode in
> the following cases that were not hashed before this change:
>  - A non-upper overlay mount
>  - A lower non-hardlink when index=off
>
> A helper ovl_hash_bylower() was added to put all the logic and
> documentation about which real inode an overlay inode is hashed by
> into one place.
>
> The issue dates back to initial version of overlayfs, but this
> patch depends on ovl_inode code that was introduced in kernel v4.13.
>
> Cc: <stable@vger.kernel.org> #v4.13
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index fcd97b783fa1..3b1bd469accd 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -669,38 +669,59 @@ struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *real,
>         return inode;
>  }
>
> +/*
> + * Does overlay inode need to be hashed by lower inode?
> + */
> +static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
> +                            struct dentry *lower, struct dentry *index)
> +{
> +       struct ovl_fs *ofs = sb->s_fs_info;
> +
> +       /* No, if pure upper */
> +       if (!lower)
> +               return false;
> +
> +       /* Yes, if already indexed */
> +       if (index)
> +               return true;
> +
> +       /* Yes, if won't be copied up */
> +       if (!ofs->upper_mnt)
> +               return true;
> +
> +       /* No, if lower hardlink is or will be broken on copy up */
> +       if ((upper || !ovl_indexdir(sb)) &&
> +           !d_is_dir(lower) && d_inode(lower)->i_nlink > 1)
> +               return false;
> +
> +       /* No, if non-indexed upper with NFS export */
> +       if (sb->s_export_op && upper)
> +               return false;
> +
> +       /* Otherwise, hash by lower inode for fsnotify */
> +       return true;
> +}
> +
>  struct inode *ovl_get_inode(struct super_block *sb, struct dentry *upperdentry,
>                             struct dentry *lowerdentry, struct dentry *index,
>                             unsigned int numlower)
>  {
> -       struct ovl_fs *ofs = sb->s_fs_info;
>         struct inode *realinode = upperdentry ? d_inode(upperdentry) : NULL;
>         struct inode *inode;
> -       /* Already indexed or could be indexed on copy up? */
> -       bool indexed = (index || (ovl_indexdir(sb) && !upperdentry));
> -       struct dentry *origin = indexed ? lowerdentry : NULL;
> +       bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry, index);
>         bool is_dir;
>
> -       if (WARN_ON(upperdentry && indexed && !lowerdentry))
> -               return ERR_PTR(-EIO);
> -
>         if (!realinode)
>                 realinode = d_inode(lowerdentry);
>
>         /*
> -        * Copy up origin (lower) may exist for non-indexed non-dir upper, but
> -        * we must not use lower as hash key in that case.
> -        * Hash non-dir that is or could be indexed by origin inode.
> -        * Hash dir that is or could be merged by origin inode.
> -        * Hash pure upper and non-indexed non-dir by upper inode.
> -        * Hash non-indexed dir by upper inode for NFS export.
> +        * Copy up origin (lower) may exist for non-indexed upper, but we must
> +        * not use lower as hash key if this is a broken hardlink.
>          */
>         is_dir = S_ISDIR(realinode->i_mode);
> -       if (is_dir && (indexed || !sb->s_export_op || !ofs->upper_mnt))
> -               origin = lowerdentry;
> -
> -       if (upperdentry || origin) {
> -               struct inode *key = d_inode(origin ?: upperdentry);
> +       if (upperdentry || bylower) {
> +               struct inode *key = d_inode(bylower ? lowerdentry :
> +                                                     upperdentry);
>                 unsigned int nlink = is_dir ? 1 : realinode->i_nlink;
>
>                 inode = iget5_locked(sb, (unsigned long) key,
> @@ -728,6 +749,7 @@ struct inode *ovl_get_inode(struct super_block *sb, struct dentry *upperdentry,
>                         nlink = ovl_get_nlink(lowerdentry, upperdentry, nlink);
>                 set_nlink(inode, nlink);
>         } else {
> +               /* Lower hardlink that will be broken on copy up */
>                 inode = new_inode(sb);
>                 if (!inode)
>                         goto out_nomem;
>
