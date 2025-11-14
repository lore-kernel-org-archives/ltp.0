Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4EDCE7AAC
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 10:27:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 597B63CF822
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 11:27:14 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 456DD3CEBA0
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 11:26:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CBCB560024B
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 11:26:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FF1F1F825;
 Fri, 14 Nov 2025 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763116018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEzk2A5OXp2NfOrmkre+9tjF39KTFUJj0rbPjlQ3ETU=;
 b=AhHuPpEtUCCBsOeGaOT4gyzkEUudDOpRifpU4L32Pn+BM6aeXZW+Fo+fho4SMHVGmGU7Hg
 3CxM+DfCeOPYneu/QqY4pgVkadrA/XqNCQ429qhj/gkgQJoX0XupHt+9vlo2S+C2gKTfUI
 trSB25mC9SpRl4S5pTUZJcs5HB5gb9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763116018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEzk2A5OXp2NfOrmkre+9tjF39KTFUJj0rbPjlQ3ETU=;
 b=TkbKXrZFDSfmBxWvRUhCLpCdysmKNSnGD+FD93gfcb9foSm3a1mI8WHjb7NCA7LW7SMbTw
 szK1w6jQE6AVIUAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tfplxlef;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qjh7WBwN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763116017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEzk2A5OXp2NfOrmkre+9tjF39KTFUJj0rbPjlQ3ETU=;
 b=tfplxlefG7iJ+k89e5KG3y/RTdnOAiDALpTZwd9DE1hG4TiY7WzuJTQfNhIcWHi9NGTSv+
 3ciD0MLlSonzHLrll0BRszKhEP6yOaG4dnHqnucQvl52dBdtBzbihVvG2SaVJYAS967FNb
 HasV253aAHtlfrwW2bcp56hsJNNZgYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763116017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEzk2A5OXp2NfOrmkre+9tjF39KTFUJj0rbPjlQ3ETU=;
 b=Qjh7WBwNTUSRLua5XUoo5UQevXk/7B2iIekpBXZ4EUBwz6WM/E5+i5hd1MsY3XmmQFLOnf
 jyV9G7f73SCh1aBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0F503EA61;
 Fri, 14 Nov 2025 10:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 11e5OfADF2mtCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Nov 2025 10:26:56 +0000
Date: Fri, 14 Nov 2025 11:27:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aRcEIpgvi9C8NKLd@yuki.lan>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-6-pvorel@suse.cz>
 <12777454.O9o76ZdvQC@thinkpad> <20251114102457.GC52218@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251114102457.GC52218@pevik>
X-Rspamd-Queue-Id: 0FF1F1F825
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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
> This change requires to normalize TMPDIR via realpath() otherwise grep will
> fail. Either in the test or in the library [1] (I'll submit it separately, no
> need to be part of Wei's cleanup).

I was wondering if we can avoid matching the full path. Maybe we can
just do strstr() on the line from the /proc/mounts matching the filename
before we attempt to do the scanf().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
