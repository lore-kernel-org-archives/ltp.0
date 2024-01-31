Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B65CC47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:34:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FB7F3CE0B4
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:34:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10ED93CB13B
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:33:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AA2F10124CF
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:33:49 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99C961FB78;
 Wed, 31 Jan 2024 10:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706697228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt1kLFNjidYaLa/tMMF2tsf0I5pxOGbWf8uz389V0Qc=;
 b=AODPyWknyYFInYe+ZWvILrcMXweoFoN8yofoo5QkztPQflqbdC/1fEiAZbeQVra3+THLG+
 YCPkbf3bWJT4Khy11Ws4LPXmmjgPaxfRQAvELtLx+xcsFB51VTp7ONilTWI/UVeK6CeGGd
 1PPkCn1oUskvxeITn45hR1LQbXIh5Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706697228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt1kLFNjidYaLa/tMMF2tsf0I5pxOGbWf8uz389V0Qc=;
 b=hbjqVpJqesjIIhZwcaHJflygg/WUS12S1xWjCvxBGwOa2n4b1Xz7dlILZY27oJ7b6LBFl+
 ILXIq54a4eOgwxBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706697228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt1kLFNjidYaLa/tMMF2tsf0I5pxOGbWf8uz389V0Qc=;
 b=AODPyWknyYFInYe+ZWvILrcMXweoFoN8yofoo5QkztPQflqbdC/1fEiAZbeQVra3+THLG+
 YCPkbf3bWJT4Khy11Ws4LPXmmjgPaxfRQAvELtLx+xcsFB51VTp7ONilTWI/UVeK6CeGGd
 1PPkCn1oUskvxeITn45hR1LQbXIh5Tc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706697228;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yt1kLFNjidYaLa/tMMF2tsf0I5pxOGbWf8uz389V0Qc=;
 b=hbjqVpJqesjIIhZwcaHJflygg/WUS12S1xWjCvxBGwOa2n4b1Xz7dlILZY27oJ7b6LBFl+
 ILXIq54a4eOgwxBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 70B98139D9;
 Wed, 31 Jan 2024 10:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id VQ5sGQwiumX8NQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 10:33:48 +0000
Date: Wed, 31 Jan 2024 11:33:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240131103347.GA893365@pevik>
References: <20240131100018.15767-1-andrea.cervesato@suse.de>
 <20240131100018.15767-3-andrea.cervesato@suse.de>
 <20240131102551.GC890138@pevik> <ZbohXx6wa4ny60G1@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbohXx6wa4ny60G1@yuki>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AODPyWkn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hbjqVpJq
X-Spamd-Result: default: False [0.41 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.08)[63.44%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 99C961FB78
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Increase default appends operations in
 dio_append
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

> Hi!
> > I'm ok to keep this in single commit with increasing the number of operations,
> > but it should have been at least mentioned in the commit message.

> The commit changelog should mention the addition of the function to
> check the available space, but otherwise it's ok.

> > And, if I understand correctly, this was meant by Cyril in v1
> > https://lore.kernel.org/ltp/ZbjpATp6cK9AkvBm@yuki/

> I mostly object to having two unrelated chnages in a single commit,
> functional fix shouldn't be cobbled togegher with a change that adjusts
> default parameters.

I figured that out, that's why I merged before you wrote. I'm sorry for the
noise.

> Also the check for a free space should be ideally added into all I/O
> tests eventually.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
