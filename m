Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F7ECD3427
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 12:24:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9530A3E617E
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:24:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 173923CEA39
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:24:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 846E66008A9
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:24:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 115176B272;
 Tue,  5 May 2026 12:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777983858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvGyP4kTtYiWwfa6+mjtEB0/WETQsHs+5w6dvJT08Rw=;
 b=qDA5k5G37M8luivkZI1YYMhxm2XB7/u012uuTZk7zssuXgyLcoQkZI7bCRIRFBXKJ//tMO
 TgfRceYBVYt1NyLKnHvctu4H0vbnXst3FcVVSGPUNuvysGxxb85/4+axLIgJporcuEcsur
 KZykhmeZ9KmfzJe+fX112yfd7jQpKTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777983858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvGyP4kTtYiWwfa6+mjtEB0/WETQsHs+5w6dvJT08Rw=;
 b=79jP8QhHFoO1mbDuSTK74WiCm36J70HncohvrG7Q6KRaN3USR4PIzZ99Xd369/iuO8OrRQ
 cGfrAkC/NHz62HBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="1YDR9Z/C";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ia4tvXfw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777983857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvGyP4kTtYiWwfa6+mjtEB0/WETQsHs+5w6dvJT08Rw=;
 b=1YDR9Z/CWKwRdBrvJI3AeXKYoJ7SaoQT162s/MwK6r/89cTF7OKRYGCVE4Bx8PxM8LK7/F
 cK/9r/PmurGdpijAd6kbOuasFiqZkECJ8jPYUQcE+5BOo7ByYYA31eka3e5InDeE6z09CW
 30NTwcZ1l4mLptpE27ZC+m2gx+gB9BE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777983857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvGyP4kTtYiWwfa6+mjtEB0/WETQsHs+5w6dvJT08Rw=;
 b=ia4tvXfwBC3dTdWUmTGNoAJ474Hih5rUDP3Fgy86Kq8yU8oP9+bwl/clI5cBnc1pdD8FKH
 YmnkJiStvQmFpdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01E49593A3;
 Tue,  5 May 2026 12:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /YAaO3Dh+WkSDQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 May 2026 12:24:16 +0000
Date: Tue, 5 May 2026 14:24:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: acervesato@ltp-agent
Message-ID: <afnhc0tHGXTF-1TT@yuki.lan>
References: <20260411094742.219667-1-rbranco@suse.de>
 <20260411104402.4073-1-ltp-ci@noreply.github.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260411104402.4073-1-ltp-ci@noreply.github.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 115176B272
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memfd_create: move sys_memfd_create() to lapi/memfd.h
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > memfd_create: move sys_memfd_create() to lapi/memfd.h
> >
> > Add the static inline wrapper to include/lapi/memfd.h and include the
> > required headers so other tests can reuse it.
> >
> > Also fix some minor issues detected by make check.
> 
> The commit bundles two logical changes: the main refactoring (moving
> sys_memfd_create() to lapi/memfd.h) and unrelated minor fixes (blank
> line in memfd_create01.c, trailing semicolon in CHECK_MFD_HAS_SEALS).
> Please split them into separate commits.

In this case it's a single semicolon removal, so I would let it as it
is.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
