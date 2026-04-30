Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02095FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:39:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A22373E6C8C
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:39:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BA143E1CB7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:39:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 472B0600631
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:39:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF8B46A822
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777556352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=1U9yNKr2fZddfWkBUcakSsX9bNwDASheiSKkRhhZ2uA=;
 b=N8ZaIG2Ocq5t0jMA+pve3IsssBO6/R/F6Qozvnq/VPS1PkFUyb4s1qT8imxbPkkAaMRcUy
 RMjBo8fZO1BcghiSe/DL6d+/XDTZHrbyUdJZutV4qGP6TIb9toEbGqSB6bzf95LPBfc7ha
 5Cm4fMO0lx0pXF9/aZsAq3+Vencsr4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777556352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=1U9yNKr2fZddfWkBUcakSsX9bNwDASheiSKkRhhZ2uA=;
 b=3Err+X6wfyFUJ/9enzha8kqTWmZqb2EaSias2tn9OWDGagFmYLwUc9hXGtykCNs5pljU0E
 nQVlAIliCjMYyQCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777556351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=1U9yNKr2fZddfWkBUcakSsX9bNwDASheiSKkRhhZ2uA=;
 b=zCd0YhKmpYXETbZI9/HrH+bj9X5Msl/PGDeMmBbmZXV/zTmwtV1yCvia/PZgdDZ23Hg2Bd
 xPNrruUsBL7i2vJACf8h2iQLGG5IUTzyOZxeMDUXw/+k9PMpeKsen39vgO5osbtirLury4
 +JhR5H888s1x+CeosQiurmZKatTn4g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777556351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=1U9yNKr2fZddfWkBUcakSsX9bNwDASheiSKkRhhZ2uA=;
 b=oYGtp/59aoOEf2UhDnNf4uj1O/G+wt2SdDUZ4Gr5wK/pkrREALrrSv6HewJqi/IdXDx12y
 zPda22NOMKjNFBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4A03593B0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i6z/Kn9b82k7QQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:39:11 +0000
Date: Thu, 30 Apr 2026 15:39:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <afNbfCcv83zeMsgZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_NONE(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, yuki.lan:mid,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Given that we have a SUSE Labs konference in the week starting 18. May I
would like to start LTP May release preparations a bit sooner.

I would like to do the usual patch review that decides what goes into
the release during the first two weeks of May. Followed by the
pre-release freeze starting at the 18. May and final release at the end
of the Month.

If there are any patches that should be considered to be included before
the release, please reply to this email.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
