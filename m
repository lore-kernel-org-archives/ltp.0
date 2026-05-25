Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EEDCD5BC8
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 09:36:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B61A3E528F
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:36:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89123C72D9
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:35:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 408A71A00156
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:35:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71D08758CB;
 Mon, 25 May 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779701746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwJQPL9lHlIn8l5A1CJD1KmGLTVjLY+BQDP6G6sQMDA=;
 b=DlUM1bl1+x99wKUITcxKCvhEhGoedgyD9GVJgubx932sRWmSu67IJjKiAmyrozpjAgAK0Z
 oOA8xDEziATfVba8g4RjNqQILJRu4nd3D84eEOkn7+ZriftxZ4h40h/A57vf+T7/veknoJ
 N/fQpM/EhSL+34dr6DaQYF2IIb5QXLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779701746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwJQPL9lHlIn8l5A1CJD1KmGLTVjLY+BQDP6G6sQMDA=;
 b=kdf7qGhI/kPOD18uNWdTsNHoygypwiO+ePA6tMy8KWSSGHxRQxq32DCiyNs5MuRRzhXkzJ
 /5OfNI3q1X12/CBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FBMEnnWW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+P0WwedV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779701745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwJQPL9lHlIn8l5A1CJD1KmGLTVjLY+BQDP6G6sQMDA=;
 b=FBMEnnWWOMOVoSG9QtRyAdEmASca0r8RHMPrEmyOwKrW9dXVSYdRir6Y3ZQytl9SdTIm/4
 Tsai1BJ2yrdiTUWqIAm6XfNq8rJnLSqZ1dVQ+KRv/dkkSYNVJT9d0aCSUdm6p5kFwyrc+Y
 WZRZeOXWiVqTW0NeHhDdp/8t8hddnIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779701745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MwJQPL9lHlIn8l5A1CJD1KmGLTVjLY+BQDP6G6sQMDA=;
 b=+P0WwedVWZsnnA2CrstDQb9lNOw6/65zjQvhSQi9Q6W2qMqKYqbBdm5P9XN40p+d+LgGKb
 tcjDis16I+S2JKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 634FD59B93;
 Mon, 25 May 2026 09:35:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j15hF/EXFGr+EgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 25 May 2026 09:35:45 +0000
Date: Mon, 25 May 2026 11:35:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ahQX5jAGqqbcQbqW@yuki.lan>
References: <20260518-fragnesia-variant-v1-1-45b9df38cc78@suse.com>
 <a17d2c76-3b48-480a-bf2b-39fa49cbf952@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a17d2c76-3b48-480a-bf2b-39fa49cbf952@suse.cz>
X-Rspamd-Queue-Id: 71D08758CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sockets/xfrm03: Add skb_segment SKBFL_SHARED_FRAG
 stripping test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +	ret = tst_cmd(xfrm_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
> > +	if (ret)
> > +		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");
> 
> Please change the TBROK to TCONF. Older kernels don't support espintcp 
> even though they have the necessary kernel modules. We should revisit 
> this command later and convert it to direct rtnetlink request in order 
> to correctly handle other errors than missing protocol support.

I've fixed this and pushed the patch, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
