Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B287C3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:08:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C76173CE53D
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 11:08:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B0C3C8B55
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 11:07:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9BEC603A5B
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 11:07:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F4071F795;
 Mon,  8 Jan 2024 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704708422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R99rqxoGR/Qlzqgu2a6HJKzxAx4tDUpg3SJMoXbVjNk=;
 b=GsmfaT9vT5a2rd85NnzGqeWRbuuq3hTMlT1avysMx1ORSgDDgY+/MFoxWcl6VBFexV6GyC
 m8W2Cydfw4v0Qx4Bagq4PPXa7Gua3JJbzmtP4RSMW3hGUKn4xm0YP9qQfEUI2SwCdpmIXx
 mZwBi9cpv7TZ1vvxwbqMG6rS1GFFaV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704708422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R99rqxoGR/Qlzqgu2a6HJKzxAx4tDUpg3SJMoXbVjNk=;
 b=7ScbUFE/CJ4U26UvCsuT6MZhX96dkM3iqYXqnjxi/FbgcAHJn3yVZixO3KDB0KCmmaWvcJ
 9xYfLEbYp9QfauAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704708422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R99rqxoGR/Qlzqgu2a6HJKzxAx4tDUpg3SJMoXbVjNk=;
 b=GsmfaT9vT5a2rd85NnzGqeWRbuuq3hTMlT1avysMx1ORSgDDgY+/MFoxWcl6VBFexV6GyC
 m8W2Cydfw4v0Qx4Bagq4PPXa7Gua3JJbzmtP4RSMW3hGUKn4xm0YP9qQfEUI2SwCdpmIXx
 mZwBi9cpv7TZ1vvxwbqMG6rS1GFFaV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704708422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R99rqxoGR/Qlzqgu2a6HJKzxAx4tDUpg3SJMoXbVjNk=;
 b=7ScbUFE/CJ4U26UvCsuT6MZhX96dkM3iqYXqnjxi/FbgcAHJn3yVZixO3KDB0KCmmaWvcJ
 9xYfLEbYp9QfauAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 512331392C;
 Mon,  8 Jan 2024 10:07:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sMOXEkbJm2UrNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 08 Jan 2024 10:07:02 +0000
Date: Mon, 8 Jan 2024 11:07:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZvJXTshFUYSaMVH@yuki>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240108090338.GA1552643@pevik>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GsmfaT9v;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="7ScbUFE/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWELVE(0.00)[19];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 6F4071F795
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Call for nommu LTP maintainer [was: Re: [PATCH 00/36]
 Remove UCLINUX from LTP]
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, Jonathan Corbet <corbet@lwn.net>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Rob Landley <rob@landley.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>, buildroot@buildroot.org,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> support him in my free time (review patches, give advices). And if nobody
> stands, this patchset which removes the support in the old API will be merged
> after next LTP release (in the end of January).

Let me highlight this part, we are eager to help anybody who is willing
to pick the nommu work, but we do not have resources to drive it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
