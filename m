From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Mar 2019 04:23:25 -0400 (EDT)
Subject: [LTP] LTP: mount02 was expected EINVAL(22) but got ENOENT(2):
 No such file or directory
In-Reply-To: <CA+G9fYsDK=4jJ31qeTpOxif+j7dTijznsboMHRdkfhQ3V0+8tA@mail.gmail.com>
References: <CA+G9fYudJC07HfrU1fVptCEvgCuBsF9G2N76PiGG5Z258z0Dzg@mail.gmail.com>
 <226607771.7950393.1552490962324.JavaMail.zimbra@redhat.com>
 <CA+G9fYsDK=4jJ31qeTpOxif+j7dTijznsboMHRdkfhQ3V0+8tA@mail.gmail.com>
Message-ID: <696858120.8161208.1552551805566.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi Jan,
> 
> Thanks for looking into this.
> 
> On Wed, 13 Mar 2019 at 20:59, Jan Stancek <jstancek@redhat.com> wrote:
> >
> >
> > ----- Original Message -----
> > > LTP syscalls mount02 failed on mainline (Linux version 5.0.0) for all
> > > devices.
> > >
> > > Results comparison link,
> > > https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/mount02
> > > you could see good and bad commit id in the above link.
> >
> > OK, so it's not "5.0.0" that fails, it's 5.0.0+ (5.0.0 + patches for
> > 5.1.0-rc1)
> >
> > I'm guessing this part:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/super.c#n1470
> > called by do_new_mount().
> >
> 
> You are guess is right,
> Here is the kernel commit changing the error code from EINVAL to ENOENT.

(TLDR version)
We are talking about this:
  mount(NULL, "mntpoint", "ext2", 0, NULL) = -1 EINVAL (Invalid argument)
now giving ENOENT.

Per man-page, ENOTBLK seems to fit more:
  ENOTBLK - source is not a block device (and a device was required).

> With this change we have to modify our test code.

And probably just accept both errnos (when this makes it to 5.1)

> 
> From f3a09c92018a91ad0981146a4ac59414f814d801 Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Sun, 23 Dec 2018 18:55:56 -0500
> Subject: introduce fs_context methods
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/super.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> (limited to 'fs/super.c')
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5055323..76b3181 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -894,13 +894,15 @@ int reconfigure_super(struct fs_context *fc)
>   }
>   }
> 
> - retval = legacy_reconfigure(fc);
> - if (retval) {
> - if (!force)
> - goto cancel_readonly;
> - /* If forced remount, go ahead despite any errors */
> - WARN(1, "forced remount of a %s fs returned %i\n",
> -     sb->s_type->name, retval);
> + if (fc->ops->reconfigure) {
> + retval = fc->ops->reconfigure(fc);
> + if (retval) {
> + if (!force)
> + goto cancel_readonly;
> + /* If forced remount, go ahead despite any errors */
> + WARN(1, "forced remount of a %s fs returned %i\n",
> +     sb->s_type->name, retval);
> + }
>   }
> 
>   WRITE_ONCE(sb->s_flags, ((sb->s_flags & ~fc->sb_flags_mask) |
> @@ -1294,10 +1296,28 @@ int vfs_get_tree(struct fs_context *fc)
>   struct super_block *sb;
>   int error;
> 
> - error = legacy_get_tree(fc);
> + if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
> + return -ENOENT;
> +
> + if (fc->root)
> + return -EBUSY;
> +
> + /* Get the mountable root in fc->root, with a ref on the root and a ref
> + * on the superblock.
> + */
> + error = fc->ops->get_tree(fc);
>   if (error < 0)
>   return error;
> 
> + if (!fc->root) {
> + pr_err("Filesystem %s get_tree() didn't set fc->root\n",
> +       fc->fs_type->name);
> + /* We don't know what the locking state of the superblock is -
> + * if there is a superblock.
> + */
> + BUG();
> + }
> +
>   sb = fc->root->d_sb;
>   WARN_ON(!sb->s_bdi);
> 
> 
> --
> cgit v1.1
> 
