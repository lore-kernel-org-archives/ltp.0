Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F9CC27C77
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 13:53:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591F93D0BD8
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 15:53:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 609603D0905
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 15:53:16 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1038260025A
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 15:53:15 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 86CCA6148E;
 Wed, 12 Jun 2024 13:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E7AC4AF4D;
 Wed, 12 Jun 2024 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718200393;
 bh=9ZhMiQb8F+YQkrSmW/uvqq+sOj8IhPHHedOkJlMaFF4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fvKnVWA67l2XCec23FfIZmoq1TS+spuTVbQympdCm7UMttUJCZLZZLe64EqSf6FXI
 8SCU86o5e5aoAixswN3wUaJ9u6l7ri5xkVbcLVW9bKm/5jiyPilSe5xkPiYXKmwTis
 NtSzPwrdd/y9XD64ii4OrGOevxIt0b3ekkUY846QVMYQnINaBz9qk+4D3+o9V5Ql2q
 IFHVXcjOrFJi/a6jiLCUYoxUEV5tPmGfvBAInTaRGLW8plyEHBDjz2GPCXSQ06H6TE
 t7Lgu1AcIMYvUQUtQseFJiMcExfYzQi8SHvi6GCrBOQaWL5mV533wS4UAq6Eh618B6
 4jbj+ACrX4XAg==
Date: Wed, 12 Jun 2024 15:53:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Message-ID: <20240612-nennung-ungnade-ae9bdc5f8c4c@brauner>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <171817619547.14261.975798725161704336@noble.neil.brown.name>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: linux-nfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 12, 2024 at 05:09:55PM +1000, NeilBrown wrote:
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
> ---

We should take this is a bugfix because it doesn't change behavior.

But then we should follow this up with a patch series that tries to
rectify the open/close imbalance because I find that pretty ugly. That's
at least my opinion.

We should aim to only generate an open event when may_open() succeeds
and don't generate a close event when the open has failed. Maybe:

+#ifdef CONFIG_FSNOTIFY
+#define file_nonotify(f) ((f)->f_mode |= __FMODE_NONOTIFY)
+#else
+#define file_nonotify(f) ((void)(f))
+#endif

will do.

Basic open permissions failing should count as failure to open and thus
also turn of a close event.

The somewhat ugly part is imho that security hooks introduce another
layer of complexity. While we do count security_file_permission() as
a failure to open we wouldn't e.g., count security_file_post_open() as a
failure to open (Though granted here that "*_post_open()" makes it
easier.). But it is really ugly that LSMs get to say "no" _after_ the
file has been opened. I suspect this is some IMA or EVM thing where they
hash the contents or something but it's royally ugly and I complained
about this before. But maybe such things should just generate an LSM
layer event via fsnotify in the future (FSNOTIFY_MAC) or something...
Then userspace can see "Hey, the VFS said yes but then the MAC stuff
said no."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
