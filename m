From: Michael Holzheu <holzheu@linux.ibm.com>
Date: Fri, 25 Jan 2019 12:48:55 +0100
Subject: [LTP] LTP mount02: Fails on linux-next (EINVAL vs. ENOENT)
Message-ID: <20190125124855.0dab1e53@TP-holzheu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

The LTP testcase "mount02" fails on s390 with linux-next (built with commit 5b74ce505631)
as follows: 

mount02     5  TFAIL  :  mount02.c:117: mount() was expected to fail with EINVAL(22): TEST_ERRNO=ENOENT(2): No such file or directory

I simplified the testcase:

$ cat mount.c
#include <stdio.h>
#include <errno.h>
#include <sys/mount.h>

int main()
{
        int rc;

        rc = mount(NULL, "mnt", "ext2", 0, NULL);
        if (rc) {
                perror("Mount failed");
        }
        return 0;
}

When we run the testcase on linux-next, we get:

# mkdir mnt
# ./mount 
Mount failed: No such file or directory

On vanilla 5.0.0 we get:

# mkdir mnt
# ./mount 
Mount failed: Invalid argument

I checked the kernel code and I think the following commit introduced
the change:

 - 91e41453c388b5add ("introduce fs_context methods")

More precisely the following change:

@@ -1294,10 +1296,28 @@ int vfs_get_tree(struct fs_context *fc)
        struct super_block *sb;
        int error;
.
-       error = legacy_get_tree(fc);
+       if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source)
+               return -ENOENT;

IMHO the code patch before was like follows:

ksys_mount
  ...
  vfs_kern_mount() (fs/namespace.c)
   fc_mount() (fs/namespace.c)
    vfs_get_tree() (fs/super.c)
     legacy_get_tree() (fs/fs_context.c)

      fc->fs_type->mount().
        ext2_mount() (ext2/super.c)

         mount_bdev() (fs/super.c)
           blkdev_get_by_path(dev_name) (fs/block_dev.c)
             lookup_bdev() (fs/block_dev.c)
                     if (!pathname || !*pathname)
                         return ERR_PTR(-EINVAL);

So the question is: Should the testcase or the kernel code be changed?

Michael

