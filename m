Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2F1C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:33:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA70B3CE39B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:33:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 435443CC251
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:33:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAE3D6002FD
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:33:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DC853DF6;
 Mon, 10 Aug 2026 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786361590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdTfozp/vSzbM+o/48BIkVbBxgc95u6LV4oQcRF6z5g=;
 b=YFKBZ4tZ3/Oh9Jb7uZ68MAucBpunhy7rYPbGXw+NBKLjYi7uSzSMmiBmvRKqnBpxNlzBrc
 e+/q5OXpHq+HJgy+hxeteex2l5cb7LLfL6EUIOHzzOB47q+5sq4VBhm0V2+lzFVivUPYQG
 puEPrTTsZl26FmyxyShwDjNmYtiC4l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786361590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdTfozp/vSzbM+o/48BIkVbBxgc95u6LV4oQcRF6z5g=;
 b=kI3TPfYN8fSL5pgQSa9IAm7x9jdZuo4VX5MUBQWhZ0tdOUUAE0KZyzD215nk/PbTeRkNRg
 DV7QQP+BXsJ2cfDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZnzPGGWG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=89ujbHhr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786361586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdTfozp/vSzbM+o/48BIkVbBxgc95u6LV4oQcRF6z5g=;
 b=ZnzPGGWGEqn9pppuXVE2qy+CBxj7IdpXSWQ5uASSXCX1Y67Birwz8EybJXQIiAGVjiYkql
 z7VamgYKUe7iaoueWJ16nx3iXfJ2Tn2leDz20b5/8Br2YaDVWXFROiT7HgcJ2+cTtDGUaD
 5/k+6aDP06awVCfECtJxVaBOdZxQ2DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786361586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zdTfozp/vSzbM+o/48BIkVbBxgc95u6LV4oQcRF6z5g=;
 b=89ujbHhrtvRHFxOLx8EKii0jtvTtogM35qUnQLg/Yf6fY13E9mp2A1bQhPghkIh9fDiaNp
 Ch3gb4j4p77VbVBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D375E779B2;
 Mon, 10 Aug 2026 11:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jCCSMvG2eWpaJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 11:33:05 +0000
Date: Mon, 10 Aug 2026 13:33:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260810113300.GD918586@pevik>
References: <20260805151451.648990-2-pvorel@suse.cz>
 <6a74317f.5b42f266.2b3442.f731@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a74317f.5b42f266.2b3442.f731@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0DC853DF6
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/9] tst_kvercmp: Factor out error handling
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

Hi Andrea,

> Hi Petr,

> We got 4 reviews..it seems like there's a problem with the CI
> and the new instance is not setting the state correctly, which
> is used by the script to recognize if patch was already reviewed
> or not. I will fix it.

Thanks for your time and effort to fix it.

> Anyway, we can say you had enough material to fix the series :-)

If you mean agent complains [1] they are mostly wrong. (The only correct one is
for 9th commit which I'm going to drop).

Anyway, I'll send next version without last 3 commits (2 of them RFC), because
only that part was problematic (even v3 was ready and could have been merged
with 2 minor fixes changed before merge).

I'll reply to agent objections [1] before sending and I guess I'll have to do it
again in next version, unless there is some shared context between patchsets.
But I'm getting to understand Wei's frustration to fight against agent's false
positives :).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260805173540.9276-1-linuxtestproject.agent@gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
