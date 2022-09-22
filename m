Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F7BC6FA91
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 10:54:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A5923CAD6A
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 12:54:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2739D3CAD04
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:54:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 587651A01448
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:54:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A028921A19;
 Thu, 22 Sep 2022 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663844062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+S+9Lra6rNZ7rYohCd39B5PzdfFRMtmzu+NDaNSnMg=;
 b=eCzogBZ9nNPJNoecgIARbmCctATVEZavZyt7Pum2lpmDZDsfTTfZUqRX/ps1Rc7UavZWRm
 kVjQ1j3t++6Y07131CiC/vYbDiv/B21E+FhAwoWHTxY9NFTVk15FFuMusmS05bnUzBb3/Q
 2/J7pB6B4NjB1+PviS2D21N11/vNrwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663844062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i+S+9Lra6rNZ7rYohCd39B5PzdfFRMtmzu+NDaNSnMg=;
 b=FjVgDNfdBcUxQgtax97c75CqC819pR62DgPCPD8710SbIu4JF/HGzdXyyKeP2jPx2n7LiN
 0tkPbZjdOJT/KsDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 894EF1346B;
 Thu, 22 Sep 2022 10:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 22NDIN4+LGMjKgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 22 Sep 2022 10:54:22 +0000
Date: Thu, 22 Sep 2022 12:55:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yyw/CYzZ2XjbQdxu@rei>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <YywknXj4nL48PaR6@pevik>
 <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
 <Yyw7osX47bnvNFr2@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yyw7osX47bnvNFr2@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > This seems a bit tricky to distinguish EXT2,3,4, from what I know,
> > they use the same magic number. It will be difficult to get the
> > FS block and extract smaller granularity of feature without
> > using fs helper tools.
> 
> Yep, magic is the same: 0xef53 (not count the old ext2: 0xef51).
> I thought that I'd map ext[235] to "ext2/ext3/ext4".
> But maybe it's not a good idea.
> 
> OTOH df (coreutils) manages to distinguish them, stat can't.
> I looked into df sources, it looks read_file_system_list() from gnulib which
> it uses, reads /proc/self/mountinfo. Wouldn't be better to follow this approach
> in tst_fs_type_() instead of using statfs()? (using st_dev - major:minor from
> stat to match). I guess we always read mounted filesystem, thus it'd be a
> drop-in replacement, we'd not need tst_fs_type_name() any more.

The real problem is that the line between ext2, ext3 and ext4 is really
blurry to an extend where it's hard to say which filesystem are you
working with. For example while ext2 kernel driver still exists and is
in use on embedded hardware modern distributions use single ext driver
to handle all three filesystems. Also I think that it was possible to
mount ext3 with ext2 driver at some point which disabled the journaling.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
