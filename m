Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6CDC88E75
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 14:44:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046BF3E8CB7
	for <ltp@archiver.kernel.org>; Tue, 15 Sep 2026 16:44:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DEBD3E48AE
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:44:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E1B8460097E
 for <ltp@lists.linux.it>; Tue, 15 Sep 2026 16:44:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CCD11FF3B;
 Tue, 15 Sep 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9L3PVF/Xc3tclwjVhxBOG7kshWouU9z0x9FVXDG9bKc=;
 b=sdr1SxJldXCve0ktUKYLZHPw0sPIaNmfMR6cv38LF56N5+jdlpsHRt+mzesQlMVNa6s/R1
 LN4tZEVf5Qns1o44GwIXKXoDqApUD3kR/oFeaP9iY//YdYBAY30VbiUQ+YUvsdcmWF7gSu
 ahKTL1AaIAHtJ5qH+98EDucrKSyPNqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9L3PVF/Xc3tclwjVhxBOG7kshWouU9z0x9FVXDG9bKc=;
 b=BTkhOrCr7XRoj6xL9Y42w62Oh8kp6wtRyya1OJE8QgrCzoZ+65aJYH6YKzAvHbBwrEQeDD
 e5AEWYajajbk02BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t+hptVgx;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DM03csAu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789483458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9L3PVF/Xc3tclwjVhxBOG7kshWouU9z0x9FVXDG9bKc=;
 b=t+hptVgxO1L0H98Fnb+mDlKV/l0ozvI9/xdxV58tmYnaxMB0Wsy73CnEKSPiw9y5mfLh9J
 OExtXrpT4frFrBbwUStsUhvqe1p5owJqiyUM5NGPdMUiAjcX9ZESglSKgzfanK6tuMScQB
 Bd8ZT6taLGVyiU29vz+3vZQUUnOssk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789483458;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9L3PVF/Xc3tclwjVhxBOG7kshWouU9z0x9FVXDG9bKc=;
 b=DM03csAubjInCs/+3k8vkSk/o0zh/SsN0W14O8m84pAOgUPLFPKrEp2r6MtcjmTgrb3vVm
 c1/zuM3QKuXAi4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD02813432;
 Tue, 15 Sep 2026 14:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LD9qKcFZqWoMRwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Sep 2026 14:44:17 +0000
Date: Tue, 15 Sep 2026 16:44:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Michael Menasherov <mmenashe@redhat.com>
Message-ID: <aqlZzGOS3yojgci9@yuki.lan>
References: <20260908092248.15774-1-mmenashe@redhat.com>
 <aqlAt5wCGegscwBS@yuki.lan>
 <CAHGiOXdkKcpTTqaTxH-xVwPP-MTDOkpe837Q-xrgO8Hro5gdTA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHGiOXdkKcpTTqaTxH-xVwPP-MTDOkpe837Q-xrgO8Hro5gdTA@mail.gmail.com>
X-Rspamd-Queue-Id: 0CCD11FF3B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] read_all: Fix buffer too small for long paths
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
> Thanks for explaining the problem with the code. I took a better look at it.
> How about checking before the write instead:
> 
>       while (q->data[i]) {
>           if (j >= BUFFER_SIZE - 1)
>               tst_brk(TBROK, "Buffer is too small for path");
> 
>           q->popped[j++] = q->data[i];
>           i = (i + 1) % QUEUE_SIZE;
>       }
>       q->popped[j] = '\0';
> 
>   j can never reach BUFFER_SIZE without TBROK, and PATH_MAX - 1 paths
>   still fit. Does this look good to you?

Ah, righ, there is tst_brk(), sorry for missing that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
