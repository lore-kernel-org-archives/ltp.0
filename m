Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879ACE9538F
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:26:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16E563CE0E0
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:26:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C831D3CDE88
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:26:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5EA871A004CC
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:26:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 027335BE10;
 Wed,  4 Feb 2026 12:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770207993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QTRPe2PuGFT7NhcWE9VVoorMqylSkx6d/vURYxLO2A=;
 b=slTEeMWYmKhpNuwnW7GR2aJWgrfNqZR4pzl8KCkR0r2FC9iGtJ1iz0TOCeR75sFnfI44br
 jhBRyBIcsA+SZHVmiOM3hOd2SrcOTbabfknzZS+CorCKCuyTRh9eZlb/UO8OJ+2T+BLHu4
 /l5xQIJcBu4Mk1+33MoIH7/t5aUJ3Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770207993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QTRPe2PuGFT7NhcWE9VVoorMqylSkx6d/vURYxLO2A=;
 b=0TC8/MT4s8oS32yCXq/oPNF3Sjvr7O+RTN/taHAQJOS7P2Kr2g+wkU+Xq+VT4xe2+UA+Rc
 4mELmKnnahjjthBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=slTEeMWY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0TC8/MT4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770207993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QTRPe2PuGFT7NhcWE9VVoorMqylSkx6d/vURYxLO2A=;
 b=slTEeMWYmKhpNuwnW7GR2aJWgrfNqZR4pzl8KCkR0r2FC9iGtJ1iz0TOCeR75sFnfI44br
 jhBRyBIcsA+SZHVmiOM3hOd2SrcOTbabfknzZS+CorCKCuyTRh9eZlb/UO8OJ+2T+BLHu4
 /l5xQIJcBu4Mk1+33MoIH7/t5aUJ3Wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770207993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QTRPe2PuGFT7NhcWE9VVoorMqylSkx6d/vURYxLO2A=;
 b=0TC8/MT4s8oS32yCXq/oPNF3Sjvr7O+RTN/taHAQJOS7P2Kr2g+wkU+Xq+VT4xe2+UA+Rc
 4mELmKnnahjjthBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D091E3EA63;
 Wed,  4 Feb 2026 12:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y5WmMPg6g2l+DwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 12:26:32 +0000
Date: Wed, 4 Feb 2026 13:26:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260204122631.GA228239@pevik>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260203024320.227453-2-liwang@redhat.com>
 <20260204115718.GB224465@pevik> <aYM19J5g7dTa5gqO@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYM19J5g7dTa5gqO@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 027335BE10
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] newlib_tests: add tst_filesystems01 to
 .gitignore
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

> On Wed, Feb 04, 2026 at 12:57:18PM +0100, Petr Vorel wrote:
> > Hi Li,

> > obviously correct, thanks!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Patchset merged, thanks!

Ah, I should have sent my comments for v1 first, as I meant my RBT just for this
patch, now for the first one :).

Anyway, I'll send a patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
