Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88788C433F5
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 13:29:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F5DA3C8D6B
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 14:29:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5D3B3C25EC
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 14:29:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5389D1A00A44
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 14:29:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38F481FD39;
 Mon, 22 Nov 2021 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637587765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBcRk0uKyn4Zh1Cyv0zVCwydH4eapYMxaeUBcsUWtJ0=;
 b=axO/D1cMqGYJcw/tgQY3JPmz1NzQpC377+uPEFNP9UMouzk4cb0mgPGHItFIMZaajHJsyM
 7DFX0H5Iqmlx7o5ymAjJhUxiZoAUBrv6e8I/aWmEsMzzuAZXhu3x2Hnh9KQJM+ZEgwPOUA
 5EMuprN2H4nuF1AKYnkGN1O8BLRgZUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637587765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tBcRk0uKyn4Zh1Cyv0zVCwydH4eapYMxaeUBcsUWtJ0=;
 b=dSr5RphgAFAI0z547/FsSq4oGB0X5hiAPh7O2GwgyyuiTG7QH5eKhW3qLymtwHfy7fS9WN
 ZW6PvS818AuuUVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23AFD13CB0;
 Mon, 22 Nov 2021 13:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MhEtBzWbm2EnVgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 13:29:25 +0000
Date: Mon, 22 Nov 2021 14:30:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YZubdhIyP19rhEVD@yuki>
References: <20211118112900.15757-1-rpalethorpe@suse.com>
 <619708EC.6090305@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <619708EC.6090305@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx04: Re-add BTRFS version check
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Do you mean that your distribution based on older kernel ie 4.11
> supports statx syscall but btrfs missed the btrfs patch? Also this
> distribution doesn't update and so have no choice to backport.
> > This is different from the
> > other version checks which are for much newer kernels. 
> IMO, distribution based on older kernel 4.11 still can make ext2 ext4
> xfs supports statx because the backport looks not diffcult. So, I don't
> think this is a difference. It depends on kernel users worked on this
> distirbution whether have this requirement.
> Also there could be differences in the difficulty of a backport.
> I see xfs/btrfs code, it only fills the attributes field of stat
> struture by parsing inode flags.
> 
> If you must add this check on suse distribution, I guess you just add
> this version check for suse distribution. For centos7,8, neither of them
> supports btrfs, but I don't know other distribution situation ie unbuntu.

I just checked debian, both oldstable (4.16) and stable (5.10) have new
enough kernels for this not to matter.

> Maybe you can just add suse detection in lib/tst_kvercmp.c.

I guess that this would be the cleanest solution.

Actually SUSE should be detected just fine, since we parse
/etc/os-release for ID='foo' in the test library.

So this could be solved just by defining:

static struct tst_kern_exv kvers[] = {
	{"sles", "4.13.0"}
	{}
};

and then doing:

	if (tst_kvercmp2(0, 0, 0, kvers) < 0)
		tst_brk(TCONF, "Btrfs statx() supported since 4.13");


Also it would be a bit cleaner to add this to the tst_test structure as
.min_kver_ex as well, but that's a different story...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
