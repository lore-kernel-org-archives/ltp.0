Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61935E7E64E
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 16:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84E443CDC8D
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 18:33:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAA793CB09D
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 18:33:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C3DD51A01004
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 18:33:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB121F8B5;
 Tue, 26 Sep 2023 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695746025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSHnZzYR24MW7lpOelCCaxoZTQ3dJUlSojwmar12Tk0=;
 b=bpwMtKWfgQkOTybPBgsURe+L77NwdX3T6CKb8NRd7/CyBpKJiZCIckox78Jx+7xBJCf1bk
 d9biPs4NYDQu6VUCeVADIxVLUdsyZetzzbBVnLA3AeLk7YLOSMP7H54e0pinufbsCr3YfK
 GFkTuk3ir9UqIbON41fztgXS+BcyoGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695746025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSHnZzYR24MW7lpOelCCaxoZTQ3dJUlSojwmar12Tk0=;
 b=ZLrP5pmNNnGNDaNQorLhmPM80OeSDPaQbgAqlZmwAkrJPraMPm+JcD0YAoLGfeKjqRU5kp
 fbqKWkuy/t4yy8Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F173E1390B;
 Tue, 26 Sep 2023 16:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XmjnOegHE2WeIwAAMHmgww
 (envelope-from <dsterba@suse.cz>); Tue, 26 Sep 2023 16:33:44 +0000
Date: Tue, 26 Sep 2023 18:27:07 +0200
From: David Sterba <dsterba@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <20230926162707.GT13697@twin.jikos.cz>
References: <459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com>
 <202309261438.d1bebb50-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202309261438.d1bebb50-oliver.sang@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/8] btrfs: use extent_io_tree_release() to empty
 dirty log pages
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
Reply-To: dsterba@suse.cz
Cc: oe-lkp@lists.linux.dev, ltp@lists.linux.it, fdmanana@kernel.org,
 lkp@intel.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 26, 2023 at 02:25:06PM +0800, kernel test robot wrote:
> Hello,
> 
> kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_fs/btrfs/extent-io-tree.c" on:
> 
> commit: 84b23544b95acd2e4c05fc473816d19b749fe17b ("[PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages")
> url: https://github.com/intel-lab-lkp/linux/commits/fdmanana-kernel-org/btrfs-make-extent-state-merges-more-efficient-during-insertions/20230922-184038
> base: https://git.kernel.org/cgit/linux/kernel/git/kdave/linux.git for-next
> patch link: https://lore.kernel.org/all/459c0d25abdfecdc7c57192fa656c6abda11af31.1695333278.git.fdmanana@suse.com/
> patch subject: [PATCH 7/8] btrfs: use extent_io_tree_release() to empty dirty log pages

Known and fixed in the git branch.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
