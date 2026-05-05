Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C65CD342F
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 12:07:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C4A3E617B
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:07:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B71A3D0E76
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:07:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05E49200985
 for <ltp@lists.linux.it>; Tue,  5 May 2026 14:07:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9F86AF41;
 Tue,  5 May 2026 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777982831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfXqMSRCvkxgHwuDvGVCULb/kISvdNo+cEty0CylhBs=;
 b=ezlNPPk6a6mux0OQk5A3Rl/GEoAZf3Tr9IVWW0pYuGhyWnFbC6Wa6k1vdLr+F08+9lL8Mt
 KDCosXTNbOw8fPT8fY2znznlDcxiIsNdG/0eYQEu/DCWvfeeSief5htkk/Y7UJmQF6DIjF
 iDfr5YndeTXybylHJIrlfDZJpltf6gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777982831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfXqMSRCvkxgHwuDvGVCULb/kISvdNo+cEty0CylhBs=;
 b=g2tQRKeV6lscBiDhyTN+4tiSF20tjrrBbqaf4GCP30t67Yg4h91SmB2/dIyEOTwQfnE5kR
 Q4BmL71kMWRi9fCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ezlNPPk6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g2tQRKeV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777982831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfXqMSRCvkxgHwuDvGVCULb/kISvdNo+cEty0CylhBs=;
 b=ezlNPPk6a6mux0OQk5A3Rl/GEoAZf3Tr9IVWW0pYuGhyWnFbC6Wa6k1vdLr+F08+9lL8Mt
 KDCosXTNbOw8fPT8fY2znznlDcxiIsNdG/0eYQEu/DCWvfeeSief5htkk/Y7UJmQF6DIjF
 iDfr5YndeTXybylHJIrlfDZJpltf6gQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777982831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfXqMSRCvkxgHwuDvGVCULb/kISvdNo+cEty0CylhBs=;
 b=g2tQRKeV6lscBiDhyTN+4tiSF20tjrrBbqaf4GCP30t67Yg4h91SmB2/dIyEOTwQfnE5kR
 Q4BmL71kMWRi9fCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14202593A3;
 Tue,  5 May 2026 12:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MkYVBG/d+WnreQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 05 May 2026 12:07:11 +0000
Date: Tue, 5 May 2026 14:07:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <afndbbVfw4hV3c5i@yuki.lan>
References: <20260411092452.211540-1-rbranco@suse.de>
 <20260415080623.164440-1-rbranco@suse.de>
 <afjANI7jr23hP4IJ@yuki.lan>
 <bc75c487-59db-47a8-a2f3-db860919b35b@suse.de>
 <afjb4yWvM8Abh98q@yuki.lan>
 <f834cba1-003e-4751-9a84-ddb6a21c282e@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f834cba1-003e-4751-9a84-ddb6a21c282e@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2C9F86AF41
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Use two-step handshake to probe
 features
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > However I would put this code into a common header and call it only in
> > the test setup (so that it's not executed on each test iteration).
> >
> > #define CHECK_UFFD_FLAG(flag) do { \
> >          ... \
> > 	if (!(uffdio_api.features & (flag))) \
> > 		tst_brk(TCONF, #flag " not supported"); \
> > 	... \
> > } while (0)
> >
> =

> Will add this macro.=A0 Let's keep doing the 2 step handshake though.

Sure, sounds good to me.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
