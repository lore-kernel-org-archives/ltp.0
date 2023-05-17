Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3185BC77B75
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 15:07:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D2AE3CDCE6
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 17:07:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F95A3CB2B9
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:07:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F8DB10009F7
 for <ltp@lists.linux.it>; Wed, 17 May 2023 17:07:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 240161FE51;
 Wed, 17 May 2023 15:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684336045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TGlrb0cFe9EhUMCnm8yQmxfvmOmNVAPE1Yz8wmHm1k=;
 b=K6kg3dmPTVdMXVyCROLUuQLZZL1SzoxxRRCLykSHlvGnT6QCY5jUp4rEz9AHW71VhzdSHi
 zCymQZEPOwGZTMRVfsnUMZKoiQfllOZg655YysNbRn0kbPJ31XLX+V6YKyqs+popGxzueK
 UgeDP00tNj/70722eF8EOj8HGTjryVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684336045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TGlrb0cFe9EhUMCnm8yQmxfvmOmNVAPE1Yz8wmHm1k=;
 b=3b1u6gcBlimIyvAoc7l+5AOXxdjgj83seDpY+M0yI3i+/pH9ogr5G27OGGL8UOGiQDBDob
 +BOT4PjhrkDQE/Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3338313358;
 Wed, 17 May 2023 15:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0kqEOqvtZGRUegAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 17 May 2023 15:07:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 17 May 2023 20:37:21 +0530
Message-ID: <5961201.lOV4Wx5bFT@localhost>
Organization: SUSE
In-Reply-To: <20230516115841.GA7742@pevik>
References: <20230315155650.12469-1-akumar@suse.de>
 <20230516115841.GA7742@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mknod02.c: Simplify and convert to new LTP API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Tuesday, May 16, 2023 5:28:41 PM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > Simply test when parent directory does not have set-group-ID bit set,
> > new node gets GID from effective GID of the process and does not inherit
> > the group ownership from its parent directory.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Few comments below.
> 
> >  testcases/kernel/syscalls/mknod/mknod02.c | 316 +++-------------------
> >  1 file changed, 36 insertions(+), 280 deletions(-)
> 
> ...
> 
> > +/*\
> > + * [Description]
> > 
> >   *
> > 
> > + * Verify that if mknod(2) creates a filesystem node in a directory which
> > + * does not have the set-group-ID bit set, new node will not inherit the
> > + * group ownership from its parent directory and its group ID will be the
> > + * effective group ID of the process.
> 
> @Cyril I wonder if it'd be good to test this on all_filesystems. Are we
> trying to use use all_filesystems = 1 when subject of testing is using VFS
> or the opposite? (kernel docs mentions "VFS system calls open(2), stat(2),
> read(2), write(2), chmod(2)". It also mentions locking [2]).
> 
> BTW looking what has mknod in vfs, it's just nfsd and 9p (none of them are
> used in all_filesystems):
> 
> $ git grep  mknod $(git ls-files fs/|grep -i vfs)
> fs/9p/vfs_inode.c: * for mknod(2).
> fs/9p/vfs_inode.c: * v9fs_vfs_mknod - create a special file
> fs/9p/vfs_inode.c:v9fs_vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
> fs/9p/vfs_inode.c:      .mknod = v9fs_vfs_mknod,
> fs/9p/vfs_inode.c:      .mknod = v9fs_vfs_mknod,
> fs/9p/vfs_inode_dotl.c:v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct
> inode *dir, fs/9p/vfs_inode_dotl.c: return v9fs_vfs_mknod_dotl(idmap, dir,
> dentry, omode, 0); fs/9p/vfs_inode_dotl.c: * v9fs_vfs_mknod_dotl - create a
> special file fs/9p/vfs_inode_dotl.c:v9fs_vfs_mknod_dotl(struct mnt_idmap
> *idmap, struct inode *dir, fs/9p/vfs_inode_dotl.c:        
> p9_debug(P9_DEBUG_VFS, "Failed to get acl values in mknod %d\n",
> fs/9p/vfs_inode_dotl.c: err = p9_client_mknod_dotl(dfid, name, mode, rdev,
> gid, &qid); fs/9p/vfs_inode_dotl.c: .mknod = v9fs_vfs_mknod_dotl,
> fs/nfsd/vfs.c:          host_err = vfs_mknod(&nop_mnt_idmap, dirp, dchild,
> 
> >   */
> 
> ...
> 
> > +static void run(void)
> > 
> >  {
> 
> ...
> 
> > +	SAFE_CHDIR(TEMP_DIR);
> > +	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0), "mknod(%s, %o, 0)", 
TEMP_NODE,
> > MODE1);
> IMHO this simple form will print the same info, I suggest to use it.
> 	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0));
> 
> > -	/*
> > -	 * Create a test directory under temporary directory with the
> > -	 * specified mode permissions, with uid/gid set to that of guest
> > -	 * user and the test process.
> > -	 */
> > -	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
> > -	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
> > +	SAFE_STAT(TEMP_NODE, &buf);
> > +	TST_EXP_EQ_LI(buf.st_gid, 0);
> 
> ...
> 
> Diff for using all_filesystems (I'm not sure myself).
> 
> Kind regards,
> Petr

Thanks for reviewing, I agree with your proposed changes if we are going to 
enable if for all filesystems, test executes fine with all_filesystems=1 in my 
setup.

> 
> [1] https://www.kernel.org/doc/html/next/filesystems/vfs.html
> [2] https://www.kernel.org/doc/html/next/filesystems/locking.html
> 
> +++ testcases/kernel/syscalls/mknod/mknod02.c
> @@ -24,6 +24,8 @@
>  #define TEMP_DIR "testdir"
>  #define TEMP_NODE "testnode"
> 
> +#define MNTPOINT	"mntpoint"
> +
>  static struct stat buf;
>  static struct passwd *user_nobody;
>  static gid_t gid_nobody;
> @@ -40,18 +42,28 @@ static void setup(void)
>  static void run(void)
>  {
>  	SAFE_CHDIR(TEMP_DIR);
> -	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0), "mknod(%s, %o, 0)", 
TEMP_NODE,
> MODE1); +	TST_EXP_PASS(mknod(TEMP_NODE, MODE1, 0));
> 
>  	SAFE_STAT(TEMP_NODE, &buf);
>  	TST_EXP_EQ_LI(buf.st_gid, 0);
> 
>  	SAFE_UNLINK(TEMP_NODE);
>  	SAFE_CHDIR("..");
> +
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_RMDIR(TEMP_DIR);
>  }
> 
>  static struct tst_test test = {
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.test_all = run,
>  	.needs_root = 1,
> -	.needs_tmpdir = 1
> +	.needs_tmpdir = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
>  };

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
