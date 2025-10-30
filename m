Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A85CCF9E3
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 19:40:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 086FF3CC4C0
	for <ltp@archiver.kernel.org>; Thu, 30 Oct 2025 20:40:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDC623CB322
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 20:40:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3EFC314002C4
 for <ltp@lists.linux.it>; Thu, 30 Oct 2025 20:40:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3572337A4;
 Thu, 30 Oct 2025 19:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761853194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+w5U0hqtZHTYvTIEgL51ZPvkjkxaQ3H2LmFN8Nmmc0Y=;
 b=xz7cUJqRCChcIFukCbne1Rizn6H2q6Ffxme/3QD0x84/rZ01D0C9o3WFNXjGtnlS/HfsKL
 MC0MOLmaIVSyzoHiRHTyim19g2kqYYztLJPeD3finGxixTFBBSLEH5rxrQZQpv5v6cM9xw
 FsGQggrwpL/gHRVm++ME1yN9OcL92Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761853194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+w5U0hqtZHTYvTIEgL51ZPvkjkxaQ3H2LmFN8Nmmc0Y=;
 b=c0a0rPcbtbvkvChRmoLdUZXGISyu2g5ZeFX5wmsY8alKBdRFMbD0284UPVcMh9g1zBWtW4
 jLbaHQ9I4g2NJOBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761853194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+w5U0hqtZHTYvTIEgL51ZPvkjkxaQ3H2LmFN8Nmmc0Y=;
 b=xz7cUJqRCChcIFukCbne1Rizn6H2q6Ffxme/3QD0x84/rZ01D0C9o3WFNXjGtnlS/HfsKL
 MC0MOLmaIVSyzoHiRHTyim19g2kqYYztLJPeD3finGxixTFBBSLEH5rxrQZQpv5v6cM9xw
 FsGQggrwpL/gHRVm++ME1yN9OcL92Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761853194;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+w5U0hqtZHTYvTIEgL51ZPvkjkxaQ3H2LmFN8Nmmc0Y=;
 b=c0a0rPcbtbvkvChRmoLdUZXGISyu2g5ZeFX5wmsY8alKBdRFMbD0284UPVcMh9g1zBWtW4
 jLbaHQ9I4g2NJOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6952F1396A;
 Thu, 30 Oct 2025 19:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BRikFgq/A2l+UQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 30 Oct 2025 19:39:54 +0000
Date: Thu, 30 Oct 2025 20:39:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251030193952.GA763610@pevik>
References: <20250827230301.32614-1-wegao@suse.com>
 <20251015031540.2120-1-wegao@suse.com>
 <20251016133203.GA284465@pevik> <aPH1a43lTn_CKnH1@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPH1a43lTn_CKnH1@localhost>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

Hi Wei,

...
> > And please use #ifdef.
> When MREMAP_DONTUNMAP can not be found config.h will contain:
> #define HAVE_DECL_MREMAP_DONTUNMAP 0

> So i suppose we should use #if instead of #ifdef otherwise compile issue
> will happen on old platform.

Indeed declarations are really defined (instead of commented out undef).
I'm sorry for a wrong hint.

Kind regards,
Petr

> If you agree then i will prepare new patch.
> Thanks.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
