Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55703D2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 06:43:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABDE23CA790
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 07:43:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8207C3C6F4F
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 07:42:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7440510006A5
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 07:42:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DA8F5BCC3;
 Tue, 20 Jan 2026 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768891369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3gRflPD6I2rv1I03etesCut5X2mBiuF5TOrr3qkw+M=;
 b=1Y/+VJXNKBldwHcdvxH7WtPwNQz/Gfnw35mU3hQqU8RWRe7T2vXEX5Uceeuq021iSMerTt
 oVQXOv9y3KVLfaa5E123HgCtftkQXO19U96s35qWvbQgOXMrqu98ORSFTSjluOoVhtqPqt
 Fz2yIofEGm5KTXA5lUhaiHUJ7lLIPeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768891369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3gRflPD6I2rv1I03etesCut5X2mBiuF5TOrr3qkw+M=;
 b=JyTNKsePwdUBGcJr4X184z4f9dg6FoJLZIX/aQ0e2lCWzarXOLmWmUtmpuXR4gl7XzYJRj
 Tqan4O8STBBwEnDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768891369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3gRflPD6I2rv1I03etesCut5X2mBiuF5TOrr3qkw+M=;
 b=1Y/+VJXNKBldwHcdvxH7WtPwNQz/Gfnw35mU3hQqU8RWRe7T2vXEX5Uceeuq021iSMerTt
 oVQXOv9y3KVLfaa5E123HgCtftkQXO19U96s35qWvbQgOXMrqu98ORSFTSjluOoVhtqPqt
 Fz2yIofEGm5KTXA5lUhaiHUJ7lLIPeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768891369;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3gRflPD6I2rv1I03etesCut5X2mBiuF5TOrr3qkw+M=;
 b=JyTNKsePwdUBGcJr4X184z4f9dg6FoJLZIX/aQ0e2lCWzarXOLmWmUtmpuXR4gl7XzYJRj
 Tqan4O8STBBwEnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F7A83EA63;
 Tue, 20 Jan 2026 06:42:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eS6TAukjb2mbDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jan 2026 06:42:49 +0000
Date: Tue, 20 Jan 2026 07:42:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260120064239.GA9785@pevik>
References: <20251223020836.9439-1-wegao@suse.com>
 <20260109061716.20258-1-wegao@suse.com>
 <20260109061716.20258-2-wegao@suse.com> <aW5FCFziQ2ug064v@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aW5FCFziQ2ug064v@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/4] lib: Add support option for .needs_cmds
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
> > +enum cmd_ids {
> > +	CMD,
> > +	OPTIONAL,
> > +};
> > +
> > +static ujson_obj_attr cmd_attrs[] = {
> > +	UJSON_OBJ_ATTR_IDX(CMD, "cmd", UJSON_STR),
> > +	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_INT),

> I guess that it would be cleaner to map this to BOOL, and adjust
> metadata parser to match the value. I guess that I can send a separate
> patch to adjust these two once this is pushed though.

Good point. I also agree to merge this and fix in a follow up.
If you add your RBT, I'll merge whole patchset.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
