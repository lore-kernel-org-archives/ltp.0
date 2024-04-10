Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A092CD11C2
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 13:34:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC4A63CF7D3
	for <ltp@archiver.kernel.org>; Wed, 10 Apr 2024 15:34:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 103DC3CEE6F
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 15:33:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C500F1A00FA4
 for <ltp@lists.linux.it>; Wed, 10 Apr 2024 15:33:47 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFCF95CE33;
 Wed, 10 Apr 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B72941390D;
 Wed, 10 Apr 2024 13:33:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id EfPpKjqVFmbmGAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Apr 2024 13:33:46 +0000
Date: Wed, 10 Apr 2024 15:33:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240410133337.GA205337@pevik>
References: <20240401150015.301640-1-samasth.norway.ananda@oracle.com>
 <Zg_oLGuLcssY-rYY@yuki>
 <e2368059-647c-4d98-8c90-2cc5f3bb34a4@oracle.com>
 <20240409101753.GA107959@pevik> <ZhZcL9cH5bVDWL_k@yuki>
 <20240410094621.GA184706@pevik> <ZhZlEz8MjZ2KOiR4@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZhZlEz8MjZ2KOiR4@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DFCF95CE33
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mremap06: fallocate is not supported on nfsv3
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: calum.mackay@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > The solution would be to at least check for tst_fs_type(".") == TST_NFS_MAGIC.

> I would go for this at the moment, that is the easiest fix at the
> moment.

So you mean we risk we lost fallocate support in NFSv4.2 for the simplicity. OK
for me.

> > Perfect solution would IMHO be to check for NFS version (e.g. in /proc/mounts)
> > and TCONF only on NFSv3.

> And is nfsv4 enough, wasn't it added in nfsv4.2? Do we need to parse
> /proc/net/rpc/nfs to figure out if nfs fallocate() is supported?

Yes. First, I got confused 95d871f03cae ("nfsd: Add ALLOCATE support") [1] which is
not mentioning NFS version, because it's for nfsd. But looking other commits,
e.g. 95d871f03cae ("nfsd: Add ALLOCATE support") [2], 624bd5b7b683 ("nfs: Add
DEALLOCATE support") [3] and the docs from merge commit in 3.19 [4] and
kernelnewbies [5], it's clear: it's for NFSv4.2.

BTW is that whole fallocate() support? [4] mentions "NFSv4.2 client support for
hole punching and preallocation.", commit [3]: "This patch adds support for
using the NFS v4.2 operation DEALLOCATE to punch holes in a file.", commit
b0cb9085239a ("nfsd: Add DEALLOCATE support") [6] uses FALLOC_FL_PUNCH_HOLE
flag. All that IMHO means it's adding just FALLOC_FL_PUNCH_HOLE support into
NFSv4.2. Thus other (basic) fallocate() might work in all NFS versions, right?

That would suggest when addin safe_fallocate() we should check for NFS
(tst_fs_type(".") == TST_NFS_MAGIC) only when FALLOC_FL_PUNCH_HOLE is used.
(I got from your answer we ignore missing support for older filesystems,
we can always add the check once somebody reports invalid error).

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95d871f03cae6b49de040265cf88cbe2a16b9f05
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4ac1674f5da420ef17896f0f222c5215ebcde80
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=624bd5b7b683c978c6d5f4e9f6142cfb3470983d
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e20db597b6264de55ea6636fc79b1e4aaa89d129
[5] https://kernelnewbies.org/Linux_3.19#NFSv4.2_support_for_hole_punching_and_preallocation
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0cb9085239a20b7482ddd4839dd1d5476801dfa

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
