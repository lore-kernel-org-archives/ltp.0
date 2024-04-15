Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EC0C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 15:21:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83A1B3CFA2A
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 17:21:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A284F3CFA02
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 17:20:53 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A8851000D09
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 17:20:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBE3037150;
 Mon, 15 Apr 2024 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713194449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE9Gktv+bxc9wrG1vMUbZrxvZSN1m/JQtLzzithqQEk=;
 b=G8FGPeZE921tfnWZJzNXXxQyf4vai1yyUJS5q7jS8bnDu2GH5roo97UcV3RNldWeRy9YlD
 SMlkPFbcJ7JMF+f8gvdWvdHEnxXey3A0nt/n7Y30tvWQBjC945Yn7QapyWy5tIprlSx1xM
 uYXroVYv+7/MusVBiIkgrzMeydiRzkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713194449;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE9Gktv+bxc9wrG1vMUbZrxvZSN1m/JQtLzzithqQEk=;
 b=EehSbbwp2DhT2s/IEPs4SM+PQJh5P9tSac7AzW6s1pZZnPzNPyaN3SmRy7SclFNY21jhvI
 NWjZT3pq13mRB1Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Aa5dRRcp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5Fc5COcl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713194448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE9Gktv+bxc9wrG1vMUbZrxvZSN1m/JQtLzzithqQEk=;
 b=Aa5dRRcp6mqaR1D4PtSMrfs0llH/88YsmquTnnyYUkArYcLcMzKBwa5/ltZ+p/Dp7kRhqS
 BbxY/AS5BoDs8/7buwaj9B54kW9nh0BUI5idRrUlhrv6Xo/vAErCr2GDoz48Mj6Tg//KS+
 mKkbxGHIVJWLUV6Ju9Nxd8d0U688N/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713194448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fE9Gktv+bxc9wrG1vMUbZrxvZSN1m/JQtLzzithqQEk=;
 b=5Fc5COclAsCVDGYbhb//OtMCMI7vq0XrKUhWpZK/k642tOGZUFlVIwSHnk98EncXLFrmjn
 ikQHneTdlHNcu9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABDD51368B;
 Mon, 15 Apr 2024 15:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ECaeKNBFHWYDOwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Apr 2024 15:20:48 +0000
Date: Mon, 15 Apr 2024 17:20:43 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240415152043.GA541530@pevik>
References: <20240322030208.3278120-1-liwang@redhat.com>
 <20240322050046.GA572447@pevik>
 <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
 <20240322053217.GA588706@pevik>
 <CAEemH2fjNisDjZjRn60534rK1AHefbXPEUPS1FS0EA0OcfFrtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fjNisDjZjRn60534rK1AHefbXPEUPS1FS0EA0OcfFrtQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DBE3037150
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Petr Vorel <pvorel@suse.cz> wrote:

> > > Thanks, I would give the patch set more time in case others have
> > comments.

> > Sure. Thanks for a nice work!


> Patch set applied.

FYI it looks like this patch merge as:

f987ffff5 ("libswap: add two methods to create swapfile")

introduced TWARN on all tests which touched: swapoff0[12], swapon0[1-3] on openSUSE Tumbleweed
on ppc64le (e.g. very close to mainline stable kernels: 6.8.x). Have you noticed
this on Fedora as well?  I hope to manage to have look on it soon, but maybe
it's obvious to you already.

libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).

Example of the warning:

* swapoff01
on all of the filesystems:
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_swaWdvJcZ/mntpoint fstyp=ext2 flags=0
libswap.c:156: TINFO: create a swapfile with 10 block numbers
libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).

* swapon03
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1131: TINFO: Mounting /dev/loop0 to /var/tmp/LTP_swalq2Qxc/mntpoint fstyp=ext2 flags=0
libswap.c:156: TINFO: create a swapfile with 10 block numbers
libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
libswap.c:156: TINFO: create a swapfile with 10 block numbers
libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).
libswap.c:156: TINFO: create a swapfile with 10 block numbers
libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).
libswap.c:156: TINFO: create a swapfile with 10 block numbers
libswap.c:163: TWARN: Swapfile size is less than the system page size. Using page size (65536 bytes) instead of block size (4096 bytes).
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
