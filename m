From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 22 May 2019 15:50:37 +0530
Subject: [LTP] ext4 regression (was Re: [PATCH 4.19 000/105]
	4.19.45-stable review)
In-Reply-To: <20190522050511.GB4943@mit.edu>
References: <20190520115247.060821231@linuxfoundation.org>
 <20190520222342.wtsjx227c6qbkuua@xps.therub.org>
 <20190521085956.GC31445@kroah.com>
 <CA+G9fYvHmUimtwszwo=9fDQLn+MNh8Vq3UGPaPUdhH=dEKzqxg@mail.gmail.com>
 <20190521093849.GA9806@kroah.com>
 <CA+G9fYveeg_FMsL31aunJ2A9XLYk908Y1nSFw4kwkFk3h3uEiA@mail.gmail.com>
 <20190521162142.GA2591@mit.edu>
 <CA+G9fYunxonkqmkhz+zmZYuMTfyRMVBxn6PkTFfjd8tTT+bzHQ@mail.gmail.com>
 <20190522050511.GB4943@mit.edu>
Message-ID: <CA+G9fYsA6BWh+W+U-9BSQWq63WZMKGXGbsh92LS94ZCempgm5A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 22 May 2019 at 10:36, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, May 21, 2019 at 11:27:21PM +0530, Naresh Kamboju wrote:
> > Steps to reproduce is,
> > running LTP three test cases in sequence on x86 device.
> > # cd ltp/runtest
> > # cat syscalls ( only three test case)
> > open12 open12
> > madvise06 madvise06
> > poll02 poll02
> > #
> >
> > as Dan referring to,
> >
> > LTP is run using '/opt/ltp/runltp -d /scratch -f syscalls', where the
> > syscalls file has been replaced with three test case names, and
> > /scratch is an ext4 SATA drive. /scratch is created using 'mkfs -t ext4
> > /dev/disk/by-id/ata-TOSHIBA_MG03ACA100_37O9KGKWF' and mounted to
> > /scratch.
>
> I'm still having trouble reproducing the problem.  I've followed the
> above exactly, and it doesn't trigger on my system.  I think I know
> what is happening, but even given my theory, I'm still not able to
> trigger it.  So, I'm not 100% sure this is the appropriate fix.  If
> you can reproduce it, can you see if this patch, applied on top of the
> Linus's tip, fixes the problem for you?

Applied your patch on mainline master branch and tested on x86_64 and
confirms that the reported problem fixed.

Thanks for your fix patch.

LTP syscalls full test output log,
https://lkft.validation.linaro.org/scheduler/job/739075

---
Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using
block_validity")
    Reported-by: Dan Rue <dan.rue@linaro.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2c62e2a0c98..d40ed940001e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -518,10 +518,14 @@ __read_extent_tree_block(const char *function,
unsigned int line,
        }
        if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
                return bh;
-       err = __ext4_ext_check(function, line, inode,
-                              ext_block_hdr(bh), depth, pblk);
-       if (err)
-               goto errout;
+       if (!ext4_has_feature_journal(inode->i_sb) ||
+           (inode->i_ino !=
+            le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum))) {
+               err = __ext4_ext_check(function, line, inode,
+                                      ext_block_hdr(bh), depth, pblk);
+               if (err)
+                       goto errout;
+       }
        set_buffer_verified(bh);
        /*
         * If this is a leaf block, cache all of its entries


- Naresh
