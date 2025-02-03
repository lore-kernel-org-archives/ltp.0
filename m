Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067C7C02193
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 10:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F4343C6AA0
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 11:13:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0F383C06D3
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:12:58 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DEF6422C657
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 11:12:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA0E1F37C;
 Mon,  3 Feb 2025 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738577576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uuTZE1Z7J31LmbO3BGZ0jaYwR9M7PA+eSgbYBtOQplM=;
 b=Z6YJd3uxkosScC7hM6O6jr/dB0HlUu9/2eKx4UNoFWlvNllyDIuaZFjyLzhj+NqortZeZp
 MGWpEP/Dsa2GPgIfRA4AuuCrplurTfULrxD+RBEZHo8ps4niX9rQiSwOGVMVbnFJrgb8PN
 J2vz1lyugQmRpe/J7jp+ee9RTe93Ebs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738577576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uuTZE1Z7J31LmbO3BGZ0jaYwR9M7PA+eSgbYBtOQplM=;
 b=8l4Uu8DEkL0Ovha1bGt4CMjovVc8nNtiFHhDgJMOuQxmDWZ5FGOsPpFSxiY8vxspNdrdH/
 EVKJEiuSAVyDN2AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738577576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uuTZE1Z7J31LmbO3BGZ0jaYwR9M7PA+eSgbYBtOQplM=;
 b=Z6YJd3uxkosScC7hM6O6jr/dB0HlUu9/2eKx4UNoFWlvNllyDIuaZFjyLzhj+NqortZeZp
 MGWpEP/Dsa2GPgIfRA4AuuCrplurTfULrxD+RBEZHo8ps4niX9rQiSwOGVMVbnFJrgb8PN
 J2vz1lyugQmRpe/J7jp+ee9RTe93Ebs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738577576;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uuTZE1Z7J31LmbO3BGZ0jaYwR9M7PA+eSgbYBtOQplM=;
 b=8l4Uu8DEkL0Ovha1bGt4CMjovVc8nNtiFHhDgJMOuQxmDWZ5FGOsPpFSxiY8vxspNdrdH/
 EVKJEiuSAVyDN2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B67A13795;
 Mon,  3 Feb 2025 10:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D4ydAaiWoGfwbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Feb 2025 10:12:56 +0000
Date: Mon, 3 Feb 2025 11:12:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250203101254.GA1237315@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <6145632.lOV4Wx5bFT@thinkpad> <20250131110136.GB1097590@pevik>
 <6151942.lOV4Wx5bFT@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6151942.lOV4Wx5bFT@thinkpad>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

Hi Avinesh,

...
> > > Hi Petr,

> > > I am sorry, I completely missed this.
> > > I sent the patch for EWOULDBLOCK case now -
> > > https://lore.kernel.org/ltp/20250114155013.7644-1-akumar@suse.de/T/#u

> > Thanks for info. I'm closing this as rejected. Please let me know if I did not
> > understand you and this is a valid patch.

> Hi Petr, the above v3 patch (for new test of flock/EINTR errno) is still valid.
> I took out the EWOULDBLOCK test from the original patch (by Yang Xu) and
> added that to flock02, you already merged that one.
> So you can review flock07.c patch just for the EINTR case.

Thanks for info, I reopened it in patchwork and I'll have look later.

I see, the crash is workarounded by forking child and verifying, that's why it's
not in flock02.c (which has other errnos, which don't need a workaround with
forking).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
