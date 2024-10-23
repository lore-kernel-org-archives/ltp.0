Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12815CF5386
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 12:57:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B0623C706B
	for <ltp@archiver.kernel.org>; Wed, 23 Oct 2024 14:57:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E75D3C1BE0
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:57:11 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0071208F8B
 for <ltp@lists.linux.it>; Wed, 23 Oct 2024 14:57:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6406E1FD9F;
 Wed, 23 Oct 2024 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729688229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URA3t+GeqPg9qsL8ptUSbzaFQYh3hKVunpLS36FhPVM=;
 b=ljnB/DleYXBTVzv89ra0Hev9YEXRL2Yff6jFoqM3NRqPAvO+c3offqRictn2D3hxYYmDIt
 yoO//bB9MX5bR5vpPn8m7hz5Ymakf/BalmHYvqLFnn7LkRHGrn+QacKsCpARDueM4eCe4K
 7azKaNiYiX1AX+ODGi4plBg0GXeWXms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729688229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URA3t+GeqPg9qsL8ptUSbzaFQYh3hKVunpLS36FhPVM=;
 b=Ki5j8CuGlC8yggWMsPbBRh4rYEmer9L3R6pWn3i/lAweaZIpqL30Bz738oSU91PWls24GZ
 DQ3jPV00Pxd09LDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729688229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URA3t+GeqPg9qsL8ptUSbzaFQYh3hKVunpLS36FhPVM=;
 b=ljnB/DleYXBTVzv89ra0Hev9YEXRL2Yff6jFoqM3NRqPAvO+c3offqRictn2D3hxYYmDIt
 yoO//bB9MX5bR5vpPn8m7hz5Ymakf/BalmHYvqLFnn7LkRHGrn+QacKsCpARDueM4eCe4K
 7azKaNiYiX1AX+ODGi4plBg0GXeWXms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729688229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URA3t+GeqPg9qsL8ptUSbzaFQYh3hKVunpLS36FhPVM=;
 b=Ki5j8CuGlC8yggWMsPbBRh4rYEmer9L3R6pWn3i/lAweaZIpqL30Bz738oSU91PWls24GZ
 DQ3jPV00Pxd09LDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E456313A63;
 Wed, 23 Oct 2024 12:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kGW9M6TyGGc6cwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Oct 2024 12:57:08 +0000
Date: Wed, 23 Oct 2024 14:57:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241023125707.GA594199@pevik>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-4-5328a785bbad@suse.com>
 <CAEemH2fnQ+H83o4L6Rx1p-e7s3ExFAwK9PNRkbGZuc2OFYUEYg@mail.gmail.com>
 <CAEemH2fyP++1HsNyN_EUjOAXj+XOKjnMXs4muzP-V4Dtnq1PQg@mail.gmail.com>
 <20241015171717.GA36237@pevik>
 <69c655f5-3635-48c7-a925-544ad2af05ca@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c655f5-3635-48c7-a925-544ad2af05ca@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Update syscalls files
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

Hi Andrea,

> Hi Petr,

...
> > Also, this 4th patch also does not apply. Unlike first commit there are more
> > conflicts (applying of course on the top of the 3 previous patches):

> > Description: [v4,4/4] Update syscalls files
> > Applying: Update syscalls files
> > error: patch failed: include/lapi/syscalls/arm.in:1
> > error: include/lapi/syscalls/arm.in: patch does not apply
> > error: patch failed: include/lapi/syscalls/arm64.in:294
> > error: include/lapi/syscalls/arm64.in: patch does not apply
> > error: patch failed: include/lapi/syscalls/ia64.in:341
> > error: include/lapi/syscalls/ia64.in: patch does not apply
> > error: patch failed: include/lapi/syscalls/x86_64.in:349
> > error: include/lapi/syscalls/x86_64.in: patch does not apply
> > Patch failed at 0001 Update syscalls files
> This is really strange. It's not happening for me even with the latest HEAD.
> Did you rebase first?

I was applying to the master (as I wrote first I need to adjust first patch
which also didn't apply, but that's just a single line). Don't bother if the
problem is really on my side.  But pushing the patchset to your fork would help
me to actually test the code.

Kind regards,
Petr

> > Kind regards,
> > Petr
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
