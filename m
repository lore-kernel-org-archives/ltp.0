Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F10EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:17:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52EBB3C036A
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 15:17:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0A6B3C036A
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:52:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0958E6010E3
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:52:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 01A3B2215C;
 Fri, 14 Jul 2023 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689335573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KDV1nJ5Jz4wRDhIKmz6NBTzJCSWRm0jEnj5bKK8jms=;
 b=RaI2ovdDvUPrEZfWKhoWhNZo8wczuah4soS9qZNmjNs4m77GOOhIkliWi0AW6JeIY2bpTl
 sS1XdU5o65Y83yhWiMvQHDPuT8pXn8OAcj/xhWpT2sCettpHZpXHdcAwUxw32zO95FET5+
 a7afrjnmliXMK10v/s4xRw7EosrSLdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689335573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8KDV1nJ5Jz4wRDhIKmz6NBTzJCSWRm0jEnj5bKK8jms=;
 b=Xwjlf4wtU20I149ib7jAHqHYtFJHRAEQ7KLGUG/IqQ27Glob67oL5W1MoWY3aYVfy9nRQk
 tVWwL8O32q1ldDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF04138F8;
 Fri, 14 Jul 2023 11:52:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vwKmNRQ3sWT7PwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 14 Jul 2023 11:52:52 +0000
Date: Fri, 14 Jul 2023 13:53:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <ZLE3Vh5yHq_floF7@yuki>
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
 <20230713150923.GA28246@lst.de> <ZLAZn_SBmoIFG5F5@yuki>
 <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Jul 2023 15:16:55 +0200
Subject: Re: [LTP] [linus:master] [iomap] 219580eea1: ltp.writev07.fail
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
 Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Anna Schumaker <anna@kernel.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > I can't reproduce this on current mainline.  Is this a robust failure
> > > or flapping test?  Especiall as the FAIL conditions look rather
> > > unrelated.
> 
> It's consistently reproducible for me on xfs with HEAD at:
> eb26cbb1a754 ("Merge tag 'platform-drivers-x86-v6.5-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")

Should be fixed by https://lore.kernel.org/linux-fsdevel/20230714085124.548920-1-hch@lst.de/T/#t

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
