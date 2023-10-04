Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3285DE7C4C6
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:52:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE1D3CDB5A
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 16:52:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9293B3C9959
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:52:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED959140132C
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 16:52:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2A2CC1F45A;
 Wed,  4 Oct 2023 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696431150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q3148ZnxxpT4v2dnY42midxl1lwJ1NjKbIFfJVdmTgs=;
 b=lmbFjyLkn5YxNLF//QlTXpvI/KWljGWtVL8FpzK1tcOWQTgxn3OCqpdAuuHH6Gj4uGm9Fd
 UzVSGCrlJVm4dYAq8Qin3M06gPrdDoMHBMovc4GFoDrdqrm5WZO5BErkPDJMskwEvi7rta
 flYj8k2bZEszKzJm6KuMj2lDxn5YdUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696431150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q3148ZnxxpT4v2dnY42midxl1lwJ1NjKbIFfJVdmTgs=;
 b=qvjD6jXIvWXFUw4gfN8CxaG5CinWL7zThfXbochIRyXW0sMuxZ/1tBJB5mLMr//rjNZyLb
 60/Z/BMpduVIQLBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1951313A2E;
 Wed,  4 Oct 2023 14:52:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kQEfBi58HWXwCQAAMHmgww
 (envelope-from <jack@suse.cz>); Wed, 04 Oct 2023 14:52:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 9B2C8A07CC; Wed,  4 Oct 2023 16:52:29 +0200 (CEST)
Date: Wed, 4 Oct 2023 16:52:29 +0200
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231004145229.mulvwfxkfg63u7jx@quack3>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <20231004124712.3833-3-chrubis@suse.cz>
 <CAOQ4uxg8Z1sQJ35fdXnct3BJoCaahHoQ9ek3rmPs3Ly8cVCz=A@mail.gmail.com>
 <ZR11nlq3Le1GAwcd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZR11nlq3Le1GAwcd@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/readahead01: Make use of
 tst_fd_iterate()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 04-10-23 16:24:30, Cyril Hrubis wrote:
> Hi!
> > > TODO: readahead() on /proc/self/maps seems to succeed is that to be
> > >       expected?
> > 
> > Not sure.
> > How does llseek() work on the same fd?
> 
> Looks like we we can seek in that file as well, accordingly to man pages
> we cannot seek in pipe, socket, and fifo, which seems to match the
> reality.  We can apparently seek in O_DIRECTORY fd as well, not sure if
> that is even useful.

Seeking on O_DIRECTORY fd is actually well defined by POSIX. You can store
current file position you've got back from lseek and you are guaranteed to
get back at the same position in the directory if you lseek to it (even if
there was a change to the directory, although effects on changed directory
entries is undefined). This is actually pretty tough to implement in
contemporary filesystems with non-trivial directory structure but that is
how POSIX defined it...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
