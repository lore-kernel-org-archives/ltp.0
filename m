Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D28C6FA86
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 10:40:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39EDC3CAD84
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 12:40:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1077B3CAD4F
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:40:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6630D602451
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 12:40:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 867F3219E0;
 Thu, 22 Sep 2022 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663843237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rm7c6xAh/KckVoY521xv4ofyjEc4Kj0Of/DEGFOhuvE=;
 b=OwE9EYIn3nzNmtQ59HsrBGvcxUkFMA0mtZWBojNHELt/ruY4L3b8fDafApaKcrK6v0SL6A
 3vpvdRdp9WLXNd01JCwQrluGiDTMhPANcWsqbJFEAnr3moNsfYl5um2r+XuY9GcxmDxBQu
 j3no4H9dHmfH7iHaqWImXBexBozoRxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663843237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rm7c6xAh/KckVoY521xv4ofyjEc4Kj0Of/DEGFOhuvE=;
 b=cxk/pR+QU9RtjavQb3N6t5r+HRVk0kXBlnRASrfF6hSorD3IZM2ERRz48SHizU2Cgz/66W
 GjEubnNYQt7+ePCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1865F1346B;
 Thu, 22 Sep 2022 10:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g7LCAqU7LGNFIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 10:40:37 +0000
Date: Thu, 22 Sep 2022 12:40:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yyw7osX47bnvNFr2@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <YywknXj4nL48PaR6@pevik>
 <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Sep 22, 2022 at 5:03 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > > > Although the tst_fs_type_name() functions could use some improvements,
> > > > e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get
> > properly

> > > Yes, that's true, we need to make it keep consistent with two
> > > skipping ways. Otherwise below test output "ext2/ext3/ext4"
> > > looks like a bit mess to remember.

> > > Better going with a single FS for matching (i.e. "ext4" for both fs_type
> > > and '-d path').
> > > But we can solve this in a separate patch later.

> > > $ df -T . | tail -1 | awk '{print $2}'
> > > ext4

> > > $ ./tst_supported_fs -s "ext4" ext4
> > > tst_supported_fs.c:135: TCONF: ext4 is skipped
> > > $ echo $?
> > > 32

> > > $ ./tst_supported_fs -s "ext4" -d .
> > > tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped
> > > $ echo $?
> > > 0

> > > $ ./tst_supported_fs -s "ext2/ext3/ext4" -d .
> > > tst_supported_fs.c:135: TCONF: ext2/ext3/ext4 is skipped
> > > $ echo $?
> > > 32

> > The same problem is for .skip_filesystems on tests which does not use
> > .all_filesystems. We only haven't noticed, because there was no reason to
> > skip
> > ext[234] so far. I'm looking into this.


> This seems a bit tricky to distinguish EXT2,3,4, from what I know,
> they use the same magic number. It will be difficult to get the
> FS block and extract smaller granularity of feature without
> using fs helper tools.

Yep, magic is the same: 0xef53 (not count the old ext2: 0xef51).
I thought that I'd map ext[235] to "ext2/ext3/ext4".
But maybe it's not a good idea.

OTOH df (coreutils) manages to distinguish them, stat can't.
I looked into df sources, it looks read_file_system_list() from gnulib which
it uses, reads /proc/self/mountinfo. Wouldn't be better to follow this approach
in tst_fs_type_() instead of using statfs()? (using st_dev - major:minor from
stat to match). I guess we always read mounted filesystem, thus it'd be a
drop-in replacement, we'd not need tst_fs_type_name() any more.

Kind regards,
Petr


> > BTW .skip_filesystems without .all_filesystems have other problems, e.g.
> > using
> > filesystems which aren't in fs_type_whitelist[] array (e.g. ramfs, nfs).
> > That'd be nice to fix after the release.


> +1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
