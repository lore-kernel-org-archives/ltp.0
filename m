Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10813C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 11:14:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9F53D199D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 13:14:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63AD23D1962
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 13:14:13 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BC6D21000A09
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 13:14:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6534A1FB7E;
 Fri, 12 Jul 2024 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720782850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
 b=PdQHb8Qg6f3KKtYiYyev+EG4jQNpczpUCCYwefz/ZDjiHjQ3KhIKT4JoU5J79YB9Q5J8WT
 rpS/SCGkJYFGOflpGC7v2Y8cnWF7hlV8W43C8fAidyGYCxvKmK7tuNmx/Rq7W9TXTCfw3A
 IgXLwuqLWRhbEZS2wNTUrsQOJDzzguI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720782850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
 b=LIfZX9T7Y3N7mHtQEaTAeG3kyvBybKBad7irujFfEVzIBP73ArkrLL/RaG8eSeQOYLlwSo
 mumV+eDL5IacwODA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720782850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
 b=PdQHb8Qg6f3KKtYiYyev+EG4jQNpczpUCCYwefz/ZDjiHjQ3KhIKT4JoU5J79YB9Q5J8WT
 rpS/SCGkJYFGOflpGC7v2Y8cnWF7hlV8W43C8fAidyGYCxvKmK7tuNmx/Rq7W9TXTCfw3A
 IgXLwuqLWRhbEZS2wNTUrsQOJDzzguI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720782850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD724Ak1dF6hBUC0nbhOetqocyngLZMCsuzDsOwo8Ew=;
 b=LIfZX9T7Y3N7mHtQEaTAeG3kyvBybKBad7irujFfEVzIBP73ArkrLL/RaG8eSeQOYLlwSo
 mumV+eDL5IacwODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5A9F13686;
 Fri, 12 Jul 2024 11:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mOQBGvwPkWYVOgAAD6G6ig
 (envelope-from <neilb@suse.de>); Fri, 12 Jul 2024 11:14:04 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
In-reply-to: <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
References: <>, <f74754b59ffc564ef882566beda87b3f354da48c.camel@kernel.org>
Date: Fri, 12 Jul 2024 21:13:59 +1000
Message-id: <172078283934.15471.13377048166707693692@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWELVE(0.00)[14];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Greg KH <greg@kroah.com>, Sherry Yang <sherry.yang@oracle.com>,
 linux-stable <stable@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Chuck Lever III <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>,
 Calum Mackay <calum.mackay@oracle.com>,
 "kernel-team@fb.com" <kernel-team@fb.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 12 Jul 2024, Jeff Layton wrote:
> On Fri, 2024-07-12 at 16:12 +1000, NeilBrown wrote:
> > 
> > My point is that if we are going to change the kernel to accommodate LTP
> > at all, we should accommodate LTP as it is today.  If we are going to
> > change LTP to accommodate the kernel, then it should accommodate the
> > kernel as it is today.
> > 
> 
> The problem is that there is no way for userland tell the difference
> between the older and newer behavior. That was what I was suggesting we
> add.

To make sure I wasn't talking through my hat, I had a look at the ltp
code.

The test in question simply tests that the count of RPC calls increases.

It can get the count of RPC calls in one of 2 ways :
 1/ "lhost" - look directly in /proc/net/rpc/{nfs,nfsd}
 2/ "rhost" - ssh to the server and look in that file.

The current test to "fix" this for kernels -ge "6.9" is to force the use
of "rhost".

I'm guessing that always using "rhost" for the nfsd stats would always
work.
But if not, the code could get both the local and remote nfsd stats, and
check that at least one of them increases (and neither decrease).

So ltp doesn't need to know which kernel is being used - it can be
written to work safely on either.

NeilBrown


> 
> To be clear, I hold this opinion loosely. If the consensus is that we
> need to revert things then so be it. I just don't see the value of
> doing that in this particular situation.
> -- 
> Jeff Layton <jlayton@kernel.org>
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
