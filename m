Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD28FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 12:53:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB28C3E594A
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 14:53:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAEED3E2ACC
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:53:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 68CDE600D7F
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 14:53:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B35C06A821
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777553596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytIKWoheFm64FvcPvlDPU8rjSs2r2jz2qU8QvduB5Lo=;
 b=b3FzQ+zicebH7XhOfXltUUdSi5idqxqoNL8Gwe0JVknH/7sRduiJdCq5LOOcJJ9nyW0gtR
 33Y28d4aT6eMYHDTmn23uAVWy324IrmvpNgk8EYW0RLXZAFyTQ5dvNsNdVVX4HYFaMGgzO
 3GIqzYYjKYLUeVt/sFWc2cpad+c7bH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777553596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytIKWoheFm64FvcPvlDPU8rjSs2r2jz2qU8QvduB5Lo=;
 b=TGLJAUdN72Ba37SiQWUmB4pwbF/cjexpu6xnwCvhUCsVs5KejAvVsovWXKlPOv7/4xZjwh
 O5PFlF0fknn3vrBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kynVmJFw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G3mjQk5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777553595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytIKWoheFm64FvcPvlDPU8rjSs2r2jz2qU8QvduB5Lo=;
 b=kynVmJFwGVZ8cY6U/DXIlaLQFBm4hpIII+UArr/w1Tj5KQ53RcLArBrlAF5gvAJLoxAYO+
 e+fYgnk1BrpCmzY3qMmV1OwEAtFEj4cMdTKfrmJZg3wmT7TIou84QuWZa4M4hg+wKRN5ko
 +EYUcaj7Nhgf5JAjlXgZ49vqiVG0qK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777553595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytIKWoheFm64FvcPvlDPU8rjSs2r2jz2qU8QvduB5Lo=;
 b=G3mjQk5WJS+gSipyV53Vr6fyoTquPdzPWR/vNZNY8TohIn1ftKo+4s1KCOgS0x1larJybg
 v6vDYK8j2tg2KbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A44CF593B0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VYlIJ7tQ82laEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 12:53:15 +0000
Date: Thu, 30 Apr 2026 14:53:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <afNQuLNeBcYC_zAG@yuki.lan>
References: <20260430091956.10915-1-chrubis@suse.cz>
 <afMwMO1yTBGDLQJc@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afMwMO1yTBGDLQJc@linux.dev>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid,
 linux.dev:email, linux.it:url]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B35C06A821
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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
> > Calling tst_reinit() when library is already initialized or calling it
> > for a second time is always mistake. With that we silenty drop the old
> > IPC region, that may have contained test results and there are likely
> > other problems possibly caused by initializing the test library twice.
> > 
> > To fix that this patch adds tst_brk() that abort the test if we call
> > tst_reinit() with already initialized test library.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> Reviewed-by: Li Wang <li.wang@linux.dev>
> 
> The patch itself looks good, I'm just wondering how you found
> this issue, was it called twice somewhere/in a test?

https://lists.linux.it/pipermail/ltp/2026-April/048084.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
