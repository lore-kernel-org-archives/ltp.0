Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B4CC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:41:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BD6C3CE227
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:41:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E17413C88E1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:41:33 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 35E362001DB
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:41:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C136E21F62;
 Mon, 22 Jan 2024 09:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705916491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/ux6w1wXz5JCqNrrRQ1RI9npnWmIkmUPW+bso6HiSM=;
 b=mCE8hikXUHfNR98ZH7sWVYRJiOalqgsR15qXlNzYmshVUyPsdPawyzB2Ma6T2BZBUeqyMe
 Lil91cq3S8ovczkFeHy0U+4wkhwszb/V+OuBxaWFku7sEbcIMgHKxmWnZBMzoMZRNlCI5v
 JauCZVfoC64E2qB5RA+DB0141Q2yuzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705916491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/ux6w1wXz5JCqNrrRQ1RI9npnWmIkmUPW+bso6HiSM=;
 b=jNq//eEgmUdi2hMozFNAOPRWS2EUOOFbBPP04mNDh8M6xI1nUam7bUhPyvzaxa0/uApnhC
 CfWSuTrQZDs+a1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705916491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/ux6w1wXz5JCqNrrRQ1RI9npnWmIkmUPW+bso6HiSM=;
 b=mCE8hikXUHfNR98ZH7sWVYRJiOalqgsR15qXlNzYmshVUyPsdPawyzB2Ma6T2BZBUeqyMe
 Lil91cq3S8ovczkFeHy0U+4wkhwszb/V+OuBxaWFku7sEbcIMgHKxmWnZBMzoMZRNlCI5v
 JauCZVfoC64E2qB5RA+DB0141Q2yuzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705916491;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/ux6w1wXz5JCqNrrRQ1RI9npnWmIkmUPW+bso6HiSM=;
 b=jNq//eEgmUdi2hMozFNAOPRWS2EUOOFbBPP04mNDh8M6xI1nUam7bUhPyvzaxa0/uApnhC
 CfWSuTrQZDs+a1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A370C139A8;
 Mon, 22 Jan 2024 09:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GWLjJks4rmXYdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 09:41:31 +0000
Date: Mon, 22 Jan 2024 10:41:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
Message-ID: <20240122094126.GG76754@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122090349.GD76754@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240122090349.GD76754@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mCE8hikX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="jNq//eEg"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.cz:dkim]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: C136E21F62
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril,

> Hi Li, Cyril,
...
> >  void is_swap_supported(const char *filename)
> >  {
> > +	int i, sw_support = 0;
> >  	int fibmap = tst_fibmap(filename);
> Just a note unrelated to this patchset. When testing on SLES kernel based on
> 5.3.18 we still get TCONF due missing FIBMAP ioctl support:

> tst_test.c:1669: TINFO: === Testing on btrfs ===
> tst_test.c:1118: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> tst_test.c:1132: TINFO: Mounting /dev/loop0 to /tmp/LTP_swazaqF1L/mntpoint fstyp=btrfs flags=0
> tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
> libswap.c:45: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01

> libswap.c:114: TCONF: Swapfile on btrfs not implemented

Hm, what makes me wonder is that btrfs does not support FIBMAP even on current
openSUSE Tumbleweed with 6.7.0 kernel:

# TMPDIR=/var/tmp/ LTP_SINGLE_FS_TYPE=btrfs ./swapon01
...
tst_test.c:1669: TINFO: === Testing on btrfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_swaMBctpq/mntpoint fstyp=btrfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:45: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01

libswap.c:114: TCONF: Swapfile on btrfs not implemented

$ df -hT /var/tmp
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/vda2      btrfs   28G   19G  3.3G  86% /var

$ uname -r 
6.7.0-9.gaedda80-default

I thought the problem is that underlying fs is btrfs, but testing on Debian
on 6.6.x with TMPDIR on ext4 does not bring FIBMAP support:

# TMPDIR=/var/tmp LTP_SINGLE_FS_TYPE=btrfs /opt/ltp/testcases/bin/swapon01

tst_test.c:1669: TINFO: === Testing on btrfs ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_swaZf8FN6/mntpoint fstyp=btrfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:45: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01

libswap.c:114: TCONF: Swapfile on btrfs not implemented

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
