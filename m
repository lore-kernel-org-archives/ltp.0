Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CB0C982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 15:12:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CAB03E6CE7
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 17:12:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 648C33E6CA3
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:12:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1EB61A0111F
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 17:12:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81EBB1F848;
 Tue, 22 Sep 2026 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790089911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsjEvk77pnMnjiuEwBKELGWOnqh2pIZREamlZZZrgHg=;
 b=XrQofKOt47s52Ismwz5MIjIdMExO8DQe9pz60/4Iv85KQ9OXlMeuJclr1qiHiAxPMbKh3G
 PzYmoLd0aYxbyJJRm9jAFhDz9EvDTkcUkLbCXYIZtsX8hUknK2wCiLhbC1QZhNC8JGMDMX
 6tWvCPfyXyTJ2RHtZFMk7RQ4jEatCBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790089911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsjEvk77pnMnjiuEwBKELGWOnqh2pIZREamlZZZrgHg=;
 b=tOMQu6KZTPcACIrGv8M1yI4GEo1JzslQogsYqWK+Be/BQQEZqXAbJxGrNGmE9NCwZt4I2z
 R9DARQR8SGSw4yDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tf47h1BC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EGxuvp2Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790089907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsjEvk77pnMnjiuEwBKELGWOnqh2pIZREamlZZZrgHg=;
 b=tf47h1BCodDdWw7CCwN2ZUdzzelVVYw33kRtSz6OiCaS46bFBn2YQ3QLzs+0Q2SlNHH8cY
 5ZsZ+lv9PQRaZ3kLX2yUqeIxaqY/OimiH5Rk+YG3EoL3LJJyyxxz/ajS+EuBiHMD9vsQPv
 1RcYPlX5mdtzG9NfR2KjuY2IAl67J74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790089907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JsjEvk77pnMnjiuEwBKELGWOnqh2pIZREamlZZZrgHg=;
 b=EGxuvp2ZadfAfH/zsmxgaFeNOfnRJtEi54FXP4diETO9rjLVFNU/lFvrZ3DG0X0wNLGpwn
 7oVJ3ap4He+Au+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F854136D9;
 Tue, 22 Sep 2026 15:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0RxtC7OasmrbZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 22 Sep 2026 15:11:47 +0000
Date: Tue, 22 Sep 2026 17:11:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <arKavCPzS5Py0rVG@yuki.lan>
References: <20260922122059.4087109-1-chrubis@suse.cz>
 <20260922142816.4918-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922142816.4918-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 81EBB1F848
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kconfig: Add CONFIG_* mappings for keyctl tests
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
> On Tue Sep 22 14:20:59 2026 +0200, Cyril Hrubis wrote:
> > tst_kconfig: Add CONFIG_* mappings for keyctl tests
> 
> > @@ -165,6 +165,8 @@ static struct config_module_map {
> >  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> >  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> >  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> > +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},
> 
> Typo in module name "pcks8_key_parser"; change it to "pkcs8_key_parser".
> When CONFIG_PKCS8_PRIVATE_KEY_PARSER=m, tst_check_module_driver() fails
> to find the module and marks the kconfig as unset, causing tests like
> keyctl30 to be incorrectly skipped with TCONF.
> 
> Verdict - Needs revision

Sigh, send v2.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
