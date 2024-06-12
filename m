Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D74C27C75
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 10:28:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D9EC3D0BFA
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:28:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307033D0B64
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:28:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=james.clark@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-4.smtp.seeweb.it (Postfix) with ESMTP id 3AFFF1000A16
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 12:28:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8498A1595;
 Wed, 12 Jun 2024 03:28:28 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 D3A4F3F73B; Wed, 12 Jun 2024 03:28:02 -0700 (PDT)
Message-ID: <2c5c43b0-c3ad-4536-b839-cfd1f5b8911b@arm.com>
Date: Wed, 12 Jun 2024 11:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: NeilBrown <neilb@suse.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <171817619547.14261.975798725161704336@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 12/06/2024 08:09, NeilBrown wrote:
> 
> When a file is opened and created with open(..., O_CREAT) we get
> both the CREATE and OPEN fsnotify events and would expect them in that
> order.   For most filesystems we get them in that order because
> open_last_lookups() calls fsnofify_create() and then do_open() (from
> path_openat()) calls vfs_open()->do_dentry_open() which calls
> fsnotify_open().
> 
> However when ->atomic_open is used, the
>    do_dentry_open() -> fsnotify_open()
> call happens from finish_open() which is called from the ->atomic_open
> handler in lookup_open() which is called *before* open_last_lookups()
> calls fsnotify_create.  So we get the "open" notification before
> "create" - which is backwards.  ltp testcase inotify02 tests this and
> reports the inconsistency.
> 
> This patch lifts the fsnotify_open() call out of do_dentry_open() and
> places it higher up the call stack.  There are three callers of
> do_dentry_open().
> 
> For vfs_open() and kernel_file_open() the fsnotify_open() is placed
> directly in that caller so there should be no behavioural change.
> 
> For finish_open() there are two cases:
>  - finish_open is used in ->atomic_open handlers.  For these we add a
>    call to fsnotify_open() at the top of do_open() if FMODE_OPENED is
>    set - which means do_dentry_open() has been called.
>  - finish_open is used in ->tmpfile() handlers.  For these a similar
>    call to fsnotify_open() is added to vfs_tmpfile()
> 
> With this patch NFSv3 is restored to its previous behaviour (before
> ->atomic_open support was added) of generating CREATE notifications
> before OPEN, and NFSv4 now has that same correct ordering that is has
> not had before.  I haven't tested other filesystems.
> 
> Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
> Reported-by: James Clark <james.clark@arm.com>
> Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.com
> Signed-off-by: NeilBrown <neilb@suse.de>

That's passing for me now on NFSv3:

Tested-by: James Clark <james.clark@arm.com>

> ---
>  fs/namei.c |  5 +++++
>  fs/open.c  | 19 ++++++++++++-------
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 37fb0a8aa09a..057afacc4b60 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3612,6 +3612,9 @@ static int do_open(struct nameidata *nd,
>  	int acc_mode;
>  	int error;
>  
> +	if (file->f_mode & FMODE_OPENED)
> +		fsnotify_open(file);
> +
>  	if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
>  		error = complete_walk(nd);
>  		if (error)
> @@ -3700,6 +3703,8 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
>  	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
>  	error = dir->i_op->tmpfile(idmap, dir, file, mode);
>  	dput(child);
> +	if (file->f_mode & FMODE_OPENED)
> +		fsnotify_open(file);
>  	if (error)
>  		return error;
>  	/* Don't check for other permissions, the inode was just created */
> diff --git a/fs/open.c b/fs/open.c
> index 89cafb572061..970f299c0e77 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
>  		}
>  	}
>  
> -	/*
> -	 * Once we return a file with FMODE_OPENED, __fput() will call
> -	 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
> -	 */
> -	fsnotify_open(f);
>  	return 0;
>  
>  cleanup_all:
> @@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
>   */
>  int vfs_open(const struct path *path, struct file *file)
>  {
> +	int ret;
> +
>  	file->f_path = *path;
> -	return do_dentry_open(file, NULL);
> +	ret = do_dentry_open(file, NULL);
> +	if (!ret)
> +		/*
> +		 * Once we return a file with FMODE_OPENED, __fput() will call
> +		 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
> +		 */
> +		fsnotify_open(file);
> +	return ret;
>  }
>  
>  struct file *dentry_open(const struct path *path, int flags,
> @@ -1178,7 +1182,8 @@ struct file *kernel_file_open(const struct path *path, int flags,
>  	if (error) {
>  		fput(f);
>  		f = ERR_PTR(error);
> -	}
> +	} else
> +		fsnotify_open(f);
>  	return f;
>  }
>  EXPORT_SYMBOL_GPL(kernel_file_open);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
