From: Theodore Ts'o <tytso@mit.edu>
Date: Wed, 22 May 2019 01:05:11 -0400
Subject: [LTP] ext4 regression (was Re: [PATCH 4.19 000/105]
 4.19.45-stable review)
In-Reply-To: <CA+G9fYunxonkqmkhz+zmZYuMTfyRMVBxn6PkTFfjd8tTT+bzHQ@mail.gmail.com>
References: <20190520115247.060821231@linuxfoundation.org>
 <20190520222342.wtsjx227c6qbkuua@xps.therub.org>
 <20190521085956.GC31445@kroah.com>
 <CA+G9fYvHmUimtwszwo=9fDQLn+MNh8Vq3UGPaPUdhH=dEKzqxg@mail.gmail.com>
 <20190521093849.GA9806@kroah.com>
 <CA+G9fYveeg_FMsL31aunJ2A9XLYk908Y1nSFw4kwkFk3h3uEiA@mail.gmail.com>
 <20190521162142.GA2591@mit.edu>
 <CA+G9fYunxonkqmkhz+zmZYuMTfyRMVBxn6PkTFfjd8tTT+bzHQ@mail.gmail.com>
Message-ID: <20190522050511.GB4943@mit.edu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 21, 2019 at 11:27:21PM +0530, Naresh Kamboju wrote:
> Steps to reproduce is,
> running LTP three test cases in sequence on x86 device.
> # cd ltp/runtest
> # cat syscalls ( only three test case)
> open12 open12
> madvise06 madvise06
> poll02 poll02
> #
> 
> as Dan referring to,
> 
> LTP is run using '/opt/ltp/runltp -d /scratch -f syscalls', where the
> syscalls file has been replaced with three test case names, and
> /scratch is an ext4 SATA drive. /scratch is created using 'mkfs -t ext4
> /dev/disk/by-id/ata-TOSHIBA_MG03ACA100_37O9KGKWF' and mounted to
> /scratch.

I'm still having trouble reproducing the problem.  I've followed the
above exactly, and it doesn't trigger on my system.  I think I know
what is happening, but even given my theory, I'm still not able to
trigger it.  So, I'm not 100% sure this is the appropriate fix.  If
you can reproduce it, can you see if this patch, applied on top of the
Linus's tip, fixes the problem for you?

					- Ted

commit 3ad7621bfff343b16d59ed418f6d4420d4ec3e63
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Tue May 21 17:01:01 2019 -0400

    ext4: don't perform block validity checks on the journal inode
    
    Since the journal inode is already checked when we added it to the
    block validity's system zone, if we check it again, we'll just trigger
    a failure.
    
    This was causing failures like this:
    
    [   53.897001] EXT4-fs error (device sda): ext4_find_extent:909: inode
    #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
    [   53.931430] jbd2_journal_bmap: journal block not found at offset 49 on sda-8
    [   53.938480] Aborting journal on device sda-8.
    
    ... but only if the system was under enough memory pressure that
    logical->physical mapping for the journal inode gets pushed out of the
    extent cache.  (This is why it wasn't noticed earlier.)
    
    Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
    Reported-by: Dan Rue <dan.rue@linaro.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2c62e2a0c98..d40ed940001e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -518,10 +518,14 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	}
 	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
 		return bh;
-	err = __ext4_ext_check(function, line, inode,
-			       ext_block_hdr(bh), depth, pblk);
-	if (err)
-		goto errout;
+	if (!ext4_has_feature_journal(inode->i_sb) ||
+	    (inode->i_ino !=
+	     le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum))) {
+		err = __ext4_ext_check(function, line, inode,
+				       ext_block_hdr(bh), depth, pblk);
+		if (err)
+			goto errout;
+	}
 	set_buffer_verified(bh);
 	/*
 	 * If this is a leaf block, cache all of its entries
