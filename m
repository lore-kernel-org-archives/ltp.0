Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BA7C001B0
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 15:13:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22C8A3CEF05
	for <ltp@archiver.kernel.org>; Thu, 13 Jul 2023 17:13:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5DC63C99ED
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 17:11:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C28E31A00A56
 for <ltp@lists.linux.it>; Thu, 13 Jul 2023 17:11:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2276322158;
 Thu, 13 Jul 2023 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689261071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCLBmF2e2dRCNx7+d13fHc8+rkei0zsayK8x+eKdnGc=;
 b=qomcWisImhIgTGE3b4ZUEPF9NcyOW0hyDzZnyCPVzVgRuINKpG8MQbpCS13E9V1HBOrMO/
 iAyUdkn6A+IJpPb5QvbPi4sRRNNjhjdXjokIMH8S4MUYkByXeu7CRlgjWvkVWDawXd8vHp
 8AT5b9KhPS/AKO4mxgcaNhfFavUADcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689261071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wCLBmF2e2dRCNx7+d13fHc8+rkei0zsayK8x+eKdnGc=;
 b=2D2YEL/BjKdkgcqnhmm74ZlNQAyBcVXYYRhOK4PSceT9B8FBt6yWbDy3bm5gYdZm5fpfJG
 MnQHKcIOISrEZ3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AC70133D6;
 Thu, 13 Jul 2023 15:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FtJUAg8UsGQOBwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jul 2023 15:11:11 +0000
Date: Thu, 13 Jul 2023 17:12:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <ZLAUT_19ST-47Wed@yuki>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202307132107.2ce4ea2f-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 13 Jul 2023 17:13:23 +0200
Subject: Re: [LTP] [linus:master] [iomap]  219580eea1: ltp.writev07.fail
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Chao Yu <chao@kernel.org>, oe-lkp@lists.linux.dev,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
The test description:

 Verify writev() behaviour with partially valid iovec list.
 Kernel <4.8 used to shorten write up to first bad invalid
 iovec. Starting with 4.8, a writev with short data (under
 page size) is likely to get shorten to 0 bytes and return
 EFAULT.

 This test doesn't make assumptions how much will write get
 shortened. It only tests that file content/offset after
 syscall corresponds to return value of writev().

 See: [RFC] writev() semantics with invalid iovec in the middle
      https://marc.info/?l=linux-kernel&m=147388891614289&w=2

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
