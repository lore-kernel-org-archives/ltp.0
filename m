Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C841C55184
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:33:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF87E3E15FE
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:33:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D143CC870
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:33:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C371140098C
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:33:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A5003F87;
 Mon,  3 Aug 2026 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785752657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmFCEvTwmbdnQpHSlXY6MkKDMo1C9yc9jDQY9ANtvfM=;
 b=0gdJ49pgY4lzP3bOjVazDWBlm+zJoTuo7RYDQTeC5AUHKAMDLXeVHme0TCkeDo5GDSt32M
 d0DQ4pB75c/k5/Ui24QKHxJ9b1k6k+cdlSSpkH2d35Q7/GU5HqJr51JbB8rVB+xjd0qkf/
 0ghqlRhDTXyEniA4+yDdqn8D3qKI1qE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785752657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmFCEvTwmbdnQpHSlXY6MkKDMo1C9yc9jDQY9ANtvfM=;
 b=JsfKCeU8CxBATB3seCohdywwLF05eOtAO3GpajUCkZ0L1E9RrvMb5kx6cHs7rHnQGUnvIy
 if0UvqIQ1F3TjOCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kolf2Oq3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="EOD/trHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785752653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmFCEvTwmbdnQpHSlXY6MkKDMo1C9yc9jDQY9ANtvfM=;
 b=Kolf2Oq3kJsHHg66EGevAYS+6RiBbjG1sTGh92or83xF2G2cKpGBSqSD4y5DsAwuX2IvFr
 1eZ9GWE454xlYg55NcmDQOtS04uco/xCahY67qB4OMRZnzYn2yOaxlxc4hlYYqIZHqZRx2
 fhmQM1AX/6CWNC+5WxMOtw6YZcug5xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785752653;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmFCEvTwmbdnQpHSlXY6MkKDMo1C9yc9jDQY9ANtvfM=;
 b=EOD/trHOUdq5fa/W6PWxWm0pnoeAqKirScusLGwXV2MIaVThqTOpR9a8z7IR89a8tAyZtJ
 drZCjpz+fW409NDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E721779C1;
 Mon,  3 Aug 2026 10:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SKbeFU1scGr0UAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 10:24:13 +0000
Date: Mon, 3 Aug 2026 12:24:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Jan Stancek <jstancek@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>,
 Avinesh Kumar <akumar@suse.de>, Martin Doucha <mdoucha@suse.cz>,
 Wei Gao <wegao@suse.com>
Message-ID: <20260803102407.GB217746@pevik>
References: <anBdxCKHlpedf2rf@yuki.lan>
 <6a705f30.cfe55ba5.e6eae.189a@mx.google.com>
 <anBi9ybOfNzbxALE@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anBi9ybOfNzbxALE@linux.dev>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,linux.dev:email,ozlabs.org:url,linux.it:url];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,ozlabs.org:url,linux.it:url];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 9A5003F87
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Hi Li, all,

> Andrea Cervesato wrote:

> > > I would keep it around at least for a year or two, I sometimes look up
> > > old patches there.

> > that looks like a really long period of time. lore.kernel.org/ltp/
> > is not enough?

> I guess Cyril means to look back the history of patch discussion when needed.

Well, for the patch history we have LTP ML archive [1] and lore (has longer
history than patchwork [2]). Although patch view in patchwork might be easier to
read.

I meant something different: people have probably sent LTP patchwork ozlabs
instance links to other, put in bugzilla etc. Patchwork use Message-id, therefore
patch link [3] can be easily converted to lore [4]. Patch comment [5] don't.
That's why I'd keep abandoned LTP instance for some time, but maybe we just don't care.
Obviously keeping it around depends on ozlabs maintainers decision.

> Or, can we tar the mail discussion for recent years and store it somewhere?

FYI we already have history in git as an public-inbox [6]:
git clone https://lore.kernel.org/ltp/

> Anyway, for the patch:

> Reviewed-by: Li Wang <li.wang@linux.dev>

Thanks!

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/
[2] https://lore.kernel.org/ltp/?t=20180216133201
[3] https://patchwork.ozlabs.org/project/ltp/patch/20260731054548.133241-1-pvorel@suse.cz/
[4] https://lore.kernel.org/ltp/20260731054548.133241-1-pvorel@suse.cz/
[5] https://patchwork.ozlabs.org/comment/3731798/
[6] https://lore.kernel.org/ltp/_/text/mirror/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
